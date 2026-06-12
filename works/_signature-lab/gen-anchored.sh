#!/usr/bin/env bash
# Signature-lab REFERENCE-LOCK generator — the production rail (locked 12/6/2026).
# Αλλαγή μοχλού: αντί να ΠΕΡΙΓΡΑΦΟΥΜΕ το particle behaviour (που το gpt-image-2 αγνοεί
# στο pixel-level → cream knockout tic σε πυκνές dot zones), το ΔΕΙΧΝΟΥΜΕ — περνάμε τον
# καθαρότερο frame (Icarus r5, zero knockouts) ως style anchor στο /v1/images/edits.
# Τα νέα frames αντιγράφουν την dissolve-γραμματική από την ΙΔΙΑ την εικόνα.
#
# Usage: ./gen-anchored.sh <round> <label> "<subject sentence>"
#   ./gen-anchored.sh a1 meso-gilgamesh "a vast flat city wall mass ... — the wall of Uruk."
set -u
set -a; source ~/credentials/.env.master 2>/dev/null; set +a
OUT="/Users/nikolaoslouvaris/.openclaw/media/tool-image-generation"
LAB="$(cd "$(dirname "$0")" && pwd)"
ANCHOR="$LAB/anchors/MASTER-ANCHOR.png"
SIZE="${SIZE:-1024x1536}"

ROUND="${1:?round}"; LABEL="${2:?label}"; shift 2; SUBJ="$*"

# Lean prompt — το ΒΑΡΟΣ της υπογραφής το σηκώνει ο anchor, ΟΧΙ οι λέξεις.
# Κρατάμε μόνο: ταυτότητα-χεριού, palette ratio, dissolve-rule (ως reminder, όχι ως όλο),
# composition, kill-list. Το particle behaviour ΔΕΝ περιγράφεται εξαντλητικά πια —
# αντιγράφεται από τον anchor.
PROMPT="Make a new illustration in the EXACT same signature hand, palette, line and dissolve language as the reference image. Match it precisely: about 60% warm cream, 30% baked ochre, 10% deep charcoal — only these three flat colours; one uniform charcoal contour line; 100% flat fills; single global paper-grain. DISSOLVE: copy the reference dissolve exactly — the dominant ochre mass stays a clean solid edge, then whole SOLID ochre dots break off and float into empty cream. The dots are ALWAYS sparse and well-separated — each dot floats alone with clear cream space around it; dots NEVER touch, overlap, cluster or pack densely (dense packing is what creates fake cream holes). NEVER punch cream/white holes inside the ochre mass; no perforated/moth-eaten edge, no halftone screen, no dense dot-cloud. Composition: dominant mass on one vertical edge ~40% of frame, calm negative space opposite, horizon low, one tiny solid-charcoal witness figure for scale. KILL: no crosshatching, no internal hatching, no engraved/relief texture, no hairlines, no text, no letters, no crowd, no photoreal. SUBJECT: ${SUBJ}"

FILE="$OUT/sig-${ROUND}-${LABEL}.png"
http=$(curl -sS --max-time 300 --retry 1 --retry-all-errors -w "%{http_code}" -o /tmp/anch_${ROUND}_${LABEL}.json \
  https://api.openai.com/v1/images/edits \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -F "model=gpt-image-2" \
  -F "image[]=@${ANCHOR}" \
  -F "size=${SIZE}" \
  -F "n=1" \
  -F "prompt=${PROMPT}" 2>/dev/null)

if [ "$http" = "200" ]; then
  jq -r '.data[0].b64_json' /tmp/anch_${ROUND}_${LABEL}.json | base64 -d > "$FILE"
  echo "OK   sig-${ROUND}-${LABEL}  (anchored)"
else
  echo "FAIL ${LABEL} http=$http $(head -c 220 /tmp/anch_${ROUND}_${LABEL}.json | tr -d '\n')"
fi
