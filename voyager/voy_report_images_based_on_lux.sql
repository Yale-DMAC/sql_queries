SELECT bib_text.bib_id
    , bib_text.series
    , bib_text.begin_pub_date
    , bib_text.end_pub_date
    , bib_text.pub_dates_combined
    , bib_text.author
    , bib_text.bib_format
    , bib_text.rda_content
    , bib_text.rda_carrier
    , bib_text.rda_media
    , bib_text.field_008
    , bib_text.descrip_form
    , "LOCATION".LOCATION_DISPLAY_NAME
    , bib_text.title
    , marc_fields.marc_090
    , marc_fields.marc_240
    , marc_fields.marc_300
    , marc_fields.marc_336
    , marc_fields.marc_500
    , marc_fields.marc_510
    , marc_fields.marc_545
    , marc_fields.marc_520
    , marc_fields.marc_590
    , marc_fields.marc_650
    , marc_fields.marc_655
FROM bib_text
LEFT JOIN BIB_LOCATION on BIB_LOCATION.BIB_ID = BIB_TEXT.BIB_ID
LEFT JOIN "LOCATION" on BIB_LOCATION.LOCATION_ID = "LOCATION".LOCATION_ID
LEFT JOIN (SELECT BIB_ID
    , YALEDB.GETBIBTAG(BIB_ID, '090') as marc_090
    , YALEDB.GETBIBTAG(BIB_ID, '240') as marc_240
    , YALEDB.GETBIBTAG(BIB_ID, '300') as marc_300
    , YALEDB.GETBIBTAG(BIB_ID, '336') as marc_336
    , YALEDB.GETBIBTAG(BIB_ID, '502') as marc_502
    , YALEDB.GETBIBTAG(BIB_ID, '510') as marc_510
    , YALEDB.GETBIBTAG(BIB_ID, '545') as marc_545
    , YALEDB.GETBIBTAG(BIB_ID, '520') as marc_520
    , YALEDB.GETBIBTAG(BIB_ID, '590') as marc_590
    , YALEDB.GETBIBTAG(BIB_ID, '773') as marc_773
    , YALEDB.GETALLBIBTAGREPEATS(BIB_ID, '500') as marc_500
    , YALEDB.GETALLBIBTAGREPEATS(BIB_ID, '650') as marc_650
    , YALEDB.GETALLBIBTAGREPEATS(BIB_ID, '655') as marc_655
    FROM BIB_MASTER) marc_fields on marc_fields.BIB_ID = BIB_TEXT.BIB_ID
LEFT JOIN (SELECT BIB_ID
    , SUPPRESS_IN_OPAC
    , ACTION_DATE
    FROM BIB_HISTORY
    WHERE ACTION_DATE = (SELECT MAX(BH.ACTION_DATE)
                         FROM BIB_HISTORY BH
                         WHERE BH.BIB_ID = BIB_HISTORY.BIB_ID)
    AND SUPPRESS_IN_OPAC = 'Y') suppressed_records on suppressed_records.BIB_ID = BIB_TEXT.BIB_ID
WHERE suppressed_records.SUPPRESS_IN_OPAC is NULL
AND bib_text.bib_format like '%k%'
OR bib_text.bib_format like '%e%'
OR bib_text.bib_format like '%f%'
OR marc_fields.marc_655 like '%collage%'
OR marc_fields.marc_300 like '%collage%'
OR marc_fields.marc_300 like '%drawing%'
OR marc_fields.marc_650 like '%drawing%'
OR marc_fields.marc_655 like '%drawing%'
OR marc_fields.marc_090 like '%yuldatasetimg%'
OR marc_fields.marc_300 like '%painting%'
OR marc_fields.marc_655 like '%painting%'
OR marc_fields.marc_300 like '%photo%'
OR marc_fields.marc_650 like '%photo%'
OR marc_fields.marc_655 like '%photo%'
OR marc_fields.marc_336 like '%still image%'
OR marc_fields.marc_655 like '%sti%'
OR marc_fields.marc_650 like '%pictorial work%'
OR marc_fields.marc_650 like '%caricature%'
OR marc_fields.marc_650 like '%cartoon%'
OR marc_fields.marc_650 like '%chart%'
OR marc_fields.marc_650 like '%diagram%'
OR marc_fields.marc_650 like '%illustration%'
OR marc_fields.marc_650 like '%art%'
OR marc_fields.marc_650 like '%portrait%'
OR marc_fields.marc_300 like '%poster%'
OR marc_fields.marc_650 like '%poster%'
OR marc_fields.marc_655 like '%poster%'
OR marc_fields.marc_300 like '%print%'
OR marc_fields.marc_655 like '%lithograph%'