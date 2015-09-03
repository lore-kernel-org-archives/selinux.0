Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t83D4tp9014729
 for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2015 09:04:55 -0400
Received: by wicfx3 with SMTP id fx3so51569020wic.0
 for <selinux@tycho.nsa.gov>; Thu, 03 Sep 2015 06:04:53 -0700 (PDT)
Date: Thu, 3 Sep 2015 15:04:50 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: secilc: in segfault
Message-ID: <20150903130449.GC2118@x250>
References: <20150903094844.GA18832@x250> <55E83A89.5010208@tycho.nsa.gov>
 <20150903124013.GB2118@x250> <55E842DD.3080408@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
In-Reply-To: <55E842DD.3080408@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2015 at 02:53:49PM +0200, Petr Lautrbach wrote:

<snip>

> >=20
> > # cd selinux
> > # make LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64
> >=20
> > I have installed all the build dependencies i believe
> >=20
> > This is what it is failing with here:
> >=20
> > cc1: all warnings being treated as errors
> > Makefile:113: recipe for target 'direct_api.o' failed
> > make[2]: *** [direct_api.o] Error 1
> > make[2]: Leaving directory
> > '/home/kcinimod/Workspace/selinux/libsemanage/src'
> > Makefile:2: recipe for target 'all' failed
> > make[1]: *** [all] Error 2
> > make[1]: Leaving directory
> > '/home/kcinimod/Workspace/selinux/libsemanage'
> > Makefile:11: recipe for target 'all' failed
> > make: *** [all] Error 1
> >=20
>=20
> This report seems to be little stripped so the important messages are
> missing. Nevertheless, according to README you should use install
> target. The following command works for me on Fedora 23:
>=20
> make DESTDIR=3D/home/plautrba/devel/build/selinux  install
>=20

That seems to work, thanks



> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.


--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV6EVtAAoJENAR6kfG5xmcWcUMALzLb37R30PBgpU+S8JB2P9d
mBJE71VU52DzS4YwkPQE2djvC6rKf7Zof/sz0xmnOr5c1cWX6Xz/3UKEVyPyh8Lo
Gm7RPOyHKie07hZ/2iJCIj7Ghre1JFwZlLigJ37VvthLI6VksrUOkD9oFzo7hghb
mFI7y68CaefhxBEKmARcI32CYpkQs3Q6v/cSQq+gPw36WZjGPtAyuXg6xU/wJ04J
mVjJ91fRTw3D2u40GK4Jn3KS3DhhVGaVohMKzZrGZ7XwlhvJckqx3d7H+tRKQlKw
0t7afHF33dOLT5all+u7kghhXyYS7GfndpJElJTMsEvlxuYqpf5nS+soyPxp3ZCO
pXoR6z811ES3BML2p5KAUYq1BWWKdMdWZ3O543jNsaG0sibAxi7fSI8jeW46ZU4c
s7UToTKOVHZU460t2PfqUpsiwJszxExC8tL19DScDT8VCKO0xxw4SQFYDAflz9+F
MGH7Ndq5WfgavqbnXtUfuKK05YfLEbmJWc8ZtE5djw==
=j0p8
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
