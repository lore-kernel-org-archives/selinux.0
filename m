Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i87GT8rT027472
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 12:29:09 -0400 (EDT)
Received: from web.linuxrulz.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i87GS9xo008878
	for <selinux@tycho.nsa.gov>; Tue, 7 Sep 2004 16:28:13 GMT
Date: Tue, 7 Sep 2004 18:28:24 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>,
   openssh-unix-dev@mindrot.org
Subject: Re: Please review openssh patch for selinux
Message-ID: <20040907162824.GU10151@lbsd.net>
References: <200408241818.40064.russell@coker.com.au> <41371628.2020408@redhat.com> <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil> <200409022338.20644.russell@coker.com.au> <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil> <413741A3.3070305@redhat.com> <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil> <41377927.3080703@redhat.com> <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil> <41377E8A.2030707@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pui5YDBJbCQuJ1A1"
In-Reply-To: <41377E8A.2030707@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Pui5YDBJbCQuJ1A1
Content-Type: multipart/mixed; boundary="AJ3oM32U01nchLSz"
Content-Disposition: inline


--AJ3oM32U01nchLSz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As posted, here is an updated patch which allows openssh to be built
with non-selinux config.

(Hi openssh guys, forwarding this to you incase you interested including
it into the devel version of openssh. Please let us know if you have any
suggestions or changes that need to be made)


Regards
Nigel Kukard


On Thu, Sep 02, 2004 at 04:11:54PM -0400, Daniel J Walsh wrote:
> New SSH patch.
>=20
> Provides the capability of doing
>=20
> ssh hostname -l root/sysadm_r
>=20
> suggested by Collin.=20
>=20
> I used the / instead of : to preserve the BSD syntax.
>=20
> Comments?
>=20
>=20
> Dan
>=20

--AJ3oM32U01nchLSz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openssh-3.9p1_selinux.patch"
Content-Transfer-Encoding: quoted-printable

Author: Daniel J Walsh <dwalsh@redhat.com>
Date:   02/09/2004
Source: selinux@tycho.nsa.gov mailing list


ChangeLog:

	07/09/2004 - Nigel Kukard  <nkukard@lbsd.net>
		o Fixed patch to work with non-selinux configuration


Changes:

 Makefile.in              |    2=20
 auth.h                   |    3 +
 auth1.c                  |   11 +++++
 auth2.c                  |   17 +++++++
 config.h.in              |    3 +
 configure.ac             |   13 ++++++
 contrib/redhat/sshd.init |    9 ++++
 monitor.c                |   29 +++++++++++++
 monitor.h                |    2=20
 monitor_wrap.c           |   18 ++++++++
 monitor_wrap.h           |    3 +
 selinux.c                |  101 ++++++++++++++++++++++++++++++++++++++++++=
+++++
 selinux.h                |   10 ++++
 session.c                |    8 +++
 sshpty.c                 |    8 +++
 15 files changed, 234 insertions(+), 3 deletions(-)


diff -u --new-file --recursive openssh-3.9p1_vanilla/Makefile.in openssh-3.=
9p1_selinux/Makefile.in
--- openssh-3.9p1_vanilla/Makefile.in	2004-08-15 13:01:37.000000000 +0200
+++ openssh-3.9p1_selinux/Makefile.in	2004-09-07 17:41:15.000000000 +0200
@@ -76,7 +76,7 @@
 	sshconnect.o sshconnect1.o sshconnect2.o
=20
 SSHDOBJS=3Dsshd.o auth-rhosts.o auth-passwd.o auth-rsa.o auth-rh-rsa.o \
-	sshpty.o sshlogin.o servconf.o serverloop.o \
+	sshpty.o sshlogin.o servconf.o serverloop.o selinux.o \
 	auth.o auth1.o auth2.o auth-options.o session.o \
 	auth-chall.o auth2-chall.o groupaccess.o \
 	auth-skey.o auth-bsdauth.o auth2-hostbased.o auth2-kbdint.o \
diff -u --new-file --recursive openssh-3.9p1_vanilla/auth.h openssh-3.9p1_s=
elinux/auth.h
--- openssh-3.9p1_vanilla/auth.h	2004-05-24 02:36:23.000000000 +0200
+++ openssh-3.9p1_selinux/auth.h	2004-09-07 18:03:09.000000000 +0200
@@ -57,6 +57,9 @@
 	char		*service;
 	struct passwd	*pw;		/* set if 'valid' */
 	char		*style;
+#ifdef WITH_SELINUX
+	char		*role;
+#endif
 	void		*kbdintctxt;
 #ifdef BSD_AUTH
 	auth_session_t	*as;
diff -u --new-file --recursive openssh-3.9p1_vanilla/auth1.c openssh-3.9p1_=
selinux/auth1.c
--- openssh-3.9p1_vanilla/auth1.c	2004-08-12 14:40:25.000000000 +0200
+++ openssh-3.9p1_selinux/auth1.c	2004-09-07 18:04:03.000000000 +0200
@@ -284,6 +284,9 @@
 {
 	u_int ulen;
 	char *user, *style =3D NULL;
+#ifdef WITH_SELINUX
+	char *role=3DNULL;
+#endif
=20
 	/* Get the name of the user that we wish to log in as. */
 	packet_read_expect(SSH_CMSG_USER);
@@ -292,11 +295,19 @@
 	user =3D packet_get_string(&ulen);
 	packet_check_eom();
=20
+#ifdef WITH_SELINUX
+	if ((role =3D strchr(user, '/')) !=3D NULL)
+		*role++ =3D '\0';
+#endif
+
 	if ((style =3D strchr(user, ':')) !=3D NULL)
 		*style++ =3D '\0';
=20
 	authctxt->user =3D user;
 	authctxt->style =3D style;
+#ifdef WITH_SELINUX
+	authctxt->role =3D role;
+#endif
=20
 	/* Verify that the user is a valid user. */
 	if ((authctxt->pw =3D PRIVSEP(getpwnamallow(user))) !=3D NULL)
diff -u --new-file --recursive openssh-3.9p1_vanilla/auth2.c openssh-3.9p1_=
selinux/auth2.c
--- openssh-3.9p1_vanilla/auth2.c	2004-08-12 14:40:25.000000000 +0200
+++ openssh-3.9p1_selinux/auth2.c	2004-09-07 18:06:25.000000000 +0200
@@ -133,6 +133,9 @@
 	Authctxt *authctxt =3D ctxt;
 	Authmethod *m =3D NULL;
 	char *user, *service, *method, *style =3D NULL;
+#ifdef WITH_SELINUX
+	char *role =3D NULL;
+#endif
 	int authenticated =3D 0;
=20
 	if (authctxt =3D=3D NULL)
@@ -144,6 +147,11 @@
 	debug("userauth-request for user %s service %s method %s", user, service,=
 method);
 	debug("attempt %d failures %d", authctxt->attempt, authctxt->failures);
=20
+#ifdef WITH_SELINUX
+	if ((role =3D strchr(user, '/')) !=3D NULL)
+		*role++ =3D 0;
+#endif
+
 	if ((style =3D strchr(user, ':')) !=3D NULL)
 		*style++ =3D 0;
=20
@@ -170,8 +178,15 @@
 		    use_privsep ? " [net]" : "");
 		authctxt->service =3D xstrdup(service);
 		authctxt->style =3D style ? xstrdup(style) : NULL;
-		if (use_privsep)
+#ifdef WITH_SELINUX
+		authctxt->role =3D role ? xstrdup(role) : NULL;
+#endif
+		if (use_privsep) {
 			mm_inform_authserv(service, style);
+#ifdef WITH_SELINUX
+			mm_inform_authrole(role);
+#endif
+		}
 	} else if (strcmp(user, authctxt->user) !=3D 0 ||
 	    strcmp(service, authctxt->service) !=3D 0) {
 		packet_disconnect("Change of username or service not allowed: "
diff -u --new-file --recursive openssh-3.9p1_vanilla/config.h.in openssh-3.=
9p1_selinux/config.h.in
--- openssh-3.9p1_vanilla/config.h.in	2004-08-17 14:54:51.000000000 +0200
+++ openssh-3.9p1_selinux/config.h.in	2004-09-07 17:41:15.000000000 +0200
@@ -265,6 +265,9 @@
 /* Define if you want Kerberos 5 support */
 #undef KRB5
=20
+/* Define if have want SELinux support */
+#undef WITH_SELINUX
+
 /* Define this if you are using the Heimdal version of Kerberos V5 */
 #undef HEIMDAL
=20
diff -u --new-file --recursive openssh-3.9p1_vanilla/configure.ac openssh-3=
.9p1_selinux/configure.ac
--- openssh-3.9p1_vanilla/configure.ac	2004-08-16 15:12:06.000000000 +0200
+++ openssh-3.9p1_selinux/configure.ac	2004-09-07 17:41:15.000000000 +0200
@@ -2218,6 +2218,18 @@
 			[#include <arpa/nameser.h>])
 	])
=20
+# Check whether user wants SELinux support
+SELINUX_MSG=3D"no"
+AC_ARG_WITH(selinux,
+	[  --with-selinux   Enable SELinux support],
+	[ if test "x$withval" !=3D "xno" ; then
+		AC_DEFINE(WITH_SELINUX)
+		SELINUX_MSG=3D"yes"
+		AC_CHECK_HEADERS(selinux.h)
+		LIBS=3D"$LIBS -lselinux"
+	fi
+	])
+
 # Check whether user wants Kerberos 5 support
 KRB5_MSG=3D"no"
 AC_ARG_WITH(kerberos5,
@@ -2973,6 +2985,7 @@
 echo "                    Manpage format: $MANTYPE"
 echo "                       PAM support: $PAM_MSG"
 echo "                 KerberosV support: $KRB5_MSG"
+echo "                   SELinux support: $SELINUX_MSG"
 echo "                 Smartcard support: $SCARD_MSG"
 echo "                     S/KEY support: $SKEY_MSG"
 echo "              TCP Wrappers support: $TCPW_MSG"
diff -u --new-file --recursive openssh-3.9p1_vanilla/contrib/redhat/sshd.in=
it openssh-3.9p1_selinux/contrib/redhat/sshd.init
--- openssh-3.9p1_vanilla/contrib/redhat/sshd.init	2002-05-10 04:19:23.0000=
00000 +0200
+++ openssh-3.9p1_selinux/contrib/redhat/sshd.init	2004-09-07 17:41:15.0000=
00000 +0200
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
diff -u --new-file --recursive openssh-3.9p1_vanilla/monitor.c openssh-3.9p=
1_selinux/monitor.c
--- openssh-3.9p1_vanilla/monitor.c	2004-07-17 09:05:14.000000000 +0200
+++ openssh-3.9p1_selinux/monitor.c	2004-09-07 18:01:38.000000000 +0200
@@ -127,6 +127,10 @@
 int mm_answer_sesskey(int, Buffer *);
 int mm_answer_sessid(int, Buffer *);
=20
+#ifdef WITH_SELINUX
+int mm_answer_authrole(int, Buffer *);
+#endif
+
 #ifdef USE_PAM
 int mm_answer_pam_start(int, Buffer *);
 int mm_answer_pam_account(int, Buffer *);
@@ -178,6 +182,9 @@
     {MONITOR_REQ_AUTHSERV, MON_ONCE, mm_answer_authserv},
     {MONITOR_REQ_AUTH2_READ_BANNER, MON_ONCE, mm_answer_auth2_read_banner},
     {MONITOR_REQ_AUTHPASSWORD, MON_AUTH, mm_answer_authpassword},
+#ifdef WITH_SELINUX
+    {MONITOR_REQ_AUTHROLE, MON_ONCE, mm_answer_authrole},
+#endif
 #ifdef USE_PAM
     {MONITOR_REQ_PAM_START, MON_ONCE, mm_answer_pam_start},
     {MONITOR_REQ_PAM_ACCOUNT, 0, mm_answer_pam_account},
@@ -602,6 +609,9 @@
 	else {
 		/* Allow service/style information on the auth context */
 		monitor_permit(mon_dispatch, MONITOR_REQ_AUTHSERV, 1);
+#ifdef WITH_SELINUX
+		monitor_permit(mon_dispatch, MONITOR_REQ_AUTHROLE, 1);
+#endif
 		monitor_permit(mon_dispatch, MONITOR_REQ_AUTH2_READ_BANNER, 1);
 	}
=20
@@ -646,6 +656,25 @@
 	return (0);
 }
=20
+#ifdef WITH_SELINUX
+int
+mm_answer_authrole(int sock, Buffer *m)
+{
+	monitor_permit_authentications(1);
+
+	authctxt->role =3D buffer_get_string(m, NULL);
+	debug3("%s: style=3D%s",
+	    __func__, authctxt->role);
+
+	if (strlen(authctxt->role) =3D=3D 0) {
+		xfree(authctxt->role);
+		authctxt->role =3D NULL;
+	}
+
+	return (0);
+}
+#endif
+
 int
 mm_answer_authpassword(int sock, Buffer *m)
 {
diff -u --new-file --recursive openssh-3.9p1_vanilla/monitor.h openssh-3.9p=
1_selinux/monitor.h
--- openssh-3.9p1_vanilla/monitor.h	2003-11-17 13:18:22.000000000 +0200
+++ openssh-3.9p1_selinux/monitor.h	2004-09-07 18:08:22.000000000 +0200
@@ -30,7 +30,7 @@
=20
 enum monitor_reqtype {
 	MONITOR_REQ_MODULI, MONITOR_ANS_MODULI,
-	MONITOR_REQ_FREE, MONITOR_REQ_AUTHSERV,
+	MONITOR_REQ_FREE, MONITOR_REQ_AUTHSERV, MONITOR_REQ_AUTHROLE,
 	MONITOR_REQ_SIGN, MONITOR_ANS_SIGN,
 	MONITOR_REQ_PWNAM, MONITOR_ANS_PWNAM,
 	MONITOR_REQ_AUTH2_READ_BANNER, MONITOR_ANS_AUTH2_READ_BANNER,
diff -u --new-file --recursive openssh-3.9p1_vanilla/monitor_wrap.c openssh=
-3.9p1_selinux/monitor_wrap.c
--- openssh-3.9p1_vanilla/monitor_wrap.c	2004-07-17 09:05:14.000000000 +0200
+++ openssh-3.9p1_selinux/monitor_wrap.c	2004-09-07 18:14:58.000000000 +0200
@@ -274,6 +274,24 @@
 	buffer_free(&m);
 }
=20
+/* Inform the privileged process about role */
+#ifdef WITH_SELINUX
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
+#endif
+
 /* Do the password authentication */
 int
 mm_auth_password(Authctxt *authctxt, char *password)
diff -u --new-file --recursive openssh-3.9p1_vanilla/monitor_wrap.h openssh=
-3.9p1_selinux/monitor_wrap.h
--- openssh-3.9p1_vanilla/monitor_wrap.h	2004-06-22 04:56:02.000000000 +0200
+++ openssh-3.9p1_selinux/monitor_wrap.h	2004-09-07 18:13:13.000000000 +0200
@@ -44,6 +44,9 @@
 DH *mm_choose_dh(int, int, int);
 int mm_key_sign(Key *, u_char **, u_int *, u_char *, u_int);
 void mm_inform_authserv(char *, char *);
+#ifdef WITH_SELINUX
+void mm_inform_authrole(char *);
+#endif
 struct passwd *mm_getpwnamallow(const char *);
 char *mm_auth2_read_banner(void);
 int mm_auth_password(struct Authctxt *, char *);
diff -u --new-file --recursive openssh-3.9p1_vanilla/selinux.c openssh-3.9p=
1_selinux/selinux.c
--- openssh-3.9p1_vanilla/selinux.c	1970-01-01 02:00:00.000000000 +0200
+++ openssh-3.9p1_selinux/selinux.c	2004-09-07 17:41:15.000000000 +0200
@@ -0,0 +1,101 @@
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
+static const security_context_t selinux_get_user_context(const char *name)=
 {
+	security_context_t user_context=3DNULL;
+	if (get_default_context(name,NULL,&user_context)) {
+		if (security_getenforce() > 0)=20
+			fatal("Failed to get default security context for %s.", name);
+		else=20
+			error("Failed to get default security context for %s. Continuing in per=
missve mode", name);
+	} else {
+		if (the_authctxt) {
+			char *role=3Dthe_authctxt->role;
+			if (role !=3D NULL && role[0]) {
+				char *type;
+				if (get_default_type(role, &type) < 0) {
+					if (security_getenforce() > 0)=20
+						fatal("Failed to get default type for role %s, user %s.", role, name=
);
+					else=20
+						error("Failed to get default type for role %s, user %s. Continuing i=
n permissive mode", role, name);
+				} else {
+					context_t newcon=3Dcontext_new(user_context);
+					if (context_role_set(newcon, role) !=3D 0) {
+						context_free(newcon);
+						if (security_getenforce() > 0)=20
+							fatal("Failed to set role %s for %s.", role, name);
+						else=20
+							error("Failed to set role %s for %s. Continuing in permissive mode"=
, role, name);
+					} else if (context_type_set(newcon, type) !=3D 0) {
+						context_free(newcon);
+						if (security_getenforce() > 0)=20
+							fatal("Failed to set type %s for %s.", role, name);
+						else=20
+							error("Failed to set type %s for %s. Continuing in permissive mode"=
, role, name);
+					} else {
+						freecon(user_context);
+						user_context =3D strdup(context_str(newcon));
+						context_free(newcon);
+					}
+				}
+			}
+		}
+	}
+	return user_context;
+}
+
+void setup_selinux_pty(const char *name, const char *tty) {
+	if (is_selinux_enabled() > 0) {
+		security_context_t new_tty_context=3DNULL, user_context=3DNULL, old_tty_=
context=3DNULL;=20
+
+		user_context=3Dselinux_get_user_context(name);
+
+		if (getfilecon(tty, &old_tty_context) < 0) {
+			error("getfilecon(%.100s) failed: %.100s", tty, strerror(errno));
+		} else {
+			if (security_compute_relabel(user_context,old_tty_context,
+						     SECCLASS_CHR_FILE,
+						     &new_tty_context) !=3D 0) {
+				error("security_compute_relabel(%.100s) failed: %.100s", tty,
+				      strerror(errno));
+			} else {
+				if (setfilecon (tty, new_tty_context) !=3D 0)=20
+					error("setfilecon(%.100s, %s) failed: %.100s",
+					      tty, new_tty_context,=20
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
+		security_context_t user_context=3Dselinux_get_user_context(name);
+		if (setexeccon(user_context)) {
+			if (security_getenforce() > 0)=20
+				fatal("Failed to set exec security context %s for %s.", user_context, =
name);
+			else=20
+				error("Failed to set exec security context %s for %s. Continuing in pe=
rmissive mode", user_context, name);
+		}
+		if (user_context) {
+			freecon(user_context);
+		}
+	}
+}
+
+#endif /* WITH_SELINUX */
diff -u --new-file --recursive openssh-3.9p1_vanilla/selinux.h openssh-3.9p=
1_selinux/selinux.h
--- openssh-3.9p1_vanilla/selinux.h	1970-01-01 02:00:00.000000000 +0200
+++ openssh-3.9p1_selinux/selinux.h	2004-09-07 17:41:16.000000000 +0200
@@ -0,0 +1,10 @@
+#ifndef __SELINUX_H_
+#define __SELINUX_H_
+#ifdef WITH_SELINUX
+extern void setup_selinux_pty(const char *name, const char *tty);
+extern void setup_selinux_exec_context(const char *name);
+#else
+inline void setup_selinux_pty(const char *name, const char *tty) {}
+inline void setup_selinux_exec_context(const char *name) {}=20
+#endif /* WITH_SELINUX */
+#endif /* __SELINUX_H_ */
diff -u --new-file --recursive openssh-3.9p1_vanilla/session.c openssh-3.9p=
1_selinux/session.c
--- openssh-3.9p1_vanilla/session.c	2004-08-12 14:40:25.000000000 +0200
+++ openssh-3.9p1_selinux/session.c	2004-09-07 17:41:56.000000000 +0200
@@ -58,6 +58,10 @@
 #include "session.h"
 #include "monitor_wrap.h"
=20
+#ifdef WITH_SELINUX
+#include "selinux.h"
+#endif
+
 #if defined(KRB5) && defined(USE_AFS)
 #include <kafs.h>
 #endif
@@ -1304,6 +1308,10 @@
 #endif
 	if (getuid() !=3D pw->pw_uid || geteuid() !=3D pw->pw_uid)
 		fatal("Failed to set uids to %u.", (u_int) pw->pw_uid);
+
+#ifdef WITH_SELINUX
+	setup_selinux_exec_context(pw->pw_name);
+#endif
 }
=20
 static void
diff -u --new-file --recursive openssh-3.9p1_vanilla/sshpty.c openssh-3.9p1=
_selinux/sshpty.c
--- openssh-3.9p1_vanilla/sshpty.c	2004-06-22 04:56:02.000000000 +0200
+++ openssh-3.9p1_selinux/sshpty.c	2004-09-07 17:42:39.000000000 +0200
@@ -22,6 +22,10 @@
 #include "log.h"
 #include "misc.h"
=20
+#ifdef WITH_SELINUX
+#include "selinux.h"
+#endif
+
 #ifdef HAVE_PTY_H
 # include <pty.h>
 #endif
@@ -200,6 +204,10 @@
 		fatal("stat(%.100s) failed: %.100s", tty,
 		    strerror(errno));
=20
+#ifdef WITH_SELINUX
+	setup_selinux_pty(pw->pw_name, tty);
+#endif
+=09
 	if (st.st_uid !=3D pw->pw_uid || st.st_gid !=3D gid) {
 		if (chown(tty, pw->pw_uid, gid) < 0) {
 			if (errno =3D=3D EROFS &&

--AJ3oM32U01nchLSz--

--Pui5YDBJbCQuJ1A1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBPeGoKoUGSidwLE4RAgj3AJ4pR+slB5OKGb3dl69M/z1mzBrjvQCgi8nf
N/+f52Gf2AEjlivW9f8StjY=
=ENje
-----END PGP SIGNATURE-----

--Pui5YDBJbCQuJ1A1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
