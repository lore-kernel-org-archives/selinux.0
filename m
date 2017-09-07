Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v87CS2C1018038
 for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2017 08:28:03 -0400
Received: by mail-wm0-f49.google.com with SMTP id f145so22379539wme.0
 for <selinux@tycho.nsa.gov>; Thu, 07 Sep 2017 05:26:51 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id a33sm1797842edd.67.2017.09.07.05.26.44
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Sep 2017 05:26:45 -0700 (PDT)
Date: Thu, 7 Sep 2017 14:26:42 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170907122642.GB1813@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Subject: conditional role and range transitions?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I was just reminded of the fact that role and range transitions cannot be c=
onditional in kernel policy.

Is this technically impossible? Why can type transitions be conditional in =
kernel policy but not role and range transitions?

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlmxOv4ACgkQJXSOVTf5
R2mCZAwAti3qNjhbinKtlYgOr+a9Qbn7BuRwd/C5JGI35m/Wy8UXhoYnG3nB+XpI
M/sfyxS2oTQo7AKLAZA/7mAsMgFmx8poddOhv8gJScZwie2wBfFYEmauPl6afhKT
xIBrSgISmelOnNd6SMM8di971nGMW1nz70FxNZk8zadmJWxgtfKHAUZGJjvlEdA8
isLfaY2pw/qSlPw7JEKMHFvhxbbSWcSS0R+tivXu3Y576fPw6oHGIXmjL3n4bcHA
RvwUEA5tW8K1brGzBPJIZQZbHhwBO/8sjZBv73/ZdyH2FQUmxd2Hc+k1UAFOmFtL
aNNCm+qUnJjYGQ34qOs5xR3Nqv6y+a1IGBssUuzrED01PqmahXdMJadxZ595YkM0
4iHern5587ND3f+/xIcDokdJwDPgPuLpiT1Zj1CkJPpB4xLLoKTvbOdWpf7ccc5R
hAAwSmgWY9Ga+mq0Gvbofa0RawrvWs2WcXFf3+RJvD9d+zI4qUmUlehDD/D8Qqwo
RjYgyYFT
=7MMr
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
