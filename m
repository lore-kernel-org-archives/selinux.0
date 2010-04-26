Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3QEdi6S030219
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2010 10:39:45 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3QEeitO021563
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2010 14:40:45 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o3QEdYVe011482
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2010 16:39:34 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o3QEcnKP073154
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2010 16:38:49 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Mon, 26 Apr 2010 16:39:33 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELINUX: new permission controlling the ability to set
 suid
Message-ID: <20100426143933.GU21894@myhost.felk.cvut.cz>
References: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com>
 <1271972155.16202.55.camel@moss-pluto.epoch.ncsc.mil>
 <4BD18CAE.4050201@redhat.com>
 <20100426061848.GS21894@myhost.felk.cvut.cz>
 <4BD58C7B.1000507@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AHVSF3we4xtO5oi5"
In-Reply-To: <4BD58C7B.1000507@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--AHVSF3we4xtO5oi5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Daniel J Walsh wrote:
> First my example was sort of a gross oversimplification.  It would not
> only effect unconfined_t but any other domain that could use the
> setuid bit to gain additional privs.

If a domain can use uid=0 to get additional privileges then the MAC
policy has holes... like cheese and relies on DAC to plumb them. That
significantly reduces the utility of the MAC.

> unconfined_t to a user means, give him all the power of a normal user
> with SELinux disabled.  You are still protected by DAC.  I would argue
> that you want to make sure there are limited setuid apps around when
> running with unconfined_t.  But if you give him unconfined_t and
> "chcon 4755"  as a confined user running as root, then you make it
> easy for him to become unconfined_t running as UID=0.

The problem with this reasoning is thus:

1) you give the user unconfined_t, well, okay, sad but perhaps necessary
2) you give the user root
3) you wonder that the user has root & unconfined

I know that the root in (2) is 'bundled in' a MAC restricted domain but
since root is a DAC concept it propagates ('leaks') back to the DAC
world.

You now want the MAC to stop the leak, but IMO that is a futile attempt.
It would take some serious analysis to find out how many ways 'root' can
leak out. I bet suid is not the only one. How about screwing up the web
server so that it runs as root and listens for your commands.

> If we want people to experiment with confined admins, allow unconfined_t
> - -> sudo_exec_t -> confined_admin_t is a good thing.

People can experiment with confined admins as they like, but they should
note that as long as they have an unconfined element in the game the
system simply won't be secure. Default allow has never worked.

Simply put I don't like this from systemic sense, but perhaps the demand
is so high that you should go ahead (with a big fat red warning).


Michal Svoboda


--AHVSF3we4xtO5oi5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvVpaUACgkQg/fU9pp1uX4xTgCfaU8D46y3qVfGZQeC5Qa7qUeW
P5cAn3wsLp+ZkbtKAMWvmje290MPokB8
=pLgk
-----END PGP SIGNATURE-----

--AHVSF3we4xtO5oi5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
