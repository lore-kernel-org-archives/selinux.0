Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAJIeQIi022671
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 13:40:26 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAJIeSlF014191
	for <selinux@tycho.nsa.gov>; Fri, 19 Nov 2004 18:40:29 GMT
Message-Id: <200411191838.iAJIcB3E006019@turing-police.cc.vt.edu>
To: Colin Walters <walters@verbum.org>
Cc: Greg Norris <haphazard@kc.rr.com>, SE-Linux <selinux@tycho.nsa.gov>,
   sds@epoch.ncsc.mil, jwcart2@epoch.ncsc.mil
Subject: Re: using procmail under SE-Linux 
In-Reply-To: Your message of "Thu, 18 Nov 2004 23:06:54 EST."
             <1100837214.23707.15.camel@nexus.verbum.private>
From: Valdis.Kletnieks@vt.edu
References: <20041119013811.GA21001@yggdrasil.localdomain>
            <1100837214.23707.15.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_747291093P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 19 Nov 2004 13:38:11 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_747291093P
Content-Type: text/plain; charset=us-ascii

On Thu, 18 Nov 2004 23:06:54 EST, Colin Walters said:

> type_transition postfix_local_t user_home_dir_t:dir user_procmail_t.
> 
> So procmail would compute the domain to use like this, in pseudocode:
> 
> newcon = security_compute_relabel (getcon (),
>                                    getfilecon (getpwent (getuid ())->pw_dir))
> setexeccon(newcon)

This would apply only to things that procmail exec'ed, and not to any
file access/etc done by procmail itself, correct? (i.e. this would fix
a call to mh's "rcvstore", but not a misuse of 'LOG=' in the procmailrc)...

--==_Exmh_747291093P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBnj2TcC3lWbTT17ARAj+xAKCEOT/HRIHO1WpL4VqKlR4QYRiHYQCg1ESU
h/oqLtpUV3dcROdhnBi/HSI=
=krdA
-----END PGP SIGNATURE-----

--==_Exmh_747291093P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
