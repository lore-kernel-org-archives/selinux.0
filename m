Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA2DC07E99
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 07:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CE761433
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 07:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344619AbhGLHiI convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 03:38:08 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:37941 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243683AbhGLHgi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 03:36:38 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9F6E4564984
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 09:33:47 +0200 (CEST)
Received: by mail-pf1-f170.google.com with SMTP id m83so7925214pfd.0
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 00:33:47 -0700 (PDT)
X-Gm-Message-State: AOAM533x7DhS/1MttvMpb42r4ikO4gqhHqM3ymRtuW8Tn5ZwxDNQ2vdR
        Tzdh8Ja3dopUPfZtZxj0CQmLLerT5AwHdGAnQxI=
X-Google-Smtp-Source: ABdhPJwqgUxyS8UZkRg4yXSZ2QxOhB4an/M4Hh0PqCzouCUiIX1+cUmDBQ7DmliYaqUO5QR19wkZcPqQUTnLoLxF5TA=
X-Received: by 2002:a63:fd43:: with SMTP id m3mr44956978pgj.210.1626075226525;
 Mon, 12 Jul 2021 00:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210701183430.145934-1-cgzones@googlemail.com> <20210706173629.22032-1-cgzones@googlemail.com>
In-Reply-To: <20210706173629.22032-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 12 Jul 2021 09:33:35 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nOpwQD8vZOZvwsc-W7Vo1GHVCKop0tat=OanK=+rqmDg@mail.gmail.com>
Message-ID: <CAJfZ7=nOpwQD8vZOZvwsc-W7Vo1GHVCKop0tat=OanK=+rqmDg@mail.gmail.com>
Subject: Re: [PATCH v3] libsepol: avoid unsigned integer overflow
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Jul 12 09:33:48 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 6, 2021 at 7:36 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Unsigned integer overflow is well-defined and not undefined behavior.
> It is commonly used for hashing or pseudo random number generation.
> But it is still useful to enable undefined behavior sanitizer checks on
> unsigned arithmetic to detect possible issues on counters or variables
> with similar purpose or missed overflow checks on user input.
>
> Use a spaceship operator like comparison instead of subtraction.
>
>     policydb.c:851:24: runtime error: unsigned integer overflow: 801 - 929 cannot be represented in type 'unsigned int'
>
> Follow-up of: 1537ea8412e4 ("libsepol: avoid unsigned integer overflow")
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

> ---
>  libsepol/src/policydb.c | 10 +++++-----
>  libsepol/src/private.h  |  2 ++
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index ef2217c2..0398ceed 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -817,11 +817,11 @@ static int filenametr_cmp(hashtab_t h __attribute__ ((unused)),
>         const filename_trans_key_t *ft2 = (const filename_trans_key_t *)k2;
>         int v;
>
> -       v = (ft1->ttype > ft2->ttype) - (ft1->ttype < ft2->ttype);
> +       v = spaceship_cmp(ft1->ttype, ft2->ttype);
>         if (v)
>                 return v;
>
> -       v = (ft1->tclass > ft2->tclass) - (ft1->tclass < ft2->tclass);
> +       v = spaceship_cmp(ft1->tclass, ft2->tclass);
>         if (v)
>                 return v;
>
> @@ -843,15 +843,15 @@ static int rangetr_cmp(hashtab_t h __attribute__ ((unused)),
>         const struct range_trans *key2 = (const struct range_trans *)k2;
>         int v;
>
> -       v = key1->source_type - key2->source_type;
> +       v = spaceship_cmp(key1->source_type, key2->source_type);
>         if (v)
>                 return v;
>
> -       v = key1->target_type - key2->target_type;
> +       v = spaceship_cmp(key1->target_type, key2->target_type);
>         if (v)
>                 return v;
>
> -       v = key1->target_class - key2->target_class;
> +       v = spaceship_cmp(key1->target_class, key2->target_class);
>
>         return v;
>  }
> diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> index 72f21262..c63238ab 100644
> --- a/libsepol/src/private.h
> +++ b/libsepol/src/private.h
> @@ -47,6 +47,8 @@
>  #define is_saturated(x) (x == (typeof(x))-1)
>  #define zero_or_saturated(x) ((x == 0) || is_saturated(x))
>
> +#define spaceship_cmp(a, b) (((a) > (b)) - ((a) < (b)))
> +
>  /* Policy compatibility information. */
>  struct policydb_compat_info {
>         unsigned int type;
> --
> 2.32.0
>

