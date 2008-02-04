Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m14J2bpP001299
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 14:02:37 -0500
Received: from penguin.goodinassociates.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m14J2ag3014552
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 19:02:36 GMT
Received: from [206.80.71.242] ([206.80.71.242])
	(authenticated bits=0)
	by penguin.goodinassociates.com (8.13.1/8.13.1) with ESMTP id m14J2FC5028680
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Mon, 4 Feb 2008 13:02:15 -0600
Subject: su problems again
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3AJ6pJ9VnS8S96Qt65F9"
Date: Mon, 04 Feb 2008 13:02:13 -0600
Message-Id: <1202151733.2801.116.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-3AJ6pJ9VnS8S96Qt65F9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Is there some way to turn of the dontaudit  w/ the refpolicy and a
module policy build. make enableaudit seems to only change the base
policy, and not any of the policies that actually do anything.=20

This is with the refpolicy selinux-refpolicy-sources-20071214-1 running
on RHEL5.=20

For some reason, when the policy is enforced, I can't su  from a staff_r
user, yet when I try with enforcing=3D0 I don't get any audit messages,
and I'm not really comfortable modifying every user oriented admin
modules to remove the dontaudit rules. doing so in su.te helped find a
few things, but I'm not sure what's blocking it now.=20



Sodd's Second Law: Sooner or later, the worst possible set of
circumstances is bound to occur.

--=-3AJ6pJ9VnS8S96Qt65F9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHp2E16caZY8jbHDkRAtJWAKCEaXwoR3P20eVI/E44Q3vCEwMrpACgr5mb
kdlFNJBxknZCvIDDyRSqCiI=
=T6TN
-----END PGP SIGNATURE-----

--=-3AJ6pJ9VnS8S96Qt65F9--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
