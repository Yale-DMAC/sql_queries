SELECT * 
FROM HEADING
JOIN BIB_HEADING on BIB_HEADING.HEADING_ID = HEADING.HEADING_ID
JOIN BIB_MASTER on BIB_MASTER.BIB_ID = BIB_HEADING.BIB_ID
WHERE BIB_HEADING.BIB_ID = 1019937