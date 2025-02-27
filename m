Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FC26F460
	for <selinux@vger.kernel.org>; Thu, 27 Feb 2025 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692078; cv=none; b=unCTzVD3zNonU+OgjHeI2M1QlHLTZi1C+meIQG+q07Odie+cqOR0eyGmGLVueWMrGThcz4I6ZNl0XSTbo+DRTSoc23HH+jj2aT6Q2mn7qc1Ajs8YG9lmzOWzXWy2Pwvhbxc7ZLZmgBdAgmmbzX04hr269bZBs680GaUi1Sbk+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692078; c=relaxed/simple;
	bh=ya1qk9lYYTZfO9ff2Xk9gnLhfnlryoX7HPX0orHoh6c=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bOrtf94WwXetCgnFQut5gbx1Ml/rXIB3tQECuYCSqjNxwLuolg/F4+682sR0tQO5lY7DjX43/sQ58WtWztTsLSB+h2hGlcez00MyKvlQSJfmCMghvazOws628t10F8f2XnF6/8prInL0FCcj5iYd5+ShuSSOYN7TdDxNZhDjHnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=NXlxUqXZ; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="NXlxUqXZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1740691931;
	bh=ya1qk9lYYTZfO9ff2Xk9gnLhfnlryoX7HPX0orHoh6c=;
	h=Date:From:Cc:Subject:From;
	b=NXlxUqXZk5UnvDD+GTJMI/85znNYFwnKKk4O4lH+qN8MNLWJHYmD/iEE1cR8WY9XQ
	 xW5/xWn4wMHSZrUDExoxgtsLH+sv7fOxSU+rFrZFjG9+eKwsit1kSj4UQOr6iBlQLy
	 xghr5j9d2EThNpcNBT7RVkrqzkCxvzH4Z8U2UqZ+6ONUM5FWnayCmdLeW6QVcLkKCZ
	 VPtZ6l5E607RbNe+v17tk0pZwiBdt/3AiCiluyePh+VPLeY2V+ATqhPAXk7v59Boap
	 4aCHzHry/VgQroB/R3Eae9jN4A1qwXQeMwDRHKq28C7UlNWHLPmzqw0nqm311XjWNv
	 +P+aC1R4y6+Sg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id CCBC2A35E
	for <selinux@vger.kernel.org>; Thu, 27 Feb 2025 22:32:11 +0100 (CET)
Date: Thu, 27 Feb 2025 22:32:11 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: selinux@vger.kernel.org
Subject: [PATCH] Don't inject matchpathcon_filespec_add64() ifdef __x86_64__
Message-ID: <jievtm5yb2pqqrn5p2idny7iipfoxnwn3gx5xtw6ycq6qqfgh5@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="babbd5cjwadzhfob"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--babbd5cjwadzhfob
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As the code notes, it wants to add an
  /* ABI backwards-compatible shim for non-LFS 32-bit systems */
it tries to detect these with
  #if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_P=
ER_LONG < 64
which is correct with the added precondition that the ino_t /without/
-D_FILE_OFFSET_BITS=3D64 /was actually/ u32
(i.e. it conflates /all/ ILP32 systems into being non-LFS).

This is not the case on x32, for example, which is LFS; thus, the
  static_assert(sizeof(unsigned long) =3D=3D sizeof(__ino_t), "inode size m=
ismatch");
assertion fails (__ino_t is the "kernel ino_t" type,
which generally corresponds to the kernel's ulong, which is u64 on x32).

The correct spelling of the test for this is
  #if (...) && sizeof(__ino_t) =3D=3D 4
but this is not statically solvable with the preprocessor.

Thus, we need to explcitly special-case this.
__x86_64__ indicates one of two ABIs (LP64 (amd64) or ILP32 (x32)),
both of which have ino_t=3Du64, and is the macro used for defining
__INO_T_TYPE in the system headers, so it's the best fit here.

Fixes: commit 9395cc0322 ("Always build for LFS mode on 32-bit archs.")
Closes: #463
Closes: Debian#1098481
Signed-off-by: =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz>
---
 libselinux/include/selinux/selinux.h | 2 +-
 libselinux/src/matchpathcon.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/seli=
nux/selinux.h
index f3cf5a20..318e273f 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -537,7 +537,7 @@ extern int matchpathcon_index(const char *path,
    with the same inode (e.g. due to multiple hard links).  If so, then
    use the latter of the two specifications based on their order in the=20
    file contexts configuration.  Return the used specification index. */
-#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PE=
R_LONG < 64
+#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PE=
R_LONG < 64 && !defined(__x86_64__)
 #define matchpathcon_filespec_add matchpathcon_filespec_add64
 #endif
 extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *f=
ile);
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 51f0e4ff..61f27274 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -261,7 +261,7 @@ int matchpathcon_filespec_add(ino_t ino, int specind, c=
onst char *file)
 	return -1;
 }
=20
-#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PE=
R_LONG < 64
+#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PE=
R_LONG < 64 && !defined(__x86_64__)
 /* alias defined in the public header but we undefine it here */
 #undef matchpathcon_filespec_add
=20
@@ -282,7 +282,7 @@ int matchpathcon_filespec_add(unsigned long ino, int sp=
ecind,
 }
 #else
=20
-static_assert(sizeof(unsigned long) =3D=3D sizeof(ino_t), "inode size mism=
atch");
+static_assert(sizeof(uint64_t) =3D=3D sizeof(ino_t), "inode size mismatch"=
);
=20
 #endif
=20
--=20
2.39.5


--babbd5cjwadzhfob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmfA2dsACgkQvP0LAY0m
WPH+gA/8CBvD35o2ckqFZDeDZz0oiSsH9ye4zAP6xAUcj2r4PISmWt9uAO1XJNd8
noEixTiQ9A2Q85z5Ryy4pU82O3j1ZGptBZ0luoPybPmJLtdfs3cszV1s8x+SwYPy
X7kI4hRclrQRn1qzNTzAThxSaC6a9LYwQJ0ByZA1fak3ez/PJ1P4Kwbjd56wdk9c
8SMCr6E4/xI98LZQgZBp/pyWPDxj9GsQStTHgTRw3eQt9dK8nm7vLY75v5QWl3UJ
pqafWFWWYm3+sH2ZSxbmGlPOPBMzeIq2Kl0j0ZbUT+Ht+Ld/7mzLgACu6vOzA2ke
2FwgMsCv/DkWzDVL4Qb4/faoIE3ZYqmfSJsXA8sJzPLxgHbTlFlg8ZUSbVwV+x/F
k9elqXo9yV/vrGD0ZDuBr7P9CupfdsEsD1tpDQsii3prJqxxuaobm1tQyABqLQ50
+s82lhtOhOv4ZT8Dt0hMx7skSmLtMbwsAPSpAleNiQ5aefC9f0YTf9Jpm/qBz/2E
yZ4wT8Bk4WkKTjcKjEEXHh9+4gJXXNp+K9Vy2L0aUGxPv/vvd5tlGq7yNelFprvo
ub+AA1YAc3fwKMfnQSWQfNv6e3ZM/Ug2VpUhBvcZWExlL1jjun3FEu+184QWQCqZ
EszSqGQp+MuLinCS7WG6BDETXT2BSHiRpHkM/kSmd5MZIb+0S4g=
=sp9H
-----END PGP SIGNATURE-----

--babbd5cjwadzhfob--
