Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91ITArT003682
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 14:29:10 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i91ISuEb010363
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 18:29:08 GMT
Message-Id: <200410011828.i91ISrN6018074@turing-police.cc.vt.edu>
To: jwcart2@epoch.ncsc.mil
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Patch to restorecon to add -R switch 
In-Reply-To: Your message of "Wed, 29 Sep 2004 15:08:40 EDT."
             <1096484920.3270.13.camel@moss-lions.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <41584DCA.7030006@redhat.com>
            <1096484920.3270.13.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1949317072P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 01 Oct 2004 14:28:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1949317072P
Content-Type: text/plain; charset=us-ascii

On Wed, 29 Sep 2004 15:08:40 EDT, James Carter said:
> Everything looks fine, but why does all the output just go to the log
> file now?  

> > -	rpm -q -l $i | restorecon ${OUTFILES} -n -v -f - 2>&1 | tee $LOGFILE
> > +	rpm -q -l $i | restorecon ${OUTFILES} -n -v -f - 2>&1 > $LOGFILE

That (and a few other places '| tee' was removed) is the technical reason
why it goes to the logfile only.  Dan would have to address the logic behind why
the change was made.

--==_Exmh_1949317072P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBXaHkcC3lWbTT17ARAtUqAKDAKXTN7sEGRJXkwSi3M+bju/sykQCgqex7
YlyeS+mVJz6HZdr3dVJBgFc=
=bel9
-----END PGP SIGNATURE-----

--==_Exmh_1949317072P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
