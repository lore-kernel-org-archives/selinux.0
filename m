Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m16FeNn6016872
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2008 10:40:23 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m16FeLOC022603
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2008 15:40:21 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1) with ESMTP id m16FcvTU019546
	for <selinux@tycho.nsa.gov>; Wed, 6 Feb 2008 10:38:57 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.1/8.14.1/Submit) id m16FcvBr019545
	for selinux@tycho.nsa.gov; Wed, 6 Feb 2008 10:38:57 -0500
Subject: [patch] libselinux:  disable setlocaldefs if no local boolean or
	user files exist
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>,
        "Todd C. Miller" <tmiller@tresys.com>,
        Chad Sellers <csellers@tresys.com>
Content-Type: text/plain
Date: Wed, 06 Feb 2008 10:26:32 -0500
Message-Id: <1202311592.27371.150.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If there are no local boolean or user files present, then the libselinux
load policy logic can disable setlocaldefs early and thus avoid creating
a writable mapping of the policy as well as avoiding the overhead of
calling the sepol functions for manipulating local boolean and user
files altogether.  This is cleaner than changing the default for the
config option, as it will fall back to compatibility behavior for older
distributions.  Thus, this change should not change behavior for RHEL 4.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libselinux/src/load_policy.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

Index: trunk/libselinux/src/load_policy.c
===================================================================
--- trunk/libselinux/src/load_policy.c	(revision 2790)
+++ trunk/libselinux/src/load_policy.c	(working copy)
@@ -47,6 +47,7 @@
 {	
 	int kernvers = security_policyvers();
 	int vers = kernvers, minvers = DEFAULT_POLICY_VERSION;
+	int setlocaldefs = load_setlocaldefs;
 	char path[PATH_MAX], **names;
 	struct stat sb;
 	struct utsname uts;
@@ -131,13 +132,29 @@
 		minvers = vers_min();
 	}
 
+	/*
+	 * Check whether we need to support local boolean and user definitions.
+	 */
+	if (setlocaldefs) {
+		if (access(selinux_booleans_path(), F_OK) == 0)
+			goto checkbool;
+		snprintf(path, sizeof path, "%s.local", selinux_booleans_path());
+		if (access(path, F_OK) == 0)
+			goto checkbool;
+		snprintf(path, sizeof path, "%s/local.users", selinux_users_path());
+		if (access(path, F_OK) == 0)
+			goto checkbool;
+		/* No local definition files, so disable setlocaldefs. */
+		setlocaldefs = 0;
+	}
 
+checkbool:
 	/* 
 	 * As of Linux 2.6.22, the kernel preserves boolean
 	 * values across a reload, so we do not need to 
 	 * preserve them in userspace.
 	 */
-	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.22") >= 0)
+	if (preservebools && uname(&uts) == 0 && strverscmp(uts.release, "2.6.22") >= 0)
 		preservebools = 0;
 
       search:
@@ -158,7 +175,7 @@
 		goto close;
 
 	prot = PROT_READ;
-	if (load_setlocaldefs || preservebools)
+	if (setlocaldefs || preservebools)
 		prot |= PROT_WRITE;
 
 	size = sb.st_size;
@@ -195,7 +212,7 @@
 	}
 
 	if (usesepol) {
-		if (load_setlocaldefs) {
+		if (setlocaldefs) {
 			void *olddata = data;
 			size_t oldsize = size;
 			rc = genusers(olddata, oldsize, selinux_users_path(),
@@ -228,7 +245,7 @@
 					free(names[i]);
 				free(names);
 			}
-		} else if (load_setlocaldefs) {
+		} else if (setlocaldefs) {
 			(void)genbools(data, size,
 				       (char *)selinux_booleans_path());
 		}

-- 
Stephen Smalley
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
