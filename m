Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i86INqrT022295
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 14:23:53 -0400 (EDT)
Received: from web.linuxrulz.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i86IMwvL028577
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 18:22:59 GMT
Date: Mon, 6 Sep 2004 20:23:05 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>,
   Colin Walters <walters@redhat.com>, Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Please review openssh patch for selinux
Message-ID: <20040906182305.GJ10151@lbsd.net>
References: <200408241818.40064.russell@coker.com.au> <41371628.2020408@redhat.com> <1094130607.17265.47.camel@moss-spartans.epoch.ncsc.mil> <200409022338.20644.russell@coker.com.au> <1094136369.17265.128.camel@moss-spartans.epoch.ncsc.mil> <413741A3.3070305@redhat.com> <1094153919.17265.375.camel@moss-spartans.epoch.ncsc.mil> <41377927.3080703@redhat.com> <1094155198.17265.389.camel@moss-spartans.epoch.ncsc.mil> <41377E8A.2030707@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UrGtnQA9R6QcIU0f"
In-Reply-To: <41377E8A.2030707@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--UrGtnQA9R6QcIU0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I Tried to apply the below patch to vanilla 3.9p1 and get the following
error...

<snip>
gcc -o sshd sshd.o auth-rhosts.o auth-passwd.o auth-rsa.o auth-rh-rsa.o ssh=
pty.o sshlogin.o servconf.o serverloop.o selinux.o auth.o auth1.o auth2.o a=
uth-options.o session.o auth-chall.o auth2-chall.o groupaccess.o auth-skey.=
o auth-bsdauth.o auth2-hostbased.o auth2-kbdint.o auth2-none.o auth2-passwd=
.o auth2-pubkey.o monitor_mm.omonitor.o monitor_wrap.o kexdhs.o kexgexs.o a=
uth-krb5.o auth2-gss.o gss-serv.o gss-serv-krb5.o loginrec.o auth-pam.o aut=
h-shadow.o auth-sia.o md5crypt.o -L. -Lopenbsd-compat/  -lssh -lopenbsd-com=
pat -lwrap -lpam -ldl -lresolv -lcrypto -lutil -lz -lnsl -lcrypt
session.o(.text+0x0): In function `setup_selinux_pty':
/var/tmp/nkukard-openssh-build/openssh-3.9p1/selinux.h:7: multiple
definition of `setup_selinux_pty'
sshpty.o(.text+0x480)://selinux.h:7: first defined here
session.o(.text+0x10): In function `setup_selinux_exec_context':
/var/tmp/nkukard-openssh-build/openssh-3.9p1/selinux.h:8: multiple
definition of `setup_selinux_exec_context'
sshpty.o(.text+0x490)://selinux.h:8: first defined here
collect2: ld returned 1 exit status
</snip>

this is using kernel 2.6.8.1 + latest selinux patch (kernel side)


-Nigel


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

> --- openssh-3.9p1/monitor_wrap.h.selinux	2004-06-21 22:56:02.000000000 -0=
400
> +++ openssh-3.9p1/monitor_wrap.h	2004-09-02 16:01:12.361473922 -0400
> @@ -44,6 +44,7 @@
>  DH *mm_choose_dh(int, int, int);
>  int mm_key_sign(Key *, u_char **, u_int *, u_char *, u_int);
>  void mm_inform_authserv(char *, char *);
> +void mm_inform_authrole(char *);
>  struct passwd *mm_getpwnamallow(const char *);
>  char *mm_auth2_read_banner(void);
>  int mm_auth_password(struct Authctxt *, char *);
> --- openssh-3.9p1/contrib/redhat/sshd.init.selinux	2002-05-09 22:19:23.00=
0000000 -0400
> +++ openssh-3.9p1/contrib/redhat/sshd.init	2004-09-02 16:01:12.363473687 =
-0400
> @@ -35,6 +35,9 @@
>  		if $KEYGEN -q -t rsa1 -f $RSA1_KEY -C '' -N '' >&/dev/null; then
>  			chmod 600 $RSA1_KEY
>  			chmod 644 $RSA1_KEY.pub
> +			if [ -x /sbin/restorecon ]; then
> +			    /sbin/restorecon $RSA1_KEY.pub
> +			fi
>  			success $"RSA1 key generation"
>  			echo
>  		else
> @@ -51,6 +54,9 @@
>  		if $KEYGEN -q -t rsa -f $RSA_KEY -C '' -N '' >&/dev/null; then
>  			chmod 600 $RSA_KEY
>  			chmod 644 $RSA_KEY.pub
> +			if [ -x /sbin/restorecon ]; then
> +			    /sbin/restorecon $RSA_KEY.pub
> +			fi
>  			success $"RSA key generation"
>  			echo
>  		else
> @@ -67,6 +73,9 @@
>  		if $KEYGEN -q -t dsa -f $DSA_KEY -C '' -N '' >&/dev/null; then
>  			chmod 600 $DSA_KEY
>  			chmod 644 $DSA_KEY.pub
> +			if [ -x /sbin/restorecon ]; then
> +			    /sbin/restorecon $DSA_KEY.pub
> +			fi
>  			success $"DSA key generation"
>  			echo
>  		else
> --- openssh-3.9p1/auth1.c.selinux	2004-09-02 16:01:12.290482263 -0400
> +++ openssh-3.9p1/auth1.c	2004-09-02 16:02:18.505704965 -0400
> @@ -283,7 +283,7 @@
>  do_authentication(Authctxt *authctxt)
>  {
>  	u_int ulen;
> -	char *user, *style =3D NULL;
> +	char *user, *style =3D NULL, *role=3DNULL;
> =20
>  	/* Get the name of the user that we wish to log in as. */
>  	packet_read_expect(SSH_CMSG_USER);
> @@ -292,11 +292,15 @@
>  	user =3D packet_get_string(&ulen);
>  	packet_check_eom();
> =20
> +	if ((role =3D strchr(user, '/')) !=3D NULL)
> +		*role++ =3D '\0';
> +
>  	if ((style =3D strchr(user, ':')) !=3D NULL)
>  		*style++ =3D '\0';
> =20
>  	authctxt->user =3D user;
>  	authctxt->style =3D style;
> +	authctxt->role =3D role;
> =20
>  	/* Verify that the user is a valid user. */
>  	if ((authctxt->pw =3D PRIVSEP(getpwnamallow(user))) !=3D NULL)
> --- openssh-3.9p1/monitor.h.selinux	2003-11-17 06:18:22.000000000 -0500
> +++ openssh-3.9p1/monitor.h	2004-09-02 16:01:12.366473335 -0400
> @@ -30,7 +30,7 @@
> =20
>  enum monitor_reqtype {
>  	MONITOR_REQ_MODULI, MONITOR_ANS_MODULI,
> -	MONITOR_REQ_FREE, MONITOR_REQ_AUTHSERV,
> +	MONITOR_REQ_FREE, MONITOR_REQ_AUTHSERV,MONITOR_REQ_AUTHROLE,
>  	MONITOR_REQ_SIGN, MONITOR_ANS_SIGN,
>  	MONITOR_REQ_PWNAM, MONITOR_ANS_PWNAM,
>  	MONITOR_REQ_AUTH2_READ_BANNER, MONITOR_ANS_AUTH2_READ_BANNER,
> --- openssh-3.9p1/monitor.c.selinux	2004-07-17 03:05:14.000000000 -0400
> +++ openssh-3.9p1/monitor.c	2004-09-02 16:01:12.369472982 -0400
> @@ -111,6 +111,7 @@
>  int mm_answer_pwnamallow(int, Buffer *);
>  int mm_answer_auth2_read_banner(int, Buffer *);
>  int mm_answer_authserv(int, Buffer *);
> +int mm_answer_authrole(int, Buffer *);
>  int mm_answer_authpassword(int, Buffer *);
>  int mm_answer_bsdauthquery(int, Buffer *);
>  int mm_answer_bsdauthrespond(int, Buffer *);
> @@ -176,6 +177,7 @@
>      {MONITOR_REQ_SIGN, MON_ONCE, mm_answer_sign},
>      {MONITOR_REQ_PWNAM, MON_ONCE, mm_answer_pwnamallow},
>      {MONITOR_REQ_AUTHSERV, MON_ONCE, mm_answer_authserv},
> +    {MONITOR_REQ_AUTHROLE, MON_ONCE, mm_answer_authrole},
>      {MONITOR_REQ_AUTH2_READ_BANNER, MON_ONCE, mm_answer_auth2_read_banne=
r},
>      {MONITOR_REQ_AUTHPASSWORD, MON_AUTH, mm_answer_authpassword},
>  #ifdef USE_PAM
> @@ -602,6 +604,7 @@
>  	else {
>  		/* Allow service/style information on the auth context */
>  		monitor_permit(mon_dispatch, MONITOR_REQ_AUTHSERV, 1);
> +		monitor_permit(mon_dispatch, MONITOR_REQ_AUTHROLE, 1);
>  		monitor_permit(mon_dispatch, MONITOR_REQ_AUTH2_READ_BANNER, 1);
>  	}
> =20
> @@ -647,6 +650,23 @@
>  }
> =20
>  int
> +mm_answer_authrole(int sock, Buffer *m)
> +{
> +	monitor_permit_authentications(1);
> +
> +	authctxt->role =3D buffer_get_string(m, NULL);
> +	debug3("%s: style=3D%s",
> +	    __func__, authctxt->role);
> +
> +	if (strlen(authctxt->role) =3D=3D 0) {
> +		xfree(authctxt->role);
> +		authctxt->role =3D NULL;
> +	}
> +
> +	return (0);
> +}
> +
> +int
>  mm_answer_authpassword(int sock, Buffer *m)
>  {
>  	static int call_count;
> --- openssh-3.9p1/config.h.in.selinux	2004-08-17 08:54:51.000000000 -0400
> +++ openssh-3.9p1/config.h.in	2004-09-02 16:01:12.371472747 -0400
> @@ -265,6 +265,9 @@
>  /* Define if you want Kerberos 5 support */
>  #undef KRB5
> =20
> +/* Define if have want SELinux support */
> +#undef WITH_SELINUX
> +
>  /* Define this if you are using the Heimdal version of Kerberos V5 */
>  #undef HEIMDAL
> =20
> --- /dev/null	2004-08-26 15:03:20.000000000 -0400
> +++ openssh-3.9p1/selinux.c	2004-09-02 16:01:12.375472277 -0400
> @@ -0,0 +1,101 @@
> +#include "includes.h"
> +#include "auth.h"
> +#include "log.h"
> +
> +#ifdef WITH_SELINUX
> +#include <selinux/selinux.h>
> +#include <selinux/flask.h>
> +#include <selinux/context.h>
> +#include <selinux/get_context_list.h>
> +#include <selinux/get_default_type.h>
> +extern Authctxt *the_authctxt;
> +
> +static const security_context_t selinux_get_user_context(const char *nam=
e) {
> +	security_context_t user_context=3DNULL;
> +	if (get_default_context(name,NULL,&user_context)) {
> +		if (security_getenforce() > 0)=20
> +			fatal("Failed to get default security context for %s.", name);
> +		else=20
> +			error("Failed to get default security context for %s. Continuing in p=
ermissve mode", name);
> +	} else {
> +		if (the_authctxt) {
> +			char *role=3Dthe_authctxt->role;
> +			if (role !=3D NULL && role[0]) {
> +				char *type;
> +				if (get_default_type(role, &type) < 0) {
> +					if (security_getenforce() > 0)=20
> +						fatal("Failed to get default type for role %s, user %s.", role, na=
me);
> +					else=20
> +						error("Failed to get default type for role %s, user %s. Continuing=
 in permissive mode", role, name);
> +				} else {
> +					context_t newcon=3Dcontext_new(user_context);
> +					if (context_role_set(newcon, role) !=3D 0) {
> +						context_free(newcon);
> +						if (security_getenforce() > 0)=20
> +							fatal("Failed to set role %s for %s.", role, name);
> +						else=20
> +							error("Failed to set role %s for %s. Continuing in permissive mod=
e", role, name);
> +					} else if (context_type_set(newcon, type) !=3D 0) {
> +						context_free(newcon);
> +						if (security_getenforce() > 0)=20
> +							fatal("Failed to set type %s for %s.", role, name);
> +						else=20
> +							error("Failed to set type %s for %s. Continuing in permissive mod=
e", role, name);
> +					} else {
> +						freecon(user_context);
> +						user_context =3D strdup(context_str(newcon));
> +						context_free(newcon);
> +					}
> +				}
> +			}
> +		}
> +	}
> +	return user_context;
> +}
> +
> +void setup_selinux_pty(const char *name, const char *tty) {
> +	if (is_selinux_enabled() > 0) {
> +		security_context_t new_tty_context=3DNULL, user_context=3DNULL, old_tt=
y_context=3DNULL;=20
> +
> +		user_context=3Dselinux_get_user_context(name);
> +
> +		if (getfilecon(tty, &old_tty_context) < 0) {
> +			error("getfilecon(%.100s) failed: %.100s", tty, strerror(errno));
> +		} else {
> +			if (security_compute_relabel(user_context,old_tty_context,
> +						     SECCLASS_CHR_FILE,
> +						     &new_tty_context) !=3D 0) {
> +				error("security_compute_relabel(%.100s) failed: %.100s", tty,
> +				      strerror(errno));
> +			} else {
> +				if (setfilecon (tty, new_tty_context) !=3D 0)=20
> +					error("setfilecon(%.100s, %s) failed: %.100s",
> +					      tty, new_tty_context,=20
> +					      strerror(errno));
> +				freecon(new_tty_context);
> +			}
> +			freecon(old_tty_context);
> +		}
> +		if (user_context) {
> +			freecon(user_context);
> +		}
> +	}
> +}
> +
> +void setup_selinux_exec_context(char *name) {
> +
> +	if (is_selinux_enabled() > 0) {
> +		security_context_t user_context=3Dselinux_get_user_context(name);
> +		if (setexeccon(user_context)) {
> +			if (security_getenforce() > 0)=20
> +				fatal("Failed to set exec security context %s for %s.", user_context=
, name);
> +			else=20
> +				error("Failed to set exec security context %s for %s. Continuing in =
permissive mode", user_context, name);
> +		}
> +		if (user_context) {
> +			freecon(user_context);
> +		}
> +	}
> +}
> +
> +#endif /* WITH_SELINUX */
> --- openssh-3.9p1/auth.h.selinux	2004-05-23 20:36:23.000000000 -0400
> +++ openssh-3.9p1/auth.h	2004-09-02 16:01:12.377472042 -0400
> @@ -57,6 +57,7 @@
>  	char		*service;
>  	struct passwd	*pw;		/* set if 'valid' */
>  	char		*style;
> +	char		*role;
>  	void		*kbdintctxt;
>  #ifdef BSD_AUTH
>  	auth_session_t	*as;
> --- openssh-3.9p1/sshpty.c.selinux	2004-06-21 22:56:02.000000000 -0400
> +++ openssh-3.9p1/sshpty.c	2004-09-02 16:01:12.378471925 -0400
> @@ -22,6 +22,8 @@
>  #include "log.h"
>  #include "misc.h"
> =20
> +#include "selinux.h"
> +
>  #ifdef HAVE_PTY_H
>  # include <pty.h>
>  #endif
> @@ -200,6 +202,8 @@
>  		fatal("stat(%.100s) failed: %.100s", tty,
>  		    strerror(errno));
> =20
> +	setup_selinux_pty(pw->pw_name, tty);
> +
>  	if (st.st_uid !=3D pw->pw_uid || st.st_gid !=3D gid) {
>  		if (chown(tty, pw->pw_uid, gid) < 0) {
>  			if (errno =3D=3D EROFS &&
> --- openssh-3.9p1/configure.ac.selinux	2004-09-02 16:01:12.327477916 -0400
> +++ openssh-3.9p1/configure.ac	2004-09-02 16:01:12.382471455 -0400
> @@ -2218,6 +2218,18 @@
>  			[#include <arpa/nameser.h>])
>  	])
> =20
> +# Check whether user wants SELinux support
> +SELINUX_MSG=3D"no"
> +AC_ARG_WITH(selinux,
> +	[  --with-selinux   Enable SELinux support],
> +	[ if test "x$withval" !=3D "xno" ; then
> +		AC_DEFINE(WITH_SELINUX)
> +		SELINUX_MSG=3D"yes"
> +		AC_CHECK_HEADERS(selinux.h)
> +		LIBS=3D"$LIBS -lselinux"
> +	fi
> +	])
> +
>  # Check whether user wants Kerberos 5 support
>  KRB5_MSG=3D"no"
>  AC_ARG_WITH(kerberos5,
> @@ -2975,6 +2987,7 @@
>  echo "                    Manpage format: $MANTYPE"
>  echo "                       PAM support: $PAM_MSG"
>  echo "                 KerberosV support: $KRB5_MSG"
> +echo "                   SELinux support: $SELINUX_MSG"
>  echo "                 Smartcard support: $SCARD_MSG"
>  echo "                     S/KEY support: $SKEY_MSG"
>  echo "              TCP Wrappers support: $TCPW_MSG"
> --- openssh-3.9p1/Makefile.in.selinux	2004-08-15 07:01:37.000000000 -0400
> +++ openssh-3.9p1/Makefile.in	2004-09-02 16:01:12.385471103 -0400
> @@ -76,7 +76,7 @@
>  	sshconnect.o sshconnect1.o sshconnect2.o
> =20
>  SSHDOBJS=3Dsshd.o auth-rhosts.o auth-passwd.o auth-rsa.o auth-rh-rsa.o \
> -	sshpty.o sshlogin.o servconf.o serverloop.o \
> +	sshpty.o sshlogin.o servconf.o serverloop.o selinux.o \
>  	auth.o auth1.o auth2.o auth-options.o session.o \
>  	auth-chall.o auth2-chall.o groupaccess.o \
>  	auth-skey.o auth-bsdauth.o auth2-hostbased.o auth2-kbdint.o \
> --- /dev/null	2004-08-26 15:03:20.000000000 -0400
> +++ openssh-3.9p1/selinux.h	2004-09-02 16:01:12.386470985 -0400
> @@ -0,0 +1,10 @@
> +#ifndef __SELINUX_H_
> +#define __SELINUX_H_
> +#ifdef WITH_SELINUX
> +extern void setup_selinux_pty(const char *name, const char *tty);
> +extern void setup_selinux_exec_context(const char *name);
> +#else
> +inline void setup_selinux_pty(const char *name, const char *tty) {}
> +inline void setup_selinux_exec_context(const char *name) {}=20
> +#endif /* WITH_SELINUX */
> +#endif /* __SELINUX_H_ */
> --- openssh-3.9p1/auth2.c.selinux	2004-08-12 08:40:25.000000000 -0400
> +++ openssh-3.9p1/auth2.c	2004-09-02 16:01:12.389470633 -0400
> @@ -132,7 +132,7 @@
>  {
>  	Authctxt *authctxt =3D ctxt;
>  	Authmethod *m =3D NULL;
> -	char *user, *service, *method, *style =3D NULL;
> +	char *user, *service, *method, *style =3D NULL, *role =3D NULL;
>  	int authenticated =3D 0;
> =20
>  	if (authctxt =3D=3D NULL)
> @@ -144,6 +144,9 @@
>  	debug("userauth-request for user %s service %s method %s", user, servic=
e, method);
>  	debug("attempt %d failures %d", authctxt->attempt, authctxt->failures);
> =20
> +	if ((role =3D strchr(user, '/')) !=3D NULL)
> +		*role++ =3D 0;
> +
>  	if ((style =3D strchr(user, ':')) !=3D NULL)
>  		*style++ =3D 0;
> =20
> @@ -170,8 +173,11 @@
>  		    use_privsep ? " [net]" : "");
>  		authctxt->service =3D xstrdup(service);
>  		authctxt->style =3D style ? xstrdup(style) : NULL;
> -		if (use_privsep)
> +		authctxt->role =3D role ? xstrdup(role) : NULL;
> +		if (use_privsep) {
>  			mm_inform_authserv(service, style);
> +			mm_inform_authrole(role);
> +		}
>  	} else if (strcmp(user, authctxt->user) !=3D 0 ||
>  	    strcmp(service, authctxt->service) !=3D 0) {
>  		packet_disconnect("Change of username or service not allowed: "
> --- openssh-3.9p1/monitor_wrap.c.selinux	2004-07-17 03:05:14.000000000 -0=
400
> +++ openssh-3.9p1/monitor_wrap.c	2004-09-02 16:01:12.391470398 -0400
> @@ -274,6 +274,23 @@
>  	buffer_free(&m);
>  }
> =20
> +/* Inform the privileged process about role */
> +
> +void
> +mm_inform_authrole(char *role)
> +{
> +	Buffer m;
> +
> +	debug3("%s entering", __func__);
> +
> +	buffer_init(&m);
> +	buffer_put_cstring(&m, role ? role : "");
> +
> +	mm_request_send(pmonitor->m_recvfd, MONITOR_REQ_AUTHROLE, &m);
> +
> +	buffer_free(&m);
> +}
> +
>  /* Do the password authentication */
>  int
>  mm_auth_password(Authctxt *authctxt, char *password)
> --- openssh-3.9p1/session.c.selinux	2004-08-12 08:40:25.000000000 -0400
> +++ openssh-3.9p1/session.c	2004-09-02 16:01:12.395469928 -0400
> @@ -58,6 +58,8 @@
>  #include "session.h"
>  #include "monitor_wrap.h"
> =20
> +#include "selinux.h"
> +
>  #if defined(KRB5) && defined(USE_AFS)
>  #include <kafs.h>
>  #endif
> @@ -1304,6 +1306,8 @@
>  #endif
>  	if (getuid() !=3D pw->pw_uid || geteuid() !=3D pw->pw_uid)
>  		fatal("Failed to set uids to %u.", (u_int) pw->pw_uid);
> +
> +	setup_selinux_exec_context(pw->pw_name);
>  }
> =20
>  static void


--=20
Nigel Kukard, PhD CompSc
(Chief Executive Officer)
Linux Based Systems Design (Non-Profit)
Web: www.lbsd.net          Email: nkukard@lbsd.net
Tel: (+27) 023 349 8000     Cell: (+27) 082 333 3723
Fax: (+27) 023 349 1395  Support: 086 747 7600
Address: LIGT House, 2 Klipdrift Rd, Rawsonville
Linux Systems Design & Technology Solutions


   The best language to use is the language that was designed for
                  what you want to use it for.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Disclaimer
----------
The contents of this message and any attachments are intended=20
solely for the addressee's use and may be legally privileged and/or=20
confidential information. This message may not be retained,=20
distributed, copied or used if you are not he addressee of this=20
message. If this message was sent to you in error, please notify=20
the sender immediately by reply e-mail and then destroy the message=20
and any copies thereof.

Opinions, conclusions and other information in this message may be=20
personal to the sender and is not that of Linux Based Systems Design,
LinuxRulz or any of it's subsideries, associated companies or=20
principals and is therefore not endorsed by Linux Based Systems=20
Design or LinuxRulz. Due to e-maill communication being insecure,=20
Linux Based Systems Design and LinuxRulz do not guarantee=20
confidentiality, security, accuracy or performance of the e-mail.=20
Any liability for viruses is excluded to the fullest extent.

--UrGtnQA9R6QcIU0f
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBPKsJKoUGSidwLE4RAvxAAKCH9t57IY8qW2IAajyA4KIF/xHTKQCeNVk4
dA/pWN8T+jRO79HNMEcjN7c=
=a5cg
-----END PGP SIGNATURE-----

--UrGtnQA9R6QcIU0f--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
