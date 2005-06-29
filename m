Message-ID: <42C3023F.4070907@redhat.com>
Date: Wed, 29 Jun 2005 16:19:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: libsepol patch to fix error message
Content-Type: multipart/mixed;
 boundary="------------030606020605040707080107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030606020605040707080107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 



--------------030606020605040707080107
Content-Type: text/x-patch;
 name="libsepol-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsepol/src/genbools.c libsepol-1.5.9/src/genbools.c
--- nsalibsepol/src/genbools.c	2005-05-17 08:07:47.000000000 -0400
+++ libsepol-1.5.9/src/genbools.c	2005-05-26 10:54:03.000000000 -0400
@@ -194,7 +194,7 @@
 	for (i = 0; i < nel; i++) {
 		datum = hashtab_search(policydb.p_bools.table, names[i]);
 		if (!datum) {
-			__sepol_debug_printf("%s:  unknown boolean %s\n", 
+			__sepol_debug_printf("%s:  boolean %s no longer in policy\n", 
 					     __FUNCTION__, names[i]);
 			errors++;
 			continue;

--------------030606020605040707080107--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
