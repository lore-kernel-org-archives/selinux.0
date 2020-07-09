Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3D1C433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B74C620739
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qPsMSuAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgGIAY6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgGIAY6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 20:24:58 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56F7C061A0B
        for <selinux@vger.kernel.org>; Wed,  8 Jul 2020 17:24:57 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so418844edq.8
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2020 17:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVt5r0rW7b4VNRPLMeQzqBVn/dTpVnT+sAfbgX3+7y0=;
        b=qPsMSuAT0T3NHfOEKAPPh6KEECewIANO1r5kEMykIrQzLqLcVLO82i45mJ3Iq3QEwd
         yoeK9YRQxtJacPiZIbVKcAfSSWtZ8H00pqlnqmKTJrzhnfQCbyyAKvD0v2ssx1Gy55PQ
         ijScXXoB/CdxHv0kZqFrCXyzwn4KTW2xjIZoZ2mrpDvZNgbxvJxClb8B+RHewzZoGUN0
         Y+nqSejZRZNdBOT4H9T6I2E1a9UVav8+FYN6QGMaxgE5o3rvPw5gz2p271Gf2numBWus
         GBXKZMHjGoevINE7Ck5A2peYt2/oPRKNXu+Iok6u2o5IDeuSJiz15eKmEdDH7BATgMHp
         WbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVt5r0rW7b4VNRPLMeQzqBVn/dTpVnT+sAfbgX3+7y0=;
        b=R2oCMn2wyCGC6osjCQ5n6E0RBmhT0H6o9p3Qeim2xIVbHOOyjML1Y/1YNrWmOhxvVn
         VnYPjKElgAFx/AoR7zQWNqF89TstufaMMc45ks7nwEfSwuta+SbzsjkrNFciUFphHH3e
         mAIlUJI89fRYJy8BAt9JnVBExVoGWeZE7ntuu7Y3od6Q3Iu+puDoS64nqhPGD7WJsZ0L
         NmNganXcxq7V8f2Zlo4w1PfNtHPVmFqiuWit1cdNUJ3XSm/10iYOtZiO3rH4GYq40TT5
         k4fzc2xapXg/f8Y7BDMObgbFTTKfSY4N3SR4p2Fr9JT2nFmQBDOAmUhVpJ64Dxjh5Wnc
         v+uA==
X-Gm-Message-State: AOAM532ia2i/OiuwbhVk0GdGF7vVgU1neVNQPt+pW/r9fEY2quw9+M/v
        VziLxuzz0vrmWD9lu+iW95Yrwg9Gj/sFFbvhQ/3T
X-Google-Smtp-Source: ABdhPJxFhjlmM3crUSfOAQ3SFwGHIcXXiDm2b12kEWsZbrErobfo9LG0KYERSzR02zK4UJk7uB3bFTeKXbfVDLSKemM=
X-Received: by 2002:a05:6402:1d89:: with SMTP id dk9mr57857067edb.31.1594254296376;
 Wed, 08 Jul 2020 17:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200708112447.292321-1-omosnace@redhat.com> <20200708112447.292321-2-omosnace@redhat.com>
In-Reply-To: <20200708112447.292321-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Jul 2020 20:24:45 -0400
Message-ID: <CAHC9VhSZz=y6LWTvMH3fACdvgVPOSqGZYX0U9YZGyidP9n-3mw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] selinux: specialize symtab insert and search functions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 8, 2020 at 7:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This encapsulates symtab a little better and will help with further
> refactoring later.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/conditional.c |  4 +--
>  security/selinux/ss/conditional.h |  2 +-
>  security/selinux/ss/mls.c         | 21 +++++++------
>  security/selinux/ss/policydb.c    | 52 +++++++++++++++----------------
>  security/selinux/ss/services.c    | 34 ++++++++++----------
>  security/selinux/ss/symtab.c      |  9 ++++++
>  security/selinux/ss/symtab.h      |  3 ++
>  7 files changed, 69 insertions(+), 56 deletions(-)

Regardless of the other patches in this series, I like the changes
here so I've gone ahead and merged it into selinux/next.  Thanks.

-- 
paul moore
www.paul-moore.com
