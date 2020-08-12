Return-Path: <SRS0=FvZo=BW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BC9C433DF
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 09:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16D720781
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 09:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bn8I569O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgHLJAR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:00:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30724 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726618AbgHLJAQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Aug 2020 05:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597222815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o2vJJlSAhXz4kjoICSJTd6Qdn6UAhIJnAh6vrLM3sNg=;
        b=Bn8I569Orxs7UK8Fj/LItBKwy9k4qyGZTUbpkp0aRtteV18M+eUdy3duSm+K2g+MmCTa7X
        Yyhtrg9RnOlWKv6z8t1uz4B0eEs9xMCn4S9u3DPi5QS5GxUB+6NPd8qRHF3Bt4G4Sk72jS
        WS7SauWScVTj1OIDrLgwk86xaR7pr7U=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-HmAYhzM6OqiqotlQDRuR2g-1; Wed, 12 Aug 2020 05:00:11 -0400
X-MC-Unique: HmAYhzM6OqiqotlQDRuR2g-1
Received: by mail-lf1-f69.google.com with SMTP id o9so433623lfi.23
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2020 02:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o2vJJlSAhXz4kjoICSJTd6Qdn6UAhIJnAh6vrLM3sNg=;
        b=FEGMDb9vJW1GfTC6C/ejdotzDbQuCqwxS88p+eClC7SOd5sNpmxXBhFUSz+5comxlx
         SgaG2QK14jntkIaB6jPfrFxYeP2wX01wxcHfz5MQX3rQMr7mTE8Oo6wJ65fLo0cd9OEz
         a0XmbLL0O86NrQXOdx4qMs2TcqzilI9NCKgUYlnYe2tRZzyyu68qdSEcJA7KFZsZDpAm
         IR+lIFzDaWQ4DE3DbwuynoXfO+Un+buCcQJaXSlATx/F++ZXxzv5RzfrRFY1zoEWpz/U
         8LzxFGo27xV68C6YT43jhgDYQifwXTkRzYfctIc83NEZi2g8FYenBMUaJdnFIXW7V7Yl
         79+w==
X-Gm-Message-State: AOAM533ZmL4MaBs1YaV0KRkugJiqCtmDMWKcHu2q9ZgOVMsxCJ0YSRyd
        uEutarbYewDAlaWzLQlClOlfJNxb+DZyQcJ125j60McuMcTuRF+baV7DoeR9nzFaU/m4lugzMlr
        T8RsBkEtQFkwcznD7Fy1Vk2dQZUvvkELfpA==
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr5213650lfo.125.1597222810116;
        Wed, 12 Aug 2020 02:00:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtgphzY+JJE4QifokUtaAcS4zIgG+PWeuYlmvj2+kDDc4pNv+YUN8GoPxpVLjUm4QOt0p1GPCOAY9dqtpsu9A=
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr5213638lfo.125.1597222809877;
 Wed, 12 Aug 2020 02:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200811084555.105374-1-omosnace@redhat.com> <20200811084555.105374-3-omosnace@redhat.com>
 <a7e521af-48ba-47d1-c752-1222ecc135ad@gmail.com>
In-Reply-To: <a7e521af-48ba-47d1-c752-1222ecc135ad@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 12 Aug 2020 10:59:59 +0200
Message-ID: <CAFqZXNvyx613z4reu0cgy8HGHo49+pyOZGaJCqziLVBr6prmhA@mail.gmail.com>
Subject: Re: [PATCH testsuite v2 2/2] travis: run the full testsuite on a
 Fedora VM
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 11, 2020 at 7:48 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On 8/11/20 4:45 AM, Ondrej Mosnacek wrote:
>
> > This patch removes the old hackery to test-build the testsuite and
> > replaces it with scripts that run the full testsuite on a Fedora VM. The
> > scripts are based on William Roberts' work on SELinux userspace CI [1],
> > which does a similar thing.
> >
> > This patch enables testing on Fedora 32 (the image ships with kernel
> > 5.6.6) and Rawhide nightly images (with kernels close to mainline).
> > Switching to other versions can be controlled via CI environment
> > variables.
> >
> > One downside is that with this patch we lose the test build against
> > refpolicy, but it shouldn't be too hard to add testing on a Debian VM
> > with refpolicy later on.
> >
> > [1] https://github.com/SELinuxProject/selinux/commit/562d6d15272420542bf65da328bc5300219fce76
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
>
> Thanks, this is great.  One more question: when we added the VM-based
> testing to the selinux userspace travis, we nonetheless kept the old
> limited build / unit test run on the Ubuntu image as well to provide
> some degree of sanity checking there (plus it is much faster and
> possibly less prone to intermittent breakage).  Is there a reason to
> drop the "old hackery" entirely or should we retain it too?  Up to you.

The problem with the existing CI is that it broke recently :) I
realize now, that probably no one knows but me (I noticed it when
preparing to merge Richard's SCTP patch), so I should have explained
that better in the commit message... Basically all my attempts at
fixing it quickly and nicely have failed, so I figured it would be
easier to try to adopt the KVM approach instead.

I see your point about the existing CI being faster (well, at least
when there is a cache snapshot available...), but unfortunately the
testsuite logic is too much dependent on the kernel version and the
uapi headers that it's not easy to keep it working in the Travis
environment... Add to it the complexity of selinuxfs mocking, building
and installing two policy variants... It was good while it lasted, but
I think it's time for it to retire now.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

