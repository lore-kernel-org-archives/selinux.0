Subject: port of util-linux login patch to shadow-utils login.c
From: Colin Walters <walters@verbum.org>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-+lptQ62F+F9AZnrNO7CQ"
Message-Id: <1057863925.10910.62.camel@columbia>
Mime-Version: 1.0
Date: 10 Jul 2003 15:05:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+lptQ62F+F9AZnrNO7CQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

I've ported the SELinux 2.5 patch against the login in util-linux to the
login.c in shadow-utils (which is what Debian uses).  This patch could
probably just be appended to the SE patch for shadow-utils.

I've tested it and it appears to work.  



--=-+lptQ62F+F9AZnrNO7CQ
Content-Disposition: attachment; filename=shadow-login-selinux.patch
Content-Type: text/plain; name=shadow-login-selinux.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- shadow-4.0.3.orig/src/login.c	2003-07-09 19:05:06.000000000 -0400
+++ shadow-4.0.3/src/login.c	2003-07-09 18:58:02.000000000 -0400
@@ -63,6 +63,17 @@
 #define MAXHOSTNAMELEN 64
 #endif
=20
+#ifdef WITH_SELINUX
+#include <selinux/get_context_list.h>
+#include <selinux/flask.h>
+#include <selinux/selinux.h>
+
+security_context_t user_context=3DNULL;
+security_context_t ttyn_context=3DNULL;  /* The current context of ttyn de=
vice */
+int selinux_enabled=3D0;
+
+#endif
+
 #ifdef RADIUS
 /*
  * Support for RADIUS authentication based on a hacked util-linux login
@@ -164,6 +175,46 @@
 static struct faillog faillog;
 #endif
=20
+#ifdef WITH_SELINUX
+
+static security_context_t security_label_tty(char *tty, security_context_t=
 usercon) {
+  security_context_t newdev_context=3DNULL; /* The new context of a device=
 */
+  security_context_t prev_context=3DNULL; /* The new context of a device *=
/
+  if (getfilecon(tty, &prev_context) < 0)=20
+    {
+      fprintf(stderr, _("Warning!  Could not get current context for %s, n=
ot relabeling.\n"), tty);
+      syslog(LOG_NOTICE, _("Warning!  Could not get current context for %s=
, not relabeling.\n"), tty);
+      return NULL;
+    }=09
+  if( security_compute_relabel(usercon,prev_context,SECCLASS_CHR_FILE,&new=
dev_context)!=3D0) {
+    fprintf(stderr, _("Warning!  Could not get new context for %s, not rel=
abeling.\n"), tty);
+    syslog(LOG_NOTICE, _("Warning!  Could not get new context for %s, not =
relabeling.\n"), tty);
+      return NULL;
+  }
+  if (setfilecon(tty,newdev_context))=20
+    {
+      fprintf(stderr, _("Warning!  Could not relabel %s with %s, not relab=
eling.\n"), tty,newdev_context);
+      syslog(LOG_NOTICE, _("Warning!  Could not relabel %s with %s, not re=
labeling.\n"), tty,newdev_context);
+      return NULL;
+    }
+  freecon(newdev_context);
+  return prev_context;
+}
+
+static void security_restorelabel_tty(char *tty,security_context_t context=
) {
+  if (context=3D=3DNULL)
+    return;
+
+  if (setfilecon(tty,context))=20
+    {
+      fprintf(stderr, _("Warning!  Could not relabel %s with %s, not relab=
eling.\n"), tty,context);
+      syslog(LOG_NOTICE, _("Warning!  Could not relabel %s with %s, not re=
labeling.\n"), tty,context);
+    }
+  freecon(context);
+  return;
+}
+#endif /* WITH_SELINUX */
+
 /* local function prototypes */
 static void usage (void);
 static void setup_tty (void);
@@ -176,6 +227,7 @@
 static void init_env (void);
 static RETSIGTYPE alarm_handler (int);
=20
+
 /*
  * usage - print login command usage and exit
  *
@@ -892,6 +944,33 @@
 		else
 		        pwent =3D *pwd;
=20
+#ifdef WITH_SELINUX
+		/* Make sure SELINUX is really running on this system */
+		if ((selinux_enabled =3D is_selinux_enabled())) {
+			int ret;
+			security_context_t* contextlist;
+			int num_contexts =3D get_ordered_context_list(pam_user, 0, &contextlist=
);
+			if (num_contexts > 0) {
+				ret =3D query_user_context(contextlist, &user_context);
+				freeconary(contextlist);
+			=09
+				if (ret < 0) {
+					fprintf(stderr, "%s:  query_user_context failed\n", argv[0]);
+					syslog (LOG_ERR,  "%s:  query_user_context failed\n", argv[0]);
+					exit (1);
+				}
+			=09
+			} else {
+				fprintf(stderr, "login: unable to obtain context for %s.\n", pam_user)=
;
+				ret =3D manual_user_enter_context(pam_user, &user_context);
+				if (ret < 0) {
+					syslog (LOG_ERR, "UNABLE TO GET VALID CONTEXT FOR %s", username);
+					exit (1);
+				}
+			}
+		}
+#endif /* WITH_SELINUX */
+
 		retcode =3D pam_setcred (pamh, PAM_ESTABLISH_CRED);
 		PAM_FAIL_CHECK;
=20
@@ -943,6 +1022,7 @@
 		} else {
 			pwent =3D *pwd;
 		}
+
 #ifndef USE_PAM
 #ifdef SHADOWPWD
 		spwd =3D NULL;
@@ -1241,6 +1321,11 @@
 	setup_limits (&pwent);	/* nice, ulimit etc. */
 #endif				/* ! USE_PAM */
 	chown_tty (tty, &pwent);
+#ifdef WITH_SELINUX
+	if (is_selinux_enabled) {
+		ttyn_context =3D security_label_tty (tty, user_context);
+	}
+#endif
=20
 #ifdef LOGIN_FBTAB
 	/*
@@ -1378,6 +1463,18 @@
 	signal (SIGALRM, SIG_DFL);	/* default alarm signal */
 	signal (SIGHUP, SIG_DFL);	/* added this.  --marekm */
=20
+#ifdef WITH_SELINUX
+	if (selinux_enabled) {
+		if (setexeccon(user_context)) {
+			fprintf(stderr, _("Error!  Unable to set executable context %s.\n"), us=
er_context);
+			syslog(LOG_ERR, _("Error!  Unable to set executable context %s.\n"), us=
er_context);
+			exit(3);=20
+		}
+		freecon(user_context);
+	}
+#endif
+=09
+
 #ifdef USE_PAM
 	/*
 	 * We must fork before setuid() because we need to call
@@ -1407,6 +1504,10 @@
 			 */
 			wait (NULL);
 			PAM_END;
+#ifdef WITH_SELINUX
+			fprintf(stderr, "restoring tty %s with context %s\n", tty, ttyn_context=
);
+			security_restorelabel_tty (tty, ttyn_context);
+#endif
 			exit (0);
 		}
 		/* child */
@@ -1422,6 +1523,25 @@
 #ifdef	SHADOWGRP
 	endsgent ();	/* stop access to shadow group file */
 #endif
+#ifdef WITH_SELINUX
+	if (selinux_enabled) {
+		if (pwd->pw_uid =3D=3D 0) {
+			if (hostname)
+				syslog(LOG_NOTICE, _("ROOT LOGIN ON %s FROM %s USING %s"),
+				       tty, fromhost, user_context);
+			else
+				syslog(LOG_NOTICE, _("ROOT LOGIN ON %s USING %s"),
+				       tty, user_context);
+		} else {
+			if (hostname)=20
+				syslog(LOG_INFO, _("LOGIN ON %s BY %s FROM %s USING %s"),
+				       tty, pam_user, fromhost, user_context);
+			else=20
+				syslog(LOG_INFO, _("LOGIN ON %s BY %s USING %s"),
+				       tty, pam_user, user_context);
+		}
+	} else
+#endif
 	if (pwent.pw_uid =3D=3D 0)
 		SYSLOG ((LOG_NOTICE, "ROOT LOGIN %s", fromhost));
 	else if (getdef_bool ("LOG_OK_LOGINS"))

--=-+lptQ62F+F9AZnrNO7CQ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
