Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k55IQd0D004760
	for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2006 14:26:39 -0400
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k55IQbGm028690
	for <selinux@tycho.nsa.gov>; Mon, 5 Jun 2006 18:26:37 GMT
Received: from localhost.localdomain (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with ESMTP id 05FE6B0E8A
	for <selinux@tycho.nsa.gov>; Mon,  5 Jun 2006 19:26:26 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mail.nagafix.co.uk (Postfix) with SMTP id 1B2F3B0E8C
	for <selinux@tycho.nsa.gov>; Mon,  5 Jun 2006 19:26:19 +0100 (BST)
Subject: Re: why I have /selinux??
From: Antoine Martin <antoine@nagafix.co.uk>
To: Mario Fanelli <mario.fanelli@gmail.com>
Cc: SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <44844b0e.1953fca1.1083.ffffce13@mx.gmail.com>
References: <44844b0e.1953fca1.1083.ffffce13@mx.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PFoL47toIgrLjgpSHxEr"
Date: Mon, 05 Jun 2006 19:32:34 +0100
Message-Id: <1149532354.10653.3.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-PFoL47toIgrLjgpSHxEr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-06-05 at 17:17 +0200, Mario Fanelli wrote:
> I don't understand why I have selinuxfs mounted on /selinux, but in
> /etc/fstab I don't find any entry that concern that...
> Why?
Because it is mounted automagically by your distribution very early on
in the boot.

--=-PFoL47toIgrLjgpSHxEr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEhHjCrTBrLRG7eDcRAv70AJ9FedG1jeThP/e88sLEABpPxJKGAQCffZMp
x09vfJUvLv6WU39FJx7y4OI=
=W+8Q
-----END PGP SIGNATURE-----

--=-PFoL47toIgrLjgpSHxEr--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
