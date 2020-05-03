Return-Path: <SRS0=LGaS=6R=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACD3C28CBC
	for <selinux@archiver.kernel.org>; Sun,  3 May 2020 20:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CD12071C
	for <selinux@archiver.kernel.org>; Sun,  3 May 2020 20:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oz1Ck7IX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgECUfE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 3 May 2020 16:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgECUfE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 3 May 2020 16:35:04 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5A0C061A0E
        for <selinux@vger.kernel.org>; Sun,  3 May 2020 13:35:02 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s10so11795788edy.9
        for <selinux@vger.kernel.org>; Sun, 03 May 2020 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rC57if6zTGOgurlYLWvBBTGyEEoR1y0RiHyLtTaQ6Kg=;
        b=oz1Ck7IXTFfMWwP8clGnWiAsiFziFJ+LqKk6GVzdyaZ1d1TfQUtRl1nvgPmTmVhEDH
         HF0gXyFZMTxJCCnz245E/T7sRkysA2RT76GyfF9UB6Ixp/CqUCCYLyPAbW2E3UsQf0cp
         c/7kU/FmMoe5jBZhg7xSTK5LuBQzWhuThIL6YVVp8Ws/gg0Hwig68nE0WVStSslRYBCb
         d5ZLANxsY0mlpIVjasdBKyGJSXnyaCJPV24QKrdOadRidkinTYaR/YFD1J47ymsdlfqd
         0lCB19Ov5qLVejD1kR7Z8VbBrr5X+qxm6VWd7l5R8Uxxfy+9+t10IBPSY5UBpZp8qRnV
         Od/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rC57if6zTGOgurlYLWvBBTGyEEoR1y0RiHyLtTaQ6Kg=;
        b=HwVxyhyc1q1fJmKzqQivMgMh1M8t7YPGpXhnGHM+ekE0P4SvgswK262nLoh6tcSWSd
         lgS3c7HW3Ov+8GiZf2kdYfSTe/t+eBCr8YHxy1uZv77L1RFMb18svOup4WBObbZDbWna
         T5bP4iFX7x2DlIJ8zlb42mE+W3UOd63nBDjuvo6s0L9O/l86uYcF0KJGrKTbwaop3xW7
         whnGrx7O54OtFP0Y7F6jyRwGn2a8nVXSBnMfwU5y9HSgujDkLXwDS3DM2zvsYOdAE40s
         VZSO8C10AcGtuxWoiMNWqzFIbyThm4GzjLOKE0Y23zPCx6OU0ZWzVvHeXc5kekmN4f9b
         umcw==
X-Gm-Message-State: AGi0PuZESNCQdhQ7RkJNc9av2/rm+qoivKfUfMckw7lvxGPb28fcb43e
        zOgW4HWKZqXfQUHvAKT/oCi5NHfywu+GIaZwVzU6auE=
X-Google-Smtp-Source: APiQypKxXN/9YUVBQRQW+z4ohlub61hoGag0mpqNklohnV5CqskMX0iQUeu2nqfLW91/8OjeLiNztqatJWe85MtAgVg=
X-Received: by 2002:aa7:cd59:: with SMTP id v25mr11403024edw.135.1588538100676;
 Sun, 03 May 2020 13:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200428125514.2780171-1-omosnace@redhat.com> <20200428125514.2780171-4-omosnace@redhat.com>
 <CAHC9VhSP70QB4A4zjLScK1uGxBUhzHXi9UUVKk0kDoKbJF+PrQ@mail.gmail.com> <CAFqZXNtRazyUY--gSUz+e=0=V6v65oqN-GqHa-HWz0D3sS5SgQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtRazyUY--gSUz+e=0=V6v65oqN-GqHa-HWz0D3sS5SgQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 3 May 2020 16:34:49 -0400
Message-ID: <CAHC9VhThaSEpKoEtjpgvF7nPx+Vr-hoRdHsQJi7A7ex213pH_Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] selinux: prepare for inlining of hashtab functions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 2, 2020 at 5:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, May 1, 2020 at 10:33 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Apr 28, 2020 at 8:55 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:

...

> > > diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
> > > index 31c11511fe10..4885234257d4 100644
> > > --- a/security/selinux/ss/hashtab.h
> > > +++ b/security/selinux/ss/hashtab.h
> > > @@ -13,6 +13,12 @@
> > >
> > >  #define HASHTAB_MAX_NODES      0xffffffff
> > >
> > > +struct hashtab_key_params {
> > > +       u32 (*hash)(const void *key);   /* hash function */
> > > +       int (*cmp)(const void *key1, const void *key2);
> > > +                                       /* key comparison function */
> > > +};
> > > +
> > >  struct hashtab_node {
> > >         void *key;
> > >         void *datum;
> > > @@ -23,10 +29,6 @@ struct hashtab {
> > >         struct hashtab_node **htable;   /* hash table */
> > >         u32 size;                       /* number of slots in hash table */
> > >         u32 nel;                        /* number of elements in hash table */
> > > -       u32 (*hash_value)(struct hashtab *h, const void *key);
> > > -                                       /* hash function */
> > > -       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2);
> > > -                                       /* key comparison function */
> >
> > I don't like how you've split the hashing and comparison functions out
> > of the hashtab struct and into their own data structure with no
> > explicit linkage between the two.  This is a bad design decision in my
> > opinion, and something we should try to avoid.
>
> In general, I would totally agree with you, but in this case this is
> crucial to avoid the indirect calls. Granted, the commit message fails
> to explain this and I need to rewrite it (and the callback separation
> probably deserves a comment in the code as well) ...

Write a proper commit description for the patches and resubmit them,
I'll take a closer look then.  Generally when I see a poor commit
description and something odd in the code I stop reviewing the patch
and push back asking for a better explanation, which is what I did
here.

As a reminder, I have yet to reject a patch because the commit
description was too long, or too detailed.

-- 
paul moore
www.paul-moore.com
