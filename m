Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA9LoFSf001487
	for <selinux@tycho.nsa.gov>; Sun, 9 Nov 2003 16:50:15 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA9Lnp1W027669
	for <selinux@tycho.nsa.gov>; Sun, 9 Nov 2003 21:49:51 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hA9Lnm5e027666
	for <selinux@tycho.nsa.gov>; Sun, 9 Nov 2003 21:49:49 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id C6E2461BB0
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 08:50:02 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
 by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11431-03 for <selinux@tycho.nsa.gov>;
 Mon, 10 Nov 2003 08:50:00 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id F163661BA7
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 08:49:59 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 6473E925E8
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 08:49:59 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 94FA07F06A
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 08:49:52 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new PAM and policy to match
Date: Mon, 10 Nov 2003 08:49:52 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Aarr/7DvAJaKV1h"
Message-Id: <200311100849.52026.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Aarr/7DvAJaKV1h
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have updated my web site with new policy that greatly restricts access to
/etc/shadow, this relies on a modified version of PAM that has a more capable 
unix_chkpwd implementation with a new program unix_verify to check for 
expired accounts.

It's still a bit experimental at the moment and there is no clear upgrade path 
from an existing SE Linux system (IE an upgrade while in enforcing mode is 
likely to break things).

I hav attached the main PAM patch that I am using, the policy is in the usual 
place.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Aarr/7DvAJaKV1h
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pam.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pam.diff"

--- pam-0.77.orig/Linux-PAM/modules/pam_unix/Makefile
+++ pam-0.77/Linux-PAM/modules/pam_unix/Makefile
@@ -36,13 +36,14 @@
 endif
 
 CHKPWD=unix_chkpwd
+VERIFY=unix_verify
 
-EXTRAS += -DCHKPWD_HELPER=\"$(SUPLEMENTED)/$(CHKPWD)\"
+EXTRAS += -DCHKPWD_HELPER=\"$(SUPLEMENTED)/$(CHKPWD)\" -DVERIFY_HELPER=\"$(SUPLEMENTED)/$(VERIFY)\"
 
 ########################################################################
 
-CFLAGS += $(USE_CRACKLIB) $(USE_LCKPWDF) $(NEED_LCKPWDF) $(EXTRAS)
-LDLIBS = $(EXTRALS)
+CFLAGS += $(USE_CRACKLIB) $(USE_LCKPWDF) $(NEED_LCKPWDF) $(EXTRAS) -DWITH_SELINUX
+LDLIBS = $(EXTRALS) -lselinux
 
 ifdef USE_CRACKLIB
 CRACKLIB = -lcrack
@@ -69,7 +70,7 @@
 
 ########################### don't edit below #######################
 
-all: dirs info $(PLUS) $(LIBSHARED) $(LIBSTATIC) $(CHKPWD) register
+all: dirs info $(PLUS) $(LIBSHARED) $(LIBSTATIC) $(CHKPWD) $(VERIFY) register
 
 dynamic/%.o : %.c
 	$(CC) $(CFLAGS) $(DYNAMIC) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
@@ -125,6 +126,12 @@
 unix_chkpwd.o: unix_chkpwd.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
 
+$(VERIFY): unix_verify.o
+	$(CC) -o $(VERIFY) $^ $(LDLIBS)
+
+unix_verify.o: unix_verify.c
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
+
 md5_good.o: md5.c
 	$(CC) $(CFLAGS) $(CPPFLAGS) -DHIGHFIRST -D'MD5Name(x)=Good##x' \
 		$(TARGET_ARCH) -c $< -o $@
@@ -150,15 +157,17 @@
 endif
 	$(MKDIR) $(FAKEROOT)$(SUPLEMENTED)
 	install -m 4555 $(CHKPWD) $(FAKEROOT)$(SUPLEMENTED)
+	install -m 4555 $(VERIFY) $(FAKEROOT)$(SUPLEMENTED)
 
 remove:
 	rm -f $(FAKEROOT)$(SECUREDIR)/$(LIBSHARED)
 	for x in pam_unix_auth pam_unix_acct pam_unix_passwd pam_unix_session;\
 		do rm -f $(FAKEROOT)$(SECUREDIR)/$$x.so ; done
 	rm -f $(FAKEROOT)$(SUPLEMENTED)/$(CHKPWD)
+	rm -f $(FAKEROOT)$(SUPLEMENTED)/$(VERIFY)
 
 clean:
-	rm -f $(LIBOBJD) $(LIBOBJS) $(CHKPWD) *.o *.so core
+	rm -f $(LIBOBJD) $(LIBOBJS) $(CHKPWD) $(VERIFY) *.o *.so core
 	rm -f *~ *.a *.out *.bak
 	rm -rf dynamic static
 
--- pam-0.77.orig/Linux-PAM/modules/pam_unix/lckpwdf.-c
+++ pam-0.77/Linux-PAM/modules/pam_unix/lckpwdf.-c
@@ -26,6 +26,9 @@
 
 #include <fcntl.h>
 #include <signal.h>
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif
 
 #define LOCKFILE "/etc/.pwd.lock"
 #define TIMEOUT 15
@@ -64,7 +67,29 @@
 	if (lockfd != -1)
 		return -1;
 
-	lockfd = open(LOCKFILE, O_CREAT | O_WRONLY, 0600);
+#ifdef WITH_SELINUX
+	if(is_selinux_enabled())
+	{
+		lockfd = open(LOCKFILE, O_WRONLY);
+		if(lockfd == -1 && errno == ENOENT)
+		{
+			security_context_t create_context;
+			int rc;
+
+			if(getfilecon("/etc/passwd", &create_context))
+				return -1;
+			rc = setfscreatecon(create_context);
+			freecon(create_context);
+			if(rc)
+				return -1;
+			lockfd = open(LOCKFILE, O_CREAT | O_WRONLY, 0600);
+			if(setfscreatecon(NULL))
+				return -1;
+		}
+	}
+	else
+#endif
+		lockfd = open(LOCKFILE, O_CREAT | O_WRONLY, 0600);
 	if (lockfd == -1)
 		return -1;
 	if (set_close_on_exec(lockfd) == -1)
--- pam-0.77.orig/Linux-PAM/modules/pam_unix/pam_unix_acct.c
+++ pam-0.77/Linux-PAM/modules/pam_unix/pam_unix_acct.c
@@ -97,6 +97,8 @@
 		return PAM_USER_UNKNOWN;
 	}
 
+	return _unix_run_verify_binary(pamh, ctrl, uname, pwent->pw_uid);
+#if 0
 	if (!strcmp( pwent->pw_passwd, "*NP*" )) { /* NIS+ */
 		uid_t save_euid, save_uid;
 
@@ -187,6 +189,7 @@
 	D(("all done"));
 
 	return PAM_SUCCESS;
+#endif
 }
 
 
--- pam-0.77.orig/Linux-PAM/modules/pam_unix/pam_unix_passwd.c
+++ pam-0.77/Linux-PAM/modules/pam_unix/pam_unix_passwd.c
@@ -57,6 +57,12 @@
 #include <rpcsvc/yp_prot.h>
 #include <rpcsvc/ypclnt.h>
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+static int selinux_enabled=0;
+static security_context_t prev_context=NULL;
+#endif
+
 #ifdef USE_CRACKLIB
 #include <crack.h>
 #endif
@@ -264,16 +270,34 @@
     }
 
     oldmask = umask(077);
+    if ((selinux_enabled=is_selinux_enabled())) {
+      security_context_t passwd_context=NULL;
+      if (getfilecon("/etc/passwd",&passwd_context)<0) {
+        return PAM_AUTHTOK_ERR;
+      };
+      if (getfscreatecon(&prev_context)<0) {
+        freecon(passwd_context);
+        return PAM_AUTHTOK_ERR;
+      }
+      if (setfscreatecon(passwd_context)) {
+        freecon(passwd_context);
+        freecon(prev_context);
+        return PAM_AUTHTOK_ERR;
+      }
+      freecon(passwd_context);
+    }
     pwfile = fopen(OPW_TMPFILE, "w");
     umask(oldmask);
     if (pwfile == NULL) {
-	return PAM_AUTHTOK_ERR;
+      err = 1;
+      goto done;
     }
 
     opwfile = fopen(OLD_PASSWORDS_FILE, "r");
     if (opwfile == NULL) {
 	fclose(pwfile);
-	return PAM_AUTHTOK_ERR;
+	err = 1;
+	goto done;
     }
 
     chown(OPW_TMPFILE, 0, 0);
@@ -334,8 +358,20 @@
 	err = 1;
     }
 
-    if (!err) {
+done:
+    if (!err)
 	rename(OPW_TMPFILE, OLD_PASSWORDS_FILE);
+#ifdef WITH_SELINUX
+    if (selinux_enabled) {
+      if (setfscreatecon(prev_context)) {
+        err = 1;
+      }
+      if (prev_context)
+        freecon(prev_context);
+      prev_context=NULL;
+    }
+#endif
+    if (!err) {
 	return PAM_SUCCESS;
     } else {
 	unlink(OPW_TMPFILE);
@@ -415,16 +451,37 @@
 	return PAM_USER_UNKNOWN;
     }
     oldmask = umask(077);
+
+#ifdef WITH_SELINUX
+    if ((selinux_enabled=is_selinux_enabled())) {
+      security_context_t shadow_context=NULL;
+      if (getfilecon("/etc/shadow",&shadow_context)<0) {
+        return PAM_AUTHTOK_ERR;
+      };
+      if (getfscreatecon(&prev_context)<0) {
+        freecon(shadow_context);
+        return PAM_AUTHTOK_ERR;
+      }
+      if (setfscreatecon(shadow_context)) {
+        freecon(shadow_context);
+        freecon(prev_context);
+        return PAM_AUTHTOK_ERR;
+      }
+      freecon(shadow_context);
+    }
+#endif
     pwfile = fopen(SH_TMPFILE, "w");
     umask(oldmask);
     if (pwfile == NULL) {
-	return PAM_AUTHTOK_ERR;
+	err = 1;
+	goto done;
     }
 
     opwfile = fopen("/etc/shadow", "r");
     if (opwfile == NULL) {
 	fclose(pwfile);
-	return PAM_AUTHTOK_ERR;
+	err = 1;
+	goto done;
     }
 
     chown(SH_TMPFILE, 0, 0);
@@ -454,8 +511,23 @@
 	err = 1;
     }
 
+ done:
     if (!err) {
 	rename(SH_TMPFILE, "/etc/shadow");
+    }
+
+#ifdef WITH_SELINUX
+    if (selinux_enabled) {
+      if (setfscreatecon(prev_context)) {
+	err = 1;
+      }
+      if (prev_context) 
+	freecon(prev_context);
+      prev_context=NULL;
+    }
+#endif
+
+    if (!err) {
 	return PAM_SUCCESS;
     } else {
 	unlink(SH_TMPFILE);
--- pam-0.77.orig/Linux-PAM/modules/pam_unix/support.c
+++ pam-0.77/Linux-PAM/modules/pam_unix/support.c
@@ -432,7 +432,7 @@
 #include <sys/wait.h>
 
 static int _unix_run_helper_binary(pam_handle_t *pamh, const char *passwd,
-				   unsigned int ctrl, const char *user)
+				   unsigned int ctrl, const char *user, uid_t uid)
 {
     int retval, child, fds[2];
     void (*sighandler)(int) = NULL;
@@ -472,6 +472,9 @@
 	args[0] = x_strdup(CHKPWD_HELPER);
 	args[1] = x_strdup(user);
 
+	if(uid != -1)
+		setreuid(uid, uid);
+
 	execve(CHKPWD_HELPER, args, envp);
 
 	/* should not get here: exit with error */
@@ -497,6 +500,88 @@
 	retval = (retval == 0) ? PAM_SUCCESS:PAM_AUTH_ERR;
     } else {
 	D(("fork failed"));
+	close(fds[0]);
+	close(fds[1]);
+	retval = PAM_AUTH_ERR;
+    }
+
+    if (sighandler != NULL) {
+        (void) signal(SIGCHLD, sighandler);   /* restore old signal handler */
+    }
+
+    D(("returning %d", retval));
+    return retval;
+}
+
+int _unix_run_verify_binary(pam_handle_t *pamh, unsigned int ctrl, const char *user, uid_t uid)
+{
+    int retval, child, fds[2];
+    void (*sighandler)(int) = NULL;
+
+    D(("called."));
+    /* create a pipe for the password */
+    if (pipe(fds) != 0) {
+	D(("could not make pipe"));
+	return PAM_AUTH_ERR;
+    }
+
+    if (off(UNIX_NOREAP, ctrl)) {
+	/*
+	 * This code arranges that the demise of the child does not cause
+	 * the application to receive a signal it is not expecting - which
+	 * may kill the application or worse.
+	 *
+	 * The "noreap" module argument is provided so that the admin can
+	 * override this behavior.
+	 */
+	sighandler = signal(SIGCHLD, SIG_IGN);
+    }
+
+    /* fork */
+    child = fork();
+    if (child == 0) {
+	static char *envp[] = { NULL };
+	char *args[] = { NULL, NULL, NULL };
+
+	/* XXX - should really tidy up PAM here too */
+
+	close(fds[0]);
+	close(0);
+	dup2(fds[1], STDOUT_FILENO);
+
+	/* exec binary helper */
+	args[0] = x_strdup(VERIFY_HELPER);
+	args[1] = x_strdup(user);
+
+	/* set the uid if we are root */
+	if(!getuid() && uid)
+		setreuid(uid, uid);
+
+	execve(VERIFY_HELPER, args, envp);
+
+	/* should not get here: exit with error */
+	D(("helper binary is not available"));
+	exit(PAM_AUTHINFO_UNAVAIL);
+    } else if (child > 0) {
+	char buf[1024];
+	int rc;
+	/* wait for child */
+	close(fds[1]);
+	(void) waitpid(child, &retval, 0);  /* wait for helper to complete */
+	rc = read(fds[0], buf, sizeof(buf) - 1);
+	if(rc > 0)
+	{
+		buf[rc] = '\0';
+		if(!strncmp(buf, "I:", 2))
+			_make_remark(pamh, ctrl, PAM_TEXT_INFO, buf + 2);
+		else
+			_make_remark(pamh, ctrl, PAM_ERROR_MSG, buf);
+	}
+	retval = (retval == 0) ? PAM_SUCCESS:PAM_AUTH_ERR;
+    } else {
+	D(("fork failed"));
+	close(fds[0]);
+	close(fds[1]);
 	retval = PAM_AUTH_ERR;
     }
 
@@ -584,30 +669,13 @@
 
 	retval = PAM_SUCCESS;
 	if (pwd == NULL || salt == NULL || !strcmp(salt, "x")) {
-		if (geteuid()) {
-			/* we are not root perhaps this is the reason? Run helper */
 			D(("running helper binary"));
-			retval = _unix_run_helper_binary(pamh, p, ctrl, name);
+			retval = _unix_run_helper_binary(pamh, p, ctrl, name, pwd ? pwd->pw_uid : -1);
 			if (pwd == NULL && !on(UNIX_AUDIT,ctrl)
 			    && retval != PAM_SUCCESS)
 			{
 				name = NULL;
 			}
-		} else {
-			D(("user's record unavailable"));
-			if (on(UNIX_AUDIT, ctrl)) {
-				/* this might be a typo and the user has given a password
-				   instead of a username. Careful with this. */
-				_log_err(LOG_ALERT, pamh,
-				         "check pass; user (%s) unknown", name);
-			} else {
-				name = NULL;
-				_log_err(LOG_ALERT, pamh,
-				         "check pass; user unknown");
-			}
-			p = NULL;
-			retval = PAM_AUTHINFO_UNAVAIL;
-		}
 	} else {
 	    int salt_len = strlen(salt);
 	    if (!salt_len) {
--- pam-0.77.orig/Linux-PAM/modules/pam_unix/unix_chkpwd.c
+++ pam-0.77/Linux-PAM/modules/pam_unix/unix_chkpwd.c
@@ -87,6 +87,17 @@
 	(void) sigaction(SIGQUIT, &action, NULL);
 }
 
+static uid_t getuidname(const char * const username)
+{
+	struct passwd *pw;
+
+	pw = getpwnam(username);
+	if (pw == NULL)
+		return -1;
+
+	return pw->pw_uid;
+}
+
 static int _unix_verify_password(const char *name, const char *p, int opt)
 {
 	struct passwd *pwd = NULL;
@@ -183,21 +194,6 @@
 	return retval;
 }
 
-static char *getuidname(uid_t uid)
-{
-	struct passwd *pw;
-	static char username[32];
-
-	pw = getpwuid(uid);
-	if (pw == NULL)
-		return NULL;
-
-	strncpy(username, pw->pw_name, sizeof(username));
-	username[sizeof(username) - 1] = '\0';
-	
-	return username;
-}
-
 int main(int argc, char *argv[])
 {
 	char pass[MAXPASS + 1];
@@ -205,7 +201,7 @@
 	int npass, opt;
 	int force_failure = 0;
 	int retval = UNIX_FAILED;
-	char *user;
+	uid_t my_uid;
 
 	/*
 	 * Catch or ignore as many signal as possible.
@@ -221,7 +217,7 @@
 	 * account).
 	 */
 
-	if (isatty(STDIN_FILENO)) {
+	if (isatty(STDIN_FILENO) || argc != 2) {
 
 		_log_err(LOG_NOTICE
 		      ,"inappropriate use of Unix helper binary [UID=%d]"
@@ -236,13 +232,9 @@
 	/*
 	 * determine the current user's name is
 	 */
-	user = getuidname(getuid());
-	if (argc == 2) {
-	    /* if the caller specifies the username, verify that user
-	       matches it */
-	    if (strcmp(user, argv[1])) {
-		force_failure = 1;
-	    }
+	my_uid = getuidname(argv[1]);
+	if (my_uid == -1 || my_uid != getuid()) {
+	    return UNIX_FAILED;
 	}
 
 	/* read the nullok/nonull option */
@@ -276,13 +268,13 @@
 		if (npass == 0) {
 			/* the password is NULL */
 
-			retval = _unix_verify_password(user, NULL, opt);
+			retval = _unix_verify_password(argv[1], NULL, opt);
 
 		} else {
 			/* does pass agree with the official one? */
 
 			pass[npass] = '\0';	/* NUL terminate */
-			retval = _unix_verify_password(user, pass, opt);
+			retval = _unix_verify_password(argv[1], pass, opt);
 
 		}
 	}
--- pam-0.77.orig/Linux-PAM/modules/pam_unix/unix_verify.c
+++ pam-0.77/Linux-PAM/modules/pam_unix/unix_verify.c
@@ -0,0 +1,252 @@
+/*
+ * $Id: unix_chkpwd.c,v 1.9 2002/09/23 17:33:22 agmorgan Exp $
+ *
+ * This program is designed to run setuid(root) or with sufficient
+ * privilege to read all of the unix password databases. It is designed
+ * to provide a mechanism for the current user (defined by this
+ * process' uid) to verify their own password.
+ *
+ * The password is read from the standard input. The exit status of
+ * this program indicates whether the user is authenticated or not.
+ *
+ * Copyright information is located at the end of the file.
+ *
+ */
+
+#include <security/_pam_aconf.h>
+
+#ifdef MEMORY_DEBUG
+# undef exit
+# undef strdup
+# undef free
+#endif /* MEMORY_DEBUG */
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syslog.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <pwd.h>
+#include <shadow.h>
+#include <signal.h>
+#include <security/_pam_types.h>
+#include <time.h>
+
+#include <security/_pam_macros.h>
+
+#define UNIX_PASSED	0
+#define UNIX_FAILED	1
+
+/* syslogging function for errors and other information */
+
+static void _log_err(int err, const char *format,...)
+{
+	va_list args;
+
+	va_start(args, format);
+	openlog("unix_chkpwd", LOG_CONS | LOG_PID, LOG_AUTH);
+	vsyslog(err, format, args);
+	va_end(args);
+	closelog();
+}
+
+static void su_sighandler(int sig)
+{
+	if (sig > 0) {
+		_log_err(LOG_NOTICE, "caught signal %d.", sig);
+		exit(sig);
+	}
+}
+
+static void setup_signals(void)
+{
+	struct sigaction action;	/* posix signal structure */
+
+	/*
+	 * Setup signal handlers
+	 */
+	(void) memset((void *) &action, 0, sizeof(action));
+	action.sa_handler = su_sighandler;
+	action.sa_flags = SA_RESETHAND;
+	(void) sigaction(SIGILL, &action, NULL);
+	(void) sigaction(SIGTRAP, &action, NULL);
+	(void) sigaction(SIGBUS, &action, NULL);
+	(void) sigaction(SIGSEGV, &action, NULL);
+	action.sa_handler = SIG_IGN;
+	action.sa_flags = 0;
+	(void) sigaction(SIGTERM, &action, NULL);
+	(void) sigaction(SIGHUP, &action, NULL);
+	(void) sigaction(SIGINT, &action, NULL);
+	(void) sigaction(SIGQUIT, &action, NULL);
+}
+
+static uid_t getuidname(const char * const username)
+{
+	struct passwd *pw;
+
+	pw = getpwnam(username);
+	if (pw == NULL)
+		return -1;
+
+	return pw->pw_uid;
+}
+
+
+static int verify_account(const char * const uname)
+{
+	int daysleft;
+	time_t curdays;
+	struct spwd *spent;
+	struct passwd *pwent;
+	char buf[80];
+
+	pwent = getpwnam(uname);
+	if (!pwent) {
+		_log_err(LOG_ALERT, "could not identify user (from getpwnam(%s))", uname);
+		return PAM_USER_UNKNOWN;
+	}
+
+	if (!strcmp( pwent->pw_passwd, "*NP*" )) { /* NIS+ */
+		uid_t save_euid, save_uid;
+
+		save_euid = geteuid();
+		save_uid = getuid();
+		if (save_uid == pwent->pw_uid)
+			setreuid( save_euid, save_uid );
+		else  {
+			setreuid( 0, -1 );
+			if (setreuid( -1, pwent->pw_uid ) == -1) {
+				setreuid( -1, 0 );
+				setreuid( 0, -1 );
+				if(setreuid( -1, pwent->pw_uid ) == -1)
+					return PAM_CRED_INSUFFICIENT;
+			}
+		}
+		spent = getspnam( uname );
+		if (save_uid == pwent->pw_uid)
+			setreuid( save_uid, save_euid );
+		else {
+			if (setreuid( -1, 0 ) == -1)
+			setreuid( save_uid, -1 );
+			setreuid( -1, save_euid );
+		}
+
+	} else if (!strcmp( pwent->pw_passwd, "x" )) {
+		spent = getspnam(uname);
+	} else if ((spent = getspnam(uname)) == NULL) {
+		return PAM_SUCCESS;
+	}
+
+	if (!spent)
+		return PAM_AUTHINFO_UNAVAIL;	/* Couldn't get username from shadow */
+
+	curdays = time(NULL) / (60 * 60 * 24);
+	if ((curdays > spent->sp_expire) && (spent->sp_expire != -1)
+	    && (spent->sp_expire != 0) && (spent->sp_lstchg != 0)) {
+		_log_err(LOG_NOTICE, "account %s has expired (account expired)", uname);
+		printf("Your account has expired; please contact your system administrator");
+		return PAM_ACCT_EXPIRED;
+	}
+	if ((curdays > (spent->sp_lstchg + spent->sp_max + spent->sp_inact))
+	    && (spent->sp_max != -1) && (spent->sp_max != 0) && (spent->sp_inact != -1)
+	    && (spent->sp_inact != 0) && (spent->sp_lstchg != 0)) {
+		_log_err(LOG_NOTICE, "account %s has expired (failed to change password)", uname);
+		printf("Your account has expired; please contact your system administrator");
+		return PAM_ACCT_EXPIRED;
+	}
+	if (spent->sp_lstchg == 0) {
+		_log_err(LOG_NOTICE, "expired password for user %s (root enforced)", uname);
+		printf("You are required to change your password immediately (root enforced)");
+		return PAM_NEW_AUTHTOK_REQD;
+	}
+	if (((spent->sp_lstchg + spent->sp_max) < curdays) && (spent->sp_max != -1)
+	    && (spent->sp_max != 0)) {
+		_log_err(LOG_DEBUG, "expired password for user %s (password aged)", uname);
+		printf("You are required to change your password immediately (password aged)");
+		return PAM_NEW_AUTHTOK_REQD;
+	}
+	if ((curdays > (spent->sp_lstchg + spent->sp_max - spent->sp_warn))
+	    && (spent->sp_max != -1) && (spent->sp_warn != -1)
+	    && (spent->sp_max != 0) && (spent->sp_warn != 0)) {
+		daysleft = (spent->sp_lstchg + spent->sp_max) - curdays;
+		_log_err(LOG_DEBUG, "password for user %s will expire in %d days", uname, daysleft);
+		snprintf(buf, 80, "I:Warning: your password will expire in %d day%.2s",
+			 daysleft, daysleft == 1 ? "" : "s");
+		printf(buf);
+	}
+
+	return UNIX_PASSED;
+}
+
+int main(int argc, char *argv[])
+{
+	uid_t my_uid;
+
+	/*
+	 * Catch or ignore as many signal as possible.
+	 */
+	setup_signals();
+
+	/*
+	 * we establish that this program is running with non-tty stdin.
+	 * this is to discourage casual use.
+	 */
+
+	if (isatty(STDIN_FILENO) || argc != 2) {
+
+		_log_err(LOG_NOTICE
+		      ,"inappropriate use of Unix helper binary [UID=%d]"
+			 ,getuid());
+		fprintf(stderr
+		 ,"This binary is not designed for running in this way\n"
+		      "-- the system administrator has been informed\n");
+		sleep(10);	/* this should discourage/annoy the user */
+		return UNIX_FAILED;
+	}
+
+	/*
+	 * determine the current user's name is
+	 */
+	my_uid = getuidname(argv[1]);
+	if (my_uid == -1 || my_uid != getuid())
+	    return UNIX_FAILED;
+
+	return verify_account(argv[1]);
+}
+
+/*
+ * Copyright (c) Andrew G. Morgan, 1996. All rights reserved
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, and the entire permission notice in its entirety,
+ *    including the disclaimer of warranties.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ * 3. The name of the author may not be used to endorse or promote
+ *    products derived from this software without specific prior
+ *    written permission.
+ * 
+ * ALTERNATIVELY, this product may be distributed under the terms of
+ * the GNU Public License, in which case the provisions of the GPL are
+ * required INSTEAD OF the above restrictions.  (This clause is
+ * necessary due to a potential bad interaction between the GPL and
+ * the restrictions contained in a BSD-style copyright.)
+ * 
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
+ * OF THE POSSIBILITY OF SUCH DAMAGE.
+ */

--Boundary-00=_Aarr/7DvAJaKV1h--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
