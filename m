Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF32C6A4
	for <selinux@vger.kernel.org>; Tue, 27 Feb 2024 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054042; cv=none; b=RTfnTTJFRlSEubjd4Pi541QCcrrc7f9ByssXp28A6Sq8nPXfM4TkPJhL58b3HodriI2lX03cU1hR7NdiU3Ji7sD7q38xPt+3ur2h59ljq40mE8WHqeJfXXnAkzxh8a/M7iMGsQtHwDRd2k71Qh7otzuVnxg+6cWA00ONp4A42Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054042; c=relaxed/simple;
	bh=ogLwCIt1SqYGvFIQ2pDPo0c12DntwO/5fc+DTnAt2+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPSc42NGJsxMeNM4YX/K1I5KOmIMumH+mKJKIG+a+PAqWa3uyeei1clHt9grQ0FHczuGkFq7lP2XGftFdBm950iHVzJmRLR37BDpwDuZ7tHbK5MYXHOEsvaZXZI+VT3FuD6wjKUlZqB3fgqaRcOZ05gqhfpLVnv/bzvEj0EXjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ATbJW/fl; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ATbJW/fl"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-608e3530941so30373787b3.1
        for <selinux@vger.kernel.org>; Tue, 27 Feb 2024 09:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1709054040; x=1709658840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQIsyh6lnKQIviP7vQLhIGoAiKl46fXb5BNVjuF18L4=;
        b=ATbJW/fl6nGegkqepFkhoI7RulgVQ5YxuxUb/skc7P3j1NeLYpfU0LB71foo9PycQ/
         VrVdmHMh2Bp+kdQDUDdWTnBawChVQ6lA2vrtTnJJKfrd89+7J+BgnOMDkfwJmFng9B3x
         ZjgQobOP3xAEMmpzC5R5iDSl5syQZionuFDUcQRUkaq1YiZt1of9ChvVB/dBQDmVmbM6
         r7e5VPTouVJafuzbYCoceKefFzS0hnkfFUT2ZQoB4N/NymcuuEG2/j9TUIdwMgiqYxNW
         NUcXib26hxh6jZ/7akm+Kcb6H2aLFlyla8qJ92K5WQdSaviWPA5oTmUKxvuqWGHW0R6A
         Ef4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709054040; x=1709658840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQIsyh6lnKQIviP7vQLhIGoAiKl46fXb5BNVjuF18L4=;
        b=gL17EqCmpc160rLXQvMdEKxb3WgUMsMVkN63s5Guk131/ZXItvPfPihDLja47T+By1
         hOAMcOZZDfa28awYLHUmUjW4jYysAAvqU4Og1ne6/ryWqG3xjZxr5p3r5gbddNGf/TKs
         RCAlFokTYEo6kTfIO+npcs9MxELgGpnn9DKFFK9d/XfKw3YiirU5705oFvuwvep4ONkU
         YK5Kw0GMEWAwyOJemT4IT8IAj3SamgIrFJ6dWuteKwnRoWefYZXFiNAGYLxRKw0ZZhok
         ofqFNLDgPTu4HJy3IsJCBBPjzX7jI5c1CDLcCU8deFQVhfF3MvdVCXy1bIbIaylR52tu
         lFDg==
X-Forwarded-Encrypted: i=1; AJvYcCXQfIANsKU35AGlOzMfzDP1FSXj+lSfIxuO1/FjaS3lSddYe1ddWdhq8iN9baTW/Wx2/vksIi4nRcf6tTkyv+T5KjdhrBFg8w==
X-Gm-Message-State: AOJu0Yz42hjkW9PwnvyamX8qq5k3QIwEXyGnl73sm/9RxCGABgwqH+HZ
	Olg8g19BbyoafY1Lpn+zamqqXgKXJA7WjT5ifHwViZLvIBj4n8bxCGcJGvYVRa7a5u60cXSJpej
	XUNeKrPvjcZYctpY+Fn6fHzyoRoM=
X-Google-Smtp-Source: AGHT+IGAkEr9Fh3AmR1RuzoNhKry2xYiKSx4BWhb3BBdEqVHrK7hNCC+rgftKUeY+r/wnnwg7WD9yfYchdY9GUaFZ54=
X-Received: by 2002:a81:af13:0:b0:607:554f:9c25 with SMTP id
 n19-20020a81af13000000b00607554f9c25mr2897890ywh.51.1709054038360; Tue, 27
 Feb 2024 09:13:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216003252.29057-1-steve.langasek@canonical.com>
 <Zc6tzKPsYZRICHya@homer.dodds.net> <202402171351.439742DA@keescook>
 <ZdF0no51QNtKq8Ri@homer.dodds.net> <Zdrh/euXdvdWlVSp@homer.dodds.net>
 <CAJ2a_DeQFFgo+b6xf3_79bsfsvWeGWOephtgsJTK+RxJ7epG4Q@mail.gmail.com> <Zd2IcMMLagkTZGJp@homer.dodds.net>
In-Reply-To: <Zd2IcMMLagkTZGJp@homer.dodds.net>
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Tue, 27 Feb 2024 18:13:47 +0100
Message-ID: <CAJ2a_Df75EDn27iHSg=aAh0ZzRE40SqyanzRkfzv6ETmFiE8ug@mail.gmail.com>
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
To: Steve Langasek <vorlon@debian.org>
Cc: James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Feb 2024 at 08:00, Steve Langasek <vorlon@debian.org> wrote:
>
> Thanks for the feedback.
>
> On Mon, Feb 26, 2024 at 06:52:10PM +0100, Christian G=C3=B6ttsche wrote:
> > > > +#include <stdint.h>
>
> > I needed <asm/bitsperlong.h> aswell for __BITS_PER_LONG
>
> Can you tell me about the platform you were building on?  In my tests, th=
e
> code with this patch behaved as intended on Ubuntu 24.04 pre-release with
> glibc 2.38, on both armhf and amd64, with no additional includes required=
.

Debian sid.

> > > > +#if _FILE_OFFSET_BITS =3D=3D 64
>
> > One should probably check for existence:
>
> > #if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64
>
> Should we not consider it an error if this is not defined?  I can't think=
 of
> any reason why _FILE_OFFSET_BITS would legitimately be missing and in my
> view it's ambiguous what we should do in this circumstance.  Using the
> define without checking for existence first implicitly gives an error if
> it's missing.  If preferred, we could be explicit as in:
>
> #if !defined(_FILE_OFFSET_BITS)
> #error [...]
> #endif
> #if _FILE_OFFSET_BITS =3D=3D 64
> [...]

During my testing yesterday _FILE_OFFSET_BITS was not defined by
default (gcc-13/gcc-14/clang-18 on Debian sid).

> > > > +typedef uint64_t libselinux_ino_t;
> > > > +#if __BITS_PER_LONG < 64
> > > > +#define matchpathcon_filespec_add matchpathcon_filespec_add64
> > > > +#endif
> > > > +#else
> > > > +typedef uint32_t libselinux_ino_t;
> > > > +#endif
>
> > Is the typedef libselinux_ino_t really necessary, isn't it always just
> > equal to ino_t?
>
> When _FILE_OFFSET_BITS =3D=3D 64, ino_t is a 64-bit type and we need to
> explicitly declare a 32-bit type for the compatibility interface.  From
> sys/stat.h:
>
> # ifndef __ino_t_defined
> #  ifndef __USE_FILE_OFFSET64
> typedef __ino_t ino_t;
> #  else
> typedef __ino64_t ino_t;
> #  endif
> #  define __ino_t_defined
> # endif

But isn't this the identical logic as for libselinux_ino_t?
If _FILE_OFFSET_BITS is defined to be 64 libselinux_ino_t is
typedef'ed to uint64_t and ino_t should also be a 64-bit integer.
If _FILE_OFFSET_BITS is not 64 libselinux_ino_t is typedef'ed to
uint32_t and ino_t should also be a 32-bit integer.

Also if I understand the patch idea correctly the 32-bit compatibility
type is only needed on 32-bit-LFS-enabled systems for the exported
symbol matchpathcon_filespec_add() to not break the ABI.
Changes to the header "only" lead to API breakage, which seems acceptable.

> > > > +extern int matchpathcon_filespec_add(libselinux_ino_t ino, int spe=
cind, const char *file);
> > > >
> > > >  /* Destroy any inode associations that have been added, e.g. to re=
start
> > > >     for a new filesystem. */
> > > > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > > index d3b981fc..267291aa 100644
> > > > --- a/libselinux/src/Makefile
> > > > +++ b/libselinux/src/Makefile
> > > > @@ -87,6 +87,7 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wfo=
rmat-security -Winit-self -Wmissi
> > > >            -fstack-protector-all --param=3Dssp-buffer-size=3D4 -fex=
ceptions \
> > > >            -fasynchronous-unwind-tables -fdiagnostics-show-option \
> > > >            -Werror -Wno-aggregate-return \
> > > > +          -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64 \
>
> > This won't work if CFLAGS are customized during build (e.g. by dpkg).
> > Also utils/ is unaffected.
> > Maybe use something like:
>
> > libselinux/Makefile:
> >
> > USE_LFS ?=3D y
> > export USE_LFS
> >
> > libselinux/{src,utils}/Makefile:
> >
> > ifeq ($(USE_LFS),y)
> >        override CFLAGS +=3D -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D6=
4
> > endif
>
> Thanks, I'm happy to amend the patch to do that (but will wait to converg=
e
> on the other points above before I resubmit).
>
> I was largely unconcerned about the case of dpkg overriding it since, goi=
ng
> forward, dpkg would always be overriding it in the direction we wanted.  =
But
> build systems for other distros may do otherwise and in that sense I agre=
e
> we should make it resistant to accidental clobbering.
>
> > > > --- a/libselinux/src/libselinux.map
> > > > +++ b/libselinux/src/libselinux.map
> > > > @@ -251,4 +251,5 @@ LIBSELINUX_3.5 {
> > > >    global:
> > > >      getpidprevcon;
> > > >      getpidprevcon_raw;
> > > > +    matchpathcon_filespec_add64;
> > > >  } LIBSELINUX_3.4;
>
> > For downstream this seems fine, for upstream this should go into a new
> > LIBSELINUX_3.6 section.
>
> For me the ideal outcome is bidirectional ABI compatibility with upstream=
,
> which means agreeing on the symbol version in advance before I upload thi=
s.
> For purposes of the upstream submission I'm happy to set this to
> LIBSELINUX_3.6 (yes, obviously it wouldn't be LIBSELINUX_3.5 anymore sinc=
e
> that ABI is already fixed).  Barring a committment to land this change as
> part of LIBSELINUX_3.6, my inclination for the downstream change this wee=
k
> would be to leave it as an unversioned symbol so that consumers would be
> forwards-compatible with later upstream inclusion regardless of the symbo=
l
> version used.
>
> > > > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpa=
thcon.c
> > > > index e44734c3..189e00fb 100644
> > > > --- a/libselinux/src/matchpathcon.c
> > > > +++ b/libselinux/src/matchpathcon.c
> > > > @@ -195,7 +195,8 @@ static file_spec_t *fl_head;
> > > >   * then use the specification that occurs later in the
> > > >   * specification array.
> > > >   */
> > > > -int matchpathcon_filespec_add(ino_t ino, int specind, const char *=
file)
> > > > +int matchpathcon_filespec_add(libselinux_ino_t ino, int specind,
> > > > +                              const char *file)
> > > >  {
> > > >       file_spec_t *prevfl, *fl;
> > > >       int h, ret;
> > > > @@ -261,6 +262,18 @@ int matchpathcon_filespec_add(ino_t ino, int s=
pecind, const char *file)
> > > >       return -1;
> > > >  }
> > > >
> > > > +#if _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PER_LONG < 64
> > > > +/* alias defined in the public header but we undefine it here */
> > > > +#undef matchpathcon_filespec_add
> > > > +
> > > > +/* ABI backwards-compatible shim for non-LFS 32-bit systems */
>
> > Missing extern declaration to avoid a missing-prototype warning.
>
> Ack - will fix.
>
> > > > +int matchpathcon_filespec_add(unsigned long ino, int specind,
>
> > Are there 32-bit architectures we like to support where unsigned long
> > is not 4 (but 8) bytes in size?
>
> I am not aware of any.
> https://en.wikipedia.org/wiki/LP64#64-bit_data_models discusses the vario=
us
> combinations of 32-bit and 64-bit types that are known to have been used,
> and while there are configurations that use a 64-bit pointer with a 32-bi=
t
> long there are no examples shown for configurations that do the opposite.
>
> --
> Steve Langasek                   Give me a lever long enough and a Free O=
S
> Debian Developer                   to set it on, and I can move the world=
.
> Ubuntu Developer                                   https://www.debian.org=
/
> slangasek@ubuntu.com                                     vorlon@debian.or=
g
