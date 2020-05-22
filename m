Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D50DC433E0
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 07:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3692207FB
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 07:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdHi1BCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgEVHkr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 03:40:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727839AbgEVHkr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 03:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590133245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6wgqtH/hpg0mXEQCg88KNo5SdWRZtiOXEMQ0f6I+JUs=;
        b=XdHi1BCK5z2pxixQj5GwdgTqzhHkRa0tisxhO8eLfy69r4RFTxqYtIM6h4vkj62xRsKCXb
        DHX4T+T2odHrcm4XKHpOLF58z1mCCHMvjvuDZSiXNTjfbtk5hUIYcIH9WwQfixF+P01sav
        uZbDfAYDk6cttaQgYJb0dN5QatGEatc=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-5ec3OvpHMLy-McAWMA5FeA-1; Fri, 22 May 2020 03:40:42 -0400
X-MC-Unique: 5ec3OvpHMLy-McAWMA5FeA-1
Received: by mail-oi1-f200.google.com with SMTP id m13so4708472oic.2
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 00:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6wgqtH/hpg0mXEQCg88KNo5SdWRZtiOXEMQ0f6I+JUs=;
        b=pJHUj0cAQ7Wvd3PyVgGZ2wXQOCWuZuY7Qk0WAxOEX8Dis41K4c2I5aIDYYKCdmogax
         fKSqD4RUj6VfedRrVd0u8Q/Q84UnVmAcVqVMXweCIiG1CHh2Vlt/gD98GK07dYc6fHCK
         8KTyrKioHpzt4BWnw8DXwOrxjy/rnZTv8y9ukNonvOKt1pof6OKO3CBFzIwBBNT29uPp
         QCcY61q8761jJmNQ/ndfZG7sRW7xKrFYErZBxWqbMVnWlyZsbatJP7h2l3uoJrUiL00h
         561JE3cvDs12fCg3HwBGK4oJVeNUTnrnwbvHGUXE+trDAt80hqyjBrx+Uecnlmz4cl9Y
         k+9g==
X-Gm-Message-State: AOAM531rUNRwSPUu2lAMoOQ8OGYEjyPhKhqckf0W1gZEpWERp/xxR04m
        X1LJ1/3FHAloyjxdhluuZnhvMBCK6KdfnSutlCxqI/r5Yx7QpOZNNuHrldeNQjOhduNYXyP0Ztm
        y0umuloYR/Z3ieQEZ+M4rkMummT+RG2KotA==
X-Received: by 2002:a4a:d043:: with SMTP id x3mr2014849oor.17.1590133241127;
        Fri, 22 May 2020 00:40:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4mlHdhjHTbpAawqg+Q6FeHqlAScxUMYZo2V0IAO+7SV6UECCw1eB5t8VB4dmi6BgJ6dyZmoBpy9i9huQyFJ0=
X-Received: by 2002:a4a:d043:: with SMTP id x3mr2014836oor.17.1590133240801;
 Fri, 22 May 2020 00:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTNZ=gcw5w3FFEs9KiuSrUBhbYLVc=sZq0N4ZEGCem1Zg@mail.gmail.com>
 <20200520163421.27965-1-william.c.roberts@intel.com> <20200520163421.27965-2-william.c.roberts@intel.com>
 <CAFqZXNsV8fUeA-tT4kMtmaNaDK6_LkqvftY-SF7+RUrSBkWUvA@mail.gmail.com>
 <CAEjxPJ7HwA_5E6vCrtRfKK=Lpppp-WEbBa_5cVJvzH7fLSGD_A@mail.gmail.com>
 <CAFqZXNuOTsPrE-0D7OD7jZ4ETWgwW4HCVywnooJs4Q4Qk3d5EQ@mail.gmail.com> <CAFftDdqnrPr32GW71aRgXu8akvMAu3FG5L7B2fp4GzBs0=_Z9g@mail.gmail.com>
In-Reply-To: <CAFftDdqnrPr32GW71aRgXu8akvMAu3FG5L7B2fp4GzBs0=_Z9g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 22 May 2020 09:40:29 +0200
Message-ID: <CAFqZXNvc-J0=wpFnNzCxiq80e-hY=5Tubu84-KkPm5nAfgaYRQ@mail.gmail.com>
Subject: Re: [PATCH v2] ci: run SELinux kernel test suite
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 21, 2020 at 4:12 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Thu, May 21, 2020 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, May 21, 2020 at 2:52 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
[...]
> > > Last I looked, his script builds and installs the userspace code on
> > > top of the Fedora libraries and programs (make LIBDIR=... install...)
> > > and then runs the testsuite.  That was my suggestion.
> >
> > Ah, yes, I can see that line now. Sorry, somehow I missed it before.
> >
> > > While it is the
> > > kernel testsuite, it exercises a lot of SELinux userspace
> > > functionality that isn't tested by the userspace tests.
> >
> > OK, I suppose it's better than nothing...
> >
>
> Stephen pointed out the additional ways userspace gets tested, and
> perhaps my title and description
> of the patch could be better. But the main point is to increase the
> test coverage
> and perform the testing steps we expect are done before a release in
> the CI. We should have
> the testing coverage and the confidence to release userspace from master at any
> point. We also have forward facing proof that tests are being executed
> and we can make sure
> nothing regresses.
>
> My ultimate goal here, is to help make sure that if Petr gets hit by a
> bus, releases will
> move forward without worry and without any change in quality among the various
> maintainers.
>
> Additionally, we pick up some cross project testing and can find other
> surprises.

Ah, so you want to move an integration test, which we would normally
run only before release, down to per-commit testing, which is fine
because it is quite fast... OK, it started to make sense to me now :)

If I find time I'll have a closer look at the scripts. I already see
some tiny possible improvements...

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

