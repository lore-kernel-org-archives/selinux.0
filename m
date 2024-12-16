Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948D1B9831
	for <selinux@vger.kernel.org>; Mon, 16 Dec 2024 21:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384376; cv=none; b=URd15KUqYdDkEolNxq2/nYDv4o5r+abtSBLNjDKIPWu9Jzmi25jLxtyAFsLjfTGMFqjcn6Cpo47IhDhwW71gnekb0ppGaV0G5XEXRsN7ruOegJ20Q3b/EiLQXIHfiYGeH31LKELo97sx0zcyk6ZJPKfgStZiKmgXsPSCR42AJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384376; c=relaxed/simple;
	bh=teQiS7clX9YMArbC/ly1ecWgdx8G9JrLT5xQAOhsPDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bL1haWo2JvSJEHQ8wfWIFYmEaEoPnafsZGIz5NMLq34BycHiIvMDXerBHeRqhfNcNTafNq3DGrzPt0eAp1KAijk6dkXTajVzbaaI7EvS4VUSMgVSYVjkJe2FUPWbhtIn17WGpzEfbxdJ8xhhunrfis83tTjqKoPW0wuBWLJSoOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUNoVOpg; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUNoVOpg"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afdf096fc5so1023813137.2
        for <selinux@vger.kernel.org>; Mon, 16 Dec 2024 13:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734384373; x=1734989173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxGPSjjbFmOzC+b2WCD+RVOiMb0SQjbQM7xlH/cpJyk=;
        b=dUNoVOpgxfaB82tSp4pKXV+JvX7eqy1RaO4MDvko2v9FPjPljquBXUWy2+SzO9FnnY
         luEQLsWg4Yg5nFYUbo8HB4a2pTunVKCH7r/CetfhUhDCWBMOj+kxnhbgu6OtTDJ4IqzF
         xY1v9VZ/fDSCo3nGh9VC65Uk6TTYt4WS6Xz4+4rIhvsT+B0wXfdLjmxEhMrGk9/ITq9F
         89LHLoD+qz76BFaR+Fm/Z8Wn3PZqKNKYy+lsgB9QXFaPCWR8VoEE0nx4ZOV+1fxYLY7F
         j/9/QV3GI242TW2t97ewio7rA6gp65EqVVRmn53T9p4SyngGACLyt6JkEJ8wWrpnoa1+
         c5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734384373; x=1734989173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxGPSjjbFmOzC+b2WCD+RVOiMb0SQjbQM7xlH/cpJyk=;
        b=MpmDR+lfExujwi0+7n5QZyB1iJiAmhhHpqvHxRwbC2DdCpF8mmL6qtxA3noMVp2lhA
         MjMvTBa6jnlbBvXsjAnZTV3WmQBJ+G6S3sklDDaLrB4u70GX2NHHBuhuEOVdHY9rstYs
         CuOFt14q4zXKhxTF1FXTVk5zhai/9EbDw9wrJPD66AuFyapHjZpwKyz8l3S2Y+vq/Pa9
         I4CoK2fq9M2dtM1oLsO/wbRtpn3OLr2erfzuFwb6vlL4ncJca08hLTcHGWU9mxXpLtvE
         Sg1gitY4So62T16NL36JQGbW5Lmbws8JCtxsToMGWO7H9gnzqZjaS7iM2ZWtjF2QihTq
         TRbQ==
X-Gm-Message-State: AOJu0YwRV0fnjaq9GMBdgI8s2o1uD+iTmO2rR6BiJy7BM/XgQUxJiVoD
	y5+scRjXcYnoN3vc0PE1IgpOHqN6Vm1uzqMKnx9sKVb5FfE4f9jFKOWWvi9QX3RTDTikhFLHmwm
	8ibliElniZsN6/mCMPtwnMfPkAxs=
X-Gm-Gg: ASbGncswaaXY6sDr964wPYgDdjw3YdMNv7Ea0WYQ4aZi3AbZAZ9Gk4G7p/zwUhPUilM
	v8JIWKUWjS0FZS3hG58DKRJt+5bSF+b7w5Q961A==
X-Google-Smtp-Source: AGHT+IHNoW0umoFce7p/nMo+BRJv4VmnsEBYxgd1w/4OQfVveR0+EGlCAGY/fbUuq2QilMiLFTeiiCZUymRqiSyHysQ=
X-Received: by 2002:a05:6102:8099:b0:4af:5f65:4fd3 with SMTP id
 ada2fe7eead31-4b25d96b9e9mr14401405137.6.1734384373267; Mon, 16 Dec 2024
 13:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128165436.93649-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241128165436.93649-1-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 16 Dec 2024 16:26:02 -0500
Message-ID: <CAP+JOzRcM0eO6aScd71ZRBs1Oaxoc0p_RB3-ZvHa7ir7yKDDuQ@mail.gmail.com>
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Steve Langasek <steve.langasek@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 6:05=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Steve Langasek <steve.langasek@canonical.com>
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
> In order to support smooth migration of such operating systems from 32-bi=
t
> time_t to 64-bit time_t, it is useful for libselinux to:
>
> - provide entry points on 32-bit systems for both LFS and non-LFS variant=
s
>   of the API (as glibc itself does)
> - use LFS internally for all filesystem calls (just in case)
> - map the API call to the correct implementation based on the build
>   environment of the caller.
>
> Signed-off-by: Steve Langasek <steve.langasek@canonical.com>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> Originally posted https://lore.kernel.org/selinux/ZeQuOBwQ2eSbkUAS@homer.=
dodds.net/1.2-0001-Always-build-for-LFS-mode-on-32-bit-archs.patch
>
> v2:
>  - Adjusted version in libselinux.map
>  - check for __BITS_PER_LONG availability in matchpathcon.c similar to
>    selinux.h
>  - add static asserts, it's better to fail hard at compile time instead
>    of having a silent ABI break
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/Makefile                  |  6 ++++++
>  libselinux/include/selinux/selinux.h |  5 +++++
>  libselinux/src/Makefile              |  2 ++
>  libselinux/src/libselinux.map        |  5 +++++
>  libselinux/src/matchpathcon.c        | 26 ++++++++++++++++++++++++++
>  libselinux/utils/Makefile            |  2 ++
>  6 files changed, 46 insertions(+)
>
> diff --git a/libselinux/Makefile b/libselinux/Makefile
> index 6d9e2736..a50b6491 100644
> --- a/libselinux/Makefile
> +++ b/libselinux/Makefile
> @@ -34,6 +34,12 @@ PCRE_CFLAGS +=3D $(shell $(PKG_CONFIG) --cflags $(PCRE=
_MODULE))
>  PCRE_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs $(PCRE_MODULE))
>  export PCRE_MODULE PCRE_CFLAGS PCRE_LDLIBS
>
> +USE_LFS ?=3D y
> +ifeq ($(USE_LFS),y)
> +       LFS_CFLAGS :=3D -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64
> +endif
> +export LFS_CFLAGS
> +
>  OS :=3D $(shell uname)
>  export OS
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index 50419a7c..f3cf5a20 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -1,8 +1,10 @@
>  #ifndef _SELINUX_H_
>  #define _SELINUX_H_
>
> +#include <stdint.h>
>  #include <sys/types.h>
>  #include <stdarg.h>
> +#include <asm/bitsperlong.h>
>
>  #ifdef __cplusplus
>  extern "C" {
> @@ -535,6 +537,9 @@ extern int matchpathcon_index(const char *path,
>     with the same inode (e.g. due to multiple hard links).  If so, then
>     use the latter of the two specifications based on their order in the
>     file contexts configuration.  Return the used specification index. */
> +#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_=
PER_LONG < 64
> +#define matchpathcon_filespec_add matchpathcon_filespec_add64
> +#endif
>  extern int matchpathcon_filespec_add(ino_t ino, int specind, const char =
*file);
>
>  /* Destroy any inode associations that have been added, e.g. to restart
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 41cfbdca..9909eb40 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -89,6 +89,8 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-s=
ecurity -Winit-self -Wmissi
>            -Werror -Wno-aggregate-return \
>            $(EXTRA_CFLAGS)
>
> +override CFLAGS +=3D $(LFS_CFLAGS)
> +
>  LD_SONAME_FLAGS=3D-soname,$(LIBSO),--version-script=3Dlibselinux.map,-z,=
defs,-z,relro
>
>  ifeq ($(OS), Darwin)
> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.ma=
p
> index 5e00f45b..02f5b761 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map
> @@ -252,3 +252,8 @@ LIBSELINUX_3.5 {
>      getpidprevcon;
>      getpidprevcon_raw;
>  } LIBSELINUX_3.4;
> +
> +LIBSELINUX_3.8 {
> +  global:
> +    matchpathcon_filespec_add64;
> +} LIBSELINUX_3.5;
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.=
c
> index 967520e4..15f9353d 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -1,3 +1,4 @@
> +#include <assert.h>
>  #include <sys/stat.h>
>  #include <string.h>
>  #include <errno.h>
> @@ -261,6 +262,31 @@ int matchpathcon_filespec_add(ino_t ino, int specind=
, const char *file)
>         return -1;
>  }
>
> +#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BITS_=
PER_LONG < 64
> +/* alias defined in the public header but we undefine it here */
> +#undef matchpathcon_filespec_add
> +
> +/* ABI backwards-compatible shim for non-LFS 32-bit systems */
> +
> +static_assert(sizeof(unsigned long) =3D=3D sizeof(__ino_t), "inode size =
mismatch");
> +static_assert(sizeof(unsigned long) =3D=3D sizeof(uint32_t), "inode size=
 mismatch");
> +static_assert(sizeof(ino_t) =3D=3D sizeof(ino64_t), "inode size mismatch=
");
> +static_assert(sizeof(ino64_t) =3D=3D sizeof(uint64_t), "inode size misma=
tch");
> +
> +extern int matchpathcon_filespec_add(unsigned long ino, int specind,
> +                                     const char *file);
> +
> +int matchpathcon_filespec_add(unsigned long ino, int specind,
> +                              const char *file)
> +{
> +       return matchpathcon_filespec_add64(ino, specind, file);
> +}
> +#else
> +
> +static_assert(sizeof(unsigned long) =3D=3D sizeof(ino_t), "inode size mi=
smatch");
> +
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
>
> +override CFLAGS +=3D $(LFS_CFLAGS)
> +
>  ifeq ($(OS), Darwin)
>  override CFLAGS +=3D -I/opt/local/include -I../../libsepol/include
>  override LDFLAGS +=3D -L../../libsepol/src -undefined dynamic_lookup
> --
> 2.45.2
>
>
