Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k44JIe8S031613
	for <selinux@tycho.nsa.gov>; Thu, 4 May 2006 15:18:44 -0400
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k44JIbMb027448
	for <selinux@tycho.nsa.gov>; Thu, 4 May 2006 19:18:38 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 4 May 2006 21:18:36 +0200
Date: Thu, 4 May 2006 21:18:34 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Joshua Brindle <method@gentoo.org>, Karl MacMillan <kmacmillan@tresys.com>,
        Jeremy Katz <katzj@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
Subject: Re: We are attempting once again to split policy	out	into	individual RPMS.
Message-Id: <20060504191834.GB7303@thorium.jmh.mhn.de>
References: <44576B91.8060607@redhat.com> <44577454.5040204@gentoo.org> <1146583000.32102.8.camel@orodruin.boston.redhat.com> <44577BC5.3050009@gentoo.org> <1146584925.32102.36.camel@orodruin.boston.redhat.com> <1146669307.6723.20.camel@localhost.localdomain> <4458FE33.80908@gentoo.org> <1146683243.2766.42.camel@localhost.localdomain> <44591D4A.10005@gentoo.org> <20060504090128.GA7306@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
In-Reply-To: <20060504090128.GA7306@thorium.jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Thomas Bleher <bleher@informatik.uni-muenchen.de> [2006-05-04 11:15]:
> * Joshua Brindle <method@gentoo.org> [2006-05-03 23:24]:
> [Discussion about allowing rpm to write security labels to disk which
> are not in the policy]=20
> > I am baffled why the advocates of this believe making kernel tolerant o=
f=20
> > inconsistent filesystem labels and allowing strange policy interactions=
=20
> > for the sake of bandaiding an inadequacy in RPM is better.. .*shrug*
>=20
> For the record, I'm also opposed to this change. It can be handled
> entirely in userspace, which IMHO is the proper place.
>=20
> I still think that separate policy packages would be the best solution.
> They're the standard way of doing what you want, people understand them,
> and they provide an easy way to look at policy for analysis. Another
> important point: They make it easy for people to supply alternative
> policy. Want to use strict instead of targeted? No need to replace every
> package containing policy, just create a new repository with policy
> packages in them, and give this repository a higher priority.
>=20
> If you really don't want to use separate packages you could implement
> something like dpkg triggers[1]. Basically you could add a trigger
> "Reload SELinux policy", which would be run between preinst and actual
> installation if any policy was changed. Then you could add an option to
> semodule: "Store module and install it on next policy rebuild".
> I think that would solve your problems within the current framework,
> without requiring kernel changes.
> Another advantage: If a policy module is bad (symbol clashes, ...) you
> notice before installation.

I got a reply from Jeremy indicating that my message was not as clear as
I thought.

So to clear up any confusion, here's how package installation could
work:
1. rpm is given a list of packages to be installed.
2. It runs all preinstall scripts of the to-be-installed packages
3. Every package which has its own policy asks semodule to instll its
   policy package on the next policy rebuild; it also sets a flag (or
   trigger, whatever you want to call it): "I need policy reloaded before
   I'm installed"
4. After all preinstall scripts have been run, rpm reloads the policy
5. Now everything is set up so packages can be installed normally.

*HOW* you store the policy in the package is not so important (you can
also store it in a special section in the package so that the package
does not need to have an install script). The important point is that
first all policies are extracted from the packages, then policy is
reloaded, and after that packages are installed.

I think this does everything you want, just without kernel changes.

Thomas

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEWlOKD9qpeVMU938RAl0XAJ9O337BKefWiphYNs9Vm/huEHwZowCeL6ti
+zv9rBCQZC3XPO3dXiLIEow=
=NanC
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
