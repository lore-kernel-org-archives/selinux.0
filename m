Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2499AC433DB
	for <selinux@archiver.kernel.org>; Wed, 31 Mar 2021 02:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE22C6192B
	for <selinux@archiver.kernel.org>; Wed, 31 Mar 2021 02:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhCaCEq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 22:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhCaCE2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 22:04:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C429C061574
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 19:04:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b16so20398025eds.7
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 19:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+tLZPNePsV7b/b0OHtj71s9WmczhSr/OXQdMNHiNRDg=;
        b=zWQUd9lhFThi+lq+9i8zJdQ03hwJJCB5iHc8v9APi73YSTmfI0L8QRJE3pDUTpuhsP
         5kEPthMDlQvYWXzB6tLFoaaljA/vKYwi763lFSzdYEaXfwLoDcfwgvH8D1TsiW3DIXSH
         ldLy1JDiP8DvBAq9d/EKYApV70BjchZa8Ri/Yc0C+6ZL/fRqyRC9ynE4Zum0ppnrcVq1
         SsJTKHg88eodONURsobYZu0pcpjBq8bXXbQg5QgPL+fMtSV2/VPWO5f+VPBns2PYIp4e
         QMVEcabNG3oyMa+9UEf5Sj230la0nWn0sZ+AjkydGXUNfZ6yp6D/23Yg/BEGi+iT1+Ck
         Yp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+tLZPNePsV7b/b0OHtj71s9WmczhSr/OXQdMNHiNRDg=;
        b=UWdfcBP1/9rwM0KOrq9or45Z3J0cDw832Rb58pBdGDM/M1mThCUQr+PVOK5L3hg33w
         wxJJ2F0ZybiqQgRfGs3cEN+reFjtAlY3o77KsLtRYcgpToqMaSlBl5ulBcIE1sPAC2+S
         xCLDExtqZyfd/0oKg1VBvmvf0eHOwSWfzOx0xeqZ3KhJzsYtWKx5m30l2fpjHDVMKdOB
         orHcuKc0bGZC+EuFTsIfhDnKmtj/eZIcYvHy8jzVI9Q2ZNcOW9Vxt2XDrRKiGHEfVCQL
         UN8BX3I83W/zb5Tw4iMQj5dj77yXTvCQJkgLeU8OjYSAyaYr0FlMVMCVJcd4Oah4ouTN
         kB7g==
X-Gm-Message-State: AOAM5300Ftn1hV7cxjqfkYjt1n3qsWgf2Yr8ePXhyO63YU27JOqfr1y3
        jW5T0SrwCxwti9obSoAUG+KJbRI+uWA282rAEJiW
X-Google-Smtp-Source: ABdhPJzXZV15t7woEJm9Jxx8IHAqVjEdw6u8NQpT/c4t9KegPhFW8rbpq0TZOzaKnfRuKaM5VgkV2k7zd8Oc706PBwE=
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr816349edb.135.1617156265574;
 Tue, 30 Mar 2021 19:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210330131646.1401838-1-omosnace@redhat.com> <20210330131646.1401838-2-omosnace@redhat.com>
In-Reply-To: <20210330131646.1401838-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Mar 2021 22:04:14 -0400
Message-ID: <CAHC9VhQ4Hc1VccUjR7cMq_Lm2YOn=i=w_FahZ7ZFnoxz+iKUPA@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: fix cond_list corruption when changing booleans
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 30, 2021 at 9:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Currently, duplicate_policydb_cond_list() first copies the whole
> conditional avtab and then tries to link to the correct entries in
> cond_dup_av_list() using avtab_search(). However, since the conditional
> avtab may contain multiple entries with the same key, this approach
> often fails to find the right entry, potentially leading to wrong rules
> being activated/deactivated when booleans are changed.
>
> To fix this, instead start with an empty conditional avtab and add the
> individual entries one-by-one while building the new av_lists. This
> approach leads to the correct result, since each entry is present in the
> av_lists exactly once.
>
> The issue can be reproduced with Fedora policy as follows:
>
>     # sesearch -s ftpd_t -t public_content_rw_t -c dir -p create -A
>     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
>     allow ftpd_t public_content_rw_t:dir { add_name create link remove_name rename reparent rmdir setattr unlink watch watch_reads write }; [ ftpd_anon_write ]:True
>     # setsebool ftpd_anon_write=off ftpd_connect_all_unreserved=off ftpd_connect_db=off ftpd_full_access=off
>
> On fixed kernels, the sesearch output is the same after the setsebool
> command:
>
>     # sesearch -s ftpd_t -t public_content_rw_t -c dir -p create -A
>     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
>     allow ftpd_t public_content_rw_t:dir { add_name create link remove_name rename reparent rmdir setattr unlink watch watch_reads write }; [ ftpd_anon_write ]:True
>
> While on the broken kernels, it will be different:
>
>     # sesearch -s ftpd_t -t public_content_rw_t -c dir -p create -A
>     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
>     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
>     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
>
> Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/avtab.c       | 90 +++++++++----------------------
>  security/selinux/ss/avtab.h       |  2 +-
>  security/selinux/ss/conditional.c | 12 ++---
>  3 files changed, 33 insertions(+), 71 deletions(-)
>
> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 6dcb6aa4db7f..11f8f524de98 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -305,86 +305,48 @@ void avtab_init(struct avtab *h)
>         h->nel = 0;
>  }
>
> -int avtab_alloc(struct avtab *h, u32 nrules)
> +static int avtab_alloc_common(struct avtab *h, u32 nslot)
>  {
> -       u32 mask = 0;
> -       u32 shift = 0;
> -       u32 work = nrules;
> -       u32 nslot = 0;
> -
> -       if (nrules == 0)
> -               goto avtab_alloc_out;
> -
> -       while (work) {
> -               work  = work >> 1;
> -               shift++;
> -       }
> -       if (shift > 2)
> -               shift = shift - 2;
> -       nslot = 1 << shift;
> -       if (nslot > MAX_AVTAB_HASH_BUCKETS)
> -               nslot = MAX_AVTAB_HASH_BUCKETS;
> -       mask = nslot - 1;
> -
>         h->htable = kvcalloc(nslot, sizeof(void *), GFP_KERNEL);
>         if (!h->htable)
>                 return -ENOMEM;

Hmmm, do we need to protect against 'nslot == 0'?  Unless I missed
something, a quick dive into kvcalloc() makes it look like it can
return non-NULL for zero length allocations, at least in the slab
case.

> - avtab_alloc_out:
>         h->nel = 0;
>         h->nslot = nslot;
> -       h->mask = mask;
> -       pr_debug("SELinux: %d avtab hash slots, %d rules.\n",
> -              h->nslot, nrules);
> +       h->mask = nslot - 1;

This is definitely not good if 'nslot <= 1';

>         return 0;
>  }
>
> -int avtab_duplicate(struct avtab *new, struct avtab *orig)
> +int avtab_alloc(struct avtab *h, u32 nrules)
>  {
> -       int i;
> -       struct avtab_node *node, *tmp, *tail;
> -
> -       memset(new, 0, sizeof(*new));
> +       int rc;
> +       u32 shift = 0;
> +       u32 work = nrules;
> +       u32 nslot = 0;
>
> -       new->htable = kvcalloc(orig->nslot, sizeof(void *), GFP_KERNEL);
> -       if (!new->htable)
> -               return -ENOMEM;
> -       new->nslot = orig->nslot;
> -       new->mask = orig->mask;
> -
> -       for (i = 0; i < orig->nslot; i++) {
> -               tail = NULL;
> -               for (node = orig->htable[i]; node; node = node->next) {
> -                       tmp = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
> -                       if (!tmp)
> -                               goto error;
> -                       tmp->key = node->key;
> -                       if (tmp->key.specified & AVTAB_XPERMS) {
> -                               tmp->datum.u.xperms =
> -                                       kmem_cache_zalloc(avtab_xperms_cachep,
> -                                                       GFP_KERNEL);
> -                               if (!tmp->datum.u.xperms) {
> -                                       kmem_cache_free(avtab_node_cachep, tmp);
> -                                       goto error;
> -                               }
> -                               tmp->datum.u.xperms = node->datum.u.xperms;
> -                       } else
> -                               tmp->datum.u.data = node->datum.u.data;
> -
> -                       if (tail)
> -                               tail->next = tmp;
> -                       else
> -                               new->htable[i] = tmp;
> -
> -                       tail = tmp;
> -                       new->nel++;
> +       if (nrules != 0) {
> +               while (work) {
> +                       work  = work >> 1;

Extra  horizontal  spaces  are  awkward  and  bad.

> +                       shift++;
>                 }
> +               if (shift > 2)
> +                       shift = shift - 2;

Since we are getting nit-picky with this code, why not make the
loop/if a bit more elegant?  How about something like below?

  u32 shift = 2;
  u32 work = nrules >> 4;
  while (work) {
    work >>= 1;
    shift++;
  }

> +               nslot = 1 << shift;
> +               if (nslot > MAX_AVTAB_HASH_BUCKETS)
> +                       nslot = MAX_AVTAB_HASH_BUCKETS;
>         }
>
> +       rc = avtab_alloc_common(h, nslot);
> +       if (rc)
> +               return rc;
> +
> +       pr_debug("SELinux: %d avtab hash slots, %d rules.\n", nslot, nrules);
>         return 0;
> -error:
> -       avtab_destroy(new);
> -       return -ENOMEM;
> +}
> +
> +int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
> +{
> +       return avtab_alloc_common(new, orig->nslot);
>  }

-- 
paul moore
www.paul-moore.com
