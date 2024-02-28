Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B65364C7
	for <selinux@vger.kernel.org>; Wed, 28 Feb 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112029; cv=none; b=jYWz1yh+7+av0Q7RGiJlgCZ3A8XIBOS4MWAfICBixVilxdkYKeu5KriZ0jqRgRURY/sBpN9skyYpzJW1QIZrMlIU+/TnUbtSVslDU4uObYDA0/Ps8q9XDlPzlIWWAm7ehUpTbmShbPLFqVco2CSlaPf4olcNb7ocvGu8kqvkCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112029; c=relaxed/simple;
	bh=wUryHteOIZ/Yklc11wt93u5bxop2vaC3MV6gG0a+JiA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GGDpp2KJTyNBnehPufy33CHyJK3RTEbfIuY4jfEhQWCmXf34LTB1AMRFVEjpk0hscxA0RdvMQTWG+lh2X551osjknY8un7s43LkcnNVchIC9HUxW7Fz7c6Zr7M/p+FpvGExz1hOPS1z1nFXdXuXpPZvKoaBFKncmblTohvz8Nd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0iI0Gcm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0iI0Gcm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709112025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ruhs/e7LO8urfpLQlwBjy5qPXTs5t9bZHuUQnqi0934=;
	b=Y0iI0GcmQWeaHaUUPhq8JfxQUBavSh25GryHZcBj611ZAjfOoYlpbof9deAfFquOFal581
	Z1tDc+L+OiLo06kLfT7ilvJZ2iL9XZk22MM/+Eha/nwjRNN98heO9g5MfG7aH6WBeTPHbP
	FB2OkWqa3O1W0jLoH/ASV/GrAmtHMv0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-NOQVdpvuNEegTyUxAODJNw-1; Wed,
 28 Feb 2024 04:20:24 -0500
X-MC-Unique: NOQVdpvuNEegTyUxAODJNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B4711C05AEA;
	Wed, 28 Feb 2024 09:20:23 +0000 (UTC)
Received: from localhost (unknown [10.45.224.176])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 39BFEAC17;
	Wed, 28 Feb 2024 09:20:23 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Steve Langasek <vorlon@debian.org>, Christian =?utf-8?Q?G=C3=B6ttsche?=
 <cgzones@googlemail.com>
Cc: James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
In-Reply-To: <Zd7OnevwfxbiJUVj@homer.dodds.net>
References: <20240216003252.29057-1-steve.langasek@canonical.com>
 <Zc6tzKPsYZRICHya@homer.dodds.net> <202402171351.439742DA@keescook>
 <ZdF0no51QNtKq8Ri@homer.dodds.net> <Zdrh/euXdvdWlVSp@homer.dodds.net>
 <CAJ2a_DeQFFgo+b6xf3_79bsfsvWeGWOephtgsJTK+RxJ7epG4Q@mail.gmail.com>
 <Zd2IcMMLagkTZGJp@homer.dodds.net>
 <CAJ2a_Df75EDn27iHSg=aAh0ZzRE40SqyanzRkfzv6ETmFiE8ug@mail.gmail.com>
 <Zd7OnevwfxbiJUVj@homer.dodds.net>
Date: Wed, 28 Feb 2024 10:20:22 +0100
Message-ID: <877cipc5d5.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Steve Langasek <vorlon@debian.org> writes:

> Thanks again for the feedback.
>
> Since you weren't cc:ed on my earlier email, I'd like to pull out my comm=
ent
> at the top of the thread:
>
>   As this problem has been discovered rather late in our transition proce=
ss, I
>   have a bit of a time crunch on my side which is not your problem, but I
>   would ask that whether or not the patch is ready to land, we reach a
>   consensus ASAP on:
>
>     - whether it is acceptable to introduce a new entry point for this on
>       32-bit architectures
>     - the name this new entry point should use (including symbol version)
>     - that it is acceptable to upstream that we proceed on implementing t=
his
>       at the distro level in advance of the patch landing upstream.
>
> Since all of your comments have been about the mechanics of the patch
> landing, am I able to take it as agreed that libselinux will add a new en=
try
> point of matchpathcon_filespec_add64@LIBSELINUX_3.6 in the next release, =
and
> the rest is details?

Technical detail: next release will be 3.7 therefore I'd expect
matchpathcon_filespec_add64@LIBSELINUX_3.7



> On Tue, Feb 27, 2024 at 06:13:47PM +0100, Christian G=C3=B6ttsche wrote:
>> On Tue, 27 Feb 2024 at 08:00, Steve Langasek <vorlon@debian.org> wrote:
>> >
>> > Thanks for the feedback.
>> >
>> > On Mon, Feb 26, 2024 at 06:52:10PM +0100, Christian G=C3=B6ttsche wrot=
e:
>> > > > > +#include <stdint.h>
>
>> > > I needed <asm/bitsperlong.h> aswell for __BITS_PER_LONG
>
>> > Can you tell me about the platform you were building on?  In my tests,=
 the
>> > code with this patch behaved as intended on Ubuntu 24.04 pre-release w=
ith
>> > glibc 2.38, on both armhf and amd64, with no additional includes requi=
red.
>
>> Debian sid.
>
> Ok.  https://codesearch.debian.net/search?q=3D%3Casm%2Fbitsperlong.h%3E&l=
iteral=3D1
> shows it's uncommon to include asm/bitsperlong directly from userspace
> packages, but not unprecedented, so I'll go ahead and make that change.
>
>> > > > > +#if _FILE_OFFSET_BITS =3D=3D 64
>
>> > > One should probably check for existence:
>
>> > > #if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64
>
>> > Should we not consider it an error if this is not defined?  I can't th=
ink of
>> > any reason why _FILE_OFFSET_BITS would legitimately be missing and in =
my
>> > view it's ambiguous what we should do in this circumstance.  Using the
>> > define without checking for existence first implicitly gives an error =
if
>> > it's missing.  If preferred, we could be explicit as in:
>> >
>> > #if !defined(_FILE_OFFSET_BITS)
>> > #error [...]
>> > #endif
>> > #if _FILE_OFFSET_BITS =3D=3D 64
>> > [...]
>
>> During my testing yesterday _FILE_OFFSET_BITS was not defined by
>> default (gcc-13/gcc-14/clang-18 on Debian sid).
>
> It occurs to me that I only did a test build of libselinux itself with th=
is
> change, and maybe you're trying to build other software against it and
> therefore running into the issue when including this public header.  Ok,
> 'defined &&' it is.
>
>> > > > > +typedef uint64_t libselinux_ino_t;
>> > > > > +#if __BITS_PER_LONG < 64
>> > > > > +#define matchpathcon_filespec_add matchpathcon_filespec_add64
>> > > > > +#endif
>> > > > > +#else
>> > > > > +typedef uint32_t libselinux_ino_t;
>> > > > > +#endif
>
>> > > Is the typedef libselinux_ino_t really necessary, isn't it always ju=
st
>> > > equal to ino_t?
>
>> > When _FILE_OFFSET_BITS =3D=3D 64, ino_t is a 64-bit type and we need to
>> > explicitly declare a 32-bit type for the compatibility interface.  From
>> > sys/stat.h:
>
>> > # ifndef __ino_t_defined
>> > #  ifndef __USE_FILE_OFFSET64
>> > typedef __ino_t ino_t;
>> > #  else
>> > typedef __ino64_t ino_t;
>> > #  endif
>> > #  define __ino_t_defined
>> > # endif
>
>> But isn't this the identical logic as for libselinux_ino_t?
>> If _FILE_OFFSET_BITS is defined to be 64 libselinux_ino_t is
>> typedef'ed to uint64_t and ino_t should also be a 64-bit integer.
>> If _FILE_OFFSET_BITS is not 64 libselinux_ino_t is typedef'ed to
>> uint32_t and ino_t should also be a 32-bit integer.
>
> You're right, I overlooked this when refactoring based on Kees's feedback=
 in
> <https://lore.kernel.org/selinux/Zdrh%2FeuXdvdWlVSp@homer.dodds.net/T/#m1=
d767f13e043e662555f6b8d8ddbffe033435d33>.
>
> We want the entry point exposed to the caller to always be the one using =
the
> same ino_t size as the rest of the calling code.  So there's no need for
> this extra typedef; fixed.
>
>> > > > > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
>> > > > > index d3b981fc..267291aa 100644
>> > > > > --- a/libselinux/src/Makefile
>> > > > > +++ b/libselinux/src/Makefile
>> > > > > @@ -87,6 +87,7 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -=
Wformat-security -Winit-self -Wmissi
>> > > > >            -fstack-protector-all --param=3Dssp-buffer-size=3D4 -=
fexceptions \
>> > > > >            -fasynchronous-unwind-tables -fdiagnostics-show-optio=
n \
>> > > > >            -Werror -Wno-aggregate-return \
>> > > > > +          -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64 \
>
>> > > This won't work if CFLAGS are customized during build (e.g. by dpkg).
>> > > Also utils/ is unaffected.
>> > > Maybe use something like:
>
>> > > libselinux/Makefile:
>
>> > > USE_LFS ?=3D y
>> > > export USE_LFS
>
>> > > libselinux/{src,utils}/Makefile:
>
>> > > ifeq ($(USE_LFS),y)
>> > >        override CFLAGS +=3D -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=
=3D64
>> > > endif
>
>> > Thanks, I'm happy to amend the patch to do that (but will wait to conv=
erge
>> > on the other points above before I resubmit).
>
> As an aside here, it doesn't actually matter if the utils are built with =
LFS
> support for this purpose; the point is to make sure the library isn't bro=
ken
> for callers, whether they have LFS enabled or not.  But as long as we're
> changing the library anyway to always be LFS-compatible, there's no harm =
in
> also turning it on for the utils.
>
> Attached an updated patch which I think addresses all your feedback.
>
> --=20
> Steve Langasek                   Give me a lever long enough and a Free OS
> Debian Developer                   to set it on, and I can move the world.
> Ubuntu Developer                                   https://www.debian.org/
> slangasek@ubuntu.com                                     vorlon@debian.org
> From fb2e5ecaa84a2bb3d9f1f3946968add62e0ce5df Mon Sep 17 00:00:00 2001
> From: Steve Langasek <steve.langasek@canonical.com>
> Date: Thu, 15 Feb 2024 15:22:45 -0800
> Subject: [PATCH] Always build for LFS mode on 32-bit archs.
>
> Maintains the type signature of the existing matchpathcon_filespec_add()
> entry point on 32-bit archs but maps the API to a new
> matchpathcon_filespec_add64() entry point that takes a 64-bit ino_t argum=
ent
> instead.
>
> Software on 32-bit Linux ports which historically use a 32-bit time_t (th=
us
> affected by the y2038 problem) have, as a precondition of migrating to
> 64-bit time_t, that they also migrate to large filesystem support because
> glibc does not provide entry points for the cross-product of
> (LFS: yes, LFS: no) x (time_t: 32, time_t: 64).
>
> In order to support smooth migration of such operating systems from 32-bit
> time_t to 64-bit time_t, it is useful for libselinux to:
>
> - provide entry points on 32-bit systems for both LFS and non-LFS variants
>   of the API (as glibc itself does)
> - use LFS internally for all filesystem calls (just in case)
> - map the API call to the correct implementation based on the build
>   environment of the caller.
>
> Signed-off-by: Steve Langasek <steve.langasek@canonical.com>
> ---
>  libselinux/Makefile                  |  6 ++++++
>  libselinux/include/selinux/selinux.h |  5 +++++
>  libselinux/src/Makefile              |  2 ++
>  libselinux/src/libselinux.map        |  5 +++++
>  libselinux/src/matchpathcon.c        | 16 ++++++++++++++++
>  libselinux/utils/Makefile            |  2 ++
>  6 files changed, 36 insertions(+)
>
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index 6d9e2736..a50b6491 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -34,6 +34,12 @@ PCRE_CFLAGS +=3D $(shell $(PKG_CONFIG) --cflags $(PCRE=
_MODULE))
>  PCRE_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs $(PCRE_MODULE))
>  export PCRE_MODULE PCRE_CFLAGS PCRE_LDLIBS
>=20=20
> +USE_LFS ?=3D y
> +ifeq ($(USE_LFS),y)
> +	LFS_CFLAGS :=3D -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64
> +endif
> +export LFS_CFLAGS
> +
>  OS :=3D $(shell uname)
>  export OS
>=20=20
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index a0948853..080b486c 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -1,8 +1,10 @@
>  #ifndef _SELINUX_H_
>  #define _SELINUX_H_
>=20=20
> +#include <stdint.h>
>  #include <sys/types.h>
>  #include <stdarg.h>
> +#include <asm/bitsperlong.h>
>=20=20
>  #ifdef __cplusplus
>  extern "C" {
> @@ -521,6 +523,9 @@ extern int matchpathcon_index(const char *path,
>     with the same inode (e.g. due to multiple hard links).  If so, then
>     use the latter of the two specifications based on their order in the=
=20
>     file contexts configuration.  Return the used specification index. */
> +#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_=
PER_LONG < 64
> +#define matchpathcon_filespec_add matchpathcon_filespec_add64
> +#endif
>  extern int matchpathcon_filespec_add(ino_t ino, int specind, const char =
*file);
>=20=20
>  /* Destroy any inode associations that have been added, e.g. to restart
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index d3b981fc..9580cce8 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -89,6 +89,8 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-s=
ecurity -Winit-self -Wmissi
>            -Werror -Wno-aggregate-return \
>            $(EXTRA_CFLAGS)
>=20=20
> +override CFLAGS +=3D $(LFS_CFLAGS)
> +
>  LD_SONAME_FLAGS=3D-soname,$(LIBSO),--version-script=3Dlibselinux.map,-z,=
defs,-z,relro
>=20=20
>  ifeq ($(OS), Darwin)
> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
> index 5e00f45b..5176c8a9 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map
> @@ -252,3 +252,8 @@ LIBSELINUX_3.5 {
>      getpidprevcon;
>      getpidprevcon_raw;
>  } LIBSELINUX_3.4;
> +
> +LIBSELINUX_3.6 {
> +  global:
> +    matchpathcon_filespec_add64;
> +} LIBSELINUX_3.5;
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
> index e44734c3..f8ee4b4b 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -261,6 +261,22 @@ int matchpathcon_filespec_add(ino_t ino, int specind=
, const char *file)
>  	return -1;
>  }
>=20=20
> +#if _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PER_LONG < 64
> +/* alias defined in the public header but we undefine it here */
> +#undef matchpathcon_filespec_add
> +
> +/* ABI backwards-compatible shim for non-LFS 32-bit systems */
> +
> +extern int matchpathcon_filespec_add(unsigned long ino, int specind,
> +                                     const char *file);
> +
> +int matchpathcon_filespec_add(unsigned long ino, int specind,
> +                              const char *file)
> +{
> +	return matchpathcon_filespec_add64(ino, specind, file);
> +}
> +#endif
> +
>  /*
>   * Evaluate the association hash table distribution.
>   */
> diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> index f3cedc11..0d7095b1 100644
> --- a/libselinux/utils/Makefile
> +++ b/libselinux/utils/Makefile
> @@ -36,6 +36,8 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-s=
ecurity -Winit-self -Wmissi
>            -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-ov=
erflow=3D5 \
>            $(EXTRA_CFLAGS)
>=20=20
> +override CFLAGS +=3D $(LFS_CFLAGS)
> +
>  ifeq ($(OS), Darwin)
>  override CFLAGS +=3D -I/opt/local/include -I../../libsepol/include
>  override LDFLAGS +=3D -L../../libsepol/src -undefined dynamic_lookup
> --=20
> 2.40.1

