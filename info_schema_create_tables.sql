
CREATE TABLE Badges (
	Id int(10) NOT NULL,
	UserId int(10) NOT NULL,
	Name nvarchar(50) NOT NULL,
	Date datetime NOT NULL,
	Class tinyint(3) NOT NULL,
	TagBased bit NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE CloseAsOffTopicReasonTypes (
	Id smallint(5) NOT NULL,
	IsUniversal bit NOT NULL,
	MarkdownMini nvarchar(500) NOT NULL,
	CreationDate datetime NOT NULL,
	CreationModeratorId int(10) NULL,
	ApprovalDate datetime NULL,
	ApprovalModeratorId int(10) NULL,
	DeactivationDate datetime NULL,
	DeactivationModeratorId int(10) NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE CloseReasonTypes (
	Id tinyint(3) NOT NULL,
	Name nvarchar(200) NOT NULL,
	Description nvarchar(500) NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE Comments (
	Id int(10) NOT NULL,
	PostId int(10) NOT NULL,
	Score int(10) NOT NULL,
	Text nvarchar(600) NOT NULL,
	CreationDate datetime NOT NULL,
	UserDisplayName nvarchar(30) NULL,
	UserId int(10) NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE FlagTypes (
	Id tinyint(3) NOT NULL,
	Name nvarchar(50) NOT NULL,
	Description nvarchar(500) NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE PendingFlags (
	Id int(10) NOT NULL,
	FlagTypeId tinyint(3) NOT NULL,
	PostId int(10) NOT NULL,
	CreationDate date NULL,
	CloseReasonTypeId tinyint(3) NULL,
	CloseAsOffTopicReasonTypeId smallint(5) NULL,
	DuplicateOfQuestionId int(10) NULL,
	BelongsOnBaseHostAddress nvarchar(100) NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE PostFeedback (
	Id int(10) NOT NULL,
	PostId int(10) NOT NULL,
	IsAnonymous bit NULL,
	VoteTypeId tinyint(3) NOT NULL,
	CreationDate datetime NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE PostHistory (
	Id int(10) NOT NULL,
	PostHistoryTypeId tinyint(3) NOT NULL,
	PostId int(10) NOT NULL,
	RevisionGUID uniqueidentifier NOT NULL,
	CreationDate datetime NOT NULL,
	UserId int(10) NULL,
	UserDisplayName nvarchar(40) NULL,
	Comment nvarchar(400) NULL,
	Text nvarchar(800) NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE PostHistoryTypes (
	Id tinyint(3) NOT NULL,
	Name nvarchar(50) NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE PostLinks (
	Id int(10) NOT NULL,
	CreationDate datetime NOT NULL,
	PostId int(10) NOT NULL,
	RelatedPostId int(10) NOT NULL,
	LinkTypeId tinyint(3) NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE PostNoticeTypes (
	Id int(10) NOT NULL,
	ClassId tinyint(3) NOT NULL,
	Name nvarchar(80) NULL,
	Body nvarchar(800) NULL,
	IsHidden bit NOT NULL,
	Predefined bit NOT NULL,
	PostNoticeDurationId int(10) NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE PostNotices (
	Id int(10) NOT NULL,
	PostId int(10) NOT NULL,
	PostNoticeTypeId int(10) NULL,
	CreationDate datetime NOT NULL,
	DeletionDate datetime NULL,
	ExpiryDate datetime NULL,
	Body nvarchar(800) NULL,
	OwnerUserId int(10) NULL,
	DeletionUserId int(10) NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE PostTags (
	PostId int(10) NOT NULL,
	TagId int(10) NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE PostTypes (
	Id tinyint(3) NOT NULL,
	Name nvarchar(50) NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE Posts (
	Id int(10) NOT NULL,
	PostTypeId tinyint(3) NOT NULL,
	AcceptedAnswerId int(10) NULL,
	ParentId int(10) NULL,
	CreationDate datetime NOT NULL,
	DeletionDate datetime NULL,
	Score int(10) NOT NULL,
	ViewCount int(10) NULL,
	Body nvarchar(800) NULL,
	OwnerUserId int(10) NULL,
	OwnerDisplayName nvarchar(40) NULL,
	LastEditorUserId int(10) NULL,
	LastEditorDisplayName nvarchar(40) NULL,
	LastEditDate datetime NULL,
	LastActivityDate datetime NULL,
	Title nvarchar(250) NULL,
	Tags nvarchar(250) NULL,
	AnswerCount int(10) NULL,
	CommentCount int(10) NULL,
	FavoriteCount int(10) NULL,
	ClosedDate datetime NULL,
	CommunityOwnedDate datetime NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE PostsWithDeleted (
	Id int(10) NOT NULL,
	PostTypeId tinyint(3) NOT NULL,
	AcceptedAnswerId int(10) NULL,
	ParentId int(10) NULL,
	CreationDate datetime NOT NULL,
	DeletionDate datetime NULL,
	Score int(10) NOT NULL,
	ViewCount int(10) NULL,
	Body nvarchar(800) NULL,
	OwnerUserId int(10) NULL,
	OwnerDisplayName nvarchar(40) NULL,
	LastEditorUserId int(10) NULL,
	LastEditorDisplayName nvarchar(40) NULL,
	LastEditDate datetime NULL,
	LastActivityDate datetime NULL,
	Title nvarchar(250) NULL,
	Tags nvarchar(250) NULL,
	AnswerCount int(10) NULL,
	CommentCount int(10) NULL,
	FavoriteCount int(10) NULL,
	ClosedDate datetime NULL,
	CommunityOwnedDate datetime NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE ReviewRejectionReasons (
	Id tinyint(3) NOT NULL,
	Name nvarchar(100) NOT NULL,
	Description nvarchar(300) NOT NULL,
	PostTypeId tinyint(3) NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE ReviewTaskResultTypes (
	Id tinyint(3) NOT NULL,
	Name nvarchar(100) NOT NULL,
	Description nvarchar(300) NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE ReviewTaskResults (
	Id int(10) NOT NULL,
	ReviewTaskId int(10) NOT NULL,
	ReviewTaskResultTypeId tinyint(3) NOT NULL,
	CreationDate date NULL,
	RejectionReasonId tinyint(3) NULL,
	Comment nvarchar(150) NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE ReviewTaskStates (
	Id tinyint(3) NOT NULL,
	Name nvarchar(50) NOT NULL,
	Description nvarchar(300) NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE ReviewTaskTypes (
	Id tinyint(3) NOT NULL,
	Name nvarchar(50) NOT NULL,
	Description nvarchar(300) NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE ReviewTasks (
	Id int(10) NOT NULL,
	ReviewTaskTypeId tinyint(3) NOT NULL,
	CreationDate date NULL,
	DeletionDate date NULL,
	ReviewTaskStateId tinyint(3) NOT NULL,
	PostId int(10) NOT NULL,
	SuggestedEditId int(10) NULL,
	CompletedByReviewTaskId int(10) NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE SuggestedEditVotes (
	Id int(10) NOT NULL,
	SuggestedEditId int(10) NOT NULL,
	UserId int(10) NOT NULL,
	VoteTypeId tinyint(3) NOT NULL,
	CreationDate datetime NOT NULL,
	TargetUserId int(10) NULL,
	TargetRepChange int(10) NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE SuggestedEdits (
	Id int(10) NOT NULL,
	PostId int(10) NOT NULL,
	CreationDate datetime NULL,
	ApprovalDate datetime NULL,
	RejectionDate datetime NULL,
	OwnerUserId int(10) NULL,
	Comment nvarchar(800) NULL,
	Text nvarchar(800) NULL,
	Title nvarchar(250) NULL,
	Tags nvarchar(250) NULL,
	RevisionGUID uniqueidentifier NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE TagSynonyms (
	Id int(10) NOT NULL,
	SourceTagName nvarchar(35) NULL,
	TargetTagName nvarchar(35) NULL,
	CreationDate datetime NOT NULL,
	OwnerUserId int(10) NOT NULL,
	AutoRenameCount int(10) NOT NULL,
	LastAutoRename datetime NULL,
	Score int(10) NOT NULL,
	ApprovedByUserId int(10) NULL,
	ApprovalDate datetime NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE Tags (
	Id int(10) NOT NULL,
	TagName nvarchar(35) NULL,
	Count int(10) NOT NULL,
	ExcerptPostId int(10) NULL,
	WikiPostId int(10) NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE Users (
	Id int(10) NOT NULL,
	Reputation int(10) NOT NULL,
	CreationDate datetime NOT NULL,
	DisplayName nvarchar(40) NULL,
	LastAccessDate datetime NOT NULL,
	WebsiteUrl nvarchar(200) NULL,
	Location nvarchar(100) NULL,
	AboutMe nvarchar(800) NULL,
	Views int(10) NOT NULL,
	UpVotes int(10) NOT NULL,
	DownVotes int(10) NOT NULL,
	ProfileImageUrl nvarchar(200) NULL,
	EmailHash varchar(32) NULL,
	AccountId int(10) NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE VoteTypes (
	Id tinyint(3) NOT NULL,
	Name nvarchar(50) NOT NULL,
	PRIMARY KEY ( Id )
);             

CREATE TABLE Votes (
	Id int(10) NOT NULL,
	PostId int(10) NOT NULL,
	VoteTypeId tinyint(3) NOT NULL,
	UserId int(10) NULL,
	CreationDate datetime NULL,
	BountyAmount int(10) NULL,
	PRIMARY KEY ( Id )
);             

ALTER TABLE PostsWithDeleted 
ADD CONSTRAINT Fk_PostsWithDeleted_PostTypes FOREIGN KEY ( PostTypeId ) 
REFERENCES PostTypes( Id ) ;

ALTER TABLE PostHistory 
ADD CONSTRAINT Fk_PostHistory_PostHistoryTypes FOREIGN KEY ( PostHistoryTypeId ) 
REFERENCES PostHistoryTypes( Id ) ;

ALTER TABLE PostHistory 
ADD CONSTRAINT Fk_PostHistory_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PostHistory 
ADD CONSTRAINT Fk_PostHistory_Users FOREIGN KEY ( UserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE Votes 
ADD CONSTRAINT Fk_Votes_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE Votes 
ADD CONSTRAINT Fk_Votes_VoteTypes FOREIGN KEY ( VoteTypeId ) 
REFERENCES VoteTypes( Id ) ;

ALTER TABLE Votes 
ADD CONSTRAINT Fk_Votes_Users FOREIGN KEY ( UserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE Badges 
ADD CONSTRAINT Fk_Badges_Users FOREIGN KEY ( UserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE Comments 
ADD CONSTRAINT Fk_Comments_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE Comments 
ADD CONSTRAINT Fk_Comments_Users FOREIGN KEY ( UserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE PostFeedback 
ADD CONSTRAINT Fk_PostFeedback_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PostFeedback 
ADD CONSTRAINT Fk_PostFeedback_VoteTypes FOREIGN KEY ( VoteTypeId ) 
REFERENCES VoteTypes( Id ) ;

ALTER TABLE SuggestedEdits 
ADD CONSTRAINT Fk_SuggestedEdits_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE SuggestedEditVotes 
ADD CONSTRAINT Fk_SuggestedEditVotes_SuggestedEdits FOREIGN KEY ( SuggestedEditId ) 
REFERENCES SuggestedEdits( Id ) ;

ALTER TABLE SuggestedEditVotes 
ADD CONSTRAINT Fk_SuggestedEditVotes_Users FOREIGN KEY ( UserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE SuggestedEditVotes 
ADD CONSTRAINT Fk_SuggestedEditVotes_VoteTypes FOREIGN KEY ( VoteTypeId ) 
REFERENCES VoteTypes( Id ) ;

ALTER TABLE PostLinks 
ADD CONSTRAINT Fk_PostLinks_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PendingFlags 
ADD CONSTRAINT Fk_PendingFlags_FlagTypes FOREIGN KEY ( FlagTypeId ) 
REFERENCES FlagTypes( Id ) ;

ALTER TABLE PendingFlags 
ADD CONSTRAINT Fk_PendingFlags_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PendingFlags 
ADD CONSTRAINT Fk_PendingFlags_CloseReasonTypes FOREIGN KEY ( CloseReasonTypeId ) 
REFERENCES CloseReasonTypes( Id ) ;

ALTER TABLE PendingFlags 
ADD CONSTRAINT Fk_PendingFlags_CloseAsOffTopicReasonTypes FOREIGN KEY ( CloseAsOffTopicReasonTypeId ) 
REFERENCES CloseAsOffTopicReasonTypes( Id ) ;

ALTER TABLE ReviewTasks 
ADD CONSTRAINT Fk_ReviewTasks_ReviewTaskTypes FOREIGN KEY ( ReviewTaskTypeId ) 
REFERENCES ReviewTaskTypes( Id ) ;

ALTER TABLE ReviewTasks 
ADD CONSTRAINT Fk_ReviewTasks_ReviewTaskStates FOREIGN KEY ( ReviewTaskStateId ) 
REFERENCES ReviewTaskStates( Id ) ;

ALTER TABLE ReviewTasks 
ADD CONSTRAINT Fk_ReviewTasks_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE ReviewTasks 
ADD CONSTRAINT Fk_ReviewTasks_SuggestedEdits FOREIGN KEY ( SuggestedEditId ) 
REFERENCES SuggestedEdits( Id ) ;

ALTER TABLE ReviewTaskResults 
ADD CONSTRAINT Fk_ReviewTaskResults_ReviewTasks FOREIGN KEY ( ReviewTaskId ) 
REFERENCES ReviewTasks( Id ) ;

ALTER TABLE ReviewTaskResults 
ADD CONSTRAINT Fk_ReviewTaskResults_ReviewTaskResultTypes FOREIGN KEY ( ReviewTaskResultTypeId ) 
REFERENCES ReviewTaskResultTypes( Id ) ;

ALTER TABLE ReviewRejectionReasons 
ADD CONSTRAINT Fk_ReviewRejectionReasons_PostTypes FOREIGN KEY ( PostTypeId ) 
REFERENCES PostTypes( Id ) ;

ALTER TABLE PostNotices 
ADD CONSTRAINT Fk_PostNotices_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PostNotices 
ADD CONSTRAINT Fk_PostNotices_PostNoticeTypes FOREIGN KEY ( PostNoticeTypeId ) 
REFERENCES PostNoticeTypes( Id ) ;

ALTER TABLE PostTags 
ADD CONSTRAINT Fk_PostTags_Posts FOREIGN KEY ( PostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PostTags 
ADD CONSTRAINT Fk_PostTags_Tags FOREIGN KEY ( TagId ) 
REFERENCES Tags( Id ) ;

ALTER TABLE Posts 
ADD CONSTRAINT Fk_Posts_PostTypes FOREIGN KEY ( PostTypeId ) 
REFERENCES PostTypes( Id ) ;

ALTER TABLE PostsWithDeleted 
ADD CONSTRAINT Fk_PostsWithDeleted_Users FOREIGN KEY ( OwnerUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE PostsWithDeleted 
ADD CONSTRAINT Fk_PostsWithDeleted_Users FOREIGN KEY ( LastEditorUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE TagSynonyms 
ADD CONSTRAINT Fk_TagSynonyms_Users FOREIGN KEY ( OwnerUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE TagSynonyms 
ADD CONSTRAINT Fk_TagSynonyms_Users FOREIGN KEY ( ApprovedByUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE SuggestedEdits 
ADD CONSTRAINT Fk_SuggestedEdits_Users FOREIGN KEY ( OwnerUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE SuggestedEditVotes 
ADD CONSTRAINT Fk_SuggestedEditVotes_Users FOREIGN KEY ( TargetUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE CloseAsOffTopicReasonTypes 
ADD CONSTRAINT Fk_CloseAsOffTopicReasonTypes_Users FOREIGN KEY ( CreationModeratorId ) 
REFERENCES Users( Id ) ;

ALTER TABLE CloseAsOffTopicReasonTypes 
ADD CONSTRAINT Fk_CloseAsOffTopicReasonTypes_Users FOREIGN KEY ( ApprovalModeratorId ) 
REFERENCES Users( Id ) ;

ALTER TABLE CloseAsOffTopicReasonTypes 
ADD CONSTRAINT Fk_CloseAsOffTopicReasonTypes_Users FOREIGN KEY ( DeactivationModeratorId ) 
REFERENCES Users( Id ) ;

ALTER TABLE PostNotices 
ADD CONSTRAINT Fk_PostNotices_Users FOREIGN KEY ( OwnerUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE PostNotices 
ADD CONSTRAINT Fk_PostNotices_Users FOREIGN KEY ( DeletionUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE Posts 
ADD CONSTRAINT Fk_Posts_Users FOREIGN KEY ( OwnerUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE Posts 
ADD CONSTRAINT Fk_Posts_Users FOREIGN KEY ( LastEditorUserId ) 
REFERENCES Users( Id ) ;

ALTER TABLE PostsWithDeleted 
ADD CONSTRAINT Fk_PostsWithDeleted_Posts FOREIGN KEY ( AcceptedAnswerId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PostsWithDeleted 
ADD CONSTRAINT Fk_PostsWithDeleted_Posts FOREIGN KEY ( ParentId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PostLinks 
ADD CONSTRAINT Fk_PostLinks_Posts FOREIGN KEY ( RelatedPostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE PendingFlags 
ADD CONSTRAINT Fk_PendingFlags_Posts FOREIGN KEY ( DuplicateOfQuestionId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE Tags 
ADD CONSTRAINT Fk_Tags_Posts FOREIGN KEY ( ExcerptPostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE Tags 
ADD CONSTRAINT Fk_Tags_Posts FOREIGN KEY ( WikiPostId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE Posts 
ADD CONSTRAINT Fk_Posts_Posts FOREIGN KEY ( AcceptedAnswerId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE Posts 
ADD CONSTRAINT Fk_Posts_Posts FOREIGN KEY ( ParentId ) 
REFERENCES Posts( Id ) ;

ALTER TABLE ReviewTaskResults 
ADD CONSTRAINT Fk_ReviewTaskResults_ReviewRejectionReasons FOREIGN KEY ( RejectionReasonId ) 
REFERENCES ReviewRejectionReasons( Id ) ;

ALTER TABLE ReviewTasks 
ADD CONSTRAINT Fk_ReviewTasks_CompletedByReviewTaskId FOREIGN KEY ( CompletedByReviewTaskId ) 
REFERENCES ReviewTaskResults( Id ) ;

ALTER TABLE TagSynonyms 
ADD CONSTRAINT Fk_TagSynonymsSourceTagName_Tags FOREIGN KEY ( SourceTagName ) 
REFERENCES Tags( TagName ) ;
ALTER TABLE TagSynonyms 
ADD CONSTRAINT Fk_TagSynonymsTargetTagName_Tags FOREIGN KEY ( TargetTagName ) 
REFERENCES Tags( TagName ) ;

