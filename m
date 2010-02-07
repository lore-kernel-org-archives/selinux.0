Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o17GOCcp030140
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 11:24:12 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o17GO0Ps012709
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 16:24:00 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o17GNxPu044801
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 17:23:59 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o17GNx0Y047163
	for <selinux@tycho.nsa.gov>; Sun, 7 Feb 2010 17:23:59 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Sun, 7 Feb 2010 17:23:58 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: Selinux in enforcing mode prevent network interface to be
 configured at boot for Debian stable ( 5.0)
Message-ID: <20100207162358.GR1750@myhost.felk.cvut.cz>
References: <bf30b281002070012q1d9a33ffsc90781d217e05f9b@mail.gmail.com>
 <4B6E7CE0.1050107@gmail.com>
 <bf30b281002070131l4821a6abg45a3cbc3d01a08e6@mail.gmail.com>
 <4B6E8EF5.3010608@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BuGwuXnZwGGQ9GEc"
In-Reply-To: <4B6E8EF5.3010608@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--BuGwuXnZwGGQ9GEc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Justin P. Mattock wrote:
> if nothing the do a
> sudo /usr/sbin/semodule -DB
> (reboot)
> then what does audit2allow say?
> should give you some allow rules
> if so add them to your policy.

This will most likely output a very large number of rules that don't
make sense, ie. they would do more bad than good.

The basic problem is that the network scripts don't have their own
restricted domain in which they could run. Running them from udev on
'network hotplug event' will copy the udev context, which doesn't have
enough privileges to configure network. Giving these privileges to udev
directly would be sub-optimal.

Michal Svoboda

--BuGwuXnZwGGQ9GEc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktu6R4ACgkQg/fU9pp1uX5VFwCgnmlmZ3lJrBVdOsLj0rN0Lhnj
HJsAn2BuUlLUnYhhy1KFBhx3NYzqZktI
=OjTZ
-----END PGP SIGNATURE-----

--BuGwuXnZwGGQ9GEc--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
