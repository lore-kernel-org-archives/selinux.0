Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAL25Ii023519
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 16:02:05 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAL0Rwg024071
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 21:00:27 GMT
Message-Id: <200412102101.iBAL1NeN009808@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Jim Carter <jwcart2@epoch.ncsc.mil>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: can_network patch. 
In-Reply-To: Your message of "Sat, 11 Dec 2004 05:11:07 +1100."
             <200412110511.12960.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <41741A2C.8040408@redhat.com> <1102698638.1628.148.camel@moss-spartans.epoch.ncsc.mil> <41B9E48A.8010204@redhat.com>
            <200412110511.12960.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1105077332P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 10 Dec 2004 16:01:21 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1105077332P
Content-Type: text/plain; charset=us-ascii

On Sat, 11 Dec 2004 05:11:07 +1100, Russell Coker said:

> We have mozilla running in it's own domain to limit the risk of exploits of 
> mozilla taking over the rest of the system.  Allowing mozilla to install 
> packages seems to directly contradict this aim.

Gaak.  Given the "browser can install software" mentality that's one of the single
biggest design borkages in That Other Browser/Operating System, we should do what
we can to fix this...

> Maybe we should just remove the mozilla policy?

I'd rather have a mozilla policy that enforces (roughly) "it can play inside
the ~/.mozilla tree, and download into ~/Downloads or similar, and any other
activity is constrained".

Or did you mean "remove the bit of policy that allows it to install packages",
in which case we're in total agreement....

--==_Exmh_-1105077332P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBug6hcC3lWbTT17ARAr2mAKDGlZvfhVwc5Hvl9TGD+MzVZAvkZACgu9WU
ETqYyXutKTB2p8XR4bt3TUI=
=t/u8
-----END PGP SIGNATURE-----

--==_Exmh_-1105077332P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
