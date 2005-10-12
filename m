Date: Wed, 12 Oct 2005 10:34:30 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux@tycho.nsa.gov
Subject: Re: System hang during boot on Debian Sid
Message-Id: <20051012083430.GA8035@thorium.jmh.mhn.de>
References: <20051009083426.GA10995@localhost.localdomain> <1129033658.3308.48.camel@moss-spartans.epoch.ncsc.mil> <20051011132002.GA6249@localhost.localdomain> <20051011170544.GE8829@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
In-Reply-To: <20051011170544.GE8829@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2005-10-11 19:16]:
> On Tue, Oct 11, 2005 at 08:20:02PM +0700, Dave Patterson wrote:
> > * Stephen Smalley <sds@tycho.nsa.gov> [2005-10-11 08:27:38 -0400]:
> >=20
> >=20
> > > > and the system hangs.  Any suggestions?
> > >=20
> > > That change was included in the 2.6.13-selinux1.patch and is going to=
 be
> > > part of 2.6.14 upstream (already in 2.6.14-rcX, and has been in Fedora
> > > rawhide kernels for a while).
> > Ah. OK...=20
> > > I don't know about the state of SELinux in Debian sid, but Russell's
> > > message indicated that udev doesn't work well with SELinux in Debian
> > > yet. =20
> > >=20
> > And I can see why - Debian's initrd is archaic, so I don't use it
> > unless I have to, and udev in our distro is indeed grumpy.
> > No, the main cause of my problems so far lie in my policy
> > configuration at the moment (the boot process was hanging at INIT) -
> > Russel's package is the strict policy, and I haven't edited it well
> > enough yet.  I'm attempting a prototype multiuser, multilingual
> > desktop install using this, and I've banged my shins on a few things so=
 far.
>=20
>  yes, you will.
>=20
>  not least of those will be if you use kdm.
>=20
>  xdm, kdm, gdm, wdm, all seem to derive from the same codebase at some
>  point.  they've been hacked about rather badly since, and the
>  authorisation code has been shuffled.
>=20
>  gdm is fairly sorted (because it's the default on FC) but kdm?  naah.
>=20
>  the last time i mentioned this, i believe it was russell who mentioned
>  that there needs to be some work done in creating a modified policy to
>  deal with kdm.
>=20
>  specifically, there is a part of kdm which communicates via a socket to
>  the user desktop bit, which allows kde to shut down the system.

I don't think that's true any longer. I have kdm running here without
special modifications or patches (at least for normal user logins). If
kdm should be able to shutdown the system it needs to have some access
to lilo, but I don't remember completely (could dig it up if you want).
I do not allow my users to shutdown the system from within their session
so I don't know what mods you need for this.

Thomas


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDTMqWxWIrrrL0q+cRAnzlAKC43EvDTSO3GeCsoxf/zELT97mCeQCgl2b8
JgtZxm6YU2jvpJ2olSVMm98=
=qBD6
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
