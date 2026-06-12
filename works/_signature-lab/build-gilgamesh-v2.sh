#!/usr/bin/env bash
# Build ALL 14 Gilgamesh frames with the COMPOSED (two-reference) rail.
# style anchor (palette/line/dissolve) + shape guide (subject/layout) → decoupled.
set -u
LAB="$(cd "$(dirname "$0")" && pwd)"
GEN="$LAB/gen-composed.sh"
AN="$LAB/anchors"
OUT="/Users/nikolaoslouvaris/.openclaw/media/tool-image-generation"
BACK="$LAB/../gilgamesh/frames"
export SIZE=1024x1536
mkdir -p "$BACK"
log(){ echo "[$(date +%H:%M:%S)] $*"; }

MASTER="$AN/MASTER-ANCHOR.png"; CEDAR="$AN/zone-cedar.png"; ASH="$AN/zone-ash.png"; WATERS="$AN/zone-waters.png"

run(){ # style label zone subject
  STYLE="$1" "$GEN" g2 "$2" "$3" "$4"
  [ -f "$OUT/sig-g2-$2.png" ] && cp "$OUT/sig-g2-$2.png" "$BACK/sig-gilg-$2.png"
}

log "COMPOSED BUILD — 14 frames"

run "$MASTER" F01-uruk-wall      "baked ochre and clay-red" "a vast ancient mud-brick city wall, massive and high, anchored to the right side, one tiny king figure at its base looking up — the great wall of Uruk, NOT a winged figure"
run "$MASTER" F02-king-empty     "baked ochre" "a single tall crowned king standing in profile dominating the frame, a tiny toy-like miniature city at his feet far below, he towers over it restless and unsatisfied — a god-king who has everything and is empty, NOT a bird"
run "$MASTER" F03-enkidu-wild    "baked ochre" "a wild muscular man crouching in profile among calm animals (a lion, a gazelle), hair long and matted like grass, he is one of the animals — Enkidu the wild man, NOT a sun, NOT a face"
run "$MASTER" F04-becoming-one   "baked ochre" "two equal-sized human silhouette figures facing each other and clasping/merging at the centre, mirror of each other, becoming one — two rivals becoming inseparable friends, NOT a sun, NOT a single figure"
run "$CEDAR"  F05-cedar-forest   "deep green-black" "a vast wall of many enormous towering cedar trees forming one solid dark forest mass filling the frame, two tiny human figures at its foot looking up dwarfed — the forbidden Cedar Forest"
run "$CEDAR"  F06-humbaba        "deep green-black" "an enormous monstrous guardian face-mask presence looming in the dark forest, half in shadow with ONE single large glowing eye, two tiny figures standing before it — Humbaba guardian of the cedars"
run "$ASH"    F07-enkidu-dies    "ash grey" "one human figure lying flat dead on the ground, a second figure kneeling bent over it in grief, ash and grey, the dead body dissolving away into rising dots — the death of Enkidu"
run "$ASH"    F08-death-enters   "ash grey" "a lone small king figure running fleeing across a vast empty grey wasteland, his own body starting to dissolve into drifting dots, overwhelming emptiness — death entering Gilgamesh, terror made flesh"
run "$WATERS" F09-wandering      "cold grey-blue" "a tiny lone figure wrapped in ragged animal skins walking across a vast empty cold landscape, immense emptiness around him, a low horizon — Gilgamesh wandering in grief seeking immortality"
run "$WATERS" F10-waters-of-death "cold grey-blue" "a small boat with one standing figure poling across a vast cold sea, a low silver horizon line, endless water — the crossing of the Waters of Death, NOT a wave, NOT a dune"
run "$WATERS" F11-plant-of-life  "cold grey-blue" "a figure leaning down from a boat reaching one arm deep into the water toward a small glowing plant on the seabed below — the plant of youth within reach"
run "$WATERS" F12-serpent        "cold grey-blue" "a long low snake slithering away carrying a small plant in its mouth, a human hand reaching out grasping at empty air behind it — the serpent steals the plant of immortality"
run "$MASTER" F13-the-turn       "baked ochre" "a tiny king figure standing again at the foot of the vast ochre city wall looking up, and ONE single small deep lapis-blue glowing light at the wall's edge as the only saturated colour in the frame — the moment he finally understands"
run "$MASTER" F14-you            "baked ochre" "scattered ochre dots flowing inward and reassembling into a single large open human eye at the centre, a deep lapis-blue glowing core, vast calm space around — the dissolve running backward, the myth reassembling into the viewer's own gaze"

log "COMPOSED BUILD COMPLETE"
ls "$BACK"/sig-gilg-*.png | wc -l
