Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7IIB7Ob000387
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 14:11:08 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7II0gsQ022967
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 18:00:43 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j7II1tq6032571
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 14:01:55 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j7II1tNS032570
	for selinux@tycho.nsa.gov; Thu, 18 Aug 2005 14:01:55 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7IHYmOb000079
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:34:49 -0400 (EDT)
Received: from e3.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7IHPR4R001582
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 17:25:27 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7IHPSWT011006
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:25:28 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7IHPRIc205458
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:25:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7IHPRsU017912
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:25:27 -0400
Received: from serge.austin.ibm.com (sig-9-65-101-195.mts.ibm.com [9.65.101.195])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j7IHPR2d017899
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:25:27 -0400
Received: from serge.austin.ibm.com (localhost [127.0.0.1])
	by serge.austin.ibm.com (8.13.3/8.13.3) with ESMTP id j7IILdsD007659
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 13:21:40 -0500
Received: (from hallyn@localhost)
	by serge.austin.ibm.com (8.13.4/8.13.3/Submit) id j7IILdGV007658
	for selinux@tycho.nsa.gov; Thu, 18 Aug 2005 13:21:39 -0500
Date: Thu, 18 Aug 2005 13:21:39 -0500
From: hallyn@serge.ibm.com
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] libsepol: potential error_msg resource leak
Message-ID: <20050818182139.GB7622@serge.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch addresses a potential bug found by Coverity:

	I'm not sure whether this condition is possible or not, but
	judging by the logic it should be.  The 'error_msg' is created
	by expand_terule_helper if 'conflict' is true, but an erorr is
	then only returned if both 'conflict' and 'cond' are non-NULL.

Index: src/expand.c
===================================================================
--- src.orig/expand.c
+++ src/expand.c
@@ -429,6 +429,7 @@ static int alias_copy_callback(hashtab_k
         new_alias = (type_datum_t *) malloc(sizeof(type_datum_t));
         if (!new_alias) {
                 write_error (state, "Out of memory!");
+		free(new_id);
                 return -ENOMEM;
         }
         memset(new_alias, 0, sizeof(type_datum_t));
@@ -1194,9 +1195,16 @@ static int cond_avrule_list_copy(policyd
 			}
 			return -1;
 		}
+
+		if (error_msg) {
+			write_error (state, "%s", error_msg);
+			free(error_msg);
+			error_msg = NULL;
+		}
+
 		cur = cur->next;
 	}
-	
+
 	return 0;
 }
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
