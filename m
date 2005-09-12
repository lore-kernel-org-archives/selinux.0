Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8CKKPNs016448
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2005 16:20:25 -0400 (EDT)
Received: from estila.tuxedo-es.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8CKHel1000647
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2005 20:17:41 GMT
Subject: Re: Problem compiling libselinux 1.26
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Pierre <pierre42d@9online.fr>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4325DE1A.2000408@9online.fr>
References: <4325DE1A.2000408@9online.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ozDoH/F1fwdZVL3MtABk"
Date: Mon, 12 Sep 2005 22:17:41 +0200
Message-Id: <1126556261.19011.2.camel@estila>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ozDoH/F1fwdZVL3MtABk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

El lun, 12-09-2005 a las 21:59 +0200, Pierre escribi=C3=B3:
> # make
> make -C src
> make[1]: Entering directory `/tmp/libselinux-1.26/src'
> gcc -s -O3 -march=3Di686 -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=
=3D64=20
> -c -o fgetfilecon.o fgetfilecon.c
> fgetfilecon.c:6:23: sys/xattr.h: No such file or directory
> make[1]: *** [fgetfilecon.o] Error 1
> make[1]: Leaving directory `/tmp/libselinux-1.26/src'
> make: *** [all] Error 2

You need the file-system extended attributes related header files, but
you lack of them for some reason.

You can try to get them from http://sosdg.org/~coywolf/lxr/source/ or
re-install your kernel headers packages, or just get updated ones.

I hope it helps ;)

Cheers,
--=20
Lorenzo Hern=C3=A1ndez Garc=C3=ADa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-ozDoH/F1fwdZVL3MtABk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBDJeJkDcEopW8rLewRAjxfAJ9BrYky/v4qlrSB0k9IJGTnl8UCBgCgp/2Y
R1IzbPKW5fhl9QnqD+2lv1U=
=wagt
-----END PGP SIGNATURE-----

--=-ozDoH/F1fwdZVL3MtABk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
