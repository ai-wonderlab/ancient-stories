# ΓΚΙΛΓΚΑΜΕΣ — STORYBOARD (production)

_Draft 01 — 12 Ιουνίου 2026_
_Κληρονομεί: `projects/ancient-stories/ART-DIRECTION.md` (canon — ο τρόπος) + `works/gilgamesh/ART-DIRECTION.md` (CLAY & ASH per-myth lock)._
_Μορφή: αφήγηση βιώματος, ΟΧΙ μάθημα. Ελεύθερη διάρκεια, σπασμένη σε **movements**. Κάθετο 9:16. Κάθε frame = starting image για i2v animation (ένα ζωντανό στοιχείο/κάδρο)._

> **Ο όρκος του project (NORTH-STAR):** βιώνει ή μαθαίνει; Δεν λέμε *για* τον Γκίλγκαμες — τον φέρνουμε να **συμβεί** μέσα στον θεατή. Κριτήριο: «δεν ήξερα ότι αυτό μπορεί να υπάρξει.»

---

## Η ΚΑΜΠΥΛΗ ΤΟΥ ΒΙΩΜΑΤΟΣ

Ένας βασιλιάς που φοβάται τον θάνατο διασχίζει τον κόσμο για να μην πεθάνει ποτέ — και βρίσκει ότι η αθανασία δεν ήταν ποτέ το φυτό. Ήταν το τείχος που έχτισε. Η ιστορία που μένει να ειπωθεί. **Αυτή που βιώνεις τώρα, 4.000 χρόνια μετά.**

```
ΚΑΤΩΦΛΙ      Ι. ΟΥΡΟΥΚ        ο βασιλιάς που έχει τα πάντα και τίποτα δεν τον γεμίζει
ΒΥΘΙΣΗ       ΙΙ. Ο ΑΛΛΟΣ      βρίσκει τον όμοιό του· γίνονται ένα
             ΙΙΙ. Ο ΚΕΔΡΟΣ    μαζί νικούν το τέρας· η ύβρις
             IV. Η ΡΩΓΜΗ       ο φίλος πεθαίνει· ο θάνατος μπαίνει στο σώμα του βασιλιά
             V. ΤΟ ΠΕΡΑΣΜΑ     διασχίζει τα Νερά του Θανάτου ψάχνοντας το αθάνατο
Η ΣΤΡΟΦΗ     VI. ΤΟ ΤΕΙΧΟΣ     το φυτό χάνεται· γυρίζει — και βλέπει
ΑΠΟΤΥΠΩΜΑ    VII. ΕΣΥ          ο μύθος αποδεικνύεται πάνω σου, τώρα
```

---

## ΠΑΛΕΤΑ ΑΝΑ ΖΩΝΗ (locked) → per-zone anchor

| Ζώνη | Frames | Παλέτα | Anchor |
|---|---|---|---|
| **Πηλός/γη** | F1,F2,F3,F4,F13 | cream + ψημένο ώχρα + clay-red + charcoal | `MASTER-ANCHOR.png` (ochre native) |
| **Κέδρος** | F5,F6 | cream + βαθύ πράσινο-μαύρο + charcoal | `anchors/zone-cedar.png` (bootstrap) |
| **Στάχτη/θάνατος** | F7,F8 | cream + ash-grey + charcoal, σχεδόν μονόχρωμο | `anchors/zone-ash.png` (bootstrap) |
| **Νερό/κατώφλι** | F9,F10,F11,F12 | cream + ψυχρό γκρι-μπλε + silver | `anchors/zone-waters.png` (bootstrap) |
| **Lapis ✦** | F13,F14 | ash/ochre + ΕΝΑ βαθύ lapis-blue (το μόνο κορεσμένο) | accent μέσα στη ζώνη |

Ποτέ >3 έντονα χρώματα/κάδρο. Το lapis = η «σπάνια φλόγα» — μόνο στη Στροφή.

---

# ΤΑ ΚΑΔΡΑ

_Κάθε frame: **εικόνα** (τι βλέπεις) · **λόγος** (VO/typography, ελληνικά κύρια + αγγλικά υπότιτλος) · **κίνηση** (το ένα ζωντανό στοιχείο για i2v) · **prompt subject** (τι μπαίνει στο `gen-anchored.sh`)._

---

## MOVEMENT I — ΟΥΡΟΥΚ · ΤΟ ΚΑΤΩΦΛΙ  〔ochre/clay〕

### F1 — Το τείχος
**Εικόνα:** Τεράστιο τείχος από ψημένο πηλό, αγκυρωμένο δεξιά, ~40% του κάδρου. Η άκρη του διαλύεται σε αραιές solid κουκκίδες προς τον κενό ουρανό. Στη βάση, μια μικροσκοπική σιλουέτα-βασιλιάς κοιτάζει ψηλά.
**Λόγος:** «Δες τι έχτισε. / Look what he built.»
**Κίνηση:** σκόνη που σαλεύει αργά στις κουκκίδες· push-in ~2%.
**Subject:** _(βλ. anchored prompt — υπάρχει: `sig-g1-uruk-wall.png`)_

### F2 — Ο βασιλιάς που δεν χορταίνει
**Εικόνα:** Ο Γκίλγκαμες ως κυρίαρχη σκούρα σιλουέτα με στέμμα, σε profile, να γεμίζει το κάδρο· πίσω/κάτω, η πόλη μικρή σαν παιχνίδι. Το βάρος του πέφτει πάνω της.
**Λόγος:** «Δύο τρίτα θεός. Κι όμως — τίποτα δεν τον γεμίζει. / Two-thirds god. And still — nothing fills him.»
**Κίνηση:** ελάχιστη ταλάντωση στις σιλουέτες της πόλης· ο βασιλιάς ακίνητος.
**Subject:** `a single dominant crowned king figure in profile as a solid charcoal silhouette filling the right ~45% of the frame, a tiny ochre toy-like city low at its feet, vast cream sky, the king's trailing edge shedding a few sparse solid ochre dots — a restless god-king who has everything and is empty.`

---

## MOVEMENT II — Ο ΑΛΛΟΣ ΕΑΥΤΟΣ  〔ochre〕

### F3 — Ο άγριος
**Εικόνα:** Ο Ενκίντου σηκώνεται ανάμεσα σε ζώα· σώμα από ώχρα, μαλλιά σαν χόρτο, profile. Γύρω του σιλουέτες ζώων σε ηρεμία.
**Λόγος:** «Οι θεοί φτιάχνουν τον όμοιό του. Άγριο. Ελεύθερο. / The gods make his equal. Wild. Free.»
**Κίνηση:** ένα ζώο γέρνει το κεφάλι· χόρτο που σαλεύει.
**Subject:** `a wild man figure rising in profile among calm animal silhouettes, his body a flat ochre mass with hair like grass, anchored left, trailing edge shedding a few sparse solid ochre dots into empty cream — Enkidu the wild man born among beasts.`

### F4 — Η σύγκρουση που γίνεται αγκαλιά
**Εικόνα:** Δύο ίσες ώχρα μορφές, καθρεφτισμένες, να σπρώχνουν η μία την άλλη — και η γραμμή ανάμεσά τους διαλύεται, τους ενώνει. Από εχθροί, ένα.
**Λόγος:** «Παλεύουν σαν να μισιούνται. Κι έπειτα — δεν ξαναχωρίζουν. / They fight like enemies. And then — never part again.»
**Κίνηση:** οι κουκκίδες ανάμεσά τους αναπνέουν αργά, σαν ένα πεδίο.
**Subject:** `two equal mirrored ochre silhouette figures in profile pressing against each other at the centre, the dissolve zone of sparse solid ochre dots flowing BETWEEN them joining the two into one, vast cream around — two rivals becoming inseparable.`

---

## MOVEMENT III — Ο ΚΕΔΡΟΣ · Η ΥΒΡΙΣ  〔green-black〕

### F5 — Το δάσος
**Εικόνα:** Πελώριο δάσος κέδρων ως μία επίπεδη πράσινη-μαύρη μάζα, αγκυρωμένη δεξιά. Δύο μικροσκοπικές σιλουέτες μπαίνουν από κάτω-αριστερά. Ιερό και απειλητικό μαζί.
**Λόγος:** «Πάνε εκεί που κανείς δεν τόλμησε. Στο δάσος των θεών. / They go where no one dared. The forest of the gods.»
**Κίνηση:** φύλλωμα που σαλεύει ελάχιστα· σκόνη φωτός.
**Subject:** `a vast looming deep green-black cedar forest as one flat shape anchored to the right edge ~45% of frame, its trailing edge shedding sparse solid dark-green dots into empty cream, two tiny charcoal silhouette figures entering low-left — the forbidden Cedar Forest.`

### F6 — Χουμπάμπα
**Εικόνα:** Ο φύλακας Χουμπάμπα — τεράστια σκιερή παρουσία, πρόσωπο μισό στο σκοτάδι, ένα μάτι φωτισμένο. Μπροστά του οι δύο μικροί. Η στιγμή του φόνου.
**Λόγος:** «Σκοτώνουν τον φύλακα. Νιώθουν αθάνατοι. / They slay the guardian. They feel immortal.»
**Κίνηση:** το ένα φωτισμένο μάτι· τίποτα άλλο.
**Subject:** `a huge shadowed guardian face-presence in deep green-black, half in darkness with one single lit eye, two tiny charcoal silhouette figures before it, sparse solid dark dots dissolving at the edge, cream void — Humbaba the guardian of the cedars at the moment of his fall.`

---

## MOVEMENT IV — Η ΡΩΓΜΗ · Ο ΘΑΝΑΤΟΣ  〔ash/charcoal〕

### F7 — Ο Ενκίντου φεύγει
**Εικόνα:** Μία μορφή ξαπλωμένη, ακίνητη· η άλλη σκυμμένη από πάνω. Στάχτη παντού. Η διάλυση τραβάει τη ξαπλωμένη μορφή — γίνεται κουκκίδες, φεύγει.
**Λόγος:** «Οι θεοί ζητούν πληρωμή. Ο φίλος του σβήνει. / The gods demand payment. His friend fades.»
**Κίνηση:** η ξαπλωμένη σιλουέτα διαλύεται σε κουκκίδες που ανεβαίνουν αργά.
**Subject:** `one ash-grey silhouette figure lying flat and still, a second charcoal figure bent over it in grief, near-monochrome ash and charcoal on cream, the lying figure's body dissolving along its edge into sparse solid grey dots drifting upward — the death of Enkidu.`

### F8 — Ο θάνατος μπαίνει στο σώμα του
**Εικόνα:** Ο Γκίλγκαμες μόνος, να τρέχει/να φεύγει, μικρός μέσα σε τεράστιο κενό από στάχτη. Και τώρα η διάλυση απειλεί **τον ίδιο** — οι κουκκίδες ξεκινούν από το δικό του σώμα. Ο φόβος έγινε σάρκα.
**Λόγος:** «Για πρώτη φορά, ξέρει: θα πεθάνει κι αυτός. / For the first time, he knows: he too will die.»
**Κίνηση:** οι κουκκίδες που φεύγουν από το σώμα του τρεμοπαίζουν.
**Subject:** `a lone small charcoal king figure fleeing across a vast empty ash-grey void, the dissolve of sparse solid grey dots now breaking off from HIS OWN body, overwhelming negative space, near-monochrome — death entering the body of Gilgamesh, terror made flesh.`

---

## MOVEMENT V — ΤΟ ΠΕΡΑΣΜΑ · Η ΑΝΑΖΗΤΗΣΗ  〔cold grey-blue / silver〕

### F9 — Η περιπλάνηση
**Εικόνα:** Μικροσκοπική μορφή με δέρματα ζώων διασχίζει απέραντο άδειο τοπίο. Ψυχρό γκρι-μπλε. Χαμένος, μόνος, αποφασισμένος.
**Λόγος:** «Αφήνει τα πάντα. Ψάχνει αυτό που κανείς δεν βρήκε: να μην πεθάνει. / He leaves everything. He seeks what no one found: to never die.»
**Κίνηση:** αργό push-in· λίγη σκόνη στον αέρα.
**Subject:** `a tiny lone figure wrapped in animal skins crossing a vast empty cold grey-blue landscape, silver horizon low, sparse solid grey-blue dots dissolving at one edge, immense emptiness — Gilgamesh wandering, seeking immortality.`

### F10 — Τα Νερά του Θανάτου
**Εικόνα:** Ψυχρό γκρι-μπλε νερό· μια μικρή βάρκα, μια σιλουέτα με κοντάρι. Το πέρασμα που κανείς ζωντανός δεν διασχίζει.
**Λόγος:** «Μπροστά του, τα Νερά του Θανάτου. Τα διασχίζει. / Before him, the Waters of Death. He crosses.»
**Κίνηση:** το νερό κυματίζει ελάχιστα· η βάρκα γλιστράει.
**Subject:** `a small dark boat with one standing silhouette poling across vast cold grey-blue silver water, a thin silver horizon, sparse solid dots dissolving at the water's edge into cream sky — the crossing of the Waters of Death.`

### F11 — Το φυτό της ζωής
**Εικόνα:** Η μορφή σκύβει στο νερό, απλώνει το χέρι σε ένα φυτό στον βυθό. Η μόνη ελπίδα της αθανασίας.
**Λόγος:** «Στον βυθό, το φυτό που γυρίζει τα χρόνια πίσω. Το πιάνει. / On the seabed, the plant that turns back the years. He takes it.»
**Κίνηση:** κυματισμός στο νερό γύρω από το χέρι.
**Subject:** `a silhouette figure reaching down into cold grey-blue water toward a single small plant on the seabed, silver ripples, sparse solid dots at the edge, cream above — the plant of youth within reach.`

### F12 — Το φίδι
**Εικόνα:** Ένα φίδι-σιλουέτα γλιστράει και παίρνει το φυτό. Η αθανασία χάνεται σε μια στιγμή απροσεξίας. Η μορφή απλώνει το χέρι σε άδειο.
**Λόγος:** «Μια στιγμή. Ένα φίδι. Και η αθανασία χάνεται για πάντα. / One moment. A serpent. And immortality is lost forever.»
**Κίνηση:** το φίδι γλιστράει έξω από το κάδρο με το φυτό.
**Subject:** `a low serpent silhouette sliding away carrying a small plant, a figure's empty reaching hand behind, cold grey-blue and silver, sparse solid dots dissolving away into cream — the serpent steals the plant of life.`

---

## MOVEMENT VI — ΤΟ ΤΕΙΧΟΣ · Η ΣΤΡΟΦΗ  〔ash → ochre, lapis ✦ accent〕

### F13 — Γυρίζει. Και βλέπει.
**Εικόνα:** Ο βασιλιάς ξανά στη βάση του τείχους της Ουρούκ (το F1 αντιστραμμένο συναισθηματικά). Η στάχτη ξαναγίνεται ώχρα. Και — για πρώτη φορά — ένα βαθύ **lapis-blue** φως ανάβει στην άκρη του τείχους. Το μόνο κορεσμένο χρώμα. Βλέπει.
**Λόγος:** _(σιωπή 0.5s → low hit)_ «Δεν βρήκε την αθανασία. Στεκόταν από την αρχή μπροστά του. / He never found immortality. It stood before him all along.»
**Κίνηση:** πάγωμα· μόνο το lapis φως αναπνέει.
**Subject:** `a tiny king figure standing again at the base of the vast ochre wall of Uruk, looking up, the wall's trailing edge shedding sparse solid ochre dots, and ONE single deep lapis-blue glow igniting at the wall's edge — the only saturated colour in the entire frame — the moment he understands.`

### F14 — ΕΣΥ
**Εικόνα:** Η διάλυση **αντιστρέφεται** — οι κουκκίδες μαζεύονται, ξαναχτίζουν: το τείχος, ή ένα ανοιχτό μάτι, ή την ίδια τη ματιά του θεατή. Το lapis στο κέντρο. Ο μύθος δεν τελειώνει — περνάει μέσα σου.
**Λόγος:** «Η ιστορία του έμεινε. 4.000 χρόνια. Μέχρι εσένα. Τώρα. / His story remained. 4,000 years. To you. Now.»
**Κίνηση:** οι κουκκίδες μαζεύονται προς το κέντρο (reverse dissolve)· το lapis πάλλεται μία φορά.
**Subject:** `sparse solid ochre dots reversing inward and reassembling into a single open eye / wall shape at the centre, a deep lapis-blue core glowing, vast calm cream around — the dissolve running backward, the myth reassembling into the viewer's own gaze.`

---

## ΗΧΟΣ (όλο το κομμάτι)
- **VO:** αφαιρετικό, present-tense, μία ιδέα/πρόταση. Ελληνικά κύρια, αγγλικά subtitle (Sargasso pattern).
- **Sound-bed:** drone 40-70Hz που αναπνέει· χτίζει I→IV, σπάει στη Στροφή.
- **Στη Στροφή (F13):** σιωπή 0.5s → ένα low hit → η φράση → πάγωμα.
- Αρχαίοι σφηνοειδείς φθόγγοι ως υφή, ποτέ μεταφρασμένη λέξη. ΟΧΙ melody.

## BRAND GLYPH
Σφηνοειδές cuneiform glyph, πάνω-αριστερά, διακριτικό, χαραγμένο, σε **κάθε** frame.

## TYPOGRAPHY
Lower-center 58-65%, serif επιγραφικό (Cormorant/EB Garamond), #F2EFE6, soft shadow χωρίς bar, δίγλωσσο.

---

## ΠΑΡΑΓΩΓΗ — pipeline
1. **Per-zone anchors** (bootstrap): `zone-cedar` (green-black), `zone-ash`, `zone-waters` (cold blue) → ένα καθαρό frame/ζώνη, γίνεται anchor.
2. **Starting frames** anchored: ochre frames από `MASTER-ANCHOR`, υπόλοιπα από zone-anchor.
3. **i2v animation:** Seedance 2.0 (film-forge), ένα ζωντανό στοιχείο/κάδρο, push-in ~2% ή hold· στη Στροφή πάγωμα.
4. **Edit:** VO + drone + glyph + typography → κάθετο 9:16 master + 2.39:1 για festival.

_Frames: `~/.openclaw/media/tool-image-generation/sig-g1-*.png` · anchors: `works/_signature-lab/anchors/`._
