sel CAST (TO_BYTES (column_name, 'ASCII') as BYTE (16)) from table_name where ;

-- To remove null sign
REGEXP_REPLACE(column_name, '\s', ' ')
