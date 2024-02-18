Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7337115C0
	for <selinux@vger.kernel.org>; Sun, 18 Feb 2024 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708225708; cv=none; b=PxqCsT2VBzTDOpy0xnzmlZcPNDmRDPZv7fxHDOSCTV1SUm7ogT51QcFIx3fNAVPbvv1LJc9Fwi2rhEzZerHwOikxI+NAblwW8I8s0ZkDcrGX4Re5iKy4Ct5vMMg1NEu5j7akzK2crlgQr/gI+aEecrKISgHbmQKiAogaJmnED1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708225708; c=relaxed/simple;
	bh=mS4De8VlLBQ0BP3Va/kEJkQONCO5/Dwit8HsxxmJ9Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swDZ5tix0CJptxRsI1/n9Ig+JpPWsuR+xCFZSaJE4cOwhzYTxGvnvmLhRS02NcjSw1W8RVYkLnf8b9alWVcL2hZlrsoC9qkyVaZmPDsnMK45tl6bL9FwRKdZuhrUJLXv3Q/w8DOhyiMTwnMPSTEfpVi1DFHQTpiEhgcW2dAlses=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=oCeEHcKy; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="oCeEHcKy"
Received: from homer.dodds.net (1.general.vorlon.us.vpn [10.172.64.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B799840EB1;
	Sun, 18 Feb 2024 03:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1708225697;
	bh=VqytLV67zEiewsFfN9/6ylOxkjo6b26a/R3GnH8ViVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=oCeEHcKyG9w3Lde2GAe/BMZv9kPw+8UASiP8ovOXvGFKfHt1+Kc5bNgETRxLanEUY
	 BUau39IWHdXVu211LI9p5x1QCGaxtl0Mb8sBsC6/HkvukXqzV90snRTF+Z+8DyYd3+
	 xVTfCfj1yMU1T53Se9GkIl2y9QV+HlJiuXqY8bfHoSWU80ihnT8HncZ4FYx461n3SX
	 j/J3QpER+lnPSSFiG4sriQMYLsLpqrS5AgLaUMHH9IZC+5rkRtWjQ+JqKpd4tKwy1S
	 VDFLxwX/3K7pEWZUFavhlgQxPc78Zp4+yreMxo6d0kGykF+DT/Sx+s0bZFbWaXkdxv
	 ks8ekb+GcQlbg==
Received: by homer.dodds.net (Postfix, from userid 1000)
	id B0AF21104; Sat, 17 Feb 2024 19:08:14 -0800 (PST)
Date: Sat, 17 Feb 2024 19:08:14 -0800
From: Steve Langasek <steve.langasek@canonical.com>
To: Kees Cook <keescook@chromium.org>
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
Message-ID: <ZdF0no51QNtKq8Ri@homer.dodds.net>
References: <20240216003252.29057-1-steve.langasek@canonical.com>
 <Zc6tzKPsYZRICHya@homer.dodds.net>
 <202402171351.439742DA@keescook>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rDYyGtdsdJaCalvT"
Content-Disposition: inline
In-Reply-To: <202402171351.439742DA@keescook>


--rDYyGtdsdJaCalvT
Content-Type: multipart/mixed; boundary="AdWj9Bovr3+GiSIj"
Content-Disposition: inline


--AdWj9Bovr3+GiSIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Sat, Feb 17, 2024 at 01:54:14PM -0800, Kees Cook wrote:
> On Thu, Feb 15, 2024 at 04:35:24PM -0800, Steve Langasek wrote:
> > index a0948853..78953870 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -1,6 +1,7 @@
> >  #ifndef _SELINUX_H_
> >  #define _SELINUX_H_
> > =20
> > +#include <stdint.h>
> >  #include <sys/types.h>
> >  #include <stdarg.h>
> > =20
> > @@ -521,7 +522,11 @@ extern int matchpathcon_index(const char *path,
> >     with the same inode (e.g. due to multiple hard links).  If so, then
> >     use the latter of the two specifications based on their order in th=
e=20
> >     file contexts configuration.  Return the used specification index. =
*/
> > -extern int matchpathcon_filespec_add(ino_t ino, int specind, const cha=
r *file);
> > +typedef uint64_t libselinux_ino_t;
> > +#if _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PER_LONG < 64
> > +#define matchpathcon_filespec_add matchpathcon_filespec_add64
> > +#endif
> > +extern int matchpathcon_filespec_add(libselinux_ino_t ino, int specind=
, const char *file);

> What's the ABI goal here? I think the type is wrong -- doesn't this need
> to be uint32_t not a uint64_t for the wrapper?

Thanks for the review!  The intent is that there are 3 cases:

- on 64-bit archs, matchpathcon_filespec_add64() is not defined because the
  ino_t passed to matchpathcon_filespec_add() is already 64-bit
- on 32-bit archs when LFS support is defined, references to
  matchpathcon_filespec_add() will be rewritten to
  matchpathcon_filespec_add64() because the ino_t argument passed to _add()
  is* 32-bit
- on 32-bit archs when LFS support is not defined, the existing
  matchpathcon_filespec_add() entry point should be used as-is.

And in the process of articulating this, I've come to recognize there was a
bug here, because in the case where our arch is 32-bit and our caller is NOT
being invoked with LFS build flags, we are exposing the previous
matchpathcon_filespec_add() but have wrongly modified the prototype here to
take a 64-bit ino_t.

I believe the attached revised patch corrects this.

--=20
Steve Langasek                   Give me a lever long enough and a Free OS
Debian Developer                   to set it on, and I can move the world.
Ubuntu Developer                                   https://www.debian.org/
slangasek@ubuntu.com                                     vorlon@debian.org

* may be.  There are some 32-bit archs defined in glibc/Linux that do not
  treat 32-bit time_t as an option and AIUI thus also have 64-bit ino_t; in
  which case the additional entry point is unnecessary but also of
  low impact.

--AdWj9Bovr3+GiSIj
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Always-build-for-LFS-mode-on-32-bit-archs.patch"
Content-Transfer-Encoding: quoted-printable

=46rom b23c9044b542b8807f57f4691f4bd1149cbee04c Mon Sep 17 00:00:00 2001
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
 libselinux/include/selinux/selinux.h | 11 ++++++++++-
 libselinux/src/Makefile              |  1 +
 libselinux/src/libselinux.map        |  1 +
 libselinux/src/matchpathcon.c        | 15 ++++++++++++++-
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/seli=
nux/selinux.h
index a0948853..040629c3 100644
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
@@ -521,7 +522,15 @@ extern int matchpathcon_index(const char *path,
    with the same inode (e.g. due to multiple hard links).  If so, then
    use the latter of the two specifications based on their order in the=20
    file contexts configuration.  Return the used specification index. */
-extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *f=
ile);
+#if _FILE_OFFSET_BITS =3D=3D 64
+typedef uint64_t libselinux_ino_t;
+#if __BITS_PER_LONG < 64
+#define matchpathcon_filespec_add matchpathcon_filespec_add64
+#endif
+#else
+typedef uint32_t libselinux_ino_t;
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


--AdWj9Bovr3+GiSIj--

--rDYyGtdsdJaCalvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErEg/aN5yj0PyIC/KVo0w8yGyEz0FAmXRdJcACgkQVo0w8yGy
Ez2RXg//dyu/zcp5xlLuh8SsXq6NX3Iv92KaZnF6bm4lEqzSAjncwp6eW3XnauAM
q8tBDaGWtbbMH2WUy9UcdbW9LU+/sU7CH+3lF8+7oV7IODSfZgEFsGw3GFH0ei6p
eMJ15IVutnSvDGtjcJPF1oAbXd97oBZycxqLwUtRy5wW/ncMG9KYVhYyZW4Y4whj
gtgWQ1pz+YzPZg3s/KgzUV8ffbcs7P07RYTiTVLpeVC3r0Eh9Z2aWEiX+uChVkD4
0k+IOuMUJhBYdEpzW3i83F05H4PsVoSJQTQMK8F+wlUtWzTR7/YeY4DpSZGdto+7
fb3YLMm49J55z5vqjsZWpJorDBSFgfCBm5GMzqOgvOUyH6MyMZeqDC3jM8AtROgl
/BBGXNyiQpnm5CkO3I7ZJOwJAJuY6pvK13O3nU9Q71CuulZhqVokgswybmIWEJ9a
2Opc+IgI1A/6e9sAn/tjbp8Z0X1MmmqTo9EdQRvS9uLnhW7f9LEArWkDsqrQDl2t
yycNF9pMWm4wA/gskRuBY7w23771EgMeooIwmZV15+NSOCi9QX3bV8kNPa0LvEJj
C+xvjinRbvYBRTrpRQS3rZuDE/tSDYqwqJy8pGTwV4LVCFmojPZaeKjANrrxE5bx
kdq8e1n+L2cQDat0KDhEICrhZUJb+Pm+/sfSNpcJKQCO4LtAu54=
=reFr
-----END PGP SIGNATURE-----

--rDYyGtdsdJaCalvT--
