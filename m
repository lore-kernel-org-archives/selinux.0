Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA03656
	for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2003 10:24:11 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA29459
	for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2003 15:21:30 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id PAA29455
	for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2003 15:21:29 GMT
Message-Id: <200301061529.KAA12081@moss-shockers.ncsc.mil>
Date: Mon, 6 Jan 2003 10:29:26 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Policy Language
To: selinux@tycho.nsa.gov, mark.westerman@westcam.com
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY=Covey_of_Partridges_899_000
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Covey_of_Partridges_899_000
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: NMNg20gzLVvyGR9CwESM+w==


> In working toward a policy management system I have run across a few
> ambiguities in the language.

The grammar in policy_parse.y is unambiguous.  For that matter, the attached 
grammar for the constructs that you mentioned is unambiguous, even with a 
completely free form statement list.  There are no conflicts.  What precisely is 
the problem?

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

--Covey_of_Partridges_899_000
Content-Type: TEXT/plain; name="foo.y"; charset=us-ascii; x-unix-mode=0644
Content-Description: foo.y
Content-MD5: aIZkcGOLQG59KWO3SRn+GA==

%token CLASS
%token INHERITS
%token IDENTIFIER
%token SID
%token ALLOW

%%
statement_list          : statement | statement_list statement
                        ;
statement               : av_perms_def |
                          class_def |
                          initial_sid_def |
                          initial_sid_context_def |
                          allow_def |
                          role_allow_def
                        ;
av_perms_def		: CLASS identifier '{' identifier_list '}'
                        | CLASS identifier INHERITS identifier 
                        | CLASS identifier INHERITS identifier '{' identifier_list '}'
			;
identifier_list		: identifier
			| identifier_list identifier
			;
identifier		: IDENTIFIER
			;
class_def		: CLASS identifier
			;
initial_sid_def         : SID identifier
                        ;
initial_sid_context_def : SID identifier security_context_def
                        ;
security_context_def	: identifier ':' identifier ':' identifier 
	                ;
allow_def               : ALLOW names names ':' names names ';'
                        ;
role_allow_def          : ALLOW names names ';'
                        ;
names           	: identifier
			| nested_id_set
			;
nested_id_set           : '{' nested_id_list '}'
                        ;
nested_id_list          : nested_id_element | nested_id_list nested_id_element
                        ;
nested_id_element       : identifier | nested_id_set
                        ;
%%

--Covey_of_Partridges_899_000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
