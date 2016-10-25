Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9PDoMrG027057
 for <selinux@tycho.nsa.gov>; Tue, 25 Oct 2016 09:50:24 -0400
Received: by mail-lf0-f52.google.com with SMTP id o16so10822815lff.7
 for <selinux@tycho.nsa.gov>; Tue, 25 Oct 2016 06:50:20 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id q125sm3836014wmd.2.2016.10.25.06.50.17
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Oct 2016 06:50:17 -0700 (PDT)
Subject: Re: POSIX mqueues
To: selinux@tycho.nsa.gov
References: <CA+RmS-_=5kQza1VcwXoqwF40nvXBv6t2z4=rESj494=nDJ7RnQ@mail.gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <977dbaf4-2064-5953-c4f7-4b9cd27d84e6@gmail.com>
Date: Tue, 25 Oct 2016 15:50:12 +0200
MIME-Version: 1.0
In-Reply-To: <CA+RmS-_=5kQza1VcwXoqwF40nvXBv6t2z4=rESj494=nDJ7RnQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D4PklLW8WAGwbMEHKieUatPFhA5fxUgwF"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D4PklLW8WAGwbMEHKieUatPFhA5fxUgwF
Content-Type: multipart/mixed; boundary="a3cuUTgak6UxlJhFkMAeS1638QBr8NjW0";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <977dbaf4-2064-5953-c4f7-4b9cd27d84e6@gmail.com>
Subject: Re: POSIX mqueues
References: <CA+RmS-_=5kQza1VcwXoqwF40nvXBv6t2z4=rESj494=nDJ7RnQ@mail.gmail.com>
In-Reply-To: <CA+RmS-_=5kQza1VcwXoqwF40nvXBv6t2z4=rESj494=nDJ7RnQ@mail.gmail.com>

--a3cuUTgak6UxlJhFkMAeS1638QBr8NjW0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/24/2016 09:25 PM, David Graziano wrote:
> I am attempting to write policy for a set of applications which use
> POSIX mqueues using named type_transistion rules to uniquely label the
> mqueue files in the /dev/mqueue directory then controlling access
> based on the types. Standard type transition rules seem to work but I
> cannot seem to get the named type transitions to apply the proper
> label. Are named type transitions not supported by the mqueue file
> system? I=E2=80=99m on a 3.14 series kernel with policy version 28 if t=
hat
> helps. I=E2=80=99d like to avoid needing to do a restorecon after a new=
 queue
> is created. Named type transistions seem to work on other file systems
> like tmp and jffs2.
>=20
> Thanks in advance,
> David Graziano
>=20

FWIW, I can confirm the above. Am encountering the same.

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--a3cuUTgak6UxlJhFkMAeS1638QBr8NjW0--

--D4PklLW8WAGwbMEHKieUatPFhA5fxUgwF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYD2MUAAoJECV0jlU3+Udp2CQMALkb1k0Rmna/QefbshR5VVPd
BqkXlN8H5M5QvnmBxPl9YOV1Kq65xWVn6ga/ticHzQf/7RJqxKqNbA1fCXmEK9eQ
H1w3KyVMkuDR5jCIUSdhEJ0RSG9g0Cn0iJPuvR4mchzfKvMPVKBH5wZIpQtvdmtf
pPnRIpsPhEonLE0YoNepsoXNM0gPVhYIo512Ot9NfhXeObP0TxmOMEMojCciMwQx
Hsi3kXk8yBKjy3APX8xxeKRPngVLhs0oMgGKpz2g6Y687JeZq/d+0dGQaewkGB3Z
1dngHAEVg23lEKmIosu7SeeqxkFrEzitrwbQ68e8juxOpet6EQZJhjQOFpyUWuaT
YzN9R4dD8c2mlS5uXdrkYxCa2//TB/6w2NBkltR/cv6MbKVHmgu2yWOYsaKiFeqv
xqvqXJSnn+f15GlaxtLqn58mEoQSh0N/kO5LV5NM1ZBRmIcZVak+keOevL8svdQH
+u0kgTDha4Tyf7Hen2SEu2KHb6aEU6Ui2x+RrpkzBg==
=RLfQ
-----END PGP SIGNATURE-----

--D4PklLW8WAGwbMEHKieUatPFhA5fxUgwF--
