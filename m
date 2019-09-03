Return-Path: <SRS0=4h59=W6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0034C3A5A7
	for <selinux@archiver.kernel.org>; Tue,  3 Sep 2019 10:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81572217D7
	for <selinux@archiver.kernel.org>; Tue,  3 Sep 2019 10:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfICK5K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:57:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31059 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbfICK5J (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 3 Sep 2019 06:57:09 -0400
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 08FA1C049E36
        for <selinux@vger.kernel.org>; Tue,  3 Sep 2019 10:57:09 +0000 (UTC)
Received: by mail-oi1-f200.google.com with SMTP id g204so5843293oif.14
        for <selinux@vger.kernel.org>; Tue, 03 Sep 2019 03:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5SHp11wOV3pOSOyl3f8F3SY0ucEH46MEmxrh7KbeplM=;
        b=XsNllrexdu5Ij2rtKvcMk9kvwOCbtQK2HTUHlilQAu9K3OshVaQmLrQ8yu6X+Ba+em
         fX2/H/ycIjPxA13R4bxFBwLi5I0msAtpE5YtXF3cJdNWTmISv2QJx3gRLow0mrg7Rj7U
         uqoWddHHJsFRh0H8ZcTFAZ4JcxR80pSDSU+AwG+s8py4H/WXpFLp2fGyLYuWT19DquKL
         Pe1L4xCUz3G/eG3FktpPCbzD6dnPlE2xR5OO/sjLZxzJPLs/4RJffOlhEqvXL7fpD2jx
         yZp6Nh/sN9yV1sg5+Pvwh2B0yAFoFZHXMQ80InvxDrXU+/yffsZv+t1cojGcbyHuDbaZ
         COWQ==
X-Gm-Message-State: APjAAAVDsXzdBO7s2EdbwcBXQGjsoLosPG+Ta8TAC1fTh7SPO31lHxrA
        vac2TiHlFIHzQ3rFAfzgsKNVM55pmXe2AqIaxz1uZrgRaN8/x+MdPdhgpd1QoRLfOvNO3mQdVvP
        4DOlj0KMDM7haiI4xBpQOJ3aw1lEdOQOjJw==
X-Received: by 2002:a05:6830:13d9:: with SMTP id e25mr16068189otq.197.1567508228543;
        Tue, 03 Sep 2019 03:57:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxuTdCVHhYd1chR/ytGPClkobDKUuD3w3ECT2jZIK58xBo/XwzpeChL2pWRFOrVQSupmecqKB5ut5+E6cMc8k4=
X-Received: by 2002:a05:6830:13d9:: with SMTP id e25mr16068173otq.197.1567508228277;
 Tue, 03 Sep 2019 03:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190801140243.24080-1-omosnace@redhat.com> <20190801160910.GW1131@ZenIV.linux.org.uk>
 <CAFqZXNs5igF_G8=EA+bD-JRorS6xeuCiXQr5vweaJFYNwEVKZA@mail.gmail.com>
In-Reply-To: <CAFqZXNs5igF_G8=EA+bD-JRorS6xeuCiXQr5vweaJFYNwEVKZA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 3 Sep 2019 12:56:57 +0200
Message-ID: <CAFqZXNtprcuqgPhN63dHvoA8guj3x4hJ8Jp9qhUu_hXBUFp_YA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] selinux: fix race when removing selinuxfs entries
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 8, 2019 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Aug 1, 2019 at 6:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Thu, Aug 01, 2019 at 04:02:39PM +0200, Ondrej Mosnacek wrote:
> > > After hours and hours of getting familiar with dcache and debugging,
> > > I think I finally found a solution that works and hopefully stands a
> > > chance of being committed.
> > >
> > > The series still doesn't address the lack of atomicity of the policy
> > > reload transition, but this is part of a wider problem and can be
> > > resolved later. Let's fix at least the userspace-triggered lockup
> > > first.
> >
> > I don't think this is the right approach.  Consider the related problem:
> > what happens if somebody has mounted something upon a selinuxfs file?
> > That is the hard part here, and AFAICS your variant doesn't help it
> > at all...
>
> But that's another independent problem and it's not even fixed in
> debugfs, which for now I'm treating as the baseline as I don't know of
> any other filesystem that needs to remove its own directory trees in a
> similar way.
>
> I get that you don't want me to add a new function to the dcache API
> that isn't bulletproof (and what I wrote here is apparently still far
> from it), but you also previously said that I shouldn't open-code this
> stuff in selinuxfs.c... I don't think I have the wits to write a
> common function that handles all the possible issues, but I still want
> to fix at least this one scenario (dcache_readdir() vs.
> sel_remove_entries()).
>
> Is there some way I could do this without getting a NACK from you? For
> example, I thought of taking what is now debugfs_remove[_recursive]()
> out of debugfs into, say, fs/libfs.c (providing some optional callback
> to allow debugfs to do its __debugfs_file_removed() business) and use
> this function(s) from both debugfs and selinuxfs. This way we could
> later fix the leftover mount issue in one place and both filesystems
> would (hopefully) immediately benefit from it. Would that be a
> feasible way forward?

Ping?

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
