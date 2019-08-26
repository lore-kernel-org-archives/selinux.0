Return-Path: <SRS0=L6MV=WW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74E8C3A59F
	for <selinux@archiver.kernel.org>; Mon, 26 Aug 2019 21:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF8B20850
	for <selinux@archiver.kernel.org>; Mon, 26 Aug 2019 21:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="E63dYgoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfHZVTW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:19:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33389 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfHZVTV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Aug 2019 17:19:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id z17so16489199ljz.0
        for <selinux@vger.kernel.org>; Mon, 26 Aug 2019 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6QAglOZ5A4LRRhx1jeNlqalFIQLuij8axSSqlCEu0A=;
        b=E63dYgoQeWkQPGKufGxettpIvZ+6cgYewrI1uB0eBjgL0Gc8anOZJfyNgfSPSs+OuC
         zqwADf1Q2WGuaVlwr6lB3SRCrWT1j5Dq1w4bE/Am1p3dlnGShizWaDlO+NHyNodj/kdw
         xGDBgBpvSNojG1FI2dap8aAOZtqPkxlO5WHPzD5DuRPBAFoLjRIPBe5QlR72f9B+iflG
         nFwKXhewxayiqALTgL0R+du7XIZEv5tVi9IVlgCPoaz5hBP+blqjFuPpbwjj2R/cX6ds
         DV/UryLgvCm3SXMRQmCe+TVvq8tpDX6GqVvLnMRACzun12mPqADutLWoUx1Vk54a3p6X
         8wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6QAglOZ5A4LRRhx1jeNlqalFIQLuij8axSSqlCEu0A=;
        b=DVGPSLhNEKPC6ZXKCOFiHWkHKBm5qIA5ECroWO10795EHGha+78N9iZAUD7kNcFw4t
         aMOcZB0LqGiZfSOkniyMNBI74/woi8eAGXbyR0HroSbQm0r6lekG6Qvsrwc4e35U4yR2
         uuE4tuMH7ZZjRPED7BAKPsmFVrEyZuPVTXjN2xx8dKM51hm/9Rof8T17sbxpb2CIyFBo
         JcjCrJVXXWwQNu2tqnvl8Rnwnyq8GGeL5n5L0MCrhtN4/aJKcWfAtJ5pM58r+0yFcebP
         duCOCyOodWNnZxK1RuzP6oMtnmF+t4XgZyZOstCLcF9DUKIngX8p0qNfXkapV3bFj4u6
         p9CA==
X-Gm-Message-State: APjAAAV3QvUfib5IkVY3NA+jaqL0V8HdzORV5EZ8N+kAZAKeSHuPuxeA
        GczGiXsI1V3SlxaTk1YIIatNyjtsTsi5rnm3IErM
X-Google-Smtp-Source: APXvYqxtsGIVbHQ3HCuP+5JBXO0Lm2v0oOpIEUyPwarqQCfmsiQdnA+NU4anbHtBhbXhRgMuPJF73u4cguFPT6WRGFA=
X-Received: by 2002:a2e:9757:: with SMTP id f23mr10411861ljj.91.1566854358678;
 Mon, 26 Aug 2019 14:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190826142008.2198-1-joshua.brindle@crunchydata.com>
In-Reply-To: <20190826142008.2198-1-joshua.brindle@crunchydata.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Aug 2019 17:19:06 -0400
Message-ID: <CAHC9VhRXyRDjj3KJDHvA4ruJg6H+1kzFPzfA-PLZ-NqBicsLrw@mail.gmail.com>
Subject: Re: [PATCH] default_range glblub implementation
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 26, 2019 at 10:20 AM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
> A policy developer can now specify glblub as a default_range default and
> the computed transition will be the intersection of the mls range of
> the two contexts.
>
> Signed-off-by: Joshua Brindle <joshua.brindle@crunchydata.com>
> ---
>  security/selinux/include/security.h |  3 ++-
>  security/selinux/ss/context.h       |  6 ++++++
>  security/selinux/ss/ebitmap.c       | 15 +++++++++++++++
>  security/selinux/ss/ebitmap.h       |  1 +
>  security/selinux/ss/mls.c           |  2 ++
>  security/selinux/ss/mls_types.h     | 28 ++++++++++++++++++++++++++++
>  security/selinux/ss/policydb.c      |  5 +++++
>  security/selinux/ss/policydb.h      |  1 +
>  8 files changed, 60 insertions(+), 1 deletion(-)

Independent from the comments below I think we need to additional
things for this patch:

* A much better description.  At the very least I would like you to
explain the MLS bounding and how one might use this (think sample
code); and don't worry about your description being too long ;)
* Tests (see the selinux-testsuite).

> diff --git a/security/selinux/ss/context.h b/security/selinux/ss/context.h
> index 2260c44a568c..cecb84d8b26c 100644
> --- a/security/selinux/ss/context.h
> +++ b/security/selinux/ss/context.h
> @@ -95,6 +95,12 @@ static inline int mls_context_cpy_high(struct context *dst, struct context *src)
>         return rc;
>  }
>
> +
> +static inline int mls_context_glblub(struct context *dst, struct context *c1, struct context *c2)
> +{
> +       return mls_range_glblub(&dst->range, &c1->range, &c2->range);
> +}

Considering the other functions that are already defined in context.h,
it seems like you could get rid of mls_range_glblub() and put the guts
in mls_context_glblub(), yes?  Unless I missed something
mls_range_glblub() is only ever called from mls_context_glblub() which
makes one of these functions pointless.

>  static inline int mls_context_cmp(struct context *c1, struct context *c2)
>  {
>         return ((c1->range.level[0].sens == c2->range.level[0].sens) &&
> diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
> index 09929fc5ab47..2042729b81f8 100644
> --- a/security/selinux/ss/ebitmap.c
> +++ b/security/selinux/ss/ebitmap.c
> @@ -77,6 +77,21 @@ int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src)
>         return 0;
>  }
>
> +int ebitmap_and(struct ebitmap *dst, struct ebitmap *e1, struct ebitmap *e2)
> +{
> +       unsigned int i, length = min(ebitmap_length(e1), ebitmap_length(e2));

A line of vertical whitespace here would be nice.

> +       ebitmap_init(dst);
> +       for (i=0; i < length; i++) {
> +               if (ebitmap_get_bit(e1, i) && ebitmap_get_bit(e2, i)) {
> +                       int rc = ebitmap_set_bit(dst, i, 1);
> +                       if (rc < 0)
> +                               return rc;
> +               }
> +       }

Same as above, a line of vertical whitespace would be nice.

Beyond that, since this is an AND operation, could we make better use
of things like find_first_bit()/ebitmap_start_positive()/ebitmap_next_positive()
to skip along one of the bitmaps instead of needing to call
ebitmap_get_bit() for each bit?  I imagine it would be quicker that
way.

> +       return 0;
> +}

...

> diff --git a/security/selinux/ss/mls_types.h b/security/selinux/ss/mls_types.h
> index 068e0d7809db..e2a20eb0e87c 100644
> --- a/security/selinux/ss/mls_types.h
> +++ b/security/selinux/ss/mls_types.h
> @@ -39,6 +39,34 @@ static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
>                 ebitmap_contains(&l1->cat, &l2->cat, 0));
>  }
>
> +static inline int mls_range_glblub(struct mls_range *dst, struct mls_range *r1, struct mls_range *r2)
> +{
> +       int rc = 0;
> +
> +       if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens < r1->level[0].sens) {
> +       {

These braces aren't necessary, take them from the patch and give them
to a child in need.

> +               // These ranges have no common sensitivities

Please use the old C style comments instead of the C++ style comments
(this applies to the whole patch).  I know you don't track kernel
development very closely, but we just had a discussion about this
on-list earlier this summer.

> +               return -1;
> +       }
> +
> +       // Take the greatest of the low
> +       dst->level[0].sens = max(r1->level[0].sens, r2->level[0].sens);
> +
> +        // Take the least of the high
> +       dst->level[1].sens = min(r1->level[1].sens, r2->level[1].sens);
> +
> +       rc = ebitmap_and(&dst->level[0].cat, &r1->level[0].cat, &r2->level[0].cat);
> +       if (rc)
> +               goto out;
> +
> +       rc = ebitmap_and(&dst->level[1].cat, &r1->level[1].cat, &r2->level[1].cat);
> +       if (rc)
> +               goto out;
> +
> +out:
> +       return rc;
> +}

-- 
paul moore
www.paul-moore.com
