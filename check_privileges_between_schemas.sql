--SDC ONLY

SELECT UserName , RoleName ,DatabaseName,tablename, substr(XMLAGG(COALESCE(','|| Description,',NULL')  ORDER BY Description DESC)(varchar(8000)),2) as AccessRight 
FROM 
            (SELECT A.GRANTEE as UserName , A.ROLENAME as RoleName  ,B.DATABASENAME as DatabaseName, tablename,AccessRight
            FROM    DBC.ROLEMEMBERS A
            JOIN    DBC.ALLROLERIGHTS B
            ON  A.ROLENAME = B.ROLENAME
            WHERE 1=1 
            UNION
            SELECT USERNAME, '' as RoleName, DATABASENAME, tablename, AccessRight FROM dbc.allrights WHERE 1=1 GROUP BY 1,2,3,4,5) as tab1
            JOIN SDC_TOOLS.AccessRightsDict dict ON (tab1.AccessRight = dict.AccessRight)
WHERE trim(UPPER(UserName)) like 'EDWCLT_VP'
and trim(UPPER(DatabaseName)) like 'EDWENR%'
--and length(trim(UserName))<10
group by 1,2,3,4
order by 1,2;
