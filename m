Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F65DC48BCD
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 14:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0780861246
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 14:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhFIOIp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:08:45 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:38623 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbhFIOIp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jun 2021 10:08:45 -0400
Received: by mail-oo1-f54.google.com with SMTP id n17-20020a4ae1d10000b029024a49ea822bso375585oot.5
        for <selinux@vger.kernel.org>; Wed, 09 Jun 2021 07:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4VX3K7/JLNOXldQUHh0gxbTewf5EoYR+/ICw4Oi8qy0=;
        b=lEt0JmQ9FFyaDPcmPhPB669Y54BGyP1DBTah4zNrVEOI/y76m3doH6AEv6aWA8d8WH
         F/th62HAb5L2yplwzqbHyj7gXm5jqQN0lOCtjnrwMFyvgR90FyXwo3yURHYKbf5T9eGs
         PYSsrPBNJVN0wXBFQRAy5rN5vbmvIJ8N20U5sDXuNoPGotKmf/4ma8xHvaIPMKnc2grC
         ndVQ/UuO2YpnX6ANVMlvH+s96nW6aYOLNfkxYijpSePZOYQWacK5NV16mR88KDtDNv0G
         xJdKZ0kd9E7u+QwGulcGQ3S2jMR8fGBXrn76fmHj1ZB9/WH9vUdgWlkKfvSktvr5nKRx
         81Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4VX3K7/JLNOXldQUHh0gxbTewf5EoYR+/ICw4Oi8qy0=;
        b=cnkeZvXNYM5EzGykXYfcJM0GfX1LDnuYgQ824b2ClU4C6Buc9BK0OWM6WcJZ8mwiTJ
         C3NNd0Nk7MKlOc4gwU7zx2uzfRyN6oCjiQYIcq0SWEB8ZwtquyxO7O3SBj0A++6L0XTt
         /Tu9+GQxi9vB6fKlWe3K9ur0t/ZJlwSPDJwgqniLzhflqLMQzZCPs4mIsXaGiNmDtqoD
         Sc6P8Vf0iF0DiBtpch/xEdWkwx4rrVtUzVN0m+DW7SIeEC54YgwkdxJ2ufH+MM8zfDb4
         xScrsZ2pRik3fzKU67ceXrAWl3bJ5vdnwjxTUuohdufUNTR9U+TG0zYA1dw0n678NqlB
         wDbw==
X-Gm-Message-State: AOAM533x3hsheaBxGq/7L6gCxi5XVstZtNUnJ6oQpV5rfDBGz0zMxVeD
        GCXO33YyaiihvZ8DKyuqloHaY9lk5PEh/yvVE20=
X-Google-Smtp-Source: ABdhPJz3zYCs14BIXoCZQB2ipM7SxqLRYsRg3PsYQShcwPYSkYjc6TaWwC596C/omFC2Oq6N1Fa66Iw4oWOExP+ZqEU=
X-Received: by 2002:a4a:a9c8:: with SMTP id h8mr68276oon.1.1623247550722; Wed,
 09 Jun 2021 07:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-5-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-5-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Jun 2021 10:05:39 -0400
Message-ID: <CAP+JOzQABNk9sxuDjBimEi9HJGhoBUsXD1BNQDjyLZoF+WiY3A@mail.gmail.com>
Subject: Re: [PATCH 04/23] libsepol: ignore UBSAN false-positives
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:02 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Unsigned integer overflow is well-defined and not undefined behavior.
> But it is still useful to enable undefined behavior sanitizer checks on
> unsigned arithmetic to detect possible issues on counters or variables
> with similar purpose.
>
> Annotate functions in which unsigned overflows are expected to happen.
>
> avtab.c:76:2: runtime error: unsigned integer overflow: 6 * 3432918353 ca=
nnot be represented in type 'unsigned int'
> policydb.c:795:42: runtime error: unsigned integer overflow: 816094304217=
9512010 * 11 cannot be represented in type 'unsigned long'
> symtab.c:25:12: runtime error: left shift of 1766601759 by 4 places canno=
t be represented in type 'unsigned int'
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/avtab.c    | 6 ++++++
>  libsepol/src/policydb.c | 6 ++++++
>  libsepol/src/symtab.c   | 6 ++++++
>  3 files changed, 18 insertions(+)
>
> diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
> index 257f051a..c2ccb005 100644
> --- a/libsepol/src/avtab.c
> +++ b/libsepol/src/avtab.c
> @@ -52,6 +52,12 @@
>  /* Based on MurmurHash3, written by Austin Appleby and placed in the
>   * public domain.
>   */
> +#if defined(__clang__) && defined(__clang_major__) && (__clang_major__ >=
=3D 4)
> +__attribute__((no_sanitize("unsigned-integer-overflow")))
> +#if (__clang_major__ >=3D 12)
> +__attribute__((no_sanitize("unsigned-shift-base")))
> +#endif
> +#endif

My understanding is that there is no equivalent in gcc. Is that correct?
Jim

>  static inline int avtab_hash(struct avtab_key *keyp, uint32_t mask)
>  {
>         static const uint32_t c1 =3D 0xcc9e2d51;
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index fc1d0711..cbe0c432 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -789,6 +789,12 @@ static int roles_init(policydb_t * p)
>         goto out;
>  }
>
> +#if defined(__clang__) && defined(__clang_major__) && (__clang_major__ >=
=3D 4)
> +__attribute__((no_sanitize("unsigned-integer-overflow")))
> +#if (__clang_major__ >=3D 12)
> +__attribute__((no_sanitize("unsigned-shift-base")))
> +#endif
> +#endif
>  static inline unsigned long
>  partial_name_hash(unsigned long c, unsigned long prevhash)
>  {
> diff --git a/libsepol/src/symtab.c b/libsepol/src/symtab.c
> index 9a417ca2..738fa0a4 100644
> --- a/libsepol/src/symtab.c
> +++ b/libsepol/src/symtab.c
> @@ -11,6 +11,12 @@
>  #include <sepol/policydb/hashtab.h>
>  #include <sepol/policydb/symtab.h>
>
> +#if defined(__clang__) && defined(__clang_major__) && (__clang_major__ >=
=3D 4)
> +__attribute__((no_sanitize("unsigned-integer-overflow")))
> +#if (__clang_major__ >=3D 12)
> +__attribute__((no_sanitize("unsigned-shift-base")))
> +#endif
> +#endif
>  static unsigned int symhash(hashtab_t h, const_hashtab_key_t key)
>  {
>         const char *p, *keyp;
> --
> 2.32.0
>
