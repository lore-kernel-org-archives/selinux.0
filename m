Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2VGPYRb022294
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 11:25:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2VGNdlU007327
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 16:23:40 GMT
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu [128.173.14.107])
	by jazzswing.ncsc.mil  with ESMTP id i2VGNbkj007319
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 16:23:39 GMT
Message-Id: <200403311625.i2VGPU5n010010@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: "lcvleo@ig.com.br" <lcvleo@ig.com.br>, selinux@tycho.nsa.gov
Subject: Re: Problems to compile the src.rpm packages on Red Hat Linux 9.0 
In-Reply-To: Your message of "Wed, 31 Mar 2004 08:22:04 EST."
             <1080739324.22514.4.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <1080685248.6780.5.camel@linux.linuxista.eti.br>
            <1080739324.22514.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1371443280P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 31 Mar 2004 11:25:30 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1371443280P
Content-Type: text/plain; charset=us-ascii

On Wed, 31 Mar 2004 08:22:04 EST, Stephen Smalley said:

> The SRPMS on the NSA web site are for Fedora Core 1, not RH9.  In any
> event, at this point, you are better off installing Fedora Core 2 test2
> if you want to experiment with Fedora and SELinux.  It already includes
> a SELinux-enabled kernel and applications.

Either I'm missing something, or the FC2 test2 RPMS still only speak
the policy.15 format, no sign of .16/.17 yet.  Can somebody enlighten
me as to whether

a) I'm dense and forgot to do <FOO>?
b) it's already in the Fedora pipe and should arrive shortly?
c) Punt and roll my own while I wait for the RPM to show up?

--==_Exmh_-1371443280P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAavD6cC3lWbTT17ARAm0uAJoCGJ/cH+8Vkwo7OORyPngIDbfxQACeJw9D
GY4yqQx5CbZsCzC+74FRZ0U=
=wkdL
-----END PGP SIGNATURE-----

--==_Exmh_-1371443280P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
