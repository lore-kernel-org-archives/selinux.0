Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VDrlgA004560
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 09:53:47 -0400 (EDT)
Received: from h80ad25eb.async.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4VDlpC0015078
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 13:47:52 GMT
Message-Id: <200505311347.j4VDlfo7027518@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Chris PeBenito <pebenito@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: gentoo/hardened 
In-Reply-To: Your message of "Tue, 31 May 2005 01:57:39 BST."
             <20050531005739.GH28006@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20050530013136.GA28006@lkcl.net> <1117496766.1742.39.camel@chris.pebenito.net>
            <20050531005739.GH28006@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1117547259_3664P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 31 May 2005 09:47:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1117547259_3664P
Content-Type: text/plain; charset=us-ascii

On Tue, 31 May 2005 01:57:39 BST, Luke Kenneth Casson Leighton said:

>  valdis just this week chopped a stack-load of [iirc
>  correctly: unused? ] macro stuff out and the memory usage
>  dropped dramatically.
> 
>  if what valdis has done is suitable for gentoo/hardened,
>  that would [fortunately!] make this justification redundant
>  (i hope!)

What I did *seems* to work *on my laptop*.  The *correct* way to do it would
involve adding a whole bunch of m4 ifdefs.  I think for what Chris was trying
to do for Gentoo, the *right* fix wasn't deleting code, but wrapping the
code to be removed in a ifndef(`gentoo') wrapper....

--==_Exmh_1117547259_3664P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCnGr7cC3lWbTT17ARAmrUAJ0ax27KM/QsxY+ESiD6ObOVhPUy3QCePlso
3ALNP0IFerHCAkGv8+BmTTE=
=e1Td
-----END PGP SIGNATURE-----

--==_Exmh_1117547259_3664P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
