Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3E6JYqA020258
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 02:19:34 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3E6J2e0017388
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 06:19:03 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o3E6JF9S050268
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 08:19:15 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o3E6IwS0014737
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 08:18:59 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Wed, 14 Apr 2010 08:19:14 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: The confusing dot operator
Message-ID: <20100414061914.GA21894@myhost.felk.cvut.cz>
References: <20100406134846.GO1518@myhost.felk.cvut.cz>
 <1271185979.9577.62.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
In-Reply-To: <1271185979.9577.62.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen Smalley wrote:
> mcstransd

I tried to use this daemon at first but it appeared to require one
translation line for each possible combination of the categories and
even ranges of them. For example, on a particular centos 5 machine I
have to specify

s0-s0:c0=3Dcoreprocess
s0-s0:c1=3Dwebprocess
s0:c0=3Dcore
s0:c1=3Dweb

Actually the same behavior is illustrated by the default

s0-s0:c0.c1023=3DSystemLow-SystemHigh
s0:c0.c1023=3DSystemHigh

confusingly enough, s0 does not equal SystemLow but an empty string.

I recall reading a presentation (IIRC from a symposium proceeding) that
would suggest an improvement was planned here, but how far has that
effort progressed?

OTOH I somehow feel safer to have the words 'core' and 'web' stored
directly in the inode of the disk rather than rely on a run time mapping
=66rom some generic number. (That's why I don't like unix UID/GIDs too
much either.)

Finally, it would appear that even the most smart mcstransd can't do too
much about the 'rangeizing' feature. The kernel itself presents c0,c1,c2
as c0.c2, so mcstrans can only *guess* that there is a c1 in between. Or
is there a way to query the kernel about the exact list of categories?

> It also serves a practical end - keeping context string sizes sane for
> kernel interfaces (/selinux/* and /proc/self/attr/*).

Does a category length such as 16 characters classify as 'sane' too, or
is there a noticeable overhead?

> I think we're open to improvements in this area, but naturally we will
> need to retain compatibility for the current users of the dot
> notation.  We have talked in the past about improving direct kernel
> support for complex label encodings, but unfortunately no one has
> really moved forward in that space.

Do you have some pointers to these talks?


Regards,
Michal Svoboda


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvFXmIACgkQg/fU9pp1uX44iACgjss6VnpQHJLzz3bJuSt83SUC
3IwAoKkgpHkcv2qcV75DzfP+utz9KkO9
=ha4u
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
