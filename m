Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB77C433ED
	for <selinux@archiver.kernel.org>; Wed, 31 Mar 2021 23:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA8D61057
	for <selinux@archiver.kernel.org>; Wed, 31 Mar 2021 23:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhCaXUN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Mar 2021 19:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhCaXT6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Mar 2021 19:19:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55326C061574
        for <selinux@vger.kernel.org>; Wed, 31 Mar 2021 16:19:58 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a7so116522ejs.3
        for <selinux@vger.kernel.org>; Wed, 31 Mar 2021 16:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5nlFsw7x0LFWfBTRVOqhal/lk1UgZDPLmvDYouVvPM=;
        b=YVcZyuER2K1L6EOrzazTHN/USCVKXoM6M/K2MSv9w7YcXIzvsVa55OGlKRJ/iWKgem
         rUGIgv/fo6UDQpymhT7J+tWCLKd2GC70ObLn6AmhzPdCOOCX1gI9uWLi6sJ8wkg9spTu
         t6rREXfy3K5pfXlLcJ+4EAd/OV4EAb19otyIStklErbJTRlsZfQ+wjlx5FSlivowZtAM
         4MHnrF2KVEK1yIDbuyaf9GmRpcX2F70Hug6OeP0TfaztoVLr5i/CC170MCo7GgXu2p9/
         vGu2IQqrCxPgRKeDICjTgQ7QzrZnL/RDjnv/m88ZFnT0kAYmfXATXK6QA95XnjgHJFaE
         X8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5nlFsw7x0LFWfBTRVOqhal/lk1UgZDPLmvDYouVvPM=;
        b=pYA4ywR1Zi6Q9ED8N2gMqHHtU/nH16ov7hwagU4dYDPJ4uNboYZs9WTPMNf3F477FO
         OY/0lkVn1Dbf/EviNwq8B2sjtfjUPiThgTC3wq/DHoidkWNoP3MUTsN3X94nWlEZSqKK
         tQKx7/j2CgtyVpS4kJMbc8O41mIBXqabZEPvGjm+/UJbgz3ad7C8+JNQXVkDFAV1+Kpr
         NVQPcliTN1qXRvXv6neIRgrnt75+HxqITXvc2rF0D6uBjQ4kKPlD20kYNwhS4ceZo6Cd
         8aA+Shr0P6HlT45I7+hQT7ubonZweo9F15hklgym9qFXWPJaBKZO0IypiZUOy7GFBDRv
         Ry9w==
X-Gm-Message-State: AOAM530okGYBS5j4wyiIJcifqwmj6/mJdEfReI4ShWJxblOy0MBXN6h1
        zexN6xIbzBQJ3o+Q7pTdEgIzMPSnJl3GEbCC570p1chVRwxe
X-Google-Smtp-Source: ABdhPJyGoN5QFLb4H+1+YyCG7g6qUZ1xkq5WrunaxTFcTRNSZZiixwYzD5agdnREM6+CNx2kh9BT9pJW39Xzfqyn2Bo=
X-Received: by 2002:a17:906:edca:: with SMTP id sb10mr6076842ejb.398.1617232796827;
 Wed, 31 Mar 2021 16:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210330131646.1401838-1-omosnace@redhat.com> <20210330131646.1401838-2-omosnace@redhat.com>
 <CAHC9VhQ4Hc1VccUjR7cMq_Lm2YOn=i=w_FahZ7ZFnoxz+iKUPA@mail.gmail.com> <CAFqZXNsus-5PGNMT2t=T4WQQMrzgBSJDu6=qr0KmtDgKCR=hfQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsus-5PGNMT2t=T4WQQMrzgBSJDu6=qr0KmtDgKCR=hfQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 31 Mar 2021 19:19:45 -0400
Message-ID: <CAHC9VhRD=SNev8Ptk7idauX+0gzQysKDLBhGkfpD1CETB2TNrA@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: fix cond_list corruption when changing booleans
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 31, 2021 at 5:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Mar 31, 2021 at 4:04 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Mar 30, 2021 at 9:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:

...

> > > -int avtab_duplicate(struct avtab *new, struct avtab *orig)
> > > +int avtab_alloc(struct avtab *h, u32 nrules)
> > >  {
> > > -       int i;
> > > -       struct avtab_node *node, *tmp, *tail;
> > > -
> > > -       memset(new, 0, sizeof(*new));
> > > +       int rc;
> > > +       u32 shift = 0;
> > > +       u32 work = nrules;
> > > +       u32 nslot = 0;
> > >
> > > -       new->htable = kvcalloc(orig->nslot, sizeof(void *), GFP_KERNEL);
> > > -       if (!new->htable)
> > > -               return -ENOMEM;
> > > -       new->nslot = orig->nslot;
> > > -       new->mask = orig->mask;
> > > -
> > > -       for (i = 0; i < orig->nslot; i++) {
> > > -               tail = NULL;
> > > -               for (node = orig->htable[i]; node; node = node->next) {
> > > -                       tmp = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
> > > -                       if (!tmp)
> > > -                               goto error;
> > > -                       tmp->key = node->key;
> > > -                       if (tmp->key.specified & AVTAB_XPERMS) {
> > > -                               tmp->datum.u.xperms =
> > > -                                       kmem_cache_zalloc(avtab_xperms_cachep,
> > > -                                                       GFP_KERNEL);
> > > -                               if (!tmp->datum.u.xperms) {
> > > -                                       kmem_cache_free(avtab_node_cachep, tmp);
> > > -                                       goto error;
> > > -                               }
> > > -                               tmp->datum.u.xperms = node->datum.u.xperms;
> > > -                       } else
> > > -                               tmp->datum.u.data = node->datum.u.data;
> > > -
> > > -                       if (tail)
> > > -                               tail->next = tmp;
> > > -                       else
> > > -                               new->htable[i] = tmp;
> > > -
> > > -                       tail = tmp;
> > > -                       new->nel++;
> > > +       if (nrules != 0) {
> > > +               while (work) {
> > > +                       work  = work >> 1;
> >
> > Extra  horizontal  spaces  are  awkward  and  bad.
> >
> > > +                       shift++;
> > >                 }
> > > +               if (shift > 2)
> > > +                       shift = shift - 2;
> >
> > Since we are getting nit-picky with this code, why not make the
> > loop/if a bit more elegant?  How about something like below?
> >
> >   u32 shift = 2;
> >   u32 work = nrules >> 4;
> >   while (work) {
> >     work >>= 1;
> >     shift++;
> >   }
>
> I think you meant:
> u32 shift = 0;
> u32 work = nrules >> 2;
> while (work) {
>     work >>= 1;
>     shift++;
> }
>
> ...which is equivalent to the current code and yes, I'll use that :)

Well, no, not really, but that's okay as looking at it now we both got
it wrong :)

Basically I wanted to avoid the odd problem where the current code has
a dip in the number of slots/buckets when nrules is equal to 4, 5, 6,
or 7.  While the code I proposed yesterday did that, it inflated the
number of buckets beyond the current code; your suggestion had
problems with low numbers resulting in zero buckets.

I think what we really want is this:

  shift = 2;
  work = nrules >> 4;
  while (work) {
    work >>= 1;
    shift++;
  }

... it avoids any dips in the bucket count and it results in similar
bucket counts as the existing code for larger numbers of rules.

-- 
paul moore
www.paul-moore.com
