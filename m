Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n89A79Va025241
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 06:07:09 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n89A6S66009272
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 10:06:28 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id n89A6me2039389
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 12:06:48 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] ([147.32.84.251])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id n89A6lDS014607
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 12:06:48 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Wed, 9 Sep 2009 12:06:47 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: MCS and default labels
Message-ID: <20090909100647.GE24297@myhost.felk.cvut.cz>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
 <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
 <20090908163628.GC24297@myhost.felk.cvut.cz>
 <1252429805.13634.423.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
In-Reply-To: <1252429805.13634.423.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen Smalley wrote:
> Unfortunately for you, MCS is using the existing MLS engine, which
> doesn't presently support inheritance from parent directory (unlike the
> TE engine).  So to support the behavior you want, you'd have to modify
> the actual code (and that's kernel code).  Thus, you are more likely to
> find success using actual MLS or using TE.

Let me see if I can come up with a simple patch that does the work. It
sounds better than rewriting each app to actually change the labels for
themselves. (Is there even an API for specifying MCS label prior to file
creation? If it has to be changed after the file exists then it's a huge
race condition style hole.)

> > Secondly I don't see why a user is not able to discretionarily specify
> > his range outright when going via ssh just as he can with roles.=20
>=20
> That's another artifact of the MLS model (label preservation /
> confinement).

Unfortunately here I have no idea on what code should I look to remove
that artifact.

> > No. MLS is about strict ordering 0 < 1 < 2 ... I just want a partially
> > ordered set. I want compartments, not sensitivities. MCS and MLS are
> > orthogonal, at least by their theoretical properties (and SELinux MCS
> > strongly resembles the theory in practice).
>=20
> I think you're confused about MLS; it supports a set of hierarchical
> sensitivities and a set of non-hierarchical categories, and MCS is
> nothing more than a particular configuration of the MLS engine.  So you
> are free to just use a single MLS sensitivity and only use its
> categories. =20

I think I am not confused. There are two principles, sensitivities and
categories. Categories do have hierarchy, just not a strictly ordered
one. For any two categories one could find a supremal and infimal ones,
and that's what contributes to the quadratic number of types should TE
be used instead.

A MCS system is then just taking advantage of the categories principle,
and not utilising the sensitivities one. That is perfectly what I want,
but I just want it to be usable on my use case, ie. files inheriting
categories from parent dirs, which I think is perfectly valid. I see
this topic recurring and the standard reply "use something else than
MCS" is just weird at least.

Regards,
Michal Svoboda

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkqnfjcACgkQg/fU9pp1uX5otQCfe+qBrEyLSL1gZhC2Y9geN4mK
hvEAoKE7weFWX+OSPNCiStB2h7or4Q+9
=nv9L
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
