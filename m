Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA5J4iSr026355
 for <selinux@tycho.nsa.gov>; Sat, 5 Nov 2016 15:04:44 -0400
Received: by mail-wm0-f43.google.com with SMTP id f82so48484885wmf.1
 for <selinux@tycho.nsa.gov>; Sat, 05 Nov 2016 12:04:39 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id f3sm3651125wmf.10.2016.11.05.12.04.37
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 05 Nov 2016 12:04:37 -0700 (PDT)
Subject: Re: Security context of shared libraries
To: selinux@tycho.nsa.gov
References: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <450453c1-af39-8875-2c2d-4db7b2171f0a@gmail.com>
Date: Sat, 5 Nov 2016 20:04:25 +0100
MIME-Version: 1.0
In-Reply-To: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HFlnmcUgstxcQFG6pr8RapKmAkguALxbL"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HFlnmcUgstxcQFG6pr8RapKmAkguALxbL
Content-Type: multipart/mixed; boundary="qTPEtXHgTvbXaJbBogDqkhANov0LI62tI";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <450453c1-af39-8875-2c2d-4db7b2171f0a@gmail.com>
Subject: Re: Security context of shared libraries
References: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>
In-Reply-To: <f195719b-bab5-6a83-0a13-8d62c077e808@gmail.com>

--qTPEtXHgTvbXaJbBogDqkhANov0LI62tI
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/05/2016 07:55 PM, mm wrote:
> Hi all,
>=20
> I have an executable started by /bin/foo which runs confined within the=

> context foo_t.
> The process loads (actually does LD_PRELOAD) bar.so which needs to
> access resources outside foo_t (actually unconfined_t).
>=20
> I can allow access to such resources from foo_t, but I would like to
> allow such access only for code running within bar.so, instead of the
> whole process.
>=20
> I have been looking in the docs, but I could not find if it is possible=

> to specify a source context for shared libraries, instead of whole
> processes.
> My idea would be to define a context bar_t for code running within
> bar.so, and allow the required access (to unconfined_t) from bar_t,
> without extending access for foo_t.
>=20
> Makes sense? Is it possible?
>=20

Makes sense, but is not possible AFAIK (not transparently anyway)

> Thanks in advance,
> M. Manfredini
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--qTPEtXHgTvbXaJbBogDqkhANov0LI62tI--

--HFlnmcUgstxcQFG6pr8RapKmAkguALxbL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYHi0+AAoJECV0jlU3+UdpGYYL/A2roiSqsuzTxfIPFUg9hSlZ
k3UGTvuUfI5lW1bJI4Muj7Eo0ycEqVne0mNLvCW+NgfipD9Z3X8SqRQ/pp7DatsL
5WHsvM4jZF7DMDQF7Ycqj9yCw0YgFW4KMji1uvMXasQYlZlxK4V9Qihm1Qh3D5Vk
hobHFUTSZ/g5IhtXA134911CHnOfOLNeeOmF5y1tuxooTY2JOZSdY9zWXtgM2fK4
XGYp6NKqdmANnU8A4qrOzeAoe5qw5sNn46gbUuO0M6CpPrsgiiTYuYwo5PCFF664
FWRNcJNmm35hCz8T4N6tf9iHkppV5HiPMO0FKYjYClly5cE8akEOH3TbZjZPCRFe
+7VvPIYDNs1REnBlfABzZYrzbJxz/uck9CXcx4bl9k/UuSjG99W040G4In/+zN20
RAZuAfba/1mJQEAfsRww5NSZeeNc91YyvlDuC8JwbcrcsxkYlf8suKwArsOsVZqq
7YmBdz8ZgDtdarxvKQcOGBKwPemIkzi6ESSzsk87mg==
=qSDK
-----END PGP SIGNATURE-----

--HFlnmcUgstxcQFG6pr8RapKmAkguALxbL--
