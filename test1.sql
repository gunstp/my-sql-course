--select * from airports

select 
    ps.PatientId
    , ps.AdmittedDate
    , ps.dischargedate 
    , DATEDIFF (day, ps.AdmittedDate, ps.dischargedate) As Lengthofstay
    , Dateadd (WEEK, -2, ps.AdmittedDate) as reminderdate
    , ps.Hospital
    , ps.Ward
    , ps.Tariff
from PatientStay ps
WHERE ps.Hospital IN ('pruh', 'oxleas')
And ps.Ward Like '%Surgery'
--And ps.AdmittedDate >= '2024-02-27'
--and ps.AdmittedDate <= '2024-03-01'
And ps.AdmittedDate BETWEEN '2024-02-27' AND '2024-03-01'

