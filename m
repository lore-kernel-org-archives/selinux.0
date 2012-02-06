Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q164Qear026529
	for <selinux@tycho.nsa.gov>; Sun, 5 Feb 2012 23:26:40 -0500
Received: from smtp.colliertech.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q164QY7Z026954
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2012 04:26:34 GMT
Received: from calcifer ([172.16.9.40])
	by smtp.colliertech.org with esmtp (Exim 4.72)
	(envelope-from <cjac@colliertech.org>)
	id 1RuG9l-0002Di-Ee
	for selinux@tycho.nsa.gov; Sun, 05 Feb 2012 20:26:33 -0800
From: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
Reply-To: cjac@colliertech.org
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-96+jpMZPJZYb/LrN+rJg"
Date: Sun, 05 Feb 2012 20:26:47 -0800
Message-ID: <1328502407.14110.7074.camel@calcifer>
Mime-Version: 1.0
Subject: SELinux on Wheezy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-96+jpMZPJZYb/LrN+rJg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey folks,

I brought up a wheezy install on an alternate lvm root a couple of weeks
ago.  I turned SELinux on shortly thereafter.  I think I updated my
kernel, and now X won't start.  Could someone look at these logs with me
and help figure out what's going on?  Something showed up during boot
that said something about updating labels, but I didn't capture it.
Where should I look to find these boot logs, do you think?

http://www.colliertech.org/federal/nsa/selinux-20120205T2023PST.log

Thank you in advance!

C.J.



--=-96+jpMZPJZYb/LrN+rJg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAABAgAGBQJPL1Z/AAoJEEyimPmPQm233x0H/2HAnP8SrLHAgECNw8qdKHJj
Zx6mL33YySXVS6e4ON0/aGrVZEiuW7bLzgTjYhposFemwQNgmXkNl/xASu4LTqW8
+t6UlchfgS4ZYEqhUPp2GZgucDED2kTVwjol6Wmd5V0/GahCXxHLV+lNGnsQdOTN
Xw9v/008BxMNOIrJL/yCodfvFAwArmpJl+O0adN4FqMY66/ZT8e4vkZyNLnWYLxf
byYOnl3S6dC7j7lhU122eOJo+X+w9/5BAbD6GW+GNy1U/6EhONCTdBTqz4cKJKy+
DNJWsKsLmtRe9mK/YrdFVxPFrvGGT/a/g51kOoGMdLRmR9aVP3EAWpcBVQbcBRI=
=y23r
-----END PGP SIGNATURE-----

--=-96+jpMZPJZYb/LrN+rJg--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
