Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBALe0Ii023777
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 16:40:00 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBALe3R8013513
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 21:40:03 GMT
Message-Id: <200412102139.iBALdhHh020525@turing-police.cc.vt.edu>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: Russell Coker <russell@coker.com.au>, Daniel J Walsh <dwalsh@redhat.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: can_network patch. 
In-Reply-To: Your message of "Fri, 10 Dec 2004 20:11:07 +0100."
             <20041210191107.GA5059@jmh.mhn.de>
From: Valdis.Kletnieks@vt.edu
References: <41741A2C.8040408@redhat.com> <1102698638.1628.148.camel@moss-spartans.epoch.ncsc.mil> <41B9E48A.8010204@redhat.com> <200412110511.12960.russell@coker.com.au>
            <20041210191107.GA5059@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1015039288P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 10 Dec 2004 16:39:42 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1015039288P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Dec 2004 20:11:07 +0100, Thomas Bleher said:

> Or add a boolean to control the transition from the userdomain to
> mozilla. Then we can have a locked down policy for people who just want
> to securely browse the web. People who want all the bells and whistles
> can turn the transition off at the cost of higher exposure.

I could live with that.  However, before long we're in danger of getting lost
in a maze of tiny little twisty booleans, all different... :)


--==_Exmh_-1015039288P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBuheecC3lWbTT17ARAgKGAKCiU4FVSwJkesCh6fgladxLs6WcWgCgiZbU
N7G/otPuJvLagFgJ6ajaPlE=
=y7Lu
-----END PGP SIGNATURE-----

--==_Exmh_-1015039288P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
