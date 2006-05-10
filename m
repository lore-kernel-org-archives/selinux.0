Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4AMBqRi025301
	for <selinux@tycho.nsa.gov>; Wed, 10 May 2006 18:11:52 -0400
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4AMBo8W002749
	for <selinux@tycho.nsa.gov>; Wed, 10 May 2006 22:11:51 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 11 May 2006 00:11:49 +0200
Date: Thu, 11 May 2006 00:11:47 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: James Morris <jmorris@namei.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][SECMARK 05/08] Add new packet controls to SELinux
Message-Id: <20060510221146.GG8937@thorium.jmh.mhn.de>
References: <Pine.LNX.4.64.0605071104590.8588@d.namei> <Pine.LNX.4.64.0605071136100.8588@d.namei> <1147106449.23640.102.camel@moss-spartans.epoch.ncsc.mil> <Pine.LNX.4.64.0605081947400.19850@d.namei> <1147174138.32651.5.camel@moss-spartans.epoch.ncsc.mil> <Pine.LNX.4.64.0605091146350.25693@d.namei>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
In-Reply-To: <Pine.LNX.4.64.0605091146350.25693@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* James Morris <jmorris@namei.org> [2006-05-09 18:00]:
> On Tue, 9 May 2006, Stephen Smalley wrote:
>=20
> > > It doesn't seem warranted as a boot option and/or kernel config optio=
n as=20
> > > the desired behavior can be trivially selected during early boot.
> >=20
> > I was thinking it would be helpful for distributions (example:  Fedora
> > Core 4 and 5 re-base to 2.6.18, want the compatibility mode enabled by
> > default, do not wish to update/add some new userspace component to
> > trigger the compatibility mode).   And also for users to deal with
> > mismatches between their kernels and userlands (example:  kernel
> > developer using Fedora Core 5 as his development platform builds an
> > upstream kernel and boots it, but FC5 userland has no knowledge of
> > either the new checks or the compatibility mode, so it would be nice if
> > he could enable the compatibility mode in his kernel config or select it
> > trivially via boot param).  But I have no strong opinion; if no one else
> > thinks it is necessary, that is fine.
>=20
> The thing is that the old network controls will be going away at some=20
> point reasonably soon in the upstream kernel, and it seems wrong to add=
=20
> more than the minimally required infrastructure to support it.  Perhaps=
=20
> legacy distros which update their kernels but not their policy tools to=
=20
> match should patch this into the kernel themselves.  I don't think it=20
> belongs upstream.  The compat networking is for transition purposes only,=
=20
> and if the distro isn't going to transition, it's diverging from mainline=
=20
> and needs to carry that burden itself, not expect the mainline kernel to=
=20
> do so.

I'd prefer a config option because it makes it possible to load old
policy without changing things beyond the kernel. It also alerts people
that they will need to upgrade their userland before they switch to the
next kernel.

Remember: Not all people use distro kernels (or have selinux userland
provided by their distro). It's not nice to break compatibility without
a proper notice in advance.

I think there is a tendency here to break backwards compatibility[1]
because "RedHat will fix it". This gives SELinux a reputation of "breaks
regularly, maintainers don't care for their users". We should avoid this
if at all possible.

(Possibly crazy idea: Would it be possible to change the module format
so that the kernel recognizes permissions which are not defined in the
loaded policy at all and automatically allows them? This would allow us
to define new permissions (e.g. for decomposing CAP_SYS_ADMIN) without
needing comlex compatibility code or breaking systems.)

Thomas

[1]: "Breaking backwards compatibility" happened in the past when
name_connect and the various exec* checks were introduced, because after
updating the kernel the system didn't work anymore, because the new
permissions weren't granted in the policy.


--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEYmUiD9qpeVMU938RAjD4AJwOw8knC6NW7RAmYrT3h9ySOO4E9QCeJUzw
aRDIlMpaAfXZgoEz0Smx47k=
=3koF
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
