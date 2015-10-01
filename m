From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] Fix newrole to not drop capabilities from the bounding
 set.
Date: Thu,  1 Oct 2015 15:51:29 -0400
Message-Id: <1443729091-9496-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Dan Walsh <dwalsh@redhat.com>

Stop dropping capabilities from its children.
Add better error messages.

Signed-off-by: Dan Walsh <dwalsh@redhat.com>
---
 policycoreutils/newrole/newrole.c | 60 +++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 1882cc8..55e8d39 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -546,9 +546,7 @@ static int drop_capabilities(int full)
 	if (!uid) return 0;
 
 	capng_setpid(getpid());
-	capng_clear(CAPNG_SELECT_BOTH);
-	if (capng_lock() < 0) 
-		return -1;
+	capng_clear(CAPNG_SELECT_CAPS);
 
 	/* Change uid */
 	if (setresuid(uid, uid, uid)) {
@@ -557,7 +555,7 @@ static int drop_capabilities(int full)
 	}
 	if (! full) 
 		capng_update(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED, CAP_AUDIT_WRITE);
-	return capng_apply(CAPNG_SELECT_BOTH);
+	return capng_apply(CAPNG_SELECT_CAPS);
 }
 #elif defined(NAMESPACE_PRIV)
 /**
@@ -575,20 +573,21 @@ static int drop_capabilities(int full)
  */
 static int drop_capabilities(int full)
 {
+	uid_t uid = getuid();
+	if (!uid) return 0;
+
 	capng_setpid(getpid());
-	capng_clear(CAPNG_SELECT_BOTH);
-	if (capng_lock() < 0) 
-		return -1;
+	capng_clear(CAPNG_SELECT_CAPS);
 
-	uid_t uid = getuid();
 	/* Change uid */
 	if (setresuid(uid, uid, uid)) {
 		fprintf(stderr, _("Error changing uid, aborting.\n"));
 		return -1;
 	}
 	if (! full) 
-		capng_updatev(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED, CAP_SYS_ADMIN , CAP_FOWNER , CAP_CHOWN, CAP_DAC_OVERRIDE, CAP_SETPCAP, -1);
-	return capng_apply(CAPNG_SELECT_BOTH);
+		capng_updatev(CAPNG_ADD, CAPNG_EFFECTIVE | CAPNG_PERMITTED, CAP_SYS_ADMIN , CAP_FOWNER , CAP_CHOWN, CAP_DAC_OVERRIDE, CAP_AUDIT_WRITE, -1);
+	
+	return capng_apply(CAPNG_SELECT_CAPS);
 }
 
 #else
@@ -679,7 +678,7 @@ static int relabel_tty(const char *ttyn, security_context_t new_context,
 		       security_context_t * tty_context,
 		       security_context_t * new_tty_context)
 {
-	int fd;
+	int fd, rc;
 	int enforcing = security_getenforce();
 	security_context_t tty_con = NULL;
 	security_context_t new_tty_con = NULL;
@@ -698,7 +697,13 @@ static int relabel_tty(const char *ttyn, security_context_t new_context,
 		fprintf(stderr, _("Error!  Could not open %s.\n"), ttyn);
 		return fd;
 	}
-	fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+	/* this craziness is to make sure we cann't block on open and deadlock */
+	rc = fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+	if (rc) {
+		fprintf(stderr, _("Error!  Could not clear O_NONBLOCK on %s\n"), ttyn);
+		close(fd);
+		return rc;
+	}
 
 	if (fgetfilecon(fd, &tty_con) < 0) {
 		fprintf(stderr, _("%s!  Could not get current context "
@@ -1009,9 +1014,9 @@ int main(int argc, char *argv[])
 	int fd;
 	pid_t childPid = 0;
 	char *shell_argv0 = NULL;
+	int rc;
 
 #ifdef USE_PAM
-	int rc;
 	int pam_status;		/* pam return code */
 	pam_handle_t *pam_handle;	/* opaque handle used by all PAM functions */
 
@@ -1222,18 +1227,26 @@ int main(int argc, char *argv[])
 			fprintf(stderr, _("Could not close descriptors.\n"));
 			goto err_close_pam;
 		}
-		fd = open(ttyn, O_RDWR | O_NONBLOCK);
+		fd = open(ttyn, O_RDONLY | O_NONBLOCK);
 		if (fd != 0)
 			goto err_close_pam;
-		fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+		rc = fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+		if (rc)
+			goto err_close_pam;
+
 		fd = open(ttyn, O_RDWR | O_NONBLOCK);
 		if (fd != 1)
 			goto err_close_pam;
-		fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+		rc = fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+		if (rc)
+			goto err_close_pam;
+
 		fd = open(ttyn, O_RDWR | O_NONBLOCK);
 		if (fd != 2)
 			goto err_close_pam;
-		fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+		rc = fcntl(fd, F_SETFL, fcntl(fd, F_GETFL, 0) & ~O_NONBLOCK);
+		if (rc)
+			goto err_close_pam;
 
 	}
 	/*
@@ -1267,19 +1280,24 @@ int main(int argc, char *argv[])
 	}
 #endif
 
-	if (send_audit_message(1, old_context, new_context, ttyn))
+	if (send_audit_message(1, old_context, new_context, ttyn)) {
+		fprintf(stderr, _("Failed to send audit message"));
 		goto err_close_pam_session;
+	}
 	freecon(old_context); old_context=NULL;
 	freecon(new_context); new_context=NULL;
 
 #ifdef NAMESPACE_PRIV
-	if (transition_to_caller_uid())
+	if (transition_to_caller_uid()) {
+		fprintf(stderr, _("Failed to transition to namespace\n"));
 		goto err_close_pam_session;
+	}
 #endif
 
-	if (drop_capabilities(TRUE))
+	if (drop_capabilities(TRUE)) {
+		fprintf(stderr, _("Failed to drop capabilities %m\n"));
 		goto err_close_pam_session;
-
+	}
 	/* Handle environment changes */
 	if (restore_environment(preserve_environment, old_environ, &pw)) {
 		fprintf(stderr, _("Unable to restore the environment, "
-- 
2.1.0
