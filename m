Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9A5C433F5
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 12:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA5F610A2
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 12:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhJSMxA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235714AbhJSMxA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 08:53:00 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE07C06161C
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 05:50:47 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so3863337otq.12
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nIAYh3QbGMqMqrdt1o+BK9SyUdzCz9SIsHJhkQuOOUk=;
        b=DrlOXX6mOHJyvO6ERaksRGTLfPwBK3rw0WRpPGkewIB1Vw92EAXb1cQWTLvfSIRsLj
         uFxtvg//u6A5gBi4sSJenB0++jbmz0b0HV6GCX1TwTI4Idb6RUyRCYCtt40QBm48VJD8
         vXHvaOKm0B0DJcxl61E4Fy9NgWK5gjtACS3rgoWSO0m3Ybz0erPfYxGGWYsc0hc2mNun
         0GtKO3N396wUDT3ZVhJxTC4DzkJu4rUY1pJRscroK9hGXPFC80qE1Amxvkw25W2eZDzj
         7W51S766HJ6ZbOPjzEdXFuhFLwzr42mNS8XCN5CCCKYagevUAQXxFVYOEqYZTrRQ/C/G
         Z96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nIAYh3QbGMqMqrdt1o+BK9SyUdzCz9SIsHJhkQuOOUk=;
        b=qezo2gkTKw2XIK1rhaPq7rSPJQjMsYtIsI68hPaBRAhGsSqkXtEeGaLYDd/KtQVHA7
         ZheN4qNYb3nl3BLz/tiWWaGy8vwSB9dnyl5Nb4Gi7lolVcYJSyqr7ToXlNXT9pfOMKvU
         iv+dgPpv3QyxUAb7wsV5FzNQ+FaY+cdcklnH2hlpOfXUDquskHgdv41XAuJ4bHlZDV1E
         hZqDaaVbpHK3N2+LZg2zeqsF1pE0tHrk6aF30Rku/uIUYzs5/F8zIVw+Q1/5r+wI2/JJ
         QV9+XzKfvDM4MW6ITFFKjDCWyLfrw6h06quemhzF9hzlgJ/9sM0zkd7et1WqbVkZH98y
         c8fw==
X-Gm-Message-State: AOAM531E5Ho+lOET/3FWDIvE7nFIZc0qBoQYHF9poIqT6KrfknK9tRcw
        qtDnrOnUAqV10OHZuYWH1PTd57wUaLH7Go8m4W+L4VlUJ1jXDA==
X-Google-Smtp-Source: ABdhPJz6iYNtDYHLs7mdJPaTFTNh9VOXmscUigQdaIkBItVJcLV4PZe5D6sbCA7o3alyhC9LuuxkilrVfxJtjpDT2zg=
X-Received: by 2002:a9d:60dd:: with SMTP id b29mr4980367otk.117.1634647846682;
 Tue, 19 Oct 2021 05:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211013125358.15534-1-cgzones@googlemail.com> <CAJfZ7=kcmhox2sToZjCS0YKfwZ0TgNqsMpTOe5PUR80zPgB4ig@mail.gmail.com>
In-Reply-To: <CAJfZ7=kcmhox2sToZjCS0YKfwZ0TgNqsMpTOe5PUR80zPgB4ig@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 19 Oct 2021 14:50:35 +0200
Message-ID: <CAJ2a_De2P8ivkbagD1qYAPk80QY77VKTEOHaY2M6Wc1XYLFKUg@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: do not pass NULL to memcpy
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, 16 Oct 2021 at 21:30, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Wed, Oct 13, 2021 at 2:54 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > For the first iteration `mod->perm_map[sclassi]` is NULL, thus do not
> > use it as source of a memcpy(3), even with a size of 0.  memcpy(3) migh=
t
> > be annotated with the function attribute nonnull and UBSan then
> > complains:
> >
> >     link.c:193:3: runtime error: null pointer passed as argument 2, whi=
ch is declared to never be null
> >
> > Use a realloc + memset instead of a calloc and free to increase the siz=
e
> > of `mod->perm_map[sclassi]`.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  libsepol/src/link.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > index 7512a4d9..75ce2b20 100644
> > --- a/libsepol/src/link.c
> > +++ b/libsepol/src/link.c
> > @@ -185,14 +185,12 @@ static int permission_copy_callback(hashtab_key_t=
 key, hashtab_datum_t datum,
> >          * may have originated from the class -or- it could be from
> >          * the class's common parent.*/
> >         if (perm->s.value > mod->perm_map_len[sclassi]) {
> > -               uint32_t *newmap =3D calloc(perm->s.value, sizeof(*newm=
ap));
> > +               uint32_t *newmap =3D realloc(mod->perm_map[sclassi], pe=
rm->s.value * sizeof(*newmap));
>
> Hello,
> It seems sad to transform a calloc call to an explicit multiplication
> which can overflow. Nowadays glibc provides reallocarray, for a
> "realloc with multiplication overflow checking". Could you use it here
> instead?
>

Yes, I thought about that, but I wanted this diff to be as small as possibl=
e.
One option would be to wait until reallocarray is available (via
fallback or requirement (see later)) or keep the calloc+memcpy, but
not invoke the memset on a size of 0.

> I saw in another patch ([RFC PATCH 09/35] libsepol: use reallocarray
> wrapper to avoid overflows ;
> https://lore.kernel.org/selinux/20211011162533.53404-10-cgzones@googlemai=
l.com/T/#u)
> that you introduced reallocarray calls in other places, with a
> fallback implementation for systems which lack it. When I saw it, I
> was wondering: which C library does not provide this function?
>
> - glibc has it since version 2.29 (according to
> https://man7.org/linux/man-pages/man3/realloc.3.html ; this version
> was released on 2019-02-01)
> - musl has it since version 1.2.2 (thanks to
> https://git.musl-libc.org/cgit/musl/commit/?id=3D821083ac7b54eaa040d5a8dd=
c67c6206a175e0ca
> ; released on 2021-01-15)
> - bionic has it since 2018
> (https://android.googlesource.com/platform/bionic/+/b177085ce7219562eecf7=
7f2e8de49f8f2605005%5E%21/)
> - newlib has it since 2017
> (https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3Deb1=
4d0cc649978c10928bf38c1847f295bf0de69)
>
> However uclic-ng 1.0.39 (released ten days ago) does not provide
> reallocarray. It is the only maintained and open-source C library
> compatible with Linux that I could find which would not provide
> reallocarray. Did I miss a library which is likely to be used by
> libsepol users?
>
> In my humble opinion, this means that for future releases we can
> consider that systems are expected to provide reallocarray, and that
> we can introduce a Makefile variable which would introduce a custom
> internal reallocarray implementation in libsepol. This means that I
> suggest using something like this in libsepol/src/Makefile:
>
> USE_INTERNAL_REALLOCARRAY ?=3D n
> ifeq (USE_INTERNAL_REALLOCARRAY, y)
>   CFLAGS +=3D -DUSE_INTERNAL_REALLOCARRAY
> endif
>
> and I suggest putting the internal reallocarray implementation from
> your patch in libsepol/src/private.h (like you did), around "#ifdef
> USE_INTERNAL_REALLOCARRAY" statements. This way, libsepol would work
> out-of-the-box on most systems, would be compatible on systems without
> reallocarray by using "make USE_INTERNAL_REALLOCARRAY=3Dy", and would
> not try to auto-detect it at build-time by some compiler magic in
> Makefile (which would avoid issues similar as the one libapparmor had
> in http://lists.busybox.net/pipermail/buildroot/2020-October/294691.html)=
.
> What do you think of these suggestions?
>

Looking for example at
https://github.com/SELinuxProject/selinux/commit/4859b738136ef8889fbb71a166=
cfec8d313ba4e0
(supporting gcc 4.8) I am not sure what compilers and standard C
libraries should be supported for building the SELinux userland
libraries and tools. Until any statement of the maintainer team, I
prefer the Makefile hack from
https://lore.kernel.org/selinux/20211011162533.53404-10-cgzones@googlemail.=
com/T/#u
to support standard C libraries without reallocarray(3).


> Thanks,
> Nicolas
>
> >                 if (newmap =3D=3D NULL) {
> >                         ERR(state->handle, "Out of memory!");
> >                         return -1;
> >                 }
> > -               memcpy(newmap, mod->perm_map[sclassi],
> > -                      mod->perm_map_len[sclassi] * sizeof(*newmap));
> > -               free(mod->perm_map[sclassi]);
> > +               memset(newmap + mod->perm_map_len[sclassi], '\0', perm-=
>s.value - mod->perm_map_len[sclassi]);
> >                 mod->perm_map[sclassi] =3D newmap;
> >                 mod->perm_map_len[sclassi] =3D perm->s.value;
> >         }
> > --
> > 2.33.0
> >
>
