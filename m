Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D16321D5B0
	for <selinux@vger.kernel.org>; Thu, 20 Mar 2025 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486131; cv=none; b=qLB+g562muW2IvCc7lfq/w7OzriT/W0DYIfxHkMEVZNdZHjtLcXQpMjuyzdoq2DAMc54Q1ZTnzvAvjwtDC7VYgBWw6odKNMOexP5wVaadciWWnW4NpLOPSEzbBPsKwdDChPy3JuyN7L4HbG/hgjO5Vj7gHhoSYm3sMSzScn7Gro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486131; c=relaxed/simple;
	bh=SWOBdaWZPRRdaS3EGAaFi7qbv5f9tuMsMBfKjJCL2HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpv16PktTx1SAnKxpj7vsdJfnYWRADu9I9sxyD5Bvji6lB5hhMmQpc/yTNDRw9hP9TY8RuZZd2c6/w3qGZoS1ijUKI+utAkU1BNS8Jcub/ZLrR26Sxb6LIvDikr9eHvGieis5xYpeHi1GKZZTgby92Xv5KeOMTnbh8Dm+I+KOKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=Gx50sX28; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Gx50sX28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1742486117;
	bh=SWOBdaWZPRRdaS3EGAaFi7qbv5f9tuMsMBfKjJCL2HA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gx50sX283Ur5JUpBqYs1n+FUHNhmB5xN6Iqxv6vT0PZ3YdBrkTpklRG6JygL3w3qD
	 +hGpBeLtwaugzib8M1//AFVtj1pcYmpzKJuoNr37SsijG6niIXwW8P435BtGjohxyl
	 84cIeQpiTUcT41XIFLzqDJr4KKYogCa9agKUce453jcA8HxBWojPXEhGkKi0esRcZj
	 sNh4DCRcRYPCUvAP156XYTT77Cx9z5rpEOi1MbOcbe80RP8LMX0KDFlV8c7BkhVu90
	 BAlSbqNJdUNzDFVe2mCpCSKk8GHFdMLQMK6fcZ5A6JsW3q95MMTVFV3+odB5T1RDvz
	 D68KxE2cp9Haw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id A6627C392;
	Thu, 20 Mar 2025 16:55:17 +0100 (CET)
Date: Thu, 20 Mar 2025 16:55:17 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: selinux@vger.kernel.org
Cc: Alba Mendez <me@alba.sh>
Subject: [PATCH v3] Inject matchpathcon_filespec_add64() if
 !defined(__INO_T_MATCHES_INO64_T) instead of using __BITS_PER_LONG < 64 as
 proxy
Message-ID: <jxjamggy4xaie53uyfuvriryqj4mtdc7gqr4gmjveyhwoukrxm@tarta.nabijaczleweli.xyz>
References: <cpbjftpok3lt54s6t7qmhzwbhl47vsz3efrxs45t5os7ztp3zg@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fqcvi35prowv5ulg"
Content-Disposition: inline
In-Reply-To: <cpbjftpok3lt54s6t7qmhzwbhl47vsz3efrxs45t5os7ztp3zg@tarta.nabijaczleweli.xyz>
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--fqcvi35prowv5ulg
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
Changes from v2: fix build with USE_LFS=3Dn on non-LFS ILP32 systems (i386)

 libselinux/include/selinux/selinux.h | 2 +-
 libselinux/src/matchpathcon.c        | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

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
index 51f0e4ff..a4f65045 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -261,7 +261,7 @@ int matchpathcon_filespec_add(ino_t ino, int specind, c=
onst char *file)
 	return -1;
 }
=20
-#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PE=
R_LONG < 64
+#if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) && !define=
d(__INO_T_MATCHES_INO64_T)
 /* alias defined in the public header but we undefine it here */
 #undef matchpathcon_filespec_add
=20
@@ -280,9 +280,13 @@ int matchpathcon_filespec_add(unsigned long ino, int s=
pecind,
 {
 	return matchpathcon_filespec_add64(ino, specind, file);
 }
+#elif (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) || defin=
ed(__INO_T_MATCHES_INO64_T)
+
+static_assert(sizeof(uint64_t) =3D=3D sizeof(ino_t), "inode size mismatch"=
);
+
 #else
=20
-static_assert(sizeof(unsigned long) =3D=3D sizeof(ino_t), "inode size mism=
atch");
+static_assert(sizeof(uint32_t) =3D=3D sizeof(ino_t), "inode size mismatch"=
);
=20
 #endif
=20
--=20
2.42.0

--fqcvi35prowv5ulg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmfcOmMACgkQvP0LAY0m
WPF4DA//XhFMJm2Bf5TsPBBorFGK6M1gQ8/TOriTxYUQFxnl7FnadVXM/tJYOoDp
zqnVSKTkxaXiFk8Hp7psKJmOKlNu31BDFHcT1BmIoufGAb1nKaDEFSmAe4YVrFPX
y2YetLAiUeR+X2/p6L21oiaBFNrJaGtsw4qd5mlGTQK7RppRshS4eUkSo86V5R8j
chNNdI8t0xj/C9Bp5QfvfBlwKEDGkPY0Uu4rX7mv+oDuW/abTKptMQYijRWRGXml
zVYnMeU6R/Y3RVbWOQVZm2FRSD71ANqyvnkl/KYkaaF5b/lQMimplRVVNTLDT6o9
mQg303ivGeHyzEvkfACFGp98xTA5fqiRTNrGa0BWykeKMKeVR+73H6OSJfqA1ESz
OrXZ6vN4l33otmuN2f3tbAuJn0Xc168agUudljpNhLRSdX75aK4EZhXHteYDjFIf
P3x3xtHiEoy/VCYHFjmIFRFadVUApA2ugQANe01lDktV9Gijz8yl3pxLhbeR0mFP
ejEMG6zFk/rP++kB8vLNaQw1TPDXldfy88CCzHw3GQuCtQ8Vbu/FCOQxelMjQFk/
QJRwineWG7Z1lGIvOaUwAALfRy5TKyBjVOyfN/SilxRrf0LvZefQcx/13Na60ZV3
ma6XuJNkyEs9vgX8BcC6y1pDRN9wpu0ucfma2PeR3UBLvbC/SI0=
=ITbT
-----END PGP SIGNATURE-----

--fqcvi35prowv5ulg--
