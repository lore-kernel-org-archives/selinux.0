Message-Id: <200602062221.k16MLUNq011736@gotham.columbia.tresys.com>
From: "Kevin Carr" <kcarr@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "Chad Hanson" <chanson@TrustedCS.com>,
   "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: [PATCH 1/3] libsepol - fix aliased sensitivities
Date: Mon, 6 Feb 2006 17:21:30 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01E7_01C62B41.C56A8980"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_01E7_01C62B41.C56A8980
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

While testing MLS features in apol we realized a few problems with aliased
sensitivities in libsepol.  This first patch fixes a double free in
sens_destroy().

Kevin Carr
Tresys Technology
410.290.1411 x137


------=_NextPart_000_01E7_01C62B41.C56A8980
Content-Type: application/octet-stream;
	name="aliased-sens-double-free.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="aliased-sens-double-free.patch"

Index: libsepol/src/policydb.c
===================================================================
--- libsepol/src/policydb.c	(revision 427)
+++ libsepol/src/policydb.c	(working copy)
@@ -829,8 +829,10 @@
 	if (key)
 		free(key);
 	levdatum = (level_datum_t *)datum;
-	ebitmap_destroy(&levdatum->level->cat);
-	free(levdatum->level);
+	if (!levdatum->isalias) {
+		ebitmap_destroy(&levdatum->level->cat);
+		free(levdatum->level);
+	}
 	free(datum);
 	return 0;
 }

------=_NextPart_000_01E7_01C62B41.C56A8980--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
