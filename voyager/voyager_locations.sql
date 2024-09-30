SELECT DISTINCT bib_master.bib_id,
  mfhd_master.mfhd_id,
  location.location_code,
  mfhd_master.display_call_no,
  bib_text.isbn,
  bib_text.issn,
  bib_text.title,
  bib_text.author,
  bib_text.imprint
FROM bib_master 
JOIN bib_text on bib_master.bib_id = bib_text.bib_id
JOIN bib_mfhd ON bib_text.bib_id = bib_mfhd.bib_id
JOIN mfhd_master ON bib_mfhd.mfhd_id = mfhd_master.mfhd_id
JOIN location ON mfhd_master.location_id = location.location_id
WHERE location.location_code in ()