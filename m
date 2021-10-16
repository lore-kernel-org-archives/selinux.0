Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FDDC433EF
	for <selinux@archiver.kernel.org>; Sat, 16 Oct 2021 19:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5493460F6E
	for <selinux@archiver.kernel.org>; Sat, 16 Oct 2021 19:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhJPTcq convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sat, 16 Oct 2021 15:32:46 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:34291 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbhJPTcq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 16 Oct 2021 15:32:46 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 42817564783
        for <selinux@vger.kernel.org>; Sat, 16 Oct 2021 21:30:36 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id v20so8545328plo.7
        for <selinux@vger.kernel.org>; Sat, 16 Oct 2021 12:30:36 -0700 (PDT)
X-Gm-Message-State: AOAM530NvAtZ514xcccpLgtXRWxeLRNPxYbd6MNH9FrBpie+NYfKG13y
        gFFi6aZgn0LzHytA+yu1DA0NcZnGrUK7Cku3FRQ=
X-Google-Smtp-Source: ABdhPJy6ZglpLAD/1lifVpj0zKzhRX5wIkJgakfohqBNagzKzUAJMte/OSqhQd2SBBKxEHG2RaN7ImM7Jv9Nyj7nS/o=
X-Received: by 2002:a17:902:e843:b0:13f:2212:d64c with SMTP id
 t3-20020a170902e84300b0013f2212d64cmr18020597plg.16.1634412634738; Sat, 16
 Oct 2021 12:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20211013125358.15534-1-cgzones@googlemail.com>
In-Reply-To: <20211013125358.15534-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 16 Oct 2021 21:30:23 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kcmhox2sToZjCS0YKfwZ0TgNqsMpTOe5PUR80zPgB4ig@mail.gmail.com>
Message-ID: <CAJfZ7=kcmhox2sToZjCS0YKfwZ0TgNqsMpTOe5PUR80zPgB4ig@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: do not pass NULL to memcpy
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Oct 16 21:30:36 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 13, 2021 at 2:54 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> For the first iteration `mod->perm_map[sclassi]` is NULL, thus do not
> use it as source of a memcpy(3), even with a size of 0.  memcpy(3) might
> be annotated with the function attribute nonnull and UBSan then
> complains:
>
>     link.c:193:3: runtime error: null pointer passed as argument 2, which is declared to never be null
>
> Use a realloc + memset instead of a calloc and free to increase the size
> of `mod->perm_map[sclassi]`.
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/link.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index 7512a4d9..75ce2b20 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -185,14 +185,12 @@ static int permission_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>          * may have originated from the class -or- it could be from
>          * the class's common parent.*/
>         if (perm->s.value > mod->perm_map_len[sclassi]) {
> -               uint32_t *newmap = calloc(perm->s.value, sizeof(*newmap));
> +               uint32_t *newmap = realloc(mod->perm_map[sclassi], perm->s.value * sizeof(*newmap));

Hello,
It seems sad to transform a calloc call to an explicit multiplication
which can overflow. Nowadays glibc provides reallocarray, for a
"realloc with multiplication overflow checking". Could you use it here
instead?

I saw in another patch ([RFC PATCH 09/35] libsepol: use reallocarray
wrapper to avoid overflows ;
https://lore.kernel.org/selinux/20211011162533.53404-10-cgzones@googlemail.com/T/#u)
that you introduced reallocarray calls in other places, with a
fallback implementation for systems which lack it. When I saw it, I
was wondering: which C library does not provide this function?

- glibc has it since version 2.29 (according to
https://man7.org/linux/man-pages/man3/realloc.3.html ; this version
was released on 2019-02-01)
- musl has it since version 1.2.2 (thanks to
https://git.musl-libc.org/cgit/musl/commit/?id=821083ac7b54eaa040d5a8ddc67c6206a175e0ca
; released on 2021-01-15)
- bionic has it since 2018
(https://android.googlesource.com/platform/bionic/+/b177085ce7219562eecf77f2e8de49f8f2605005%5E%21/)
- newlib has it since 2017
(https://sourceware.org/git/?p=newlib-cygwin.git;a=commitdiff;h=eb14d0cc649978c10928bf38c1847f295bf0de69)

However uclic-ng 1.0.39 (released ten days ago) does not provide
reallocarray. It is the only maintained and open-source C library
compatible with Linux that I could find which would not provide
reallocarray. Did I miss a library which is likely to be used by
libsepol users?

In my humble opinion, this means that for future releases we can
consider that systems are expected to provide reallocarray, and that
we can introduce a Makefile variable which would introduce a custom
internal reallocarray implementation in libsepol. This means that I
suggest using something like this in libsepol/src/Makefile:

USE_INTERNAL_REALLOCARRAY ?= n
ifeq (USE_INTERNAL_REALLOCARRAY, y)
  CFLAGS += -DUSE_INTERNAL_REALLOCARRAY
endif

and I suggest putting the internal reallocarray implementation from
your patch in libsepol/src/private.h (like you did), around "#ifdef
USE_INTERNAL_REALLOCARRAY" statements. This way, libsepol would work
out-of-the-box on most systems, would be compatible on systems without
reallocarray by using "make USE_INTERNAL_REALLOCARRAY=y", and would
not try to auto-detect it at build-time by some compiler magic in
Makefile (which would avoid issues similar as the one libapparmor had
in http://lists.busybox.net/pipermail/buildroot/2020-October/294691.html).
What do you think of these suggestions?

Thanks,
Nicolas

>                 if (newmap == NULL) {
>                         ERR(state->handle, "Out of memory!");
>                         return -1;
>                 }
> -               memcpy(newmap, mod->perm_map[sclassi],
> -                      mod->perm_map_len[sclassi] * sizeof(*newmap));
> -               free(mod->perm_map[sclassi]);
> +               memset(newmap + mod->perm_map_len[sclassi], '\0', perm->s.value - mod->perm_map_len[sclassi]);
>                 mod->perm_map[sclassi] = newmap;
>                 mod->perm_map_len[sclassi] = perm->s.value;
>         }
> --
> 2.33.0
>

