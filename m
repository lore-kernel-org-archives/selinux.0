Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TKxMrT022636
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 16:59:22 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TKwpbB019820
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 20:58:51 GMT
Message-Id: <200407292059.i6TKxGFL019918@turing-police.cc.vt.edu>
To: James Morris <jmorris@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux 
In-Reply-To: Your message of "Thu, 29 Jul 2004 13:06:15 EDT."
             <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1119865848P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 29 Jul 2004 16:59:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1119865848P
Content-Type: text/plain; charset=us-ascii

On Thu, 29 Jul 2004 13:06:15 EDT, James Morris said:
 
> This could be done by simply allowing context= to override any other 
> behavior, right?

Well, with proper control over what roles/etc can use that mount option.
(Think "/dev/cdrom auto-mounted as 'user' by a system daemon"...)

--==_Exmh_1119865848P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBCWUjcC3lWbTT17ARAhKmAJ9cvSk146xBpKHL24sCeliwT9flLgCePxIz
1FPzzvDeay9L4B/MtHxhZ8A=
=bfE+
-----END PGP SIGNATURE-----

--==_Exmh_1119865848P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
