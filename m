Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B18EC00A89
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423312222B
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 15:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPI+zUgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgKBPS7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 10:18:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbgKBPSz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 10:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604330334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMcxHNiu0GfCGzDhCicVmPp8vp0/feR+a+97NmH1nW0=;
        b=iPI+zUgHDFddoXKHPPpqjEKWL71h2a3abFwm6n2OkiyfP/yg/3ZRpBaLIKx9QnbYTN+MRJ
        V3DzL+PjgTYqM+7j0vvLPYyqRBXTM/D2vLrrnx6pMdMT9WI2QJHUV7qx+3qwbtlLOdjilD
        PRBxh/2fRQthLv72kc+fxUmI9OOC9Ic=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-0bkGL3cGNsiWQbYeA0XzAQ-1; Mon, 02 Nov 2020 10:18:51 -0500
X-MC-Unique: 0bkGL3cGNsiWQbYeA0XzAQ-1
Received: by mail-lj1-f200.google.com with SMTP id d5so3446484ljo.17
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 07:18:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMcxHNiu0GfCGzDhCicVmPp8vp0/feR+a+97NmH1nW0=;
        b=rLADILKranNnrrisdQHOr4Pu3fiGu0TDcYtrff4j+XT96PLuhIvVBBGv9fdeFhMtbD
         k4+PJWTcNlbsWYCU8CSab+XgHuWr/Ae0sGuxv1eXTUbx00UiF657/L4ydyDSs86kY1sC
         jtCnN4ZsC6WV1ppZHBXrHHnX3J2V7zjIHb4f/IBNtTpHLOEt4O/2R2N9oUxYWrigEtCk
         v8FOwJUzUoGhWcXTtX5lBpmUc3MRG/sk9Fjy1objv+H5dTh127g8faDhcdGi1AtCV7yh
         VmlmQAcg2KdFG4zrMhkwW6h1JcfCZbPhCqGdfGjvg0ZW3UnyDZRdOPazPdJEcS8abZUe
         jYaA==
X-Gm-Message-State: AOAM532smuSstFjNXGnVjzmLjuYWPMzGM0u+R5PfoSgp4TvrbCyl2GO3
        sqErJhrpVDGJRNVFUUXuY4wZFIjSu3f+rvS035IpUVG3chDcG0zF3hLhgv8yIfHewew7+Kc6iow
        JSuGXncLze5Mdt3vA4lyKDAN/XyEJRVgyiA==
X-Received: by 2002:a19:c8c1:: with SMTP id y184mr5670817lff.598.1604330329180;
        Mon, 02 Nov 2020 07:18:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8qH+QBIYn4gchdnrVnb2YmdbatZ8/yas91bTKC5iLB+3CIfYJDqvWSEwH5w6AnjIsGXXRlwOq4blorJwOdPI=
X-Received: by 2002:a19:c8c1:: with SMTP id y184mr5670814lff.598.1604330328974;
 Mon, 02 Nov 2020 07:18:48 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNtWg4+PrjizBcaa9hwQHdq1qQN4RzeqFS_y_8R9KZfMSA@mail.gmail.com>
 <CAHC9VhRMsh5iHbunu0qJyheENm8a+KSnonLLuBynDWbBmOq3Og@mail.gmail.com>
 <20201027163749.GA25212@localhost.localdomain> <CAFqZXNswY13BoABpXGOQq=kOsORRJPY6HEPjDE3ZRXKQhW2vTA@mail.gmail.com>
 <CAHC9VhQhKkS7hSfyOyef6c-gjmY-ab_L6mMR0SxAshv7d5Tm8g@mail.gmail.com>
In-Reply-To: <CAHC9VhQhKkS7hSfyOyef6c-gjmY-ab_L6mMR0SxAshv7d5Tm8g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 2 Nov 2020 16:18:37 +0100
Message-ID: <CAFqZXNspH6MmB-o0wtJJwj-p0DKKrH-ZjfW2YkF_yQS_gCBwqQ@mail.gmail.com>
Subject: Re: [Travis/GitHub] Migrating SELinuxProject projects to
 travis-ci.com (vs. travis-ci.org)
To:     Paul Moore <paul@paul-moore.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 2, 2020 at 3:46 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Nov 2, 2020 at 3:04 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Tue, Oct 27, 2020 at 5:37 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> > > On Mon, Oct 26, 2020 at 07:04:52PM -0400, Paul Moore wrote:
> > > > On Mon, Oct 26, 2020 at 9:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > Hello everyone (mainly the maintainers of projects on GH, but to avoid
> > > > > a huge cc list, I'm sending this to the ML),
> > > > >
> > > > > As you may or may not know, Travis is migrating open-source projects
> > > > > to their main site [1][2] (to .com from .org, where they have been
> > > > > until now). AFAIK, the functionality stays pretty much the same, they
> > > > > just want to have open-source and private projects under the same
> > > > > infrastructure to unify things.
> > > > >
> > > > > Recently, they started migrating runners away from the .org site [3],
> > > > > resulting in new builds being queued for a very long time. [4]
> > > > >
> > > > > I tried to migrate some of my forks (selinux-testsuite and selinux) to
> > > > > the new site and it went smoothly. The only downside seems to be that
> > > > > the build history is not migrated immediately (but it did show up
> > > > > after a while). The queue times were indeed resolved after the
> > > > > migration.
> > > > >
> > > > > So, I'd like to propose to start migrating the projects under
> > > > > SELinuxProject that use the Travis CI (selinux, refpolicy,
> > > > > selinux-testsuite, setools) now, so that we are not affected by the
> > > > > lack of workers.
> > > > >
> > > > > If there are no objections until next week, I'll migrate the
> > > > > selinux-testsuite, for a start. The other projects I'll leave for the
> > > > > other maintainers, unless they choose to mandate me to do so :)
> > > >
> > > > Sounds good to me.
> > > >
> > >
> > > Please do it for selinux too. Thank you!
> >
> > Apparently I would need to be an admin/owner in the SELinuxProject
> > group to do anything... So either one of the owners will have to do it
> > or make me an owner :)
>
> Done :)

Thanks, I've just migrated selinux and selinux-testsuite:
https://travis-ci.com/github/SELinuxProject

I can also migrate refpolicy and setools if Chris gives me a thumbs-up.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

