Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3OD9wMC012879
 for <selinux@tycho.nsa.gov>; Mon, 24 Apr 2017 09:09:58 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [RFC PATCH 1/1] libselinux: Add support for selinux_check_access_flags
Date: Mon, 24 Apr 2017 14:09:44 +0100
Message-Id: <20170424130944.5334-1-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add function selinux_check_access_flags() that is the same as
selinux_check_access() except that it will also return the avd
flags. Currently only the SELINUX_AVD_FLAGS_PERMISSIVE flag is
used to signify that the source type is defined as permissive
in policy.

Because selinux_check_access_flags() can return before the AVC
call, and also the AVC call may return with undefined avd flags,
the returned flags should be checked for SELINUX_AVD_FLAGS_UNDEFINED,
first. If set, the remaining flags are undefined. See the
selinux_check_access_flags() man page entry for details. There is a
utility for testing the functionality:
utils/selinux_check_access -f scon tcon class perm

As a consequence of implementing selinux_check_access_flags, additional
calls have been added to avc.c: avc_has_perm_flags() and
avc_has_perm_noaudit_flags(). The appropriate man pages have been updated.

There is a utility for testing the avc_has_perm() and avc_has_perm_flags():
utils/avc_has_perm -f scon tcon class perm

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/include/selinux/avc.h                 |  68 +++++++
 libselinux/include/selinux/selinux.h             |  32 +++
 libselinux/man/man3/avc_has_perm.3               |  37 +++-
 libselinux/man/man3/security_compute_av.3        |  21 +-
 libselinux/man/man3/selinux_check_access_flags.3 |   1 +
 libselinux/src/avc.c                             |  44 ++++-
 libselinux/src/avc_internal.h                    |   1 +
 libselinux/src/checkAccess.c                     |  63 +++---
 libselinux/utils/.gitignore                      |   2 +
 libselinux/utils/avc_has_perm.c                  | 235 +++++++++++++++++++++++
 libselinux/utils/selinux_check_access.c          | 189 ++++++++++++++++++
 11 files changed, 660 insertions(+), 33 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_check_access_flags.3
 create mode 100644 libselinux/utils/avc_has_perm.c
 create mode 100644 libselinux/utils/selinux_check_access.c

diff --git a/libselinux/include/selinux/avc.h b/libselinux/include/selinux/avc.h
index b4bc6f3..89d75c3 100644
--- a/libselinux/include/selinux/avc.h
+++ b/libselinux/include/selinux/avc.h
@@ -264,6 +264,43 @@ int avc_has_perm_noaudit(security_id_t ssid,
 			 struct avc_entry_ref *aeref, struct av_decision *avd);
 
 /**
+ * avc_has_perm_noaudit_flags - Check permissions but perform no auditing,
+ *                              return avd flags.
+ * @ssid: source security identifier
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @aeref:  AVC entry reference
+ * @avd: access vector decisions
+ * @flags: returned avd flags. Currently two flags are supported:
+ *         SELINUX_AVD_FLAGS_UNDEFINED This is typically set when the
+ *         source or target context is not valid in policy, or the
+ *         avc is in permissive mode, or the returned entry could not be
+ *         inserted into the avc cache.
+ *         SELINUX_AVD_FLAGS_PERMISSIVE, which indicates the decision is
+ *         computed on a policy defined permissive domain.
+ *
+ * Check the AVC to determine whether the @requested permissions are granted
+ * for the SID pair (@ssid, @tsid), interpreting the permissions
+ * based on @tclass, and call the security server on a cache miss to obtain
+ * a new decision and add it to the cache.  Update @aeref to refer to an AVC
+ * entry with the resulting decisions, and return a copy of the decisions
+ * in @avd.  Return %0 if all @requested permissions are granted, -%1 with
+ * @errno set to %EACCES if any permissions are denied, or to another value
+ * upon other errors.  This function is typically called by avc_has_perm(),
+ * but may also be called directly to separate permission checking from
+ * auditing, e.g. in cases where a lock must be held for the check but
+ * should be released for the auditing.
+ */
+int avc_has_perm_noaudit_flags(security_id_t ssid,
+			       security_id_t tsid,
+			       security_class_t tclass,
+			       access_vector_t requested,
+			       struct avc_entry_ref *aeref,
+			       struct av_decision *avd,
+			       unsigned int *flags);
+
+/**
  * avc_has_perm - Check permissions and perform any appropriate auditing.
  * @ssid: source security identifier
  * @tsid: target security identifier
@@ -286,6 +323,37 @@ int avc_has_perm(security_id_t ssid, security_id_t tsid,
 		 struct avc_entry_ref *aeref, void *auditdata);
 
 /**
+ * avc_has_perm_flags - Check permissions, returning avd flags and perform any
+ *                      appropriate auditing.
+ * @ssid: source security identifier
+ * @tsid: target security identifier
+ * @tclass: target security class
+ * @requested: requested permissions, interpreted based on @tclass
+ * @aeref:  AVC entry reference
+ * @auditdata: auxiliary audit data
+ * @flags: returned avd flags. Currently two flags are supported:
+ *         SELINUX_AVD_FLAGS_UNDEFINED This is typically caused when the
+ *         source or target context is not valid in policy, or the
+ *         avc is in permissive mode, or the returned entry could not be
+ *         inserted into the avc cache.
+ *         SELINUX_AVD_FLAGS_PERMISSIVE, which indicates the decision is
+ *         computed on a policy defined permissive domain.
+ *
+ * Check the AVC to determine whether the @requested permissions are granted
+ * for the SID pair (@ssid, @tsid), interpreting the permissions
+ * based on @tclass, and call the security server on a cache miss to obtain
+ * a new decision and add it to the cache.  Update @aeref to refer to an AVC
+ * entry with the resulting decisions.  Audit the granting or denial of
+ * permissions in accordance with the policy.  Return %0 if all @requested
+ * permissions are granted, -%1 with @errno set to %EACCES if any permissions
+ * are denied or to another value upon other errors.
+ */
+int avc_has_perm_flags(security_id_t ssid, security_id_t tsid,
+		      security_class_t tclass, access_vector_t requested,
+		      struct avc_entry_ref *aeref, void *auditdata,
+		      unsigned int *flags);
+
+/**
  * avc_audit - Audit the granting or denial of permissions.
  * @ssid: source security identifier
  * @tsid: target security identifier
diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 45dd6ca..4e9d209 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -136,6 +136,7 @@ struct av_decision {
 
 /* Definitions of av_decision.flags */
 #define SELINUX_AVD_FLAGS_PERMISSIVE	0x0001
+#define SELINUX_AVD_FLAGS_UNDEFINED	0x8000
 
 /* Structure for passing options, used by AVC and label subsystems */
 struct selinux_opt {
@@ -578,6 +579,37 @@ extern const char *selinux_path(void);
  */
 extern int selinux_check_access(const char * scon, const char * tcon, const char *tclass, const char *perm, void *auditdata);
 
+/**
+ * selinux_check_access_flags - Check permissions, returning avd flags and
+ * perform any appropriate auditing.
+ * @scon: source security context
+ * @tcon: target security context
+ * @tclass: target security class string
+ * @perm: requested permissions string, interpreted based on @tclass
+ * @auditdata: auxiliary audit data
+ * @flags: returned avd flags. Currently two flags are supported:
+ *         SELINUX_AVD_FLAGS_UNDEFINED, which indicates that the remaining
+ *         @flags should not be checked as the avd flags could not be read.
+ *         SELINUX_AVD_FLAGS_PERMISSIVE, which indicates the decision is
+ *         computed on a policy defined permissive domain.
+ *
+ * Check the AVC to determine whether the @perm permissions are granted
+ * for the SID pair (@scon, @tcon), interpreting the permissions
+ * based on @tclass.
+ * Return %0 if all @perm permissions are granted, -%1 with
+ * @errno set to %EACCES if any permissions are denied or to another
+ * value upon other errors.
+ * If auditing or logging is configured the appropriate callbacks will be
+ * called and passed the auditdata field.
+ * If selinux_check_access_flags() fails before calling the AVC, then @flags
+ * will be returned with a value of SELINUX_AVD_FLAGS_UNDEFINED as the avd
+ * flags could not be read. This will happen when either SELinux is disabled
+ * or there is an unknown class/permission.
+ */
+extern int selinux_check_access_flags(const char *scon, const char *tcon,
+				      const char *tclass, const char *perm,
+				      void *auditdata, unsigned int *flags);
+
 /* Check a permission in the passwd class.
    Return 0 if granted or -1 otherwise. */
 extern int selinux_check_passwd_access(access_vector_t requested);
diff --git a/libselinux/man/man3/avc_has_perm.3 b/libselinux/man/man3/avc_has_perm.3
index 3e9fca8..74d3420 100644
--- a/libselinux/man/man3/avc_has_perm.3
+++ b/libselinux/man/man3/avc_has_perm.3
@@ -19,6 +19,13 @@ avc_has_perm, avc_has_perm_noaudit, avc_audit, avc_entry_ref_init \- obtain and
 .BI "struct avc_entry_ref *" aeref ", void *" auditdata ");"
 .in
 .sp
+.BI "int avc_has_perm_flags(security_id_t " ssid ", security_id_t " tsid ,
+.in +\w'int avc_has_perm('u
+.BI "security_class_t " tclass ", access_vector_t " requested ,
+.br
+.BI "struct avc_entry_ref *" aeref ", void *" auditdata ", int *" flags ");"
+.in
+.sp
 .BI "int avc_has_perm_noaudit(security_id_t " ssid ", security_id_t " tsid ,
 .in +\w'int avc_has_perm('u
 .BI "security_class_t " tclass ", access_vector_t " requested ,
@@ -60,6 +67,21 @@ parameter is for supplemental auditing; see
 .BR avc_audit ()
 below.
 
+.BR avc_has_perm_flags ()
+is identical to
+.BR avc_has_perm ()
+but additionally sets the
+.I flags
+field. On return
+.I flags
+must be tested and if
+.BR SELINUX_AVD_FLAGS_UNDEFINED ,
+then the remaining
+.I flags
+should not be checked. Currently one other flag is supported:
+.BR SELINUX_AVD_FLAGS_PERMISSIVE ,
+which indicates the decision is computed on a policy defined permissive domain.
+
 .BR avc_has_perm_noaudit ()
 behaves as
 .BR avc_has_perm ()
@@ -69,6 +91,15 @@ and can be passed to
 .BR avc_audit ()
 explicitly.
 
+.BR avc_has_perm_noaudit_flags ()
+behaves as
+.BR avc_has_perm_flags ()
+without producing an audit message.  The access decision is returned in
+.I avd
+and can be passed to
+.BR avc_audit ()
+explicitly.
+
 .BR avc_audit ()
 produces an audit message for the access query represented by
 .IR ssid ,
@@ -101,9 +132,11 @@ After declaring an
 structure, use
 .BR avc_entry_ref_init ()
 to initialize it before passing it to
-.BR avc_has_perm ()
+.BR avc_has_perm (),
+.BR avc_has_perm_flags (),
+.BR avc_has_perm_noaudit ()
 or
-.BR \%avc_has_perm_noaudit ()
+.BR avc_has_perm_noaudit_flags ()
 for the first time.
 Using an uninitialized structure will produce undefined behavior.
 .
diff --git a/libselinux/man/man3/security_compute_av.3 b/libselinux/man/man3/security_compute_av.3
index 2aade5f..2a9312f 100644
--- a/libselinux/man/man3/security_compute_av.3
+++ b/libselinux/man/man3/security_compute_av.3
@@ -39,7 +39,9 @@ the SELinux policy database in the kernel
 .sp
 .BI "int security_get_initial_context_raw(const char *" name ", char **" con );
 .sp
-.BI "int selinux_check_access(const char *" scon ", const char *" tcon ", const char *" class ", const char *" perm ", void *" auditdata);
+.BI "int selinux_check_access(const char *" scon ", const char *" tcon ", const char *" class ", const char *" perm ", void *" auditdata );
+.sp
+.BI "int selinux_check_access_flags(const char *" scon ", const char *" tcon ", const char *" class ", const char *" perm ", void *" auditdata ", int *" flags );
 .sp
 .BI "int selinux_check_passwd_access(access_vector_t " requested );
 .sp
@@ -67,7 +69,7 @@ field of
 .IR avd .
 Currently one flag is supported:
 .BR SELINUX_AVD_FLAGS_PERMISSIVE ,
-which indicates the decision is computed on a permissive domain.
+which indicates the decision is computed on a policy defined permissive domain.
 
 .BR security_compute_create ()
 is used to compute a context to use for labeling a new object in a particular
@@ -119,6 +121,21 @@ translation.
 .BR selinux_check_access ()
 is used to check if the source context has the access permission for the specified class on the target context.
 
+.BR selinux_check_access_flags ()
+is identical to
+.BR selinux_check_access ()
+but additionally sets the
+.I flags
+field. On return
+.I flags
+must be tested and if
+.BR SELINUX_AVD_FLAGS_UNDEFINED ,
+then the remaining
+.I flags
+should not be checked. Currently one other flag is supported:
+.BR SELINUX_AVD_FLAGS_PERMISSIVE ,
+which indicates the decision is computed on a policy defined permissive domain.
+
 .BR selinux_check_passwd_access ()
 is used to check for a permission in the
 .I passwd
diff --git a/libselinux/man/man3/selinux_check_access_flags.3 b/libselinux/man/man3/selinux_check_access_flags.3
new file mode 100644
index 0000000..a60bca4
--- /dev/null
+++ b/libselinux/man/man3/selinux_check_access_flags.3
@@ -0,0 +1 @@
+.so man3/security_compute_av.3
diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index b1ec57f..87f4c76 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -741,12 +741,27 @@ static void avd_init(struct av_decision *avd)
 	avd->flags = 0;
 }
 
+
 int avc_has_perm_noaudit(security_id_t ssid,
 			 security_id_t tsid,
 			 security_class_t tclass,
 			 access_vector_t requested,
 			 struct avc_entry_ref *aeref, struct av_decision *avd)
 {
+	return avc_has_perm_noaudit_flags(ssid, tsid, tclass,
+					  requested, aeref, avd, NULL);
+}
+
+hidden_def(avc_has_perm_noaudit)
+
+int avc_has_perm_noaudit_flags(security_id_t ssid,
+			       security_id_t tsid,
+			       security_class_t tclass,
+			       access_vector_t requested,
+			       struct avc_entry_ref *aeref,
+			       struct av_decision *avd,
+			       unsigned int *flags)
+{
 	struct avc_entry *ae;
 	int rc = 0;
 	struct avc_entry entry;
@@ -790,13 +805,13 @@ int avc_has_perm_noaudit(security_id_t ssid,
 							   &entry.avd);
 			if (rc && errno == EINVAL && !avc_enforcing) {
 				rc = errno = 0;
-				goto out;
+				goto set_undef;
 			}
 			if (rc)
-				goto out;
+				goto set_undef;
 			rc = avc_insert(ssid, tsid, tclass, &entry, aeref);
 			if (rc)
-				goto out;
+				goto set_undef;
 		}
 		ae = aeref->ae;
 	}
@@ -816,21 +831,38 @@ int avc_has_perm_noaudit(security_id_t ssid,
 		}
 	}
 
-      out:
+	if (flags)
+		*flags = ae->avd.flags;
+out:
 	avc_release_lock(avc_lock);
 	return rc;
+
+set_undef:
+	if (flags)
+		*flags = SELINUX_AVD_FLAGS_UNDEFINED;
+	goto out;
 }
 
-hidden_def(avc_has_perm_noaudit)
+hidden_def(avc_has_perm_noaudit_flags)
 
 int avc_has_perm(security_id_t ssid, security_id_t tsid,
 		 security_class_t tclass, access_vector_t requested,
 		 struct avc_entry_ref *aeref, void *auditdata)
 {
+	return avc_has_perm_flags(ssid, tsid, tclass, requested, aeref,
+				  auditdata, NULL);
+}
+
+int avc_has_perm_flags(security_id_t ssid, security_id_t tsid,
+		       security_class_t tclass, access_vector_t requested,
+		       struct avc_entry_ref *aeref, void *auditdata,
+		       unsigned int *flags)
+{
 	struct av_decision avd;
 	int errsave, rc;
 
-	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, aeref, &avd);
+	rc = avc_has_perm_noaudit_flags(ssid, tsid, tclass,
+				  requested, aeref, &avd, flags);
 	errsave = errno;
 	avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
 	errno = errsave;
diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
index f851659..82781d1 100644
--- a/libselinux/src/avc_internal.h
+++ b/libselinux/src/avc_internal.h
@@ -179,4 +179,5 @@ hidden_proto(avc_av_stats)
     hidden_proto(avc_reset)
     hidden_proto(avc_audit)
     hidden_proto(avc_has_perm_noaudit)
+    hidden_proto(avc_has_perm_noaudit_flags)
 #endif				/* _SELINUX_AVC_INTERNAL_H_ */
diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index 8de5747..0a3d79b 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -1,4 +1,3 @@
-/*-*- Mode: C; c-basic-offset: 8; indent-tabs-mode: nil -*-*/
 #include <unistd.h>
 #include <sys/types.h>
 #include <stdlib.h>
@@ -32,7 +31,16 @@ static void avc_init_once(void)
 	}
 }
 
-int selinux_check_access(const char *scon, const char *tcon, const char *class, const char *perm, void *aux) {
+int selinux_check_access(const char *scon, const char *tcon, const char *class,
+			 const char *perm, void *aux)
+{
+	return selinux_check_access_flags(scon, tcon, class, perm, aux, NULL);
+}
+
+int selinux_check_access_flags(const char *scon, const char *tcon,
+			       const char *class, const char *perm,
+			       void *aux, unsigned int *flags)
+{
 	int rc;
 	security_id_t scon_id;
 	security_id_t tcon_id;
@@ -41,6 +49,13 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
 
 	__selinux_once(once, avc_init_once);
 
+	/* Set flags undefined as avc_has_perm_flags may never get called,
+	 * as either SELinux is disabled or there is an unknown
+	 * class/permission.
+	 */
+	if (flags)
+		*flags = SELINUX_AVD_FLAGS_UNDEFINED;
+
 	if (selinux_enabled != 1)
 		return 0;
 
@@ -54,27 +69,29 @@ int selinux_check_access(const char *scon, const char *tcon, const char *class,
 
 	(void) avc_netlink_check_nb();
 
-       sclass = string_to_security_class(class);
-       if (sclass == 0) {
-	       rc = errno;
-	       avc_log(SELINUX_ERROR, "Unknown class %s", class);
-	       if (security_deny_unknown() == 0)
-		       return 0;
-	       errno = rc;
-	       return -1;
-       }
-
-       av = string_to_av_perm(sclass, perm);
-       if (av == 0) {
-	       rc = errno;
-	       avc_log(SELINUX_ERROR, "Unknown permission %s for class %s", perm, class);
-	       if (security_deny_unknown() == 0)
-		       return 0;
-	       errno = rc;
-	       return -1;
-       }
-
-       return avc_has_perm (scon_id, tcon_id, sclass, av, NULL, aux);
+	sclass = string_to_security_class(class);
+	if (sclass == 0) {
+		rc = errno;
+		avc_log(SELINUX_ERROR, "Unknown class %s", class);
+		if (security_deny_unknown() == 0)
+			return 0;
+		errno = rc;
+		return -1;
+	}
+
+	av = string_to_av_perm(sclass, perm);
+	if (av == 0) {
+		rc = errno;
+		avc_log(SELINUX_ERROR, "Unknown permission %s for class %s",
+			perm, class);
+		if (security_deny_unknown() == 0)
+			return 0;
+		errno = rc;
+		return -1;
+	}
+
+	return avc_has_perm_flags(scon_id, tcon_id, sclass, av, NULL,
+				  aux, flags);
 }
 
 int selinux_check_passwd_access(access_vector_t requested)
diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index ed3bf0b..07c0870 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -25,3 +25,5 @@ selinuxexeccon
 setenforce
 setfilecon
 togglesebool
+avc_has_perm
+selinux_check_access
diff --git a/libselinux/utils/avc_has_perm.c b/libselinux/utils/avc_has_perm.c
new file mode 100644
index 0000000..c144674
--- /dev/null
+++ b/libselinux/utils/avc_has_perm.c
@@ -0,0 +1,235 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+#include <selinux/avc.h>
+
+static void usage(char *progname)
+{
+	fprintf(stderr, "usage:  %s [-f] [-i] [-p] scon tcon class perm\n"
+		"\nWhere:\n\t"
+		"-f  Call avc_has_perm_flags(3) to obtain the avd\n\t"
+		"    flags. Currently only the SELINUX_AVD_FLAGS_PERMISSIVE\n\t"
+		"    flag is defined. If set, signifies the source type is\n\t"
+		"    defined in policy as a PERMISSIVE type.\n\t"
+		"    The default is to call avc_has_perm(3) that\n\t"
+		"    does not request the avd flags.\n\t"
+		"-i  Interactive mode. Once displayed first result, can\n\t"
+		"    enter additional entries and display AVC cache info.\n"
+		"-p  Set avc_open to permissive mode.\n",
+		progname);
+	exit(1);
+}
+
+static void get_entry(char **buffer)
+{
+	char *buf;
+	int len;
+#define BUF_LEN 81
+
+	buf = malloc(BUF_LEN * sizeof(char));
+	if (!buf) {
+		perror("malloc");
+		exit(1);
+	}
+
+	if (fgets(buf, BUF_LEN - 1, stdin) == NULL) {
+		perror("fgets");
+		exit(1);
+	}
+
+	len = strlen(buf);
+	if (buf[len - 1] == '\n')
+		buf[len - 1] = 0;
+
+	*buffer = buf;
+}
+
+/*
+ * Function to print the AVC statistics. Because no audit logging call back
+ * has been set, the avc_cache_stats will be displayed on stderr.
+ */
+static void print_avc_stats(void)
+{
+	struct avc_cache_stats acs;
+
+	avc_cache_stats(&acs);
+	printf("\nThe avc_cache_stats are as follows:\n");
+	printf("entry_hits:     %d\t(Decisions found in aeref)\n",
+	       acs.entry_hits);
+	printf("entry_misses:   %d\t(Decisions not found in aeref)\n",
+	       acs.entry_misses);
+	printf("entry_discards: %d\t(Decisions not found in aeref that were "
+	       "also non-NULL)\n", acs.entry_discards);
+	printf("entry_lookups:  %d\t(Queries made)\n", acs.entry_lookups);
+	printf("cav_lookups:    %d\t(Cache lookups)\n", acs.cav_lookups);
+	printf("cav_hits:       %d\t(Cache hits)\n", acs.cav_hits);
+	printf("cav_probes:     %d\t(Entries examined searching the cache)\n",
+	       acs.cav_probes);
+	printf("cav_misses:     %d\t(Cache misses)\n\n", acs.cav_misses);
+}
+
+struct avc_entry_ref aeref;
+static void exec_func(char *scon, char *tcon, char *class, char *perm,
+		      bool get_flags)
+{
+	int rc;
+	unsigned int flags;
+	context_t context;
+	const char *type;
+	security_id_t scon_id;
+	security_id_t tcon_id;
+	security_class_t sclass;
+	access_vector_t av;
+
+	rc = avc_context_to_sid(scon, &scon_id);
+	if (rc < 0) {
+		perror("Error scon avc_context_to_sid");
+		exit(1);
+	}
+
+	rc = avc_context_to_sid(tcon, &tcon_id);
+	if (rc < 0) {
+		perror("Error tcon avc_context_to_sid");
+		exit(1);
+	}
+
+	sclass = string_to_security_class(class);
+	av = string_to_av_perm(sclass, perm);
+
+	context = context_new(scon);
+	if (!context) {
+		perror("Error context_new");
+		exit(1);
+	}
+	type = context_type_get(context);
+	if (!type) {
+		perror("Error context_type_get");
+		free(context);
+		exit(1);
+	}
+
+	printf("\nAny avc_log error messages are shown on stderr:\n");
+	if (get_flags)
+		rc = avc_has_perm_flags(scon_id, tcon_id, sclass, av, &aeref,
+					NULL, &flags);
+	else
+		rc = avc_has_perm(scon_id, tcon_id, sclass, av, &aeref, NULL);
+	printf("\nEnd of avc_log error messages.\n\n");
+
+	if (rc < 0) {
+		printf("Error %s: %s\n",
+		       get_flags ? "avc_has_perm_flags" : "avc_has_perm",
+		       strerror(errno));
+	} else {
+		printf("Permission ALLOWED.\n");
+	}
+
+	if (get_flags) {
+		if (flags & SELINUX_AVD_FLAGS_UNDEFINED)
+			printf("AVD flags are undefined.\n");
+		else if (flags & SELINUX_AVD_FLAGS_PERMISSIVE)
+			printf("%s is defined in policy as a PERMISSIVE "
+			       "domain.\n", type);
+		else
+			printf("%s is NOT defined in policy as a PERMISSIVE "
+			       "domain.\n", type);
+	}
+	context_free(context);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, rc;
+	bool get_flags = false, interactive = false;
+	char *scon, *tcon, *class, *perm;
+	struct selinux_opt avc_option;
+
+	avc_option.type = AVC_OPT_SETENFORCE;
+	avc_option.value = (char *)1;
+
+	while ((opt = getopt(argc, argv, "fip")) != -1) {
+		switch (opt) {
+		case 'f':
+			get_flags = true;
+			break;
+		case 'i':
+			interactive = true;
+			break;
+		case 'p':
+			avc_option.value = NULL;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 4)
+		usage(argv[0]);
+
+	rc = is_selinux_enabled();
+	if (rc == 0) {
+		printf("SELinux is not enabled.\n");
+		exit(1);
+	} else if (rc == 1) {
+		printf("SELinux is enabled.\n");
+	} else {
+		perror("Error is_selinux_enabled");
+		exit(1);
+	}
+
+	rc = security_getenforce();
+	if (rc == 0)
+		printf("SELinux running in PERMISSIVE mode.\n");
+	else if (rc == 1)
+		printf("SELinux running in ENFORCING mode.\n");
+	else {
+		perror("Error security_getenforce");
+		exit(1);
+	}
+
+	rc = security_deny_unknown();
+	if (rc == 0)
+		printf("Undefined object classes or permissions: ALLOWED.\n");
+	else if (rc == 1)
+		printf("Undefined object classes or permissions: DENIED.\n");
+	else {
+		perror("Error security_deny_unknown");
+		exit(1);
+	}
+
+	if (avc_open(&avc_option, 1)) {
+		perror("Error avc_open");
+		exit(1);
+	}
+
+	if (avc_option.value == NULL)
+		printf("avc_open - PERMISSIVE mode.\n");
+	else
+		printf("avc_open - ENFORCING mode.\n");
+
+	avc_entry_ref_init(&aeref);
+
+	exec_func(argv[optind], argv[optind + 1], argv[optind + 2],
+		  argv[optind + 3], get_flags);
+
+	while (interactive) {
+		printf("\nEnter scon: ");
+		get_entry(&scon);
+		printf("Enter tcon: ");
+		get_entry(&tcon);
+		printf("Enter class: ");
+		get_entry(&class);
+		printf("Enter perm: ");
+		get_entry(&perm);
+
+		exec_func(scon, tcon, class, perm, get_flags);
+		print_avc_stats();
+	}
+
+	exit(0);
+}
diff --git a/libselinux/utils/selinux_check_access.c b/libselinux/utils/selinux_check_access.c
new file mode 100644
index 0000000..06cbaf5
--- /dev/null
+++ b/libselinux/utils/selinux_check_access.c
@@ -0,0 +1,189 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+#include <selinux/avc.h>
+
+static void usage(char *progname)
+{
+	fprintf(stderr, "usage:  %s [-f] [-i] scon tcon class perm\n"
+		"\nWhere:\n\t"
+		"-f  Call selinux_check_access_flags(3) to obtain the avd\n\t"
+		"    flags. Currently only the SELINUX_AVD_FLAGS_PERMISSIVE\n\t"
+		"    flag is defined. If set, signifies the source type is\n\t"
+		"    defined in policy as a PERMISSIVE type.\n\t"
+		"    The default is to call selinux_check_access(3) that\n\t"
+		"    does not request the avd flags.\n\t"
+		"-i  Interactive mode. Once displayed first result, can\n\t"
+		"    enter additional entries and display AVC cache info.\n",
+		progname);
+	exit(1);
+}
+
+static void get_entry(char **buffer)
+{
+	char *buf;
+	int len;
+#define BUF_LEN 81
+
+	buf = malloc(BUF_LEN * sizeof(char));
+	if (!buf) {
+		perror("malloc");
+		exit(1);
+	}
+
+	if (fgets(buf, BUF_LEN - 1, stdin) == NULL) {
+		perror("fgets");
+		exit(1);
+	}
+
+	len = strlen(buf);
+	if (buf[len - 1] == '\n')
+		buf[len - 1] = 0;
+
+	*buffer = buf;
+}
+
+/*
+ * Function to print the AVC statistics. Because no audit logging call back
+ * has been set, the avc_cache_stats will be displayed on stderr.
+ * selinux_check_access* sets aeref = NULL, so do not print these stats.
+ */
+static void print_avc_stats(void)
+{
+	struct avc_cache_stats acs;
+
+	avc_cache_stats(&acs);
+	printf("\nThe avc_cache_stats are as follows:\n");
+	printf("entry_lookups:  %d\t(Queries made)\n", acs.entry_lookups);
+	printf("cav_lookups:    %d\t(Cache lookups)\n", acs.cav_lookups);
+	printf("cav_hits:       %d\t(Cache hits)\n", acs.cav_hits);
+	printf("cav_probes:     %d\t(Entries examined searching the cache)\n",
+	       acs.cav_probes);
+	printf("cav_misses:     %d\t(Cache misses)\n\n", acs.cav_misses);
+}
+
+static void exec_func(char *scon, char *tcon, char *class, char *perm,
+		      bool get_flags)
+{
+	int rc;
+	unsigned int flags;
+	context_t context;
+	const char *type;
+
+	context = context_new(scon);
+	if (!context) {
+		perror("Error context_new");
+		exit(1);
+	}
+	type = context_type_get(context);
+	if (!type) {
+		perror("Error context_type_get");
+		free(context);
+		exit(1);
+	}
+
+	printf("\nAny avc_log error messages are shown on stderr:\n");
+	if (get_flags)
+		rc = selinux_check_access_flags(scon, tcon, class, perm,
+						NULL, &flags);
+	else
+		rc = selinux_check_access(scon, tcon, class, perm, NULL);
+	printf("\nEnd of avc_log error messages.\n\n");
+
+	if (rc < 0)
+		printf("Error %s: %s\n",
+		       get_flags ? "selinux_check_access_flags" :
+		       "selinux_check_access", strerror(errno));
+	else
+		printf("Permission ALLOWED.\n");
+
+	if (get_flags) {
+		if (flags & SELINUX_AVD_FLAGS_UNDEFINED)
+			printf("AVD flags are undefined.\n");
+		else if (flags & SELINUX_AVD_FLAGS_PERMISSIVE)
+			printf("%s is defined in policy as a PERMISSIVE "
+			       "domain.\n", type);
+		else
+			printf("%s is NOT defined in policy as a PERMISSIVE "
+			       "domain.\n", type);
+	}
+	context_free(context);
+}
+
+int main(int argc, char **argv)
+{
+	int opt, rc;
+	bool get_flags = false, interactive = false;
+	char *scon, *tcon, *class, *perm;
+
+	while ((opt = getopt(argc, argv, "fi")) != -1) {
+		switch (opt) {
+		case 'f':
+			get_flags = true;
+			break;
+		case 'i':
+			interactive = true;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if ((argc - optind) != 4)
+		usage(argv[0]);
+
+	rc = is_selinux_enabled();
+	if (rc == 0) {
+		printf("SELinux is not enabled.\n");
+		exit(1);
+	} else if (rc == 1) {
+		printf("SELinux is enabled.\n");
+	} else {
+		perror("Error is_selinux_enabled");
+		exit(1);
+	}
+
+	rc = security_getenforce();
+	if (rc == 0)
+		printf("SELinux running in PERMISSIVE mode.\n");
+	else if (rc == 1)
+		printf("SELinux running in ENFORCING mode.\n");
+	else {
+		perror("Error security_getenforce");
+		exit(1);
+	}
+
+	rc = security_deny_unknown();
+	if (rc == 0)
+		printf("Undefined object classes or permissions: ALLOWED.\n");
+	else if (rc == 1)
+		printf("Undefined object classes or permissions: DENIED.\n");
+	else {
+		perror("Error security_deny_unknown");
+		exit(1);
+	}
+
+	exec_func(argv[optind], argv[optind + 1], argv[optind + 2],
+		  argv[optind + 3], get_flags);
+
+	while (interactive) {
+		printf("\nEnter scon: ");
+		get_entry(&scon);
+		printf("Enter tcon: ");
+		get_entry(&tcon);
+		printf("Enter class: ");
+		get_entry(&class);
+		printf("Enter perm: ");
+		get_entry(&perm);
+
+		exec_func(scon, tcon, class, perm, get_flags);
+		print_avc_stats();
+	}
+
+	exit(0);
+}
-- 
2.9.3
