Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9THTT8I024773
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2013 13:29:29 -0400
Received: from [10.0.3.42] (unknown [10.0.3.42])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mthode.org (Postfix) with ESMTPSA id E4FB811F97
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2013 13:31:31 -0400 (EDT)
Message-ID: <526FF06D.5070904@mthode.org>
Date: Tue, 29 Oct 2013 12:29:17 -0500
From: Matthew Thode <mthode@mthode.org>
Reply-To: mthode@mthode.org
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: rlpkg -a -r causes a kernel bug
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ipdlklUpMX3Prm52FVVa2e29robltF62U"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ipdlklUpMX3Prm52FVVa2e29robltF62U
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This occurs when running on ZFS.  Please refer to the following bug for
more info.

https://bugs.gentoo.org/show_bug.cgi?id=3D489598

(here is the kernel log (for two instances of hitting the bug))
https://489598.bugs.gentoo.org/attachment.cgi?id=3D362062

--=20
-- Matthew Thode


--ipdlklUpMX3Prm52FVVa2e29robltF62U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSb/B0AAoJECRx6z5ArFrDWCkP/1zQAskFH1ta7uZq4MRj+UIC
Xfp5qre5ik+TtZ59Xv0RRHdOMBnskWPmdo3mcrzMRjj4Nedt21uswWQVFlPnDngw
knnuDXaoPpWX45AhVvAtpHHW5VflP2mENpr+EwHTi4bIWpwUE/0fm9wfGMgs0DV4
BnKeO6WtZqCzBaUB9b7lz6BetSbzoCZUbMlsQhHzOQsL8lBUhkm+AFGe541rPiaA
nHJ+2se5J4uUs7PZIDDpcTr5mZFXy2C8FG4DWoyjCNWBJdNFkTzNq1LSj+Cpf9i4
Sk7EZi4d4KcRcQITGDTjyJBh+zy06RdccjsCwA4eKa9dXYPnro7BHGstPRXx+kUK
F8aQ8qg3R/YuF4mG0j+NNI8ehmuC+tvV/dQRDOczY2XwPLDB0wQ2vp4Jwoo8vkpV
KROa1YO7fgHDe6jdBuAaD1/Q2gyn5G1rgGrlYeqqH8xysidjBMNhHfpvB+DKmz5N
F5Iu82MrxaLoUjS6rHRRMANNil5vg4HY8fSsTRSUN+f2E4Qa1T9+xdPh+X5dWCXw
E5m6xFmbulA1l4+hMomPZ1mJ0oRY1Z7fFzCGlhu1pdehW9ozNgJFgmp8rsLD/hc2
UKvc6VtxSD1dnWduSd3IlknsoGdJElsXZtivxoU28Dxc6FdbEKFxLQxW655iRm5Q
YHjWNss6jrcLl3Kgm3V0
=2LBq
-----END PGP SIGNATURE-----

--ipdlklUpMX3Prm52FVVa2e29robltF62U--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
