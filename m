Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o45Hl7UI007567
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 13:47:07 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o45HmBV7008635
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 17:48:12 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o45HkiKx072845
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 19:46:44 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o45Hkfft027710
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 19:46:42 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Wed, 5 May 2010 19:46:43 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: The confusing dot operator
Message-ID: <20100505174643.GC27129@myhost.felk.cvut.cz>
References: <20100406134846.GO1518@myhost.felk.cvut.cz>
 <1271185979.9577.62.camel@moss-pluto.epoch.ncsc.mil>
 <20100414061914.GA21894@myhost.felk.cvut.cz>
 <B4BA93A9-0C9A-4C43-95A5-46979F2084DF@nall.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
In-Reply-To: <B4BA93A9-0C9A-4C43-95A5-46979F2084DF@nall.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Joe Nall wrote:
> http://github.com/joenall/mcstrans

Thank you I will take a look when I get to it.

> > OTOH I somehow feel safer to have the words 'core' and 'web' stored
> > directly in the inode of the disk rather than rely on a run time mapping
> > from some generic number. (That's why I don't like unix UID/GIDs too
> > much either.)
>=20
> I disagree. I prefer something on the inode with predictable, portable
> mathematical meaning. Adding web/code/fu/bar means that the policy on the
> object is dependent on yet another config file/policy because you need
> to encode the semantic meaning of those words somewhere. The beauty of the
> current approach is that the kernel doesn't have to know word semantics
> to do range dominance checks.

I always thought that it was the c0 stuff that needed run time support
to be semantical, at least to humans using it.

There is nothing more mathematical about c0.c1023 than there is about
apple, banana and cherry. Categories have no ordering. What really
matters here is the set inclusion operator (dominance).=20

About predictability I dare say that c0.c1023 attempts to create a fake
sense of ordering where there is not. Therefore is slightly less
predictable.

And I'm not sure what you mean by portability. If it means transferring
categories between systems then with fixed notation like c0 there is
only higher chance of conflicting with other uses for the categories on
the target system.

While experimenting with this I found out that the biggest plus of the
generic categories is that you do not need to reload policy, restart
sshd, crond, etc. when you add new ones. (And God forbid removing them,
I even managed to get a kernel panic while playing with MCS too much ;)

But I'm not sure if this is a problem. Change of categories is a change
in security policy and that is a major enough event to require restart
of services which authenticate users.


Michal Svoboda


--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvhrwMACgkQg/fU9pp1uX4yHgCgqFH1381PF5814fz4NERApCcy
3cMAoJF2KVVV/MWXm2pl7kUcJ5MnLRvZ
=lz+l
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
