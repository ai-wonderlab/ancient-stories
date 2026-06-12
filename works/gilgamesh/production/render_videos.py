#!/usr/bin/env python3
"""
render_videos.py — turn the 14 Gilgamesh starting frames into Seedance 2.0 videos.

For each shot in shots.json:
  - load the final frame from ../final-frames/<frame> as base64 data URI (first_frame)
  - build a Seedance prompt = motion description + spoken VO (in double quotes for audio sync)
  - POST image-to-video (first frame) to ModelArk Seedance 2.0, generate_audio=true
  - poll, download mp4 into ./videos/<id>.mp4

Idempotent: skips a shot if ./videos/<id>.mp4 already exists.
Usage:
  python3 render_videos.py            # all shots
  python3 render_videos.py F01 F02    # only these
  python3 render_videos.py --fast     # use Seedance 2.0 Fast (720p max) for drafts
"""
from __future__ import annotations
import base64, json, sys, time
from pathlib import Path

HERE = Path(__file__).resolve().parent
WORK = HERE.parent                      # works/gilgamesh
FRAMES = WORK / "final-frames"
VIDEOS = HERE / "videos"
SHOTS = HERE / "shots.json"

# import the existing client
sys.path.insert(0, str(WORK.parent.parent / "projects" if False else ""))
SEEDANCE_DIR = Path.home() / ".openclaw/workspace/projects/bytedance-seedance-video-2/api"
sys.path.insert(0, str(SEEDANCE_DIR))
from seedance import Seedance, MODEL_S2, MODEL_S2_FAST  # noqa: E402


def data_uri(p: Path) -> str:
    b = p.read_bytes()
    return "data:image/png;base64," + base64.b64encode(b).decode("ascii")


def build_prompt(shot: dict) -> str:
    motion = shot["motion"].strip()
    vo = shot.get("vo", "").strip()
    parts = [motion]
    if vo:
        # double quotes => Seedance optimizes spoken audio for this line
        parts.append(f'A single calm male narrator says, in English: "{vo}"')
    parts.append("Signature flat editorial illustration style, warm cream and ochre and charcoal, "
                 "graphic poster look, no text on screen, no subtitles, no captions.")
    return " ".join(parts)


def main() -> int:
    args = [a for a in sys.argv[1:]]
    fast = "--fast" in args
    args = [a for a in args if not a.startswith("--")]
    model = MODEL_S2_FAST if fast else MODEL_S2
    resolution = "720p" if fast else "1080p"

    cfg = json.loads(SHOTS.read_text())
    shots = cfg["shots"]
    if args:
        want = {a.upper() for a in args}
        shots = [s for s in shots if s["id"].upper() in want]

    VIDEOS.mkdir(parents=True, exist_ok=True)
    client = Seedance(default_model=model)

    results = []
    for s in shots:
        sid = s["id"]
        out = VIDEOS / f"{sid}.mp4"
        if out.exists():
            print(f"skip {sid} (exists)")
            results.append((sid, "skipped", str(out)))
            continue
        frame = FRAMES / s["frame"]
        if not frame.exists():
            print(f"MISSING FRAME {sid}: {frame}")
            results.append((sid, "missing-frame", ""))
            continue

        prompt = build_prompt(s)
        print(f"\n=== {sid} ({s['zone']}, {s['duration']}s) ===")
        print(f"VO: {s.get('vo','')}")
        try:
            task = client.create_image_to_video(
                prompt,
                first_frame_url=data_uri(frame),
                resolution=resolution,
                ratio=cfg.get("ratio", "9:16"),
                duration=int(s.get("duration", 6)),
                generate_audio=True,
                watermark=False,
                safety_identifier="ancient-stories",
            )
        except Exception as e:
            print(f"  create FAILED: {e}")
            results.append((sid, "create-failed", str(e)[:200]))
            continue
        tid = task.get("id")
        if not tid:
            print(f"  no task id: {task}")
            results.append((sid, "no-id", json.dumps(task)[:200]))
            continue
        print(f"  task {tid} — polling…")
        try:
            final = client.wait(tid, poll_every=10.0, timeout=1200.0,
                                 on_update=lambda i: print(f"    status={i.get('status')}"))
        except Exception as e:
            print(f"  wait FAILED: {e}")
            results.append((sid, "wait-failed", str(e)[:200]))
            continue
        if final.get("status") != "succeeded":
            print(f"  status={final.get('status')} :: {json.dumps(final)[:300]}")
            results.append((sid, final.get("status", "?"), tid))
            continue
        url = final["content"]["video_url"]
        client.download(url, out)
        print(f"  saved → {out}")
        results.append((sid, "ok", str(out)))

    print("\n===== SUMMARY =====")
    for sid, st, info in results:
        print(f"{sid:5} {st:14} {info}")
    ok = sum(1 for _, st, _ in results if st in ("ok", "skipped"))
    print(f"\n{ok}/{len(results)} ready")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
