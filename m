Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u998AqNg001044
 for <selinux@tycho.nsa.gov>; Sun, 9 Oct 2016 04:10:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id d128so567048wmf.0
 for <selinux@tycho.nsa.gov>; Sun, 09 Oct 2016 01:10:50 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id 4sm12027193wmu.2.2016.10.09.01.10.48
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Oct 2016 01:10:48 -0700 (PDT)
To: selinux@tycho.nsa.gov
From: Dominick Grift <dac.override@gmail.com>
Subject: should module_load be checked on a kernel module object?
Message-ID: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
Date: Sun, 9 Oct 2016 10:10:38 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2uEg61U8B7FbaETWbxlF6VW4xeQ5oTFN1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2uEg61U8B7FbaETWbxlF6VW4xeQ5oTFN1
Content-Type: multipart/mixed; boundary="XAFVwA1JqUIkf3E4b1idLh93KEpFX6L3h";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <5906c68c-4c9e-cdfc-1eec-a15701841d6a@gmail.com>
Subject: should module_load be checked on a kernel module object?

--XAFVwA1JqUIkf3E4b1idLh93KEpFX6L3h
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


I encountered a system module_load event for the first time today.
Howver i am a bit surprised:


avc:  denied  { module_load } for  pid=3D473 comm=3D"modprobe"
scontext=3Dwheel.id:sysadm.role:lmc.subj:s0-s0:c0.c1023
tcontext=3Dwheel.id:sysadm.role:lmc.subj:s0-s0:c0.c1023 tclass=3Dsystem
permissive=3D1

Should that permission not have applied to a kernel module object
instead of "self"?
--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--XAFVwA1JqUIkf3E4b1idLh93KEpFX6L3h--

--2uEg61U8B7FbaETWbxlF6VW4xeQ5oTFN1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJX+fuDAAoJECV0jlU3+UdpiOkMAKtSeN7fi+EIEdNBr7R5c6Oa
eKLQvkmQBW+5stCNdqbGQXGjb4OyWCNmpgMyFFymw3VqEbIVtuL5ZhasgVTpeusc
3M0FB0LALGKxN3RuflQvW3APKakjB3bujetUA3eLK+rqjioyvNnyN0neMQVfKBYT
LbV4qC7sAcoJFqBwfW+3hwl8Mya4VPKX4rVQMFuRGGooJ0e/OMimNK0NnLUAEuWo
hNEHwaPm9mxXf9pCRqLgPGooCtTD8m4f6G0xLQTCE+pjPeMVMTpIMG/7piVIZNNI
rhOKxACpFxewVP+NXtw4ZAgEAC0APrAsn1eICpyJvlcQH+n6XTkJ37MvaEt5HpO8
C6ZcHNf5/5YddvC23g/DWkUIzMYPCxfq4T26FGM86Tc6Jttn1G5bcy3WtLDrlxn6
QDtIip3JpIUNCYvMv6nfD11lt9/m102lYJNHHUOQH+Yzt1LlMgCS/K87RWaPvszt
pd2y5SOHFI5G4Ybrm/1ILsyeris5Lhcy530MipLNOg==
=+kpV
-----END PGP SIGNATURE-----

--2uEg61U8B7FbaETWbxlF6VW4xeQ5oTFN1--
