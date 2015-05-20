Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4KFq5Fi022722
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 11:52:05 -0400
Received: by wicmx19 with SMTP id mx19so159999395wic.0
 for <selinux@tycho.nsa.gov>; Wed, 20 May 2015 08:51:39 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id n3sm4207245wix.1.2015.05.20.08.51.38
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 May 2015 08:51:38 -0700 (PDT)
Date: Wed, 20 May 2015 17:51:37 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: enable per-file labeling for debugfs files.
Message-ID: <20150520155135.GA30612@x131e>
References: <1432064766-30354-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
In-Reply-To: <1432064766-30354-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2015 at 03:46:06PM -0400, Stephen Smalley wrote:
> Add support for per-file labeling of debugfs files so that
> we can distinguish them in policy.  This is particularly
> important in Android where certain debugfs files have to be writable
> by apps and therefore the debugfs directory tree can be read and
> searched by all.
>=20
> Since debugfs is entirely kernel-generated, the directory tree is
> immutable by userspace, and the inodes are pinned in memory, we can
> simply use the same approach as with proc and label the inodes from
> policy based on pathname from the root of the debugfs filesystem.
> Generalize the existing labeling support used for proc and reuse it
> for debugfs too.

Was there a compelling reason not to implement something similar for /sys?

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVXK2EAAoJENAR6kfG5xmcr84L/jEsnuf+W/elAvVUYQUHxwg2
qfH2/7hk/poCz8hTC4TSw0JpCz3s+He1qqmgbvhbMjcR/l9KmSUv0snKXNnLgxHF
UHbdbCI9gqlKN7VkyRGYcpitz6DMIKeUUxa790kfQwRrUccwJAH95pJ83DlxJN+U
tU8mDs3EQclJkUn4AzpJSyjKGUdMPCA6zW94v8FhU43ofVoUtvZLCUJ7ag9tjRV7
DxbBew5IwNPv5yBnI5o5yqh6yYFKeN1ON7awSTfqo1C+m7pXiaf84XEtWIrxkVlp
K1vGQ10uRaI38PRg1gy9mIZedC5S+iiFsGzvdFr73pj66WosQl4zvsrsc+okfCnX
42nd2b1vUIdKE0t5pqaxuAV6+3yIIbD2XJwwRq37LMeSzBe1oeZaO/mU6IzaIVkl
tH/c8OnAGZVqIL2laCHO+2zsvy35UfImctzgNrZvmpLABHTYgM4iHSwki+ZA/M+b
YYvVjMs0jYhcYjoDkhtuyRe5JwqLNrYgzvaq7t13ag==
=wED2
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
