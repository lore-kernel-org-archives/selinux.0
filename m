Subject: Re: spasswd.c
From: kayo <kayo@pyra.ca>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200302162251.40417.russell@coker.com.au>
References: <DTCOIKAKKNB3NWCMMKNXKJCDHTEAEFP3JRHWOJAF@ziplip.com>
	 <200302162251.40417.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kBNs+FeFlaQKdBznV3hN"
Message-Id: <1045507488.3079.5.camel@smeagol>
Mime-Version: 1.0
Date: 17 Feb 2003 12:44:48 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-kBNs+FeFlaQKdBznV3hN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Your little play machine rocks, but in my insomnia one night i will find
something you havent included in your security model. But damn you cant
do shit even as root... i would like to see what you did and why and how
cheers





On Sun, 2003-02-16 at 15:51, Russell Coker wrote:
> On Sun, 16 Feb 2003 22:36, Dusty Hall wrote:
> >   Thanks for the fix, it worked like a champ.  Although now I'm having
> > problems compiling disk-utils, specifically raw.c.  The following is th=
e
> > error message:
> >
> > cc -O -pipe -O2 -m486 -fomit-frame-pointer -I../lib -Wall
> > -Wmissing-prototypes -Wstrict-prototypes -I/usr/include/ncurses -DNCH=
=3D0
> > -I/usr/include/slang -D_FILE_OFFSET_BITS=3D64 -DSBINDIR=3D\"/sbin\"
> > -DUSRSBINDIR=3D\"/usr/sbin\" -DLOGDIR=3D\"/var/log\" -DVARPATH=3D\"/var=
\"
> > -DLOCALEDIR=3D\"/usr/share/locale\"  -s  raw.c   -o raw raw.c:22:
> > linux/raw.h: No such file or directory
>=20
> It seems that your system doesn't have the latest headers.  Login to my p=
lay=20
> machine and copy the headers you need.  The login details are in my SE Li=
nux=20
> web site.

--=-kBNs+FeFlaQKdBznV3hN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+US2f+2nlubU9QZIRApNdAJ9Asipa+RiOUE3/Ln7qK9QD4X367gCeOZSp
Ty0W+J0To/zs0IcN9+qF1do=
=DLvD
-----END PGP SIGNATURE-----

--=-kBNs+FeFlaQKdBznV3hN--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
