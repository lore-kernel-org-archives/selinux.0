Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i58FCmrT012818
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 11:12:49 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i58FCjIl019179
	for <selinux@tycho.nsa.gov>; Tue, 8 Jun 2004 11:12:45 -0400 (EDT)
Message-Id: <200406081512.i58FCs1D014004@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dpkg fails on installing nvidia-glx because /etc/init.d/nvidia-glx start is run 
In-Reply-To: Your message of "Tue, 08 Jun 2004 08:36:06 -0000."
             <20040608083606.GN3305@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20040607231556.GI3305@lkcl.net> <200406080212.i582C1uG013226@turing-police.cc.vt.edu>
            <20040608083606.GN3305@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1915655216P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 08 Jun 2004 11:12:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1915655216P
Content-Type: text/plain; charset=us-ascii

On Tue, 08 Jun 2004 08:36:06 -0000, Luke Kenneth Casson Leighton said:

>  btw during the install i got "cannot create symbolic link
>  /usr/X11/lib/ libglx-something to /usr/lib/nvidia-something".

That's a different problem - you weren't allowed to create a symlink
in the /usr/X11R6/lib directory for some reason.  Unfortunately,
it's probably going to be impossible to debug it without seeing the
exact error message...

>  ... why aren't these files _created_ with the correct permissions?

There's many potential reasons, most of which boil down to some variant
of "You weren't allowed to, or the tool didn't know how to".  I'd have to
double-check what the nvidia installer does, and what the 'make install'
does, to see what command actually gets invoked to put the *.so into place.
And then there's the question of what context you were in at the time - under
SELinux, it's possible to su to UID 0 and *not* be in role sysadm_r (which
has almost all permissions), or to su to a non-zero UID and still be in sysadm_r.



--==_Exmh_-1915655216P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAxdd2cC3lWbTT17ARAo/WAKChudsyEbTB2jhRQHwcfFWNmmfDrACfekgJ
vaOfB72Recg91mPSlYgqC3M=
=EiEK
-----END PGP SIGNATURE-----

--==_Exmh_-1915655216P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
