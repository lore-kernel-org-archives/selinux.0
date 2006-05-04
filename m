Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4491YkQ018395
	for <selinux@tycho.nsa.gov>; Thu, 4 May 2006 05:01:35 -0400
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4491WDs011846
	for <selinux@tycho.nsa.gov>; Thu, 4 May 2006 09:01:33 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 4 May 2006 11:01:29 +0200
Date: Thu, 4 May 2006 11:01:28 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Joshua Brindle <method@gentoo.org>
Cc: Karl MacMillan <kmacmillan@tresys.com>, Jeremy Katz <katzj@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Paul Nasrat <pnasrat@redhat.com>, James Antill <jantill@redhat.com>
Subject: Re: We are attempting once again to split policy	out	into	individual RPMS.
Message-Id: <20060504090128.GA7306@thorium.jmh.mhn.de>
References: <44576B91.8060607@redhat.com> <44577454.5040204@gentoo.org> <1146583000.32102.8.camel@orodruin.boston.redhat.com> <44577BC5.3050009@gentoo.org> <1146584925.32102.36.camel@orodruin.boston.redhat.com> <1146669307.6723.20.camel@localhost.localdomain> <4458FE33.80908@gentoo.org> <1146683243.2766.42.camel@localhost.localdomain> <44591D4A.10005@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
In-Reply-To: <44591D4A.10005@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Joshua Brindle <method@gentoo.org> [2006-05-03 23:24]:
[Discussion about allowing rpm to write security labels to disk which
are not in the policy]=20
> I am baffled why the advocates of this believe making kernel tolerant of=
=20
> inconsistent filesystem labels and allowing strange policy interactions=
=20
> for the sake of bandaiding an inadequacy in RPM is better.. .*shrug*

For the record, I'm also opposed to this change. It can be handled
entirely in userspace, which IMHO is the proper place.

I still think that separate policy packages would be the best solution.
They're the standard way of doing what you want, people understand them,
and they provide an easy way to look at policy for analysis. Another
important point: They make it easy for people to supply alternative
policy. Want to use strict instead of targeted? No need to replace every
package containing policy, just create a new repository with policy
packages in them, and give this repository a higher priority.

If you really don't want to use separate packages you could implement
something like dpkg triggers[1]. Basically you could add a trigger
"Reload SELinux policy", which would be run between preinst and actual
installation if any policy was changed. Then you could add an option to
semodule: "Store module and install it on next policy rebuild".
I think that would solve your problems within the current framework,
without requiring kernel changes.
Another advantage: If a policy module is bad (symbol clashes, ...) you
notice before installation.

Thomas

[1]: See http://www.netsplit.com/blog/tech/debian/dpkg/where_next_for_dpkg_=
=2Ehtml
I don't think it has been implemented yet but the idea sounds very nice.


--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEWcLoD9qpeVMU938RAozJAKCcCi6Z2GfjYcyXIIMII7ZSvOKQyQCgmR8L
j5CIkxDQ2U8XO6FC7HA5J7A=
=UDf/
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
