Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6RLNgrT005877
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 17:23:42 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6RLNAmL014403
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 21:23:12 GMT
Message-Id: <200407272123.i6RLNcp9016219@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] multiple contexts. 
In-Reply-To: Your message of "Tue, 27 Jul 2004 22:28:36 BST."
             <20040727212836.GA21236@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20040724231154.GE3437@lkcl.net> <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil> <20040727160605.GG3392@lkcl.net> <200407271940.i6RJebSp032388@turing-police.cc.vt.edu>
            <20040727212836.GA21236@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1406971762P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 27 Jul 2004 17:23:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1406971762P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Jul 2004 22:28:36 BST, Luke Kenneth Casson Leighton said:

>  yes, sort-of: more that i only wish to limit what programs a user
>  can run (and what programs _those_ programs can run).
> 
>  in particular, i want to stop people from being able to use the
>  "Run" capability of Konqueror, etc.  STOP, not have the popup coming
>  up with "are you sure you want to run this program?".

Do these users have anything resembling shell access? If they can get an xterm
or an editor open, they can run the program *anyhow*....

Probably easier to do the kdeuser group and start chgrp'ing, than to try to fight THAT
war.

Or see how hard it would be to create a patch to Konqueror to disable the
button, and see if you can push it upstream...

--==_Exmh_-1406971762P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBBsfacC3lWbTT17ARAh/3AJ98wWQSbZSYQovAv88lcNiUwM7PkwCeMM5B
GaCxOUTOLV9KiS8DgvhTMfk=
=oAQ3
-----END PGP SIGNATURE-----

--==_Exmh_-1406971762P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
