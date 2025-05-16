--select * from airports
--Select * FROM PatientStay



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
--And ps.AdmittedDate BETWEEN '2024-02-27' AND '2024-03-01'
ORDER BY ps.AdmittedDate DESC, ps.PatientId DESC

SELECT 
ps.Hospital
, ps.Ward
, COUNT(*) AS Numberofpatients 
,sum(ps.Tariff) AS Tarriff
,AVG(ps.Tariff) AS Avgtariff
,max(ps.Tariff) AS MAXtariff 
,Min(ps.Tariff) AS MAXtariff
FROM PatientStay PS
GROUP BY ps.Hospital, ps.Ward
--Order by ps.Hospital, ps.Ward
order by numberofpatients DESC
 

--SELECT 
    --ps.Ward,
    --AVG(ps.Tariff) AS AverageTariff
--FROM PatientStay ps
--GROUP BY ps.Ward
--WHERE ps.Hospital IN ('pruh', 'oxleas')
  --AND ps.Ward LIKE '%Surgery';
 
  SELECT * FROM PatientStay ps JOIN DimHospital DH on ps.Hospital = DH.Hospital

SELECT
    ps.PatientId
    ,ps.AdmittedDate
    ,ps.Hospital
    ,dh.HospitalType
    ,dh.HospitalSize
FROM PatientStay ps left JOIN DimHospitalBad dh ON ps.hospital = dh.Hospital
where DH.Hospital IS NULL

Select * from DimHospitalBad.
