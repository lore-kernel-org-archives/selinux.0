Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA307QXZ011099
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 19:07:26 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA30638r018294
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 00:06:04 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 3 Nov 2004 01:07:24 +0100
Date: Wed, 3 Nov 2004 01:07:07 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: russell@coker.com.au, jwcart2@epoch.ncsc.mil,
   SELinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Patch to make can_network stronger and remove nscd tunable.
Message-Id: <20041103000707.GD2547@jmh.mhn.de>
References: <20041018124332.GA5193@hydrogenium.cip.ifi.lmu.de> <200411030027.28875.russell@coker.com.au> <41879A1B.40103@redhat.com> <200411030248.49998.russell@coker.com.au> <4187AE44.40204@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
In-Reply-To: <4187AE44.40204@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Daniel J Walsh <dwalsh@redhat.com> [2004-11-02 18:35]:
> Updated with Russell's "daemon" change and other fixes.
>=20
> How does this look?

First off, it would be nice if you could split your patches into
logically independant pieces, makes it much easier to read.

I think there need to be some changes (comments below) but the
nfs_home_dirs-related stuff should be merged as soon as possible.
Currently it is broken in cvs because only some parts have been
converted from tunable to boolean.

> diff --exclude-from=3Dexclude -N -u -r nsapolicy/domains/program/crond.te=
 policy-1.17.37/domains/program/crond.te
> --- nsapolicy/domains/program/crond.te	2004-10-19 16:03:04.000000000 -0400
> +++ policy-1.17.37/domains/program/crond.te	2004-11-02 10:30:33.000000000=
 -0500
> @@ -114,6 +114,10 @@
> +allow crond_t krb5_conf_t:file { getattr read };
> +dontaudit crond_t krb5_conf_t:file { write };

If we are going to add this to more domains we should add a macro IMHO
like can_krb5_connect() or something. I do not know much about kerberos,
but I think most kerberized apps will need similar permissions which
should only be granted if kerberos is used.

> diff --exclude-from=3Dexclude -N -u -r nsapolicy/domains/program/login.te=
 policy-1.17.37/domains/program/login.te
> --- nsapolicy/domains/program/login.te	2004-10-19 16:03:05.000000000 -0400
> +++ policy-1.17.37/domains/program/login.te	2004-11-02 10:30:33.000000000=
 -0500
> @@ -21,6 +21,8 @@
>  dontaudit $1_login_t shadow_t:file { getattr read };
> =20
>  general_domain_access($1_login_t);
> +can_network($1_login_t)=20
> +allow $1_login_t self:{ tcp_socket udp_socket } connect;

Huh? Where does this come from? Cannot see this in the cvs policy. If
this is needed because of kerberos it should be ifdef'ed.

> -ifdef(`nfs_home_dirs', `
> +if (use_nfs_home_dirs) {
>  r_dir_file($1_login_t, nfs_t)
> -')dnl end if nfs_home_dirs
> +}

This should go into CVS ASAP, as mentioned above.

> diff --exclude-from=3Dexclude -N -u -r nsapolicy/domains/program/unused/a=
cct.te policy-1.17.37/domains/program/unused/acct.te
> --- nsapolicy/domains/program/unused/acct.te	2004-10-19 16:03:05.00000000=
0 -0400
> +++ policy-1.17.37/domains/program/unused/acct.te	2004-11-02 10:30:33.000=
000000 -0500
> @@ -63,6 +63,7 @@
> =20
>  ifdef(`logrotate.te', `
>  domain_auto_trans(logrotate_t, acct_exec_t, acct_t)
> +allow logrotate_t acct_data_t:dir { search };
>  allow logrotate_t acct_data_t:file { create_file_perms };

allow logrotate_t acct_data_t:dir search;
allow logrotate_t acct_data_t:file create_file_perms;

This makes it easier to read, IMHO.

> --- nsapolicy/domains/program/unused/ftpd.te	2004-10-27 14:32:48.00000000=
0 -0400
> +++ policy-1.17.37/domains/program/unused/ftpd.te	2004-11-02 10:30:33.000=
000000 -0500
> @@ -4,6 +4,7 @@
>  #           Russell Coker <russell@coker.com.au>
>  # X-Debian-Packages: proftpd-common bsd-ftpd ftpd vsftpd
>  #
> +# Depends: inetd.te

Not true. There is a boolean ftpd_is_daemon which governs this.
Current policy needed inetd.te to compile but I think this is an error
in the policy. The following patch should fix it:

--- ftpd.te.orig	2004-11-03 00:37:16.000000000 +0100
+++ ftpd.te	2004-11-03 00:39:33.000000000 +0100
@@ -44,8 +44,6 @@
 rw_dir_create_file(ftpd_t, var_lock_t)
 allow ftpd_t ftp_port_t:tcp_socket name_bind;
 can_tcp_connect(userdomain, ftpd_t)
-# Allows it to check exec privs on daemon
-allow inetd_t ftpd_exec_t:file x_file_perms;
 }
 ifdef(`inetd.te', `
 if (!ftpd_is_daemon) {
 =20
>  allow ftpd_t ftp_data_port_t:tcp_socket name_bind;
> +allow ftpd_t port_t:tcp_socket { name_bind };

I confess I am not too familiar with ftp, but does it really need to
bind to arbitrary ports, seems excessive and unneeded (and is not
granted in current policy as far as I can see)

> diff --exclude-from=3Dexclude -N -u -r nsapolicy/domains/program/unused/p=
ing.te policy-1.17.37/domains/program/unused/ping.te
> --- nsapolicy/domains/program/unused/ping.te	2004-06-16 13:33:36.00000000=
0 -0400
> +++ policy-1.17.37/domains/program/unused/ping.te	2004-11-02 10:30:33.000=
000000 -0500
> @@ -55,3 +56,5 @@
>  # it tries to access /var/run
>  dontaudit ping_t var_t:dir search;
> =20
> +dontaudit ping_t devtty_t:chr_file { read write };
> +dontaudit ping_t ping_t:capability { sys_tty_config };

        dontaudit ping_t self:capability sys_tty_config;

is nicer.

> diff --exclude-from=3Dexclude -N -u -r nsapolicy/file_contexts/program/ma=
ilman.fc policy-1.17.37/file_contexts/program/mailman.fc
> --- nsapolicy/file_contexts/program/mailman.fc	2004-10-13 22:41:58.000000=
000 -0400
> +++ policy-1.17.37/file_contexts/program/mailman.fc	2004-11-02 10:30:33.0=
00000000 -0500
[...]
> +/usr/lib/mailman/bin/qrunner  	 -- system_u:object_r:mailman_queue_exec_t
> +/etc/mailman(/.*)?		   system_u:object_r:mailman_data_t
> +/var/spool/mailman(/.*)?	   system_u:object_r:mailman_data_t

Sorry, I do not know mailman at all, so please excuse my ignorance.
But does mailman really have to write to /etc/mailman, which is
presumably it's configuration data? This is not nice at all.


> diff --exclude-from=3Dexclude -N -u -r nsapolicy/macros/program/ssh_macro=
s.te policy-1.17.37/macros/program/ssh_macros.te
> --- nsapolicy/macros/program/ssh_macros.te	2004-10-14 23:25:20.000000000 =
-0400
> +++ policy-1.17.37/macros/program/ssh_macros.te	2004-11-02 10:30:33.00000=
0000 -0500
> @@ -20,20 +20,16 @@
>  undefine(`ssh_domain')
>  ifdef(`ssh.te', `
>  define(`ssh_domain',`
> -ifdef(`single_userdomain', `
> -typealias $1_home_t alias $1_home_ssh_t;
> -typealias $1_t alias $1_ssh_t;
> -', `

Ahh, nice to see single_userdomain finally gone.

There were a few other superfluous braces, but the rest looks fine.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBiCErxWIrrrL0q+cRAnL2AJ9AhKNJ2D4ekeftbFx3R+j9YXhM2gCeIeTF
NCdhrxLiujs60bhW7GTOPvE=
=GLBS
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
