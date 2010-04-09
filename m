Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o39Cqds7015199
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2010 08:52:39 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o39CqAxg007810
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2010 12:52:10 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o39CqN8i024871
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2010 14:52:23 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o39CppsM029406
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2010 14:51:51 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Fri, 9 Apr 2010 14:52:23 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Cannot not open session
Message-ID: <20100409125223.GV1518@myhost.felk.cvut.cz>
References: <5A5E55DF96F73844AF7DFB0F48721F0F52E46493A4@EUSAACMS0703.eamcs.ericsson.se>
 <1270816722.2650.7.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PLOb/g6AMdJ1vPHZ"
In-Reply-To: <1270816722.2650.7.camel@moss-huskers.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--PLOb/g6AMdJ1vPHZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Stephen Smalley wrote:
> Early Fedora and RHEL-4 put pam_selinux in /etc/pam.d/su in an effort to
> automatically change contexts upon user identity changes.  This proved
> to be a mistake in practice (and a deviation from the original SELinux
> approach), and was subsequently removed in later Fedora and RHEL-5.

BTW, is there any further explanation of why this is a mistake? And
question #2, I think sudo still does this, isn't that a mistake too?

Michal Svoboda

--PLOb/g6AMdJ1vPHZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAku/IwcACgkQg/fU9pp1uX5mbQCeIU05wzuVuE6OGiACRyIUaPDZ
7/sAn2IX0t8kNgEqMUzZBC+0gUZcIHm5
=5DUA
-----END PGP SIGNATURE-----

--PLOb/g6AMdJ1vPHZ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
