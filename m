Message-Id: <200503041845.j24Ijqb2016599@turing-police.cc.vt.edu>
To: Holger Burde <hburde@t-online.de>
Cc: SELinux@tycho.nsa.gov
Subject: Re: new user domain (FC3) 
In-Reply-To: Your message of "Fri, 04 Mar 2005 15:07:30 +0100."
             <1109945251.5546.12.camel@marvin.warpnet.com>
From: Valdis.Kletnieks@vt.edu
References: <1109945251.5546.12.camel@marvin.warpnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109961952_5140P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 04 Mar 2005 13:45:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1109961952_5140P
Content-Type: text/plain; charset=us-ascii

On Fri, 04 Mar 2005 15:07:30 +0100, Holger Burde said:
> Hi;
> 
> I am looking for Infos on how to add new user domains to the FC3
> targeted Policy. Any examples/papers available ? The only example 
> one i found depends on a user.te file in $SEHOME/domains which is not
> available in FC3-targeted (examples based on that do not work).

New user domains won't work in -targeted because the whole idea of targeted is
"dump all 'real' users in -unrestricted_t and only really enforce on some of
the daemon_t types".  You need  to run -strict to have the separation needed
to make multiple user domains make any sense at all..


--==_Exmh_1109961952_5140P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCKKzgcC3lWbTT17ARAsglAKCIZiOodq5z5XHLTt/jQHl10mP2wQCg1SMP
AQX5AKYOLepNDhnZQt8Pwcg=
=5in+
-----END PGP SIGNATURE-----

--==_Exmh_1109961952_5140P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
