Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8JD8xrT012119
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 09:08:59 -0400 (EDT)
Received: from rwcrmhc12.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8JD812w021884
	for <selinux@tycho.nsa.gov>; Sun, 19 Sep 2004 13:08:02 GMT
Subject: Re: [PATCH] Gentoo-specific initrc
From: Chris PeBenito <pebenito@gentoo.org>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200409191801.05094.russell@coker.com.au>
References: <1095381586.735.30.camel@gorn.pebenito.net>
	 <200409191801.05094.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ndXHKEPCS1u0h6EFYgpz"
Message-Id: <1095599331.735.62.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Sun, 19 Sep 2004 09:08:52 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ndXHKEPCS1u0h6EFYgpz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-09-19 at 04:01, Russell Coker wrote:
> On Fri, 17 Sep 2004 10:39, Chris PeBenito <pebenito@gentoo.org> wrote:
> > Here's a patch for Gentoo-specific initrc, against sourceforge CVS.
>=20
> +allow initrc_t initrc_state_t:lnk_file { create read unlink setattr };
> +allow initrc_t initrc_state_t:file create_file_perms;
> +allow initrc_t initrc_state_t:dir { add_name remove_name read write rmdi=
r=20
> create rename setattr };
>=20
> Why not create_dir_file(initrc_t, initrc_state_t)?  It does the same thin=
gs=20
> and is easier to read.

Well I wrote this a long time ago, and thats a new macro.  Its that way
because its least privilege.  Ok, the middle line isn't exactly least,
but close, whereas the last line is half the possible permissions.=20
However, I guess if other distros are going to start using state info,
as you say later in the email, then it should be generalized to
create_dir_file.

> +allow initrc_t etc_runtime_t:dir read;
>=20
> Your patch doesn't include any .fc entries to label a directory as=20
> etc_runtime_t.

This is going to appear in my types.fc patch.  The directory I'm
referring to is not specific to initrc.

> +domain_auto_trans(sysadm_t,initrc_exec_t,run_init_t)
>=20
> This isn't something I expected, I'm not sure if it's desirable to do it =
like=20
> that but I can't think of any better way.  Steve, what do you think about=
=20
> this?

Since run_init is integrated into our init script interpreter, there is
afaik no other way to get into run_init_t since the scripts are run as
usual (/etc/init.d/foo start).

> The initrc_state_t stuff is something that will get more general use I th=
ink. =20
> In both Debian and Fedora there is work on making machines boot from CD-R=
OM=20
> which needs such things.  Is that what it's being used for in Gentoo?

It stores state and dependency info for the init scripts.

> Your patch is good, but I think we need to think about making it more gen=
eric=20
> before putting it in CVS.  Probably making the CVS policy more like what =
you=20
> are doing in Gentoo in some ways will be better for everyone.
--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-ndXHKEPCS1u0h6EFYgpz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBTYTjvI7kLeavkkMRAm9fAJ9MdYPL5gUvLi3hNBYk/nv5myBgDwCeLIbF
PBapyLmf9GvAdFixZ+IMnys=
=xbde
-----END PGP SIGNATURE-----

--=-ndXHKEPCS1u0h6EFYgpz--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
