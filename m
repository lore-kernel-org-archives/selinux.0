Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8DIicrT005088
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 14:44:38 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8DIhhHC000997
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 18:43:43 GMT
Subject: Re: checkpolicy-1.16 multiple compile job fix
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1094857561.6513.66.camel@gorn.pebenito.net>
References: <1094857561.6513.66.camel@gorn.pebenito.net>
Content-Type: text/plain
Message-Id: <1095100956.22460.54.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 13 Sep 2004 14:42:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-09-10 at 19:06, Chris PeBenito wrote:
> Here is a patch for the checkpolicy Makefile to fix a compile problem
> with multiple compile jobs (make -j*).
> 
> One of the errors that was happening was:
> 
> policy_scan.l: In function `yylex':
> policy_scan.l:48: error: `CLONE' undeclared (first use in this function)
> policy_scan.l:48: error: (Each undeclared identifier is reported only
> once
> policy_scan.l:48: error: for each function it appears in.)
> policy_scan.l:50: error: `COMMON' undeclared (first use in this
> function)
> [many more undeclared]
> 
> 
> Another was:
> policy_scan.l:23:19: y.tab.h: No such file or directory
> make: *** [lex.yy.o] Error 1
> make: *** Waiting for unfinished jobs....

Possibly the diff below instead.

Index: checkpolicy/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/Makefile,v
retrieving revision 1.22
diff -u -r1.22 Makefile
--- checkpolicy/Makefile	13 Aug 2004 15:09:25 -0000	1.22
+++ checkpolicy/Makefile	13 Sep 2004 18:37:04 -0000
@@ -48,13 +48,13 @@
 y.tab.c: policy_parse.y
 	$(YACC) -d policy_parse.y
 
-lex.yy.c: policy_scan.l
+lex.yy.c: policy_scan.l y.tab.h
 	$(LEX) policy_scan.l
 
 users.tab.c: users.y
 	$(YACC) -d -o $@ $<
 
-lex.users.c: users.l
+lex.users.c: users.l users.tab.h 
 	$(LEX) -o$@ $<
 
 install: all

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
