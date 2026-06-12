#!/usr/bin/env bash
# Build ALL 14 Gilgamesh starting frames — full storyboard, production-ready.
# Phase 1: bootstrap 3 per-zone colour anchors (green-black / ash / cold-blue).
# Phase 2: generate every frame from its correct zone anchor (palette locked in IMAGE).
set -u
LAB="$(cd "$(dirname "$0")" && pwd)"
GEN="$LAB/gen-anchored.sh"
AN="$LAB/anchors"
OUT="/Users/nikolaoslouvaris/.openclaw/media/tool-image-generation"
export SIZE=1024x1536
mkdir -p "$AN"
log(){ echo "[$(date +%H:%M:%S)] $*"; }

# ---------- PHASE 1: per-zone anchors (text-only bootstrap) ----------
log "PHASE 1 — zone anchors"

if [ ! -f "$AN/zone-cedar.png" ]; then
  ANCHOR=none "$GEN" zone cedar "a vast looming deep green-black cedar forest as one flat shape anchored to the right edge ~45% of frame, palette warm cream + deep green-black + charcoal only, its trailing edge shedding sparse well-separated solid dark-green dots into empty cream, one tiny charcoal witness figure low-left."
  cp "$OUT/sig-zone-cedar.png" "$AN/zone-cedar.png" 2>/dev/null && log "anchor cedar locked"
fi
if [ ! -f "$AN/zone-ash.png" ]; then
  ANCHOR=none "$GEN" zone ash "a vast near-monochrome ash-grey and charcoal threshold mass anchored to the right edge ~45% of frame, palette warm cream + ash-grey + charcoal only, trailing edge shedding sparse well-separated solid grey dots into empty pale cream, one tiny charcoal witness figure low."
  cp "$OUT/sig-zone-ash.png" "$AN/zone-ash.png" 2>/dev/null && log "anchor ash locked"
fi
if [ ! -f "$AN/zone-waters.png" ]; then
  ANCHOR=none "$GEN" zone waters "a vast calm cold grey-blue water plane with a thin silver horizon low, palette warm cream + cold grey-blue + silver + charcoal only, sparse well-separated solid grey-blue dots dissolving at one edge into cream, one tiny charcoal witness figure low for scale."
  cp "$OUT/sig-zone-waters.png" "$AN/zone-waters.png" 2>/dev/null && log "anchor waters locked"
fi

MASTER="$AN/MASTER-ANCHOR.png"
CEDAR="$AN/zone-cedar.png"
ASH="$AN/zone-ash.png"
WATERS="$AN/zone-waters.png"

# ---------- PHASE 2: all 14 frames ----------
log "PHASE 2 — frames"

# F1 already exists as sig-g1-uruk-wall — copy to canonical F1 name
[ -f "$OUT/sig-g1-uruk-wall.png" ] && cp "$OUT/sig-g1-uruk-wall.png" "$OUT/sig-gilg-F01-uruk-wall.png"

ANCHOR="$MASTER" "$GEN" gilg F02-king-empty "a single dominant crowned king figure in profile as a solid charcoal silhouette filling the right ~45% of the frame, a tiny ochre toy-like city low at its feet, vast cream sky, the king's trailing edge shedding a few sparse solid ochre dots — a restless god-king who has everything and is empty."

ANCHOR="$MASTER" "$GEN" gilg F03-enkidu-wild "a wild man figure rising in profile among calm animal silhouettes, his body a flat ochre mass with hair like grass, anchored left, trailing edge shedding a few sparse solid ochre dots into empty cream — Enkidu the wild man born among beasts."

ANCHOR="$MASTER" "$GEN" gilg F04-becoming-one "two equal mirrored ochre silhouette figures in profile pressing against each other at the centre, the dissolve zone of sparse solid ochre dots flowing BETWEEN them joining the two into one, vast cream around — two rivals becoming inseparable."

ANCHOR="$CEDAR" "$GEN" gilg F05-cedar-forest "a vast looming deep green-black cedar forest as one flat shape anchored to the right edge ~45% of frame, its trailing edge shedding sparse solid dark-green dots into empty cream, two tiny charcoal silhouette figures entering low-left — the forbidden Cedar Forest."

ANCHOR="$CEDAR" "$GEN" gilg F06-humbaba "a huge shadowed guardian face-presence in deep green-black, half in darkness with one single lit eye, two tiny charcoal silhouette figures before it, sparse solid dark dots dissolving at the edge, cream void — Humbaba guardian of the cedars at the moment of his fall."

ANCHOR="$ASH" "$GEN" gilg F07-enkidu-dies "one ash-grey silhouette figure lying flat and still, a second charcoal figure bent over it in grief, near-monochrome ash and charcoal on cream, the lying figure's body dissolving along its edge into sparse solid grey dots drifting upward — the death of Enkidu."

ANCHOR="$ASH" "$GEN" gilg F08-death-enters "a lone small charcoal king figure fleeing across a vast empty ash-grey void, the dissolve of sparse solid grey dots now breaking off from HIS OWN body, overwhelming negative space, near-monochrome — death entering the body of Gilgamesh, terror made flesh."

ANCHOR="$WATERS" "$GEN" gilg F09-wandering "a tiny lone figure wrapped in animal skins crossing a vast empty cold grey-blue landscape, silver horizon low, sparse solid grey-blue dots dissolving at one edge, immense emptiness — Gilgamesh wandering, seeking immortality."

ANCHOR="$WATERS" "$GEN" gilg F10-waters-of-death "a small dark boat with one standing silhouette poling across vast cold grey-blue silver water, a thin silver horizon, sparse solid dots dissolving at the water's edge into cream sky — the crossing of the Waters of Death."

ANCHOR="$WATERS" "$GEN" gilg F11-plant-of-life "a silhouette figure reaching down into cold grey-blue water toward a single small plant on the seabed, silver ripples, sparse solid dots at the edge, cream above — the plant of youth within reach."

ANCHOR="$WATERS" "$GEN" gilg F12-serpent "a low serpent silhouette sliding away carrying a small plant, a figure's empty reaching hand behind, cold grey-blue and silver, sparse solid dots dissolving away into cream — the serpent steals the plant of life."

ANCHOR="$MASTER" "$GEN" gilg F13-the-turn "a tiny king figure standing again at the base of the vast ochre wall of Uruk looking up, the wall's trailing edge shedding sparse solid ochre dots, and ONE single deep lapis-blue glow igniting at the wall's edge — the only saturated colour in the entire frame — the moment he understands."

ANCHOR="$MASTER" "$GEN" gilg F14-you "sparse solid ochre dots reversing inward and reassembling into a single open eye and wall shape at the centre, a deep lapis-blue core glowing as the only saturated colour, vast calm cream around — the dissolve running backward, the myth reassembling into the viewer's own gaze."

log "BUILD COMPLETE"
ls -t "$OUT"/sig-gilg-*.png 2>/dev/null | head -20
