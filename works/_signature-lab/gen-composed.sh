#!/usr/bin/env bash
# Signature-lab TWO-REFERENCE structural control (advanced rail, 12/6/2026).
# Πρόβλημα που λύνει: ο single-anchor /edits σέρνει ΚΑΙ το σχήμα του anchor (Enkidu→ήλιος).
# Λύση: DECOUPLING. Δύο references —
#   ref1 = STYLE anchor (παλέτα/γραμμή/grain/dissolve)  →  ΠΩΣ μοιάζει
#   ref2 = SHAPE guide  (crude flat composition/silhouette) → ΤΙ δείχνει + WHERE
# Το prompt λέει ρητά: ύφος από #1, σύνθεση/θέμα από #2.
#
# Phase A (auto): φτιάχνει shape-guide text-only (καθαρό σχήμα, χωρίς signature bias).
# Phase B: edits([style_anchor, shape_guide], compose-prompt).
#
# Usage: STYLE=/path/anchor.png ./gen-composed.sh <round> <label> "<palette-zone>" "<subject/composition>"
set -u
set -a; source ~/credentials/.env.master 2>/dev/null; set +a
OUT="/Users/nikolaoslouvaris/.openclaw/media/tool-image-generation"
LAB="$(cd "$(dirname "$0")" && pwd)"
STYLE="${STYLE:-$LAB/anchors/MASTER-ANCHOR.png}"
SIZE="${SIZE:-1024x1536}"
TMP="${TMPDIR:-/tmp}"

ROUND="${1:?round}"; LABEL="${2:?label}"; ZONE="${3:?palette-zone}"; shift 3; SUBJ="$*"

# ---------- Phase A: shape guide (text-only, NO signature bias) ----------
GUIDE="$TMP/guide_${ROUND}_${LABEL}.png"
GP="Very simple flat minimal vector illustration, plain bold shapes on a plain light background, clear readable silhouette and composition, no texture, no fine detail, no text. Vertical 9:16 layout. Show clearly: ${SUBJ}. The main mass occupies one vertical side ~40% of frame, the rest is empty negative space, one tiny human figure low for scale."
jq -n --arg p "$GP" --arg s "$SIZE" '{model:"gpt-image-2",prompt:$p,size:$s,n:1}' > "$TMP/greq_${ROUND}_${LABEL}.json"
gh=$(curl -sS --max-time 300 --retry 1 --retry-all-errors -w "%{http_code}" -o "$TMP/gresp_${ROUND}_${LABEL}.json" \
  https://api.openai.com/v1/images/generations \
  -H "Authorization: Bearer $OPENAI_API_KEY" -H "Content-Type: application/json" \
  --data @"$TMP/greq_${ROUND}_${LABEL}.json" 2>/dev/null)
if [ "$gh" != "200" ]; then echo "FAIL guide ${LABEL} http=$gh $(head -c 180 "$TMP/gresp_${ROUND}_${LABEL}.json")"; exit 1; fi
jq -r '.data[0].b64_json' "$TMP/gresp_${ROUND}_${LABEL}.json" | base64 -d > "$GUIDE"

# ---------- Phase B: compose — style from #1, shape from #2 ----------
CP="You are given TWO reference images. IMAGE 1 = the STYLE reference: copy its exact illustration identity — about 60% warm cream, 30% ${ZONE}, 10% deep charcoal, only these flat colours; ONE uniform charcoal contour line; STRICTLY 100% flat single-colour fills with ZERO brushwork, ZERO painterly shading, ZERO texture inside shapes (poster-flat, like cut paper); single global paper-grain only. DISSOLVE DEVICE (the brand, identical every frame): the dominant mass keeps a clean solid edge then sheds whole SOLID dots that float SPARSE and well-separated into empty cream — the floating dots are ALWAYS baked-ochre colour (the same warm ochre as the style anchor) NO MATTER the subject's colour, never cream holes punched inside the mass, never clustered/overlapping dots. IMAGE 2 = the COMPOSITION reference: take the SUBJECT, SHAPES, POSES and LAYOUT from it — what the picture shows and where each mass sits. COMBINE: render the subject and composition of IMAGE 2 entirely in the FLAT GRAPHIC style, palette, line and ochre-dot dissolve language of IMAGE 1. Keep one tiny solid-charcoal witness figure for scale and generous calm negative space. KILL: no crosshatching, no internal hatching, no engraved/relief texture, no hairlines, no brushstrokes, no painterly rendering, no text, no letters, no crowd, no photoreal, no gradients. SUBJECT (for clarity): ${SUBJ}"

FILE="$OUT/sig-${ROUND}-${LABEL}.png"
http=$(curl -sS --max-time 300 --retry 1 --retry-all-errors -w "%{http_code}" -o "$TMP/cresp_${ROUND}_${LABEL}.json" \
  https://api.openai.com/v1/images/edits \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -F "model=gpt-image-2" \
  -F "image[]=@${STYLE}" \
  -F "image[]=@${GUIDE}" \
  -F "size=${SIZE}" \
  -F "n=1" \
  -F "prompt=${CP}" 2>/dev/null)
if [ "$http" = "200" ]; then
  jq -r '.data[0].b64_json' "$TMP/cresp_${ROUND}_${LABEL}.json" | base64 -d > "$FILE"
  echo "OK   sig-${ROUND}-${LABEL}  (composed: style=$(basename "$STYLE") + shape-guide)"
else
  echo "FAIL ${LABEL} http=$http $(head -c 220 "$TMP/cresp_${ROUND}_${LABEL}.json" | tr -d '\n')"
fi
