Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB8IjkIi007076
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 13:45:46 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB8Ijmu3028846
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 18:45:48 GMT
Message-Id: <200412080203.iB823Mhd023488@turing-police.cc.vt.edu>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Yee-HAH! 'smartd' issues 70 avc's when it tries to send mail... 
In-Reply-To: Your message of "Tue, 07 Dec 2004 11:50:27 EST."
             <200412071650.iB7GoSQs014629@turing-police.cc.vt.edu>
From: Valdis.Kletnieks@vt.edu
References: <200412032012.iB3KCjaT030175@turing-police.cc.vt.edu> <41B5CB46.4020407@redhat.com>
            <200412071650.iB7GoSQs014629@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_639221094P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 07 Dec 2004 21:03:22 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_639221094P
Content-Type: text/plain; charset=us-ascii

On Tue, 07 Dec 2004 11:50:27 EST, Valdis.Kletnieks@vt.edu said:

> I'm wondering if it would make more sense to push a patch upstream to the
> kernel-utils crew.  Reading the smartd manpage in more detail, it looks like
> feeding it a '-M exec /usr/sbin/sendmail' (or building with that as the
> default) would let us only have to add sendmail_exec_t rather than all those.

Or that *would* work, if the smartd code didn't use popen() to actually run it,
giving us a gratuitous '/bin/sh -c'.  Looks like some fairly hefty reworking to
make it do the whole pipe()/fork()/exec() thing itself.

Blech. ;)


--==_Exmh_639221094P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBtmDqcC3lWbTT17ARAr4RAKCpmoKl7+F4EZcKBuxsi+kNO06EigCghHnN
IwTnVCmRbelw5qz8zDjj2sI=
=9I4Z
-----END PGP SIGNATURE-----

--==_Exmh_639221094P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
