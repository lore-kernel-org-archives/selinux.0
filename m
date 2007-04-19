Subject: [PATCH -trunk][RFC] libselinux: drop setlocaldefs and
	preservebools support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 14:20:19 -0400
Message-Id: <1177006819.27654.174.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This an RFC only, not for merging yet.  It naturally depends on the kernel patch
for preserving booleans atomically, and it also likely requires a bump in the .so version.
But you need it to test the kernel support without interference from libselinux.

---

Drop setlocaldefs and preservebools support from the policy loading
code in libselinux on the trunk.

setlocaldefs (patching local user definitions and boolean settings
into the in-memory policy at load time) is obsoleted by libsemanage and
managed policy.

preservebools (preserving boolean values across a policy reload rather
than resetting to the policy defaults) will be handled by the kernel
going forward.

---

 libselinux/src/load_policy.c      |   47 +-------------------------------------
 libselinux/src/selinux_config.c   |    5 ----
 libselinux/src/selinux_internal.h |    1 
 3 files changed, 2 insertions(+), 51 deletions(-)

Index: policyrep/libselinux/src/selinux_config.c
===================================================================
--- policyrep/libselinux/src/selinux_config.c	(revision 2357)
+++ policyrep/libselinux/src/selinux_config.c	(working copy)
@@ -15,7 +15,6 @@
 #define SELINUXDEFAULT "targeted"
 #define SELINUXTYPETAG "SELINUXTYPE="
 #define SELINUXTAG "SELINUX="
-#define SETLOCALDEFS "SETLOCALDEFS="
 #define REQUIRESEUSERS "REQUIRESEUSERS="
 
 /* Indices for file paths arrays. */
@@ -165,10 +164,6 @@
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
--- policyrep/libselinux/src/load_policy.c	(revision 2357)
+++ policyrep/libselinux/src/load_policy.c	(working copy)
@@ -39,8 +39,6 @@
 
 hidden_def(security_load_policy)
 
-int load_setlocaldefs hidden = 1;
-
 int selinux_mkload_policy(int preservebools)
 {
 	int vers = sepol_policy_kern_vers_max();
@@ -49,7 +47,7 @@
 	struct stat sb;
 	size_t size;
 	void *map, *data;
-	int fd, rc = -1, *values, len, i, prot;
+	int fd, rc = -1, *values, len, i;
 	sepol_policydb_t *policydb;
 	sepol_policy_file_t *pf;
 
@@ -70,12 +68,8 @@
 	if (fstat(fd, &sb) < 0)
 		goto close;
 
-	prot = PROT_READ;
-	if (load_setlocaldefs || preservebools)
-		prot |= PROT_WRITE;
-
 	size = sb.st_size;
-	data = map = mmap(NULL, size, prot, MAP_PRIVATE, fd, 0);
+	data = map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (map == MAP_FAILED)
 		goto close;
 
@@ -107,43 +101,6 @@
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
-	if (preservebools) {
-		rc = security_get_boolean_names(&names, &len);
-		if (!rc) {
-			values = malloc(sizeof(int) * len);
-			if (!values)
-				goto unmap;
-			for (i = 0; i < len; i++)
-				values[i] =
-				    security_get_boolean_active(names[i]);
-			(void)sepol_genbools_array(data, size, names, values,
-						   len);
-			free(values);
-			for (i = 0; i < len; i++)
-				free(names[i]);
-			free(names);
-		}
-	} else if (load_setlocaldefs) {
-		(void)sepol_genbools(data, size,
-				     (char *)selinux_booleans_path());
-	}
-
 	rc = security_load_policy(data, size);
 
       unmap:
Index: policyrep/libselinux/src/selinux_internal.h
===================================================================
--- policyrep/libselinux/src/selinux_internal.h	(revision 2357)
+++ policyrep/libselinux/src/selinux_internal.h	(working copy)
@@ -79,6 +79,5 @@
 hidden_proto(security_get_initial_context);
 hidden_proto(security_get_initial_context_raw);
 
-extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
 extern int selinux_page_size hidden;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
