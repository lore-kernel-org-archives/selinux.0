Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5E0pUrT015315
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 20:51:30 -0400 (EDT)
Received: from turing-police.cirt.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5E0pQkl004932
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 20:51:27 -0400 (EDT)
Message-Id: <200406140051.i5E0plBk003937@turing-police.cc.vt.edu>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: too many sysadmfile? 
In-Reply-To: Your message of "Fri, 11 Jun 2004 11:30:35 CDT."
             <1086971434.19414.148.camel@gorn.pebenito.net>
From: Valdis.Kletnieks@vt.edu
References: <1086884579.19414.30.camel@gorn.pebenito.net> <1086893852.4397.83.camel@moss-spartans.epoch.ncsc.mil>
            <1086971434.19414.148.camel@gorn.pebenito.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_369852368P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 13 Jun 2004 20:51:47 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_369852368P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <3927.1087174307.1@turing-police.cc.vt.edu>

On Fri, 11 Jun 2004 11:30:35 CDT, Chris PeBenito said:

> How does not being able to write to bin_t files, for example, break the
> existing usage?

"Existing usage" includes the idea that these "should work":

# dmesg > /tmp/foo

or

# vi /etc/hosts

I'm sure that you can come up with kajillions of similar examples of
things that Unixoid sysadmins have been expecting they can do with
just shell redirects, awk, grep, and a text editor, and been having them
actually work for the last 25 years.

That's a lot of inertia.... ;)

--==_Exmh_369852368P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAzPajcC3lWbTT17ARAnsVAJwOFZ/CioITyQpvZcp1n/Qfhc47IwCfVAOh
iAdQkzI+SwhmXEibOVfWViQ=
=JYf5
-----END PGP SIGNATURE-----

--==_Exmh_369852368P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
