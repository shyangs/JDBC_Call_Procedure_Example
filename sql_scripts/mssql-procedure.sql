
CREATE PROCEDURE MYSPCONCAT 
	-- Add the parameters for the stored procedure here
	@arg01 nvarchar(255),
	@arg02 nvarchar(255),
	@arg03 nvarchar(255) OUTPUT
AS
BEGIN
	SET @arg03 = @arg01 + @arg02
END
-- GO

-- DECLARE @res  nvarchar(255)
-- EXEC  MYSPCONCAT @arg01 = 'AA',  @arg02 = 'BB', @arg03 = @res OUTPUT
-- PRINT @res
