Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o155JWhw030991
	for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2010 00:19:33 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o155JMZt017279
	for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2010 05:19:23 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o155JMvu024855
	for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2010 06:19:22 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o155JL4t081241
	for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2010 06:19:22 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Fri, 5 Feb 2010 06:19:21 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: MLS and network
Message-ID: <20100205051921.GM1750@myhost.felk.cvut.cz>
References: <20100204174901.GL1750@myhost.felk.cvut.cz>
 <1265306980.22595.7.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5FetH82qe0Z6y/zI"
In-Reply-To: <1265306980.22595.7.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--5FetH82qe0Z6y/zI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Stephen Smalley wrote:
> If you want network enforcement, you need to configure labeled
> networking - that isn't enabled by default.

Thanks. I have two more questions. First, why does MLS require this, but
for TE it is sufficient to have labeled ports? And second, I have
managed to label my network to s0, but still, if I try to connect as s1
user, the outbound connection gets through, only the response (ie.
syn/ack) is denied. This still violates BLP; is this a matter of how the
refpolicy is set up?

Michal Svoboda

--5FetH82qe0Z6y/zI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktrqlkACgkQg/fU9pp1uX4YaACeNyMlKa2+iYU52pyO01pb72cE
icMAnimC7lua1pPPETG3su3EWGJFOJK2
=rIZx
-----END PGP SIGNATURE-----

--5FetH82qe0Z6y/zI--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
