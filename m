Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27388
	for <selinux@tycho.nsa.gov>; Sat, 4 Jan 2003 11:10:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA16688
	for <selinux@tycho.nsa.gov>; Sat, 4 Jan 2003 00:20:46 GMT
Received: from server.westcam.com (rrcs-sw-24-242-155-198.biz.rr.com [24.242.155.198])
	by jazzswing.ncsc.mil  with ESMTP id AAA16682
	for <selinux@tycho.nsa.gov>; Sat, 4 Jan 2003 00:20:45 GMT
Subject: Policy Language
Date: Fri, 3 Jan 2003 13:37:57 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Message-ID: <862636C39A8D56448223B94D19757133015EB6@server.westcam.com>
From: "Mark Westerman" <mark.westerman@westcam.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In working toward a policy management system I have run across a few
ambiguities in the language.

1. class rule

av_perms_def     : CLASS identifier '{' identifier_list '}'
                   {if (define_av_perms(FALSE)) return -1;}
                 | CLASS identifier INHERITS identifier
                   {if (define_av_perms(TRUE)) return -1;}
                 | CLASS identifier INHERITS identifier '{'identifier_list '}'
and 

class_def        : CLASS identifier
                     {if (define_class()) return -1;}
                 ;

coudl the class_def be defined as

class_def        : CLASSDEF identifier
                     {if (define_class()) return -1;}
                 ;
2. sid

initial_sid_def  : SID identifier
                    {if (define_initial_sid()) return -1;}
                 ;
and 

initial_sid_context_def  : SID identifier security_context_def
                         {if (define_initial_sid_context()) return -1;}
                         ;

Could the initial_sid_context_def be defined as

initial_sid_context_def  : SIDCONTEXT identifier security_context_def
                         {if (define_initial_sid_context()) return -1;}
                         ;

3. allow

allow_def        : ALLOW names names ':' names names  ';'
                    {if (define_te_avtab(AVTAB_ALLOWED)) return -1; }
                 ; 
and

role_allow_def   : ALLOW names names ';'
                    {if (define_role_allow()) return -1; }
                 ;
could the role_allow_def be defined as 

role_allow_def   : ROLEALLOW names names ';'
                    {if (define_role_allow()) return -1; }
                 ;

The changes would make development of a policy management system
a lot easer. The rules would still be order dependent in the
policy.conf, but it would remove the ambiguities of the rules and 
not make it order dependent in a general parse.y file. Such that 
above rule would not need special cases in order to build a policy.conf
file.


Mark


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
