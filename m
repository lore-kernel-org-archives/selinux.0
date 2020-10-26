Return-Path: <SRS0=Dm73=EB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16726C4363A
	for <selinux@archiver.kernel.org>; Mon, 26 Oct 2020 23:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB5C20708
	for <selinux@archiver.kernel.org>; Mon, 26 Oct 2020 23:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jC99khyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395392AbgJZXFF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:05:05 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:34436 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394532AbgJZXFF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Oct 2020 19:05:05 -0400
Received: by mail-ed1-f48.google.com with SMTP id x1so11480144eds.1
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2020 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfTqq/gPwaApTRV0xmHS+pSLibIuO9NNiUnZJdzhJhE=;
        b=jC99khycp5DH8C2TiX4YjNViyyiboSkZsOs67Qs2myWmxZyKd9hh7nQFL01FKDqS+t
         aDDQNdyJj/n+D+grki0kFc4mDlspJ1r58dOrHNjYO7+DKjzLG9Rna/sc8HAMawt61eQP
         U4Xebc5j9EKZ2rli7lxQvEDN/5CIU+bHly/nzJehCGw8E3qAV/IX0z8kS3rQZxJT0dOI
         628G+l1W3JYMDUvu6NLtNpIp3E0+Qi0f/2sA76obhPVDbPgUHcPKT1sVI2z9kvIW8bl0
         FqegrqBHf6QKvSNXB44mAbCE+81M3SUvo3i6wFvi0Y1G2Qo+uvPEu1XQbkkSXzOrlWWP
         wtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfTqq/gPwaApTRV0xmHS+pSLibIuO9NNiUnZJdzhJhE=;
        b=e+SOxHg8c9rv1YM36VuCRQNyCgLd1LsD5+zKsVRkRam4+roMBQujQV4pUaLe9EJKGf
         byQ6IwPwFtSuIbou45H/910mpi5eCia3FXSR4UR63zRKF8Ee/jGeTQmXiw0ibvChs++y
         hpdGN89lzyzCXODXgKUTv7JQrSrmZdlSUm4PzmGYPwre7Es+YrCignOPx6jp+Tz2QRYe
         tBV7Av2t/IT9JDUmuRGtO0eU6BVOaK9fK9gZa/eSJ8kXSmGdV3DW3bQ3dEC+BU0/ppEP
         IAWVeR668fvLgP4wbSrKnJS5vLonZGG/8d5b2n3c3ngge3+7JY6mLP1PcFXFkfMfiyyF
         APEA==
X-Gm-Message-State: AOAM532JI1ktRGPYS/guQ1fP59YlU9wtAED+OTJGmCNwOEskVFvvqize
        cdqxnqI4fMC4D9+PJo236b+K9kSQ01FLCsXQEoVeVz85Bg==
X-Google-Smtp-Source: ABdhPJxn4FSZABNZY+mJw4oYZbhe9GtxaSRCcwvaFVI+E+MuDY32/5TA3iYfgKrrlGnZad/GoKWfv0H/M8jSEJSAdBI=
X-Received: by 2002:a05:6402:94f:: with SMTP id h15mr17541423edz.12.1603753503223;
 Mon, 26 Oct 2020 16:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNtWg4+PrjizBcaa9hwQHdq1qQN4RzeqFS_y_8R9KZfMSA@mail.gmail.com>
In-Reply-To: <CAFqZXNtWg4+PrjizBcaa9hwQHdq1qQN4RzeqFS_y_8R9KZfMSA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Oct 2020 19:04:52 -0400
Message-ID: <CAHC9VhRMsh5iHbunu0qJyheENm8a+KSnonLLuBynDWbBmOq3Og@mail.gmail.com>
Subject: Re: [Travis/GitHub] Migrating SELinuxProject projects to
 travis-ci.com (vs. travis-ci.org)
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 26, 2020 at 9:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Hello everyone (mainly the maintainers of projects on GH, but to avoid
> a huge cc list, I'm sending this to the ML),
>
> As you may or may not know, Travis is migrating open-source projects
> to their main site [1][2] (to .com from .org, where they have been
> until now). AFAIK, the functionality stays pretty much the same, they
> just want to have open-source and private projects under the same
> infrastructure to unify things.
>
> Recently, they started migrating runners away from the .org site [3],
> resulting in new builds being queued for a very long time. [4]
>
> I tried to migrate some of my forks (selinux-testsuite and selinux) to
> the new site and it went smoothly. The only downside seems to be that
> the build history is not migrated immediately (but it did show up
> after a while). The queue times were indeed resolved after the
> migration.
>
> So, I'd like to propose to start migrating the projects under
> SELinuxProject that use the Travis CI (selinux, refpolicy,
> selinux-testsuite, setools) now, so that we are not affected by the
> lack of workers.
>
> If there are no objections until next week, I'll migrate the
> selinux-testsuite, for a start. The other projects I'll leave for the
> other maintainers, unless they choose to mandate me to do so :)

Sounds good to me.

-- 
paul moore
www.paul-moore.com
