Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68B1F9435
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467151; cv=none; b=FKv1kH6Qslk/ipDRyo299zSyXVOtVc/v2cxzxuX8VTYMb+vymwiJV65NCTfNU80qTYT1IdVD+qHPsskW6xD0jYljC9OxabGRqCGGfw3SzCKLQ3ijA4AJETgDUT0C021N9Dsh+S/J7CxwQIlZxMs4HqV3UkKZwA2a7nbMgoGMP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467151; c=relaxed/simple;
	bh=APqupLf13IsSY80e1uMT9RSuzG9nHYWl8cTmuGdTWlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXVHMHtMVb+3q3CS5nreLbThpIn4d2pn0MKGAcJ9fSrLeG2C2QLssuLPivJ9tV6fRVFPn49+4JMTf9PeGrAzY2WUCb8rO8qqSYckkynLb/t3eig1O1TG65VTkAWVxpjxIA8d0/bjRYmBbD0hkk7v90Pb0/v3CEvgJeZmpsigAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJ7uvJ7I; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ7uvJ7I"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4afd68271b6so1527857137.0
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 12:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734467149; x=1735071949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UshwavTrYWPO0f62sYwoOcD2MUups/g6Momx18KEIs=;
        b=RJ7uvJ7ItjrK0zJNahL7M1I3bAY6bWd1uL8w7a4kNSDztIr3ZGiq/brEzulFYDEmko
         8LLNJLuMppmOG8k8okrgLlCMRU4s+jHwlX2/nq8lfNLDcfj0oO1UmLCHMDDim3hlCLeN
         a6ZKWJFLDxLuiY8LMbDP7JP97eOXxv3ibhkn9lfADaSsAsJgKFtb5wxp15+GYRev6C2d
         pDgG04hQV1Pcn47N2BE72IhE4siuCeiDpBIs8qorxmcPDgN6dXkkUYfm+FSxkXWW46Th
         +2zJc+4u+eKmsYH6Ioq6talvfehSats6cmJOZMkDf4DPGawpUtIXOhwgP+OxlNhLJOMr
         /eKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734467149; x=1735071949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UshwavTrYWPO0f62sYwoOcD2MUups/g6Momx18KEIs=;
        b=WxQBJDlwNIGh8xDtoksAwPAemIX5CbrY0m7yNa4bohmgexkUgu2HkzUZOYJG5Cf1vo
         CyW4b6cg5UDdHUy+MzOqi9UQVrKLgQ+u764cLR3Jx9ocR67jxCwv6P3o0mEpDO2BTj2J
         +zvZ/ZIzCVt+ZrTfgrkSP+Ei8xqSv+e3IXYWemHolbKELqJ/pFeLLYS2PANH8U/psK+I
         sa/qJQnrah0kadeuRpA1ezF/joCuJOD5kwAOXD8sAbj4qAv4xmg1OoEEfAe3BWckVC6Y
         TkG20XPWON72tyB+wv5H5GjoAxme7mJmuuqYlbubFRprwyzvN/kQSPrg8zhkA1Qxypxs
         t5uA==
X-Gm-Message-State: AOJu0Yw4FPNAx1kMFfDpZbJs7Kgl4o0InM7E96eQIiNsmh/iNvxMPsv1
	gL1yeqigcmEHLrz8OymptrS62wz1PbQ3UqimWV/+zxhgpQm8rO647XVLLfJ80x3v6ppowYY/YNE
	PILEtIpTKYdKMLlPHSFT3MBzlQs4=
X-Gm-Gg: ASbGncsgrIDLTwN20ccSji56NR8hnLzXr/FfR7vB3LFM6StMtqTwpsXUXVjVwSQXZTi
	9waao3g2NMAodv+F8vIN/s84+nBtlLMPok4sofA==
X-Google-Smtp-Source: AGHT+IHh5LKBma0HDmxyvndPiKV4Rj211MORWf0CPYtbW1M1Ky6PeszhkbSOSL+ugcJh+b75j74Vg/+47e4nXk2fkss=
X-Received: by 2002:a05:6102:32ce:b0:4af:de39:c55 with SMTP id
 ada2fe7eead31-4b2ae87469cmr269144137.27.1734467148712; Tue, 17 Dec 2024
 12:25:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128165436.93649-1-cgoettsche@seltendoof.de> <CAP+JOzRcM0eO6aScd71ZRBs1Oaxoc0p_RB3-ZvHa7ir7yKDDuQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRcM0eO6aScd71ZRBs1Oaxoc0p_RB3-ZvHa7ir7yKDDuQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 17 Dec 2024 15:25:38 -0500
Message-ID: <CAP+JOzTo4Oaj+2V6fRws5EJZy5z383tFPJet2btk7bZDjNqUYg@mail.gmail.com>
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org, Steve Langasek <steve.langasek@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 4:26=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Nov 29, 2024 at 6:05=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Steve Langasek <steve.langasek@canonical.com>
> >
> > Maintains the type signature of the existing matchpathcon_filespec_add(=
)
> > entry point on 32-bit archs but maps the API to a new
> > matchpathcon_filespec_add64() entry point that takes a 64-bit ino_t arg=
ument
> > instead.
> >
> > Software on 32-bit Linux ports which historically use a 32-bit time_t (=
thus
> > affected by the y2038 problem) have, as a precondition of migrating to
> > 64-bit time_t, that they also migrate to large filesystem support becau=
se
> > glibc does not provide entry points for the cross-product of
> > (LFS: yes, LFS: no) x (time_t: 32, time_t: 64).
> >
> > In order to support smooth migration of such operating systems from 32-=
bit
> > time_t to 64-bit time_t, it is useful for libselinux to:
> >
> > - provide entry points on 32-bit systems for both LFS and non-LFS varia=
nts
> >   of the API (as glibc itself does)
> > - use LFS internally for all filesystem calls (just in case)
> > - map the API call to the correct implementation based on the build
> >   environment of the caller.
> >
> > Signed-off-by: Steve Langasek <steve.langasek@canonical.com>
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> > Originally posted https://lore.kernel.org/selinux/ZeQuOBwQ2eSbkUAS@home=
r.dodds.net/1.2-0001-Always-build-for-LFS-mode-on-32-bit-archs.patch
> >
> > v2:
> >  - Adjusted version in libselinux.map
> >  - check for __BITS_PER_LONG availability in matchpathcon.c similar to
> >    selinux.h
> >  - add static asserts, it's better to fail hard at compile time instead
> >    of having a silent ABI break
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/Makefile                  |  6 ++++++
> >  libselinux/include/selinux/selinux.h |  5 +++++
> >  libselinux/src/Makefile              |  2 ++
> >  libselinux/src/libselinux.map        |  5 +++++
> >  libselinux/src/matchpathcon.c        | 26 ++++++++++++++++++++++++++
> >  libselinux/utils/Makefile            |  2 ++
> >  6 files changed, 46 insertions(+)
> >
> > diff --git a/libselinux/Makefile b/libselinux/Makefile
> > index 6d9e2736..a50b6491 100644
> > --- a/libselinux/Makefile
> > +++ b/libselinux/Makefile
> > @@ -34,6 +34,12 @@ PCRE_CFLAGS +=3D $(shell $(PKG_CONFIG) --cflags $(PC=
RE_MODULE))
> >  PCRE_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs $(PCRE_MODULE))
> >  export PCRE_MODULE PCRE_CFLAGS PCRE_LDLIBS
> >
> > +USE_LFS ?=3D y
> > +ifeq ($(USE_LFS),y)
> > +       LFS_CFLAGS :=3D -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64
> > +endif
> > +export LFS_CFLAGS
> > +
> >  OS :=3D $(shell uname)
> >  export OS
> >
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/=
selinux/selinux.h
> > index 50419a7c..f3cf5a20 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -1,8 +1,10 @@
> >  #ifndef _SELINUX_H_
> >  #define _SELINUX_H_
> >
> > +#include <stdint.h>
> >  #include <sys/types.h>
> >  #include <stdarg.h>
> > +#include <asm/bitsperlong.h>
> >
> >  #ifdef __cplusplus
> >  extern "C" {
> > @@ -535,6 +537,9 @@ extern int matchpathcon_index(const char *path,
> >     with the same inode (e.g. due to multiple hard links).  If so, then
> >     use the latter of the two specifications based on their order in th=
e
> >     file contexts configuration.  Return the used specification index. =
*/
> > +#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BIT=
S_PER_LONG < 64
> > +#define matchpathcon_filespec_add matchpathcon_filespec_add64
> > +#endif
> >  extern int matchpathcon_filespec_add(ino_t ino, int specind, const cha=
r *file);
> >
> >  /* Destroy any inode associations that have been added, e.g. to restar=
t
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 41cfbdca..9909eb40 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -89,6 +89,8 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat=
-security -Winit-self -Wmissi
> >            -Werror -Wno-aggregate-return \
> >            $(EXTRA_CFLAGS)
> >
> > +override CFLAGS +=3D $(LFS_CFLAGS)
> > +
> >  LD_SONAME_FLAGS=3D-soname,$(LIBSO),--version-script=3Dlibselinux.map,-=
z,defs,-z,relro
> >
> >  ifeq ($(OS), Darwin)
> > diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.=
map
> > index 5e00f45b..02f5b761 100644
> > --- a/libselinux/src/libselinux.map
> > +++ b/libselinux/src/libselinux.map
> > @@ -252,3 +252,8 @@ LIBSELINUX_3.5 {
> >      getpidprevcon;
> >      getpidprevcon_raw;
> >  } LIBSELINUX_3.4;
> > +
> > +LIBSELINUX_3.8 {
> > +  global:
> > +    matchpathcon_filespec_add64;
> > +} LIBSELINUX_3.5;
> > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathco=
n.c
> > index 967520e4..15f9353d 100644
> > --- a/libselinux/src/matchpathcon.c
> > +++ b/libselinux/src/matchpathcon.c
> > @@ -1,3 +1,4 @@
> > +#include <assert.h>
> >  #include <sys/stat.h>
> >  #include <string.h>
> >  #include <errno.h>
> > @@ -261,6 +262,31 @@ int matchpathcon_filespec_add(ino_t ino, int speci=
nd, const char *file)
> >         return -1;
> >  }
> >
> > +#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BIT=
S_PER_LONG < 64
> > +/* alias defined in the public header but we undefine it here */
> > +#undef matchpathcon_filespec_add
> > +
> > +/* ABI backwards-compatible shim for non-LFS 32-bit systems */
> > +
> > +static_assert(sizeof(unsigned long) =3D=3D sizeof(__ino_t), "inode siz=
e mismatch");
> > +static_assert(sizeof(unsigned long) =3D=3D sizeof(uint32_t), "inode si=
ze mismatch");
> > +static_assert(sizeof(ino_t) =3D=3D sizeof(ino64_t), "inode size mismat=
ch");
> > +static_assert(sizeof(ino64_t) =3D=3D sizeof(uint64_t), "inode size mis=
match");
> > +
> > +extern int matchpathcon_filespec_add(unsigned long ino, int specind,
> > +                                     const char *file);
> > +
> > +int matchpathcon_filespec_add(unsigned long ino, int specind,
> > +                              const char *file)
> > +{
> > +       return matchpathcon_filespec_add64(ino, specind, file);
> > +}
> > +#else
> > +
> > +static_assert(sizeof(unsigned long) =3D=3D sizeof(ino_t), "inode size =
mismatch");
> > +
> > +#endif
> > +
> >  /*
> >   * Evaluate the association hash table distribution.
> >   */
> > diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
> > index f3cedc11..0d7095b1 100644
> > --- a/libselinux/utils/Makefile
> > +++ b/libselinux/utils/Makefile
> > @@ -36,6 +36,8 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat=
-security -Winit-self -Wmissi
> >            -Werror -Wno-aggregate-return -Wno-redundant-decls -Wstrict-=
overflow=3D5 \
> >            $(EXTRA_CFLAGS)
> >
> > +override CFLAGS +=3D $(LFS_CFLAGS)
> > +
> >  ifeq ($(OS), Darwin)
> >  override CFLAGS +=3D -I/opt/local/include -I../../libsepol/include
> >  override LDFLAGS +=3D -L../../libsepol/src -undefined dynamic_lookup
> > --
> > 2.45.2
> >
> >
