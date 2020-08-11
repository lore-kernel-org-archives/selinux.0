Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFFBC433E0
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 08:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28FCC206B5
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 08:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6cIgo6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgHKI7W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:59:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54577 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728224AbgHKI7W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 04:59:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597136360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFOyVYPLThdPjz1eFLOgMh6QzO2YRCyb2CD9AwsYxlE=;
        b=L6cIgo6THPGRYQaxls3gH1D0/gOdYNsk1stOJV+W6IJmmnyJP13F/Y9ypMA++ytP2dj60L
        Gdcaid8QlDEq8gM1syvj8FBabeB+q16ZRcCtxfbny/PfUfw64ao88x/oMRk7mMR9p8tP8x
        OdIb6/0MhBTeFlWeYWlQJphiAlO5caY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-kQCxRARJOJeVe48-JceTtw-1; Tue, 11 Aug 2020 04:59:19 -0400
X-MC-Unique: kQCxRARJOJeVe48-JceTtw-1
Received: by mail-lf1-f70.google.com with SMTP id u11so3894385lfg.11
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 01:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFOyVYPLThdPjz1eFLOgMh6QzO2YRCyb2CD9AwsYxlE=;
        b=TpSrq/tDMbssxSuMvQ8AXHPs0EwqQs5trHg5/0nDxYT5yaS89QXNzGocbPJEHgucKT
         GQgboHpi+Snq44/H5dOlhFeaYmUMTc0IVE9k4B/aQJr1GJK82JJX6Rbhpc0/QyHZul5M
         Bj26TX4GL3CYE0B+f2+3s7bYUiftZEaYcWJ3KZIELyiPym8wCUj70d1QsQoirjV8EscN
         YQ9KfecvtO9UaxCGCJmISItHHzShx/pwS3mtdp4U0obKS6Of88a/ToPxnqB6NfVD2HD2
         R/qohCTOeJsfchKeY9CllQjouh0WrIb5MTu6I9JuYb4vQB5XNNLANFfGAq5n3Q9d/TQ3
         jxhg==
X-Gm-Message-State: AOAM532UlGhfO1TBtzI60cdtKfTgVrVsNS1e/ULvw4RHMfR2w0sTi3ul
        UxEYEFQVdSB9swHrUbG3oiZePOPUG7X2OoPy3bvh/8wvds8a7V3MJiT/ndPLTqTbnODMKREz9fj
        rO5WvruBrrlDjMJ7niM5JXNQR8hxy13d6Jw==
X-Received: by 2002:a05:651c:217:: with SMTP id y23mr2453545ljn.123.1597136357444;
        Tue, 11 Aug 2020 01:59:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwync24cG1LDneJiubr1364c4ijlh03/6gz48O9ptsgd6smaHozqx398XWLbFwVBvgXLwjH6jVhgWXR8m4VweQ=
X-Received: by 2002:a05:651c:217:: with SMTP id y23mr2453534ljn.123.1597136357136;
 Tue, 11 Aug 2020 01:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200807132640.1787455-1-omosnace@redhat.com> <CAEjxPJ6ZOLTG91DzMCw3iat=p=Y0K0So7Yg7zeUnYdivuDAk=Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ6ZOLTG91DzMCw3iat=p=Y0K0So7Yg7zeUnYdivuDAk=Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 11 Aug 2020 10:59:06 +0200
Message-ID: <CAFqZXNtogqZXMEcLqA=ci7oiVSYvp0QNvq40zmBJ39B7XpgVHA@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: run the full testsuite on a Fedora VM
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 7, 2020 at 3:42 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Aug 7, 2020 at 9:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > This patch removes the old hackery to test-build the testsuite and
> > replaces it with scripts that run the full testsuite on a Fedora VM. The
> > scripts are based on William Roberts' work on SELinux userspace CI [1],
> > which does a similar thing.
> >
> > The CI currently uses a F32 VM image which comes with a 5.6.6 kernel.
> > Eventually we might want to run on a more recent kernel/userspace, but
> > even this is already a big improvement over the old CI approach.
> >
> > One downside is that with this patch we lose the test build against
> > refpolicy, but it shouldn't be too hard to add testing on a Debian VM
> > with refpolicy later on.
> >
> > [1] https://github.com/SELinuxProject/selinux/commit/562d6d15272420542bf65da328bc5300219fce76
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Sounds good to me.  Only question I have is whether it would be
> possible to use a Fedora rawhide VM instead of a fixed version like
> 32?
> I understand that may have some stability issues but it would get us
> more recent kernel, userspace, and policy for testing.

I just posted a v2, which runs the testsuite on both:
https://lore.kernel.org/selinux/20200811084555.105374-1-omosnace@redhat.com/T/

> On the Debian side, I'd recommend Debian unstable which despite the
> name is more stable I think than rawhide and is what I've used for
> getting the testsuite up and running on Debian.  That exercises more
> of the tests than even Fedora rawhide does currently due to defining
> more classes/permissions.

Yes, it would definitely improve coverage, but I'd rather pass that
baton to someone else at this point.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

