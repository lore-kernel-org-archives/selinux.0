Return-Path: <SRS0=xZUV=UF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37A2C04AB5
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 11:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28DA206E0
	for <selinux@archiver.kernel.org>; Thu,  6 Jun 2019 11:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfFFLil (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:38:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39797 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfFFLil (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Jun 2019 07:38:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id r21so1618991otq.6
        for <selinux@vger.kernel.org>; Thu, 06 Jun 2019 04:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=UzViZIU8geJwF6LYLzLNW+gYQuEiPyvxdesHsZv3e1I=;
        b=TlSbytqEq5hstznD4UXhLcdwQFh5nAk7Q1ky9Juk8kSzrcNBsJAaL6bjsibvNOY0ZS
         z5cAkYezqmdls5SPPNPY7O1lLHjnO1qrQje/+lcTrX8pFhbo+pYjQZVe7GXG1pwi8NLH
         dWCFtWhueaxlBC9MGVsmNg6EolJjvMr+2W6vq1crWk46U+KTrFJ+Vd1LL9MODkh2B3kK
         E/tXGL02fw2a3aUDMHqDHOucyBy9FldnrRtgG75MbWiHTka3J+u/BWGFeWvzGcZKAh89
         hMOWiW97YPUB0ta3GLjtIDsmZpIi6yMRV78XULp/o8bN1Mlz5eMjHFXrAy+9EDpxvnq8
         5lmw==
X-Gm-Message-State: APjAAAVHt/pH+N9ba2LRR/300R3lBr5zO809kIKICR9DNrMYBwmlM98W
        +HpO7KwtR0rrfbYSayvq5KWywzIKeiUXp9wZ1/AL/IKf
X-Google-Smtp-Source: APXvYqxUHlE+bM97rTodmTi170uA6xq0q9bNDqmP3Ue+vzUoHxubYz+FiAOv9PDEf2gdSmegvBMp6LXK7ZxVcXCzd7k=
X-Received: by 2002:a9d:6a8a:: with SMTP id l10mr4186892otq.197.1559821120067;
 Thu, 06 Jun 2019 04:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190529073759.20548-1-omosnace@redhat.com> <20190529073759.20548-7-omosnace@redhat.com>
In-Reply-To: <20190529073759.20548-7-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 6 Jun 2019 13:38:29 +0200
Message-ID: <CAFqZXNtEisULemDzy+qXec5na0PmW7WUtgipeTALA0=TOQ-3Xg@mail.gmail.com>
Subject: Re: [PATCH userspace v3 6/7] [RFC] lisepol: slightly more thorough optimization
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 29, 2019 at 9:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Removes also rules that are covered only by a union of two or more
> rules. There are usually only a few of such rules (if any), but there
> should be almost no (policy build) perfomance cost for this.
>
> Side effect: clears all permission bits covered by a more general rule
> -> might slow down avtab lookups (only a single rule will now match each
> query)

Never mind, I just realized that context_struct_compute_av() goes
through all matching rules and combines the perms together, so this
change should make no difference in kernel lookup times. I'll squash
it into the first patch in the next respin unless there are
objections.

> ---
>  libsepol/src/optimize.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
> index b3859b6c..abb711e7 100644
> --- a/libsepol/src/optimize.c
> +++ b/libsepol/src/optimize.c
> @@ -73,36 +73,38 @@ static void destroy_type_map(const policydb_t *p, ebitmap_t *type_map)
>         free(type_map);
>  }
>
> -static int match_xperms(const uint32_t *p1, const uint32_t *p2)
> +static int process_xperms(uint32_t *p1, const uint32_t *p2)
>  {
>         size_t i;
> +       int ret = 1;
>
>         for (i = 0; i < EXTENDED_PERMS_LEN; i++) {
> -               if ((p2[i] & p1[i]) != p1[i])
> -                       return 0;
> +               p1[i] &= ~p2[i];
> +               if (p1[i] != 0)
> +                       ret = 0;
>         }
> -       return 1;
> +       return ret;
>  }
>
> -static int match_avtab_datum(uint16_t specified,
> -                            const avtab_datum_t *d1, const avtab_datum_t *d2)
> +static int process_avtab_datum(uint16_t specified,
> +                              avtab_datum_t *d1, const avtab_datum_t *d2)
>  {
>         /* inverse logic needed for AUDITDENY rules */
>         if (specified & AVTAB_AUDITDENY)
> -               return (d1->data & d2->data) == d2->data;
> +               return (d1->data |= ~d2->data) == 0xFFFFFFFF;
>
>         if (specified & AVTAB_AV)
> -               return (d2->data & d1->data) == d1->data;
> +               return (d1->data &= ~d2->data) == 0;
>
>         if (specified & AVTAB_XPERMS) {
> -               const avtab_extended_perms_t *x1 = d1->xperms;
> +               avtab_extended_perms_t *x1 = d1->xperms;
>                 const avtab_extended_perms_t *x2 = d2->xperms;
>
>                 if (x1->specified == AVTAB_XPERMS_IOCTLFUNCTION) {
>                         if (x2->specified == AVTAB_XPERMS_IOCTLFUNCTION) {
>                                 if (x1->driver != x2->driver)
>                                         return 0;
> -                               return match_xperms(x1->perms, x2->perms);
> +                               return process_xperms(x1->perms, x2->perms);
>                         }
>                         if (x2->specified == AVTAB_XPERMS_IOCTLDRIVER)
>                                 return xperm_test(x1->driver, x2->perms);
> @@ -111,7 +113,7 @@ static int match_avtab_datum(uint16_t specified,
>                                 return 0;
>
>                         if (x2->specified == AVTAB_XPERMS_IOCTLDRIVER)
> -                               return match_xperms(x1->perms, x2->perms);
> +                               return process_xperms(x1->perms, x2->perms);
>                 }
>                 return 0;
>         }
> @@ -152,7 +154,7 @@ static int is_avrule_redundant(avtab_ptr_t entry, avtab_t *tab,
>                         if (!d2)
>                                 continue;
>
> -                       if (match_avtab_datum(key.specified, d1, d2))
> +                       if (process_avtab_datum(key.specified, d1, d2))
>                                 return 1;
>                 }
>         }
> @@ -205,7 +207,7 @@ static int is_cond_rule_redundant(avtab_ptr_t e1, cond_av_list_t *list,
>                 if (!ebitmap_get_bit(&type_map[t1], t2))
>                         continue;
>
> -               if (match_avtab_datum(k1, &e1->datum, &e2->datum))
> +               if (process_avtab_datum(k1, &e1->datum, &e2->datum))
>                         return 1;
>         }
>         return 0;
> --
> 2.20.1
>


--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
