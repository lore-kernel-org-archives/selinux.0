Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581DAC001B8
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 17:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469C861383
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 17:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhDARmT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbhDARgv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Apr 2021 13:36:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9FEC0225B1
        for <selinux@vger.kernel.org>; Thu,  1 Apr 2021 08:36:35 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e7so2422267edu.10
        for <selinux@vger.kernel.org>; Thu, 01 Apr 2021 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PmQFadD4olVI6BkAhzVf4461pUV0vdU3DkvmGmVgxNk=;
        b=ISWufBE9ZUCXtdXbeHrIQ4ap3URrsK2mela8T6tQr1La1Y8G4L2TS2bxjdpzeYkRbi
         gLPufa6Jpj2PwI3LlBWdiiRv1wrp+Xmy4gd9pgvGvlPhyI5PTladbzz8jkS+ZOSkkt4Z
         Iqk+Wb9bBLegpoaA+IPjffvnfiQOkQanOXzFG3zkPpaSj7vAfvq8b5mXrs1cky3/+LbX
         tQnvgCW+ZEDcoPgSRvCF8t+ZZRD7xKT8EO9hsKj3PjqiHsNIpIEuUhaCCcwVr0IyjH0y
         pi23R9bbNZmzsuZOqi1qdX//syiXvpWa/tMOc/XhgHh8Uje8xi+UoOtq1Mi3PmPopko6
         305w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PmQFadD4olVI6BkAhzVf4461pUV0vdU3DkvmGmVgxNk=;
        b=G1VLmaWBFJJrQ8T81oNpyKRNBTBDE+IWi4AGFdYTaFDHAHdZ1K/uudgNrGxG+Ua2qN
         8xIvSOcQY14vAr+IJ7AzVdfdihhxCbLdhuwwCkyeTn78hqXVb58BuixS/gGOCryLQGkT
         ns1hqOmnFVgihpw3xLyI2KvwtIbVuzWxkyd2PgVuyOFTyDkgIVLngc3e3yzR6R4m4SM+
         q85XcLpvCPFLVrNfvDf3+IVkkl2kd/NurlJ+AWZL6ea9nqdHvUjOeesjrdJwlgvN6xIl
         gwP/z6GLYUtOhVX4ioLEbGeI7hmo76PL8td2zBXta+mvpILGhXMqEcxSNqj7sUhyXf61
         p+ZA==
X-Gm-Message-State: AOAM530gmHqL+LX8Q3pmjvPxBCcifJFaoTcdLeJEI6dJ+Ub9AQTD4h1N
        0rioTN42IZwtxspO7WfX0qNQhmSiC8P1zZxBGHHP
X-Google-Smtp-Source: ABdhPJxcmwOcPlxFCDt8mTHsu59f0/y/ekjp0Cxx0KGNQypBNIX1ZiddMwdh4qwn767Qkby5d6LKEpnVUDwdM6hZSYA=
X-Received: by 2002:a05:6402:c96:: with SMTP id cm22mr10599043edb.128.1617291394384;
 Thu, 01 Apr 2021 08:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210330131646.1401838-1-omosnace@redhat.com> <20210330131646.1401838-2-omosnace@redhat.com>
 <CAHC9VhQ4Hc1VccUjR7cMq_Lm2YOn=i=w_FahZ7ZFnoxz+iKUPA@mail.gmail.com>
 <CAFqZXNsus-5PGNMT2t=T4WQQMrzgBSJDu6=qr0KmtDgKCR=hfQ@mail.gmail.com>
 <CAHC9VhRD=SNev8Ptk7idauX+0gzQysKDLBhGkfpD1CETB2TNrA@mail.gmail.com> <CAFqZXNuq2aBs6mW6jZ+bt_SY2xrE4LYL3knEjxD26bOw8J3Eqg@mail.gmail.com>
In-Reply-To: <CAFqZXNuq2aBs6mW6jZ+bt_SY2xrE4LYL3knEjxD26bOw8J3Eqg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Apr 2021 11:36:23 -0400
Message-ID: <CAHC9VhQUo0cp_7Zt=ogsj0RknZ-YK7pv40rUevZztF-PJ+99ig@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: fix cond_list corruption when changing booleans
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 1, 2021 at 3:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Apr 1, 2021 at 1:20 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Mar 31, 2021 at 5:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Wed, Mar 31, 2021 at 4:04 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Tue, Mar 30, 2021 at 9:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > ...
> >
> > > > > -int avtab_duplicate(struct avtab *new, struct avtab *orig)
> > > > > +int avtab_alloc(struct avtab *h, u32 nrules)
> > > > >  {
> > > > > -       int i;
> > > > > -       struct avtab_node *node, *tmp, *tail;
> > > > > -
> > > > > -       memset(new, 0, sizeof(*new));
> > > > > +       int rc;
> > > > > +       u32 shift = 0;
> > > > > +       u32 work = nrules;
> > > > > +       u32 nslot = 0;
> > > > >
> > > > > -       new->htable = kvcalloc(orig->nslot, sizeof(void *), GFP_KERNEL);
> > > > > -       if (!new->htable)
> > > > > -               return -ENOMEM;
> > > > > -       new->nslot = orig->nslot;
> > > > > -       new->mask = orig->mask;
> > > > > -
> > > > > -       for (i = 0; i < orig->nslot; i++) {
> > > > > -               tail = NULL;
> > > > > -               for (node = orig->htable[i]; node; node = node->next) {
> > > > > -                       tmp = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
> > > > > -                       if (!tmp)
> > > > > -                               goto error;
> > > > > -                       tmp->key = node->key;
> > > > > -                       if (tmp->key.specified & AVTAB_XPERMS) {
> > > > > -                               tmp->datum.u.xperms =
> > > > > -                                       kmem_cache_zalloc(avtab_xperms_cachep,
> > > > > -                                                       GFP_KERNEL);
> > > > > -                               if (!tmp->datum.u.xperms) {
> > > > > -                                       kmem_cache_free(avtab_node_cachep, tmp);
> > > > > -                                       goto error;
> > > > > -                               }
> > > > > -                               tmp->datum.u.xperms = node->datum.u.xperms;
> > > > > -                       } else
> > > > > -                               tmp->datum.u.data = node->datum.u.data;
> > > > > -
> > > > > -                       if (tail)
> > > > > -                               tail->next = tmp;
> > > > > -                       else
> > > > > -                               new->htable[i] = tmp;
> > > > > -
> > > > > -                       tail = tmp;
> > > > > -                       new->nel++;
> > > > > +       if (nrules != 0) {
> > > > > +               while (work) {
> > > > > +                       work  = work >> 1;
> > > >
> > > > Extra  horizontal  spaces  are  awkward  and  bad.
> > > >
> > > > > +                       shift++;
> > > > >                 }
> > > > > +               if (shift > 2)
> > > > > +                       shift = shift - 2;
> > > >
> > > > Since we are getting nit-picky with this code, why not make the
> > > > loop/if a bit more elegant?  How about something like below?
> > > >
> > > >   u32 shift = 2;
> > > >   u32 work = nrules >> 4;
> > > >   while (work) {
> > > >     work >>= 1;
> > > >     shift++;
> > > >   }
> > >
> > > I think you meant:
> > > u32 shift = 0;
> > > u32 work = nrules >> 2;
> > > while (work) {
> > >     work >>= 1;
> > >     shift++;
> > > }
> > >
> > > ...which is equivalent to the current code and yes, I'll use that :)
> >
> > Well, no, not really, but that's okay as looking at it now we both got
> > it wrong :)
> >
> > Basically I wanted to avoid the odd problem where the current code has
> > a dip in the number of slots/buckets when nrules is equal to 4, 5, 6,
> > or 7.  While the code I proposed yesterday did that, it inflated the
> > number of buckets beyond the current code; your suggestion had
> > problems with low numbers resulting in zero buckets.
>
> Aah, I wrongly parsed the "if (shift > 2) shift -= 2;" statement...
> Yeah, I guess even the original intent was different than what the
> code does.

I think we all mis-interpreted that bit of code at some point.  I
seriously doubt that dip was what the original author intended :)

> Anyway, my code doesn't result in zero buckets, at worst in 1 bucket
> (nslot = 1 << shift) ...

Sorry, yes, I mis-spoke (mis-typed?); I was talking about the
shift/exponent value.

> So I'll argue that my proposed solution is actually slightly better
> (and avoids adding a new magic number).

The magic number argument isn't really valid as both approaches use
them to some degree.  Creating a #define constant is overkill here,
but I guess a short comment wouldn't be a bad idea if you wanted to
add one; I'm not going to require it in this case.

Since we are at -rc5 I really want to wrap this up soon so I'm going
to make one final suggestion:

  shift = 1;
  work = nrules >> 3;
  while (work) {
    work >>= 1;
    shift++;
  }

... this preserves the original nslot count, minus the bump/dip seen
with low rule numbers.  The shift value starts at 1, increases to 2
when the rules reach 8, increases to 3 when the rules reach 16, and so
on.  Of the approaches we've discussed, I believe it is the most
faithful to original intent.

-- 
paul moore
www.paul-moore.com
