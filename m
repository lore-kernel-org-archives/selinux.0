Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7603DC433B4
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5630F60FF3
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhDAR6t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236920AbhDAR4D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Apr 2021 13:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617299762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PqNENAt1jxYw4hSKZAb8O08x/5l7ic8AGRF/0HXN/wI=;
        b=QtYhZyhwtr7mVTcIv6jnaKoNGK8UPiwVB4VoDyAr1F1FcdSSaedCCxT6AuHfSNyO5tvjAt
        jG5r9a9pPSNRCJM448oHHzli09/wUsUhkyLYuDEpy565zxpEAu9wiR/udOnPxd9iuJnoEy
        ZHDQC17HG1NJezBNDKQ2wi1UD9DHk38=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-K7DiGmmSNYy8a2bIDPZhag-1; Thu, 01 Apr 2021 11:54:39 -0400
X-MC-Unique: K7DiGmmSNYy8a2bIDPZhag-1
Received: by mail-yb1-f197.google.com with SMTP id i2so6191103ybl.21
        for <selinux@vger.kernel.org>; Thu, 01 Apr 2021 08:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PqNENAt1jxYw4hSKZAb8O08x/5l7ic8AGRF/0HXN/wI=;
        b=lx4NPMp51/ps5z/yozYm5BIarYk+9dX2WYX5R2gkzsV6Q8p4+pLb/kVYv7/P8EvvrR
         rDJTwTfucADfwv7zy7lA+TMFNFnp+fEar20YWZBLh/1llL4ZeuW5GoLMjcsU0IC0d8wC
         Ux06+5wxzNFeELEyhlTgtu0ImotQDFOrECtR6OBylbdplh/o2qm8v2JT0ErfllNstYxI
         qgM27la4fA34mkq4AxNKHaGtirO4vWHIW+fE5RFsIal/FmMzYzCcxB8Ay/KgU/clJXj8
         hMTfQtrwQnQW9LQj8oQv9OBSd7higbBK+9tbVNuvZASnfgvBSYeKBv0yqn78CDzjcE5m
         xIiQ==
X-Gm-Message-State: AOAM530yCar1PQEmf5bO9Ae0HPtqI6aIYfHIRPptS3byZc4ldr86W9gt
        ijIFV+mh/JdParKT342NydxPugKI5IQvwmCtrHtRE9kvVfsg1t/aplJF1pAswDUhtUeXqTnGv+j
        NUBMxXknnjaGrpJHLLefuBKZkkaAATiSfbg==
X-Received: by 2002:a25:2f8a:: with SMTP id v132mr6661642ybv.227.1617292478498;
        Thu, 01 Apr 2021 08:54:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGEpLAuVj2QGYmvRnYAJhZOcQUzAJ3GB5whnXlJb079LiwyUxgZDUS+/94KEdEQdh0wFhFW13wHpsQHFfLa54=
X-Received: by 2002:a25:2f8a:: with SMTP id v132mr6661613ybv.227.1617292478283;
 Thu, 01 Apr 2021 08:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210330131646.1401838-1-omosnace@redhat.com> <20210330131646.1401838-2-omosnace@redhat.com>
 <CAHC9VhQ4Hc1VccUjR7cMq_Lm2YOn=i=w_FahZ7ZFnoxz+iKUPA@mail.gmail.com>
 <CAFqZXNsus-5PGNMT2t=T4WQQMrzgBSJDu6=qr0KmtDgKCR=hfQ@mail.gmail.com>
 <CAHC9VhRD=SNev8Ptk7idauX+0gzQysKDLBhGkfpD1CETB2TNrA@mail.gmail.com>
 <CAFqZXNuq2aBs6mW6jZ+bt_SY2xrE4LYL3knEjxD26bOw8J3Eqg@mail.gmail.com> <CAHC9VhQUo0cp_7Zt=ogsj0RknZ-YK7pv40rUevZztF-PJ+99ig@mail.gmail.com>
In-Reply-To: <CAHC9VhQUo0cp_7Zt=ogsj0RknZ-YK7pv40rUevZztF-PJ+99ig@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 1 Apr 2021 17:54:26 +0200
Message-ID: <CAFqZXNu0fwwPYLPy0_E-+YoK+A+5odiw1f_SBVSsgeOJ-L80Mw@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: fix cond_list corruption when changing booleans
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 1, 2021 at 5:36 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Apr 1, 2021 at 3:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Thu, Apr 1, 2021 at 1:20 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Wed, Mar 31, 2021 at 5:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > On Wed, Mar 31, 2021 at 4:04 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Tue, Mar 30, 2021 at 9:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > ...
> > >
> > > > > > -int avtab_duplicate(struct avtab *new, struct avtab *orig)
> > > > > > +int avtab_alloc(struct avtab *h, u32 nrules)
> > > > > >  {
> > > > > > -       int i;
> > > > > > -       struct avtab_node *node, *tmp, *tail;
> > > > > > -
> > > > > > -       memset(new, 0, sizeof(*new));
> > > > > > +       int rc;
> > > > > > +       u32 shift = 0;
> > > > > > +       u32 work = nrules;
> > > > > > +       u32 nslot = 0;
> > > > > >
> > > > > > -       new->htable = kvcalloc(orig->nslot, sizeof(void *), GFP_KERNEL);
> > > > > > -       if (!new->htable)
> > > > > > -               return -ENOMEM;
> > > > > > -       new->nslot = orig->nslot;
> > > > > > -       new->mask = orig->mask;
> > > > > > -
> > > > > > -       for (i = 0; i < orig->nslot; i++) {
> > > > > > -               tail = NULL;
> > > > > > -               for (node = orig->htable[i]; node; node = node->next) {
> > > > > > -                       tmp = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
> > > > > > -                       if (!tmp)
> > > > > > -                               goto error;
> > > > > > -                       tmp->key = node->key;
> > > > > > -                       if (tmp->key.specified & AVTAB_XPERMS) {
> > > > > > -                               tmp->datum.u.xperms =
> > > > > > -                                       kmem_cache_zalloc(avtab_xperms_cachep,
> > > > > > -                                                       GFP_KERNEL);
> > > > > > -                               if (!tmp->datum.u.xperms) {
> > > > > > -                                       kmem_cache_free(avtab_node_cachep, tmp);
> > > > > > -                                       goto error;
> > > > > > -                               }
> > > > > > -                               tmp->datum.u.xperms = node->datum.u.xperms;
> > > > > > -                       } else
> > > > > > -                               tmp->datum.u.data = node->datum.u.data;
> > > > > > -
> > > > > > -                       if (tail)
> > > > > > -                               tail->next = tmp;
> > > > > > -                       else
> > > > > > -                               new->htable[i] = tmp;
> > > > > > -
> > > > > > -                       tail = tmp;
> > > > > > -                       new->nel++;
> > > > > > +       if (nrules != 0) {
> > > > > > +               while (work) {
> > > > > > +                       work  = work >> 1;
> > > > >
> > > > > Extra  horizontal  spaces  are  awkward  and  bad.
> > > > >
> > > > > > +                       shift++;
> > > > > >                 }
> > > > > > +               if (shift > 2)
> > > > > > +                       shift = shift - 2;
> > > > >
> > > > > Since we are getting nit-picky with this code, why not make the
> > > > > loop/if a bit more elegant?  How about something like below?
> > > > >
> > > > >   u32 shift = 2;
> > > > >   u32 work = nrules >> 4;
> > > > >   while (work) {
> > > > >     work >>= 1;
> > > > >     shift++;
> > > > >   }
> > > >
> > > > I think you meant:
> > > > u32 shift = 0;
> > > > u32 work = nrules >> 2;
> > > > while (work) {
> > > >     work >>= 1;
> > > >     shift++;
> > > > }
> > > >
> > > > ...which is equivalent to the current code and yes, I'll use that :)
> > >
> > > Well, no, not really, but that's okay as looking at it now we both got
> > > it wrong :)
> > >
> > > Basically I wanted to avoid the odd problem where the current code has
> > > a dip in the number of slots/buckets when nrules is equal to 4, 5, 6,
> > > or 7.  While the code I proposed yesterday did that, it inflated the
> > > number of buckets beyond the current code; your suggestion had
> > > problems with low numbers resulting in zero buckets.
> >
> > Aah, I wrongly parsed the "if (shift > 2) shift -= 2;" statement...
> > Yeah, I guess even the original intent was different than what the
> > code does.
>
> I think we all mis-interpreted that bit of code at some point.  I
> seriously doubt that dip was what the original author intended :)
>
> > Anyway, my code doesn't result in zero buckets, at worst in 1 bucket
> > (nslot = 1 << shift) ...
>
> Sorry, yes, I mis-spoke (mis-typed?); I was talking about the
> shift/exponent value.
>
> > So I'll argue that my proposed solution is actually slightly better
> > (and avoids adding a new magic number).
>
> The magic number argument isn't really valid as both approaches use
> them to some degree.  Creating a #define constant is overkill here,
> but I guess a short comment wouldn't be a bad idea if you wanted to
> add one; I'm not going to require it in this case.
>
> Since we are at -rc5 I really want to wrap this up soon so I'm going
> to make one final suggestion:
>
>   shift = 1;
>   work = nrules >> 3;
>   while (work) {
>     work >>= 1;
>     shift++;
>   }
>
> ... this preserves the original nslot count, minus the bump/dip seen
> with low rule numbers.  The shift value starts at 1, increases to 2
> when the rules reach 8, increases to 3 when the rules reach 16, and so
> on.  Of the approaches we've discussed, I believe it is the most
> faithful to original intent.

Ok, I agree it's not something worth obsessing over, so I'll just use
this last suggestion :) (One day maybe I'll try to simplify/optimize
it a bit, but that is for another patch...)

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

