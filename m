Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1924DC11F9D
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 07:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1066161629
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 07:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhGLHpJ convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 03:45:09 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:59190 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbhGLHhy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 03:37:54 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 18ADA5649BE
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 09:34:49 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id b5-20020a17090a9905b029016fc06f6c5bso10020766pjp.5
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 00:34:49 -0700 (PDT)
X-Gm-Message-State: AOAM530nx6zF7/n67aiPOtM+Z3hbG+4608DAPMLBQ+mtl80mVWe/CSvp
        F4aVhuFXDriSxSUDZX9QsA5GzmNaYhqvgY8ymdw=
X-Google-Smtp-Source: ABdhPJxtQ33e9apwd1f4soMA2dzT574LlQHb9oC273mSiihCcUKi3z+FfgXbKDp22KADYzS0L6uD0JVdCByKFZD9EA4=
X-Received: by 2002:a17:90a:588b:: with SMTP id j11mr50809081pji.114.1626075287878;
 Mon, 12 Jul 2021 00:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-5-cgzones@googlemail.com> <20210701180622.119708-1-cgzones@googlemail.com>
In-Reply-To: <20210701180622.119708-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 12 Jul 2021 09:34:37 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nVF8grKSGop67d4sPXHDZgP6QLChWsROcrGudJiWb=_A@mail.gmail.com>
Message-ID: <CAJfZ7=nVF8grKSGop67d4sPXHDZgP6QLChWsROcrGudJiWb=_A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] libsepol: ignore UBSAN false-positives
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Jul 12 09:34:49 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 1, 2021 at 8:06 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Unsigned integer overflow is well-defined and not undefined behavior.
> But it is still useful to enable undefined behavior sanitizer checks on
> unsigned arithmetic to detect possible issues on counters or variables
> with similar purpose.
>
> Annotate functions, in which unsigned overflows are expected to happen,
> with the respective Clang function attribute[1].
> GCC does not support sanitizing unsigned integer arithmetic[2].
>
>     avtab.c:76:2: runtime error: unsigned integer overflow: 6 * 3432918353 cannot be represented in type 'unsigned int'
>     policydb.c:795:42: runtime error: unsigned integer overflow: 8160943042179512010 * 11 cannot be represented in type 'unsigned long'
>     symtab.c:25:12: runtime error: left shift of 1766601759 by 4 places cannot be represented in type 'unsigned int'
>
> [1]: https://clang.llvm.org/docs/AttributeReference.html#no-sanitize
> [2]: https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas
> ---
> v2:
>   - use a common macro as suggested by Ondrej Mosnacek
>   - mention that GCC does not support unsigned integer sanitation
>
>  libsepol/src/avtab.c    |  1 +
>  libsepol/src/policydb.c |  1 +
>  libsepol/src/private.h  | 11 +++++++++++
>  libsepol/src/symtab.c   |  4 ++++
>  4 files changed, 17 insertions(+)
>
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 88e9d510..37e8af07 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -52,6 +52,7 @@
>  /* Based on MurmurHash3, written by Austin Appleby and placed in the
>   * public domain.
>   */
> +ignore_unsigned_overflow_
>  static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
>  {
>         static const uint32_t c1 = 0xcc9e2d51;
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index ef2217c2..0721c81e 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -789,6 +789,7 @@ static int roles_init(policydb_t * p)
>         goto out;
>  }
>
> +ignore_unsigned_overflow_
>  static inline unsigned long
>  partial_name_hash(unsigned long c, unsigned long prevhash)
>  {
> diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> index 72f21262..e54cefdb 100644
> --- a/libsepol/src/private.h
> +++ b/libsepol/src/private.h
> @@ -47,6 +47,17 @@
>  #define is_saturated(x) (x == (typeof(x))-1)
>  #define zero_or_saturated(x) ((x == 0) || is_saturated(x))
>
> +/* Use to ignore intentional unsigned under- and overflows while running under UBSAN. */
> +#if defined(__clang__) && defined(__clang_major__) && (__clang_major__ >= 4)
> +#if (__clang_major__ >= 12)
> +#define ignore_unsigned_overflow_        __attribute__((no_sanitize("unsigned-integer-overflow", "unsigned-shift-base")))
> +#else
> +#define ignore_unsigned_overflow_        __attribute__((no_sanitize("unsigned-integer-overflow")))
> +#endif
> +#else
> +#define ignore_unsigned_overflow_
> +#endif
> +
>  /* Policy compatibility information. */
>  struct policydb_compat_info {
>         unsigned int type;
> diff --git a/libsepol/src/symtab.c b/libsepol/src/symtab.c
> index 9a417ca2..a6061851 100644
> --- a/libsepol/src/symtab.c
> +++ b/libsepol/src/symtab.c
> @@ -8,9 +8,13 @@
>   */
>
>  #include <string.h>
> +
> +#include "private.h"
> +
>  #include <sepol/policydb/hashtab.h>
>  #include <sepol/policydb/symtab.h>
>
> +ignore_unsigned_overflow_
>  static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
>  {
>         const char *p, *keyp;
> --
> 2.32.0
>

