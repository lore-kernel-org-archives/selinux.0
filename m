Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VDxJgA004626
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 09:59:19 -0400 (EDT)
Received: from h80ad25eb.async.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4VDr2pZ011064
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 13:53:03 GMT
Message-Id: <200505311353.j4VDrD4l027704@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: smaller memory footprint for 'strict' policy - helping gentoo as well 
In-Reply-To: Your message of "Tue, 31 May 2005 02:28:24 BST."
             <20050531012824.GI28006@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20050531012824.GI28006@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1117547592_3664P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 31 May 2005 09:53:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1117547592_3664P
Content-Type: text/plain; charset=us-ascii

On Tue, 31 May 2005 02:28:24 BST, Luke Kenneth Casson Leighton said:

> ... would the concept of a macros/unused directory help out, here?
> along with a list of the macros you removed (and the files
> they're in), valdis - and why.  and chris, also?

Almost all the gains I got were basically from moving stuff from
domains/programs/foo.te to domains/programs/unused/foo.te

> ... surely... there's some analysis done by the m4 macro
> compiler that automatically removes "unwanted" / "unused"
> macros?

The remaining gotcha is that some of the stuff in macros/program/foo_macros.te
could use some better ifdef wrapping, which I haven't looked into yet.

> could that be done as a separate pre-pass / analysis step,
> making it unnecessary to consider a macros/unused directory?

The current 'ifdef(foo.te)' keying off the presence of a foo.te in
domains/programs is a good and clear way to manage it.  Want a given
program's policy? Move it to domains/program.  Want to get rid of it?
Move to domains/program/unused.  Simple, clear, and not much of a maint
headache.

We just need to do some more ifdef'ing to make the resulting policy more
optimal.  There's no need for a macros/unused directory.


--==_Exmh_1117547592_3664P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCnGxIcC3lWbTT17ARAs7FAKDPwuVr76Y78d8Ft3mPgtaKOqPNsQCeM43Z
PCLul3yJqwb4O7prFcXtV14=
=OmcB
-----END PGP SIGNATURE-----

--==_Exmh_1117547592_3664P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
