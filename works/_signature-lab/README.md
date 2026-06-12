# Signature Lab — η υπογραφή του καναλιού

_Locked 12/6/2026. Το **πώς** φτιάχνεται κάθε frame, από εδώ και πέρα._

## Πού φτάσαμε

Το **macro character κλείδωσε** cross-myth (Icarus, Yggdrasil, Gilgamesh, Anubis, Babel): παλέτα 60/30/10 (cream/ochre/charcoal), μία charcoal γραμμή, flat μάζες, witness figure, dissolve-into-dots. Σε thumbnail grid διαβάζεται **ένα χέρι**. Αυτό είναι αληθινό και αποδεδειγμένο.

## Το όριο που λύθηκε — και ΠΩΣ

**Πρόβλημα:** το gpt-image-2 έβαζε «cream knockout dots» (λευκές τρύπες μέσα στην ώχρα) στο dissolve zone. 5 γύροι λέξεων δεν το έσπασαν — pixel-level όριο μοντέλου, όχι prompt.

**Λύση = αλλαγή μοχλού, ΟΧΙ άλλος γύρος λέξεων:** **reference-lock.** Περνάμε τον καθαρότερο frame ως style anchor στο `/v1/images/edits`. Τα νέα frames αντιγράφουν τη γραμματική από την **εικόνα**, όχι από περιγραφή. Αποτέλεσμα: 5.5 → 8.5, μηδέν knockouts.

## Το rail — υποχρεωτικό για production

```
anchors/MASTER-ANCHOR.png   ← ο καθαρότερος frame (τώρα: Icarus r5). Κάθε frame γεννιέται από αυτόν.
gen-anchored.sh             ← Η ΓΕΝΝΗΤΡΙΑ. /v1/images/edits + anchor. ΑΥΤΟ τρέχουμε.
gen-batch.sh                ← μόνο bootstrap (νέα οικογένεια χωρίς anchor ακόμα).
```

**Χρήση:**
```bash
cd projects/ancient-stories/works/_signature-lab
SIZE=1024x1536 ./gen-anchored.sh <round> <label> "<subject sentence με per-myth palette>"
```

**Κανόνες που κρατάνε το lock:**
1. Production = **πάντα anchored**. Text-only μόνο για να γεννηθεί νέος anchor.
2. Dots **πάντα sparse & well-separated** — ποτέ overlap/cluster (το dense packing γεννά τα fake holes).
3. Καλύτερος frame γεννιέται → γίνεται ο νέος `MASTER-ANCHOR.png`.
4. Per-myth θερμοκρασία (Gilgamesh → clay + lapis accent) → μπαίνει στο SUBJECT, ή κρατάς per-myth anchor.

→ Πλήρες canon: `projects/ancient-stories/ART-DIRECTION.md` § AI generation — THE PRODUCTION RAIL.
