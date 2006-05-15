Subject: [RFC][PATCH] selinux:  introduce support for deferred mapping of
	inode security contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
        Daniel J Walsh <dwalsh@redhat.com>, SELinux-dev@tresys.com,
        James Morris <jmorris@redhat.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 12:35:50 -0400
Message-Id: <1147710951.14426.118.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

During the earlier thread on splitting policy into individual packages
(using policy modules), it was requested that SELinux provide a way for
a privileged process (like a package manager) to label an inode with a
not-yet-defined security context (treating it as having the unlabeled
SID until defined in the policy) and then automatically update the
in-memory state when a policy that defines the security context is
loaded such that the inode immediately becomes accessible under the
rules governing access to that context in the new policy.  More
generally, the same behavior is desired for any case where a security
context that was once valid becomes invalid and then becomes valid again
through a series of policy reloads, to address issues in the past where
removing and re-adding types or other context components has caused
problems when inodes are labeled with those context components.  This is
a RFC and patch for the SELinux kernel "module" changes required to
support that functionality.

With this patch applied, the following sequence is possible, subject to
policy, which must allow <domain> security_t:security labelpriv; and
allow unlabeled_t fs_t:filesystem associate; in order for this to work
in enforcing mode.  Note that unconfined_t implicitly picks up all
security permissions at present due to the use of a wildcard for the
permission set in its rule.  However, you still need the second allow
rule as well in order for this to succeed in enforcing mode.  

# touch foo
# chcon -t foo_exec_t foo
# ls -Z foo
-rw-r--r--  root root system_u:object_r:unlabeled_t    foo
# semodule -i foo.pp # defines foo_exec_t
# ls -Z foo
-rw-r--r--  root root user_u:object_r:foo_exec_t       foo
# semodule -r foo
# ls -Z foo
-rw-r--r--  root root system_u:object_r:unlabeled_t    foo
# semodule -i foo.pp
# ls -Z foo
-rw-r--r--  root root user_u:object_r:foo_exec_t       foo

Logically, there are two separate changes here.  The first logical
change is to support deferred mapping of security contexts in the SID
table, storing their string representations when they cannot be mapped
under the current policy, and treating them the same as the unlabeled
SID while they are in this state.  Upon policy reloads, if a valid
context becomes invalid under the new policy, rather than removing it
from the SID table, we convert it to its string representation under the
old policy and store that in the SID table until such a time as it
becomes valid again, and if an invalid context becomes valid, we map it
to its internal structure representation.  This change alone is
worthwhile irrespective of the second change, as it addresses the
longstanding issue with removing and re-adding types to policy when they
are assigned to inodes.  The second logical change introduces the
support for setting invalid contexts by privileged processes, both via
setxattr() and via /proc/self/attr/fscreate, which is the more
controversial aspect.  Note that contrary to my earlier expectations, no
walking of the inode security structs is required, as the SIDs
themselves remain invariant under such changes.

---<snip>---

Introduce support for deferring mapping of security contexts in the
SID table upon policy reload, and use this support for inode security
contexts when the context is not yet valid under the current policy.
Only processes with 'labelpriv' permission to the 'security' class can
set such invalid security contexts on inodes.  Inodes with such
invalid contexts are treated as having the unlabeled SID until the context 
becomes valid under a policy.  This support is for use by privileged processes
like rpm that need to set down files in the proper security contexts prior to 
loading the policy module that defines the context and its associated rules.

---

 security/selinux/hooks.c                  |   16 ++
 security/selinux/include/av_permissions.h |    1 
 security/selinux/include/objsec.h         |    3 
 security/selinux/include/security.h       |    2 
 security/selinux/selinuxfs.c              |    4 
 security/selinux/ss/context.h             |   27 ++++
 security/selinux/ss/mls.c                 |   11 -
 security/selinux/ss/mls.h                 |    3 
 security/selinux/ss/services.c            |  183 ++++++++++++++++++++----------
 security/selinux/ss/sidtab.c              |    4 
 10 files changed, 183 insertions(+), 71 deletions(-)

diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/hooks.c linux-2.6.17-rc3-mm1-x/security/selinux/hooks.c
--- linux-2.6.17-rc3-mm1/security/selinux/hooks.c	2006-05-04 14:08:36.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x/security/selinux/hooks.c	2006-05-15 09:07:33.000000000 -0400
@@ -2160,6 +2160,11 @@ static int selinux_inode_setxattr(struct
 		return rc;
 
 	rc = security_context_to_sid(value, size, &newsid);
+	if (rc == -EINVAL) {
+		if (task_has_security(current, SECURITY__LABELPRIV))
+			return rc;
+		rc = security_context_to_sid_force(value, size, &newsid);
+	}
 	if (rc)
 		return rc;
 
@@ -2193,10 +2198,11 @@ static void selinux_inode_post_setxattr(
 		return;
 	}
 
-	rc = security_context_to_sid(value, size, &newsid);
+	rc = security_context_to_sid_force(value, size, &newsid);
 	if (rc) {
 		printk(KERN_WARNING "%s:  unable to obtain SID for context "
-		       "%s, rc=%d\n", __FUNCTION__, (char*)value, -rc);
+		       "%s on (%s, %lu), rc=%d\n", __FUNCTION__, (char*)value,
+		       inode->i_sb->s_id, inode->i_ino, -rc);
 		return;
 	}
 
@@ -4158,6 +4164,12 @@ static int selinux_setprocattr(struct ta
 			size--;
 		}
 		error = security_context_to_sid(value, size, &sid);
+		if (error == -EINVAL && !strcmp(name, "fscreate")) {
+			if (task_has_security(current, SECURITY__LABELPRIV))
+				return error;
+			error = security_context_to_sid_force(value, size,
+							      &sid);
+		}
 		if (error)
 			return error;
 	}
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/include/av_permissions.h linux-2.6.17-rc3-mm1-x/security/selinux/include/av_permissions.h
--- linux-2.6.17-rc3-mm1/security/selinux/include/av_permissions.h	2006-05-04 14:08:36.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x/security/selinux/include/av_permissions.h	2006-05-12 09:48:56.000000000 -0400
@@ -526,6 +526,7 @@
 #define SECURITY__SETBOOL                         0x00000100UL
 #define SECURITY__SETSECPARAM                     0x00000200UL
 #define SECURITY__SETCHECKREQPROT                 0x00000400UL
+#define SECURITY__LABELPRIV                       0x00000800UL
 
 #define SYSTEM__IPC_INFO                          0x00000001UL
 #define SYSTEM__SYSLOG_READ                       0x00000002UL
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/include/objsec.h linux-2.6.17-rc3-mm1-x/security/selinux/include/objsec.h
--- linux-2.6.17-rc3-mm1/security/selinux/include/objsec.h	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc3-mm1-x/security/selinux/include/objsec.h	2006-05-12 09:48:56.000000000 -0400
@@ -101,4 +101,7 @@ struct sk_security_struct {
 
 extern unsigned int selinux_checkreqprot;
 
+extern int task_has_security(struct task_struct *tsk,
+			     u32 perms);
+
 #endif /* _SELINUX_OBJSEC_H_ */
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/include/security.h linux-2.6.17-rc3-mm1-x/security/selinux/include/security.h
--- linux-2.6.17-rc3-mm1/security/selinux/include/security.h	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc3-mm1-x/security/selinux/include/security.h	2006-05-12 09:46:19.000000000 -0400
@@ -68,6 +68,8 @@ int security_context_to_sid(char *sconte
 
 int security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *out_sid, u32 def_sid);
 
+int security_context_to_sid_force(char *scontext, u32 scontext_len, u32 *sid);
+
 int security_get_user_sids(u32 callsid, char *username,
 			   u32 **sids, u32 *nel);
 
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/selinuxfs.c linux-2.6.17-rc3-mm1-x/security/selinux/selinuxfs.c
--- linux-2.6.17-rc3-mm1/security/selinux/selinuxfs.c	2006-05-02 08:06:00.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x/security/selinux/selinuxfs.c	2006-05-12 09:48:56.000000000 -0400
@@ -56,8 +56,8 @@ static int *bool_pending_values = NULL;
 extern void selnl_notify_setenforce(int val);
 
 /* Check whether a task is allowed to use a security operation. */
-static int task_has_security(struct task_struct *tsk,
-			     u32 perms)
+int task_has_security(struct task_struct *tsk,
+		      u32 perms)
 {
 	struct task_security_struct *tsec;
 
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/ss/context.h linux-2.6.17-rc3-mm1-x/security/selinux/ss/context.h
--- linux-2.6.17-rc3-mm1/security/selinux/ss/context.h	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc3-mm1-x/security/selinux/ss/context.h	2006-05-15 08:39:39.000000000 -0400
@@ -28,6 +28,8 @@ struct context {
 	u32 role;
 	u32 type;
 	struct mls_range range;
+	char *str;	/* string representation if context cannot be mapped. */
+	u32 len;        /* length of string in bytes */
 };
 
 static inline void mls_context_init(struct context *c)
@@ -83,20 +85,43 @@ static inline void context_init(struct c
 
 static inline int context_cpy(struct context *dst, struct context *src)
 {
+	int rc;
+
 	dst->user = src->user;
 	dst->role = src->role;
 	dst->type = src->type;
-	return mls_context_cpy(dst, src);
+	if (src->str) {
+		dst->str = kstrdup(src->str, GFP_ATOMIC);
+		if (!dst->str)
+			return -ENOMEM;
+		dst->len = src->len;
+	} else {
+		dst->str = NULL;
+		dst->len = 0;
+	}
+	rc = mls_context_cpy(dst, src);
+	if (rc) {
+		kfree(dst->str);
+		return rc;
+	}
+	return 0;
 }
 
 static inline void context_destroy(struct context *c)
 {
 	c->user = c->role = c->type = 0;
+	kfree(c->str);
+	c->str = NULL;
+	c->len = 0;
 	mls_context_destroy(c);
 }
 
 static inline int context_cmp(struct context *c1, struct context *c2)
 {
+	if (c1->len && c2->len)
+		return (c1->len == c2->len && !strcmp(c1->str, c2->str));
+	if (c1->len || c2->len)
+		return 0;
 	return ((c1->user == c2->user) &&
 		(c1->role == c2->role) &&
 		(c1->type == c2->type) &&
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/ss/mls.c linux-2.6.17-rc3-mm1-x/security/selinux/ss/mls.c
--- linux-2.6.17-rc3-mm1/security/selinux/ss/mls.c	2006-05-02 08:47:04.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x/security/selinux/ss/mls.c	2006-05-12 10:08:35.000000000 -0400
@@ -249,7 +249,8 @@ static inline int mls_copy_context(struc
  * Policy read-lock must be held for sidtab lookup.
  *
  */
-int mls_context_to_sid(char oldc,
+int mls_context_to_sid(struct policydb *pol,
+		       char oldc,
 		       char **scontext,
 		       struct context *context,
 		       struct sidtab *s,
@@ -296,7 +297,7 @@ int mls_context_to_sid(char oldc,
 		*p++ = 0;
 
 	for (l = 0; l < 2; l++) {
-		levdatum = hashtab_search(policydb.p_levels.table, scontextp);
+		levdatum = hashtab_search(pol->p_levels.table, scontextp);
 		if (!levdatum) {
 			rc = -EINVAL;
 			goto out;
@@ -320,7 +321,7 @@ int mls_context_to_sid(char oldc,
 					*rngptr++ = 0;
 				}
 
-				catdatum = hashtab_search(policydb.p_cats.table,
+				catdatum = hashtab_search(pol->p_cats.table,
 				                          scontextp);
 				if (!catdatum) {
 					rc = -EINVAL;
@@ -336,7 +337,7 @@ int mls_context_to_sid(char oldc,
 				if (rngptr) {
 					int i;
 
-					rngdatum = hashtab_search(policydb.p_cats.table, rngptr);
+					rngdatum = hashtab_search(pol->p_cats.table, rngptr);
 					if (!rngdatum) {
 						rc = -EINVAL;
 						goto out;
@@ -404,7 +405,7 @@ int mls_from_string(char *str, struct co
 	if (!tmpstr) {
 		rc = -ENOMEM;
 	} else {
-		rc = mls_context_to_sid(':', &tmpstr, context,
+		rc = mls_context_to_sid(&policydb, ':', &tmpstr, context,
 		                        NULL, SECSID_NULL);
 		kfree(freestr);
 	}
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/ss/mls.h linux-2.6.17-rc3-mm1-x/security/selinux/ss/mls.h
--- linux-2.6.17-rc3-mm1/security/selinux/ss/mls.h	2006-05-02 08:47:04.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x/security/selinux/ss/mls.h	2006-05-12 09:03:23.000000000 -0400
@@ -21,7 +21,8 @@ int mls_compute_context_len(struct conte
 void mls_sid_to_context(struct context *context, char **scontext);
 int mls_context_isvalid(struct policydb *p, struct context *c);
 
-int mls_context_to_sid(char oldc,
+int mls_context_to_sid(struct policydb *p,
+		       char oldc,
 	               char **scontext,
 		       struct context *context,
 		       struct sidtab *s,
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/ss/services.c linux-2.6.17-rc3-mm1-x/security/selinux/ss/services.c
--- linux-2.6.17-rc3-mm1/security/selinux/ss/services.c	2006-05-02 08:47:04.000000000 -0400
+++ linux-2.6.17-rc3-mm1-x/security/selinux/ss/services.c	2006-05-15 10:01:01.000000000 -0400
@@ -619,36 +619,24 @@ out:
 
 }
 
-static int security_context_to_sid_core(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
+static int string_to_context_struct(struct policydb *pol,
+				    struct sidtab *sidtabp,
+				    char *scontext,
+				    u32 scontext_len,
+				    struct context *ctx,
+				    u32 def_sid)
 {
-	char *scontext2;
-	struct context context;
+	char *scontext2 = NULL;
 	struct role_datum *role;
 	struct type_datum *typdatum;
 	struct user_datum *usrdatum;
 	char *scontextp, *p, oldc;
 	int rc = 0;
 
-	if (!ss_initialized) {
-		int i;
+	context_init(ctx);
 
-		for (i = 1; i < SECINITSID_NUM; i++) {
-			if (!strcmp(initial_sid_to_string[i], scontext)) {
-				*sid = i;
-				goto out;
-			}
-		}
-		*sid = SECINITSID_KERNEL;
-		goto out;
-	}
-	*sid = SECSID_NULL;
-
-	/* Copy the string so that we can modify the copy as we parse it.
-	   The string should already by null terminated, but we append a
-	   null suffix to the copy to avoid problems with the existing
-	   attr package, which doesn't view the null terminator as part
-	   of the attribute value. */
-	scontext2 = kmalloc(scontext_len+1,GFP_KERNEL);
+	/* Copy the string so that we can modify the copy as we parse it. */
+	scontext2 = kmalloc(scontext_len+1, GFP_ATOMIC);
 	if (!scontext2) {
 		rc = -ENOMEM;
 		goto out;
@@ -656,11 +644,6 @@ static int security_context_to_sid_core(
 	memcpy(scontext2, scontext, scontext_len);
 	scontext2[scontext_len] = 0;
 
-	context_init(&context);
-	*sid = SECSID_NULL;
-
-	POLICY_RDLOCK;
-
 	/* Parse the security context. */
 
 	rc = -EINVAL;
@@ -672,15 +655,15 @@ static int security_context_to_sid_core(
 		p++;
 
 	if (*p == 0)
-		goto out_unlock;
+		goto out;
 
 	*p++ = 0;
 
-	usrdatum = hashtab_search(policydb.p_users.table, scontextp);
+	usrdatum = hashtab_search(pol->p_users.table, scontextp);
 	if (!usrdatum)
-		goto out_unlock;
+		goto out;
 
-	context.user = usrdatum->value;
+	ctx->user = usrdatum->value;
 
 	/* Extract role. */
 	scontextp = p;
@@ -688,14 +671,14 @@ static int security_context_to_sid_core(
 		p++;
 
 	if (*p == 0)
-		goto out_unlock;
+		goto out;
 
 	*p++ = 0;
 
-	role = hashtab_search(policydb.p_roles.table, scontextp);
+	role = hashtab_search(pol->p_roles.table, scontextp);
 	if (!role)
-		goto out_unlock;
-	context.role = role->value;
+		goto out;
+	ctx->role = role->value;
 
 	/* Extract type. */
 	scontextp = p;
@@ -704,33 +687,72 @@ static int security_context_to_sid_core(
 	oldc = *p;
 	*p++ = 0;
 
-	typdatum = hashtab_search(policydb.p_types.table, scontextp);
+	typdatum = hashtab_search(pol->p_types.table, scontextp);
 	if (!typdatum)
-		goto out_unlock;
+		goto out;
 
-	context.type = typdatum->value;
+	ctx->type = typdatum->value;
 
-	rc = mls_context_to_sid(oldc, &p, &context, &sidtab, def_sid);
+	rc = mls_context_to_sid(pol, oldc, &p, ctx, sidtabp, def_sid);
 	if (rc)
-		goto out_unlock;
+		goto out;
 
 	if ((p - scontext2) < scontext_len) {
 		rc = -EINVAL;
-		goto out_unlock;
+		goto out;
 	}
 
 	/* Check the validity of the new context. */
-	if (!policydb_context_isvalid(&policydb, &context)) {
+	if (!policydb_context_isvalid(pol, ctx)) {
 		rc = -EINVAL;
-		goto out_unlock;
+		context_destroy(ctx);
+		goto out;
 	}
-	/* Obtain the new sid. */
-	rc = sidtab_context_to_sid(&sidtab, &context, sid);
-out_unlock:
-	POLICY_RDUNLOCK;
-	context_destroy(&context);
+	rc = 0;
+out:
 	kfree(scontext2);
+	return rc;
+}
+
+static int security_context_to_sid_core(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid, int force)
+{
+	struct context context;
+	int rc = 0;
+
+	if (!ss_initialized) {
+		int i;
+
+		for (i = 1; i < SECINITSID_NUM; i++) {
+			if (!strcmp(initial_sid_to_string[i], scontext)) {
+				*sid = i;
+				goto out;
+			}
+		}
+		*sid = SECINITSID_KERNEL;
+		goto out;
+	}
+	*sid = SECSID_NULL;
+
+	POLICY_RDLOCK;
+	rc = string_to_context_struct(&policydb, &sidtab,
+				      scontext, scontext_len,
+				      &context, def_sid);
+	if (rc == -EINVAL && force) {
+		context.str = kmalloc(scontext_len+1,GFP_ATOMIC);
+		if (!context.str) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		memcpy(context.str, scontext, scontext_len);
+		context.str[scontext_len] = 0;
+		context.len = scontext_len;
+	} else if (rc)
+		goto out;
+	rc = sidtab_context_to_sid(&sidtab, &context, sid);
+	if (rc)
+		context_destroy(&context);
 out:
+	POLICY_RDUNLOCK;
 	return rc;
 }
 
@@ -748,7 +770,7 @@ out:
 int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
-	                                    sid, SECSID_NULL);
+	                                    sid, SECSID_NULL, 0);
 }
 
 /**
@@ -765,13 +787,20 @@ int security_context_to_sid(char *sconte
  * The default SID is passed to the MLS layer to be used to allow
  * kernel labeling of the MLS field if the MLS field is not present
  * (for upgrading to MLS without full relabel).
+ * Implicitly forces adding of the context even if it cannot be mapped yet.
  * Returns -%EINVAL if the context is invalid, -%ENOMEM if insufficient
  * memory is available, or 0 on success.
  */
 int security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
-	                                    sid, def_sid);
+	                                    sid, def_sid, 1);
+}
+
+int security_context_to_sid_force(char *scontext, u32 scontext_len, u32 *sid)
+{
+	return security_context_to_sid_core(scontext, scontext_len,
+	                                    sid, SECSID_NULL, 1);
 }
 
 static int compute_sid_handle_invalid_context(
@@ -1108,9 +1137,10 @@ static inline int convert_context_handle
 		char *s;
 		u32 len;
 
-		context_struct_to_string(context, &s, &len);
-		printk(KERN_ERR "security:  context %s is invalid\n", s);
-		kfree(s);
+		if (!context_struct_to_string(context, &s, &len)) {
+			printk(KERN_WARNING "SELinux:  Context %s would be invalid if enforcing\n", s);
+			kfree(s);
+		}
 	}
 	return rc;
 }
@@ -1142,6 +1172,27 @@ static int convert_context(u32 key,
 
 	args = p;
 
+	if (c->str) {
+		struct context ctx;
+		rc = string_to_context_struct(args->newp, NULL, c->str,
+					      c->len, &ctx, SECSID_NULL);
+		if (!rc) {
+			printk(KERN_INFO "SELinux:  Context %s became valid under new policy.\n", c->str);
+			/* Replace string with mapped representation. */
+			kfree(c->str);
+			memcpy(c, &ctx, sizeof(*c));
+			goto out;
+		} else if (rc == -EINVAL) {
+			/* Retain string representation for later mapping. */
+			rc = 0;
+			goto out;
+		} else {
+			/* Other error condition, e.g. ENOMEM. */
+			printk(KERN_ERR "SELinux:   Failed trying to map context %s (rc %d) under new policy, leaving unmapped.\n", c->str, -rc);
+			goto out;
+		}
+	}
+
 	rc = context_cpy(&oldc, c);
 	if (rc)
 		goto out;
@@ -1184,13 +1235,19 @@ static int convert_context(u32 key,
 	}
 
 	context_destroy(&oldc);
+	rc = 0;
 out:
 	return rc;
 bad:
-	context_struct_to_string(&oldc, &s, &len);
+	/* Map old representation to string and save it. */
+	if (context_struct_to_string(&oldc, &s, &len))
+		return -ENOMEM;
 	context_destroy(&oldc);
-	printk(KERN_ERR "security:  invalidating context %s\n", s);
-	kfree(s);
+	context_destroy(c);
+	c->str = s;
+	c->len = len;
+	printk(KERN_INFO "SELinux:  Context %s became invalid under new policy.\n", c->str);
+	rc = 0;
 	goto out;
 }
 
@@ -1249,7 +1306,11 @@ int security_load_policy(void *data, siz
 		return -EINVAL;
 	}
 
-	sidtab_init(&newsidtab);
+	if (sidtab_init(&newsidtab)) {
+		LOAD_UNLOCK;
+		policydb_destroy(&newpolicydb);
+		return -ENOMEM;
+	}
 
 	/* Verify that the existing classes did not change. */
 	if (hashtab_map(policydb.p_classes.table, validate_class, &newpolicydb)) {
@@ -1267,10 +1328,12 @@ int security_load_policy(void *data, siz
 	}
 
 	/* Convert the internal representations of contexts
-	   in the new SID table and remove invalid SIDs. */
+	   in the new SID table. */
 	args.oldp = &policydb;
 	args.newp = &newpolicydb;
-	sidtab_map_remove_on_error(&newsidtab, convert_context, &args);
+	rc = sidtab_map(&newsidtab, convert_context, &args);
+	if (rc)
+		goto err;
 
 	/* Save the old policydb and SID table to free later. */
 	memcpy(&oldpolicydb, &policydb, sizeof policydb);
@@ -1520,6 +1583,8 @@ int security_get_user_sids(u32 fromsid,
 
 	POLICY_RDLOCK;
 
+	context_init(&usercon);
+
 	fromcon = sidtab_search(&sidtab, fromsid);
 	if (!fromcon) {
 		rc = -EINVAL;
diff -X /home/sds/dontdiff -rup linux-2.6.17-rc3-mm1/security/selinux/ss/sidtab.c linux-2.6.17-rc3-mm1-x/security/selinux/ss/sidtab.c
--- linux-2.6.17-rc3-mm1/security/selinux/ss/sidtab.c	2006-03-20 00:53:29.000000000 -0500
+++ linux-2.6.17-rc3-mm1-x/security/selinux/ss/sidtab.c	2006-05-15 10:20:08.000000000 -0400
@@ -100,7 +100,7 @@ struct context *sidtab_search(struct sid
 	while (cur != NULL && sid > cur->sid)
 		cur = cur->next;
 
-	if (cur == NULL || sid != cur->sid) {
+	if (cur == NULL || sid != cur->sid || cur->context.len) {
 		/* Remap invalid SIDs to the unlabeled SID. */
 		sid = SECINITSID_UNLABELED;
 		hvalue = SIDTAB_HASH(sid);
@@ -218,6 +218,8 @@ int sidtab_context_to_sid(struct sidtab 
 			goto unlock_out;
 		}
 		sid = s->next_sid++;
+		if (context->len)
+			printk(KERN_INFO "SELinux:  Context %s is not valid under current policy, adding as unmapped value.\n", context->str);
 		ret = sidtab_insert(s, sid, context);
 		if (ret)
 			s->next_sid--;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
