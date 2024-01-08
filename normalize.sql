--NORMALIZE:

CREATE VOLATILE TABLE DDA_DATA_NORM ,  NO LOG,  NO JOURNAL,  NO FALLBACK as (

			SELECT
				AC_TXN_TP_ID
				,LDB_ID
				,EFF_DT
				,END_DT
				,BAL_TP_CL
			FROM
				DDA_DATA_END_DT
			WHERE
				EFF_DT > END_DT
				
			UNION ALL
			
			SELECT
				AC_TXN_TP_ID
				,LDB_ID
				,cast(begin(per) as DATE)  as EFF_DT
				,cast(case when end(per) = '2999-12-31' then end(per) else end(per) - 1 end as DATE) as END_DT
				,BAL_TP_CL
			FROM
				(
					SELECT NORMALIZE * FROM (
						SELECT
							AC_TXN_TP_ID
							,LDB_ID
							,period(EFF_DT, case when END_DT = '2999-12-31' then END_DT else END_DT + 1 end) as per
							,BAL_TP_CL
						FROM
							DDA_DATA_END_DT
						WHERE EFF_DT <= END_DT
					) t1
				) t2
) WITH DATA on COMMIT PRESERVE ROWS;
