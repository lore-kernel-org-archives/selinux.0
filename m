Return-Path: <SRS0=XIqT=26=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF4FC282DD
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 21:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659EF20721
	for <selinux@archiver.kernel.org>; Thu,  9 Jan 2020 21:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MnbLpuwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgAIVCB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:02:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37422 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbgAIVCB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jan 2020 16:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578603720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KL07aBdFhh5UpzQPBeQnCJEf31bMaOh1gT3A23FESJ0=;
        b=MnbLpuwM+bREEPQ46bPSN8ufVYqumrjXlQKntpTLzgQdPS9bzp8/xFVP9mQzGC+O9pdbHj
        tI8bPEiwWMj6j5zPxUIR4o6BC18w88CLizQYMvoBbJMMh1unVAmfpWBcaKmHARw1/XoXSp
        7CIDLz4kG55Zwhyw/2Z04N5+fWptK4M=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-64aXxF7sMkmQEhB9tdHoHA-1; Thu, 09 Jan 2020 16:01:59 -0500
X-MC-Unique: 64aXxF7sMkmQEhB9tdHoHA-1
Received: by mail-ot1-f71.google.com with SMTP id v14so4419064otf.12
        for <selinux@vger.kernel.org>; Thu, 09 Jan 2020 13:01:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KL07aBdFhh5UpzQPBeQnCJEf31bMaOh1gT3A23FESJ0=;
        b=kxP1aoUDGN0ZN12KrlYEmgAZ6fxiNBsTSpEQgAlo53j+4cuQGLzNWSUiNAQEslBDxo
         t1IGxXpTebOHGuTXzG4AqPJH654Aj2UGEjFpWbOvCufa3fWcre7+hh8LOX2+6BSalMwx
         5oq6IEDMbNatRtjClIfWgJJPm+tvpdZqbzi66XATAUxwaGJXGDhfvfoGY/3346FtdKE0
         huHysW0QxgtnOLFuLqbaDMu1pQXFB8mXy3NuegAvSZAaBxNc58DIJfNFvyo57ykH3iFo
         20+b1REHHR3PiIFeP66VzPGbmUNuli893oLTdsbtq4imFYfIjaFNqvh9iVjD6wJkfQbr
         CxJQ==
X-Gm-Message-State: APjAAAUMQUJAHJRQv6ek+jXxMaY2EndHdZgp6ulIHgg7jWhAJQimso+h
        9IbgptMAXqzJTbDQsP/D/gRcPSYF2U7vo8w8Iccuiv+OTXtj+oSi3tKFZ6PLTjYCY5q15UKJV41
        v5oVVSW57CP7M/OIsfvGPCCbIiH6LzDgl4Q==
X-Received: by 2002:a9d:65da:: with SMTP id z26mr10134179oth.197.1578603718683;
        Thu, 09 Jan 2020 13:01:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqycLp/8MOoPjjSCRrvXL6QLma88iVZobww8Vupxq7mGW3b+AUjXGEKyx06f6tumJl5G6kkpBrXMH4ojELnqsGw=
X-Received: by 2002:a9d:65da:: with SMTP id z26mr10134148oth.197.1578603718349;
 Thu, 09 Jan 2020 13:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20200109150709.360345-1-richard_c_haines@btinternet.com>
 <7281d970-cd5d-aee9-c790-fbf5951273d6@tycho.nsa.gov> <4eefc9594eec6010c8427a3308e5e3c3fdabbf3b.camel@btinternet.com>
In-Reply-To: <4eefc9594eec6010c8427a3308e5e3c3fdabbf3b.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 9 Jan 2020 22:01:47 +0100
Message-ID: <CAFqZXNvKgGfbcmaMExG6HK=nmeS22VCSumjAZMqSaNzxC+0Qfg@mail.gmail.com>
Subject: Re: [PATCH V2 0/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 9, 2020 at 9:36 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Thu, 2020-01-09 at 13:04 -0500, Stephen Smalley wrote:
> > On 1/9/20 10:07 AM, Richard Haines wrote:
> > > These tests should cover all the areas in selinux/hooks.c that
> > > touch
> > > the 'filesystem' class. Each hooks.c function is listed in the
> > > 'test'
> > > script as there are some permissions that are checked in multiple
> > > places.
> > >
> > > Tested on Fedora 31 and Rawhide (5.5 for the new watch perm).
> > >
> > > V2 Changes:
> > > 1) If udisks(8) daemon is running, stop then restart after tests.
> > > The tests
> > >     run faster and stops the annoying habit of adding mounts to the
> > > 'files'
> > >     app on the desktop. Supports /usr/bin/systemctl or
> > > /usr/sbin/service
> > >     More importantly it stops interferance with the '*context='
> > > tests as it
> > >     can cause intermittent failures. Tested by running 'test' in a
> > > continuous
> > >     loop with udisks enabled, and then again disabled.
> > >     Loop 200 times, with udisks failed between 1 to 70 iterations,
> > > without
> > >     udisks, no failures.
> >
> > Wondering why udisks is causing failures - that seems like another
> > bug.
>
> With udisk2 enabled, 99% of the time the 'rootcontext=' test fails (the
> 1% is 'defcontext='). However if I run this test on its own, it does
> not fail. If I add the 'context=' test before and run, the
> 'rootcontext=' will fail at some point.
>
> If I add a short delay as shown in the 'context=' sequence, the fault
> does not occur:
> -- Start --
> system("losetup -d $dev 2>/dev/null");
> system("sleep 0.01");
> get_loop_dev();
> attach_dev();

Can you try putting `udevadm settle` instead of the sleep there? I
remember having some issues with udev race conditions a long time ago
and I think that helped. (But I'm not sure at all if that's the right
fix...)

>
> # Mount again with no xttr support
> $context2_opts =
> "context=system_u:object_r:test_filesystem_context_t:s0";
> -- End --
>
> It could be udisk2 has a timing problem as the losetup(8) man page '-d'
> entry reads:
> Note that since Linux v3.7 kernel uses "lazy  device destruction". The
> detach operation does not return EBUSY error anymore if device is
> actively used by system, but it  is  marked by autoclear flag and
> destroyed later.
>
> But then again it could be something else !!!!
>
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

