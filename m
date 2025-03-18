Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4F85626
	for <selinux@vger.kernel.org>; Tue, 18 Mar 2025 22:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338082; cv=none; b=kTNJqux6DEXEaWFtoh0gg1CN5yKvR57OnYx5eimPSyJK0EJqE5OxqVW0bQhKWObTrph+hIo4YwWKw5ZU18iYH/I8MYwZt6Cg62UzWnSLz+e21xsn/BqdS9eoSCZuvRxBSDEQH2th/9VlitttVqHa1m3LiFp6lAgPOCgfs2knMSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338082; c=relaxed/simple;
	bh=WQjPRH2t/ii27JdUEkhcOylXY9eARvj78N1HEfZHlpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvi/VVF5dqTqY53orBc2IK8xTwJlqUSbwZ2aswkD+1aJz1vh7cTa4UrUaBqG+Ag3HEd79xzPNpn9t8+80sqdIYRWVwMW6O4lpvTto+O29wz14N33OVMCCCEMnRdVGe6X9ScLQHbgU8AuALrPv7NWbsvIwRdf4mZki3DdxFFaFFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=CpZm3FUg; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="CpZm3FUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1742337677;
	bh=WQjPRH2t/ii27JdUEkhcOylXY9eARvj78N1HEfZHlpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CpZm3FUgKUKcPmahxvVGkTAUHFGMnX8zLMc6PDgn5QqbzibHBPeed5NOtc4l2ggsh
	 e44RHMQusQqyi5wYpflQ4l2gUrRwAXhe0VYW0qxOTgXHDfLacKZABUX5GHL0p+f0Kk
	 T2lCoZiQPrqXHAAbzLhXf3jB9i5Cbx7G6rdOX/soxZOezkgDOyDPq6tHFMDZ1FyRzv
	 0/4s15zAns7q8LKQW4dsV9OF0hdFWqYer63r8i+s6gH02EOfw00aEPJokMgPLYGOXw
	 JFfHp7ZQQgOo08R4N1Z0+5MVMe0GwIty1BvvtU9eP/wPmg2TdaNFErDEAK8ZaFV8ZS
	 KWTi0fet4YjoQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 6D6EEBEBA;
	Tue, 18 Mar 2025 23:41:17 +0100 (CET)
Date: Tue, 18 Mar 2025 23:41:17 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: selinux@vger.kernel.org
Cc: Alba Mendez <me@alba.sh>
Subject: [PATCH v2] Inject matchpathcon_filespec_add64() if
 !defined(__INO_T_MATCHES_INO64_T) instead of using __BITS_PER_LONG < 64 as
 proxy
Message-ID: <cpbjftpok3lt54s6t7qmhzwbhl47vsz3efrxs45t5os7ztp3zg@tarta.nabijaczleweli.xyz>
References: <jievtm5yb2pqqrn5p2idny7iipfoxnwn3gx5xtw6ycq6qqfgh5@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="asfmaes4o5kagu7x"
Content-Disposition: inline
In-Reply-To: <jievtm5yb2pqqrn5p2idny7iipfoxnwn3gx5xtw6ycq6qqfgh5@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--asfmaes4o5kagu7x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The __INO_T_MATCHES_INO64_T is defined
if ino_t would be the same size as ino64_t
if -D_FILE_OFFSET_BITS=3D64 were not defined.

This is /exactly/ what
  /* ABI backwards-compatible shim for non-LFS 32-bit systems */
  #if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_P=
ER_LONG < 64
is trying to get at, but currently fails because x32/RV32 are "LFS"
with 32-bit longs and 64-bit time_ts natively.

Thus, the
  static_assert(sizeof(unsigned long) =3D=3D sizeof(__ino_t), "inode size m=
ismatch");
assertion fails (__ino_t is the "kernel ino_t" type,
which generally corresponds to the kernel's ulong, which is u64 on x32).

glibc headers allow us to check the condition we care about directly.

Fixes: commit 9395cc0322 ("Always build for LFS mode on 32-bit archs.")
Closes: #463
Closes: Debian#1098481
Signed-off-by: =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz>
Cc: Alba Mendez <me@alba.sh>
---
 libselinux/include/selinux/selinux.h | 2 +-
 libselinux/src/matchpathcon.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/seli=
nux/selinux.h
index f3cf5a20..f64896b7 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -537,7 +537,7 @@ extern int matchpathcon_index(const char *path,
    with the same inode (e.g. due to multiple hard links).  If so, then
    use the latter of the two specifications based on their order in the=20
    file contexts configuration.  Return the used specification index. */
-#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PE=
R_LONG < 64
+#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && !defined(=
__INO_T_MATCHES_INO64_T)
 #define matchpathcon_filespec_add matchpathcon_filespec_add64
 #endif
 extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *f=
ile);
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 51f0e4ff..ab7c3090 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -261,7 +261,7 @@ int matchpathcon_filespec_add(ino_t ino, int specind, c=
onst char *file)
 	return -1;
 }
=20
-#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PE=
R_LONG < 64
+#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && !defined(=
__INO_T_MATCHES_INO64_T)
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
2.42.0

--asfmaes4o5kagu7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmfZ9ooACgkQvP0LAY0m
WPEgcRAAjAkGnqZTq2I2D1w/WQpmt9hc0mTmf2HAd6EFxFm1KP1Ldhhx88UmI3fE
yUJf3916vezHExaWH6eZZOuLVNH6yr/6lXV73O6c9dSYu+w+OdaQMrYfyFAcnDI+
QfBM/4WnhL+VV+UNj2UaDRsiXCgybj4cvHh4+MeaKTOK63x2oc4gizuCsQKCNVLj
6JAT8V3z1gysIHhTKGaXo8h0uCH4VHQttv20FwKp/hr9F5QaW8LWaQ8XxQKDZxCS
S9d3mKFlyQ4hpurG+uhLZgf82tPLaxQoOX+nXu9aJVwp8D6nJQWE7Gf2LL36d/iF
6dheMsVHP4tV7+WcVzuTieiDzFu3qICte8ixHrZInGUf9sULuLY0Mxj+DNQBV479
0wGzBY7O5dQJlyFuhKC52kiodKIq/vB8nm9zTg9J8TjzzIO0FlzGMKZVDPwSHmbF
xWoA6TgO8wozuSbwppn5MSJwPPHJ2qmQ2f6He82YXfn5s8mWP1teUi0K96M5BhUS
e5HgdS+OeceNGZ4B0+wRsUvr0HJwC58D4tCcDGRUxnx1QgW6Y5AOIZfL9EGN257N
Lr1cIzXB0UdNcWjGxIsGDxFwhqnR8qYlRT0TFLfo3m36RQVd5t81RMts4nwYIqgv
v4xcHVqWM/QNgwoCimSftGd6DTp5Lp3Zbv1XI4lZolEiSvrnRN0=
=8bnY
-----END PGP SIGNATURE-----

--asfmaes4o5kagu7x--
