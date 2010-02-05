Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o15G7ZTX030472
	for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2010 11:07:35 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o15G7NUn025124
	for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2010 16:07:23 GMT
Date: Fri, 5 Feb 2010 17:07:20 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: Re: MLS and network
Message-ID: <20100205160720.GN1750@myhost.felk.cvut.cz>
References: <20100204174901.GL1750@myhost.felk.cvut.cz>
 <1265306980.22595.7.camel@moss-pluto.epoch.ncsc.mil>
 <20100205051921.GM1750@myhost.felk.cvut.cz>
 <1265378086.18100.33.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hXth9cGL35Nvpk4x"
In-Reply-To: <1265378086.18100.33.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--hXth9cGL35Nvpk4x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen Smalley wrote:
> The port-based checks (e.g. name_bind, name_connect) are not relevant
> to MLS and there are no MLS constraints written on them.

I see. In the refpolicy they say that name_bind/name_connect have no
MLS restrictions. But they place restrictions on tcp_socket write and
read, shouldn't those kick in?

BTW, what's the difference between connect and name_connect?

> 2) Can you provide more details about your configuration and your test
> case (e.g. your exact netlabel configuration, the policy package you are
> using, the context in which your process runs)?

Fedora 12 with latest updates; mls policy package. Base package
description says:
Based off of reference policy: Checked out revision  2.20090730

Context is user_u:user_r:user_t:s1

I did something like=20
netlabelctl unlbl add default address:0.0.0.0/0 \
	label:system_u:object_r:netlabel_peer_t:s0

I could see the packets on the outgoing interface.

Michal Svoboda


--hXth9cGL35Nvpk4x
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktsQjgACgkQg/fU9pp1uX4xAACbBfwD4cdAmrRn52SuEZbsnAPt
bRoAn3Ud/SeukRHu0ipnGZ6lc0mh3nSq
=qwlA
-----END PGP SIGNATURE-----

--hXth9cGL35Nvpk4x--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
