Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6P0MvKu024916
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 20:22:57 -0400
Received: from QMTA06.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6P0MvgJ001716
	for <selinux@tycho.nsa.gov>; Fri, 25 Jul 2008 00:22:57 GMT
Subject: Re: [refpolicy patch]  mozilla replace local policy by interface
	calls.
From: Chris PeBenito <pebenito@gentoo.org>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1216761068.26661.15.camel@sulphur.notebook.internal>
References: <1216761068.26661.15.camel@sulphur.notebook.internal>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-43Ld3CwF7JTqDBKjRA5X"
Date: Thu, 24 Jul 2008 20:22:40 -0400
Message-Id: <1216945360.4931.25.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-43Ld3CwF7JTqDBKjRA5X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-22 at 23:11 +0200, Dominick Grift wrote:
> This patch replaces local policy by interface calls

These aren't 1:1 replacements (see below).

> Index: /home/domg472/Workspace/refpolicy_trunk/policy/modules/apps/mozill=
a.if
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- /home/domg472/Workspace/refpolicy_trunk/policy/modules/apps/mozilla.i=
f	(revision 2762)
> +++ /home/domg472/Workspace/refpolicy_trunk/policy/modules/apps/mozilla.i=
f	(working copy)
> @@ -78,10 +78,9 @@
>  	userdom_search_user_home_dirs($1,$1_mozilla_t)
> =20
>  	# Mozpluggerrc
> -	allow $1_mozilla_t mozilla_conf_t:file read_file_perms;
> +	read_files_pattern($1_mozilla_t, mozilla_conf_t, mozilla_conf_t)

Based on the .fc, there aren't any mozilla_conf_t directories.  The
pattern adds that permission

>  	allow $1_mozilla_t $2:fd use;
> -	allow $1_mozilla_t $2:process sigchld;
>  	allow $1_mozilla_t $2:unix_stream_socket connectto;
>  	allow $2 $1_mozilla_t:fd use;
>  	allow $2 $1_mozilla_t:shm { associate getattr };
> @@ -190,6 +189,8 @@
>  	userdom_manage_user_tmp_dirs($1,$1_mozilla_t)
>  	userdom_manage_user_tmp_files($1,$1_mozilla_t)
>  	userdom_manage_user_tmp_sockets($1,$1_mozilla_t)
> +
> +	userdom_sigchld_all_users($1_mozilla_t)

The raw rule only allows the mozilla to sigchld the user domain that
transitions to the mozilla instance, e.g., user_mozilla_t sigchld'ing
user_t.  The above rule allows user_mozilla_t to sigchld all user
domains, which we don't want.
 =09
>  	xserver_user_x_domain_template($1,$1_mozilla,$1_mozilla_t,
> $1_mozilla_tmpfs_t)
>  	xserver_dontaudit_read_xdm_tmp_files($1_mozilla_t)



--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-43Ld3CwF7JTqDBKjRA5X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiJHM8ACgkQvI7kLeavkkOzvgCdEusIh94BOwFWSf3reXZtuM/Y
w4EAn2zestFFH8pRRK36DRBiqrJXbYdJ
=BITm
-----END PGP SIGNATURE-----

--=-43Ld3CwF7JTqDBKjRA5X--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
