Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o17IAsvZ001510
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 13:10:54 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o17IAh1b016029
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 18:10:44 GMT
Date: Sun, 7 Feb 2010 19:10:16 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Subject: Re: MLS and network
Message-ID: <20100207181016.GS1750@myhost.felk.cvut.cz>
References: <20100204174901.GL1750@myhost.felk.cvut.cz>
 <1265388590.18100.73.camel@moss-pluto.epoch.ncsc.mil>
 <20100205192806.GP1750@myhost.felk.cvut.cz>
 <201002051547.27944.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5tINJiUS2/Dn5Rhr"
In-Reply-To: <201002051547.27944.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--5tINJiUS2/Dn5Rhr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Paul Moore wrote:
> Not 100% sure about this, but I'm fairly certain this is SELinux type
> enforcement issue.  Have you tried adding some policy like the
> following:
>=20
> 	allow netlabel_peer_t netif_t:netif { ingress };

Nope, but sesearch comes up empty. In other news, same denial for
s0<->s0. So, you're right.

> The default setting is part of the SELinux policy using an "initial
> SID" and isn't something you probably want to modify.  I would
> recommend using semanage to set the interfaces individually.

I don't think this is such a good idea. The rule should be "what's not
allowed, is denied". Now all interfaces that the user sticks in get
implicitly s0-s15 and, perhaps even worse, since they have to be
reconfigured from userspace, there would be a slight delay until that
happens, even if done by udev-launched script. Moreover, interfaces can
be labeled anyhow, so pre-semanaging eth0 through say eth99 is only a
partial solution, let alone clumsy.

Thus I would advocate for the default to be low.

> Dynamic permission checks.  If you don't have any type of labeled
> networking configuration present the permission checks are disabled
> inside the kernel.  It may seem odd right now, but trust me, this is a
> very good thing.

I agree, this is odd and brutally contra-intuitive. We're speaking about
egress checks (due to BLP) but we need to configure ingress labeling?
(And even of a fallthrough kind?) What's the reasoning behind this?

There's one more question, if I may. It appears to me that secmark and
netlabel, when confronted with normal (ie. non-CIPSO, etc) traffic,
provide redundant ways to label ingress packets. (Netlabel has fewer
options but it too operates on a per-packet basis.) Is this so, and if,
are there plans for unification?

Regards,
Michal Svoboda

--5tINJiUS2/Dn5Rhr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktvAggACgkQg/fU9pp1uX7tcQCfaPCS/NVKyGqmwFmwOV2jsAoZ
SOMAnAg5LZQjA9KATRpyHlQACaO0npd/
=JEP/
-----END PGP SIGNATURE-----

--5tINJiUS2/Dn5Rhr--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
