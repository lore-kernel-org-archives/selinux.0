Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7OIlorT029689
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 14:47:50 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7OIlhCX015024
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 18:47:49 GMT
Message-Id: <200408241847.i7OIlgRp001380@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Joshua Brindle <jbrindle@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: constraints and subtraction 
In-Reply-To: Your message of "Tue, 24 Aug 2004 09:54:43 EDT."
             <1093355682.1800.111.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <412A5BD0.8050606@tresys.com>
            <1093355682.1800.111.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2038982184P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 24 Aug 2004 14:47:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-2038982184P
Content-Type: text/plain; charset=us-ascii

On Tue, 24 Aug 2004 09:54:43 EDT, Stephen Smalley said:
> On Mon, 2004-08-23 at 17:04, Joshua Brindle wrote:
> > I was wondering if there was a specific reason that constraints don't 
> > support subtraction but support attributes, sets, * and ~. For example 
> > the following might be useful:
> > 
> > constrain dir_file_class_set { create relabelto relabelfrom }
> >          ( u1 == u2 or t1 == { privowner -sysadm_t } );
> 
> Laziness and fear ;)  Feel free to change it, but it may be more
> complicated than you expect.

Oh yes, fear.. ;)

Attributes and sets are easy, * and ~ have reasonable definitions as well...

Given two sets F1 = {A, B, C} and F2 = {B, D}, it's unclear to me
what The Right Thing to do for (F1-F2) is.  Should the attempt to subtract
D throw an error, or fail silently and create {A, C}, or create the set {A, C, ~D}?

I can make a case for any one of the three.  I'll even hypothesize that none of
the 3 is clearly correct unless the reasons for both other alternatives being wrong
are clear-cut enough even for an idiot like me to understand....

Anybody got a 4th alternative? :)

--==_Exmh_-2038982184P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBK41NcC3lWbTT17ARAluCAKD+kC6mG0X6z8iAtJRHf0kbEJ9QhACeNmdE
CPu83fZQfQXW6CFnUXTeX0E=
=x3Zo
-----END PGP SIGNATURE-----

--==_Exmh_-2038982184P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
