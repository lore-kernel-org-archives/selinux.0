Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7MGcfOb021018
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:38:41 -0400 (EDT)
Received: from e6.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7MGRYo5023237
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:27:34 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e6.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7MGSV46016824
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:28:31 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7MGS2cX021238
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 10:28:02 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j7MGSVYI028793
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 10:28:31 -0600
Received: from sergelap.austin.ibm.com (sig-9-65-117-45.mts.ibm.com [9.65.117.45])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j7MGSUVh028777
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 10:28:30 -0600
Received: from sergelap.austin.ibm.com (localhost [127.0.0.1])
	by sergelap.austin.ibm.com (8.13.3/8.13.1) with ESMTP id j7MBhEit025060
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 06:43:15 -0500
Received: (from hallyn@localhost)
	by sergelap.austin.ibm.com (8.13.4/8.13.3/Submit) id j7MBhEWe025059
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 06:43:14 -0500
Date: Mon, 22 Aug 2005 06:43:14 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] libsemanage: fix apparent typo
Message-ID: <20050822114314.GB24949@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a bug found by Coverity in libsemanage:

	Seems to be a typo: arg instead of targ.  In every other
	case in this switch, we do

		if ((targ = fn()) == NULL) {
			goto cleanup;
		}  else {
			arg = targ;
		}

	Except in the default case it was:

		if ((arg = fn()) == NULL) {
			goto cleanup;
		}  else {
			arg = targ;
		}

Index: src/commit_api.c
===================================================================
--- src.orig/commit_api.c
+++ src/commit_api.c
@@ -637,7 +637,7 @@ static char **split_args (char *arg0, ch
                                 break;
                         }
                         default: {
-                                if ((arg = append (arg, *s)) == NULL) {
+                                if ((targ = append (arg, *s)) == NULL) {
                                         goto cleanup;
                                 }
                                 else {

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
