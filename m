Message-ID: <451C43A2.9050706@us.ibm.com>
Date: Thu, 28 Sep 2006 16:50:26 -0500
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Linux Audit <linux-audit@redhat.com>
Subject: [PATCH] -v3 newrole auditing of failures due to user actions
Content-Type: multipart/mixed;
 boundary="------------090102080109060608010906"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090102080109060608010906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch introduces two new point in the code where audit records are 
generated for newrole. Both points are when the attempt to newrole fails.

The first point is when the default type could not be determine for the 
specified role - this is audited because, as sgrubb pointed out, it is 
currently non-tracked path to probe the policy.

The second point is when the desired context to change to is invalid.

There record format remains unchanged. Failing to validate the desired 
context will result in the old and new contexts being recorded intact to 
the log. For the default type, the old and new contexts have not yet 
been obtained, so they are recorded in the log as XXX_context=?

Changes since version 2 of the patch:
  * Added __attribute__((unused)) to "no-op" inline

Changes since version 1 of the patch:
  * removed wrapping #ifdefs around send_audit_message()
  * provided a "no-op" style function
  * removed -D_GNU_SOURCE from the Makefile (as its defined in the code)
  * fixed the error path of the send_audit_message function

The solution that I have for the "no-op" function is not that pretty, 
but the Makefile is configured with -Werror and a function which doesn't 
use its parameters causes warnings. Is there a better solution to this 
problem?

Signed-off-by: Michael Thompson <thompsmc@us.ibm.com>

----

--------------090102080109060608010906
Content-Type: text/x-diff;
 name="newrole_audit_fail.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newrole_audit_fail.patch"

diff -rNau policycoreutils-1.30.29/newrole/Makefile policycoreutils-1.30.29.orig.dev/newrole/Makefile
--- policycoreutils-1.30.29/newrole/Makefile	2006-09-14 07:07:26.000000000 -0500
+++ policycoreutils-1.30.29.orig.dev/newrole/Makefile	2006-09-28 16:46:47.000000000 -0500
@@ -27,7 +27,7 @@
 	LDLIBS += -laudit
 endif
 ifeq (${LOG_AUDIT_PRIV},y)
-	override CFLAGS += -DLOG_AUDIT_PRIV -D_GNU_SOURCE
+	override CFLAGS += -DLOG_AUDIT_PRIV
 	LDLIBS += -lcap
 	MODE := 4555
 else
diff -rNau policycoreutils-1.30.29/newrole/newrole.c policycoreutils-1.30.29.orig.dev/newrole/newrole.c
--- policycoreutils-1.30.29/newrole/newrole.c	2006-09-14 07:07:26.000000000 -0500
+++ policycoreutils-1.30.29.orig.dev/newrole/newrole.c	2006-09-28 16:46:27.000000000 -0500
@@ -396,6 +396,51 @@
 }
 #endif
 
+#ifdef LOG_AUDIT_PRIV
+/* Send audit message */
+static
+int send_audit_message(int success, security_context_t old_context,
+		       security_context_t new_context, const char *ttyn)
+{
+	char *msg = NULL;
+	int rc;
+	int audit_fd = audit_open();
+
+	if (audit_fd < 0) {
+		fprintf(stderr, _("Error connecting to audit system.\n"));
+		return -1;
+	}
+	if (asprintf(&msg, "newrole: old-context=%s new-context=%s",
+				old_context ? old_context : "?",
+				new_context ? new_context : "?") < 0) {
+		fprintf(stderr, _("Error allocating memory.\n"));
+		rc = -1;
+		goto out;
+	}
+	rc = audit_log_user_message(audit_fd, AUDIT_USER_ROLE_CHANGE,
+			msg, NULL, NULL, ttyn, success);
+	if (rc <= 0) {
+		fprintf(stderr, _("Error sending audit message.\n"));
+		rc = -1;
+		goto out;
+	}
+	rc = 0;
+out:
+	free(msg);
+	close(audit_fd);
+	return rc;
+}
+#else
+static inline
+int send_audit_message(int success __attribute__((unused)),
+		       security_context_t old_context __attribute__((unused)),
+		       security_context_t new_context __attribute__((unused)),
+		       const char *ttyn __attribute__((unused)))
+{
+	return 0;
+}
+#endif
+
 /************************************************************************
  *
  * All code used for both PAM and shadow passwd goes in this section.
@@ -536,6 +581,7 @@
 	if (role_s && !type_s) {
 		if (get_default_type(role_s, &type_s)) {
 			fprintf(stderr, _("Couldn't get default type.\n"));
+			send_audit_message(0, old_context, new_context, ttyn);
 			exit(-1);
 		}
 #ifdef CANTSPELLGDB
@@ -715,6 +761,7 @@
 
 	if (security_check_context(new_context) < 0) {
 		fprintf(stderr, _("%s is not a valid context\n"), new_context);
+		send_audit_message(0, old_context, new_context, ttyn);
 		exit(-1);
 	}
 
@@ -873,32 +920,8 @@
 			new_context);
 		exit(-1);
 	}
-#ifdef LOG_AUDIT_PRIV
-	/* Send audit message */
-	{
-		char *msg;
-		int rc;
-		int audit_fd = audit_open();
-		if (audit_fd < 0) {
-			fprintf(stderr,
-				_("Error connecting to audit system.\n"));
-			exit(-1);
-		}
-		if (asprintf(&msg, "newrole: old-context=%s new-context=%s",
-			     old_context, new_context) < 0) {
-			fprintf(stderr, _("Error allocating memory.\n"));
-			exit(-1);
-		}
-		rc = audit_log_user_message(audit_fd, AUDIT_USER_ROLE_CHANGE,
-					    msg, NULL, NULL, ttyn, 1);
-		if (rc <= 0) {
-			fprintf(stderr, _("Error sending audit message.\n"));
-			exit(-1);
-		}
-		free(msg);
-		close(audit_fd);
-	}
-#endif
+	if (send_audit_message(1, old_context, new_context, ttyn))
+		exit(-1);
 	freecon(old_context);
 	execv(pw->pw_shell, argv + optind - 1);
 

--------------090102080109060608010906--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
