Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3SIsGHG030105
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 14:54:16 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3SIregg000926
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 18:53:40 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o3SIs3Lw057651
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 20:54:03 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o3SIrL3X055266
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2010 20:53:21 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Wed, 28 Apr 2010 20:54:03 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELINUX: new permission controlling the ability to set
 suid
Message-ID: <20100428185403.GD1622@myhost.felk.cvut.cz>
References: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com>
 <1271972155.16202.55.camel@moss-pluto.epoch.ncsc.mil>
 <4BD18CAE.4050201@redhat.com>
 <20100426061848.GS21894@myhost.felk.cvut.cz>
 <4BD58C7B.1000507@redhat.com>
 <20100426143933.GU21894@myhost.felk.cvut.cz>
 <4BD5AF15.8000301@redhat.com>
 <20100428161813.GC1622@myhost.felk.cvut.cz>
 <4BD8713A.3060702@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
In-Reply-To: <4BD8713A.3060702@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Daniel J Walsh wrote:
> Admin installs a third party app that requires setuid/setgid or some
> other priv, now he needs to write policy to transition his staff_t to
> thirdparty_t.  In my scenario, unconfined_t will be able to run the
> third party app, and will be able to becom confinedadmin_t for some sudo
> jobs.

The admin will have a choice to either write that policy or keep the
users unconfined while sacrificing some security (that setuid example
AND a lot of others) or to give users two roles for this n that.

Isn't this feasible?


Michal Svoboda


--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvYhEsACgkQg/fU9pp1uX7cigCfRo9xdOrx/ucfHRced0V9UV+c
9wgAn3YF5Z77yv6iHQArAV20FoyRsEsn
=jgit
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
