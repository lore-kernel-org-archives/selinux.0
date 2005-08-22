Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7MGZcOb020984
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:35:38 -0400 (EDT)
Received: from e4.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7MGOVo5023037
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:24:31 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7MGPaNe000327
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:25:36 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7MGPWRr231510
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:25:32 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7MGPWMo015529
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:25:32 -0400
Received: from sergelap.austin.ibm.com (sig-9-65-117-45.mts.ibm.com [9.65.117.45])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j7MGPWqC015509
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:25:32 -0400
Received: from sergelap.austin.ibm.com (localhost [127.0.0.1])
	by sergelap.austin.ibm.com (8.13.3/8.13.1) with ESMTP id j7MBeGrE025015
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 06:40:16 -0500
Received: (from hallyn@localhost)
	by sergelap.austin.ibm.com (8.13.4/8.13.3/Submit) id j7MBeGp0025014
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 06:40:16 -0500
Date: Mon, 22 Aug 2005 06:40:16 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] add variable initializer
Message-ID: <20050822114016.GA24949@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch fixes a bug found by Coverity:

	It is possible to goto cleanup: before outfile is
	initialized.  At cleanup: we try to close(outfile)
	if it is not NULL.

Index: src/commit_api.c
===================================================================
--- src.orig/commit_api.c
+++ src/commit_api.c
@@ -182,7 +182,7 @@ int semod_expand_sandbox(char *sandbox, 
         char *kernel_filename = NULL;
         sidtab_t sidtab;
         struct policy_file pf;
-        FILE *outfile;
+        FILE *outfile = NULL;
         if (policydb_init (&out, POLICY_KERN) == -1) {
                 write_error (error_buf, error_buf_size, "Out of memory!");
                 retval = -1;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
