Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3ED4eEW009161
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 09:04:40 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3ED48ln028810
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 13:04:08 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o3ED4SOv093135
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 15:04:28 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o3ED4BNN028938
	for <selinux@tycho.nsa.gov>; Wed, 14 Apr 2010 15:04:11 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Wed, 14 Apr 2010 15:04:28 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: MLS telnet question
Message-ID: <20100414130428.GD21894@myhost.felk.cvut.cz>
References: <6235CF4DC66FD5478F0E350E17C202FF251F2BB146@HVXMSP3.us.lmco.com>
 <20100413164236.GE16595@myhost.felk.cvut.cz>
 <201004131754.58738.paul.moore@hp.com>
 <6235CF4DC66FD5478F0E350E17C202FF251F46F50F@HVXMSP3.us.lmco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
In-Reply-To: <6235CF4DC66FD5478F0E350E17C202FF251F46F50F@HVXMSP3.us.lmco.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Benedict, Phillip M wrote:
> Also I currently have separate ssh daemons running at certain
> sensitivities (runcon) and bound to specific IP addresses (separate
> sshd_config files). Will fallback labeling impact my ssh setup?

I would say that each sshd will be only able to communicate with equally
labeled peers.

Michal Svoboda

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkvFvVwACgkQg/fU9pp1uX62VwCgtA1QZjLLFehY2Q4NcTYTggg9
8e0An1WI4thOMejIQtzQgn6LSW9bY9+D
=y2z3
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
