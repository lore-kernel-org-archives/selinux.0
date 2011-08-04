Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p74CEJLj013962
	for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2011 08:14:19 -0400
Received: from mail.cendio.se (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p74CEIeW015510
	for <selinux@tycho.nsa.gov>; Thu, 4 Aug 2011 12:14:19 GMT
Received: from [10.47.3.200] (dmz-gw.cendio.se [193.12.253.97])
	by mail.cendio.se (Postfix) with ESMTP id E262F138174
	for <selinux@tycho.nsa.gov>; Thu,  4 Aug 2011 14:14:17 +0200 (CEST)
Message-ID: <4E3A8D16.7060807@cendio.se>
Date: Thu, 04 Aug 2011 14:14:14 +0200
From: Aaron Sowry <aaron@cendio.se>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: SELinux policy regarding LD_LIBRARY_PATH
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8134809B8D708A5C713F7533"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8134809B8D708A5C713F7533
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

It appears that with SELinux enabled, the LD_LIBRARY_PATH environment
variable is not inherited by user processes forked by a root process.
This is on RHEL6.

What is the general SELinux policy regarding LD_LIBRARY_PATH? Is there
any way to change this behaviour? I couldn't find any documentation
regarding this.

Thanks,
Aaron


--------------enig8134809B8D708A5C713F7533
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOOo0ZAAoJECw8YUUfeQL9oXwIAKzMwV1PQ0nHPAP/mh0UGjYM
Ro6W3CyZWldFR42PV1nxLHRTA8g2o0eKE64/zkR+FXD1yx8y6RgGnFKs5TLYTqV6
ypQXr4iwuwDRMTxzzh+W6bv6mAkQSSqIE5wxVdRNTVJxdoilrHl7YL7iMdT1K3jl
13Jw7DNVIQY/Idhvx7+P2TXgPBTEhPct/W39JAU524fHG7NmdkHUVXl+6rVMdrJT
gl/X2p/iuxn6Wyjf5p03YA0E1t+Ib5ehmAmwOIqfE6qOVzodIkPNpLnIiwm3hZne
hoPWWn+fhzzpa+d0ukeVEHsQ7O7G6ctHo+R29KSPKtyIH1Yfi8w7zlMwgxupCwk=
=+pZl
-----END PGP SIGNATURE-----

--------------enig8134809B8D708A5C713F7533--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
