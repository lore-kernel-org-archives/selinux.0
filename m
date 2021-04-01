Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24DBC433ED
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 08:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8F86108B
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 08:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhDAIAV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Apr 2021 04:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59258 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229459AbhDAH7s (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Apr 2021 03:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617263986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mnFwzgqqf9AQMPs8DbG/UoM688xuhWlpTIPtyMGPXSw=;
        b=FTZBnVKWLvtHyD7jOpZwEuD9Cj3mv7GLlUFETm5N1oNwjM8p5KsXROr3AOvPleo2gZcNiO
        VQ+jxgruYumnmT8p7W2xrhtVFpEYDwM5hEerlmD55rXXf07LO6Y0rmNrWPnaIVUepVdQ9j
        +RCqrmGlDk+30L1AbQrjMoYL+ym14bc=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-Ct1Dhk-cPRGSBsd7XDqnOQ-1; Thu, 01 Apr 2021 03:59:44 -0400
X-MC-Unique: Ct1Dhk-cPRGSBsd7XDqnOQ-1
Received: by mail-yb1-f197.google.com with SMTP id 71so1899770ybl.0
        for <selinux@vger.kernel.org>; Thu, 01 Apr 2021 00:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mnFwzgqqf9AQMPs8DbG/UoM688xuhWlpTIPtyMGPXSw=;
        b=jPJ7MufCVzG4tOv1HtXNPc6r9Ts1a/2s9DWr7XN9jgPfx2mFqakvFPu2UVeYEqkJcA
         m6MaF/byloQ9ulUwgHEQIX3Rt6sgxJadzqkaHDcyEV7WGGeFdIlbaXnj70ipAirWkJM8
         d7ZyCgVs/IvAdJLbzv68shuB5gpbZ6PmXarWqvFVhtXubmQPkKRS30JUxQh7awS6QVYM
         J7hFn3IYtkUsvkj08eZSlxUOzIzqCigWHy+ECVQ74zv8t166lE5HLWeqoHNp7VSSeSy3
         f7WBSv2MUrAjzZRwsPFryhOTzDD8R5FgWQ1Wz/Do2exqbQ8lwSkgJX6IqBBn1md47uQq
         a0aQ==
X-Gm-Message-State: AOAM533KQwtfZk8SGjvtii1/sZJVAG9JUuBWrH03AY/4diFzKlUDFUlA
        T8tvFGCedt5doXeyIA87lOzMqA1P6MqCz+SZw9V+jG6ko2idedUqRneYF43UX/8aDvEUL3ypBqY
        McgFRO77k6y4yRGt+tRwHkBt4hYFHf4eiPw==
X-Received: by 2002:a5b:d43:: with SMTP id f3mr9921258ybr.81.1617263984284;
        Thu, 01 Apr 2021 00:59:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeDY5XRTRxQeyaF54E26A6ksrh1PqDXSvV528tYDePh3qjEfE88eeRhyz0YcVwrrSevcYanpSZcPA0OR3pUCk=
X-Received: by 2002:a5b:d43:: with SMTP id f3mr9921246ybr.81.1617263984062;
 Thu, 01 Apr 2021 00:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210330131646.1401838-1-omosnace@redhat.com> <20210330131646.1401838-2-omosnace@redhat.com>
 <CAHC9VhQ4Hc1VccUjR7cMq_Lm2YOn=i=w_FahZ7ZFnoxz+iKUPA@mail.gmail.com>
 <CAFqZXNsus-5PGNMT2t=T4WQQMrzgBSJDu6=qr0KmtDgKCR=hfQ@mail.gmail.com> <CAHC9VhRD=SNev8Ptk7idauX+0gzQysKDLBhGkfpD1CETB2TNrA@mail.gmail.com>
In-Reply-To: <CAHC9VhRD=SNev8Ptk7idauX+0gzQysKDLBhGkfpD1CETB2TNrA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 1 Apr 2021 09:59:32 +0200
Message-ID: <CAFqZXNuq2aBs6mW6jZ+bt_SY2xrE4LYL3knEjxD26bOw8J3Eqg@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: fix cond_list corruption when changing booleans
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 1, 2021 at 1:20 AM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Mar 31, 2021 at 5:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Wed, Mar 31, 2021 at 4:04 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, Mar 30, 2021 at 9:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> ...
>
> > > > -int avtab_duplicate(struct avtab *new, struct avtab *orig)
> > > > +int avtab_alloc(struct avtab *h, u32 nrules)
> > > >  {
> > > > -       int i;
> > > > -       struct avtab_node *node, *tmp, *tail;
> > > > -
> > > > -       memset(new, 0, sizeof(*new));
> > > > +       int rc;
> > > > +       u32 shift = 0;
> > > > +       u32 work = nrules;
> > > > +       u32 nslot = 0;
> > > >
> > > > -       new->htable = kvcalloc(orig->nslot, sizeof(void *), GFP_KERNEL);
> > > > -       if (!new->htable)
> > > > -               return -ENOMEM;
> > > > -       new->nslot = orig->nslot;
> > > > -       new->mask = orig->mask;
> > > > -
> > > > -       for (i = 0; i < orig->nslot; i++) {
> > > > -               tail = NULL;
> > > > -               for (node = orig->htable[i]; node; node = node->next) {
> > > > -                       tmp = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
> > > > -                       if (!tmp)
> > > > -                               goto error;
> > > > -                       tmp->key = node->key;
> > > > -                       if (tmp->key.specified & AVTAB_XPERMS) {
> > > > -                               tmp->datum.u.xperms =
> > > > -                                       kmem_cache_zalloc(avtab_xperms_cachep,
> > > > -                                                       GFP_KERNEL);
> > > > -                               if (!tmp->datum.u.xperms) {
> > > > -                                       kmem_cache_free(avtab_node_cachep, tmp);
> > > > -                                       goto error;
> > > > -                               }
> > > > -                               tmp->datum.u.xperms = node->datum.u.xperms;
> > > > -                       } else
> > > > -                               tmp->datum.u.data = node->datum.u.data;
> > > > -
> > > > -                       if (tail)
> > > > -                               tail->next = tmp;
> > > > -                       else
> > > > -                               new->htable[i] = tmp;
> > > > -
> > > > -                       tail = tmp;
> > > > -                       new->nel++;
> > > > +       if (nrules != 0) {
> > > > +               while (work) {
> > > > +                       work  = work >> 1;
> > >
> > > Extra  horizontal  spaces  are  awkward  and  bad.
> > >
> > > > +                       shift++;
> > > >                 }
> > > > +               if (shift > 2)
> > > > +                       shift = shift - 2;
> > >
> > > Since we are getting nit-picky with this code, why not make the
> > > loop/if a bit more elegant?  How about something like below?
> > >
> > >   u32 shift = 2;
> > >   u32 work = nrules >> 4;
> > >   while (work) {
> > >     work >>= 1;
> > >     shift++;
> > >   }
> >
> > I think you meant:
> > u32 shift = 0;
> > u32 work = nrules >> 2;
> > while (work) {
> >     work >>= 1;
> >     shift++;
> > }
> >
> > ...which is equivalent to the current code and yes, I'll use that :)
>
> Well, no, not really, but that's okay as looking at it now we both got
> it wrong :)
>
> Basically I wanted to avoid the odd problem where the current code has
> a dip in the number of slots/buckets when nrules is equal to 4, 5, 6,
> or 7.  While the code I proposed yesterday did that, it inflated the
> number of buckets beyond the current code; your suggestion had
> problems with low numbers resulting in zero buckets.

Aah, I wrongly parsed the "if (shift > 2) shift -= 2;" statement...
Yeah, I guess even the original intent was different than what the
code does.

Anyway, my code doesn't result in zero buckets, at worst in 1 bucket
(nslot = 1 << shift), which I think is reasonable given that the
intent of the code seems to be to simply squeeze the number of slots
down to approx. 1/4 the number of rules.

To make it a bit more concrete: your code allocates 4 buckets for
nrules 1..15; my code allocates 1 bucket for nrules 1..3, 2 buckets
for nrules 4..7, and 4 buckets for 8..15. Both our solutions are
equivalent to the old code at nrules >= 8.

So I'll argue that my proposed solution is actually slightly better
(and avoids adding a new magic number).

>
> I think what we really want is this:
>
>   shift = 2;
>   work = nrules >> 4;
>   while (work) {
>     work >>= 1;
>     shift++;
>   }
>
> ... it avoids any dips in the bucket count and it results in similar
> bucket counts as the existing code for larger numbers of rules.

But that's exactly the same as your original suggestion :D

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

