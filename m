Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3Q6IxeA003164
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2010 02:18:59 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3Q6IOfY014355
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2010 06:18:25 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o3Q6InIG065622
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2010 08:18:49 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o3Q6IZqN025258
	for <selinux@tycho.nsa.gov>; Mon, 26 Apr 2010 08:18:35 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Mon, 26 Apr 2010 08:18:48 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELINUX: new permission controlling the ability to set
 suid
Message-ID: <20100426061848.GS21894@myhost.felk.cvut.cz>
References: <20100422204612.25506.16029.stgit@paris.rdu.redhat.com>
 <1271972155.16202.55.camel@moss-pluto.epoch.ncsc.mil>
 <4BD18CAE.4050201@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y51z1SGMnxVzkhDv"
In-Reply-To: <4BD18CAE.4050201@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Y51z1SGMnxVzkhDv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Daniel J Walsh wrote:
> One possible use case would be.  I want to allow a user to login as
> unconfined_t and only be able to become root as webadm_t through sudo.
>=20
> If webadm_t has setattr on /var/www, he can cp /bin/sh /var/www/sh,
> chcon 4755 /var/www/sh, exit webadm_t and as unconfined_t become root
> using /var/www/sh.

Isn't this just a side effect of the 'unconfined' philosophy? I've
always been taught (and taught others) that with proper MAC controls you
can have as many setuid shells as you like.

You already give all your trust to the user by giving him unconfined.
Placing setuid controls in place is curing only (one of many) symptoms,
not the cause.

Michal Svoboda


--Y51z1SGMnxVzkhDv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvVMEgACgkQg/fU9pp1uX52wACghMxzDn5xmjcSXv80pkUS5aEM
8q4AnROIaB1YAdK/iyB+DgFH5y56a5iE
=uIOK
-----END PGP SIGNATURE-----

--Y51z1SGMnxVzkhDv--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
