Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n89Dxo7M022659
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 09:59:50 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n89E1AkE015526
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 14:01:11 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id n89Dxem0058507
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 15:59:40 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] ([147.32.84.251])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id n89DxebC080666
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 15:59:40 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Wed, 9 Sep 2009 15:59:40 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: MCS and default labels
Message-ID: <20090909135940.GG24297@myhost.felk.cvut.cz>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
 <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
 <20090908163628.GC24297@myhost.felk.cvut.cz>
 <1252429805.13634.423.camel@moss-pluto.epoch.ncsc.mil>
 <20090909100647.GE24297@myhost.felk.cvut.cz>
 <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
 <20090909131935.GF24297@myhost.felk.cvut.cz>
 <1252503271.13634.669.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qVHblb/y9DPlgkHs"
In-Reply-To: <1252503271.13634.669.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qVHblb/y9DPlgkHs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen Smalley wrote:
> > Maybe I am not seeing something after all. Suppose I use the full MLS
> > variant and give a user the labels c1,c2. How exactly would it happen
> > that in a c1 dir he would automatically create c1 files, and in c1,c2
> > dir c1,c2 files?
>=20
> He wouldn't.  The first case would violate MLS write-down restrictions.

Ah, I see the point now. In some literature, categories are
discretionary even when sensitivity levels are used. So a s1:c1 process
can write to s1, but not to s0:c1.

> Different people have different views of MCS.  And it hasn't really
> worked out the way it was envisioned.  There has been some discussion of
> this, including during the SELinux summits (minutes are published).

Thanks, I guess I need to read more on that. I've googled the 2007
minutes, but not the other ones. Would you happen to have some links?

Regards,
Michal Svoboda



--qVHblb/y9DPlgkHs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkqntMwACgkQg/fU9pp1uX7QjQCghpCEWxcHdi4rZX5mN+kt8DM7
/PYAoIUUUltdQBdKfSj4cXawds0dQkF2
=6DX1
-----END PGP SIGNATURE-----

--qVHblb/y9DPlgkHs--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
