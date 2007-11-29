Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lATM3QJC022439
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2007 17:03:27 -0500
Received: from cadmus.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lATM3Paw021578
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2007 22:03:26 GMT
Received: from cadmus.columbia.tresys.com (localhost.localdomain [127.0.0.1])
	by cadmus.columbia.tresys.com (8.14.1/8.14.1) with ESMTP id lATM3Por024991
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2007 17:03:25 -0500
Received: (from tmiller@localhost)
	by cadmus.columbia.tresys.com (8.14.1/8.14.1/Submit) id lATM3PBv024990
	for selinux@tycho.nsa.gov; Thu, 29 Nov 2007 17:03:25 -0500
Date: Thu, 29 Nov 2007 17:03:25 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200711292203.lATM3PBv024990@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: PATCH: print module magic in hex, not decimal on mismatch
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Print the module magic number in hex, not decimal if there is a mismatch,
just like we do for policydb magic number.  Since the magic defines are
in hex the output should be as well for easier debugging.

Signed-off-by: Todd C. Miller <tmiller@tresys.com>

--

Index: trunk/libsepol/src/module.c
===================================================================
--- trunk/libsepol/src/module.c	(revision 2690)
+++ trunk/libsepol/src/module.c	(working copy)
@@ -371,7 +371,7 @@
 	}
 	if (le32_to_cpu(buf[0]) != SEPOL_MODULE_PACKAGE_MAGIC) {
 		ERR(file->handle,
-		    "wrong magic number for module package:  expected %u, got %u",
+		    "wrong magic number for module package:  expected %#08x, got %#08x",
 		    SEPOL_MODULE_PACKAGE_MAGIC, le32_to_cpu(buf[0]));
 		goto err;
 	}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
