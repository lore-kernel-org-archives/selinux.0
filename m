Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r2EKAWVw000826
	for <selinux@tycho.nsa.gov>; Thu, 14 Mar 2013 16:10:32 -0400
Received: from [IPv6:2001:470:e1cc:3:6c39:92ff:fe2d:53a0] (unknown [IPv6:2001:470:e1cc:3:6c39:92ff:fe2d:53a0])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mthode.org (Postfix) with ESMTPSA id A0CB7ADF0
	for <selinux@tycho.nsa.gov>; Thu, 14 Mar 2013 16:10:36 -0400 (EDT)
Message-ID: <51422EB6.7000807@mthode.org>
Date: Thu, 14 Mar 2013 15:10:30 -0500
From: Matthew Thode <mthode@mthode.org>
Reply-To: mthode@mthode.org
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: semanage support for nsswitch
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2CRKRXUSNNRTUWWFALSES"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2CRKRXUSNNRTUWWFALSES
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I've noticed that semanage does not support nsswitch, is there a reason
for this or am I somehow blind?

--=20
-- Matthew Thode


------enig2CRKRXUSNNRTUWWFALSES
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQi7CAAoJECRx6z5ArFrDJoIQANHhHyCgdjvHRTMI9ApGgD6l
Quhu5Djmi/oA0AOPZQMpj9yrWUFWl05sVdZwHFK9hAZcrFTx+sQExBzYg0ECh0Gi
ZNvIKBBGPjTxXbTb+60f4fSBcMv03crsO/CRdhbi0R8cFeyO73egCIv5qw3OqTl3
9Vdmii/O+8O9cWrrMqbNSTr6dveIlRa4vtBLwQ7+T+RZHPVkPnR8WFsEC0fE/M6p
viynBD0sN8DDA4IBoNDfN8CGcAVPZ1t32of8S0HPM9fTafqYok0pEPqBvQacVdoc
oYBHTMRuA2sVcy6Hl8dncU6XoqD/KWE6YCp7NPySQG/aD9VktoZ/wr/9vTsA2W5p
hVozcxD5NZrsYmCv4oPocQvmr5sPGjqI8xdKIjIrFZVLsEabmy2VqN/RkY1Ii3Yn
eb/l4ANCMLTm0NW6Ja1gNhcrTqiPALM+iuPBiQiMp3VbVeVBMC0HwXpv33UmVJIA
UrgG3ZG/Tb8TV09MEfzd0p0g0XLC9sRo4uRhGn+6PcRLsIZzq8lWSjKdNrLHU3Pr
YkSgKFIEf6cajC6aaQi2becjtUiBMpi14u61IRLs+CRJ9kQC1VVOhFBKkAupx9yV
CNXWA72mv8X2Pixys//LHJeBlePqkgg2mReMz/wSnubhOZzPSCRfxwPhACjHNH0Z
bpIEHUcJGK37wx/MRhbR
=s2KF
-----END PGP SIGNATURE-----

------enig2CRKRXUSNNRTUWWFALSES--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
