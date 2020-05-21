Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E719DC433E0
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 12:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99F32072C
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 12:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeEqfNJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgEUM6l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 08:58:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47900 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728133AbgEUM6l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 08:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590065919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ja2uVJlIxeRYrSBA5fHlt+tQZsiOYdA4UjNfTArqj3Q=;
        b=YeEqfNJHWYUk5jYmtWagjtIS7QPGqOV5fpl7VKevuZlv0v9cmVxbPOultXpXvXplYBYKf1
        hBkIArxG7iZOzmG67FlbJcKcsMiHL0vLPz7s5xNpSyCKmNyKrJJQaDGtgldDQRAA56BB4p
        khjkNXGJUvYpzM6vOPsVvK9QOXl3rSo=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-x3XV5EhjODCmgE4_zt4bBw-1; Thu, 21 May 2020 08:58:38 -0400
X-MC-Unique: x3XV5EhjODCmgE4_zt4bBw-1
Received: by mail-oi1-f199.google.com with SMTP id g187so3222353oif.14
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 05:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ja2uVJlIxeRYrSBA5fHlt+tQZsiOYdA4UjNfTArqj3Q=;
        b=uk/5bMSAZAfs3Y9JBniIygjgqHQKx/ktStIufwRK1pnv8S6oOygujRNtYySnNdEBa7
         fO1voyk9wOKMT5w6/dXk/X21xAJm562uM0VHXn6luZI7GY/FpM+Xa2BicjnSIPO3S3+9
         mzIISi1ITGHiJ9j5RGLGWcUb60Fz7zNnjQuxZJELvlUVW9d9rO4W/kuVAdofVQPkqrLo
         yOeZhAwbHVdUtnoDdA70GRZ8pk2gvPtm/NP6hIU0Wpu8kyATunuDCkkf1Al0YYwueaay
         2Jani0S8nnDTRwARGT+bopL5rajH0qc2n08JzU0qEJ6dDSl607jT4uBKM2QoFjCnEfnI
         Q0eQ==
X-Gm-Message-State: AOAM532OLwFS0Zdp7WXUTqczK2eSt0gdYQY+cdOH8Zptk7NHxrcwrTwN
        0wln14y+hn/vyOrtFgLUohTla67cTiQ4bg7Y14FUT/fQxiyku6IRObcrkWyVWP/17Hk6c1LVDeG
        F0XGtW/hsW7PW0ZrlOAIYjVD7EnMan6wXdQ==
X-Received: by 2002:a4a:d043:: with SMTP id x3mr6858651oor.17.1590065917249;
        Thu, 21 May 2020 05:58:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAfkrpuLeUWZDyWwXfAJccr0xB8P1kraz105ZLdLdVWU1IPJP6w9s3oX+fN79wQ3C97c379Y3tMW8UWdpxIFA=
X-Received: by 2002:a4a:d043:: with SMTP id x3mr6858638oor.17.1590065916961;
 Thu, 21 May 2020 05:58:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
 <CAFqZXNsV8fUeA-tT4kMtmaNaDK6_LkqvftY-SF7+RUrSBkWUvA@mail.gmail.com> <CAEjxPJ7HwA_5E6vCrtRfKK=Lpppp-WEbBa_5cVJvzH7fLSGD_A@mail.gmail.com>
In-Reply-To: <CAEjxPJ7HwA_5E6vCrtRfKK=Lpppp-WEbBa_5cVJvzH7fLSGD_A@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 21 May 2020 14:58:25 +0200
Message-ID: <CAFqZXNuOTsPrE-0D7OD7jZ4ETWgwW4HCVywnooJs4Q4Qk3d5EQ@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 21, 2020 at 2:52 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, May 21, 2020 at 4:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Wed, May 20, 2020 at 6:34 PM <bill.c.roberts@gmail.com> wrote:
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > The current Travis CI runs the userspace tooling and libraries against
> > > policy files, but cannot test against an SELinux enabled kernel. Thus,
> > > some tests are not being done in the CI. Travis, unfortunately only
> > > provides Ubuntu images, so in order to run against a modern distro with
> > > SELinux in enforcing mode, we need to launch a KVM with something like
> > > Fedora.
> > >
> > > This patch enables this support by launching a Fedora32 Cloud Image with
> > > the SELinux userspace library passed on from the Travis clone, it then
> > > builds and replaces the current SELinux bits on the Fedora32 image and
> > > runs the SELinux testsuite.
> > >
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> >
> > From the text above I infer that this patch is intended against the
> > userspace repo, right?
> >
> > If so, I don't quite see the usefulness of running the
> > selinux-testsuite on every userspace change... It is mainly intended
> > for testing the kernel and only a small part of its running time is
> > spent on running (i.e. testing in a sense) the SELinux userspace
> > programs. Not to mention that in your patch it runs with the userspace
> > shipped in Fedora and not the version from the given commit...
>
> Last I looked, his script builds and installs the userspace code on
> top of the Fedora libraries and programs (make LIBDIR=... install...)
> and then runs the testsuite.  That was my suggestion.

Ah, yes, I can see that line now. Sorry, somehow I missed it before.

> While it is the
> kernel testsuite, it exercises a lot of SELinux userspace
> functionality that isn't tested by the userspace tests.

OK, I suppose it's better than nothing...

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

