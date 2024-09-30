# OK - so this isn't working - it's too much. So I am going to just export all
# of the tables that I need and reimport them into a MySQL database that I'll
# query locally

# tables: acid, c4, c4_acid, c4_longstrings, c4_strings, c19, c19_acid, c19_longstrings, c19_strings
# collection, 



### QUESTION:

# Does it make more sense to just UNION ALL the collections,
# and join the projects to those? Meh, there are a lot fewer.


use pamoja;
SELECT p6.oid as p_oid
	, p6.poid as p_poid
	, c4.oid as c_oid
	, c4._oid
	, c4.pid
	, c4._boid
	, c4._bindex
	, c4._zindex
	, c4._bparent
	, c4._parent
	, fd1.handle as c_acid_handle
	, acid.fdid as c_acid_fdid
	, acid.pid as c_acid_pid
	, acid.code as c_acid_code
	, acid.value as c_acid_value
	, acid.acid as c_acid_id
	, fd2.handle as c_string_handle
	, c4_strings.fdid as c_string_fdid
	, c4_strings.value as c_string_value
	, fd3.handle as c_longstring_handle
	, c4_longstrings.fdid as c_longstring_fdid
	, c4_longstrings.value as c_longstring_value
	, fd4.handle as p_acid_handle
	, acid2.fdid as p_acid_fdid
	, acid2.pid as p_acid_pid
	, acid2.code as p_acid_code
	, acid2.value as p_acid_value
	, acid.acid as p_acid_id
	, fd5.handle as p_strings_handle
	, p6_strings.fdid as p_strings_fdid
	, p6_strings.value as p_strings_value
	, fd6.handle as p_longstrings_handle
	, p6_longstrings.fdid as p_longstrings_fdid
	, p6_longstrings.value as p_longstrings_value
FROM p6
LEFT JOIN c4 on c4.oid = p6.oid
LEFT JOIN c4_acid on c4_acid.oid = p6.oid
LEFT JOIN field_definition fd1 on fd1.fdid = c4_acid.fdid
LEFT JOIN acid on c4_acid.acid = acid.acid
LEFT JOIN c4_strings on c4_strings.oid = p6.oid
LEFT JOIN field_definition fd2 on fd2.fdid = c4_strings.fdid
LEFT JOIN c4_longstrings on c4_longstrings.oid = p6.oid
LEFT JOIN field_definition fd3 on fd3.fdid = c4_longstrings.fdid
LEFT JOIN p6_acid on p6_acid.oid = p6.oid
LEFT JOIN acid acid2 on p6_acid.acid = acid2.acid
LEFT JOIN field_definition fd4 on fd4.fdid = p6_acid.fdid
LEFT JOIN p6_strings on p6_strings.oid = p6.oid
LEFT JOIN field_definition fd5 on p6_strings.fdid = fd5.fdid
LEFT JOIN p6_longstrings on p6_longstrings.oid = p6.oid
LEFT JOIN field_definition fd6 on p6_longstrings.fdid = fd6.fdid

UNION ALL

SELECT p7.oid
	, c4.oid
	, c4._oid
	, c4.pid
	, c4._boid
	, c4._bindex
	, c4._zindex
	, c4._bparent
	, c4._parent
	, acid.fdid
	, acid.pid
	, acid.code
	, acid.value
	, acid.acid
	, fd2.handle as c_string_handle
	, c4_strings.fdid as c_string_fdid
	, c4_strings.value as c_string_value
	, fd3.handle as c_longstring_handle
	, c4_longstrings.fdid as c_longstring_fdid
	, c4_longstrings.value as c_longstring_value
	, fd4.handle as p_acid_handle
	, acid2.fdid as p_acid_fdid
	, acid2.pid as p_acid_pid
	, acid2.code as p_acid_code
	, acid2.value as p_acid_value
	, acid.acid as p_acid_id
	, fd5.handle as p_strings_handle
	, p7_strings.fdid as p_strings_fdid
	, p7_strings.value as p_strings_value
	, fd6.handle as p_longstrings_handle
	, p7_longstrings.fdid as p_longstrings_fdid
	, p7_longstrings.value as p_longstrings_value
FROM p7
LEFT JOIN c4 on c4.oid = p7.oid
LEFT JOIN c4_acid on c4_acid.oid = p7.oid
LEFT JOIN acid on c4_acid.acid = acid.acid
LEFT JOIN c4_strings on c4_strings.oid = p7.oid
LEFT JOIN field_definition fd2 on fd2.fdid = c4_strings.fdid
LEFT JOIN c4_longstrings on c4_longstrings.oid = p7.oid
LEFT JOIN field_definition fd3 on fd3.fdid = c4_longstrings.fdid
LEFT JOIN p7_acid on p7_acid.oid = p7.oid
LEFT JOIN acid acid2 on p7_acid.acid = acid2.acid
LEFT JOIN field_definition fd4 on fd4.fdid = p7_acid.fdid
LEFT JOIN p7_strings on p7_strings.oid = p7.oid
LEFT JOIN field_definition fd5 on p7_strings.fdid = fd5.fdid
LEFT JOIN p7_longstrings on p7_longstrings.oid = p7.oid
LEFT JOIN field_definition fd6 on p7_longstrings.fdid = fd6.fdid

UNION ALL

SELECT p31.oid
	, c4.oid
	, c4._oid
	, c4.pid
	, c4._boid
	, c4._bindex
	, c4._zindex
	, c4._bparent
	, c4._parent
	, acid.fdid
	, acid.pid
	, acid.code
	, acid.value
	, acid.acid
	, fd2.handle as c_string_handle
	, c4_strings.fdid as c_string_fdid
	, c4_strings.value as c_string_value
	, fd3.handle as c_longstring_handle
	, c4_longstrings.fdid as c_longstring_fdid
	, c4_longstrings.value as c_longstring_value
	, fd4.handle as p_acid_handle
	, acid2.fdid as p_acid_fdid
	, acid2.pid as p_acid_pid
	, acid2.code as p_acid_code
	, acid2.value as p_acid_value
	, acid.acid as p_acid_id
	, fd5.handle as p_strings_handle
	, p31_strings.fdid as p_strings_fdid
	, p31_strings.value as p_strings_value
	, fd6.handle as p_longstrings_handle
	, p31_longstrings.fdid as p_longstrings_fdid
	, p31_longstrings.value as p_longstrings_value
FROM p31
LEFT JOIN c4 on c4.oid = p31.oid
LEFT JOIN c4_acid on c4_acid.oid = p31.oid
LEFT JOIN acid on c4_acid.acid = acid.acid
LEFT JOIN c4_strings on c4_strings.oid = p31.oid
LEFT JOIN field_definition fd2 on fd2.fdid = c4_strings.fdid
LEFT JOIN c4_longstrings on c4_longstrings.oid = p31.oid
LEFT JOIN field_definition fd3 on fd3.fdid = c4_longstrings.fdid
LEFT JOIN p31_acid on p31_acid.oid = p31.oid
LEFT JOIN acid acid2 on p31_acid.acid = acid2.acid
LEFT JOIN field_definition fd4 on fd4.fdid = p31_acid.fdid
LEFT JOIN p31_strings on p31_strings.oid = p31.oid
LEFT JOIN field_definition fd5 on p31_strings.fdid = fd5.fdid
LEFT JOIN p31_longstrings on p31_longstrings.oid = p31.oid
LEFT JOIN field_definition fd6 on p31_longstrings.fdid = fd6.fdid



UNION ALL

SELECT p35.oid
	, c4.oid
	, c4._oid
	, c4.pid
	, c4._boid
	, c4._bindex
	, c4._zindex
	, c4._bparent
	, c4._parent
	, acid.fdid
	, acid.pid
	, acid.code
	, acid.value
	, acid.acid
	, fd2.handle as c_string_handle
	, c4_strings.fdid as c_string_fdid
	, c4_strings.value as c_string_value
	, fd3.handle as c_longstring_handle
	, c4_longstrings.fdid as c_longstring_fdid
	, c4_longstrings.value as c_longstring_value
	, fd4.handle as p_acid_handle
	, acid2.fdid as p_acid_fdid
	, acid2.pid as p_acid_pid
	, acid2.code as p_acid_code
	, acid2.value as p_acid_value
	, acid.acid as p_acid_id
	, fd5.handle as p_strings_handle
	, p35_strings.fdid as p_strings_fdid
	, p35_strings.value as p_strings_value
	, fd6.handle as p_longstrings_handle
	, p35_longstrings.fdid as p_longstrings_fdid
	, p35_longstrings.value as p_longstrings_value
FROM p35
LEFT JOIN c4 on c4.oid = p35.oid
LEFT JOIN c4_acid on c4_acid.oid = p35.oid
LEFT JOIN acid on c4_acid.acid = acid.acid
LEFT JOIN c4_strings on c4_strings.oid = p35.oid
LEFT JOIN field_definition fd2 on fd2.fdid = c4_strings.fdid
LEFT JOIN c4_longstrings on c4_longstrings.oid = p35.oid
LEFT JOIN field_definition fd3 on fd3.fdid = c4_longstrings.fdid
LEFT JOIN p35_acid on p35_acid.oid = p35.oid
LEFT JOIN acid acid2 on p35_acid.acid = acid2.acid
LEFT JOIN field_definition fd4 on fd4.fdid = p35_acid.fdid
LEFT JOIN p35_strings on p35_strings.oid = p35.oid
LEFT JOIN field_definition fd5 on p35_strings.fdid = fd5.fdid
LEFT JOIN p35_longstrings on p35_longstrings.oid = p35.oid
LEFT JOIN field_definition fd6 on p35_longstrings.fdid = fd6.fdid

UNION ALL

SELECT p39.oid
	, c4.oid
	, c4._oid
	, c4.pid
	, c4._boid
	, c4._bindex
	, c4._zindex
	, c4._bparent
	, c4._parent
	, acid.fdid
	, acid.pid
	, acid.code
	, acid.value
	, acid.acid
FROM p39
LEFT JOIN c4 on c4.oid = p39.oid
LEFT JOIN c4_acid on c4_acid.oid = p39.oid
LEFT JOIN acid on c4_acid.acid = acid.acid

UNION ALL

SELECT p43.oid
	, c19.oid
	, c19._oid
	, c19.pid
	, c19._boid
	, c19._bindex
	, c19._zindex
	, c19._bparent
	, c19._parent
	, acid.fdid
	, acid.pid
	, acid.code
	, acid.value
	, acid.acid
FROM p43
LEFT JOIN c19 on c19.oid = p43.oid
LEFT JOIN c19_acid on c19_acid.oid = p43.oid
LEFT JOIN acid on c19_acid.acid = acid.acid

UNION ALL

SELECT p44.oid
	, c19.oid
	, c19._oid
	, c19.pid
	, c19._boid
	, c19._bindex
	, c19._zindex
	, c19._bparent
	, c19._parent
	, acid.fdid
	, acid.pid
	, acid.code
	, acid.value
	, acid.acid
FROM p44
LEFT JOIN c19 on c19.oid = p44.oid
LEFT JOIN c19_acid on c19_acid.oid = p44.oid
LEFT JOIN acid on c19_acid.acid = acid.acid

UNION ALL

SELECT p61.oid
	, c19.oid
	, c19._oid
	, c19.pid
	, c19._boid
	, c19._bindex
	, c19._zindex
	, c19._bparent
	, c19._parent
	, acid.fdid
	, acid.pid
	, acid.code
	, acid.value
	, acid.acid
FROM p61
LEFT JOIN c19 on c19.oid = p61.oid
LEFT JOIN c19_acid on c19_acid.oid = p61.oid
LEFT JOIN acid on c19_acid.acid = acid.acid


# projects: 6, 7, 31, 35, 39, 43, 44, 61
# collections: 4, 19 (also 24, but none of the projects are in-scope)
# project/collection: 6/4, 7/4, 31/4, 35/4, 39/4, 43/19, 44/19, 61/19

# all p records, union all: 1,690,803, no joins
# all c records, union all: 1,606,434, no joins


# Seems like the different project tables have different columns. This whole thing is wild