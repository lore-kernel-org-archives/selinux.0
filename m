Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42119C433ED
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 23:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E925A610D0
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 23:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhDAXCz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Apr 2021 19:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbhDAXCy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Apr 2021 19:02:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354E1C0613E6
        for <selinux@vger.kernel.org>; Thu,  1 Apr 2021 16:02:54 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id r12so5183018ejr.5
        for <selinux@vger.kernel.org>; Thu, 01 Apr 2021 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W7MGZVBzOxxLtZSfxZQAYVznqULDgrJXC+CI4rai3tE=;
        b=e15dnILydvdLtrcgLaXLxM6pMrwHjD0+WQAJNmo+Mff1XLn50wVPS/lg7ym1kcUEp0
         RXFgWWeaXUqwITTuzvaJrESOuatcG/EC8alcGXaK2SivFcsORfCwugNyxWYqYPUUlcK/
         W5ZtRDO2Uu7cildJAbPxYODeWIodA1HBTFALbjhMXBexrQndE4jqP4Sv/O8Orz01XljY
         1EU7wlawJyXWlIQYANHFWAsWUp/IcOocHqDZ7mu+4mf9F80Q3vbXMLCsIycQic3tfVZ9
         NOoOtyFiikFB7+qRz07fC3HMb6bKyy2cY5YGuA7D/QXJTWMLPK2/iATZqrlPTGv2BtBk
         hoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W7MGZVBzOxxLtZSfxZQAYVznqULDgrJXC+CI4rai3tE=;
        b=OjFHOFVI3IwQip0r275ZFYRO5hu0/VkE7j6N9Ckr2EpyzqEf0GXcBKKeTbNVOo6cbZ
         WSy8sArfADO0fHC2F9MB6BM6/UMGkZQCvPKZJSUhA1Z7pr5WMIPTD2JU0vQnItpgEFCH
         SL7r8PTCuS2z8RFGfO8Q+r7w12yxDURLLo5sTV+IARno8Ib1HjfFWrPFz/YjABuLkKFr
         gQQd0VOC6JUJBAtVWb5VMAiJ03+VmMCo1rwA9S9RPEZdb34HbIn6nm5Uc9tRfObjoT2E
         h5+rxUcLiZc44USWw2uHyApB+0nZy3f9kspcLDbitNJ9mVZ6ugro63zYsZnzay9HMByJ
         IcZQ==
X-Gm-Message-State: AOAM533NU+n3cuo/KssZyXlqG8xrNWNZ5nFFuoInNA2k+kFbX/GAp8Fu
        Z/cKJpr5TOJkaX33dj5Ydnd8FbAmsyLWqpw8iBFBbt1jBw==
X-Google-Smtp-Source: ABdhPJyxAPZsmUXULa7lqeBaF2rwlIr1Fgb3hxJrIGgXnyCmauXtJON1rXehr+ZObRLxF5xOCCBY6yuTE8qa0khT7HY=
X-Received: by 2002:a17:906:f283:: with SMTP id gu3mr11228144ejb.91.1617318172663;
 Thu, 01 Apr 2021 16:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210401155913.1693097-1-omosnace@redhat.com> <20210401155913.1693097-3-omosnace@redhat.com>
In-Reply-To: <20210401155913.1693097-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Apr 2021 19:02:41 -0400
Message-ID: <CAHC9VhQ2rUxGJ-p4QzaUtwqSAp1q6-GdGX1ccLd+ssvt-71GjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: fix cond_list corruption when changing booleans
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 1, 2021 at 11:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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
> While there, also simplify the computation of nslots. This changes the
> nslots values for nrules 2 or 3 to just two slots instead of 4, which
> makes the sequence more consistent.
>
> Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/avtab.c       | 88 +++++++++----------------------
>  security/selinux/ss/avtab.h       |  2 +-
>  security/selinux/ss/conditional.c | 12 ++---
>  3 files changed, 33 insertions(+), 69 deletions(-)

...

> diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> index 2aee4c965c25..f9d60010041e 100644
> --- a/security/selinux/ss/avtab.c
> +++ b/security/selinux/ss/avtab.c
> @@ -333,59 +319,37 @@ int avtab_alloc(struct avtab *h, u32 nrules)
>
>         h->nslot = nslot;
>         h->mask = nslot - 1;
> -
> -avtab_alloc_out:
> -       pr_debug("SELinux: %d avtab hash slots, %d rules.\n",
> -              h->nslot, nrules);
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
> -
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
> +       int rc;
> +       u32 nslot = 0;
> +
> +       if (nrules != 0) {
> +               u32 shift = 1;
> +               u32 work = nrules >> 3;
> +               while (work) {
> +                       work >>= 1;
> +                       shift++;
>                 }
> +               nslot = 1 << shift;
> +               if (nslot > MAX_AVTAB_HASH_BUCKETS)
> +                       nslot = MAX_AVTAB_HASH_BUCKETS;
>         }
>
> +       rc = avtab_alloc_common(h, nslot);
> +       if (rc)
> +               return rc;

Now that all of the avtab initialization is done in avtab_init(),
thanks to patch 1/2, it doesn't really make sense to call
avtab_alloc_common() here when 'nrules == 0', right?  Granted it is
safe since you check for zero rules in the function, but making the
call in the first place seems a bit pointless.  I would suggest either
moving the avtab_alloc_common() call up into the if body above it or
checking for 'nrules == 0' at the top of the function and jumping down
to the pr_debug()/return if true.

> +       pr_debug("SELinux: %d avtab hash slots, %d rules.\n", nslot, nrules);
>         return 0;
> -error:
> -       avtab_destroy(new);
> -       return -ENOMEM;
> +}

-- 
paul moore
www.paul-moore.com
