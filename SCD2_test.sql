SELECT
MIN(eff_dt) OVER (PARTITION BY t.AR_ID ORDER BY eff_dt, end_dt ROWS between 1 preceding and 1 preceding) AS prev_eff_dt,
MIN(end_dt) OVER (PARTITION BY t.AR_ID ORDER BY eff_dt, end_dt ROWS between 1 preceding and 1 preceding) AS prev_end_dt,
t.*
FROM edwsor_vp.AR_X_SVC_ELMT AS t -- where AR_ID = 19606127




qualify
MIN(eff_dt) OVER (PARTITION BY t.AR_ID ORDER BY eff_dt, end_dt ROWS between 1 preceding and 1 preceding) between eff_dt and end_dt -- overlap part1
or MIN(end_dt) OVER (PARTITION BY t.AR_ID ORDER BY eff_dt, end_dt ROWS between 1 preceding and 1 preceding) between eff_dt and end_dt -- overlap part2
or MIN(end_dt) OVER (PARTITION BY t.AR_ID ORDER BY eff_dt, end_dt ROWS between 1 preceding and 1 preceding) <> eff_dt-1 -- hole
--sample 100
;