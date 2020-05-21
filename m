Return-Path: <SRS0=ZZHY=7D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860D7C433DF
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50605206D4
	for <selinux@archiver.kernel.org>; Thu, 21 May 2020 14:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIGHmK+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgEUOL4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 21 May 2020 10:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgEUOLz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 21 May 2020 10:11:55 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AA5C061A0E
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 07:11:55 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h10so7546441iob.10
        for <selinux@vger.kernel.org>; Thu, 21 May 2020 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFwa3MRIeZXEwgXVflwLlvQa5g8vxfjhTc04/l3hJOg=;
        b=KIGHmK+squDTx2UdaLZqmtI+oCyxD8mH5009+1vJVXd6l9miZBdo4Ejw8WZiLP4dEe
         eWng14uB4QncVpFTRn+kFzGBKkqf0yQ4PV9CL8wJ+E8S0pYp2+RkniDaDLqK25rgK5tp
         WU9KpX6R2uC3VNywqLcNAzxG6eoeLerC7DMHYvwEvD7kj3Lyc5CH88ER0u++2K0CTE0B
         2ZsQpxaHZH8sGO3d4RK84Bm/1nJhBlTiWG0xZkuqGvR6R4AVXpXZy8a71NQQUH3vkz+o
         7VpI11AXKTJqeWFhS0+jgPD7jJMQg4Ba4va62HGLcgVWQzZjcGqPtZYCKzow4G3LsGPh
         1yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFwa3MRIeZXEwgXVflwLlvQa5g8vxfjhTc04/l3hJOg=;
        b=NkmJ1gjxaFcWc7jai0QoA/w+xt9p8TnBhvk4toMMjx/urvc6qnBglOq9GwPg4d1xbk
         awWDipL59LFYTwf9XmNnQdAbQNeaTGTkPVulGIarb0/yIFL5IgFwbFOCjAQILJEs9Sg0
         RKq4UYKt+QX+LZejOe0pgI39Sy1o4Xtj+Uay0HVFYnsZJ/HLBfX91m2sfhZwey3FrXa+
         dpaYvIoYCAvIWIw6fnSG1VIped0yggjeWvTyNrZFPJjZU+UhSkxiebE5O/sT0alD+kPT
         1+htjwWxSyPkiYTBSmTmNALxCwNDJYR+csAH8uqL+iV7q/CXTnrrvHlKRrNUxLoAao71
         ZgcA==
X-Gm-Message-State: AOAM531lA15nLegV1yNm8g5EN8nk0rDL4B8B19med0EUttlagA/7enDY
        yv8wrY2TnNnyDpXuC7qylX93/RbxQPv5ev5wF0U=
X-Google-Smtp-Source: ABdhPJydcpzXe//FFIfkVPUDwR/+huiZ5Ef1VRgLBE11JBoGJNgwctcCPzzT6ne9atYRNh8JtTqDw/tHr3I4+cXz618=
X-Received: by 2002:a5d:9910:: with SMTP id x16mr7832311iol.143.1590070314762;
 Thu, 21 May 2020 07:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
 <CAFqZXNsV8fUeA-tT4kMtmaNaDK6_LkqvftY-SF7+RUrSBkWUvA@mail.gmail.com>
 <CAEjxPJ7HwA_5E6vCrtRfKK=Lpppp-WEbBa_5cVJvzH7fLSGD_A@mail.gmail.com> <CAFqZXNuOTsPrE-0D7OD7jZ4ETWgwW4HCVywnooJs4Q4Qk3d5EQ@mail.gmail.com>
In-Reply-To: <CAFqZXNuOTsPrE-0D7OD7jZ4ETWgwW4HCVywnooJs4Q4Qk3d5EQ@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 21 May 2020 09:11:43 -0500
Message-ID: <CAFftDdqnrPr32GW71aRgXu8akvMAu3FG5L7B2fp4GzBs0=_Z9g@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 21, 2020 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, May 21, 2020 at 2:52 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Thu, May 21, 2020 at 4:51 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Wed, May 20, 2020 at 6:34 PM <bill.c.roberts@gmail.com> wrote:
> > > > From: William Roberts <william.c.roberts@intel.com>
> > > >
> > > > The current Travis CI runs the userspace tooling and libraries against
> > > > policy files, but cannot test against an SELinux enabled kernel. Thus,
> > > > some tests are not being done in the CI. Travis, unfortunately only
> > > > provides Ubuntu images, so in order to run against a modern distro with
> > > > SELinux in enforcing mode, we need to launch a KVM with something like
> > > > Fedora.
> > > >
> > > > This patch enables this support by launching a Fedora32 Cloud Image with
> > > > the SELinux userspace library passed on from the Travis clone, it then
> > > > builds and replaces the current SELinux bits on the Fedora32 image and
> > > > runs the SELinux testsuite.
> > > >
> > > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> > >
> > > From the text above I infer that this patch is intended against the
> > > userspace repo, right?
> > >
> > > If so, I don't quite see the usefulness of running the
> > > selinux-testsuite on every userspace change... It is mainly intended
> > > for testing the kernel and only a small part of its running time is
> > > spent on running (i.e. testing in a sense) the SELinux userspace
> > > programs. Not to mention that in your patch it runs with the userspace
> > > shipped in Fedora and not the version from the given commit...

Totally doable, and you just copy + edit those scripts to achieve
that. Currently we inject the travis repo
with patches, which is the selinux userspace, into the VM image with
virt-sysprep.
But if this was selinux-testsuite ci you would just virt-sysprep
inject it's repo.

> >
> > Last I looked, his script builds and installs the userspace code on
> > top of the Fedora libraries and programs (make LIBDIR=... install...)
> > and then runs the testsuite.  That was my suggestion.
>
> Ah, yes, I can see that line now. Sorry, somehow I missed it before.
>
> > While it is the
> > kernel testsuite, it exercises a lot of SELinux userspace
> > functionality that isn't tested by the userspace tests.
>
> OK, I suppose it's better than nothing...
>

Stephen pointed out the additional ways userspace gets tested, and
perhaps my title and description
of the patch could be better. But the main point is to increase the
test coverage
and perform the testing steps we expect are done before a release in
the CI. We should have
the testing coverage and the confidence to release userspace from master at any
point. We also have forward facing proof that tests are being executed
and we can make sure
nothing regresses.

My ultimate goal here, is to help make sure that if Petr gets hit by a
bus, releases will
move forward without worry and without any change in quality among the various
maintainers.

Additionally, we pick up some cross project testing and can find other
surprises.
