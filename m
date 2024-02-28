Received: from becquer.dodds.net (becquer.dodds.net [207.224.24.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9537FA
	for <selinux@vger.kernel.org>; Wed, 28 Feb 2024 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.224.24.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100706; cv=none; b=p20qSvP5UeMg6RlK7oFj3gA7zFMQeNY3vGHmGEeiM9HK2WtDJhTARi11WZ8Dqbanik99q76eydHWH7EWVqiqQCFY0qQ8CE4n0hAf9xMB04P78eCsPpoKznFFm7xv5RCaqvNkTLuzDLExfIB4voUUfTr8GVGbLCl0jLw/qLOxNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100706; c=relaxed/simple;
	bh=zMRTGIriC4Ssw40wuC11IfFVn7ma5cWcle1cV9QN46Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9dqHFOmlqLz3A5hLTaasyfSXPFbB1AtYX0G6d1mj0ftB/meTzQk0dzd3swoaeLnXBcZgy5EdVBB+drDA9lBD5yeKI7c2blQXy0DMObQsJHlQHHDopKTgnA/6b3dkOKR9+8Mn84Lubft2Up1su7TBX2FUQF1zKPzTe/c92ViK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DQbG0Llg; arc=none smtp.client-ip=207.224.24.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DQbG0Llg"
Received: from homer.dodds.net (homer.local [192.168.15.41])
	by becquer.dodds.net (Postfix) with ESMTPSA id 53F8A24FE3;
	Tue, 27 Feb 2024 22:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
	s=debian1.vorlon.user; t=1709100702;
	bh=zMRTGIriC4Ssw40wuC11IfFVn7ma5cWcle1cV9QN46Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQbG0Llgcajv2DS+eC0sga2m7n1WgjOuO1nqq10HKbF3990uWRn0skO19+hbnAGvg
	 CNpFk0xvrZrpYgF6p1jykTecgfMAGV3UmL9thJNXHzJTFrwyYuAQHYd7aW4Mdi8QOb
	 TYrjrB3ftF/1Hptzv6iapYyTN75TWZLeYX7X7lziBs/saLu1NEYXWGdc7ali2vWmYa
	 2+MYB8P/zWLvO0WmDbdjM0e8ygmtISGun2jRhnDVHgomzKViFbQ4Sz5BWwdLEO4gtU
	 iIv3amSJcz1VjU8FZ8Hb0rMVEPFVBdOxz7wJBQretcNCnpY73C4lvCHvReARuxypqW
	 dnphjec0qXdWQ==
Received: by homer.dodds.net (Postfix, from userid 1000)
	id AD8F411EC; Tue, 27 Feb 2024 22:11:41 -0800 (PST)
Date: Tue, 27 Feb 2024 22:11:41 -0800
From: Steve Langasek <vorlon@debian.org>
To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
Message-ID: <Zd7OnevwfxbiJUVj@homer.dodds.net>
References: <20240216003252.29057-1-steve.langasek@canonical.com>
 <Zc6tzKPsYZRICHya@homer.dodds.net>
 <202402171351.439742DA@keescook>
 <ZdF0no51QNtKq8Ri@homer.dodds.net>
 <Zdrh/euXdvdWlVSp@homer.dodds.net>
 <CAJ2a_DeQFFgo+b6xf3_79bsfsvWeGWOephtgsJTK+RxJ7epG4Q@mail.gmail.com>
 <Zd2IcMMLagkTZGJp@homer.dodds.net>
 <CAJ2a_Df75EDn27iHSg=aAh0ZzRE40SqyanzRkfzv6ETmFiE8ug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F81p6YUVvyDMgap3"
Content-Disposition: inline
In-Reply-To: <CAJ2a_Df75EDn27iHSg=aAh0ZzRE40SqyanzRkfzv6ETmFiE8ug@mail.gmail.com>


--F81p6YUVvyDMgap3
Content-Type: multipart/mixed; boundary="Ri1iLKKMOv2lA8yr"
Content-Disposition: inline


--Ri1iLKKMOv2lA8yr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks again for the feedback.

Since you weren't cc:ed on my earlier email, I'd like to pull out my comment
at the top of the thread:

  As this problem has been discovered rather late in our transition process=
, I
  have a bit of a time crunch on my side which is not your problem, but I
  would ask that whether or not the patch is ready to land, we reach a
  consensus ASAP on:

    - whether it is acceptable to introduce a new entry point for this on
      32-bit architectures
    - the name this new entry point should use (including symbol version)
    - that it is acceptable to upstream that we proceed on implementing this
      at the distro level in advance of the patch landing upstream.

Since all of your comments have been about the mechanics of the patch
landing, am I able to take it as agreed that libselinux will add a new entry
point of matchpathcon_filespec_add64@LIBSELINUX_3.6 in the next release, and
the rest is details?

On Tue, Feb 27, 2024 at 06:13:47PM +0100, Christian G=F6ttsche wrote:
> On Tue, 27 Feb 2024 at 08:00, Steve Langasek <vorlon@debian.org> wrote:
> >
> > Thanks for the feedback.
> >
> > On Mon, Feb 26, 2024 at 06:52:10PM +0100, Christian G=F6ttsche wrote:
> > > > > +#include <stdint.h>

> > > I needed <asm/bitsperlong.h> aswell for __BITS_PER_LONG

> > Can you tell me about the platform you were building on?  In my tests, =
the
> > code with this patch behaved as intended on Ubuntu 24.04 pre-release wi=
th
> > glibc 2.38, on both armhf and amd64, with no additional includes requir=
ed.

> Debian sid.

Ok.  https://codesearch.debian.net/search?q=3D%3Casm%2Fbitsperlong.h%3E&lit=
eral=3D1
shows it's uncommon to include asm/bitsperlong directly from userspace
packages, but not unprecedented, so I'll go ahead and make that change.

> > > > > +#if _FILE_OFFSET_BITS =3D=3D 64

> > > One should probably check for existence:

> > > #if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64

> > Should we not consider it an error if this is not defined?  I can't thi=
nk of
> > any reason why _FILE_OFFSET_BITS would legitimately be missing and in my
> > view it's ambiguous what we should do in this circumstance.  Using the
> > define without checking for existence first implicitly gives an error if
> > it's missing.  If preferred, we could be explicit as in:
> >
> > #if !defined(_FILE_OFFSET_BITS)
> > #error [...]
> > #endif
> > #if _FILE_OFFSET_BITS =3D=3D 64
> > [...]

> During my testing yesterday _FILE_OFFSET_BITS was not defined by
> default (gcc-13/gcc-14/clang-18 on Debian sid).

It occurs to me that I only did a test build of libselinux itself with this
change, and maybe you're trying to build other software against it and
therefore running into the issue when including this public header.  Ok,
'defined &&' it is.

> > > > > +typedef uint64_t libselinux_ino_t;
> > > > > +#if __BITS_PER_LONG < 64
> > > > > +#define matchpathcon_filespec_add matchpathcon_filespec_add64
> > > > > +#endif
> > > > > +#else
> > > > > +typedef uint32_t libselinux_ino_t;
> > > > > +#endif

> > > Is the typedef libselinux_ino_t really necessary, isn't it always just
> > > equal to ino_t?

> > When _FILE_OFFSET_BITS =3D=3D 64, ino_t is a 64-bit type and we need to
> > explicitly declare a 32-bit type for the compatibility interface.  From
> > sys/stat.h:

> > # ifndef __ino_t_defined
> > #  ifndef __USE_FILE_OFFSET64
> > typedef __ino_t ino_t;
> > #  else
> > typedef __ino64_t ino_t;
> > #  endif
> > #  define __ino_t_defined
> > # endif

> But isn't this the identical logic as for libselinux_ino_t?
> If _FILE_OFFSET_BITS is defined to be 64 libselinux_ino_t is
> typedef'ed to uint64_t and ino_t should also be a 64-bit integer.
> If _FILE_OFFSET_BITS is not 64 libselinux_ino_t is typedef'ed to
> uint32_t and ino_t should also be a 32-bit integer.

You're right, I overlooked this when refactoring based on Kees's feedback in
<https://lore.kernel.org/selinux/Zdrh%2FeuXdvdWlVSp@homer.dodds.net/T/#m1d7=
67f13e043e662555f6b8d8ddbffe033435d33>.

We want the entry point exposed to the caller to always be the one using the
same ino_t size as the rest of the calling code.  So there's no need for
this extra typedef; fixed.

> > > > > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > > > index d3b981fc..267291aa 100644
> > > > > --- a/libselinux/src/Makefile
> > > > > +++ b/libselinux/src/Makefile
> > > > > @@ -87,6 +87,7 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -W=
format-security -Winit-self -Wmissi
> > > > >            -fstack-protector-all --param=3Dssp-buffer-size=3D4 -f=
exceptions \
> > > > >            -fasynchronous-unwind-tables -fdiagnostics-show-option=
 \
> > > > >            -Werror -Wno-aggregate-return \
> > > > > +          -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64 \

> > > This won't work if CFLAGS are customized during build (e.g. by dpkg).
> > > Also utils/ is unaffected.
> > > Maybe use something like:

> > > libselinux/Makefile:

> > > USE_LFS ?=3D y
> > > export USE_LFS

> > > libselinux/{src,utils}/Makefile:

> > > ifeq ($(USE_LFS),y)
> > >        override CFLAGS +=3D -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=
=3D64
> > > endif

> > Thanks, I'm happy to amend the patch to do that (but will wait to conve=
rge
> > on the other points above before I resubmit).

As an aside here, it doesn't actually matter if the utils are built with LFS
support for this purpose; the point is to make sure the library isn't broken
for callers, whether they have LFS enabled or not.  But as long as we're
changing the library anyway to always be LFS-compatible, there's no harm in
also turning it on for the utils.

Attached an updated patch which I think addresses all your feedback.

--=20
Steve Langasek                   Give me a lever long enough and a Free OS
Debian Developer                   to set it on, and I can move the world.
Ubuntu Developer                                   https://www.debian.org/
slangasek@ubuntu.com                                     vorlon@debian.org

--Ri1iLKKMOv2lA8yr
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Always-build-for-LFS-mode-on-32-bit-archs.patch"
Content-Transfer-Encoding: quoted-printable

=46rom fb2e5ecaa84a2bb3d9f1f3946968add62e0ce5df Mon Sep 17 00:00:00 2001
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
index 5e00f45b..5176c8a9 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -252,3 +252,8 @@ LIBSELINUX_3.5 {
     getpidprevcon;
     getpidprevcon_raw;
 } LIBSELINUX_3.4;
+
+LIBSELINUX_3.6 {
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
2.40.1


--Ri1iLKKMOv2lA8yr--

--F81p6YUVvyDMgap3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErEg/aN5yj0PyIC/KVo0w8yGyEz0FAmXezpUACgkQVo0w8yGy
Ez2ggQ/+MVSKfoEZxb1HTq89jrgEq8gnkcbOFU6ez8Yly+boFlV9Lyl17QoKSlcQ
CCR2gv7DusxfwpXCaD8Z+g9GMYgNFcwhHeHDZ3TB5uQo62Rw7fDh6t6v0Qg0l8ZN
FpQSSXT8wdziSZGowh2iluH9CNSLjXgOuh7ypLovDiwQSFkkmSqoQu4OG9pfcdgK
nH1SJ81vOvc0Yyt5Qy+oatrYCzxh65ZLDbLI5UsCa/wJv18mCBEff+eb/IVOubMj
Dq6jFy+l0Wn3Ac4sXZw10QsFlgboWW6r0Qj1RiTKWvpaEC5hj4SCkXCwzPlSQ6D8
XF2i+G4RGTN5C5AGcE7xfSzUGHt244knu/vQgVim5z6NbMyCDRc3JXQEsVNL/c9K
Or18FZC3i9y7yd4pGWyWLZvwNgWsYAQEj5HQSUDh7e7HboI8sX5NdzO4t4/lpkUG
YFJUQk4aOnzCIGjUvoW3BllNqent5UMJbHZlF7/TbJPXrx6cCl3g+DYja0eblRjt
1PIfsROfBZCNZ6YiT02Osu5LWSy0zTo+nQJgzPItcdR+fkF6LC8Beq5Xn7LGfTar
i9EvdD9V2zSxTvhHVpH3PBrQQPohKgO2bK73QdE6PLX871bYsJ42J/jNttIDKkhm
Se6MY06ehU2QFHeTf81UKe1zfgtVIC9xskpSSyK9KAersK703Lg=
=FIvx
-----END PGP SIGNATURE-----

--F81p6YUVvyDMgap3--
