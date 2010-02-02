Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o12FPS1P017710
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 10:25:28 -0500
Received: from ey-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o12FPCp5002661
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 15:25:13 GMT
Received: by ey-out-1920.google.com with SMTP id 3so43151eyh.32
        for <selinux@tycho.nsa.gov>; Tue, 02 Feb 2010 07:25:20 -0800 (PST)
Message-ID: <4B6843D3.6010106@gmail.com>
Date: Tue, 02 Feb 2010 16:25:07 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: (WW) file_contexts:  line 0 has invalid context system_u:object_r:info_xproperty_t:s0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig68BB7A32A6528EB0CB4E9148"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig68BB7A32A6528EB0CB4E9148
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I Get this in Xorg.0.log when booting:

kernel-2.6.32.7-37.fc12.x86_64
selinux-policy-mls-3.7.8-5.fc13.noarch

(WW) file_contexts:  line 0 has invalid context
system_u:object_r:info_xproperty_t:s0
SELinux: a property label lookup failed!
Fatal server error:
SELinux: Failed to set label property on window!

Any idea what may be causing this?


--------------enig68BB7A32A6528EB0CB4E9148
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAktoQ94ACgkQMlxVo39jgT/p8ACfWophFOHknhys6ENtVwdHhn5c
CgQAoLaAdtLuYp6Lq3KOJEmNH93xuhD+
=cxwv
-----END PGP SIGNATURE-----

--------------enig68BB7A32A6528EB0CB4E9148--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
