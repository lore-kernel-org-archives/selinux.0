Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2PI6bDo010858
	for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2005 13:06:37 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2PI3e54025045
	for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2005 18:03:40 GMT
Subject: Re: [RFC] selinux-support (1.0.1) available
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1111760828.15280.65.camel@moss-spartans.epoch.ncsc.mil>
References: <1111704432.27644.62.camel@localhost.localdomain>
	 <1111759697.15280.53.camel@moss-spartans.epoch.ncsc.mil>
	 <1111760828.15280.65.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tVJRBa/zXzHgSRizEH4g"
Date: Fri, 25 Mar 2005 19:05:46 +0100
Message-Id: <1111773946.27644.132.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-tVJRBa/zXzHgSRizEH4g
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El vie, 25-03-2005 a las 09:27 -0500, Stephen Smalley escribi=F3:
> On Fri, 2005-03-25 at 09:08 -0500, Stephen Smalley wrote:
> > Can you explain the purpose of this package?  I'm not sure I understand
> > what you mean, or why the above packages would depend on it.  What is
> > the purpose of the /etc/selinux.conf file in this package, and how does
> > it compare to the already existing /etc/selinux/config file that is
> > being used by libselinux and various scripts?  Do you expect this to
> > remain Ubuntu-specific?
>=20
> Another question is how are you handling the SELinux-patched userspace
> in Ubuntu?  Integrated into the main packages as in Fedora or a separate
> set of packages like Russell Coker's current packages for Debian?  The
> former is obviously preferable if possible.

Integrated, I'm right now working with some packages, just finished
logrotate, now working on sysvinit, openssh and PAM.

Each modified package should depend on the proper libraries: ie.
libselinux1 and libselinux1-dev

I'm putting them on http://pearls.tuxedo-es.org/selinux/ubuntu/ among
updated packages of libselinux1 and others.

> Note that you should check the latest SELinux userspace patches from the
> Fedora CVS tree, as they have continued to evolve.  Note that there are
> now two separate SELinux-related patches for sysvinit in the Fedora CVS
> tree, sysvinit-selinux.patch and sysvinit-2.85-selgenusers.patch, where
> the latter patch was a more recent change to support pulling in
> local.users at policy load time without requiring a policy rebuild.

Right, the patches imported from the Fedora CVS being used are hosted
on:
http://pearls.tuxedo-es.org/selinux/userland-patches/

Sysvinit will need more work to get also other interesting patches, I'm
working on it.

> Also note that in some cases, SELinux support has gone into the main
> sources in the Fedora packages and is no longer a separate patch at all
> (or if a patch exists, it is a refinement of the original SELinux
> support rather than the complete SELinux support), e.g. for libuser,
> logrotate, passwd, prelink, etc.

Right, in this case, I would like to know if there's someone from Red
Hat interested in getting in touch with the sources, thus providing
separate patches, or we won't be able to handle this correctly.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-tVJRBa/zXzHgSRizEH4g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCRFL6DcEopW8rLewRAuspAKCrwcb9Mhwti4q4D4ss3LHM2S9FIgCgnH0I
8oOVI/Y5CWtJihYoz6O+2NU=
=BJ0M
-----END PGP SIGNATURE-----

--=-tVJRBa/zXzHgSRizEH4g--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
