Subject: [PATCH 1/6] libselinux:  Drop setlocaldefs support from policy
	loading code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
References: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 09:45:56 -0400
Message-Id: <1177595156.24282.325.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Drop the setlocaldefs support from the policy loading code.
setlocaldefs (patching local user definitions and boolean settings
into the in-memory policy at load time) is obsoleted by libsemanage and
managed policy.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libselinux/src/load_policy.c      |   23 +----------------------
 libselinux/src/selinux_config.c   |    5 -----
 libselinux/src/selinux_internal.h |    1 -
 3 files changed, 1 insertion(+), 28 deletions(-)

Index: policyrep/libselinux/src/selinux_internal.h
===================================================================
--- policyrep/libselinux/src/selinux_internal.h	(revision 2382)
+++ policyrep/libselinux/src/selinux_internal.h	(working copy)
@@ -79,6 +77,5 @@
 hidden_proto(security_get_initial_context);
 hidden_proto(security_get_initial_context_raw);
 
-extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
 extern int selinux_page_size hidden;
Index: policyrep/libselinux/src/selinux_config.c
===================================================================
--- policyrep/libselinux/src/selinux_config.c	(revision 2382)
+++ policyrep/libselinux/src/selinux_config.c	(working copy)
@@ -15,7 +15,6 @@
 #define SELINUXDEFAULT "targeted"
 #define SELINUXTYPETAG "SELINUXTYPE="
 #define SELINUXTAG "SELINUX="
-#define SETLOCALDEFS "SETLOCALDEFS="
 #define REQUIRESEUSERS "REQUIRESEUSERS="
 
 /* Indices for file paths arrays. */
@@ -165,10 +162,6 @@
 					end--;
 				}
 				continue;
-			} else if (!strncmp(buf_p, SETLOCALDEFS,
-					    sizeof(SETLOCALDEFS) - 1)) {
-				value = buf_p + sizeof(SETLOCALDEFS) - 1;
-				intptr = &load_setlocaldefs;
 			} else if (!strncmp(buf_p, REQUIRESEUSERS,
 					    sizeof(REQUIRESEUSERS) - 1)) {
 				value = buf_p + sizeof(REQUIRESEUSERS) - 1;
Index: policyrep/libselinux/src/load_policy.c
===================================================================
--- policyrep/libselinux/src/load_policy.c	(revision 2382)
+++ policyrep/libselinux/src/load_policy.c	(working copy)
@@ -39,8 +39,6 @@
 
 hidden_def(security_load_policy)
 
-int load_setlocaldefs hidden = 1;
-
 int selinux_mkload_policy(int preservebools)
 {
 	int vers = sepol_policy_kern_vers_max();
@@ -71,7 +69,7 @@
 		goto close;
 
 	prot = PROT_READ;
-	if (load_setlocaldefs || preservebools)
+	if (preservebools)
 		prot |= PROT_WRITE;
 
 	size = sb.st_size;
@@ -107,22 +105,6 @@
 		sepol_policydb_free(policydb);
 	}
 
-	if (load_setlocaldefs) {
-		void *olddata = data;
-		size_t oldsize = size;
-		rc = sepol_genusers(olddata, oldsize, selinux_users_path(),
-				    &data, &size);
-		if (rc < 0) {
-			/* Fall back to the prior image if genusers failed. */
-			data = olddata;
-			size = oldsize;
-			rc = 0;
-		} else {
-			if (olddata != map)
-				free(olddata);
-		}
-	}
-
 	if (preservebools) {
 		rc = security_get_boolean_names(&names, &len);
 		if (!rc) {
@@ -139,9 +121,6 @@
 				free(names[i]);
 			free(names);
 		}
-	} else if (load_setlocaldefs) {
-		(void)sepol_genbools(data, size,
-				     (char *)selinux_booleans_path());
 	}
 
 	rc = security_load_policy(data, size);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
