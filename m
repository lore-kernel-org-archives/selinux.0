Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3SGILEP020832
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 12:18:24 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o3SGJOdF010392
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 16:19:25 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o3SGIDxV047557
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 18:18:13 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o3SGI3oc011251
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 18:18:03 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Wed, 28 Apr 2010 18:18:13 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELINUX: new permission controlling the ability to set
 suid
Message-ID: <20100428161813.GC1622@myhost.felk.cvut.cz>
References: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com>
 <1271972155.16202.55.camel@moss-pluto.epoch.ncsc.mil>
 <4BD18CAE.4050201@redhat.com>
 <20100426061848.GS21894@myhost.felk.cvut.cz>
 <4BD58C7B.1000507@redhat.com>
 <20100426143933.GU21894@myhost.felk.cvut.cz>
 <4BD5AF15.8000301@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/e2eDi0V/xtL+Mc8"
In-Reply-To: <4BD5AF15.8000301@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Daniel J Walsh wrote:
> If we went full lock down on every domain then we would not have > 70%
> of the fedora community running with SELinux enabeled in enforcing
> mode.

I hear you and I still believe this was/is a smart choice, but I think
with your proposal you're not adhering to its spirit.

If unconfined means equal to DAC then the unconfined user should be able
to become unconfined root even if via seteuid backdoor. If you want to
prevent this then you're confining the user. (You're now _targeting_
that ability.)

So here's an idea: why not just make an unconfined_user_t that would be
stripped of root powers so that even if it becomes euid 0 he could not=20
exercise them. Then just control the ways of unconfined_user_t becoming
unconfined_admin_t (for example, type transition on trusted seteuid
executable program files).

Seems to me much simpler and much more bulletbroof than removing _one_
possible way of many by what you proposed - that is confining an already
confined admin, which is only very remotely responsible for what you
want to avoid.

> This is not default allow.  It is DAC + MAC as opposed to the way most
> people run, which is just DAC. I am trying to make setattr check better.

Note that from MAC viewpoint, DAC is remarkably similar to default allow.


Michal Svoboda

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvYX8UACgkQg/fU9pp1uX4EigCcCWsRbelOpP/x3coDTeav3jyo
GGkAnjJyM6f9kX/SNXiSRAW5TTg7t5Zz
=iRCa
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
