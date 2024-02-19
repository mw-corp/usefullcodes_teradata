select RTRIM(XMLAGG(TRIM(t1.ColumnName)||','
                ORDER BY columnid
               ) (VARCHAR(10000)),', ') as columns_listed
from DBC.ColumnsV t1
where upper(t1.tablename)='ALGO_RSLT_IRRBB_NII_BAL' and upper(t1.databasename)='EDWDSADK_UA4'
and upper(t1.ColumnName) not in 'PPN_EV_ID';
