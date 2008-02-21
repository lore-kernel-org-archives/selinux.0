Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1LLMoIM010670
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2008 16:22:50 -0500
Received: from penguin.goodinassociates.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1LLMmI8020111
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2008 21:22:48 GMT
Received: from [206.80.71.242] ([206.80.71.242])
	(authenticated bits=0)
	by penguin.goodinassociates.com (8.13.1/8.13.1) with ESMTP id m1LLMlM1016636
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 21 Feb 2008 15:22:47 -0600
Subject: ps aux output under sysadm context in refpolicy
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9bnIpU8EX8eReFhafWTf"
Date: Thu, 21 Feb 2008 15:22:46 -0600
Message-Id: <1203628966.3669.820.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-9bnIpU8EX8eReFhafWTf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm having a heck of a time limiting the ps aux output to show only what
I think sysadm should be able to see.

I have a number of types that are running and I get a ptrace denied, but
sysadm can still see the process. I'm really not sure why this is the
case. I've set all the build options correctly, ie left the defaults,
the booleans are set to no. Somewhere there is something going on that
lets sysadm see all of this stuff, and I just can't find it.

According to apol there is not way for me to read the proc files as
sysadm. What Am I missing, or where should I look.

thanx,
-jj-



He thought he saw an albatross That fluttered 'round the lamp. He looked
again and saw it was A penny postage stamp. "You'd best be getting
home," he said, "The nights are rather damp."

--=-9bnIpU8EX8eReFhafWTf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHveum6caZY8jbHDkRAhZqAKCVDhz7hLFnwmRGch6oNFHqooyOxwCgh8sz
9MIJRv4ahnbKi2DAbYFm69o=
=hB5w
-----END PGP SIGNATURE-----

--=-9bnIpU8EX8eReFhafWTf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
