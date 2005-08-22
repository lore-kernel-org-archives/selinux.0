Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7MGt4Ob021256
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:55:05 -0400 (EDT)
Received: from e3.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7MGj2uD029356
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 16:45:02 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7MGij66009263
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:44:49 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7MGijPr244696
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:44:45 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7MGijRB017340
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:44:45 -0400
Received: from sergelap.austin.ibm.com (sig-9-65-117-45.mts.ibm.com [9.65.117.45])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j7MGijOS017337
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 12:44:45 -0400
Received: from sergelap.austin.ibm.com (localhost [127.0.0.1])
	by sergelap.austin.ibm.com (8.13.3/8.13.1) with ESMTP id j7MBxTAA025438
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 06:59:30 -0500
Received: (from hallyn@localhost)
	by sergelap.austin.ibm.com (8.13.4/8.13.3/Submit) id j7MBxTBP025437
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 06:59:29 -0500
Date: Mon, 22 Aug 2005 06:59:29 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] policycoreutils: needless check
Message-ID: <20050822115929.GA25231@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following patch removes a needless check found by Coverity.

The only way we jump to bad: is long after p->policy has been calloc'ed
(in sepol_module_package_init()), so the check for (p->policy) is not
necessary.

thanks,
-serge

Index: semodule_link/semodule_link.c
===================================================================
--- semodule_link.orig/semodule_link.c
+++ semodule_link/semodule_link.c
@@ -70,9 +70,7 @@ static sepol_module_package_t *load_modu
 
 	return p;
 bad:
-	if (p->policy) {
-		policydb_destroy(p->policy);
-	}
+	policydb_destroy(p->policy);
 	if (p->file_contexts)
 		free(p->file_contexts);
 	return NULL;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
