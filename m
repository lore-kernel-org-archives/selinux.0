Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20F12B167
	for <selinux@vger.kernel.org>; Mon, 26 Feb 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969944; cv=none; b=OGdsTS4fYYWT1D7gGWw7Y1orrAk981Rv5Nj7WUtbnKPCbc4ffNktAAUlcsRa4JYhnkyfkMenTQCA9J3GkrAw1FzN8Sfp2GeEp7fbKbvTAmCVgJ/L582AGrg46rju2bgNeAiuCWv/9ZDtQqUnGnNphzAS45yzemZ4a2AKhWjGrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969944; c=relaxed/simple;
	bh=qOjaIoAn7rhfXijfP7X7TjfAqHJ1v+xwgD2w5LN/svE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PK+rFMunDPhQVuPp2gGMgisBve5Fz3QWyem8MopgK0itN39uCCS8IJG9nqetZKNSXPvmzyrzy/XPa4rwlQRHVPKc5CYNwM7R9rrYnbOOwQ+6CrMLb6uOvLEVjLh4S+HFtA9HBSpCDT1uSu7U9XiSxG7ifR4/OHWgb1VYYebHt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Ai8ZCFsZ; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ai8ZCFsZ"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6091e12b01fso4473837b3.2
        for <selinux@vger.kernel.org>; Mon, 26 Feb 2024 09:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1708969941; x=1709574741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VTyOMDg4C+qDvCcgquOeWy9jAsfHsOMh08YM7YSq6SI=;
        b=Ai8ZCFsZvCngKQDyD/QdBlQ1aMEysniSOmXUwBcEZKpT8gnXqWdMz7EXz31hlYPJft
         ZI2vyV9uxLQ4K8FCXRNnjH64gJSIxJUmhKhPT/Ximqngn1i203Kp6Rbh26gpr4taJwch
         V9TstJMKdM4xhnQ0Azr+/xTAijYCETidO6reHmVvXuCaRyHgTBzQyE3jJym11KyLI+kB
         lLbGn6Gmlh5S0qDtF7Jwjqf2PSVP+kMseGvRQGEx9ZsewdBWQ2zXN3tFZdby8oo4aHgQ
         mRsCjdaLVioBdaB9BkvLVTtKjI0aRvKHbUd/Ge/NGWosFnfxmhdk2+f9oELnF5ki8z2Y
         D9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708969941; x=1709574741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTyOMDg4C+qDvCcgquOeWy9jAsfHsOMh08YM7YSq6SI=;
        b=hWFLJL0wpfvQbMdLIB632mysp7ixnv3LjBkS0Yh4I/PlT07lFbWTx2BOGRHfrZI2cJ
         gk0KGn3BFJWpCZE9kkRcDQXheNxMvmZoxeNHTw4HkSJAOdg6+J4lnlTsrM6D0la0O+k1
         UJZywM7RRxstPKsXkNlxqyWzZp/9RmN/DFHwA6LGMroOabBNX1m/XKPOhCACkizT38Y5
         g+kHF3Sy4KDFNXRHxt7mRMZAfL8apXsFm80+61SRIlA5lWgCN8sQbDMo48Q9OO+JNH12
         Q7MVCCLphi12zwmNJBlNcEy9MOcb84bh3mAusVGjsfkLJ6Ramg3xyJmJkS159/BIDgy3
         QG4g==
X-Forwarded-Encrypted: i=1; AJvYcCXLR8hzX5XCjCrLCzSBKV/ZLYnqxPwlm6t/C4RYKhg5BbeHiK1gcjYmQ5wlCVloxRyQ4KyDjsm3R4amIzxZxPwvMurdBgMKSg==
X-Gm-Message-State: AOJu0YxGCMXb614um0xzwJvEt+GDEI9QgEXWCHhECrQh4Vy5TBOkE9kb
	b30EqepmagGpD60/aS8RSYK8wYTjJDr1WMcDRgysySRCUb8DtAWrBU4+GeAIKLZWB8PJ5QlGGEk
	JF84sjK4QUsjGY8Z/oGyQuHGD5CU=
X-Google-Smtp-Source: AGHT+IHMS3TJOpx4CyXsO7nrObfFjud+HdsQOIOQFh/3KtOn3p3Kd2qbZzHOY4pFcmOwzRG0pkm79PuZSpjRdaDKTH8=
X-Received: by 2002:a81:af67:0:b0:608:ba29:9a46 with SMTP id
 x39-20020a81af67000000b00608ba299a46mr6371371ywj.12.1708969941579; Mon, 26
 Feb 2024 09:52:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216003252.29057-1-steve.langasek@canonical.com>
 <Zc6tzKPsYZRICHya@homer.dodds.net> <202402171351.439742DA@keescook>
 <ZdF0no51QNtKq8Ri@homer.dodds.net> <Zdrh/euXdvdWlVSp@homer.dodds.net>
In-Reply-To: <Zdrh/euXdvdWlVSp@homer.dodds.net>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 26 Feb 2024 18:52:10 +0100
Message-ID: <CAJ2a_DeQFFgo+b6xf3_79bsfsvWeGWOephtgsJTK+RxJ7epG4Q@mail.gmail.com>
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
To: Steve Langasek <vorlon@debian.org>
Cc: James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 Feb 2024 at 07:45, Steve Langasek <vorlon@debian.org> wrote:
>
> Hi,
>
> Adding James and Christian directly to the email, as frequent contributors
> to libselinux, for visibility.
>
> Debian and Ubuntu are going to have to do something with libselinux within
> the week, and I'd greatly prefer that the "something" not be breaking ABI
> compatibility with upstream.
>
> Thanks,
> --
> Steve Langasek                   Give me a lever long enough and a Free OS
> Debian Developer                   to set it on, and I can move the world.
> Ubuntu Developer                                   https://www.debian.org/
> slangasek@ubuntu.com                                     vorlon@debian.org
>
> On Sat, Feb 17, 2024 at 07:08:14PM -0800, Steve Langasek wrote:
> > From b23c9044b542b8807f57f4691f4bd1149cbee04c Mon Sep 17 00:00:00 2001
> > From: Steve Langasek <steve.langasek@canonical.com>
> > Date: Thu, 15 Feb 2024 15:22:45 -0800
> > Subject: [PATCH] Always build for LFS mode on 32-bit archs.
> >
> > Maintains the type signature of the existing matchpathcon_filespec_add()
> > entry point on 32-bit archs but maps the API to a new
> > matchpathcon_filespec_add64() entry point that takes a 64-bit ino_t argument
> > instead.
> >
> > Software on 32-bit Linux ports which historically use a 32-bit time_t (thus
> > affected by the y2038 problem) have, as a precondition of migrating to
> > 64-bit time_t, that they also migrate to large filesystem support because
> > glibc does not provide entry points for the cross-product of
> > (LFS: yes, LFS: no) x (time_t: 32, time_t: 64).
> >
> > In order to support smooth migration of such operating systems from 32-bit
> > time_t to 64-bit time_t, it is useful for libselinux to:
> >
> > - provide entry points on 32-bit systems for both LFS and non-LFS variants
> >   of the API (as glibc itself does)
> > - use LFS internally for all filesystem calls (just in case)
> > - map the API call to the correct implementation based on the build
> >   environment of the caller.
> >
> > Signed-off-by: Steve Langasek <steve.langasek@canonical.com>
> > ---
> >  libselinux/include/selinux/selinux.h | 11 ++++++++++-
> >  libselinux/src/Makefile              |  1 +
> >  libselinux/src/libselinux.map        |  1 +
> >  libselinux/src/matchpathcon.c        | 15 ++++++++++++++-
> >  4 files changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> > index a0948853..040629c3 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -1,6 +1,7 @@
> >  #ifndef _SELINUX_H_
> >  #define _SELINUX_H_
> >
> > +#include <stdint.h>

I needed <asm/bitsperlong.h> aswell for __BITS_PER_LONG

> >  #include <sys/types.h>
> >  #include <stdarg.h>
> >
> > @@ -521,7 +522,15 @@ extern int matchpathcon_index(const char *path,
> >     with the same inode (e.g. due to multiple hard links).  If so, then
> >     use the latter of the two specifications based on their order in the
> >     file contexts configuration.  Return the used specification index. */
> > -extern int matchpathcon_filespec_add(ino_t ino, int specind, const char *file);
> > +#if _FILE_OFFSET_BITS == 64

One should probably check for existence:

#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS == 64

> > +typedef uint64_t libselinux_ino_t;
> > +#if __BITS_PER_LONG < 64
> > +#define matchpathcon_filespec_add matchpathcon_filespec_add64
> > +#endif
> > +#else
> > +typedef uint32_t libselinux_ino_t;
> > +#endif

Is the typedef libselinux_ino_t really necessary, isn't it always just
equal to ino_t?

> > +extern int matchpathcon_filespec_add(libselinux_ino_t ino, int specind, const char *file);
> >
> >  /* Destroy any inode associations that have been added, e.g. to restart
> >     for a new filesystem. */
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index d3b981fc..267291aa 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -87,6 +87,7 @@ CFLAGS ?= -O -Wall -W -Wundef -Wformat-y2k -Wformat-security -Winit-self -Wmissi
> >            -fstack-protector-all --param=ssp-buffer-size=4 -fexceptions \
> >            -fasynchronous-unwind-tables -fdiagnostics-show-option \
> >            -Werror -Wno-aggregate-return \
> > +          -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 \

This won't work if CFLAGS are customized during build (e.g. by dpkg).
Also utils/ is unaffected.
Maybe use something like:

libselinux/Makefile:

USE_LFS ?= y
export USE_LFS

libselinux/{src,utils}/Makefile:

ifeq ($(USE_LFS),y)
       override CFLAGS += -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64
endif


> >            $(EXTRA_CFLAGS)
> >
> >  LD_SONAME_FLAGS=-soname,$(LIBSO),--version-script=libselinux.map,-z,defs,-z,relro
> > diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
> > index 5e00f45b..88c9b3e5 100644
> > --- a/libselinux/src/libselinux.map
> > +++ b/libselinux/src/libselinux.map
> > @@ -251,4 +251,5 @@ LIBSELINUX_3.5 {
> >    global:
> >      getpidprevcon;
> >      getpidprevcon_raw;
> > +    matchpathcon_filespec_add64;
> >  } LIBSELINUX_3.4;

For downstream this seems fine, for upstream this should go into a new
LIBSELINUX_3.6 section.

> > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
> > index e44734c3..189e00fb 100644
> > --- a/libselinux/src/matchpathcon.c
> > +++ b/libselinux/src/matchpathcon.c
> > @@ -195,7 +195,8 @@ static file_spec_t *fl_head;
> >   * then use the specification that occurs later in the
> >   * specification array.
> >   */
> > -int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
> > +int matchpathcon_filespec_add(libselinux_ino_t ino, int specind,
> > +                              const char *file)
> >  {
> >       file_spec_t *prevfl, *fl;
> >       int h, ret;
> > @@ -261,6 +262,18 @@ int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
> >       return -1;
> >  }
> >
> > +#if _FILE_OFFSET_BITS == 64 && __BITS_PER_LONG < 64
> > +/* alias defined in the public header but we undefine it here */
> > +#undef matchpathcon_filespec_add
> > +
> > +/* ABI backwards-compatible shim for non-LFS 32-bit systems */

Missing extern declaration to avoid a missing-prototype warning.

> > +int matchpathcon_filespec_add(unsigned long ino, int specind,

Are there 32-bit architectures we like to support where unsigned long
is not 4 (but 8) bytes in size?

> > +                              const char *file)
> > +{
> > +     return matchpathcon_filespec_add64(ino, specind, file);
> > +}
> > +#endif
> > +
> >  /*
> >   * Evaluate the association hash table distribution.
> >   */
> > --
> > 2.40.1
> >
