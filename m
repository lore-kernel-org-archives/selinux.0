Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2VIOvRb023294
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 13:24:57 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2VIOtOl026016
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 18:24:55 GMT
Received: from turing-police.cirt.vt.edu (turing-police.cirt.vt.edu [128.173.54.129])
        by jazzband.ncsc.mil  with ESMTP id i2VIOqkJ025988 for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 18:24:55 GMT
Message-Id: <200403311824.i2VIOqrF004360@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: "lcvleo@ig.com.br" <lcvleo@ig.com.br>, selinux@tycho.nsa.gov
Subject: Re: Problems to compile the src.rpm packages on Red Hat Linux 9.0 
In-Reply-To: Your message of "Wed, 31 Mar 2004 12:49:42 EST."
             <1080755381.22514.85.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <1080685248.6780.5.camel@linux.linuxista.eti.br> <1080739324.22514.4.camel@moss-spartans.epoch.ncsc.mil> <200403311625.i2VGPU5n010010@turing-police.cc.vt.edu>
            <1080755381.22514.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1004434241P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 31 Mar 2004 13:24:52 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1004434241P
Content-Type: text/plain; charset=us-ascii

On Wed, 31 Mar 2004 12:49:42 EST, Stephen Smalley said:

> update your kernel, then you should be able to comment out the

Already at 2.6.5-rc2-mm5, and 2.6.5-rc3-mm2 is building in another window,
hopefully recent enough. ;)

> POLICYCOMPAT definition in the policy Makefile and build and use
> policy.16.

POLICYCOMPAT.  Damn, how come I didn't see that? :)   Thanks...

--==_Exmh_1004434241P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAawzzcC3lWbTT17ARAsELAJ9tulv/45NgKbB5xERZ5QKTPXhEsACeNv85
aXXiJtFPZSLhO980yrXN9vg=
=EQi5
-----END PGP SIGNATURE-----

--==_Exmh_1004434241P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
