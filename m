Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h646piHa005576
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 02:51:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h646opnJ017678
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 06:50:51 GMT
Received: from mylaptop (ppp-177-195.27-151.libero.it [151.27.195.177])
	by jazzswing.ncsc.mil  with ESMTP id h646onhr017675
	for <selinux@tycho.nsa.gov>; Fri, 4 Jul 2003 06:50:50 GMT
Date: Fri, 4 Jul 2003 08:51:35 +0200
From: Mauro Chiarugi <vlaovic@libero.it>
Cc: selinux@tycho.nsa.gov
Subject: Re: Policies.. but where there are?
Message-Id: <20030704085135.0ffdf7a7.vlaovic@libero.it>
In-Reply-To: <200307040852.51081.russell@coker.com.au>
References: <20030703234800.330f8026.vlaovic@libero.it>
	<200307040852.51081.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.5j_anVGL++5Ogr"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=.5j_anVGL++5Ogr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Il Fri, 4 Jul 2003 08:52:51 +1000
Russell Coker borbottando disse:

> They are stored in a "policy database" named
> /etc/security/selinux/policy.XX (where XX is the version number) in
> recent versions.

I believe that policy.XX is protected against attacks, such as malicious
editing.. is it right???

-- 
Porgere l'altra guancia non significa
iptables -t filter -P INPUT ACCEPT
iptables -t filter -P OUTPUT DROP
--=.5j_anVGL++5Ogr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE/BSP7nHfOyhtK3rgRAooTAJ9V6uN0gOLcgSEd3g7Xp7Xk6D7UPACfQD/K
dyBiSk2ytTo2zIEkCxzOqco=
=I6pG
-----END PGP SIGNATURE-----

--=.5j_anVGL++5Ogr--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
