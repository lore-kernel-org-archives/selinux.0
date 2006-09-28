Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8SLbni6031327
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 17:37:49 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8SLaibB001959
	for <selinux@tycho.nsa.gov>; Thu, 28 Sep 2006 21:36:44 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [PATCH] libsemanage: don't destroy the sepol handle if the connection fails
Date: Thu, 28 Sep 2006 17:37:49 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588052619@exchange.columbia.tresys.com>
From: "James Athey" <jathey@tresys.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch removes the call to sepol_handle_destroy() if the connection to the semanage store fails.  Without this patch, if a connection fails for any reason, any later connection attempts on the same semanage handle will dump core.  semanage_handle_create() is responsible for creating the sepol handle, and semanage_handle_destroy() already destroys it.

Index: libsemanage/src/direct_api.c
===================================================================
--- libsemanage/src/direct_api.c        (revision 2032)
+++ libsemanage/src/direct_api.c        (working copy)
@@ -218,7 +218,6 @@

       err:
        ERR(sh, "could not establish direct connection");
-       sepol_handle_destroy(sh->sepolh);
        return STATUS_ERR;
 }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
