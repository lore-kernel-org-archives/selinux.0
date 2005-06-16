Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5GHt3gA002994
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 13:55:03 -0400 (EDT)
Received: from estila.tuxedo-es.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5GHjrI8027805
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 17:45:54 GMT
Subject: Re: ANN: SELinux Reference Policy Release
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: antoine <antoine@nagafix.co.uk>, Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1118930113.18294.56.camel@sgc.columbia.tresys.com>
References: <1118871745.18294.28.camel@sgc.columbia.tresys.com>
	 <1118874951.24338.35.camel@nexus.verbum.private>
	 <1118877949.10103.19.camel@localhost>
	 <1118930113.18294.56.camel@sgc.columbia.tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KvpiaFnoiviM30B4Wh69"
Date: Thu, 16 Jun 2005 19:46:23 +0200
Message-Id: <1118943983.8987.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-KvpiaFnoiviM30B4Wh69
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El jue, 16-06-2005 a las 09:55 -0400, Christopher J. PeBenito escribi=F3:
> We did look into other available formats for machine parseable comments,
> and XML is really the best choice if you want the comments to be
> transformed into many different formats, and easily loaded into other
> programs; its already well understood, and parsers exist for many
> programming languages.  Simpler (for humans to read) commenting formats
> just don't have these options, and mainly target one transformation.

A modified Gnome-doc (ie. Kernel-doc) might be an interesting option.
It would be a matter of modifying the lex and other stuff to make it
parsing our own commenting style within the policy files.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-KvpiaFnoiviM30B4Wh69
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCsbrvDcEopW8rLewRAsX+AKCe+W/EOrRxBkSauSrO7mThz/o8/wCcD+zv
DyiVThcJrCowsecsH3FVq8A=
=4dpx
-----END PGP SIGNATURE-----

--=-KvpiaFnoiviM30B4Wh69--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
