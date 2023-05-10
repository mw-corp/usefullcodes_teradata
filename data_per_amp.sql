select hashamp(hashbucket(hashrow(PLH_EXT_OU_IP_ID ,PLH_INT_OU_IP_ID))) as h,count(*) as c
from EDWSTG_ua4.INT_SURVY_DKFO_DST_DTL 
group by 1
order by 1 desc;