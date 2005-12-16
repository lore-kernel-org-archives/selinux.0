Subject: [patch] libsepol:  bug fix for mls_range_cpy, affects MLS-enabled
	policies
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Chad Hanson <chanson@TrustedCS.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/mixed; boundary="=-Jhi4ciGHOPYH805yeQLr"
Date: Fri, 16 Dec 2005 08:46:51 -0500
Message-Id: <1134740811.3421.489.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Jhi4ciGHOPYH805yeQLr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Dan reported a problem with audit2why reporting that an avc denial under
MLS policy (due to a MLS constraint) should have been allowed, and in
looking into it, I discovered a bug in mls_range_cpy that was causing
the high level of MLS ranges to be replaced with the low level upon
context copies, thereby causing ranged contexts to become single-level.
This also affects checkpolicy.  Patch for libsepol is below.  In
addition to rebuilding libsepol, you need to rebuild users of the static
libsepol (i.e. checkpolicy and audit2why) with the new libsepol and then
rebuild any MLS-enabled policies (or at least any with ranged contexts
in them) with the new checkpolicy.

-- 
Stephen Smalley
National Security Agency

--=-Jhi4ciGHOPYH805yeQLr
Content-Disposition: attachment; filename=libsepol-rangefix.patch
Content-Type: text/x-patch; name=libsepol-rangefix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libsepol/include/sepol/policydb/mls_types.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/policydb/mls_types.h,v
retrieving revision 1.3
diff -u -p -r1.3 mls_types.h
--- libsepol/include/sepol/policydb/mls_types.h	4 Nov 2005 16:12:15 -0000	1.3
+++ libsepol/include/sepol/policydb/mls_types.h	15 Dec 2005 19:41:56 -0000
@@ -99,7 +99,7 @@ static inline int mls_range_cpy(
 	if (mls_level_cpy(&dst->level[0], &src->level[0]) < 0)
 		goto err;
 
-	if (mls_level_cpy(&dst->level[1], &src->level[0]) < 0)
+	if (mls_level_cpy(&dst->level[1], &src->level[1]) < 0)
 		goto err_destroy;
 
 	return 0;

--=-Jhi4ciGHOPYH805yeQLr--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
