Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7MLGTOb023559
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 17:16:30 -0400 (EDT)
Received: from e31.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7ML6OuD002799
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 21:06:24 GMT
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j7ML6GF3195592
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 17:06:16 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7ML5kcX352284
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 15:05:46 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j7ML6FAK007641
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 15:06:15 -0600
Received: from sergelap.austin.ibm.com (sig-9-65-117-45.mts.ibm.com [9.65.117.45])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id j7ML6FkS007594
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 15:06:15 -0600
Received: from sergelap.austin.ibm.com (localhost [127.0.0.1])
	by sergelap.austin.ibm.com (8.13.3/8.13.1) with ESMTP id j7MGKx0T005106
	for <selinux@tycho.nsa.gov>; Mon, 22 Aug 2005 11:20:59 -0500
Received: (from hallyn@localhost)
	by sergelap.austin.ibm.com (8.13.4/8.13.3/Submit) id j7MGKxLw005105
	for selinux@tycho.nsa.gov; Mon, 22 Aug 2005 11:20:59 -0500
Date: Mon, 22 Aug 2005 11:20:59 -0500
From: serue@us.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 6/6] libsepol: resource leak in avrule_decl_create
Message-ID: <20050822162059.GF4191@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch fixes a resource leak found by Coverity:

	avrule_decl_destroy(decl) does not free decl itself.
	Must do so manually on after avrule_decl_destroy().

thanks,
-serge

Index: src/avrule_block.c
===================================================================
--- src.orig/avrule_block.c
+++ src/avrule_block.c
@@ -49,6 +49,7 @@ avrule_decl_t *avrule_decl_create(uint32
         for (i = 0; i < SYM_NUM; i++) {
                 if (symtab_init(&decl->symtab[i], symtab_sizes[i])) {
                         avrule_decl_destroy(decl);
+                        free(decl);
                         return NULL;
                 }
         }

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
