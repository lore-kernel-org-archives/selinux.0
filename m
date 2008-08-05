Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75DtPa0011392
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 09:55:26 -0400
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m75DtOSF012226
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 13:55:25 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Question about newrole
Date: Tue, 5 Aug 2008 21:55:14 +0800
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4063004.B3sK4MVpiq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200808052155.18105.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart4063004.B3sK4MVpiq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,

I'd like to ask about a problem I am experiencing with newrole.
When I use newrole in permissive-mode I have no problems changing the role.=
=20
Also I don't get any audit-messages.
But when I switch to enforcing-mode I cannot use newrole, it keeps telling=
=20
me "incorrect password for root", although it clearly is correct.
I suspect a problem in interaction between newrole and unix_chkpwd, but am =
not=20
entirely sure about it.

Problem is that I don't get any audits from SELinux, only errors in auth.lo=
g=20
from unix_chkpwd:
check_pass; user unknown
password check failer for user (root)

I am working with the latest reference-policy, adjusted here and there to f=
it=20
the needs of my distro.

Thanks for any suggestions.

Dennis

--nextPart4063004.B3sK4MVpiq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiYW8YACgkQ1sXw8/2VziQmXQCeNWDpNg+vkGtZnJpg40QDqGE2
qrAAoK3a7c6c0L59Rof+ImIH/KSxKPHc
=mftY
-----END PGP SIGNATURE-----

--nextPart4063004.B3sK4MVpiq--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
