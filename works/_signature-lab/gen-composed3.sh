#!/usr/bin/env bash
# THREE-REFERENCE structural control (character lock, 12/6/2026).
# Adds a CHARACTER anchor on top of style+shape so the SAME person travels across frames.
#   ref1 = STYLE anchor    → ΠΩΣ μοιάζει (palette/line/grain/dissolve)
#   ref2 = CHARACTER anchor → ΠΟΙΟΣ είναι (body/robe colour/crown/silhouette) — identity lock
#   ref3 = SHAPE guide     → ΤΙ δείχνει + WHERE (auto text-only composition)
# If CHAR=none, falls back to 2-ref (style+shape) for character-less frames (landscapes).
#
# Usage: STYLE=.. CHAR=.. ./gen-composed3.sh <round> <label> "<palette-zone>" "<subject/composition>"
set -u
set -a; source ~/credentials/.env.master 2>/dev/null; set +a
OUT="/Users/nikolaoslouvaris/.openclaw/media/tool-image-generation"
LAB="$(cd "$(dirname "$0")" && pwd)"
STYLE="${STYLE:-$LAB/anchors/MASTER-ANCHOR-sm.png}"
CHAR="${CHAR:-none}"
SIZE="${SIZE:-1024x1536}"
TMP="${TMPDIR:-/tmp}"
MAXT="${MAXT:-240}"

ROUND="${1:?round}"; LABEL="${2:?label}"; ZONE="${3:?palette-zone}"; shift 3; SUBJ="$*"

# ---------- Phase A: shape guide (text-only, NO signature bias) ----------
GUIDE="$TMP/guide3_${ROUND}_${LABEL}.png"
GP="Very simple flat minimal vector illustration, plain bold shapes on a plain light background, clear readable silhouette and composition, no texture, no fine detail, no text. Vertical 9:16 layout. Show clearly: ${SUBJ}. Keep generous empty negative space."
jq -n --arg p "$GP" --arg s "$SIZE" '{model:"gpt-image-2",prompt:$p,size:$s,n:1}' > "$TMP/greq3_${ROUND}_${LABEL}.json"
gh=$(curl -sS --max-time "$MAXT" --retry 1 --retry-all-errors -w "%{http_code}" -o "$TMP/gresp3_${ROUND}_${LABEL}.json" \
  https://api.openai.com/v1/images/generations \
  -H "Authorization: Bearer $OPENAI_API_KEY" -H "Content-Type: application/json" \
  --data @"$TMP/greq3_${ROUND}_${LABEL}.json" 2>/dev/null)
if [ "$gh" != "200" ]; then echo "FAIL guide ${LABEL} http=$gh $(head -c 180 "$TMP/gresp3_${ROUND}_${LABEL}.json" 2>/dev/null)"; exit 1; fi
jq -r '.data[0].b64_json' "$TMP/gresp3_${ROUND}_${LABEL}.json" | base64 -d > "$GUIDE"

# ---------- Phase B: compose ----------
if [ "$CHAR" != "none" ] && [ -f "$CHAR" ]; then
  CHARLINE="IMAGE 2 = the CHARACTER reference: the people in the scene MUST be this exact same character — copy the body proportions, the robe COLOUR, the head/crown and the overall silhouette EXACTLY so the viewer recognizes the same person across scenes. IMAGE 3 = the COMPOSITION reference: take the LAYOUT, poses and where each mass sits from it. "
  IMGS=(-F "image[]=@${STYLE}" -F "image[]=@${CHAR}" -F "image[]=@${GUIDE}")
else
  CHARLINE="IMAGE 2 = the COMPOSITION reference: take the SUBJECT, shapes, poses and LAYOUT from it. "
  IMGS=(-F "image[]=@${STYLE}" -F "image[]=@${GUIDE}")
fi

CP="You are given reference images. IMAGE 1 = the STYLE reference: copy its exact illustration identity — about 60% warm cream, 30% ${ZONE}, 10% deep charcoal, only these flat colours; ONE uniform charcoal contour line; STRICTLY 100% flat single-colour fills with ZERO brushwork, ZERO painterly shading, ZERO texture inside shapes (poster-flat, like cut paper); single global paper-grain only. DISSOLVE DEVICE (the brand, identical every frame): the dominant mass keeps a clean solid edge then sheds whole SOLID dots that float SPARSE and well-separated into empty cream — the floating dots are ALWAYS baked-ochre colour NO MATTER the subject's colour, never cream holes punched inside the mass, never clustered/overlapping dots. ${CHARLINE}COMBINE everything in the FLAT GRAPHIC style, palette, line and ochre-dot dissolve of IMAGE 1. Keep one tiny solid-charcoal witness figure for scale and generous calm negative space. KILL: no crosshatching, no internal hatching, no engraved texture, no hairlines, no brushstrokes, no painterly rendering, no text, no letters, no crowd, no photoreal, no gradients. SCENE (for clarity): ${SUBJ}"

FILE="$OUT/sig-${ROUND}-${LABEL}.png"
http=$(curl -sS --max-time "$MAXT" --retry 1 --retry-all-errors -w "%{http_code}" -o "$TMP/cresp3_${ROUND}_${LABEL}.json" \
  https://api.openai.com/v1/images/edits \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -F "model=gpt-image-2" "${IMGS[@]}" \
  -F "size=${SIZE}" -F "n=1" \
  -F "prompt=${CP}" 2>/dev/null)
if [ "$http" = "200" ]; then
  jq -r '.data[0].b64_json' "$TMP/cresp3_${ROUND}_${LABEL}.json" | base64 -d > "$FILE"
  echo "OK   sig-${ROUND}-${LABEL}  (style=$(basename "$STYLE") char=$(basename "$CHAR") + shape)"
else
  echo "FAIL ${LABEL} http=$http $(head -c 220 "$TMP/cresp3_${ROUND}_${LABEL}.json" 2>/dev/null | tr -d '\n')"
fi
