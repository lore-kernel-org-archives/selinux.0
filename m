Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1RLm3Do021540
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 16:48:03 -0500 (EST)
Received: from h80ad260a.async.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1RLf1jS014388
	for <selinux@tycho.nsa.gov>; Sun, 27 Feb 2005 21:41:55 GMT
Message-Id: <200502272139.j1RLdo28027659@turing-police.cc.vt.edu>
To: todd glassey <todd.glassey@worldnet.att.net>
Cc: selinux@tycho.nsa.gov
Subject: Re: Compromise of SHA1 and SElinux 
In-Reply-To: Your message of "Sun, 27 Feb 2005 09:16:27 PST."
             <00d501c51cf1$651072c0$010aff0a@gw>
From: Valdis.Kletnieks@vt.edu
References: <1109400342.4581.25.camel@cobra.ivg2.net> <20050227104528.GC28871@lkcl.net>
            <00d501c51cf1$651072c0$010aff0a@gw>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109540389_17337P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 27 Feb 2005 16:39:49 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1109540389_17337P
Content-Type: text/plain; charset=us-ascii

On Sun, 27 Feb 2005 09:16:27 PST, todd glassey said:
> Got a question for this list - the hash collision that was discussed by
> Rivest, Shamir, and Hoyt at RSA2005 is a serious one. Is there an initiative
> to upgrade SELinux tools to address these new liabilities in SHA1. Most
> folks are moving to SHA256 at minimum and to 512 if they can.

Umm... excuse me if I blinked, but where does SELinux even *use* SHA1 for anything?

Now the guys who wrote the BSD Seclevel LSM *do* need to look at upgrading, as
that beast *does* use SHA1 for something.

--==_Exmh_1109540389_17337P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCIj4kcC3lWbTT17ARAiFUAKCXFu8Lnar0X6sT4CWk5kTV9r75tgCg/flP
/hOVXxucilP/fUoJDhCOwCQ=
=MIlX
-----END PGP SIGNATURE-----

--==_Exmh_1109540389_17337P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
