Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1EN9lxg027932
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 18:09:47 -0500
Received: from penguin.goodinassociates.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1EN9jQo016997
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 23:09:45 GMT
Received: from [206.80.71.242] ([206.80.71.242])
	(authenticated bits=0)
	by penguin.goodinassociates.com (8.13.1/8.13.1) with ESMTP id m1F0ALak000732
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 14 Feb 2008 18:10:21 -0600
Subject: secadm question
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-f0WRn5e7XkRW0x4m6Whg"
Date: Thu, 14 Feb 2008 17:09:43 -0600
Message-Id: <1203030583.3669.197.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-f0WRn5e7XkRW0x4m6Whg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I see a number of places where the secadm_r role shows up, but It
doesn't show up in the list of users and what not, Is there something
simple I need to enable it, or 	do I need to build it from scratch? My
goal it to have sysadm not able to modify policy enforcement, and my
secadm not be able to do anything but. If there is a standard way to do
this, I'd love to know.

thanx,
-jj-



Things are more like they used to be than they are now.

--=-f0WRn5e7XkRW0x4m6Whg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHtMo36caZY8jbHDkRApDEAKDDgMAFhBu9FeFLOOxhLH6uwg8trwCgxoTh
/64RZqLNvBx68rqcCVT5qBQ=
=Iv/h
-----END PGP SIGNATURE-----

--=-f0WRn5e7XkRW0x4m6Whg--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
