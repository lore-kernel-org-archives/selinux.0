Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7EJs0rT000499
	for <selinux@tycho.nsa.gov>; Sat, 14 Aug 2004 15:54:00 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7EJrxka011140
	for <selinux@tycho.nsa.gov>; Sat, 14 Aug 2004 19:53:59 GMT
Subject: [patch] setting default role from ssh
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Cc: nalin@redhat.com, dwalsh@redhat.com
Content-Type: multipart/mixed; boundary="=-tVErR/SND4hTJtaqQ5IM"
Date: Sat, 14 Aug 2004 15:54:17 -0400
Message-Id: <1092513257.4515.28.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-tVErR/SND4hTJtaqQ5IM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On various occasions I've needed to copy files via ssh/sftp from my
SELinux server that are only accessible by sysadm_r, not staff_r.  For
example, files with type user_home_t.  

A while back in a conversation with Dan we agreed that being able to do
something like:

ssh root:sysadm_r@machine

would be nice.  Now I've finally gotten around to implementing it.  I
discovered when reading the openssh source that it already accepts a ':'
in the username, and extracts it into a variable called "style" in the
authentication context.  After digging a bit more, apparently it's used
only on BSD, for "BSD auth", which I guess is sort of like PAM.  Why you
would want/need users to be able to specify styles, I don't know.

Anyways, this "style" variable, unused on Linux, was easy enough to turn
into a SELinux "role" argument.  I just had to modify a few functions to
pass it down into the SELinux setexeccon and tty relabeling.

Now, looking at the duplicative code in those two sections, I'm thinking
that it would make sense to have a libselinux function for this.
Probably something like:

int
get_default_context_with_role (const char *user, security_context_t fromcon, 
                               const char *role, security_context_t *newcon);


Anyways, updated openssh-selinux.patch attached.  I also attached the
"interdiff" output between them so it's clearer what changed.

Oh, and I also fixed a little typo in the original patch's error
message.


--=-tVErR/SND4hTJtaqQ5IM
Content-Disposition: attachment; filename=openssh-selinux2.patch
Content-Type: text/x-patch; name=openssh-selinux2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- openssh-3.8.1p1/config.h.in.selinux	2004-04-18 08:51:50.000000000 -0400
+++ openssh-3.8.1p1/config.h.in	2004-08-12 00:47:17.689874912 -0400
@@ -263,6 +263,9 @@
 /* Define if you want Kerberos 5 support */
 #undef KRB5
 
+/* Define if have want SELinux support */
+#undef WITH_SELINUX
+
 /* Define this if you are using the Heimdal version of Kerberos V5 */
 #undef HEIMDAL
 
--- openssh-3.8.1p1/contrib/redhat/sshd.init.selinux	2002-05-09 22:19:23.000000000 -0400
+++ openssh-3.8.1p1/contrib/redhat/sshd.init	2004-08-12 00:47:17.692874456 -0400
@@ -35,6 +35,9 @@
 		if $KEYGEN -q -t rsa1 -f $RSA1_KEY -C '' -N '' >&/dev/null; then
 			chmod 600 $RSA1_KEY
 			chmod 644 $RSA1_KEY.pub
+			if [ -x /sbin/restorecon ]; then
+			    /sbin/restorecon $RSA1_KEY.pub
+			fi
 			success $"RSA1 key generation"
 			echo
 		else
@@ -51,6 +54,9 @@
 		if $KEYGEN -q -t rsa -f $RSA_KEY -C '' -N '' >&/dev/null; then
 			chmod 600 $RSA_KEY
 			chmod 644 $RSA_KEY.pub
+			if [ -x /sbin/restorecon ]; then
+			    /sbin/restorecon $RSA_KEY.pub
+			fi
 			success $"RSA key generation"
 			echo
 		else
@@ -67,6 +73,9 @@
 		if $KEYGEN -q -t dsa -f $DSA_KEY -C '' -N '' >&/dev/null; then
 			chmod 600 $DSA_KEY
 			chmod 644 $DSA_KEY.pub
+			if [ -x /sbin/restorecon ]; then
+			    /sbin/restorecon $DSA_KEY.pub
+			fi
 			success $"DSA key generation"
 			echo
 		else
--- openssh-3.8.1p1/configure.ac.selinux	2004-08-12 00:47:17.615886160 -0400
+++ openssh-3.8.1p1/configure.ac	2004-08-12 00:47:17.696873848 -0400
@@ -2160,6 +2160,18 @@
 			[#include <arpa/nameser.h>])
 	])
 
+# Check whether user wants SELinux support
+SELINUX_MSG="no"
+AC_ARG_WITH(selinux,
+	[  --with-selinux   Enable SELinux support],
+	[ if test "x$withval" != "xno" ; then
+		AC_DEFINE(WITH_SELINUX)
+		SELINUX_MSG="yes"
+		AC_CHECK_HEADERS(selinux.h)
+		LIBS="$LIBS -lselinux"
+	fi
+	])
+
 # Check whether user wants Kerberos 5 support
 KRB5_MSG="no"
 AC_ARG_WITH(kerberos5,
@@ -2914,6 +2926,7 @@
 echo "                    Manpage format: $MANTYPE"
 echo "                       PAM support: $PAM_MSG"
 echo "                 KerberosV support: $KRB5_MSG"
+echo "                   SELinux support: $SELINUX_MSG"
 echo "                 Smartcard support: $SCARD_MSG"
 echo "                     S/KEY support: $SKEY_MSG"
 echo "              TCP Wrappers support: $TCPW_MSG"
--- openssh-3.8.1p1/session.h.selinux	2003-10-02 02:12:37.000000000 -0400
+++ openssh-3.8.1p1/session.h	2004-08-12 00:47:17.698873544 -0400
@@ -68,7 +68,7 @@
 Session	*session_new(void);
 Session	*session_by_tty(char *);
 void	 session_close(Session *);
-void	 do_setusercontext(struct passwd *);
+void	 do_setusercontext(struct passwd *, const char *role);
 void	 child_set_env(char ***envp, u_int *envsizep, const char *name,
 		       const char *value);
 
--- openssh-3.8.1p1/session.c.selinux	2004-04-16 08:47:55.000000000 -0400
+++ openssh-3.8.1p1/session.c	2004-08-12 00:47:17.703872784 -0400
@@ -58,6 +58,12 @@
 #include "session.h"
 #include "monitor_wrap.h"
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/get_context_list.h>
+#include <selinux/context.h>
+#endif
+
 #if defined(KRB5) && defined(USE_AFS)
 #include <kafs.h>
 #endif
@@ -1233,7 +1239,7 @@
 
 /* Set login name, uid, gid, and groups. */
 void
-do_setusercontext(struct passwd *pw)
+do_setusercontext(struct passwd *pw, const char *role)
 {
 #ifndef HAVE_CYGWIN
 	if (getuid() == 0 || geteuid() == 0)
@@ -1305,6 +1311,58 @@
 #endif
 	if (getuid() != pw->pw_uid || geteuid() != pw->pw_uid)
 		fatal("Failed to set uids to %u.", (u_int) pw->pw_uid);
+#ifdef WITH_SELINUX
+	if (is_selinux_enabled() > 0) {
+		context_t newcon=NULL;
+		security_context_t scontext;
+		if (get_default_context(pw->pw_name,NULL,&scontext)) {
+			if (security_getenforce() > 0) 
+				fatal("Failed to get default security context for %s.", pw->pw_name);
+			else 
+				error("Failed to get default security context for %s. Continuing in permissve mode", pw->pw_name);
+		} else {
+			if (role != NULL && role[0]) {
+				char *type;
+				if (get_default_type(role, &type) < 0) {
+					if (security_getenforce() > 0) 
+						fatal("Failed to get default type for role %s, user %s.", role, pw->pw_name);
+					else 
+						error("Failed to get default type for role %s, user %s. Continuing in permissive mode", role, pw->pw_name);
+				} else {
+					newcon = context_new(scontext);
+					if (context_role_set(newcon, role) > 0) {
+						context_free(newcon);
+						newcon=NULL;
+						if (security_getenforce() > 0) 
+							fatal("Failed to set role %s for %s.", role, pw->pw_name);
+						else 
+							error("Failed to set role %s for %s. Continuing in permissive mode", role, pw->pw_name);
+					} else if (context_type_set(newcon, type) > 0) {
+						context_free(newcon);
+						newcon=NULL;
+						if (security_getenforce() > 0) 
+							fatal("Failed to set type %s for %s.", role, pw->pw_name);
+						else 
+							error("Failed to set type %s for %s. Continuing in permissive mode", role, pw->pw_name);
+					} else {
+						freecon(scontext);
+						scontext = context_str(newcon);
+					}
+				}
+			}
+			if (setexeccon(scontext)) {
+				if (security_getenforce() > 0) 
+					fatal("Failed to set exec security context %s for %s.", scontext, pw->pw_name);
+				else 
+					error("Failed to set exec security context %s for %s. Continuing in permissive mode", scontext, pw->pw_name);
+			}
+			if (newcon)
+				context_free(newcon);
+			else
+				freecon(scontext);
+		}
+	}
+#endif
 }
 
 static void
@@ -1397,7 +1436,7 @@
 
 	/* Force a password change */
 	if (s->authctxt->force_pwchange) {
-		do_setusercontext(pw);
+		do_setusercontext(pw, s->authctxt->style);
 		child_close_fds();
 		do_pwchange(s);
 		exit(1);
@@ -1422,7 +1461,7 @@
 			do_motd();
 #else /* HAVE_OSF_SIA */
 		do_nologin(pw);
-		do_setusercontext(pw);
+		do_setusercontext(pw, s->authctxt->style);
 #endif /* HAVE_OSF_SIA */
 	}
 
@@ -1731,7 +1770,7 @@
 	tty_parse_modes(s->ttyfd, &n_bytes);
 
 	if (!use_privsep)
-		pty_setowner(s->pw, s->tty);
+		pty_setowner(s->pw, s->tty, s->authctxt->style);
 
 	/* Set window size from the packet. */
 	pty_change_window_size(s->ptyfd, s->row, s->col, s->xpixel, s->ypixel);
--- openssh-3.8.1p1/sshpty.c.selinux	2004-01-21 01:07:17.000000000 -0500
+++ openssh-3.8.1p1/sshpty.c	2004-08-12 00:47:17.705872480 -0400
@@ -22,6 +22,13 @@
 #include "log.h"
 #include "misc.h"
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/flask.h>
+#include <selinux/context.h>
+#include <selinux/get_context_list.h>
+#endif
+
 #ifdef HAVE_PTY_H
 # include <pty.h>
 #endif
@@ -174,7 +181,7 @@
 }
 
 void
-pty_setowner(struct passwd *pw, const char *ttyname)
+pty_setowner(struct passwd *pw, const char *ttyname, const char *role)
 {
 	struct group *grp;
 	gid_t gid;
@@ -196,6 +203,70 @@
 	 * Warn but continue if filesystem is read-only and the uids match/
 	 * tty is owned by root.
 	 */
+#ifdef WITH_SELINUX
+	if (is_selinux_enabled() > 0) {
+		context_t newcon=NULL;
+		security_context_t new_tty_context=NULL, user_context=NULL, old_tty_context=NULL; 
+
+		if (get_default_context(pw->pw_name,NULL,&user_context)) {
+			if (security_getenforce() > 0) 
+				fatal("Failed to get default security context for %s.", pw->pw_name);
+			else 
+				error("Failed to get default security context for %s. Continuing in permissve mode", pw->pw_name);
+		} else {
+			if (role != NULL && role[0]) {
+				char *type;
+				if (get_default_type(role, &type) < 0) {
+					if (security_getenforce() > 0) 
+						fatal("Failed to get default type for role %s, user %s.", role, pw->pw_name);
+					else 
+						error("Failed to get default type for role %s, user %s. Continuing in permissive mode", role, pw->pw_name);
+				} else {
+					newcon = context_new(user_context);
+					if (context_role_set(newcon, role) > 0) {
+						context_free(newcon);
+						newcon=NULL;
+						if (security_getenforce() > 0) 
+							fatal("Failed to set role %s for %s.", role, pw->pw_name);
+						else 
+							error("Failed to set role %s for %s. Continuing in permissive mode", role, pw->pw_name);
+					} else if (context_type_set(newcon, type) > 0) {
+						context_free(newcon);
+						newcon=NULL;
+						if (security_getenforce() > 0) 
+							fatal("Failed to set type %s for %s.", role, pw->pw_name);
+						else 
+							error("Failed to set type %s for %s. Continuing in permissive mode", role, pw->pw_name);
+					} else {
+						freecon(user_context);
+						user_context = context_str(newcon);
+					}
+				}
+			}
+			if (getfilecon(ttyname, &old_tty_context) < 0) {
+				error("getfilecon(%.100s) failed: %.100s", ttyname, strerror(errno));
+			} else {
+				if (security_compute_relabel(user_context,old_tty_context,
+							     SECCLASS_CHR_FILE,
+							     &new_tty_context) != 0) {
+					error("security_compute_relabel(%.100s) failed: %.100s", ttyname,
+					      strerror(errno));
+				} else {
+					if (setfilecon (ttyname, new_tty_context) != 0) 
+						error("setfilecon(%.100s, %s) failed: %.100s",
+						      ttyname, new_tty_context, 
+						      strerror(errno));
+					freecon(new_tty_context);
+				}
+				freecon(old_tty_context);
+			}
+			if (newcon)
+				context_free(newcon);
+			else
+				freecon(user_context);
+		}
+	}
+#endif
 	if (stat(ttyname, &st))
 		fatal("stat(%.100s) failed: %.100s", ttyname,
 		    strerror(errno));
@@ -225,4 +277,5 @@
 				    ttyname, (u_int)mode, strerror(errno));
 		}
 	}
+
 }
--- openssh-3.8.1p1/sshd.c.selinux	2004-08-12 00:47:17.543897104 -0400
+++ openssh-3.8.1p1/sshd.c	2004-08-12 00:47:17.712871416 -0400
@@ -568,7 +568,7 @@
 	    (u_int)pw->pw_gid);
 #if 0
 	/* XXX not ready, too heavy after chroot */
-	do_setusercontext(pw);
+	do_setusercontext(pw, NULL);
 #else
 	gidset[0] = pw->pw_gid;
 	if (setgroups(1, gidset) < 0)
@@ -662,7 +662,7 @@
 	demote_sensitive_data();
 
 	/* Drop privileges */
-	do_setusercontext(authctxt->pw);
+	do_setusercontext(authctxt->pw, authctxt->style);
 
 	/* It is safe now to apply the key state */
 	monitor_apply_keystate(pmonitor);
--- openssh-3.8.1p1/sshpty.h.selinux	2002-03-04 20:53:05.000000000 -0500
+++ openssh-3.8.1p1/sshpty.h	2004-08-12 00:47:17.715870960 -0400
@@ -21,6 +21,6 @@
 void	 pty_release(const char *);
 void	 pty_make_controlling_tty(int *, const char *);
 void	 pty_change_window_size(int, int, int, int, int);
-void	 pty_setowner(struct passwd *, const char *);
+void	 pty_setowner(struct passwd *, const char *, const char *);
 
 #endif				/* SSHPTY_H */
--- openssh-3.8.1p1/monitor.c~	2004-04-14 03:24:30.000000000 -0400
+++ openssh-3.8.1p1/monitor.c	2004-08-12 00:54:56.258161936 -0400
@@ -1227,7 +1227,7 @@
 	res = pty_allocate(&s->ptyfd, &s->ttyfd, s->tty, sizeof(s->tty));
 	if (res == 0)
 		goto error;
-	pty_setowner(authctxt->pw, s->tty);
+	pty_setowner(authctxt->pw, s->tty, authctxt->style);
 
 	buffer_put_int(m, 1);
 	buffer_put_cstring(m, s->tty);

--=-tVErR/SND4hTJtaqQ5IM
Content-Disposition: attachment; filename=openssh-selinux.interdiff
Content-Type: text/x-patch; name=openssh-selinux.interdiff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -u openssh-3.8.1p1/sshpty.c openssh-3.8.1p1/sshpty.c
--- openssh-3.8.1p1/sshpty.c	2004-06-15 13:45:24.834671024 -0400
+++ openssh-3.8.1p1/sshpty.c	2004-08-12 00:47:17.705872480 -0400
@@ -25,6 +25,7 @@
 #ifdef WITH_SELINUX
 #include <selinux/selinux.h>
 #include <selinux/flask.h>
+#include <selinux/context.h>
 #include <selinux/get_context_list.h>
 #endif
 
@@ -180,7 +181,7 @@
 }
 
 void
-pty_setowner(struct passwd *pw, const char *ttyname)
+pty_setowner(struct passwd *pw, const char *ttyname, const char *role)
 {
 	struct group *grp;
 	gid_t gid;
@@ -204,6 +205,7 @@
 	 */
 #ifdef WITH_SELINUX
 	if (is_selinux_enabled() > 0) {
+		context_t newcon=NULL;
 		security_context_t new_tty_context=NULL, user_context=NULL, old_tty_context=NULL; 
 
 		if (get_default_context(pw->pw_name,NULL,&user_context)) {
@@ -212,6 +214,35 @@
 			else 
 				error("Failed to get default security context for %s. Continuing in permissve mode", pw->pw_name);
 		} else {
+			if (role != NULL && role[0]) {
+				char *type;
+				if (get_default_type(role, &type) < 0) {
+					if (security_getenforce() > 0) 
+						fatal("Failed to get default type for role %s, user %s.", role, pw->pw_name);
+					else 
+						error("Failed to get default type for role %s, user %s. Continuing in permissive mode", role, pw->pw_name);
+				} else {
+					newcon = context_new(user_context);
+					if (context_role_set(newcon, role) > 0) {
+						context_free(newcon);
+						newcon=NULL;
+						if (security_getenforce() > 0) 
+							fatal("Failed to set role %s for %s.", role, pw->pw_name);
+						else 
+							error("Failed to set role %s for %s. Continuing in permissive mode", role, pw->pw_name);
+					} else if (context_type_set(newcon, type) > 0) {
+						context_free(newcon);
+						newcon=NULL;
+						if (security_getenforce() > 0) 
+							fatal("Failed to set type %s for %s.", role, pw->pw_name);
+						else 
+							error("Failed to set type %s for %s. Continuing in permissive mode", role, pw->pw_name);
+					} else {
+						freecon(user_context);
+						user_context = context_str(newcon);
+					}
+				}
+			}
 			if (getfilecon(ttyname, &old_tty_context) < 0) {
 				error("getfilecon(%.100s) failed: %.100s", ttyname, strerror(errno));
 			} else {
@@ -229,7 +260,10 @@
 				}
 				freecon(old_tty_context);
 			}
-			freecon(user_context);
+			if (newcon)
+				context_free(newcon);
+			else
+				freecon(user_context);
 		}
 	}
 #endif
diff -u openssh-3.8.1p1/session.c openssh-3.8.1p1/session.c
--- openssh-3.8.1p1/session.c	2004-06-15 13:44:40.179459648 -0400
+++ openssh-3.8.1p1/session.c	2004-08-12 00:47:17.703872784 -0400
@@ -61,6 +61,7 @@
 #ifdef WITH_SELINUX
 #include <selinux/selinux.h>
 #include <selinux/get_context_list.h>
+#include <selinux/context.h>
 #endif
 
 #if defined(KRB5) && defined(USE_AFS)
@@ -1238,7 +1239,7 @@
 
 /* Set login name, uid, gid, and groups. */
 void
-do_setusercontext(struct passwd *pw)
+do_setusercontext(struct passwd *pw, const char *role)
 {
 #ifndef HAVE_CYGWIN
 	if (getuid() == 0 || geteuid() == 0)
@@ -1312,6 +1313,7 @@
 		fatal("Failed to set uids to %u.", (u_int) pw->pw_uid);
 #ifdef WITH_SELINUX
 	if (is_selinux_enabled() > 0) {
+		context_t newcon=NULL;
 		security_context_t scontext;
 		if (get_default_context(pw->pw_name,NULL,&scontext)) {
 			if (security_getenforce() > 0) 
@@ -1319,13 +1321,45 @@
 			else 
 				error("Failed to get default security context for %s. Continuing in permissve mode", pw->pw_name);
 		} else {
+			if (role != NULL && role[0]) {
+				char *type;
+				if (get_default_type(role, &type) < 0) {
+					if (security_getenforce() > 0) 
+						fatal("Failed to get default type for role %s, user %s.", role, pw->pw_name);
+					else 
+						error("Failed to get default type for role %s, user %s. Continuing in permissive mode", role, pw->pw_name);
+				} else {
+					newcon = context_new(scontext);
+					if (context_role_set(newcon, role) > 0) {
+						context_free(newcon);
+						newcon=NULL;
+						if (security_getenforce() > 0) 
+							fatal("Failed to set role %s for %s.", role, pw->pw_name);
+						else 
+							error("Failed to set role %s for %s. Continuing in permissive mode", role, pw->pw_name);
+					} else if (context_type_set(newcon, type) > 0) {
+						context_free(newcon);
+						newcon=NULL;
+						if (security_getenforce() > 0) 
+							fatal("Failed to set type %s for %s.", role, pw->pw_name);
+						else 
+							error("Failed to set type %s for %s. Continuing in permissive mode", role, pw->pw_name);
+					} else {
+						freecon(scontext);
+						scontext = context_str(newcon);
+					}
+				}
+			}
 			if (setexeccon(scontext)) {
 				if (security_getenforce() > 0) 
 					fatal("Failed to set exec security context %s for %s.", scontext, pw->pw_name);
 				else 
-					error("Failed to set exec security context %s for %s. Continueing in permissive mode", scontext, pw->pw_name);
+					error("Failed to set exec security context %s for %s. Continuing in permissive mode", scontext, pw->pw_name);
 			}
-			freecon(scontext);
+			if (newcon)
+				context_free(newcon);
+			else
+				freecon(scontext);
 		}
 	}
 #endif
@@ -1421,7 +1455,7 @@
 
 	/* Force a password change */
 	if (s->authctxt->force_pwchange) {
-		do_setusercontext(pw);
+		do_setusercontext(pw, s->authctxt->style);
 		child_close_fds();
 		do_pwchange(s);
 		exit(1);
@@ -1446,7 +1480,7 @@
 			do_motd();
 #else /* HAVE_OSF_SIA */
 		do_nologin(pw);
-		do_setusercontext(pw);
+		do_setusercontext(pw, s->authctxt->style);
 #endif /* HAVE_OSF_SIA */
 	}
 
@@ -1755,7 +1789,7 @@
 	tty_parse_modes(s->ttyfd, &n_bytes);
 
 	if (!use_privsep)
-		pty_setowner(s->pw, s->tty);
+		pty_setowner(s->pw, s->tty, s->authctxt->style);
 
 	/* Set window size from the packet. */
 	pty_change_window_size(s->ptyfd, s->row, s->col, s->xpixel, s->ypixel);
only in patch2:
unchanged:
--- openssh-3.8.1p1/session.h.selinux	2003-10-02 02:12:37.000000000 -0400
+++ openssh-3.8.1p1/session.h	2004-08-12 00:47:17.698873544 -0400
@@ -68,7 +68,7 @@
 Session	*session_new(void);
 Session	*session_by_tty(char *);
 void	 session_close(Session *);
-void	 do_setusercontext(struct passwd *);
+void	 do_setusercontext(struct passwd *, const char *role);
 void	 child_set_env(char ***envp, u_int *envsizep, const char *name,
 		       const char *value);
 
only in patch2:
unchanged:
--- openssh-3.8.1p1/sshd.c.selinux	2004-08-12 00:47:17.543897104 -0400
+++ openssh-3.8.1p1/sshd.c	2004-08-12 00:47:17.712871416 -0400
@@ -568,7 +568,7 @@
 	    (u_int)pw->pw_gid);
 #if 0
 	/* XXX not ready, too heavy after chroot */
-	do_setusercontext(pw);
+	do_setusercontext(pw, NULL);
 #else
 	gidset[0] = pw->pw_gid;
 	if (setgroups(1, gidset) < 0)
@@ -662,7 +662,7 @@
 	demote_sensitive_data();
 
 	/* Drop privileges */
-	do_setusercontext(authctxt->pw);
+	do_setusercontext(authctxt->pw, authctxt->style);
 
 	/* It is safe now to apply the key state */
 	monitor_apply_keystate(pmonitor);
only in patch2:
unchanged:
--- openssh-3.8.1p1/sshpty.h.selinux	2002-03-04 20:53:05.000000000 -0500
+++ openssh-3.8.1p1/sshpty.h	2004-08-12 00:47:17.715870960 -0400
@@ -21,6 +21,6 @@
 void	 pty_release(const char *);
 void	 pty_make_controlling_tty(int *, const char *);
 void	 pty_change_window_size(int, int, int, int, int);
-void	 pty_setowner(struct passwd *, const char *);
+void	 pty_setowner(struct passwd *, const char *, const char *);
 
 #endif				/* SSHPTY_H */
only in patch2:
unchanged:
--- openssh-3.8.1p1/monitor.c~	2004-04-14 03:24:30.000000000 -0400
+++ openssh-3.8.1p1/monitor.c	2004-08-12 00:54:56.258161936 -0400
@@ -1227,7 +1227,7 @@
 	res = pty_allocate(&s->ptyfd, &s->ttyfd, s->tty, sizeof(s->tty));
 	if (res == 0)
 		goto error;
-	pty_setowner(authctxt->pw, s->tty);
+	pty_setowner(authctxt->pw, s->tty, authctxt->style);
 
 	buffer_put_int(m, 1);
 	buffer_put_cstring(m, s->tty);

--=-tVErR/SND4hTJtaqQ5IM--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
