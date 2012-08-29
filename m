Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7TD3MpQ002948
	for <selinux@tycho.nsa.gov>; Wed, 29 Aug 2012 09:03:23 -0400
Date: Wed, 29 Aug 2012 15:02:33 +0200
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: network packet context
Message-ID: <20120829130233.GA14196@telmora.telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have another one of those 'Is it normal?' questions.

To begin with my system does not label network packets in any=20
way, packets are not unlabeled_t, they just seem to be ignored by=20
LSM. There is no rule of the type 'allow X Y:packet { send recv }'
required, all domains can access the network.

When I introduce just a single iptables rule utilizing SECMARK, say

    iptables -A INPUT -t security -i tun0 -j SECMARK system_u:object_r:sec_=
tun_t:s0

to label all packets coming in at tun0, then suddenly all traffic=20
on all devices gets labeled. Those which lack an iptables rule=20
get unlabeled_t. Suddenly all network is locked down and I need=20
'allow X Y:packet { send recv }' rules in the policy.

Ole

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlA+EukACgkQS1FjE303ERwKoACggSm0Sh0FDWPl2yZe4VuENuzW
HPYAn1yU4nCqzvdPf3e+R8aC8uQw5Iqx
=8dIH
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
