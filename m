Subject: [PATCH -policyrep] Drop preservebools support from userland policy
	loader
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 14:53:34 -0400
Message-Id: <1177700014.3357.105.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For the policyrep branch.

This patch drops preservebools support from the userland policy loader,
as it will be provided by the kernel automatically going forward (already in
-git as of today, will be released in 2.6.22).  The patch includes the removal of the
obsoleted sepol_genbools_array interface from libsepol and the removal of 
the preservebools flag from the selinux_mkload_policy() interface in libselinux.
This removes the last remaining manipulation of policy at load time except for
the possible downgrading of policy to the kernel's version if they do not match.

The only case where this will yield a change in behavior is if someone does
a setsebool w/o -P and then reloads policy on a kernel that lacks the new support
for preserving booleans.  As the dominant use of booleans today is as tunables, 
non-persistent boolean changes are rarely used.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libselinux/include/selinux/selinux.h      |   12 +----
 libselinux/src/load_policy.c              |   32 ++-----------
 libselinux/src/selinuxswig.i              |    2 
 libsepol/man/man3/sepol_genbools.3        |   22 ---------
 libsepol/src/genbools.c                   |   71 ------------------------------
 libsepol/src/libsepol.map                 |    2 
 policycoreutils/load_policy/load_policy.c |    2 
 7 files changed, 11 insertions(+), 132 deletions(-)

Index: policyrep/libsepol/src/libsepol.map
===================================================================
--- policyrep/libsepol/src/libsepol.map	(revision 2421)
+++ policyrep/libsepol/src/libsepol.map	(working copy)
@@ -1,7 +1,7 @@
 LIBSEPOL_2.0 {
   global: 
 	sepol_module_package_*; sepol_link_modules; sepol_expand_module; sepol_link_packages;
-	sepol_bool_*; sepol_genbools_array; 
+	sepol_bool_*; 
 	sepol_context_*; sepol_mls_*; sepol_check_context;
 	sepol_iface_*; 
 	sepol_port_*;
Index: policyrep/libsepol/src/genbools.c
===================================================================
--- policyrep/libsepol/src/genbools.c	(revision 2421)
+++ policyrep/libsepol/src/genbools.c	(working copy)
@@ -1,71 +0,0 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <ctype.h>
-#include <errno.h>
-
-#include <sepol/policydb/policydb.h>
-#include <sepol/policydb/conditional.h>
-
-#include "debug.h"
-#include "private.h"
-#include "dso.h"
-
-int sepol_genbools_array(void *data, size_t len, char **names, int *values,
-			 int nel)
-{
-	struct policydb policydb;
-	struct policy_file pf;
-	int rc, i, errors = 0;
-	struct cond_bool_datum *datum;
-
-	/* Create policy database from image */
-	if (policydb_init(&policydb))
-		goto err;
-	if (policydb_from_image(NULL, data, len, &policydb) < 0)
-		goto err;
-
-	for (i = 0; i < nel; i++) {
-		datum = hashtab_search(policydb.p_bools.table, names[i]);
-		if (!datum) {
-			ERR(NULL, "boolean %s no longer in policy", names[i]);
-			errors++;
-			continue;
-		}
-		if (values[i] != 0 && values[i] != 1) {
-			ERR(NULL, "illegal value %d for boolean %s",
-			    values[i], names[i]);
-			errors++;
-			continue;
-		}
-		datum->state = values[i];
-	}
-
-	if (evaluate_conds(&policydb) < 0) {
-		ERR(NULL, "error while re-evaluating conditionals");
-		errno = EINVAL;
-		goto err_destroy;
-	}
-
-	pf.type = PF_USE_MEMORY;
-	pf.data = data;
-	pf.len = len;
-	rc = policydb_write(&policydb, &pf);
-	if (rc) {
-		ERR(NULL, "unable to write binary policy");
-		errno = EINVAL;
-		goto err_destroy;
-	}
-	if (errors) {
-		errno = EINVAL;
-		goto err_destroy;
-	}
-
-	policydb_destroy(&policydb);
-	return 0;
-
-      err_destroy:
-	policydb_destroy(&policydb);
-
-      err:
-	return -1;
-}
Index: policyrep/libsepol/man/man3/sepol_genbools.3
===================================================================
--- policyrep/libsepol/man/man3/sepol_genbools.3	(revision 2421)
+++ policyrep/libsepol/man/man3/sepol_genbools.3	(working copy)
@@ -1,22 +0,0 @@
-.TH "sepol_genbools" "3" "11 August 2004" "sds@epoch.ncsc.mil" "SE Linux binary policy API documentation"
-.SH "NAME"
-sepol_genbools \- Rewrite a binary policy with different boolean settings
-.SH "SYNOPSIS"
-.B #include <sepol/sepol.h>
-.sp
-.BI "int sepol_genbools_array(void *" data ", size_t " len ", char **" names ", int *" values ", int " nel );
-
-.SH "DESCRIPTION"
-.B sepol_genbools_array
-rewrites a binary policy stored in the memory region described by
-(data, len) to use the boolean settings specified in the parallel
-arrays (names, values) with nel elements each. The binary policy is
-rewritten in place in memory.
-
-.SH "RETURN VALUE"
-Returns 0 on success or -1 otherwise, with errno set appropriately.
-An errno of EINVAL indicates that one or more booleans listed in the
-boolean file was undefined in the policy or had an invalid value specified;
-in this case, the binary policy is still rewritten but any invalid
-boolean settings are ignored.
-
Index: policyrep/policycoreutils/load_policy/load_policy.c
===================================================================
--- policyrep/policycoreutils/load_policy/load_policy.c	(revision 2421)
+++ policyrep/policycoreutils/load_policy/load_policy.c	(working copy)
@@ -62,7 +62,7 @@
 			argv[0], argv[optind++]);
 	}
 
-	ret = selinux_mkload_policy(1);
+	ret = selinux_mkload_policy();
 	if (ret < 0) {
 		fprintf(stderr, _("%s:  Can't load policy:  %s\n"),
 			argv[0], strerror(errno));
Index: policyrep/libselinux/include/selinux/selinux.h
===================================================================
--- policyrep/libselinux/include/selinux/selinux.h	(revision 2421)
+++ policyrep/libselinux/include/selinux/selinux.h	(working copy)
@@ -201,16 +201,10 @@
  * This function provides a higher level interface for loading policy
  * than security_load_policy, internally determining the right policy
  * version, locating and opening the policy file, mapping it into memory,
- * manipulating it as needed for current boolean settings and/or local 
- * definitions, and then calling security_load_policy to load it.
- *
- * 'preservebools' is a boolean flag indicating whether current 
- * policy boolean values should be preserved into the new policy (if 1) 
- * or reset to the saved policy settings (if 0).  The former case is the
- * default for policy reloads, while the latter case is an option for policy
- * reloads but is primarily for the initial policy load.
+ * manipulating it as needed to match the kernel's supported version, and 
+ * then calling security_load_policy to load it.
  */
-	extern int selinux_mkload_policy(int preservebools);
+	extern int selinux_mkload_policy(void);
 
 /* 
  * Perform the initial policy load.
Index: policyrep/libselinux/src/load_policy.c
===================================================================
--- policyrep/libselinux/src/load_policy.c	(revision 2421)
+++ policyrep/libselinux/src/load_policy.c	(working copy)
@@ -39,15 +39,15 @@
 
 hidden_def(security_load_policy)
 
-int selinux_mkload_policy(int preservebools)
+int selinux_mkload_policy(void)
 {
 	int vers = sepol_policy_kern_vers_max();
 	int kernvers = security_policyvers();
-	char path[PATH_MAX], **names;
+	char path[PATH_MAX];
 	struct stat sb;
 	size_t size;
 	void *map, *data;
-	int fd, rc = -1, *values, len, i, prot;
+	int fd, rc = -1;
 	sepol_policydb_t *policydb;
 	sepol_policy_file_t *pf;
 
@@ -68,12 +68,8 @@
 	if (fstat(fd, &sb) < 0)
 		goto close;
 
-	prot = PROT_READ;
-	if (preservebools)
-		prot |= PROT_WRITE;
-
 	size = sb.st_size;
-	data = map = mmap(NULL, size, prot, MAP_PRIVATE, fd, 0);
+	data = map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (map == MAP_FAILED)
 		goto close;
 
@@ -105,24 +101,6 @@
 		sepol_policydb_free(policydb);
 	}
 
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
-	}
-
 	rc = security_load_policy(data, size);
 
       unmap:
@@ -244,7 +222,7 @@
 	}
 
 	/* Load the policy. */
-	return selinux_mkload_policy(0);
+	return selinux_mkload_policy();
 
       noload:
 	/*
Index: policyrep/libselinux/src/selinuxswig.i
===================================================================
--- policyrep/libselinux/src/selinuxswig.i	(revision 2421)
+++ policyrep/libselinux/src/selinuxswig.i	(working copy)
@@ -63,7 +63,7 @@
 extern int lsetfilecon(const char *path, security_context_t con);
 extern int fsetfilecon(int fd, security_context_t con);
 extern int getpeercon(int fd, security_context_t *con);
-extern int selinux_mkload_policy(int preservebools);
+extern int selinux_mkload_policy(void);
 extern int selinux_init_load_policy(int *enforce);
 extern int security_set_boolean_list(size_t boolcnt, 
 				     SELboolean *boollist);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
