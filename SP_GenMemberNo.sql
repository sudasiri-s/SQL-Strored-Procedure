-- =============================================
-- Author:		Sudasiri
-- Create date: 
-- Description:	PDI input: UProductId = @UProductId
--					output: @MemberNo = ExtRefNo
--							@ReferenceNo = ReferenceNo
-- =============================================
CREATE PROCEDURE [dbo].[SP_Member_Ref] 
	-- Add the parameters for the stored procedure here
	( @UProductId int 
	, @MemberNo varchar(30) OUTPUT
	, @ReferenceNo varchar(30) OUTPUT
	)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @NewPrefix varchar(30);
	DECLARE @SEQ int;
	DECLARE @PAD varchar(10);
	SET @PAD = '0000000000'

    -- Update SEQ at Prefix_number Table--
	UPDATE [dbo].[Prefix_number] 
	SET SEQ = SEQ+1
	WHERE  Unity_ID = @UProductId;


	SELECT @NewPrefix = [Prefix]
			,@SEQ  = [Seq] 
	FROM [dbo].[Prefix_number] 
	WHERE Unity_ID = @UProductId;

	SET @MemberNo = @NewPrefix +'-' + RIGHT(@PAD + CONVERT(varchar,@SEQ ),9);
	SET @ReferenceNo = CONVERT(VARCHAR, @UProductId) + @MemberNo + CONVERT(VARCHAR ,GETDATE(),12)


END