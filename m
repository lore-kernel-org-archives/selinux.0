Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91JhOrT004348
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 15:43:24 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i91JhGEb013041
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 19:43:23 GMT
Message-Id: <200410011943.i91JhEUH001486@turing-police.cc.vt.edu>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patch to restorecon to add -R switch 
In-Reply-To: Your message of "Fri, 01 Oct 2004 15:00:17 EDT."
             <415DA941.4050500@redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <41584DCA.7030006@redhat.com> <1096484920.3270.13.camel@moss-lions.epoch.ncsc.mil> <200410011828.i91ISrN6018074@turing-police.cc.vt.edu>
            <415DA941.4050500@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2098080852P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 01 Oct 2004 15:43:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_2098080852P
Content-Type: text/plain; charset=us-ascii

On Fri, 01 Oct 2004 15:00:17 EDT, Daniel J Walsh said:

> It was changed because the the messages were flooding the roots mailer 
> and if you ran fixfiles by hand, it would slow down the process
> if you were on a slow terminal.  You can still see the output by doing a 
> fixfiles -l `tty`

Hmm.. what does `tty` do inside a cron job?  That might matter to some people...

--==_Exmh_2098080852P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBXbNRcC3lWbTT17ARAkVaAJ4ja9ntjK1glOfZUnoVUjvUEul6AwCeNt0H
Lfr8wNRNhbeFvEPgck1YvkA=
=zeNa
-----END PGP SIGNATURE-----

--==_Exmh_2098080852P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
