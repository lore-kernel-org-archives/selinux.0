Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE9F624
	for <selinux@vger.kernel.org>; Fri, 16 Feb 2024 00:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043731; cv=none; b=FyTtGA0mNJ2nKOlavumzv8cK2xSPAAc5w5KIwtuexdzqoyUKtT3jpuLI/DWIO3PIDz3JMDvG+UlVZCu4K+dx8z5XJbN9QfgOqgzjJS6rWwoOQ4lHD7CEyz0iKaA8vkfjM/LccCgC9O3S+AmKuClap4ukPfLCpksgFEhi0Gs2/6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043731; c=relaxed/simple;
	bh=YpPX0cbiTZbeKdVr79CipxTLqPl6C+AIHexBEZUnEwQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/TYJeVXqoxyeRpqllUecRMAbjYuqghvhx7kV8UiZXbd98LIj3ZM0kzZcmxPvFgb/S2nlCaAibjV+FG4Tnpp6dg5ybs6E/gde+6Mwx0tdFudtajPY1dzup4NZkhhxrnRs2/A5ceUtOxIBRZFLcbToMCOj7Yw7DjFpIIdM2tj03U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nBzrRZfG; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nBzrRZfG"
Received: from homer.dodds.net (1.general.vorlon.us.vpn [10.172.64.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C0D603F20D
	for <selinux@vger.kernel.org>; Fri, 16 Feb 2024 00:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708043726;
	bh=APjoj6jpyP0Mo3q2JG4UAGwdK67RMimdY8iKFglybvo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=nBzrRZfG2khWSfsVuyYZEE5IOEvHmgnpS/lPdlRBXCntBNbMOHwKT6vcM++bPWqvD
	 3mn13T36PG35LmiWEqNNKuwTt4G1wa3XF2JwhW5UL1P9X5slPon7+9pc1asrd70vnW
	 7h3KQCVw1Os6D/yjbI/tXVNebFpPk6+uismYNv32CdVBTRm1MBHv3f0YeXHQcEIoer
	 vZ6fqDJ+2rahKNFxLt7tC+Sa1XumjH4JZ8Ohw8QAtKBK9+olJF22ELOu16AhkbL0d3
	 zZG+IZ1+0UvMRsvIQwHJdWuqSDuKxBwZuT6Hk9uOGBFnW5CQQIjlOoihlAulWcLlM2
	 o825pJBEJ6g+g==
Received: by homer.dodds.net (Postfix, from userid 1000)
	id 10372BF8; Thu, 15 Feb 2024 16:35:24 -0800 (PST)
Date: Thu, 15 Feb 2024 16:35:24 -0800
From: Steve Langasek <steve.langasek@canonical.com>
To: selinux@vger.kernel.org
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
Message-ID: <Zc6tzKPsYZRICHya@homer.dodds.net>
References: <20240216003252.29057-1-steve.langasek@canonical.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZEjvTIK/NHp6ZNMs"
Content-Disposition: inline
In-Reply-To: <20240216003252.29057-1-steve.langasek@canonical.com>


--ZEjvTIK/NHp6ZNMs
Content-Type: multipart/mixed; boundary="Zpno/pGLVqVxwvDo"
Content-Disposition: inline


--Zpno/pGLVqVxwvDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry, I clearly don't know how to operate git send-email.

--=20
Steve Langasek                   Give me a lever long enough and a Free OS
Debian Developer                   to set it on, and I can move the world.
Ubuntu Developer                                   https://www.debian.org/
slangasek@ubuntu.com                                     vorlon@debian.org

--Zpno/pGLVqVxwvDo
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Always-build-for-LFS-mode-on-32-bit-archs.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 76049abc81d6209e0692fa96e8cfb4053b717201 Mon Sep 17 00:00:00 2001
=46rom: Steve Langasek <steve.langasek@canonical.com>
Date: Thu, 15 Feb 2024 15:22:45 -0800
Subject: [PATCH] Always build for LFS mode on 32-bit archs.

Maintains the type signature of the existing matchpathcon_filespec_add()
entry point on 32-bit archs but maps the API to a new
matchpathcon_filespec_add64() entry point that takes a 64-bit ino_t argument
instead.

Software on 32-bit Linux ports which historically use a 32-bit time_t (thus
affected by the y2038 problem) have, as a precondition of migrating to
64-bit time_t, that they also migrate to large filesystem support because
glibc does not provide entry points for the cross-product of
(LFS: yes, LFS: no) x (time_t: 32, time_t: 64).

In order to support smooth migration of such operating systems from 32-bit
time_t to 64-bit time_t, it is useful for libselinux to:

- provide entry points on 32-bit systems for both LFS and non-LFS variants
  of the API (as glibc itself does)
- use LFS internally for all filesystem calls (just in case)
- map the API call to the correct implementation based on the build
  environment of the caller.

Signed-off-by: Steve Langasek <steve.langasek@canonical.com>
---
 libselinux/include/selinux/selinux.h |  7 ++++++-
 libselinux/src/Makefile              |  1 +
 libselinux/src/libselinux.map        |  1 +
 libselinux/src/matchpathcon.c        | 15 ++++++++++++++-
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/seli=
nux/selinux.h
index a0948853..78953870 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -1,6 +1,7 @@
 #ifndef _SELINUX_H_
 #define _SELINUX_H_
=20
+#include <stdint.h>
 #include <sys/types.h>
 #include <stdarg.h>
=20
@@ -521,7 +522,11 @@ extern int matchpathcon_index(const char *path,
    with the same inode (e.g. due to multiple hard links).  If so, then
    use the latter of the two specifications based on their order in the=20
    file contexts configuration.  Return the used specification index. */
-extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *f=
ile);
+typedef uint64_t libselinux_ino_t;
+#if _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PER_LONG < 64
+#define matchpathcon_filespec_add matchpathcon_filespec_add64
+#endif
+extern int matchpathcon_filespec_add(libselinux_ino_t ino, int specind, co=
nst char *file);
=20
 /* Destroy any inode associations that have been added, e.g. to restart
    for a new filesystem. */
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index d3b981fc..267291aa 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -87,6 +87,7 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-sec=
urity -Winit-self -Wmissi
           -fstack-protector-all --param=3Dssp-buffer-size=3D4 -fexceptions=
 \
           -fasynchronous-unwind-tables -fdiagnostics-show-option \
           -Werror -Wno-aggregate-return \
+          -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64 \
           $(EXTRA_CFLAGS)
=20
 LD_SONAME_FLAGS=3D-soname,$(LIBSO),--version-script=3Dlibselinux.map,-z,de=
fs,-z,relro
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index 5e00f45b..88c9b3e5 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -251,4 +251,5 @@ LIBSELINUX_3.5 {
   global:
     getpidprevcon;
     getpidprevcon_raw;
+    matchpathcon_filespec_add64;
 } LIBSELINUX_3.4;
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index e44734c3..189e00fb 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -195,7 +195,8 @@ static file_spec_t *fl_head;
  * then use the specification that occurs later in the
  * specification array.
  */
-int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
+int matchpathcon_filespec_add(libselinux_ino_t ino, int specind,
+                              const char *file)
 {
 	file_spec_t *prevfl, *fl;
 	int h, ret;
@@ -261,6 +262,18 @@ int matchpathcon_filespec_add(ino_t ino, int specind, =
const char *file)
 	return -1;
 }
=20
+#if _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PER_LONG < 64
+/* alias defined in the public header but we undefine it here */
+#undef matchpathcon_filespec_add
+
+/* ABI backwards-compatible shim for non-LFS 32-bit systems */
+int matchpathcon_filespec_add(unsigned long ino, int specind,
+                              const char *file)
+{
+	return matchpathcon_filespec_add64(ino, specind, file);
+}
+#endif
+
 /*
  * Evaluate the association hash table distribution.
  */
--=20
2.40.1


--Zpno/pGLVqVxwvDo--

--ZEjvTIK/NHp6ZNMs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErEg/aN5yj0PyIC/KVo0w8yGyEz0FAmXOrcUACgkQVo0w8yGy
Ez38phAAur5Irs/T6R+cpaNZxMxWPC4GHzwFy60w6j+oN9sTcXRkM2GkHtKYLO6h
CEZnv9zuhqu07THI/6FoUyTAKv2OBzKJu8YzBYB/m0ZmNAoxGPGV4qrVEdM0kmRm
wzJZbpCy/LpyUjzXiV2SuBvNekL3EdB19jMJS7yTsU2kUfKwxlWcDe0d5214gWQQ
r1IZsdedJ5qrVwnJJHXFQyHfhJgDQ/s8uPcgEtLifXsLlwFd4hGQHVUHXNlRyOIJ
Ze3Z8L/YinG11b/F5Rm6coIF3M7W6dMhGembA8gzwvPbvpJRYfq3MwKozCxzU6hS
FQaCVHEGqi2dArekFN+9T4nFCsDR7DcVQhBhRqs2ZtiYdR7EDeshTtqfUPT4OYeH
8naSuRrKuuOCGprSHHwNx1OtDidUuMbwL+RnMZ9O3A1pB8vfOzlHxTqAtL10xsZM
K4PNYUAyDASpeaM4RiWmx28NMdocmAwjB0ejsUGEjssQMIsXJB0cbsvetTXDd2sG
yJj8QHQTMdjOVM9qVvwZ9I6wUcGcLmKjxms0aqwkSzhHqqrYwJYeUyFqkwevGYun
gWHaZfgIFzGjRy+p/qMGbJPO/q1UIKOBFkX4/Or4AuyedZoEPGmfAaj3EEj+MXOF
20ScCddyomHB8Id/Tzk8GMbqtpaaA+GbSpOXk2bUix1Skm9ytNI=
=0J3r
-----END PGP SIGNATURE-----

--ZEjvTIK/NHp6ZNMs--
