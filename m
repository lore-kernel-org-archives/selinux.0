Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CED5C433DB
	for <selinux@archiver.kernel.org>; Wed, 31 Mar 2021 08:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F746146B
	for <selinux@archiver.kernel.org>; Wed, 31 Mar 2021 08:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhCaIYK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 Mar 2021 04:24:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231172AbhCaIXq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 Mar 2021 04:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617179025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nW26Mq8BB9eHVar4otdQjvL3tMCGORHu7i0Uxt2O1Sg=;
        b=jEJGwQN3Qjb8To2R3runYfQR4gtPgXpRNWi90p5ppKR2igvlwH30bHXrYNjzjiOUgXM1HU
        /xc8aQeTF9szrqN2KVQTUGI1PvbGszl5ROrtUMY+Y2NUXAD9v1ug2rfA5nn+yHTD0peI5i
        Iu2Aom9swbhhkXepC612uHeJ3d70G5Q=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-pK7j8FFvMiudsqnO7PNbVA-1; Wed, 31 Mar 2021 04:23:43 -0400
X-MC-Unique: pK7j8FFvMiudsqnO7PNbVA-1
Received: by mail-yb1-f198.google.com with SMTP id e129so1460559yba.3
        for <selinux@vger.kernel.org>; Wed, 31 Mar 2021 01:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nW26Mq8BB9eHVar4otdQjvL3tMCGORHu7i0Uxt2O1Sg=;
        b=tuxYf1NVIW95lFF/zGqQsKcLY+EfXav/irghyKsUnD/RZwV/eYZf8yeyUWlh2+rdkM
         Mja7UZzznHG2u3ZvQRF69C9rGqqa//gJDQDa/odg947HfO4zPEeUUBxCaAV8H1ga84yM
         l5k19os8RWc6QSlfEBoTzqIzt8e7iNHU8Wt75W/mbox9w4nWss1jR7XrkACNY2EHFH1K
         pMlEeUmRDGbK4ppGLKLvSDctT8Bxlr7ByNJvh8biJR0UTl3cC7bNGg/1shkvkqr0JX8Q
         aCIAFwApqHaaT8uHx5I10+YHVJC3YW0uj/74b3jVujumQjBsjdwvEgEZ+c5TmW5U8fk5
         ZQ4g==
X-Gm-Message-State: AOAM531Eigf7nj1m0qQ64Oy3bu89c6My1fz/USRWMDffXFhUfYcZIIK+
        E5I5HvxcLb63gjjI5Q1o8Km9NWMLhsnnpAIGgrMC1+95JafoWVgdEN+UvEgC9vMd7wSocnfIEUl
        neRrARCiQDu8+u7OQMRRyCjX1o/aH7llLTg==
X-Received: by 2002:a25:3752:: with SMTP id e79mr3174125yba.227.1617179022694;
        Wed, 31 Mar 2021 01:23:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3Ldbs9RFv2zh5A7JVn4HV2WGAhtpWkRyx/FOwhN4aSVH/ocZeltPjHJR9tZqxvCVST4k/P9Xfi4Y20Coz+l0=
X-Received: by 2002:a25:3752:: with SMTP id e79mr3174106yba.227.1617179022465;
 Wed, 31 Mar 2021 01:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210330131646.1401838-1-omosnace@redhat.com> <CAHC9VhQHTP4eXTEDtd=TztN-wPC=EZ84SG44sX9bZ=KtLfzp=g@mail.gmail.com>
In-Reply-To: <CAHC9VhQHTP4eXTEDtd=TztN-wPC=EZ84SG44sX9bZ=KtLfzp=g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 31 Mar 2021 10:23:30 +0200
Message-ID: <CAFqZXNvoDLmjYBEpgnC5Ba6nDVdi11Hbdj=6v=dJYA_bihQERw@mail.gmail.com>
Subject: Re: [PATCH 0/3] selinux: fix changing booleans
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 31, 2021 at 3:13 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Mar 30, 2021 at 9:16 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > This series contains a patch that fixes broken conditional AV list
> > duplication introduced by c7c556f1e81b ("selinux: refactor changing
> > booleans") and a couple "and while I'm here..." cleanup patches on top.
> >
> > Ondrej Mosnacek (3):
> >   selinux: fix cond_list corruption when changing booleans
> >   selinux: simplify duplicate_policydb_cond_list() by using kmemdup()
> >   selinux: constify some avtab function arguments
>
> Please don't resubmit, but in the future if you are submitting a patch
> (or two (or three ...)) which is potential -stable material (and so
> far I think 1/3 qualifies) don't submit it in a patchset with trivial
> cleanup patches.  Adding cleanup patches to a patchset that adds a
> feature is okay, but fixes should generally stand by themselves.

Okay, but in this case the patches are sort of interdependent, so I
didn't want to mess with a rebase and sending conflicting patches... I
did move the bugfix patch to the bottom so that at worst you can pick
it out and ask me to resubmit the rest some other way.

Since I'll need to respin the bugfix patch, will it be better if I
repost just the one patch?

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

