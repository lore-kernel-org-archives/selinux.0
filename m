Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1J3iXZ029229
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 14:03:45 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1J3fGG003429
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 19:03:44 GMT
Message-Id: <200411011903.iA1J3djT009295@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: patch: add assert statement for syslog 
In-Reply-To: Your message of "Mon, 01 Nov 2004 13:14:05 EST."
             <1099332844.21386.170.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <20041101102345.GA3377@jmh.mhn.de> <200411011745.iA1HjGZ0004102@turing-police.cc.vt.edu>
            <1099332844.21386.170.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1048839258P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 01 Nov 2004 14:03:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1048839258P
Content-Type: text/plain; charset=us-ascii

On Mon, 01 Nov 2004 13:14:05 EST, Stephen Smalley said:

> The patch merely adds an assertion to verify what should already be true
> in the policy, i.e. that every domain authorized to write to the
> /dev/log socket has the privlog attribute.

Pass me the caffeine, will ya? ;)

For some reason, I was convinced that macros/user-macros.te had a
ifdef that lopped out the privlog stuff - in fact, it sticks a
'dontaudit' on it.




--==_Exmh_1048839258P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBhoiGcC3lWbTT17ARAjrjAKDK07P6LhoDLVpO1pMWnGy7Hzch7wCfcR/j
lDz4v2n1GAb1t8nduE5PpaQ=
=GzW7
-----END PGP SIGNATURE-----

--==_Exmh_1048839258P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
