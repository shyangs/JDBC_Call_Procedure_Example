
-- 
-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- 

DECLARE @Object AS int;
DECLARE @responseText AS nvarchar(4000);
EXEC sp_OACreate 'MSXML2.ServerXMLHTTP', @Object OUT
-- https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ms762278(v%3dvs.85)
EXEC sp_OAMethod @Object, 'open', NULL, 'GET', 'https://www.cwb.gov.tw/V7/forecast/town368/3Hr/plot/6300200_3Hr.js', 'false'
-- https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ms764715(v%3dvs.85)
EXEC sp_OAMethod @Object, 'setRequestHeader', null, 'Content-Type', 'text/javascript; charset=UTF-8'
EXEC sp_OAMethod @Object, 'send', null, ''
EXEC sp_OAMethod @Object, 'responseText', @responseText OUTPUT
SELECT @responseText
Exec sp_OADestroy @Object



-- 
-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- 

DECLARE @Object AS int;
DECLARE @responseText AS nvarchar(4000);
EXEC sp_OACreate 'MSXML2.ServerXMLHTTP', @Object OUT
EXEC sp_OAMethod @Object, 'open', NULL, 'post', 'http://10.20.86.19:9990/CROSS/RESTful/getProdList', 'false'
EXEC sp_OAMethod @Object, 'setRequestHeader', null, 'Content-Type', 'application/json; charset=UTF-8'
EXEC sp_OAMethod @Object, 'send', null, ''
EXEC sp_OAMethod @Object, 'responseText', @responseText OUTPUT
SELECT @responseText
Exec sp_OADestroy @Object

-- 
-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- 


Declare @Object as int;
Declare @ResponseText as nvarchar(4000);
Declare @Status as int;
Declare @Body as nvarchar(4000) = ''

Declare @BodyLength int = LEN(@Body)
Exec sp_OACreate 'MSXML2.ServerXMLHTTP', @Object OUT;
-- Exec sp_OAMethod @Object, 'setProxy', '2', 'http://localhost:8888',''
Exec sp_OAMethod @Object, 'open', NULL, 'post',
    'http://10.20.86.19:9990/CROSS/RESTful/getProdList',
    'false'

Exec sp_OAMethod @Object, 'setRequestHeader', null, 'Content-Type', 'application/json; charset=UTF-8'
Exec sp_OAMethod @Object, 'setRequestHeader', null, 'Content-LEngth', @BodyLength

Exec sp_OAMethod @Object, 'send', null , @Body


Exec sp_OAMethod @Object, 'responseText', @ResponseText OUTPUT
Exec sp_OAMethod @Object, 'status', @Status OUTPUT
Exec sp_OAMethod @Object, 'responseText', @ResponseText OUTPUT

Select @ResponseText as Response, @Status as Status

Exec sp_OADestroy @Object



-- 
-- ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- 


CREATE PROCEDURE MYSPXHR
	-- Add the parameters for the stored procedure here
	@url    nvarchar(4000),
	@body   nvarchar(4000),
	@responseText nvarchar(4000) OUTPUT
AS
BEGIN
	DECLARE @Object AS int;
	EXEC sp_OACreate 'MSXML2.ServerXMLHTTP', @Object OUT
	EXEC sp_OAMethod @Object, 'open', NULL, 'post', @url, 'false'
	EXEC sp_OAMethod @Object, 'setRequestHeader', NULL, 'Content-Type', 'application/json; charset=UTF-8'
	EXEC sp_OAMethod @Object, 'send', NULL, @body
	EXEC sp_OAMethod @Object, 'responseText', @responseText OUTPUT
	EXEC sp_OADestroy @Object
END

DECLARE @res  nvarchar(4000)
EXEC  MYSPXHR @url = 'http://10.20.86.19:9990/CROSS/RESTful/getProdList', @body = '', @responseText = @res OUTPUT
PRINT @res