Subject: Re: [PATCH] SELinux - canonicalize getxattr() (fwd)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: SELinux-dev@tresys.com, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@namei.org>
In-Reply-To: <Pine.LNX.4.63.0509141014520.7898@excalibur.intercode>
References: <Pine.LNX.4.63.0509141014520.7898@excalibur.intercode>
Content-Type: multipart/mixed; boundary="=-jMniia/AtwzZSECRZy0M"
Date: Thu, 27 Oct 2005 15:03:06 -0400
Message-Id: <1130439786.18805.322.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-jMniia/AtwzZSECRZy0M
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-09-14 at 10:15 -0400, James Morris wrote:
> This patch allows SELinux to canonicalize the value returned from 
> getxattr() via  the security_inode_getsecurity() hook, which is called 
> after the fs level getxattr() function.
> 
> The purpose of this is to allow the in-core security context for an inode 
> to override the on-disk value.  This could happen in cases such as 
> upgrading a system to a different labeling form (e.g. standard SELinux to 
> MLS) without needing to do a full relabel of the filesystem.
> 
> In such cases, we want getxattr() to return the canonical security context 
> that the kernel is using rather than what is stored on disk.

Hi,

An issue has arisen with regard to the canonicalization of getxattr
results and the use of type aliases in targeted policy; some private
discussion has occurred, but I'm taking discussion to the list as a
follow-up to the message where the canonicalization patch was posted to
the list.  

The bugzilla report is at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=171846

Targeted policy presently defines a number of type aliases to provide
compatibility and allow sharing with strict policy, both in the policy
itself (macros, .te and .fc files) and in the on-disk xattrs.  Since
setxattr does not canonicalize the attributes, the alias is stored on
disk, so for example, .so files are labeled as shlib_t even though
targeted policy aliases this to lib_t.  This is advantageous for policy
sharing and for conversion between policies.  It also seems important
for allowing shared policy modules; by using the more specific names in
the module, the module should be able to be used on either targeted or
strict.

Prior to the patch to canonicalize getxattr results, getxattr would
return the on-disk xattr value, so it would also show the alias name.
With the canonicalization patch, it instead shows the primary name.
This creates confusion for programs like setfiles and restorecon that
compare the context obtained via matchpathcon with the context obtained
via getfilecon to determine whether the file needs to be relabeled,
yielding repeated messages about mislabeled files despite the files
actually being labeled correctly.  restorecon -Rv /lib on a rawhide
targeted system illustrates the point.

The canonicalization of getxattr results is desirable, but we do need to
address the problem above.  I've created experimental patches for
libsepol and libselinux to allow matchpathcon_init to canonicalize
contexts from file contexts against a policy (attached), although I
think it would be better to do this via a selinuxfs interface rather
than via sepol, as the latter requires reading of a binary policy.

However, regardless of how it is implemented, this change to
matchpathcon_init has another side effect:  rpm will then label files
with the primary names rather than the alias names, so subsequent
conversion of the system to a different policy where they were distinct
types will be more difficult (essentially requires permissive mode boot
and relabel, as .so files may not be executable under the new policy).
Not sure whether that is a real concern.

This change also doesn't address the issue in general, only for users of
matchpathcon.  If we implement it via selinuxfs, it would be feasible to
apply the canonicalization on all context translations, although even
that might be expensive.  With the current policy-based
canonicalization, it is definitely too expensive to apply on all context
translations unless we cache the policy in memory in some manner (e.g.
translation daemon).  But even that won't address the potential
confusion noted by Dan of a user performing a chcon -t shlib_t foo and
then seeing lib_t on the file upon a ls -Z.  I'm not sure whether that
is a major issue in practice.

Thoughts?

-- 
Stephen Smalley
National Security Agency

--=-jMniia/AtwzZSECRZy0M
Content-Disposition: attachment; filename=libsepol-canonicalize.patch
Content-Type: text/x-patch; name=libsepol-canonicalize.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libsepol/include/sepol/policydb.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/include/sepol/policydb.h,v
retrieving revision 1.20
diff -u -p -r1.20 policydb.h
--- libsepol/include/sepol/policydb.h	18 Oct 2005 13:28:24 -0000	1.20
+++ libsepol/include/sepol/policydb.h	27 Oct 2005 15:22:18 -0000
@@ -124,6 +124,16 @@ extern int sepol_policydb_to_image(sepol
 				   void **newdata, 
 				   size_t *newlen);
 
+/*
+ * Canonicalize a security context for a given policy.
+ * Sets '*newcon' to the canonicalized context.
+ * Caller must free *newcon via free().
+ */ 
+extern int sepol_policydb_canonicalize_context(sepol_handle_t *handle,
+					       sepol_policydb_t *p,
+					       const char *oldcon,
+					       char **newcon);
+
 #endif
 
 
Index: libsepol/src/libsepol.map
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/libsepol.map,v
retrieving revision 1.11
diff -u -p -r1.11 libsepol.map
--- libsepol/src/libsepol.map	21 Oct 2005 15:13:56 -0000	1.11
+++ libsepol/src/libsepol.map	27 Oct 2005 16:54:58 -0000
@@ -9,6 +9,7 @@
 	sepol_policydb_set_typesvers; sepol_policydb_set_vers;
 	sepol_policydb_read; sepol_policydb_write;
 	sepol_policydb_from_image; sepol_policydb_to_image;
+	sepol_policydb_canonicalize_context;
 	sepol_module_package_create; sepol_module_package_free; 
 	sepol_module_package_get_file_contexts;
 	sepol_module_package_get_file_contexts_len;
Index: libsepol/src/policydb_public.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsepol/src/policydb_public.c,v
retrieving revision 1.3
diff -u -p -r1.3 policydb_public.c
--- libsepol/src/policydb_public.c	25 Oct 2005 12:09:09 -0000	1.3
+++ libsepol/src/policydb_public.c	27 Oct 2005 15:34:59 -0000
@@ -3,6 +3,7 @@
 #include "debug.h"
 
 #include <sepol/policydb/policydb.h>
+#include "context.h"
 
 /* Policy file interfaces. */
 
@@ -157,3 +158,23 @@ int sepol_policydb_to_image(sepol_handle
 	return policydb_to_image(handle, &p->p, newdata, newlen);
 }
 
+int sepol_policydb_canonicalize_context(sepol_handle_t *handle,
+					sepol_policydb_t *p,
+					const char *oldcon,
+					char **newcon)
+{
+	context_struct_t *con;
+	size_t len;
+	int rc = STATUS_ERR;
+
+	if (context_from_string(handle, &p->p, &con, 
+				oldcon, strlen(oldcon)+1) < 0)
+		return rc;
+	if (context_to_string(handle, &p->p, con, newcon, &len) < 0)
+		goto out;
+	rc = STATUS_SUCCESS;
+out:
+	context_destroy(con);
+	free(con);
+	return rc;
+}

--=-jMniia/AtwzZSECRZy0M
Content-Disposition: attachment; filename=libselinux-canonicalize.patch
Content-Type: text/x-patch; name=libselinux-canonicalize.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/load_policy.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/load_policy.c,v
retrieving revision 1.12
diff -u -p -r1.12 load_policy.c
--- libselinux/src/load_policy.c	18 Oct 2005 13:49:00 -0000	1.12
+++ libselinux/src/load_policy.c	27 Oct 2005 17:31:24 -0000
@@ -35,19 +35,12 @@ hidden_def(security_load_policy)
 
 int load_setlocaldefs hidden = 1;
 
-int selinux_mkload_policy(int preservebools)
+static int selinux_open_policy(int *version) 
 {
-	int vers = sepol_policy_kern_vers_max();
-	int kernvers = security_policyvers();
-	char path[PATH_MAX], **names;
-	struct stat sb;
-	size_t size;
-	void *map, *data;
-	int fd, rc = -1, *values, len, i, prot;
-	sepol_policydb_t *policydb;
-	sepol_policy_file_t *pf;
+	int vers = *version ?: sepol_policy_kern_vers_max();
+	char path[PATH_MAX];
+	int fd;
 
-search:
 	snprintf(path, sizeof(path), "%s.%d", 
 		 selinux_binary_policy_path(), vers);
 	fd = open(path, O_RDONLY);
@@ -60,6 +53,27 @@ search:
 	if (fd < 0)
 		return -1;
 
+	*version = vers;
+	return fd;
+}
+
+int selinux_mkload_policy(int preservebools)
+{
+	int vers = 0;
+	int kernvers = security_policyvers();
+	char **names;
+	struct stat sb;
+	size_t size;
+	void *map, *data;
+	int fd, rc = -1, *values, len, i, prot;
+	sepol_policydb_t *policydb;
+	sepol_policy_file_t *pf;
+
+search:
+	fd = selinux_open_policy(&vers);
+	if (fd < 0)
+		return -1;
+
 	if (fstat(fd, &sb) < 0)
 		goto close;
 
@@ -259,3 +273,40 @@ noload:
 	 */
 	return -1;
 }
+
+int hidden selinux_open_policydb(sepol_policydb_t **out_policydb)
+{
+	int vers = 0, fd, rc = -1;
+	FILE *fp;
+	sepol_policydb_t *policydb = NULL;
+	sepol_policy_file_t *pf = NULL;
+
+	fd = selinux_open_policy(&vers);
+	if (fd < 0)
+		return -1;
+
+	fp = fdopen(fd, "r");
+	if (!fp) {
+		close(fd);
+		return -1;
+	}
+
+	if (sepol_policy_file_create(&pf))
+		goto err;
+	if (sepol_policydb_create(&policydb))
+		goto err;
+	sepol_policy_file_set_fp(pf, fp);
+	if (sepol_policydb_read(policydb, pf))
+		goto err;
+	*out_policydb = policydb;
+	rc = 0;
+out:
+	sepol_policy_file_free(pf);
+	fclose(fp);
+	return rc;
+err:
+	rc = -1;
+	sepol_policydb_free(policydb);
+	goto out;
+}
+
Index: libselinux/src/matchpathcon.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/matchpathcon.c,v
retrieving revision 1.31
diff -u -p -r1.31 matchpathcon.c
--- libselinux/src/matchpathcon.c	5 Oct 2005 15:48:05 -0000	1.31
+++ libselinux/src/matchpathcon.c	27 Oct 2005 17:38:25 -0000
@@ -61,6 +61,32 @@ out:
 	return rc;
 }
 
+static int selinux_canonicalize_context(sepol_policydb_t *policydb,
+					security_context_t oldcon,
+					security_context_t *newcon)
+{
+	int ret;
+	security_context_t roldcon = oldcon, rnewcon = NULL;
+
+	if (context_translations && trans_to_raw_context(oldcon, &roldcon))
+		return -1;
+
+ 	ret = sepol_policydb_canonicalize_context(NULL, 
+						  policydb, roldcon, &rnewcon);
+
+	if (context_translations) {
+		freecon(roldcon);
+		if (ret >= 0 && raw_to_trans_context(rnewcon, newcon)) {
+			*newcon = NULL;
+			ret = -1;
+		}
+		freecon(rnewcon);
+	} else if (ret >= 0)
+		*newcon = rnewcon;
+
+	return ret;
+}
+
 static void (*myprintf)(const char *fmt, ...) = &default_printf;
 
 void set_matchpathcon_printf(void (*f)(const char *fmt, ...))
@@ -214,6 +240,8 @@ static int find_stem_from_file(const cha
 	return -1;
 }
 
+static sepol_policydb_t *policydb;
+
 /*
  * The array of specifications, initially in the
  * same order as in the specification file.
@@ -451,6 +479,7 @@ static void spec_hasMetaChars(struct spe
 	}
 	return;
 }
+
 static int process_line( const char *path, char *line_buf, int pass, unsigned lineno, int mls_enabled) {
 	int items, len, regerr;
 	char *buf_p;
@@ -557,21 +586,34 @@ static int process_line( const char *pat
 		
 	skip_type:
 		if (strcmp(context, "<<none>>")) {
+			/* Translate the context for MLS or strip the level. */
 			if (context_translations) {
-				if (raw_to_trans_context(context,
-				                    &spec_arr[nspec].context)) {
+				char *trans = NULL;
+				if (raw_to_trans_context(context, &trans)) {
 					myprintf("%s: line %u has invalid "
 					         "context %s\n",
 					         path, lineno, context);
 					return 0;
 				}
 				free(context);
-				context = spec_arr[nspec].context;
+				context = trans;
 			} else {
 				if (STRIP_LEVEL(&context, mls_enabled))
 					return -1;
 			}
 
+			/* Canonicalize the context. */
+			if (policydb) {
+				char *canon = NULL;
+				if (!selinux_canonicalize_context(policydb,
+								  context, 
+								  &canon)) {
+					free(context);
+					context = canon;
+				}
+			}
+
+			/* Validate the context. */
 			if (myinvalidcon(path, lineno, context))
 				return 0;
 		}
@@ -626,6 +668,12 @@ int matchpathcon_init(const char *path)
 			__fsetlocking(localfp, FSETLOCKING_BYCALLER);
 	}
 
+	/* Canonicalize contexts against policy when acting on the
+	   active file contexts configuration. */
+	if (!strcmp(path, selinux_file_context_path())) {
+		(void) selinux_open_policydb(&policydb);
+	}
+
 	/* 
 	 * Perform two passes over the specification file.
 	 * The first pass counts the number of specifications and
Index: libselinux/src/selinux_internal.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/selinux_internal.h,v
retrieving revision 1.15
diff -u -p -r1.15 selinux_internal.h
--- libselinux/src/selinux_internal.h	27 Oct 2005 12:16:37 -0000	1.15
+++ libselinux/src/selinux_internal.h	27 Oct 2005 17:32:02 -0000
@@ -1,4 +1,5 @@
 #include <selinux/selinux.h>
+#include <sepol/policydb.h>
 #include "dso.h"
 
 hidden_proto(selinux_mkload_policy)
@@ -59,9 +60,9 @@ hidden_proto(selinux_path)
 hidden_proto(selinux_check_passwd_access)
 hidden_proto(matchpathcon_init)
 hidden_proto(selinux_users_path)
-hidden_proto(selinux_usersconf_path);
-hidden_proto(selinux_translations_path);
-hidden_proto(selinux_getenforcemode);
+hidden_proto(selinux_usersconf_path)
+hidden_proto(selinux_translations_path)
+hidden_proto(selinux_getenforcemode)
 
 extern int context_translations hidden;
 extern int hidden trans_to_raw_context(char *trans, char **rawp);
@@ -69,3 +70,5 @@ extern int hidden raw_to_trans_context(c
 
 extern int load_setlocaldefs hidden;
 extern int require_seusers hidden;
+
+extern int hidden selinux_open_policydb(sepol_policydb_t **policydb);

--=-jMniia/AtwzZSECRZy0M--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
