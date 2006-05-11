Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4BJmDh1019509
	for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 15:48:13 -0400
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4BJmCQm027571
	for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 19:48:12 GMT
Message-Id: <200605111948.k4BJmACc019175@turing-police.cc.vt.edu>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: textrel_shlib_t
In-Reply-To: Your message of "Thu, 11 May 2006 15:08:07 EDT."
             <44638B97.8080009@redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <200605111730.k4BHUc13006509@turing-police.cc.vt.edu>
            <44638B97.8080009@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147376890_2474P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 11 May 2006 15:48:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1147376890_2474P
Content-Type: text/plain; charset=us-ascii

On Thu, 11 May 2006 15:08:07 EDT, Daniel J Walsh said:

> http://people.redhat.com/~drepper/selinux-mem.html

I had that one already, it mostly discusses using chcon as a workaround..

> http://people.redhat.com/~drepper/dsohowto.pdf

Aha! Some digging through this one, and we find:

The library in question wasn't compiled with -fpic or similar.

This looks easy enough to fix. :)

--==_Exmh_1147376890_2474P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEY5T6cC3lWbTT17ARAifmAKCVC6rR9nZi9a/duNE+fhDb9i+mSwCfRK5b
RL2GHArcrYMFJcYqSi05fEE=
=EQiq
-----END PGP SIGNATURE-----

--==_Exmh_1147376890_2474P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
