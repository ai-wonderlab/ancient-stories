# Gilgamesh — Production

_Πώς γεννιέται το έργο, end-to-end. 12 Ιουνίου 2026._

## Δομή

```
works/gilgamesh/
├── ART-DIRECTION.md        per-myth art lock (CLAY & ASH + lapis) — κληρονομεί το canon
├── STORYBOARD.md           7 movements · 14 frames · όλα τα λόγια GR+EN · motion · Στροφή
├── final-frames/           ⭐ τα 14 ΤΕΛΙΚΑ starting frames (F01..F14, καθαρά ονόματα)
└── production/
    ├── shots.json          shot manifest: frame · zone · duration · VO (EN) · motion prompt
    ├── render_videos.py     Seedance 2.0 driver (frame → video + voiceover)
    └── videos/             ⭐ τα 14 mp4 (παράγονται)
```

## Pipeline (2 στάδια)

### 1) Stills — signature rail (κλειστό)
Τα 14 frames φτιάχτηκαν με το **composed two-reference rail** (`works/_signature-lab/gen-composed.sh`):
- **style anchor** (παλέτα/γραμμή/dissolve/ochre-dots) ⊕ **shape guide** (subject/layout) → decoupled.
- Λύνει ΚΑΙ το cream-knockout tic ΚΑΙ το subject-drift. → `works/_signature-lab/README.md` + canon.
- Per-zone style anchors: `MASTER-ANCHOR` (ochre) · `zone-cedar` (green-black) · `zone-ash` · `zone-waters` (cold-blue).

### 2) Video + VO — Seedance 2.0 (BytePlus ModelArk)
```bash
cd works/gilgamesh/production
python3 render_videos.py            # όλα τα 14 → videos/<id>.mp4 (1080p, 9:16, EN VO)
python3 render_videos.py F13 F14    # μόνο συγκεκριμένα
python3 render_videos.py --fast     # draft mode (Seedance 2.0 Fast, 720p)
```
- Κάθε frame → **image-to-video (first frame)** μέσω `dreamina-seedance-2-0-260128`.
- **Voiceover:** το αγγλικό VO του shot μπαίνει σε διπλά εισαγωγικά μέσα στο prompt → το μοντέλο παράγει συγχρονισμένη αφήγηση (`generate_audio: true`).
- Frames περνάνε ως base64 data URI (σιλουέτες, χωρίς πρόσωπα → καμία face-rejection).
- Output: `videos/F01.mp4 … F14.mp4`. Idempotent (skip ό,τι υπάρχει).
- ⚠️ Τα `video_url` του ModelArk ισχύουν 24h — το script κατεβάζει αμέσως τοπικά.

## Auth
`ARK_API_KEY` από `~/credentials/.env.master` (region ap-southeast-1). Client: `projects/bytedance-seedance-video-2/api/seedance.py`. `safety_identifier="ancient-stories"` για να ξεχωρίζουν στο shared pool.

## Επόμενο (post-Seedance)
Edit pass: ραφή 14 clips σε μία ροή · low drone 40-70Hz · cuneiform-phoneme ambience · brand glyph overlay · κάθετο 9:16 master + 2.39:1 για festival. (Η Seedance βγάζει το VO ενσωματωμένο· το drone/glyph μπαίνουν στο edit.)
