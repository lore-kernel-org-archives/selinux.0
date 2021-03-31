Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59DFC433C1
	for <selinux@archiver.kernel.org>; Wed, 31 Mar 2021 09:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC045619BD
	for <selinux@archiver.kernel.org>; Wed, 31 Mar 2021 09:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbhCaJMt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:12:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38009 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234231AbhCaJMR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Mar 2021 05:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617181937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WMRlKgyrgJpM16Fmri1iycjG89Hf9oU8UzFJNOjue8g=;
        b=DdVYtESUOX1UB5CTIIfjO6bKgxb21AtyYfZU9bdinSY/igSSovAOWcEIxLMR2A+yZtESR3
        TRPkNO/WEyxw62Zm+roDQM7Ag9boYKBJGwSV62AJcPqk6X3gu8DVTpoy8WlIK6+WFqhyku
        2f622Zj9zbmdwAe1/zMjqJb+PW9D6kA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-0MXXe8efNfSJYf9HTpPfmw-1; Wed, 31 Mar 2021 05:12:13 -0400
X-MC-Unique: 0MXXe8efNfSJYf9HTpPfmw-1
Received: by mail-yb1-f198.google.com with SMTP id e129so1575609yba.3
        for <selinux@vger.kernel.org>; Wed, 31 Mar 2021 02:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMRlKgyrgJpM16Fmri1iycjG89Hf9oU8UzFJNOjue8g=;
        b=swobop4SzekGChcAeNbRlfPciCMdgRXujSptFI0vMFF2qywEQBp0gbzGPvJZqAUIe9
         Or2L2gKNudIYa5j/CmY4CQry82eF4o6VqvjEILrmhyW6XUouZn1siaxgnTpllIa6P4gs
         zivbnQJ4zzKr1+1q+6amCcvOxUoPKpcxkVsiDiIUZKMPY/JJR902PWRGPY/hjRUlStR6
         1yrtG9yycSoH/F3ctCm2GgryCkgOAywIwpTWITqdNEEewumnhbEwLr9sCWToN9aAxAz9
         bH06HV7CqgSFNoWCvPSnTaZhkExkW6i9mbpQpQ5GV0IdqZBfAyOYx53SlFqHm8/wMzlV
         Suxw==
X-Gm-Message-State: AOAM5330+PKBCQVl/bV+hPwZaXzV8qFAB1RRKuauM+V6EQfQMyp/DaW1
        1xC+nOSKZ4+hCjUrT6j35+7DSiyiTiRVfBnGhtb2NEZZmmF/gYVTJndOZp2wNZ3NX9aOkp2RL1q
        6fyiNfIf0clD8BWwgldYty960mtCd4EIx1g==
X-Received: by 2002:a25:ad57:: with SMTP id l23mr3349048ybe.172.1617181932701;
        Wed, 31 Mar 2021 02:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4tjCRsw9OS2Se2MwR+u1QaGf8hwXgGtNTe4bQeLudN+LehCVFRkd98Ba6DEIEFQ8rYnUT9OTtPutQFXZqC6o=
X-Received: by 2002:a25:ad57:: with SMTP id l23mr3349025ybe.172.1617181932405;
 Wed, 31 Mar 2021 02:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210330131646.1401838-1-omosnace@redhat.com> <20210330131646.1401838-2-omosnace@redhat.com>
 <CAHC9VhQ4Hc1VccUjR7cMq_Lm2YOn=i=w_FahZ7ZFnoxz+iKUPA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ4Hc1VccUjR7cMq_Lm2YOn=i=w_FahZ7ZFnoxz+iKUPA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 31 Mar 2021 11:12:00 +0200
Message-ID: <CAFqZXNsus-5PGNMT2t=T4WQQMrzgBSJDu6=qr0KmtDgKCR=hfQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: fix cond_list corruption when changing booleans
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 31, 2021 at 4:04 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Mar 30, 2021 at 9:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
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
> > Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/avtab.c       | 90 +++++++++----------------------
> >  security/selinux/ss/avtab.h       |  2 +-
> >  security/selinux/ss/conditional.c | 12 ++---
> >  3 files changed, 33 insertions(+), 71 deletions(-)
> >
> > diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> > index 6dcb6aa4db7f..11f8f524de98 100644
> > --- a/security/selinux/ss/avtab.c
> > +++ b/security/selinux/ss/avtab.c
> > @@ -305,86 +305,48 @@ void avtab_init(struct avtab *h)
> >         h->nel = 0;
> >  }
> >
> > -int avtab_alloc(struct avtab *h, u32 nrules)
> > +static int avtab_alloc_common(struct avtab *h, u32 nslot)
> >  {
> > -       u32 mask = 0;
> > -       u32 shift = 0;
> > -       u32 work = nrules;
> > -       u32 nslot = 0;
> > -
> > -       if (nrules == 0)
> > -               goto avtab_alloc_out;
> > -
> > -       while (work) {
> > -               work  = work >> 1;
> > -               shift++;
> > -       }
> > -       if (shift > 2)
> > -               shift = shift - 2;
> > -       nslot = 1 << shift;
> > -       if (nslot > MAX_AVTAB_HASH_BUCKETS)
> > -               nslot = MAX_AVTAB_HASH_BUCKETS;
> > -       mask = nslot - 1;
> > -
> >         h->htable = kvcalloc(nslot, sizeof(void *), GFP_KERNEL);
> >         if (!h->htable)
> >                 return -ENOMEM;
>
> Hmmm, do we need to protect against 'nslot == 0'?  Unless I missed
> something, a quick dive into kvcalloc() makes it look like it can
> return non-NULL for zero length allocations, at least in the slab
> case.
>
> > - avtab_alloc_out:
> >         h->nel = 0;
> >         h->nslot = nslot;
> > -       h->mask = mask;
> > -       pr_debug("SELinux: %d avtab hash slots, %d rules.\n",
> > -              h->nslot, nrules);
> > +       h->mask = nslot - 1;
>
> This is definitely not good if 'nslot <= 1';

Yeah, in fact the current code doesn't seem to be safe against nslot
== 0 either... I'll insert another patch that fixes this.

>
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
> > +       int rc;
> > +       u32 shift = 0;
> > +       u32 work = nrules;
> > +       u32 nslot = 0;
> >
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
> > +       if (nrules != 0) {
> > +               while (work) {
> > +                       work  = work >> 1;
>
> Extra  horizontal  spaces  are  awkward  and  bad.
>
> > +                       shift++;
> >                 }
> > +               if (shift > 2)
> > +                       shift = shift - 2;
>
> Since we are getting nit-picky with this code, why not make the
> loop/if a bit more elegant?  How about something like below?
>
>   u32 shift = 2;
>   u32 work = nrules >> 4;
>   while (work) {
>     work >>= 1;
>     shift++;
>   }

I think you meant:
u32 shift = 0;
u32 work = nrules >> 2;
while (work) {
    work >>= 1;
    shift++;
}

...which is equivalent to the current code and yes, I'll use that :)

>
> > +               nslot = 1 << shift;
> > +               if (nslot > MAX_AVTAB_HASH_BUCKETS)
> > +                       nslot = MAX_AVTAB_HASH_BUCKETS;
> >         }
> >
> > +       rc = avtab_alloc_common(h, nslot);
> > +       if (rc)
> > +               return rc;
> > +
> > +       pr_debug("SELinux: %d avtab hash slots, %d rules.\n", nslot, nrules);
> >         return 0;
> > -error:
> > -       avtab_destroy(new);
> > -       return -ENOMEM;
> > +}
> > +
> > +int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
> > +{
> > +       return avtab_alloc_common(new, orig->nslot);
> >  }
>
> --
> paul moore
> www.paul-moore.com
>


-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

