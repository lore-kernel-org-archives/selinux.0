Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i582C0rT009191
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 22:12:00 -0400 (EDT)
Received: from turing-police.cirt.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i582Bt22028953
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 22:11:55 -0400 (EDT)
Message-Id: <200406080212.i582C1uG013226@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dpkg fails on installing nvidia-glx because /etc/init.d/nvidia-glx start is run 
In-Reply-To: Your message of "Mon, 07 Jun 2004 23:15:56 -0000."
             <20040607231556.GI3305@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20040607231556.GI3305@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-765810165P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 07 Jun 2004 22:12:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-765810165P
Content-Type: text/plain; charset=us-ascii

On Mon, 07 Jun 2004 23:15:56 -0000, Luke Kenneth Casson Leighton <lkcl@lkcl.net>  said:
> hiya (russell?)
> 
> i just installed the nvidia-glx package (don't ask :)

> i need to write an nvidia-glx policy, don't i?

Not necessarily.  At least under Fedora, all the NVidia stuff ends up
labelled correctly by the contents of file_contexts/program/xserver.fc
(All the /usr/lib *.so's  end up as shlib_t, and the /dev/nvidia.* end
up as xserver_misc_device_t, and you're ready to rock-n-roll...)

You may just need to cd to /etc/<selinux-path> and do a 'make relabel'.


--==_Exmh_-765810165P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAxSBxcC3lWbTT17ARAoxMAKCdhN96acH9KJKHEUDRdxXBhxtJWACgjRHE
BLVyT8y8JezRVEQ/iAsPrj0=
=QFwI
-----END PGP SIGNATURE-----

--==_Exmh_-765810165P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
