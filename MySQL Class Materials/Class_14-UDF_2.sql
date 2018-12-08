select dbo.udf_FullName(1)

select ContactID, dbo.udf_FullName(ContactID) as 'FullName'
from person.Contact 
order by ContactID

------

select * from udf_EmployeeByGender('M')
select * from udf_EmployeeByGender('f')

------
select * from dbo.GetPopulationByState()

------
select * from dbo.udf_ProductStorage(1,1)
select * from dbo.udf_ProductStorage(1,2)



