CREATE DATABASE itproject1
GO

USE itproject1
GO

-- List tables:
-- {
    -- tb_norm_user_acc(c_nuname/, c_npasswd)
    -- tb_mod_user_acc(c_muname/, c_mpasswd)
    -- tb_mod_user_info(c_muname/, c_dis_name)
    -- tb_posts(c_postid/, c_title, c_description, c_content, _datetime_created, c_author, c_url, c_category)
    -- tb_post_evaluation(c_postid/, c_upvote, c_downvote)
    -- tb_comments(c_author/, c_postid/, c_datetime/, c_content)
	-- tb_norm_user_info(c_nuname/, c_avatar)
-- }
-- /List tables


-- tb_norm_user_acc(c_nuname/, c_npasswd)
CREATE TABLE tb_norm_user_acc (
    c_nuname VARCHAR(30),
    c_npasswd VARCHAR(70) NOT NULL,

    PRIMARY KEY(c_nuname)
)
GO

-- tb_norm_user_info(c_nuname/, c_avatar)
CREATE TABLE tb_norm_user_info (
    c_nuname VARCHAR(30) REFERENCES tb_norm_user_acc(c_nuname),
    c_avatar VARCHAR(500) DEFAULT 'https://www.apple.com/ac/structured-data/images/open_graph_logo.png?201809210816',

    PRIMARY KEY(c_nuname)
)
GO

-- tb_mod_user_acc(c_muname/, c_mpasswd)
CREATE TABLE tb_mod_user_acc (
    c_muname VARCHAR(30),
    c_mpasswd VARCHAR(70) NULL,

    PRIMARY KEY(c_muname)
)
GO

-- tb_mod_user_info(c_muname/, c_dis_name)
CREATE TABLE tb_mod_user_info (
    c_muname VARCHAR(30) REFERENCES tb_mod_user_acc(c_muname),
    c_dis_name NVARCHAR(100) NOT NULL,

    PRIMARY KEY(c_muname)
)
GO

-- tb_posts(c_postid/, c_title, c_description, c_content, _datetime_created, c_author, c_url, c_category)
CREATE TABLE tb_posts (
    c_postid INT IDENTITY(1,1),
    c_title NVARCHAR(500) NOT NULL,
    c_description NTEXT NOT NULL,
    c_content NTEXT NOT NULL,
    c_datetime_created DATETIME NOT NULL,
    c_author VARCHAR(30) REFERENCES tb_mod_user_acc(c_muname) NOT NULL,
    c_aurl NVARCHAR(500) UNIQUE NOT NULL,
    c_category NVARCHAR(50) NOT NULL,
    c_thumbnailUrl NVARCHAR(500) NOT NULL,

    PRIMARY KEY(c_postid)
)
GO

-- tb_post_evaluation(c_postid/, c_upvote, c_downvote)
CREATE TABLE tb_post_evaluation (
    c_postid INT,
    c_upvote INT DEFAULT 0,
    c_downvote INT DEFAULT 0,

    FOREIGN KEY(c_postid) REFERENCES tb_posts(c_postid),
    PRIMARY KEY(c_postid)
)
GO

-- tb_comments(c_author/, c_postid/, c_datetime/, c_content)
CREATE TABLE tb_comments (
    c_author VARCHAR(30) REFERENCES tb_norm_user_acc(c_nuname),
    c_postid INT REFERENCES tb_posts(c_postid),
    c_datetime DATETIME,
    c_content NTEXT NOT NULL,

    PRIMARY KEY(c_author, c_postid, c_datetime)
)
GO

CREATE TABLE tb_userVoteState (
    c_postid INT REFERENCES tb_posts(c_postid),
    c_nuname varchar(30) REFERENCES tb_norm_user_acc(c_nuname),
    c_voteStatus INT, -- 1: UpVote | 0: DownVote | if nonVote then delete record

    PRIMARY KEY(c_postid, c_nuname)
)
GO


-- Procedures

CREATE PROC insComment
@author VARCHAR(30), @postid INT, @content NTEXT
AS
BEGIN
    INSERT dbo.tb_comments
    (
        c_author,
        c_postid,
        c_datetime,
        c_content
    )
    VALUES
    (   @author,        -- c_author - varchar(30)
        @postid,         -- c_postid - int
        GETDATE(), -- c_datetime - datetime
        @content        -- c_content - ntext
        )
END
GO

-- EXEC dbo.insComment @author = '',  @postid = 1, @content = N''
-- GO

CREATE PROC insMod
@uname VARCHAR(30), @passwd VARCHAR(70), @disname NVARCHAR(100)
AS
BEGIN
    INSERT dbo.tb_mod_user_acc
    (
        c_muname,
        c_mpasswd
    )
    VALUES
    (   @uname, -- c_muname - varchar(30)
        @passwd  -- c_mpasswd - varchar(70)
        );
	INSERT dbo.tb_mod_user_info
	(
	    c_muname,
	    c_dis_name
	)
	VALUES
	(   @uname, -- c_muname - varchar(30)
	    @disname -- c_dis_name - nvarchar(100)
	    )
END
GO

-- EXEC dbo.insMod @uname = '', @passwd = '', @disname = N''
-- GO

CREATE PROC changePasswdMod
@uname VARCHAR(30), @passwd VARCHAR(70)
AS
BEGIN
    UPDATE dbo.tb_mod_user_acc
	SET c_mpasswd = @passwd
	WHERE c_muname = @uname
END
GO

-- EXEC dbo.changePasswdMod @uname = '', @passwd = ''
-- GO

CREATE PROC insNormUser
@uname VARCHAR(30), @passwd VARCHAR(70)
AS
BEGIN
    INSERT dbo.tb_norm_user_acc
    (
        c_nuname,
        c_npasswd
    )
    VALUES
    (   @uname, -- c_nuname - varchar(30)
        @passwd  -- c_npasswd - varchar(70)
        );
	INSERT dbo.tb_norm_user_info
	(
	    c_nuname,
	    c_avatar
	)
	VALUES
	(   @uname, -- c_nuname - varchar(30)
	    'https://www.apple.com/ac/structured-data/images/open_graph_logo.png?201809210816'  -- c_avatar - varchar(500)
	    )
END
GO

-- EXEC dbo.insNormUser @uname = '', @passwd = ''
-- GO

CREATE PROC changePasswdNorm
@uname VARCHAR(30), @passwd VARCHAR(70)
AS
BEGIN
    UPDATE dbo.tb_norm_user_acc
	SET c_npasswd = @passwd
	WHERE c_nuname = @uname
END
GO

-- EXEC dbo.changePasswdMod @uname = '', @passwd = ''
-- GO

CREATE PROC changeAvtNorm
@uname VARCHAR(30), @avtlink VARCHAR(500)
AS
BEGIN
    UPDATE dbo.tb_norm_user_info
	SET c_avatar = @avtlink
	WHERE c_nuname = @uname
END
GO

-- EXEC dbo.changeAvtNorm @uname = '', @avtlink = ''
-- GO

CREATE PROC insPost
@title NVARCHAR(500), @description NTEXT, @content NTEXT, @author VARCHAR(30), @aurl NVARCHAR(500), @category NVARCHAR(50), @thumbUrl NVARCHAR(500)
AS
BEGIN
	INSERT dbo.tb_posts
	(
	    c_title,
	    c_description,
	    c_content,
	    c_datetime_created,
	    c_author,
	    c_aurl,
	    c_category,
	    c_thumbnailUrl
	)
	VALUES
	(   @title,       -- c_title - nvarchar(500)
	    @description,       -- c_description - ntext
	    @content,       -- c_content - ntext
	    GETDATE(), -- c_datetime_created - datetime
	    @author,        -- c_author - varchar(30)
	    @aurl,       -- c_aurl - nvarchar(500)
	    @category,       -- c_category - nvarchar(50)
	    @thumbUrl        -- c_thumbnailUrl - nvarchar(500)
	    );

	DECLARE @findPostId INT;
	SELECT TOP(1) @findPostId = c_postid
	FROM dbo.tb_posts
	ORDER BY c_datetime_created DESC;

	INSERT dbo.tb_post_evaluation
	(
	    c_postid,
	    c_upvote,
	    c_downvote
	)
	VALUES
	(   @findPostId, -- c_postid - int
	    0, -- c_upvote - int
	    0  -- c_downvote - int
	    )
END
GO

-- EXEC dbo.insPost @title = N'', @description = N'', @content = N'', @author = '', @aurl = N'', @category = N'', @thumbUrl = N''
-- GO

CREATE PROC changePostEval
@postId INT, @upv INT, @downv INT
AS
BEGIN
    UPDATE dbo.tb_post_evaluation
	SET c_upvote = @upv, c_downvote = @downv
	WHERE c_postid = @postId
END
GO

-- EXEC dbo.changePostEval @postId = 0, @upv = 0, @downv = 0
-- GO

CREATE PROC changeVoteState
@postId INT, @uname VARCHAR(30), @voteState INT	-- 1: up | 0: down | 2: delete record
AS
BEGIN
	DECLARE @findPostId INT, @findUname VARCHAR(30), @existed INT;

	SELECT @existed = COUNT(*)
	FROM dbo.tb_userVoteState
	WHERE c_nuname = @uname AND c_postid = @postId;

	IF @existed = 0
		BEGIN
			INSERT dbo.tb_userVoteState
			(
				c_postid,
				c_nuname,
				c_voteStatus
			)
			VALUES
			(   @postId,  -- c_postid - int
				@uname, -- c_nuname - varchar(30)
				@voteState   -- c_voteStatus - int
				);
			
			-- Write script to change Vote (Evaluation) of post
		END;
	ELSE
		BEGIN
			IF @voteState = 2
				DELETE FROM dbo.tb_userVoteState
				WHERE c_postid = @postId AND c_nuname = @uname;
			ELSE
				UPDATE dbo.tb_userVoteState
				SET c_voteStatus = @voteState
				WHERE c_postid = @postId AND c_nuname = @uname;
		END;
END
GO

-- EXEC dbo.changeVoteState @postId = 0, @uname = '', @voteState = 0
-- GO

CREATE PROC getTenArticles
@pageNum INT, @category NVARCHAR(50)
AS
BEGIN
	IF @category = 'default'
		SELECT *
		FROM (
			SELECT *, ROW_NUMBER() OVER(ORDER BY c_postid DESC) AS RN
			FROM tb_posts
		) as sl1
		WHERE RN BETWEEN 10 * (@pageNum - 1) + 1 AND 10 * (@pageNum)
		ORDER BY c_postid DESC;
	ELSE
		SELECT *
		FROM (
			SELECT *, ROW_NUMBER() OVER(ORDER BY c_postid DESC) AS RN
			FROM tb_posts
			WHERE c_category = @category
		) as sl2
		WHERE RN BETWEEN 10 * (@pageNum - 1) + 1 AND 10 * (@pageNum)
		ORDER BY c_postid DESC;
END
GO

-- EXEC getTenArticles @pageNum = 1, @category = N'default'
-- GO

CREATE PROC getTenArticlesEval
@pageNum INT, @category NVARCHAR(50)
AS
BEGIN
	SELECT *
	FROM (
		SELECT tb_post_evaluation.c_postid, tb_post_evaluation.c_upvote, tb_post_evaluation.c_downvote ,ROW_NUMBER() OVER(ORDER BY tb_post_evaluation.c_postid DESC) AS RN
		FROM tb_post_evaluation, tb_posts
		WHERE tb_posts.c_postid = tb_post_evaluation.c_postid AND tb_posts.c_category = @category
	) AS sl3
	WHERE RN BETWEEN 10 * (@pageNum - 1) + 1 AND 10 * (@pageNum)
	ORDER BY c_postid DESC
END
GO

-- EXEC getTenArticlesEval @pageNum = 1, @category = N''
-- GO


-- draft

EXEC dbo.insPost @title = N'f1', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f1-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b1', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b1-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f2', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f2-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b2', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b2-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f3', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f3-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b3', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b3-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f4', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f4-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f5', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f5-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b4', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b4-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b5', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b5-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f6', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f6-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b6', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b6-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f7', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f7-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b7', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b7-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f8', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f8-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b8', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b8-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f9', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f9-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b9', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b9-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f10', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f10-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b10', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b10-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f11', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f11-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b11', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b11-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f12', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f12-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b12', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b12-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f13', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f13-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b13', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b13-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f14', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f14-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f15', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f15-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b14', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b14-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b15', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b15-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f16', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f16-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b16', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b16-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f17', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f17-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b17', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b17-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f18', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f18-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b18', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b18-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f19', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f19-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b19', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b19-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f20', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f20-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b20', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b20-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'b21', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/b21-5', @category = N'back-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO

EXEC dbo.insPost @title = N'f21', @description = N'f1des', @content = N'asdfasdf', @author = 'vvv', @aurl = N'article/f21-5', @category = N'front-end', @thumbUrl = N'https://static2.yan.vn/YanNews/2167221/202012/suc-hut-ky-la-cua-iu-o-trung-quoc-at-via-lisa-du-khong-quang-ba-gi-b3812ff6.jpg'
GO



