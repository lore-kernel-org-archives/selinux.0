Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k26Lfhp2012847
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 16:41:43 -0500
Received: from e31.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k26LeAJj006283
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 21:40:10 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k26LffK5024642
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 16:41:41 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k26LiUSr161706
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 14:44:30 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k26LffGB015141
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 14:41:41 -0700
Received: from sergelap.hallyn.com (sig-9-65-85-1.mts.ibm.com [9.65.85.1])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id k26Lfe9e015077
	for <selinux@tycho.nsa.gov>; Mon, 6 Mar 2006 14:41:41 -0700
Date: Mon, 6 Mar 2006 15:41:39 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: libsepol/src/conditional.c:cond_evaluate_expr()
Message-ID: <20060306214139.GA7960@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

just doing a quick update static analysis scan of the nsa/selinux-usr
sources.  Most of the output in libsepol seems like the same false
positives it used to get, but I'm worried about cond_evaluate_expr.

It is supposed to return -1 on error, but as is, if the second arg
(expr) is passed in NULL, the value returned is truly undefined -
it is just taken off the stack.

Patch appended, in case this is deemed to really be a danger.

thanks,
-serge

Index: libsepol/src/conditional.c
===================================================================
--- libsepol.orig/src/conditional.c	2005-10-13 12:06:06.000000000 -0500
+++ libsepol/src/conditional.c	2006-03-06 15:40:16.000000000 -0600
@@ -191,6 +191,8 @@ int cond_evaluate_expr(policydb_t *p, co
 	int s[COND_EXPR_MAXDEPTH];
 	int sp = -1;
 
+	s[0] = -1;
+
 	for (cur = expr; cur != NULL; cur = cur->next) {
 		switch (cur->expr_type) {
 		case COND_BOOL:

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
