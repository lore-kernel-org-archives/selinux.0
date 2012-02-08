Message-ID: <1328730315.5174.1.camel@foxtrot.cjac.ntr.f5net.com>
Subject: Re: SELinux on Wheezy
From: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>
Date: Wed, 08 Feb 2012 11:45:15 -0800
In-Reply-To: <1328723647.19254.62.camel@moss-pluto>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328543813.1905.2.camel@x220.mydomain.internal>
	 <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636118.4224.35.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636826.2162.60.camel@moss-pluto>
	 <1328640976.4224.39.camel@foxtrot.cjac.ntr.f5net.com>
	 <20120207200224.GB18478@colliertech.org>
	 <1328645305.2162.105.camel@moss-pluto>
	 <20120207210501.GE18478@colliertech.org>
	 <1328707470.19254.16.camel@moss-pluto>
	 <1328722790.23833.9.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328723647.19254.62.camel@moss-pluto>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-ygN/5UUo2gWTfim/TCQU"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ygN/5UUo2gWTfim/TCQU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-08 at 12:54 -0500, Stephen Smalley wrote:
> On Wed, 2012-02-08 at 09:39 -0800, C.J. Adams-Collier KF7BMP wrote:
> > On Wed, 2012-02-08 at 08:24 -0500, Stephen Smalley wrote:
> > > On Tue, 2012-02-07 at 13:05 -0800, C.J. Adams-Collier wrote:
> > > > cjac@foxtrot:~$ sudo which seinfo
> > > > cjac@foxtrot:~$ apt-file search seinfo | grep bin | wc -l
> > > > 0
> > >=20
> > > seinfo is part of the setools package.
> >=20
> > $ apt-cache search -n setools
> > erlang-parsetools - Erlang/OTP parsing tools
> >=20
> > Hmm.
> >=20
> > Would it be safe to build seinfo from source and use it along with the
> > distro-installed tools?  If so, what's the git repo I should clone from=
?
>=20
> Curious, as setools is packaged for Debian squeeze per
> packages.debian.org.  Did the package go un-maintained before wheezy?
>=20
> Upstream is at:
> http://oss.tresys.com/projects/setools

cjac@foxtrot:/usr/src/git/debian/setools$ git log | head -5
commit 22a5d3e451d8a1e60a3c746466c865e63089a92a
Merge: fa238f0 149e283
Author: Manoj Srivastava <srivasta@debian.org>
Date:   Tue Jul 20 23:10:06 2010 -0700

I guess it has been unmaintained.  I just sent an email off to srivasta@
requesting some help getting the package built.

> > $ locate xserver.pp
> > /usr/share/selinux/default/xserver.pp
> >=20
> > I'll run semodule -i after this morning's reboot.  I installed mutt
> > yesterday, so I'll work from the console until you folks sign off for
> > the evening.
>=20
> I'd suggest installing all of the .pp files to ensure you aren't missing
> anything else.  The man page for semodule has some examples of how to
> install all modules from a directory.

What's the best way to do this at boot?



--=-ygN/5UUo2gWTfim/TCQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABCAAGBQJPMtDLAAoJEEyimPmPQm23aOsH/jf7XXEliVAJAjPzUHlGjFl8
Ol2anbm/vdZjKzlUwzJ/dNO3w3IVlQXsulOoDi3xN/shGaI5D1pgHk+g6/7jAG7D
5kHAeHw8t69gN3Yr4wb9qNyC+ih2GDD5/4n300TorKOzi6zkWDsI+9pCGzwGUIaB
TGjjMDx5adxlYWZEy5r5o6LyDYmr9kNst22Lo681MhRcKoM6Lj/Z3wvkvMX8rYmP
qSZfQvI2zSz6axV7Rgo3cw8VEPmuQzdZdzNDosgaCujXvde/m1oyFsSfr4nHRhZT
HLR0AJXiMMNny0Q0dO4hs3AT9nZCgsxFtvTenETVz1AQjngcjVGABfslPstLa8A=
=4QGK
-----END PGP SIGNATURE-----

--=-ygN/5UUo2gWTfim/TCQU--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
