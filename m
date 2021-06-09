Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CB3C48BCF
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 13:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC84610A2
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 13:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhFINq3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229947AbhFINq2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jun 2021 09:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623246274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qJtsKG2dp3+oYS3RYbIsP+5ePHL6lMX8rjs5jGIBy9E=;
        b=B57HZKYJDFpqe9PAymlQ6+cWmYCkLwct5tNKEAdT1MpEXyCcAadk0eO6Cwx96wPnLlZTUT
        dZOFdhsstI6bOsLbzQZcPvq/Fkt+HoKrB3ZxXciVUnkx/s3e3dm+OZQ+vpJ3P1A0FoACxC
        PbkCt+3O3shzJxU6UCVVhRLljKdr/00=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-dcCEFWaLOnazmxN-2l7WcQ-1; Wed, 09 Jun 2021 09:44:32 -0400
X-MC-Unique: dcCEFWaLOnazmxN-2l7WcQ-1
Received: by mail-yb1-f197.google.com with SMTP id q63-20020a25d9420000b0290532e824f77cso31455869ybg.10
        for <selinux@vger.kernel.org>; Wed, 09 Jun 2021 06:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qJtsKG2dp3+oYS3RYbIsP+5ePHL6lMX8rjs5jGIBy9E=;
        b=s8MqCnxgEimd150sO87PLKDQykxqdNVwzS2J2ddSLnn6Fp2v3c7218EYBKmGGGtTN8
         o+/rhxV3VYR0r0sGnJkbX8DPF47slGvNxi0foghUjU9Hm/3HEHSdEnJF/P2jdkt2LiEg
         vZwoyQk6HP0pOcKN0k93XQTAbG6XpTB60dz+zRGDLUy59KTcKXz7sFrN5PzpPRjKJvTi
         TmseL9EwhY1vVp7GNQpG2WKNlua3aQJJk9KE7f8LeODTBirwMT+fS0P5WPnIE3Yd7rUc
         PYZ9BqJyQl4nTXeqjIBLfsW3lIUuAZ9TQgJ9I83DxkTORBJGuadjSDBN2Up7mnGK+B4M
         XQug==
X-Gm-Message-State: AOAM531GC4p029C9700o+EMWeVZygGV4Ex9C9Mgh3VardRiDvQmjsehz
        +IDmWP/XgiCZ3Rvmr5Un2s5Kqsovw7VJ69IRWa3KqzHSa39aQhqXzrBw6OhPeCFsPOzLQS3eIML
        O/D7tGiCW1JB7ypwlXxgNsxEs+8H8oEXpnA==
X-Received: by 2002:a25:1fc1:: with SMTP id f184mr73512ybf.289.1623246271826;
        Wed, 09 Jun 2021 06:44:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCKrsZIeWzKF5SwPxElsx+iIwiUOlUYP0C7M2PvAz0x0UZunFjQfWfi12uGeVjFEsV7KbnzuyrifnoWg5Na3Q=
X-Received: by 2002:a25:1fc1:: with SMTP id f184mr73481ybf.289.1623246271574;
 Wed, 09 Jun 2021 06:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-5-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-5-cgzones@googlemail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 9 Jun 2021 15:44:20 +0200
Message-ID: <CAFqZXNvGcN1BrT=6eaKsgMe7XAWv7Ynn6xsBOD26aN03xn1MiA@mail.gmail.com>
Subject: Re: [PATCH 04/23] libsepol: ignore UBSAN false-positives
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 6:01 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
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

Perhaps this could be defined as a common macro in
libsepol/src/private.h instead of duplicating it in three places?

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

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

