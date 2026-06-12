#!/usr/bin/env bash
# Build a CHARACTER ANCHOR — a clean full-figure design sheet of one character,
# in signature style, to lock identity (body/robe colour/crown/silhouette) across frames.
# Usage: STYLE=/path/anchor.png ./gen-character-anchor.sh <name> "<character description>"
set -u
set -a; source ~/credentials/.env.master 2>/dev/null; set +a
OUT="/Users/nikolaoslouvaris/.openclaw/media/tool-image-generation"
LAB="$(cd "$(dirname "$0")" && pwd)"
STYLE="${STYLE:-$LAB/anchors/MASTER-ANCHOR-sm.png}"
SIZE="${SIZE:-1024x1536}"
TMP="${TMPDIR:-/tmp}"
NAME="${1:?name}"; shift; DESC="$*"

CP="You are given ONE style reference IMAGE 1. Produce a CHARACTER DESIGN SHEET in its exact illustration identity: about 60% warm cream background, the figure in flat colour, ONE uniform deep-charcoal contour line, STRICTLY 100% flat single-colour fills, ZERO brushwork, ZERO shading, ZERO texture inside shapes (poster-flat like cut paper), single global paper-grain only. Centre ONE single standing human figure, full body, simple frontal silhouette, calm neutral pose, arms at sides, occupying the central vertical of the frame on empty cream. No scene, no background elements, no other figures, no text. This is a reference turnaround of ONE recognizable character. THE CHARACTER: ${DESC}. Make the silhouette, the body proportions, the robe colour and the head/crown UNMISTAKABLE and simple, so the same figure can be redrawn identically in many scenes."

FILE="$OUT/char-${NAME}.png"
http=$(curl -sS --max-time 240 --retry 1 --retry-all-errors -w "%{http_code}" -o "$TMP/charesp_${NAME}.json" \
  https://api.openai.com/v1/images/edits \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -F "model=gpt-image-2" \
  -F "image[]=@${STYLE}" \
  -F "size=${SIZE}" -F "n=1" \
  -F "prompt=${CP}" 2>/dev/null)
if [ "$http" = "200" ]; then
  jq -r '.data[0].b64_json' "$TMP/charesp_${NAME}.json" | base64 -d > "$FILE"
  echo "OK   char-${NAME}  -> $FILE"
else
  echo "FAIL ${NAME} http=$http $(head -c 220 "$TMP/charesp_${NAME}.json" | tr -d '\n')"
fi
