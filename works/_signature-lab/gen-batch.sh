#!/usr/bin/env bash
# Signature-lab batch generator v2 — Frame-4 (Babel) discipline locked per Fable-5 audit.
set -u
set -a; source ~/credentials/.env.master 2>/dev/null; set +a
OUT="/Users/nikolaoslouvaris/.openclaw/media/tool-image-generation"
ROUND="${1:-r2}"
SIZE="${2:-1024x1536}"

LOCK='One strict signature illustration identity for a mythology animation channel — every frame must look drawn by the exact same hand. PALETTE RATIO (strict): about 60% warm cream, 30% baked ochre, 10% deep charcoal — only these three flat colours, every frame. LINE: one single uniform charcoal contour line, consistent medium weight everywhere with a slightly rough riso edge; NO internal hatching, NO variable-width strokes, NO hairline details, NO engraved texture inside shapes. FILL: all shapes are 100% flat single-colour fills; the ONLY texture in the image is one global paper-grain layer applied uniformly over everything; no gradients, no shading, no volume. SIGNATURE DISSOLVE DEVICE (mechanical, identical in every frame — this is the brand): the single dominant mass dissolves along its right/trailing edge into dust. PARTICLES ARE SOLID, UNOUTLINED, HARD-EDGED CIRCLES in exactly three fixed diameters (large, medium, small), filled ONLY with the parent mass own ochre colour — NO contour outline on particles, NO halftone speckle, NO cream halos, NO smudged stipple, NO grain texture inside the dissolve zone; just clean solid POSITIVE ochre circles scattered SPARSELY and thinning out into empty cream. CRITICAL BOUNDARY RULE: the edge of the ochre mass stays a CLEAN SOLID EDGE, then separate whole ochre dots break OFF from it and float outward into the empty cream. Absolutely NO cream/white holes, dots, specks or pinpricks punched INSIDE the ochre mass; NO eroded/perforated/moth-eaten edge; NO halftone gradient; NO dot-screen texture in the transition zone. The ochre is always 100% solid until a whole dot fully detaches into the cream. Think: solid shape shedding separate confetti dots, NOT a perforated/dissolving screen. The dissolve occupies about 15-20% of the subject silhouette and affects ONLY the dominant subject, never the background. The tiny witness figure is ALWAYS a solid charcoal silhouette. THE DOMINANT SUBJECT IS ALWAYS FILLED OCHRE (never charcoal); charcoal is only for the contour line and tiny accents. COMPOSITION: the dominant mass anchored to one vertical edge occupying about 40% of the frame, the opposing 60% is calm breathing negative space; horizon line in the bottom 12-15%; one small human figure at about 5-8% of frame height for scale. STYLIZATION: bold simplified iconographic poster shapes, refined modern woodcut silhouette, medium abstraction. KILL LIST: no crosshatching, no woodcut trunk texture, no internal hatching, no engraved feather detail, no thin vector hairlines, no symmetrical compositions, no text, no letters, no relief carving, no crowd, no photoreal. SUBJECT: '

gen () {
  local label="$1"; shift; local subj="$*"
  local file="$OUT/sig-${ROUND}-${label}.png"
  jq -n --arg p "${LOCK}${subj}" --arg s "$SIZE" '{model:"gpt-image-2",prompt:$p,size:$s,n:1}' > /tmp/req_${ROUND}_${label}.json
  local http
  http=$(curl -sS --max-time 270 --retry 1 --retry-all-errors -w "%{http_code}" -o /tmp/resp_${ROUND}_${label}.json \
    https://api.openai.com/v1/images/generations \
    -H "Authorization: Bearer $OPENAI_API_KEY" -H "Content-Type: application/json" \
    --data @/tmp/req_${ROUND}_${label}.json 2>/dev/null)
  if [ "$http" = "200" ]; then
    jq -r '.data[0].b64_json' /tmp/resp_${ROUND}_${label}.json | base64 -d > "$file"
    echo "OK   $label"
  else
    echo "FAIL $label http=$http $(head -c 180 /tmp/resp_${ROUND}_${label}.json | tr -d '\n')"
  fi
}

LABEL="${3:-all}"
if [ "$LABEL" = "all" ] || [ "$LABEL" = "norse" ];   then gen norse-yggdrasil  "a vast world-tree as one flat ochre mass anchored to the left edge, its right canopy edge dissolving into three-size dust, one tiny figure resting at its base — Yggdrasil."; fi
if [ "$LABEL" = "all" ] || [ "$LABEL" = "egypt" ];   then gen egyptian-scales  "a tall jackal-headed figure in profile anchored to the right edge holding a great balance scale, the figures own body dissolving along its trailing edge into three-size dust, vast empty space left — the weighing of the heart."; fi
if [ "$LABEL" = "all" ] || [ "$LABEL" = "meso" ];    then gen meso-gilgamesh   "a vast flat city wall mass anchored to the right edge, its trailing edge dissolving into three-size dust, one tiny king figure at its base looking up — Gilgamesh and the wall of Uruk."; fi
if [ "$LABEL" = "all" ] || [ "$LABEL" = "icarus" ];  then gen greek-icarus     "a large ochre winged figure anchored to the RIGHT vertical edge occupying about 40% of the frame, wings spread, the trailing wing edge shedding separate solid ochre dots into the empty cream sky on the left 60%, a tiny distant witness figure as a SOLID FLAT CHARCOAL SILHOUETTE (no outline, no fill detail) low for scale — Icarus."; fi
if [ "$LABEL" = "all" ] || [ "$LABEL" = "babel" ];   then gen babel-tower      "a single enormous spiralling tower as a flat ochre mass anchored to the RIGHT vertical edge occupying about 40% of the frame, leaning slightly, its trailing edge dissolving into solid three-size ochre dust circles, a tiny lone figure at its base, vast empty cream sky filling the left 60% — the tower of Babel."; fi
if [ "$LABEL" = "all" ] || [ "$LABEL" = "orpheus" ]; then gen greek-orpheus    "a lone musician figure in profile anchored right at a tall dark doorway, looking back, the figure dissolving along its trailing edge into three-size dust, vast empty space left — Orpheus at the threshold."; fi
echo "BATCH-${ROUND}-${LABEL}-DONE"
