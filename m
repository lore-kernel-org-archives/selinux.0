Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6RJeerT005177
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 15:40:40 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6RJe7mL009038
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 19:40:10 GMT
Message-Id: <200407271940.i6RJebSp032388@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] multiple contexts. 
In-Reply-To: Your message of "Tue, 27 Jul 2004 17:06:06 BST."
             <20040727160605.GG3392@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20040724231154.GE3437@lkcl.net> <1090858323.24945.116.camel@moss-spartans.epoch.ncsc.mil>
            <20040727160605.GG3392@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1712670068P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 27 Jul 2004 15:40:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1712670068P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Jul 2004 17:06:06 BST, Luke Kenneth Casson Leighton said:

>  i also seek to limit the programs that a KDE user may run.
> 
>  if there is a simple way to do that which does not involve writing
>  policy files for each and every single KDE program i intend to restrict
>  users to use, i would be interested to hear it.

Are there KDE programs that don't require anything but user permissions, but
that you want to restrict anyhow?

Or are all the programs to be limited already require more permission?

Or are you trying to secure a kiosk?

The answers will probably depend on what problem you're trying to solve?

--==_Exmh_-1712670068P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBBq+0cC3lWbTT17ARAsb2AKCnkThOy4eRxmGG8PdC4+Abzan4dACfSdfX
3qSXpcldWMhwN16cLmevDd0=
=lGK/
-----END PGP SIGNATURE-----

--==_Exmh_-1712670068P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
