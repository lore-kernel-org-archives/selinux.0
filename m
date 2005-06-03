Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j53GFggA001789
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 12:15:42 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j53G9GjH007201
	for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2005 16:09:16 GMT
Message-Id: <200506031609.j53G8v1W005959@turing-police.cc.vt.edu>
To: Roger Brunell <rog_brunell@yahoo.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Labeling confusion with apt-get/dpkg 
In-Reply-To: Your message of "Fri, 03 Jun 2005 07:36:39 PDT."
             <20050603143639.59205.qmail@web33209.mail.mud.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <20050603143639.59205.qmail@web33209.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1117814928_3726P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 03 Jun 2005 12:08:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1117814928_3726P
Content-Type: text/plain; charset=us-ascii

On Fri, 03 Jun 2005 07:36:39 PDT, Roger Brunell said:

> and I do not have a libpam that is selinux aware. Manoj's site lists libpam as
> a target that needs to be worked, but as yet has no updated modules. I think I
> saw something on freenode:#selinux where he said there were 8000 lines of
> changes that needed to be reviewed and encorporated.

Maybe there's 8K lines of changes *total* - but the SELinux patches that Fedora
puts into the 'pam' RPM total all of....

%  rpm2cpio pam-0.79-8.src.rpm | cpio -itv | grep selin
12990 blocks
-rw-rw-r--   1 root     root        60083 Apr  5 03:40 pam-0.78-selinux.patch
-rw-rw-r--   1 root     root        10327 Sep  9  2004 pam-pwdbselinux.patch

Certainly not 8K lines in there. 2500 or so according to 'wc', and of that
a large chunk is adding a new PAM module.  Might be a long afternoon's work,
but probably not a "show stopper"

--==_Exmh_1117814928_3726P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCoICQcC3lWbTT17ARAiPkAKCiZGMY/TQiuB2geb6vK/DF1mHLxwCg0Oqg
Kj355dtODSr59/s7ZrQnqI0=
=9NLB
-----END PGP SIGNATURE-----

--==_Exmh_1117814928_3726P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
