Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i62I6mrT015184
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 14:06:48 -0400 (EDT)
Received: from sccrmhc11.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i62I6ldS009593
	for <selinux@tycho.nsa.gov>; Fri, 2 Jul 2004 18:06:47 GMT
Subject: Re: Compiling error - sysvinit
From: Chris PeBenito <pebenito@gentoo.org>
To: Jan Gehring <pr0gm4@linoratix.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20040702190146.78697fe7.pr0gm4@linoratix.com>
References: <20040702134850.353b2f51.pr0gm4@linoratix.com>
	 <20040702071544.GA3277@lkcl.net> <20040702092526.GD3277@lkcl.net>
	 <20040702190146.78697fe7.pr0gm4@linoratix.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XU6YRlLA2rewpTVXnoa1"
Message-Id: <1088791604.6478.6.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Fri, 02 Jul 2004 13:06:45 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-XU6YRlLA2rewpTVXnoa1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-07-02 at 12:01, Jan Gehring wrote:
> > > > i tried to compile sysvinit-2.85 but i get the following error.
> > > >=20
> > > > root@maracuja src # make LDFLAGS=3D"-s -lselinux" CFLAGS=3D"-D_GNU_=
SOURCE"
> > > > cc -c -D_GNU_SOURCE -DWITH_SELINUX init.c
> > > > [...]
> > > > init.c:97: error: `SELINUXMNT' undeclared (first use in this functi=
on)
> > > > [...]
> > > > init.c:123: error: `SELINUXPOLICY' undeclared (first use in this fu=
nction)
> > > > make: *** [init.o] Error 1

Most likely you are trying to compile an older sysvinit patch against
libselinux-1.14.  I saw this myself a few days ago.  These two #defines
are gone in 1.14.  Best bet is to update your sysvinit patch.  I added
back these two #defines back into Gentoo's libselinux-1.14 selinux.h for
compatibility, which is another option.

The #defines were:

#define SELINUXMNT "/selinux/"
#define SELINUXPOLICY "/etc/security/selinux/policy"

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

--=-XU6YRlLA2rewpTVXnoa1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA5aQ0vI7kLeavkkMRAlsIAJ9N5RaoihLVz6/4vTHjwZM9BbDr4ACaAxv4
cvJbiqxQDRQu49TrbgzQq+s=
=c0tU
-----END PGP SIGNATURE-----

--=-XU6YRlLA2rewpTVXnoa1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
