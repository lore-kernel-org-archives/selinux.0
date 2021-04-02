Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA009C433B4
	for <selinux@archiver.kernel.org>; Fri,  2 Apr 2021 08:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B6C61003
	for <selinux@archiver.kernel.org>; Fri,  2 Apr 2021 08:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhDBI67 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Apr 2021 04:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51101 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229924AbhDBI66 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Apr 2021 04:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617353933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FhhGqJZJHAO3nRxBOaP+8SOGe1Su3zFMgT1rLn2dLLU=;
        b=Ewif6W3PxMGSq+yOMrcbMCy4cGR0zD5izSjYIN/NTEpz+Qumr1vzjplq472EgO0JlJ+/c9
        T9gKD3zWJTfcRg5/j4FG7l4HvThnLKt4TSrA7RkOG2h1w5KGjqrq3BSV+ZdM2Vh8p/8vc1
        W/GFTTXOFlWxrVEusR5QMklzXMQYmNs=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337--kod4BDzNOGHLuUfvTSiwg-1; Fri, 02 Apr 2021 04:58:51 -0400
X-MC-Unique: -kod4BDzNOGHLuUfvTSiwg-1
Received: by mail-yb1-f199.google.com with SMTP id 10so8740186ybx.11
        for <selinux@vger.kernel.org>; Fri, 02 Apr 2021 01:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhhGqJZJHAO3nRxBOaP+8SOGe1Su3zFMgT1rLn2dLLU=;
        b=mBWUdNTMEwLBKygQbC3o8Mt6FHqLnhsdQT0lYoorD/o+e9PSQLCWnKQLUMR6bXgBSa
         Qb+wVbWDOIxWVSgiUJk8udE4G6d7CrVhawehH8TzscCx7Ofv9e255VLRZkzhxYpgLIod
         tIXL/Rd2RzoKbq1KCSwUnWZ+Jxhb9LoNsUTanfBBz98fOAMsBuzyHxLk0h1+52GTmc93
         LuH2egdzT9YtjKhlDXsZpL6ra8dJKRncsA/lU3Snpsoa0ILTh9Rsh8d1D8BZzqApOPhA
         fMDEyIUrorC+eCqPfrb57jR3DUsjz/xnBV06WmTyLAPXEFcbhh2LGBeCLAnw3TN0kadc
         Ks3Q==
X-Gm-Message-State: AOAM532mS0dht8bdKJ5URC8lFqcXj2GO3lKyMHpbZ1038lSKtAjMOdxx
        ogweU+XfrYYgOtRl7/43py6D8nm7bFtuSms+SZteHdeRRukbJCALEHiTzFAVmBbO3oTf8pcM05e
        4P79sbPLvw+i9huzbC5iQa+pqurfgvuYk1Q==
X-Received: by 2002:a25:c750:: with SMTP id w77mr17319915ybe.340.1617353930496;
        Fri, 02 Apr 2021 01:58:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZv6eDNrJ10OQDtjqTRulm7AjGAIYiGykNwOrAgmJZ3HK3uW3cIJJiKfKgGjVurmXzf5D1Q00wRXKm5mDXnJ0=
X-Received: by 2002:a25:c750:: with SMTP id w77mr17319902ybe.340.1617353930289;
 Fri, 02 Apr 2021 01:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210401155913.1693097-1-omosnace@redhat.com> <20210401155913.1693097-3-omosnace@redhat.com>
 <CAHC9VhQ2rUxGJ-p4QzaUtwqSAp1q6-GdGX1ccLd+ssvt-71GjQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQ2rUxGJ-p4QzaUtwqSAp1q6-GdGX1ccLd+ssvt-71GjQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 2 Apr 2021 10:58:38 +0200
Message-ID: <CAFqZXNuAV5Ya8jK-0KG0iXDve6LKiKAhp4Ly2j8g_-P8DRepOA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: fix cond_list corruption when changing booleans
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 2, 2021 at 1:02 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Apr 1, 2021 at 11:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Currently, duplicate_policydb_cond_list() first copies the whole
> > conditional avtab and then tries to link to the correct entries in
> > cond_dup_av_list() using avtab_search(). However, since the conditional
> > avtab may contain multiple entries with the same key, this approach
> > often fails to find the right entry, potentially leading to wrong rules
> > being activated/deactivated when booleans are changed.
> >
> > To fix this, instead start with an empty conditional avtab and add the
> > individual entries one-by-one while building the new av_lists. This
> > approach leads to the correct result, since each entry is present in the
> > av_lists exactly once.
> >
> > The issue can be reproduced with Fedora policy as follows:
> >
> >     # sesearch -s ftpd_t -t public_content_rw_t -c dir -p create -A
> >     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
> >     allow ftpd_t public_content_rw_t:dir { add_name create link remove_name rename reparent rmdir setattr unlink watch watch_reads write }; [ ftpd_anon_write ]:True
> >     # setsebool ftpd_anon_write=off ftpd_connect_all_unreserved=off ftpd_connect_db=off ftpd_full_access=off
> >
> > On fixed kernels, the sesearch output is the same after the setsebool
> > command:
> >
> >     # sesearch -s ftpd_t -t public_content_rw_t -c dir -p create -A
> >     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
> >     allow ftpd_t public_content_rw_t:dir { add_name create link remove_name rename reparent rmdir setattr unlink watch watch_reads write }; [ ftpd_anon_write ]:True
> >
> > While on the broken kernels, it will be different:
> >
> >     # sesearch -s ftpd_t -t public_content_rw_t -c dir -p create -A
> >     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
> >     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
> >     allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
> >
> > While there, also simplify the computation of nslots. This changes the
> > nslots values for nrules 2 or 3 to just two slots instead of 4, which
> > makes the sequence more consistent.
> >
> > Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/avtab.c       | 88 +++++++++----------------------
> >  security/selinux/ss/avtab.h       |  2 +-
> >  security/selinux/ss/conditional.c | 12 ++---
> >  3 files changed, 33 insertions(+), 69 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> > index 2aee4c965c25..f9d60010041e 100644
> > --- a/security/selinux/ss/avtab.c
> > +++ b/security/selinux/ss/avtab.c
> > @@ -333,59 +319,37 @@ int avtab_alloc(struct avtab *h, u32 nrules)
> >
> >         h->nslot = nslot;
> >         h->mask = nslot - 1;
> > -
> > -avtab_alloc_out:
> > -       pr_debug("SELinux: %d avtab hash slots, %d rules.\n",
> > -              h->nslot, nrules);
> >         return 0;
> >  }
> >
> > -int avtab_duplicate(struct avtab *new, struct avtab *orig)
> > +int avtab_alloc(struct avtab *h, u32 nrules)
> >  {
> > -       int i;
> > -       struct avtab_node *node, *tmp, *tail;
> > -
> > -       memset(new, 0, sizeof(*new));
> > -
> > -       new->htable = kvcalloc(orig->nslot, sizeof(void *), GFP_KERNEL);
> > -       if (!new->htable)
> > -               return -ENOMEM;
> > -       new->nslot = orig->nslot;
> > -       new->mask = orig->mask;
> > -
> > -       for (i = 0; i < orig->nslot; i++) {
> > -               tail = NULL;
> > -               for (node = orig->htable[i]; node; node = node->next) {
> > -                       tmp = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
> > -                       if (!tmp)
> > -                               goto error;
> > -                       tmp->key = node->key;
> > -                       if (tmp->key.specified & AVTAB_XPERMS) {
> > -                               tmp->datum.u.xperms =
> > -                                       kmem_cache_zalloc(avtab_xperms_cachep,
> > -                                                       GFP_KERNEL);
> > -                               if (!tmp->datum.u.xperms) {
> > -                                       kmem_cache_free(avtab_node_cachep, tmp);
> > -                                       goto error;
> > -                               }
> > -                               tmp->datum.u.xperms = node->datum.u.xperms;
> > -                       } else
> > -                               tmp->datum.u.data = node->datum.u.data;
> > -
> > -                       if (tail)
> > -                               tail->next = tmp;
> > -                       else
> > -                               new->htable[i] = tmp;
> > -
> > -                       tail = tmp;
> > -                       new->nel++;
> > +       int rc;
> > +       u32 nslot = 0;
> > +
> > +       if (nrules != 0) {
> > +               u32 shift = 1;
> > +               u32 work = nrules >> 3;
> > +               while (work) {
> > +                       work >>= 1;
> > +                       shift++;
> >                 }
> > +               nslot = 1 << shift;
> > +               if (nslot > MAX_AVTAB_HASH_BUCKETS)
> > +                       nslot = MAX_AVTAB_HASH_BUCKETS;
> >         }
> >
> > +       rc = avtab_alloc_common(h, nslot);
> > +       if (rc)
> > +               return rc;
>
> Now that all of the avtab initialization is done in avtab_init(),
> thanks to patch 1/2, it doesn't really make sense to call
> avtab_alloc_common() here when 'nrules == 0', right?  Granted it is
> safe since you check for zero rules in the function, but making the
> call in the first place seems a bit pointless.  I would suggest either
> moving the avtab_alloc_common() call up into the if body above it or
> checking for 'nrules == 0' at the top of the function and jumping down
> to the pr_debug()/return if true.

Ok, moved it under the conditional in v3.

>
> > +       pr_debug("SELinux: %d avtab hash slots, %d rules.\n", nslot, nrules);
> >         return 0;
> > -error:
> > -       avtab_destroy(new);
> > -       return -ENOMEM;
> > +}
>
> --
> paul moore
> www.paul-moore.com
>


-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

