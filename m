Received: from becquer.dodds.net (becquer.dodds.net [207.224.24.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40473945A
	for <selinux@vger.kernel.org>; Sun,  3 Mar 2024 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.224.24.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709452868; cv=none; b=OZjSBmNv+DdlkeLyo4SswapzcEs5oJYKsjC3glrI39mKty/SdXqY2aGw85oxThIbFRuSR/D2x0YnXdMU3Ms1oAsHRgLJOfsA5TrVyLlKpPCFEiro0pwRjdkawpjJRSvCksaIQLmWp5tP2SJWXwmHw+El/3r8t2iOXVOdycBM2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709452868; c=relaxed/simple;
	bh=grT97Ntlx66XQ4ln68Ys0GEPoPV6y6pNC+VuzQtCQkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/gLtOlEaQ9qvf1wbAYOUrLB0voRYIecTMpmsQZMZeI8efPpn1AkchSWs9zfbDPhCuQP1R54snIjAkmj1BRK4B5Jnvmsvjn53W0kaMJ6hUJmV+hcjIqazLitdkCJ6dCYmaiO++fJ7KhUZ6JFMzQ6rCCPUA5HIvFsxgdtghGEQtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=O0Yz7bBY; arc=none smtp.client-ip=207.224.24.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="O0Yz7bBY"
Received: from homer.dodds.net (homer.local [192.168.15.41])
	by becquer.dodds.net (Postfix) with ESMTPSA id A9CD825259;
	Sun,  3 Mar 2024 00:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
	s=debian1.vorlon.user; t=1709452857;
	bh=grT97Ntlx66XQ4ln68Ys0GEPoPV6y6pNC+VuzQtCQkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0Yz7bBY4mghro/8LY8OqxVJrXWLSfSTxlC4DswrFmcbNKDrKjsgUazrx/W45IvAg
	 rKQLINe/vHOiHopUgK7uX9R+CIWGhkxmwkySbO13+W7MuD6bNJs2aOSkKT+m+vPFGv
	 F7bfQ/LMvH6T88ugBdKaD0GRkh59fyjp9NuRkJWC97F4ve4oZLTjdnU3HrhFtATIVD
	 WZOnlBHOTv5PWpkdbd9lfxCVYUl1NjsCWpaEXzwcl+nWCsoiZ76Ox+mPnliH5Z4bN7
	 YD9Uo152qlkUZi/SHzEgOXSniBIEjMA5UkFxMd7rRWtZy7o9pzyfM2Q5Rsav9yOE99
	 lak4cE5XaGdVw==
Received: by homer.dodds.net (Postfix, from userid 1000)
	id EDEF815AE; Sun,  3 Mar 2024 00:00:56 -0800 (PST)
Date: Sun, 3 Mar 2024 00:00:56 -0800
From: Steve Langasek <vorlon@debian.org>
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
Message-ID: <ZeQuOBwQ2eSbkUAS@homer.dodds.net>
References: <20240216003252.29057-1-steve.langasek@canonical.com>
 <Zc6tzKPsYZRICHya@homer.dodds.net>
 <202402171351.439742DA@keescook>
 <ZdF0no51QNtKq8Ri@homer.dodds.net>
 <Zdrh/euXdvdWlVSp@homer.dodds.net>
 <CAJ2a_DeQFFgo+b6xf3_79bsfsvWeGWOephtgsJTK+RxJ7epG4Q@mail.gmail.com>
 <Zd2IcMMLagkTZGJp@homer.dodds.net>
 <CAJ2a_Df75EDn27iHSg=aAh0ZzRE40SqyanzRkfzv6ETmFiE8ug@mail.gmail.com>
 <Zd7OnevwfxbiJUVj@homer.dodds.net>
 <877cipc5d5.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/vr4ERt/ft61zB1M"
Content-Disposition: inline
In-Reply-To: <877cipc5d5.fsf@redhat.com>


--/vr4ERt/ft61zB1M
Content-Type: multipart/mixed; boundary="omVgPscJGG7ivw6x"
Content-Disposition: inline


--omVgPscJGG7ivw6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:20:22AM +0100, Petr Lautrbach wrote:
> Steve Langasek <vorlon@debian.org> writes:

> > Since all of your comments have been about the mechanics of the patch
> > landing, am I able to take it as agreed that libselinux will add a new =
entry
> > point of matchpathcon_filespec_add64@LIBSELINUX_3.6 in the next release=
, and
> > the rest is details?

> Technical detail: next release will be 3.7 therefore I'd expect
> matchpathcon_filespec_add64@LIBSELINUX_3.7

Ok, patch updated.
--=20
Steve Langasek                   Give me a lever long enough and a Free OS
Debian Developer                   to set it on, and I can move the world.
Ubuntu Developer                                   https://www.debian.org/
slangasek@ubuntu.com                                     vorlon@debian.org

--omVgPscJGG7ivw6x
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Always-build-for-LFS-mode-on-32-bit-archs.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 8f137ba1da9caadc4fafe4dc7c16b6a0e51eeb80 Mon Sep 17 00:00:00 2001
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
 libselinux/Makefile                  |  6 ++++++
 libselinux/include/selinux/selinux.h |  5 +++++
 libselinux/src/Makefile              |  2 ++
 libselinux/src/libselinux.map        |  5 +++++
 libselinux/src/matchpathcon.c        | 16 ++++++++++++++++
 libselinux/utils/Makefile            |  2 ++
 6 files changed, 36 insertions(+)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 6d9e2736..a50b6491 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -34,6 +34,12 @@ PCRE_CFLAGS +=3D $(shell $(PKG_CONFIG) --cflags $(PCRE_M=
ODULE))
 PCRE_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs $(PCRE_MODULE))
 export PCRE_MODULE PCRE_CFLAGS PCRE_LDLIBS
=20
+USE_LFS ?=3D y
+ifeq ($(USE_LFS),y)
+	LFS_CFLAGS :=3D -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64
+endif
+export LFS_CFLAGS
+
 OS :=3D $(shell uname)
 export OS
=20
diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/seli=
nux/selinux.h
index a0948853..080b486c 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -1,8 +1,10 @@
 #ifndef _SELINUX_H_
 #define _SELINUX_H_
=20
+#include <stdint.h>
 #include <sys/types.h>
 #include <stdarg.h>
+#include <asm/bitsperlong.h>
=20
 #ifdef __cplusplus
 extern "C" {
@@ -521,6 +523,9 @@ extern int matchpathcon_index(const char *path,
    with the same inode (e.g. due to multiple hard links).  If so, then
    use the latter of the two specifications based on their order in the=20
    file contexts configuration.  Return the used specification index. */
+#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PE=
R_LONG < 64
+#define matchpathcon_filespec_add matchpathcon_filespec_add64
+#endif
 extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *f=
ile);
=20
 /* Destroy any inode associations that have been added, e.g. to restart
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index d3b981fc..9580cce8 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -89,6 +89,8 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-sec=
urity -Winit-self -Wmissi
           -Werror -Wno-aggregate-return \
           $(EXTRA_CFLAGS)
=20
+override CFLAGS +=3D $(LFS_CFLAGS)
+
 LD_SONAME_FLAGS=3D-soname,$(LIBSO),--version-script=3Dlibselinux.map,-z,de=
fs,-z,relro
=20
 ifeq ($(OS), Darwin)
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index 5e00f45b..030d978e 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -252,3 +252,8 @@ LIBSELINUX_3.5 {
     getpidprevcon;
     getpidprevcon_raw;
 } LIBSELINUX_3.4;
+
+LIBSELINUX_3.7 {
+  global:
+    matchpathcon_filespec_add64;
+} LIBSELINUX_3.5;
diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index e44734c3..f8ee4b4b 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -261,6 +261,22 @@ int matchpathcon_filespec_add(ino_t ino, int specind, =
const char *file)
 	return -1;
 }
=20
+#if _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PER_LONG < 64
+/* alias defined in the public header but we undefine it here */
+#undef matchpathcon_filespec_add
+
+/* ABI backwards-compatible shim for non-LFS 32-bit systems */
+
+extern int matchpathcon_filespec_add(unsigned long ino, int specind,
+                                     const char *file);
+
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
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index f3cedc11..0d7095b1 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -36,6 +36,8 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-sec=
urity -Winit-self -Wmissi
           -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-over=
flow=3D5 \
           $(EXTRA_CFLAGS)
=20
+override CFLAGS +=3D $(LFS_CFLAGS)
+
 ifeq ($(OS), Darwin)
 override CFLAGS +=3D -I/opt/local/include -I../../libsepol/include
 override LDFLAGS +=3D -L../../libsepol/src -undefined dynamic_lookup
--=20
2.43.0


--omVgPscJGG7ivw6x--

--/vr4ERt/ft61zB1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErEg/aN5yj0PyIC/KVo0w8yGyEz0FAmXkLjIACgkQVo0w8yGy
Ez0lTBAAnhPj59sQcLygmD1jntww+I1OvK7CpHUi7CCnmUq3af/iMFO1zRu2pFeN
GscOVoI4EZdCwwU4wFVX19T4A5w9Ba72W50ylXU7FbmUiY+tuKy+tdQA3rLxttfo
VNUSo6B2Wrkw9JqU14qylLDseBB9Um4DzaqLkq5gAgg5OVgMP5DI7+u+/zpAgIZx
fZA2BICK19zE+pd3SqQSDyxkD5fUJQybvO/FNyr0Y1EPOujxdAVk8uL/XRDdvLoA
+ehlXjwSwMZ+SXIE5eVwBaaQhLqprRxqxLjK0zW3jJEnxOFjUruvRwMiQFD0K3/Z
1eVERvUE7jfLpVHijxSU5p1zXM0eeT8rxmHts8j2K00NFCqkNPdZePPrAFo923Pu
r+rgQodIMB6OEvkbDQE155oy8vxEerrt0WOJDssKdVyl/xA9/r3C4reV7if/H8OZ
RDKpR5t7gvh1Aclwffl3RJw//8+FdnP2n3tjbWT6HDlCBC904G+4qCvuuuHNbdg1
e0wxmwp8svzstT4YDhKGfMsYLElxklr+JRHa+Qvlw1RDck4EDSpLg5aB03PkZKUX
K1W/anaQeaqiaZ70ydLhfn0Y/T4llRsvEl531McH11EunOm1QJ15x4TY4q2xKEnm
szGHKo/8yS3+SdB7kYrkYCXbC9qv2AHmkGBgA/o14X44sqMcwYU=
=o6l/
-----END PGP SIGNATURE-----

--/vr4ERt/ft61zB1M--
