Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43IuoRb007791
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 14:56:50 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i43IumYW027918
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 18:56:48 GMT
Received: from turing-police.cirt.vt.edu (turing-police.cirt.vt.edu [128.173.54.129])
        by jazzband.ncsc.mil  with ESMTP id i43IulBf027915 for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 18:56:48 GMT
Message-Id: <200405031856.i43IubTV003432@turing-police.cc.vt.edu>
To: "Milan P. Stanic" <mps@rns-nis.co.yu>
Cc: selinux@tycho.nsa.gov
Subject: Re: Tinydns Policy Files 
In-Reply-To: Your message of "Mon, 03 May 2004 16:30:23 +0200."
             <20040503143023.GB2163@rns-nis.co.yu>
From: Valdis.Kletnieks@vt.edu
References: <200405032042.48931.russell@coker.com.au> <4549.68.6.187.64.1083587612.squirrel@mxlx1.surveysavvy.com>
            <20040503143023.GB2163@rns-nis.co.yu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1393139916P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 03 May 2004 14:56:37 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1393139916P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 May 2004 16:30:23 +0200, "Milan P. Stanic" <mps@rns-nis.co.yu>  said:

> > Dan recommends that daemontools be installed into "/package".  After some
> > dissection this appears to mostly be because the daemontools service
> > manager is launched from the inittab, and some pain can be caused by not
> > having the binaries for it on the root filesystem.  I have at times
> > installed daemontools in other places.  Other locations work fine, however
> > filesystem repair tends to be annoying. <I can provide details if anybody
> > cares...>
> 
> I'd like hear why repair "tends to be annoying"?

I think he means all the many variants on "the tool you need to get /usr restored
was installed in /usr/sbin rather than /sbin"... :)

RedHat/Fedora had a similar whoops in the LVM package - it got linked against
libreadline.so, which was in /usr/lib.  Loads of fun if your /usr is on an LVM partition
and you need to run /sbin/lvm first to get it mounted....

--==_Exmh_1393139916P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAlpXkcC3lWbTT17ARAkJzAKDe3hGgbvZek5QB1W8wsNRb/6mAUQCgxpYO
jqwoTz+bTHx3ni2GR/hH5n0=
=ovFE
-----END PGP SIGNATURE-----

--==_Exmh_1393139916P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
