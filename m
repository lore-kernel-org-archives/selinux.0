Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0CM5nfC002841
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 17:05:49 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0CM6dd4000561
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 22:06:39 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l0CM6429030702
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 17:06:04 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l0CM649w027349
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 17:06:04 -0500
Received: from [10.12.32.53] (redsox.boston.devel.redhat.com [10.12.32.53])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l0CM63d1027535
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2007 17:06:03 -0500
Message-ID: <45A8064F.60900@redhat.com>
Date: Fri, 12 Jan 2007 17:06:07 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: I tried to extract the current openssh patch for RHEL5 
Content-Type: multipart/mixed;
 boundary="------------090300030309030107030503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090300030309030107030503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here it is, we are applying this along with many other patches to
openssh-4.3p2-noacss.tar

--------------090300030309030107030503
Content-Type: text/x-patch;
 name="openssh-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openssh-selinux.patch"

--- openssh-4.3p2/selinux.c.orig	2007-01-12 16:59:56.596199798 -0500
+++ openssh-4.3p2/selinux.c	2007-01-12 16:59:48.047760393 -0500
@@ -0,0 +1,219 @@
+#include "includes.h"
+#include "auth.h"
+#include "log.h"
+#include "xmalloc.h"
+
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/flask.h>
+#include <selinux/context.h>
+#include <selinux/get_context_list.h>
+#include <selinux/get_default_type.h>
+#include <selinux/av_permissions.h>
+
+#ifdef HAVE_LINUX_AUDIT
+#include <libaudit.h>
+#include <sys/select.h>
+#include <errno.h>
+#endif
+
+extern Authctxt *the_authctxt;
+extern int inetd_flag;
+extern int rexeced_flag;
+
+/* Send audit message */
+static int send_audit_message(int success, security_context_t default_context,
+		       security_context_t selected_context)
+{
+	int rc=0;
+#ifdef HAVE_LINUX_AUDIT
+	char *msg = NULL;
+	int audit_fd = audit_open();
+	security_context_t default_raw=NULL;
+	security_context_t selected_raw=NULL;
+	rc = -1;
+	if (audit_fd < 0) {
+		if (errno == EINVAL || errno == EPROTONOSUPPORT ||
+                                        errno == EAFNOSUPPORT)
+                        return 0; /* No audit support in kernel */
+		error("Error connecting to audit system.");
+		return rc;
+	}
+	if (selinux_trans_to_raw_context(default_context, &default_raw) < 0) {
+		error("Error translating default context.");
+		goto out;
+	}
+	if (selinux_trans_to_raw_context(selected_context, &selected_raw) < 0) {
+		error("Error translating selected context.");
+		goto out;
+	}
+	if (asprintf(&msg, "sshd: default-context=%s selected-context=%s",
+		     default_context ? default_raw : "?",
+		     selected_context ? selected_raw : "?") < 0) {
+		error("Error allocating memory.");
+		goto out;
+	}
+	if (audit_log_user_message(audit_fd, AUDIT_USER_ROLE_CHANGE,
+				   msg, NULL, NULL, NULL, success) <= 0) {
+		error("Error sending audit message.");
+		goto out;
+	}
+	rc = 0;
+      out:
+	free(msg);
+	freecon(default_raw);
+	freecon(selected_raw);
+	close(audit_fd);
+#endif
+	return rc;
+}
+/* from Linux-PAM-0.99.6.2/modules/pam_selinux/pam_selinux.c */
+static int mls_range_allowed(security_context_t src, security_context_t dst)
+{
+	struct av_decision avd;
+	int retval;
+	unsigned int bit = CONTEXT__CONTAINS;
+
+	retval = security_compute_av(src, dst, SECCLASS_CONTEXT, bit, &avd);
+	if (retval || ((bit & avd.allowed) != bit))
+		return 0;
+
+	return 1;
+}
+
+static int get_user_context(const char *user, const char *role, const char *level,
+	security_context_t *context) {
+	if (role != NULL && role[0]) 
+		return get_default_context_with_rolelevel(user, role, level, NULL, context);
+	else
+		return get_default_context_with_level(user, level, NULL, context);
+}
+
+static const security_context_t selinux_get_user_context(const char *name) {
+	security_context_t user_context=NULL;
+	security_context_t default_context=NULL;
+	char *seuser=NULL;
+	char *role=NULL;
+	int ret=-1;
+	char *dlevel=NULL;
+	const char *rlevel=NULL;
+	context_t con=NULL;
+
+	if (the_authctxt) {
+		if (the_authctxt->role != NULL) {
+			char *slash;
+			role = xstrdup(the_authctxt->role);
+			if ((slash = strchr(role, '/')) != NULL) {
+				*slash = '\0';
+				rlevel = slash + 1;
+			}
+		}
+	}
+	
+	ret = getseuserbyname(name, &seuser, &dlevel);
+	
+	if (ret >= 0) {
+		ret = get_user_context(seuser, role, dlevel, &default_context);
+	}
+	
+	if (ret >= 0) {
+		/* If launched from xinetd, we must use current level */
+		if (inetd_flag && !rexeced_flag) {
+			security_context_t sshd_context=NULL;
+
+			if (getcon(&sshd_context) < 0)
+				fatal("failed to allocate security context");
+
+			con = context_new(sshd_context);
+			rlevel = context_range_get(con);
+			freecon(sshd_context);
+
+			debug("selinux_get_user_context: current connection level '%s'", rlevel);
+		}
+		
+		if (rlevel != NULL && rlevel[0]) {
+			ret = get_user_context(seuser, role, rlevel, &user_context);
+		
+			if (ret >= 0) {
+				if (mls_range_allowed(default_context, user_context)) {
+					send_audit_message(1, default_context, user_context);
+					logit("permit MLS level %s (user range %s)", rlevel, dlevel);
+				} else {
+					send_audit_message(0, default_context, user_context);
+					if (security_getenforce() > 0) 
+						fatal("deny MLS level %s (user range %s)", rlevel, dlevel);
+					else 
+						error("deny MLS level %s (user range %s). Continuing in permissive mode", rlevel, dlevel);
+				}
+			}
+			freecon(default_context);
+		} else {
+			user_context = default_context;
+		}
+	}
+
+	if ( ret < 0 ) {
+		if (security_getenforce() > 0) 
+			fatal("Failed to get default security context for %s.", name);
+		else 
+			error("Failed to get default security context for %s. Continuing in permissive mode", name);
+	}
+	
+	if (con)
+		context_free(con);
+	free(role);
+	free(seuser);
+	free(dlevel);
+	return user_context;
+}
+
+void setup_selinux_pty(const char *name, const char *tty) {
+	if (is_selinux_enabled() > 0) {
+		security_context_t new_tty_context=NULL, user_context=NULL, old_tty_context=NULL; 
+
+		if (getexeccon(&user_context) < 0) {
+			error("getexeccon() failed: %.100s", strerror(errno));
+			return;
+		}
+
+		if (getfilecon(tty, &old_tty_context) < 0) {
+			error("getfilecon(%.100s) failed: %.100s", tty, strerror(errno));
+		} else {
+			debug("user_context: %s old_tty_context: %s", user_context, old_tty_context);
+			if (security_compute_relabel(user_context,old_tty_context,
+						     SECCLASS_CHR_FILE,
+						     &new_tty_context) != 0) {
+				error("security_compute_relabel(%.100s) failed: %.100s", tty,
+				      strerror(errno));
+			} else {
+				if (setfilecon (tty, new_tty_context) != 0) 
+					error("setfilecon(%.100s, %s) failed: %.100s",
+					      tty, new_tty_context, 
+					      strerror(errno));
+				freecon(new_tty_context);
+			}
+			freecon(old_tty_context);
+		}
+		if (user_context) {
+			freecon(user_context);
+		}
+	}
+}
+
+void setup_selinux_exec_context(char *name) {
+
+	if (is_selinux_enabled() > 0) {
+		security_context_t user_context=selinux_get_user_context(name);
+		if (setexeccon(user_context)) {
+			if (security_getenforce() > 0) 
+				fatal("Failed to set exec security context %s for %s.", user_context, name);
+			else 
+				error("Failed to set exec security context %s for %s. Continuing in permissive mode", user_context, name);
+		}
+		if (user_context) {
+			freecon(user_context);
+		}
+	}
+}
+
+#endif /* WITH_SELINUX */
--- openssh-4.3p2/sshd.c.orig	2005-12-23 22:59:12.000000000 -0500
+++ openssh-4.3p2/sshd.c	2007-01-12 17:00:19.948936547 -0500
@@ -85,6 +85,7 @@
 #include "monitor.h"
 #include "monitor_wrap.h"
 #include "monitor_fdpass.h"
+#include "selinux.h"
 
 #ifdef LIBWRAP
 #include <tcpd.h>
@@ -1740,6 +1741,8 @@
 	audit_event(SSH_AUTH_SUCCESS);
 #endif
 
+	setup_selinux_exec_context(authctxt->pw->pw_name); 
+
 	/*
 	 * In privilege separation, we fork another child and prepare
 	 * file descriptor passing.
--- /dev/null	2007-01-11 23:35:45.895627745 -0500
+++ openssh-4.3p2/selinux.h	2007-01-12 16:58:22.912302633 -0500
@@ -0,0 +1,10 @@
+#ifndef __SELINUX_H_
+#define __SELINUX_H_
+#ifdef WITH_SELINUX
+extern void setup_selinux_pty(const char *name, const char *tty);
+extern void setup_selinux_exec_context(const char *name);
+#else
+static inline void setup_selinux_pty(const char *name, const char *tty) {}
+static inline void setup_selinux_exec_context(const char *name) {} 
+#endif /* WITH_SELINUX */
+#endif /* __SELINUX_H_ */
--- openssh-4.3p2/monitor_wrap.h.orig	2005-02-08 05:52:48.000000000 -0500
+++ openssh-4.3p2/monitor_wrap.h	2007-01-12 16:58:22.912302633 -0500
@@ -44,6 +44,7 @@
 DH *mm_choose_dh(int, int, int);
 int mm_key_sign(Key *, u_char **, u_int *, u_char *, u_int);
 void mm_inform_authserv(char *, char *);
+void mm_inform_authrole(char *);
 struct passwd *mm_getpwnamallow(const char *);
 char *mm_auth2_read_banner(void);
 int mm_auth_password(struct Authctxt *, char *);
--- openssh-4.3p2/auth.h.orig	2005-07-06 21:50:20.000000000 -0400
+++ openssh-4.3p2/auth.h	2007-01-12 16:58:22.912302633 -0500
@@ -58,6 +58,7 @@
 	char		*service;
 	struct passwd	*pw;		/* set if 'valid' */
 	char		*style;
+	char		*role;
 	void		*kbdintctxt;
 #ifdef BSD_AUTH
 	auth_session_t	*as;
--- openssh-4.3p2/configure.ac.orig	2006-02-08 06:11:06.000000000 -0500
+++ openssh-4.3p2/configure.ac	2007-01-12 16:58:22.912302633 -0500
@@ -2952,6 +2952,28 @@
 			[#include <arpa/nameser.h>])
 	])
 
+# Check whether user wants SELinux support
+SELINUX_MSG="no"
+LIBSELINUX=""
+AC_ARG_WITH(selinux,
+	[  --with-selinux[[=LIBSELINUX-PATH]]   Enable SELinux support],
+	[ if test "x$withval" != "xno" ; then
+		if test "x$withval" != "xyes"; then
+			CPPFLAGS="$CPPFLAGS -I${withval}/include"
+			if test -n "${need_dash_r}"; then
+				LDFLAGS="-L${withval}/lib -R${withval}/lib ${LDFLAGS}"
+			else
+				LDFLAGS="-L${withval}/lib ${LDFLAGS}"
+			fi
+               fi 
+		AC_DEFINE(WITH_SELINUX,1,[Define if you want SELinux support.])
+		SELINUX_MSG="yes"
+		AC_CHECK_HEADERS(selinux.h)
+		LIBSELINUX="-lselinux"
+	fi
+	])
+AC_SUBST(LIBSELINUX)
+
 # Check whether user wants Kerberos 5 support
 KRB5_MSG="no"
 AC_ARG_WITH(kerberos5,
@@ -3770,6 +3792,7 @@
 echo "                    Manpage format: $MANTYPE"
 echo "                       PAM support: $PAM_MSG"
 echo "                 KerberosV support: $KRB5_MSG"
+echo "                   SELinux support: $SELINUX_MSG"
 echo "                 Smartcard support: $SCARD_MSG"
 echo "                     S/KEY support: $SKEY_MSG"
 echo "              TCP Wrappers support: $TCPW_MSG"
--- openssh-4.3p2/sshpty.c.orig	2005-05-27 07:13:41.000000000 -0400
+++ openssh-4.3p2/sshpty.c	2007-01-12 16:58:22.909303181 -0500
@@ -22,6 +22,8 @@
 #include "log.h"
 #include "misc.h"
 
+#include "selinux.h"
+
 #ifdef HAVE_PTY_H
 # include <pty.h>
 #endif
@@ -200,6 +202,8 @@
 		fatal("stat(%.100s) failed: %.100s", tty,
 		    strerror(errno));
 
+	setup_selinux_pty(pw->pw_name, tty);
+
 	if (st.st_uid != pw->pw_uid || st.st_gid != gid) {
 		if (chown(tty, pw->pw_uid, gid) < 0) {
 			if (errno == EROFS &&
--- openssh-4.3p2/auth1.c.orig	2005-07-17 03:26:44.000000000 -0400
+++ openssh-4.3p2/auth1.c	2007-01-12 16:58:22.908303363 -0500
@@ -370,7 +370,7 @@
 do_authentication(Authctxt *authctxt)
 {
 	u_int ulen;
-	char *user, *style = NULL;
+	char *user, *style = NULL, *role=NULL;
 
 	/* Get the name of the user that we wish to log in as. */
 	packet_read_expect(SSH_CMSG_USER);
@@ -379,11 +379,19 @@
 	user = packet_get_string(&ulen);
 	packet_check_eom();
 
+	if ((role = strchr(user, '/')) != NULL)
+		*role++ = '\0';
+
 	if ((style = strchr(user, ':')) != NULL)
 		*style++ = '\0';
+	else
+		if (role && (style = strchr(role, ':')) != NULL)
+			*style++ = '\0';
+			
 
 	authctxt->user = user;
 	authctxt->style = style;
+	authctxt->role = role;
 
 	/* Verify that the user is a valid user. */
 	if ((authctxt->pw = PRIVSEP(getpwnamallow(user))) != NULL)
--- openssh-4.3p2/auth2.c.orig	2005-09-23 22:43:51.000000000 -0400
+++ openssh-4.3p2/auth2.c	2007-01-12 16:58:22.908303363 -0500
@@ -134,7 +134,7 @@
 {
 	Authctxt *authctxt = ctxt;
 	Authmethod *m = NULL;
-	char *user, *service, *method, *style = NULL;
+	char *user, *service, *method, *style = NULL, *role = NULL;
 	int authenticated = 0;
 
 	if (authctxt == NULL)
@@ -146,6 +146,9 @@
 	debug("userauth-request for user %s service %s method %s", user, service, method);
 	debug("attempt %d failures %d", authctxt->attempt, authctxt->failures);
 
+	if ((role = strchr(user, '/')) != NULL)
+		*role++ = 0;
+
 	if ((style = strchr(user, ':')) != NULL)
 		*style++ = 0;
 
@@ -171,8 +174,11 @@
 		    use_privsep ? " [net]" : "");
 		authctxt->service = xstrdup(service);
 		authctxt->style = style ? xstrdup(style) : NULL;
-		if (use_privsep)
+		authctxt->role = role ? xstrdup(role) : NULL;
+		if (use_privsep) {
 			mm_inform_authserv(service, style);
+			mm_inform_authrole(role);
+		}
 	} else if (strcmp(user, authctxt->user) != 0 ||
 	    strcmp(service, authctxt->service) != 0) {
 		packet_disconnect("Change of username or service not allowed: "
--- openssh-4.3p2/Makefile.in.orig	2006-01-01 03:47:05.000000000 -0500
+++ openssh-4.3p2/Makefile.in	2007-01-12 16:58:22.905303911 -0500
@@ -43,6 +43,7 @@
 CFLAGS=@CFLAGS@
 CPPFLAGS=-I. -I$(srcdir) @CPPFLAGS@ $(PATHS) @DEFS@
 LIBS=@LIBS@
+LIBSELINUX=@LIBSELINUX@
 LIBEDIT=@LIBEDIT@
 LIBPAM=@LIBPAM@
 LIBWRAP=@LIBWRAP@
@@ -77,7 +78,7 @@
 	sshconnect.o sshconnect1.o sshconnect2.o
 
 SSHDOBJS=sshd.o auth-rhosts.o auth-passwd.o auth-rsa.o auth-rh-rsa.o \
-	sshpty.o sshlogin.o servconf.o serverloop.o \
+	sshpty.o sshlogin.o servconf.o serverloop.o selinux.o \
 	auth.o auth1.o auth2.o auth-options.o session.o \
 	auth-chall.o auth2-chall.o groupaccess.o \
 	auth-skey.o auth-bsdauth.o auth2-hostbased.o auth2-kbdint.o \
@@ -136,7 +137,7 @@
 	$(LD) -o $@ $(SSHOBJS) $(LDFLAGS) -lssh -lopenbsd-compat $(LIBS)
 
 sshd$(EXEEXT): libssh.a	$(LIBCOMPAT) $(SSHDOBJS)
-	$(LD) -o $@ $(SSHDOBJS) $(LDFLAGS) -lssh -lopenbsd-compat $(LIBWRAP) $(LIBPAM) $(LIBS)
+	$(LD) -o $@ $(SSHDOBJS) $(LDFLAGS) -lssh -lopenbsd-compat $(LIBWRAP) $(LIBPAM) $(LIBSELINUX) $(LIBS)
 
 scp$(EXEEXT): $(LIBCOMPAT) libssh.a scp.o progressmeter.o
 	$(LD) -o $@ scp.o progressmeter.o bufaux.o $(LDFLAGS) -lssh -lopenbsd-compat $(LIBS)
--- openssh-4.3p2/monitor_wrap.c.orig	2005-09-29 08:01:10.000000000 -0400
+++ openssh-4.3p2/monitor_wrap.c	2007-01-12 16:58:22.903304276 -0500
@@ -271,6 +271,23 @@
 	buffer_free(&m);
 }
 
+/* Inform the privileged process about role */
+
+void
+mm_inform_authrole(char *role)
+{
+	Buffer m;
+
+	debug3("%s entering", __func__);
+
+	buffer_init(&m);
+	buffer_put_cstring(&m, role ? role : "");
+
+	mm_request_send(pmonitor->m_recvfd, MONITOR_REQ_AUTHROLE, &m);
+
+	buffer_free(&m);
+}
+
 /* Do the password authentication */
 int
 mm_auth_password(Authctxt *authctxt, char *password)
--- openssh-4.3p2/monitor.c.orig	2005-11-04 23:07:05.000000000 -0500
+++ openssh-4.3p2/monitor.c	2007-01-12 16:58:22.902304458 -0500
@@ -111,6 +111,7 @@
 int mm_answer_pwnamallow(int, Buffer *);
 int mm_answer_auth2_read_banner(int, Buffer *);
 int mm_answer_authserv(int, Buffer *);
+int mm_answer_authrole(int, Buffer *);
 int mm_answer_authpassword(int, Buffer *);
 int mm_answer_bsdauthquery(int, Buffer *);
 int mm_answer_bsdauthrespond(int, Buffer *);
@@ -181,6 +182,7 @@
     {MONITOR_REQ_SIGN, MON_ONCE, mm_answer_sign},
     {MONITOR_REQ_PWNAM, MON_ONCE, mm_answer_pwnamallow},
     {MONITOR_REQ_AUTHSERV, MON_ONCE, mm_answer_authserv},
+    {MONITOR_REQ_AUTHROLE, MON_ONCE, mm_answer_authrole},
     {MONITOR_REQ_AUTH2_READ_BANNER, MON_ONCE, mm_answer_auth2_read_banner},
     {MONITOR_REQ_AUTHPASSWORD, MON_AUTH, mm_answer_authpassword},
 #ifdef USE_PAM
@@ -623,6 +625,7 @@
 	else {
 		/* Allow service/style information on the auth context */
 		monitor_permit(mon_dispatch, MONITOR_REQ_AUTHSERV, 1);
+		monitor_permit(mon_dispatch, MONITOR_REQ_AUTHROLE, 1);
 		monitor_permit(mon_dispatch, MONITOR_REQ_AUTH2_READ_BANNER, 1);
 	}
 
@@ -671,6 +674,23 @@
 }
 
 int
+mm_answer_authrole(int sock, Buffer *m)
+{
+	monitor_permit_authentications(1);
+
+	authctxt->role = buffer_get_string(m, NULL);
+	debug3("%s: role=%s",
+	    __func__, authctxt->role);
+
+	if (strlen(authctxt->role) == 0) {
+		xfree(authctxt->role);
+		authctxt->role = NULL;
+	}
+
+	return (0);
+}
+
+int
 mm_answer_authpassword(int sock, Buffer *m)
 {
 	static int call_count;
--- openssh-4.3p2/monitor.h.orig	2005-02-02 08:20:53.000000000 -0500
+++ openssh-4.3p2/monitor.h	2007-01-12 16:58:22.900304823 -0500
@@ -30,7 +30,7 @@
 
 enum monitor_reqtype {
 	MONITOR_REQ_MODULI, MONITOR_ANS_MODULI,
-	MONITOR_REQ_FREE, MONITOR_REQ_AUTHSERV,
+	MONITOR_REQ_FREE, MONITOR_REQ_AUTHSERV,MONITOR_REQ_AUTHROLE,
 	MONITOR_REQ_SIGN, MONITOR_ANS_SIGN,
 	MONITOR_REQ_PWNAM, MONITOR_ANS_PWNAM,
 	MONITOR_REQ_AUTH2_READ_BANNER, MONITOR_ANS_AUTH2_READ_BANNER,
--- /dev/null	2007-01-11 23:35:45.895627745 -0500
+++ openssh-4.3p2/.rhat	2007-01-12 16:58:22.899305006 -0500
@@ -0,0 +1,84 @@
+#include "includes.h"
+#include "auth.h"
+#include "log.h"
+
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/flask.h>
+#include <selinux/context.h>
+#include <selinux/get_context_list.h>
+#include <selinux/get_default_type.h>
+extern Authctxt *the_authctxt;
+
+static const security_context_t selinux_get_user_context(const char *name) {
+	security_context_t user_context=NULL;
+	char *role=NULL;
+	int ret=-1;
+	char *seuser=NULL;
+	char *level=NULL;
+
+	if (the_authctxt) 
+		role=the_authctxt->role;
+
+	if (getseuserbyname(name, &seuser, &level)==0) {
+		if (role != NULL && role[0]) 
+			ret=get_default_context_with_rolelevel(seuser, role, level,NULL,&user_context);
+		else
+			ret=get_default_context_with_level(seuser, level, NULL,&user_context);
+	}
+
+	if ( ret < 0 ) {
+		if (security_getenforce() > 0) 
+			fatal("Failed to get default security context for %s.", name);
+		else 
+			error("Failed to get default security context for %s. Continuing in permissive mode", name);
+	} 
+	return user_context;
+}
+
+void setup_selinux_pty(const char *name, const char *tty) {
+	if (is_selinux_enabled() > 0) {
+		security_context_t new_tty_context=NULL, user_context=NULL, old_tty_context=NULL; 
+
+		user_context=selinux_get_user_context(name);
+
+		if (getfilecon(tty, &old_tty_context) < 0) {
+			error("getfilecon(%.100s) failed: %.100s", tty, strerror(errno));
+		} else {
+			if (security_compute_relabel(user_context,old_tty_context,
+						     SECCLASS_CHR_FILE,
+						     &new_tty_context) != 0) {
+				error("security_compute_relabel(%.100s) failed: %.100s", tty,
+				      strerror(errno));
+			} else {
+				if (setfilecon (tty, new_tty_context) != 0) 
+					error("setfilecon(%.100s, %s) failed: %.100s",
+					      tty, new_tty_context, 
+					      strerror(errno));
+				freecon(new_tty_context);
+			}
+			freecon(old_tty_context);
+		}
+		if (user_context) {
+			freecon(user_context);
+		}
+	}
+}
+
+void setup_selinux_exec_context(char *name) {
+
+	if (is_selinux_enabled() > 0) {
+		security_context_t user_context=selinux_get_user_context(name);
+		if (setexeccon(user_context)) {
+			if (security_getenforce() > 0) 
+				fatal("Failed to set exec security context %s for %s.", user_context, name);
+			else 
+				error("Failed to set exec security context %s for %s. Continuing in permissive mode", user_context, name);
+		}
+		if (user_context) {
+			freecon(user_context);
+		}
+	}
+}
+
+#endif /* WITH_SELINUX */
--- openssh-4.3p2/contrib/redhat/sshd.init.orig	2002-05-09 22:19:23.000000000 -0400
+++ openssh-4.3p2/contrib/redhat/sshd.init	2007-01-12 16:58:22.901304641 -0500
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

--------------090300030309030107030503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
