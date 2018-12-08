execute usp_GetEmployeeInfo
exec usp_GetEmployeeInfo

--------------

exec usp_GetEmployeeInfoByTitleGender 'Marketing Manager', 'M'
exec usp_GetEmployeeInfoByTitleGender @gender='M', @title='Marketing Manager'

--------------
select * from HumanResources.EmployeePayHistory where EmployeeID = 1

exec usp_UpdateEmployeePayment 
	@EmployeeID = 1, 
	@Payment = 20.00,
	@EffectiveDate = '8/1/2018', 
	@PayFrequency = 1

--------------
declare @r_UpdateStatus char(1)
declare @r_UpdateMessage varchar(100)

exec usp_UpdateEmployeePayment 
	@EmployeeID = 2, 
	@Payment = 18.00,
	@EffectiveDate = '8/1/2018', 
	@PayFrequency = 1,
	@UpdateStatus = @r_UpdateStatus output, 
	@UpdateMessage = @r_UpdateMessage output

select @r_UpdateStatus, @r_UpdateMessage 

--------------
declare @r_UpdateStatus char(1)
declare @r_UpdateMessage varchar(100)

exec @r_UpdateStatus = usp_UpdateEmployeePayment 
				@EmployeeID = 3, 
				@Payment = 48.00,
				@EffectiveDate = '8/1/2018', 
				@PayFrequency = 1,
				@UpdateMessage = @r_UpdateMessage output

select @r_UpdateStatus, @r_UpdateMessage 
