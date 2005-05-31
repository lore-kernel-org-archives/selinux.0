Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VEH5gA004863
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 10:17:05 -0400 (EDT)
Received: from h80ad25eb.async.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4VEAkpZ013866
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 14:10:48 GMT
Message-Id: <200505311410.j4VEAecr028211@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
Subject: Re: smaller memory footprint for 'strict' policy - helping gentoo as well 
In-Reply-To: Your message of "Tue, 31 May 2005 12:09:48 BST."
             <20050531110947.GB4131@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20050531012824.GI28006@lkcl.net> <429BCDDD.8080106@gentoo.org>
            <20050531110947.GB4131@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1117548639_3664P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 31 May 2005 10:10:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1117548639_3664P
Content-Type: text/plain; charset=us-ascii

On Tue, 31 May 2005 12:09:48 BST, Luke Kenneth Casson Leighton said:

>  okay - then i must have misunderstood what valdis has done that
>  reduces the memory footprint so dramatically.
> 
>  i mean, _yes_ of course, personally, i remove any policy
>  domains that aren't used, i assume that naturally _everybody_
>  does that because otherwise a package could be installed
>  without consent and it would work (whereas if the policy
>  isn't there, it will definitely fail).

The only thing that I really did was get very fascist about moving stuff to
unused/, (I have more things in unused/ than not) and identify a few things in
macros/program that need some work (I think I identified like 10 entire files
in there that *my* config totally doesn't need).  I suspect the reason I saw
such big savings is because some of the stuff in macros/program generates a
*lot* of $USER_foo_t types unnecessarily (thus the need for more ifdefs to
suppress that).

I'll make up a proper patch later this week when I have more time...

--==_Exmh_1117548639_3664P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCnHBfcC3lWbTT17ARAmkiAKCY57LSRSdTYc72sXxAAR2EKloEGACdEuA3
iwkdi1r5BHniNWW8z7HzsLs=
=6iOF
-----END PGP SIGNATURE-----

--==_Exmh_1117548639_3664P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
