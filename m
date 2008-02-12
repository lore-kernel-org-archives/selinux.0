Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1CKxwsA001792
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 15:59:58 -0500
Received: from cadmus.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1CKxtr8029648
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 20:59:56 GMT
Received: from cadmus.columbia.tresys.com (localhost.localdomain [127.0.0.1])
	by cadmus.columbia.tresys.com (8.14.1/8.14.1) with ESMTP id m1CKx4nR001959
	for <selinux@tycho.nsa.gov>; Tue, 12 Feb 2008 15:59:05 -0500
Received: (from tmiller@localhost)
	by cadmus.columbia.tresys.com (8.14.1/8.14.1/Submit) id m1CKx3ea001958
	for selinux@tycho.nsa.gov; Tue, 12 Feb 2008 15:59:03 -0500
Date: Tue, 12 Feb 2008 15:59:03 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200802122059.m1CKx3ea001958@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: PATCH: libsepol use correct pointer type in sizeof()
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This looks to be a cut & pasto from the chunk above it.  It won't change
the code generated since sizeof(foo *) == sizeof(bar *) but it should
probably be fixed anyway.

Signed-off-by: Todd C. Miller <tmiller@tresys.com>

Index: trunk/libsepol/src/users.c
===================================================================
--- trunk/libsepol/src/users.c	(revision 2802)
+++ trunk/libsepol/src/users.c	(working copy)
@@ -237,7 +237,7 @@
 
 		tmp_ptr = realloc(policydb->sym_val_to_name[SYM_USERS],
 				  (policydb->p_users.nprim +
-				   1) * sizeof(user_datum_t *));
+				   1) * sizeof(char *));
 		if (!tmp_ptr)
 			goto omem;
 		policydb->sym_val_to_name[SYM_USERS] = tmp_ptr;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
