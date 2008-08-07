Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77EB8bC013353
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:11:08 -0400
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m77EAxjg018925
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:11:00 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Problem with MLS because /dev is labeled tmpfs_t
Date: Thu, 7 Aug 2008 22:10:54 +0800
References: <20080804123456.679565839@hardeman.nu> <20080804123737.588838945@hardeman.nu> <1218116958.5345.20.camel@gorn.columbia.tresys.com>
In-Reply-To: <1218116958.5345.20.camel@gorn.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2910490.H8xGZYJfvj";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200808072211.00709.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart2910490.H8xGZYJfvj
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

After already receiving some help with my newrole-problem I have run into t=
he=20
next problem.
It does not appear when I compile the policy as standard-policy, but I run=
=20
into it when I build a MLS-policy.

The problem I have is that device-mapper throws some security transition-er=
ror=20
(which btw. does not appear in audit2allow, but only shows during boot and =
in=20
dmesg). The reason for that is, as I believe, that my /dev is labeled as=20
tmpfs_t, which is not the right label.

Manually relabeling it doesn't help, on the next reboot, when udev starts i=
ts=20
magic, it gets turned into tmpfs_t again.

This problem of course prevents me to boot into enforcing-mode when using M=
LS.

Does anybody know where this problem is? Is it udev? I already compiled it=
=20
with SELinux-support, but /dev is always tmpfs_t.
As said, I suspect udev here, but of course I might be wrong.

--nextPart2910490.H8xGZYJfvj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkibAnQACgkQ1sXw8/2VziQFKQCgmIMDGtrplktDiZqb0Duu6s7v
KQ4AnjyQRKVR7AuNt692yH71aI7P9Upp
=to1L
-----END PGP SIGNATURE-----

--nextPart2910490.H8xGZYJfvj--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
