Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2V1npRb017653
	for <selinux@tycho.nsa.gov>; Tue, 30 Mar 2004 20:49:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2V1lvlU027678
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 01:47:57 GMT
Received: from turing-police.cirt.vt.edu (turing-police.cirt.vt.edu [128.173.54.129])
	by jazzswing.ncsc.mil  with ESMTP id i2V1lukh027675
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 01:47:56 GMT
Message-Id: <200403310149.i2V1nmpk020948@turing-police.cc.vt.edu>
To: "lcvleo@ig.com.br" <lcvleo@ig.com.br>
Cc: selinux@tycho.nsa.gov
Subject: Re: Problems to compile the src.rpm packages on Red Hat Linux 9.0 
In-Reply-To: Your message of "Tue, 30 Mar 2004 19:20:49 -0300."
             <1080685248.6780.5.camel@linux.linuxista.eti.br>
From: Valdis.Kletnieks@vt.edu
References: <1080685248.6780.5.camel@linux.linuxista.eti.br>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1503807328P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 30 Mar 2004 20:49:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1503807328P
Content-Type: text/plain; charset=us-ascii

On Tue, 30 Mar 2004 19:20:49 -0300, "lcvleo@ig.com.br" <lcvleo@ig.com.br>  said:
>        Dear friends,
>        I have problems when trying compile the packages coreutils,
> openssh, pam, vixie-cron, shadow-utils. Only this packages. This message
> error is present:
>  
>  checking for i686-pc-linux-gnu-gcc... i686-pc-linux-gnu-gcc
>  checking for C compiler default output... configure: error: C compiler
>  cannot create executables
>  See `config.log' for more details.

And what does the config.log say?  (Most likely, the directory isn't writable
by you, or you have an odd $CFLAGS setting)....

--==_Exmh_1503807328P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAaiO7cC3lWbTT17ARAv+9AKDRslUv0rPYkQN/SRj40Lvqcm0vgQCgmXxE
uIwBnz8jV8V9V+wvd7bw0gE=
=F1ET
-----END PGP SIGNATURE-----

--==_Exmh_1503807328P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
