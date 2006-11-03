Message-ID: <454A95BC.7000807@us.ibm.com>
Date: Thu, 02 Nov 2006 19:05:00 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Michael C Thompson <thompsmc@us.ibm.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 4/8] make newrole suid (take 3)
References: <454A8F35.2020006@us.ibm.com>
In-Reply-To: <454A8F35.2020006@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090108040801070902040403"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090108040801070902040403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Michael C Thompson wrote:
> The 8 patches are as follows:
> 1) Modifications to Makefile to support future patch needs
>    Add newrole-lspp.pamd
> 2) New extract_pw_data function and use in main()
> 3) Add signal handler function
> 4) Update drop_capabilities() and use in main()

This is the 4th of 8 patches.
This patch applies against policycoreutils-1.30.30-1.

This patch adds expands the drop_capabilities functionality
to support various compile-time options (with audit, with
namespace, or neither).

Changes:
  * Splits drop_capabilities into three versions (compile time option):
    - 'No-cap' version, returns true
    - 'audit-only' version, retains only CAP_AUDIT_WRITE
       Enable with AUDIT_LOG_PRIV=y
    - 'namespace+' version, retains CAP_AUDIT_WRITE, CAP_SYS_ADMIN and
       more to allow namespace actions
       Enable with NAMESPACE_PRIV = y
  * main() calls drop_capabilities unconditionally

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>


--------------090108040801070902040403
Content-Type: text/x-diff;
 name="04-drop_capabilties.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="04-drop_capabilties.patch"

diff -Naur policycoreutils-1.30.30/newrole/newrole.c policycoreutils-1.30.30.suid/newrole/newrole.c
--- policycoreutils-1.30.30/newrole/newrole.c	2006-11-02 12:24:57.000000000 -0600
+++ policycoreutils-1.30.30.suid/newrole/newrole.c	2006-11-02 12:24:19.000000000 -0600
@@ -387,67 +387,138 @@
 	return -1;
 }
 
-/*
+/**
  * This function will drop the capabilities so that we are left
  * only with access to the audit system. If the user is root, we leave
  * the capabilities alone since they already should have access to the
  * audit netlink socket.
+ *
+ * Returns zero on success, non-zero otherwise
  */
-#ifdef LOG_AUDIT_PRIV
-static void drop_capabilities(void)
+#if defined(AUDIT_LOG_PRIV) && !defined(NAMESPACE_PRIV)
+static int drop_capabilities(void)
 {
+	int rc = 0;
+	cap_t new_caps, tmp_caps;
+	cap_value_t cap_list[] = { CAP_AUDIT_WRITE };
+	cap_value_t tmp_cap_list[] = { CAP_AUDIT_WRITE, CAP_SETUID };
 	uid_t uid = getuid();
 
-	if (uid) {		/* Non-root path */
-		cap_t new_caps, tmp_caps;
-		cap_value_t cap_list[] = { CAP_AUDIT_WRITE };
-		cap_value_t tmp_cap_list[] = { CAP_AUDIT_WRITE, CAP_SETUID };
-
-		new_caps = cap_init();
-		tmp_caps = cap_init();
-		if (!new_caps || !tmp_caps) {
-			fprintf(stderr,
-				_("Error initing capabilities, aborting.\n"));
-			exit(-1);
-		}
-		cap_set_flag(new_caps, CAP_PERMITTED, 1, cap_list, CAP_SET);
-		cap_set_flag(new_caps, CAP_EFFECTIVE, 1, cap_list, CAP_SET);
-		cap_set_flag(tmp_caps, CAP_PERMITTED, 2, tmp_cap_list, CAP_SET);
-		cap_set_flag(tmp_caps, CAP_EFFECTIVE, 2, tmp_cap_list, CAP_SET);
+	if (!uid)
+		return 0;
 
-		/* Keep capabilities across uid change */
-		prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
+	/* Non-root caller, suid root path */
+	new_caps = cap_init();
+	tmp_caps = cap_init();
+	if (!new_caps || !tmp_caps) {
+		fprintf(stderr, _("Error initing capabilities, aborting.\n"));
+		return -1;
+	}
+	rc |= cap_set_flag(new_caps, CAP_PERMITTED, 1, cap_list, CAP_SET);
+	rc |= cap_set_flag(new_caps, CAP_EFFECTIVE, 1, cap_list, CAP_SET);
+	rc |= cap_set_flag(tmp_caps, CAP_PERMITTED, 2, tmp_cap_list, CAP_SET);
+	rc |= cap_set_flag(tmp_caps, CAP_EFFECTIVE, 2, tmp_cap_list, CAP_SET);
+	if (rc) {
+		fprintf(stderr, _("Error setting capabilities, aborting\n"));
+		goto out;
+	}
 
-		/* We should still have root's caps, so drop most capabilities now */
-		if (cap_set_proc(tmp_caps)) {
-			fprintf(stderr,
-				_("Error dropping capabilities, aborting\n"));
-			exit(-1);
-		}
-		cap_free(tmp_caps);
+	/* Keep capabilities across uid change */
+	if (prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0)) {
+		fprintf(stderr, _("Error setting KEEPCAPS, aborting\n"));
+		rc = -1;
+		goto out;
+	}
 
-		/* Change uid */
-		if (setresuid(uid, uid, uid)) {
-			fprintf(stderr, _("Error changing uid, aborting.\n"));
-			exit(-1);
-		}
+	/* Does this temporary change really buy us much? */
+	/* We should still have root's caps, so drop most capabilities now */
+	if ((rc = cap_set_proc(tmp_caps))) {
+		fprintf(stderr, _("Error dropping capabilities, aborting\n"));
+		goto out;
+	}
 
-		/* Now get rid of this ability */
-		if (prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0) < 0) {
-			fprintf(stderr,
-				_("Error resetting KEEPCAPS, aborting\n"));
-			exit(-1);
-		}
+	/* Change uid */
+	if ((rc = setresuid(uid, uid, uid))) {
+		fprintf(stderr, _("Error changing uid, aborting.\n"));
+		goto out;
+	}
 
-		/* Finish dropping capabilities. */
-		if (cap_set_proc(new_caps)) {
-			fprintf(stderr,
-				_
-				("Error dropping SETUID capability, aborting\n"));
-			exit(-1);
-		}
-		cap_free(new_caps);
+	/* Now get rid of this ability */
+	if ((rc = prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0) < 0)) {
+		fprintf(stderr, _("Error resetting KEEPCAPS, aborting\n"));
+		goto out;
+	}
+
+	/* Finish dropping capabilities. */
+	if ((rc = cap_set_proc(new_caps))) {
+		fprintf(stderr,
+			_("Error dropping SETUID capability, aborting\n"));
+		goto out;
+	}
+out:
+	if (cap_free(tmp_caps) || cap_free(new_caps))
+		fprintf(stderr, _("Error freeing caps\n"));
+	return rc;
+}
+#elif defined(NAMESPACE_PRIV)
+/**
+ * This function will drop the capabilities so that we are left
+ * only with access to the audit system and the ability to raise
+ * CAP_SYS_ADMIN, CAP_DAC_OVERRIDE, CAP_FOWNER and CAP_CHOWN,
+ * before invoking pam_namespace.  These capabilities are needed
+ * for performing bind mounts/unmounts and to create potential new
+ * instance directories with appropriate DAC attributes. If the
+ * user is root, we leave the capabilities alone since they already
+ * should have access to the audit netlink socket and should have
+ * the ability to create/mount/unmount instance directories.
+ *
+ * Returns zero on success, non-zero otherwise
+ */
+static int drop_capabilities(void)
+{
+	int rc = 0;
+	cap_t new_caps;
+	cap_value_t cap_list[] = { CAP_AUDIT_WRITE, CAP_SETUID,
+				   CAP_SYS_ADMIN, CAP_FOWNER, CAP_CHOWN,
+				   CAP_DAC_OVERRIDE };
+
+	if (!getuid())
+		return 0;
+
+	/* Non-root caller, suid root path */
+	new_caps = cap_init();
+	if (!new_caps) {
+		fprintf(stderr, _("Error initing capabilities, aborting.\n"));
+		return -1;
+	}
+	rc |= cap_set_flag(new_caps, CAP_PERMITTED, 6, cap_list, CAP_SET);
+	rc |= cap_set_flag(new_caps, CAP_EFFECTIVE, 6, cap_list, CAP_SET);
+	if (rc) {
+		fprintf(stderr, _("Error setting capabilities, aborting\n"));
+		goto out;
+	}
+
+	/* Ensure that caps are dropped after setuid call */
+	if ((rc = prctl(PR_SET_KEEPCAPS, 0, 0, 0, 0) < 0)) {
+		fprintf(stderr, _("Error resetting KEEPCAPS, aborting\n"));
+		goto out;
 	}
+
+	/* We should still have root's caps, so drop most capabilities now */
+	if ((rc = cap_set_proc(new_caps))) {
+		fprintf(stderr, _("Error dropping capabilities, aborting\n"));
+		goto out;
+	}
+out:
+	if (cap_free(new_caps))
+		fprintf(stderr, _("Error freeing caps\n"));
+	return rc;
+}
+
+#else
+static inline int drop_capabilities(void)
+{
+	return 0;
 }
 #endif
 
@@ -559,10 +630,15 @@
 	int fd;
 	int enforcing;
 
-#ifdef LOG_AUDIT_PRIV
-	drop_capabilities();
-#endif
-
+	/*
+	 * Step 0: Setup
+	 *
+	 * Do some intial setup, including dropping capabilities, checking
+	 * if it makes sense to continue to run newrole, and setting up
+	 * a scrubbed environment.
+	 */
+	if (drop_capabilities())
+		return -1;
 	if (set_signal_handles())
 		return -1;
 

--------------090108040801070902040403--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
