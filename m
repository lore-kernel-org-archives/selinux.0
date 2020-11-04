Return-Path: <SRS0=XO28=EK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F9DC388F9
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 07:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8DE20780
	for <selinux@archiver.kernel.org>; Wed,  4 Nov 2020 07:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FC9KviZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgKDHYf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Nov 2020 02:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726844AbgKDHYf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Nov 2020 02:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604474673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ugvi3gdLDaClpwJBcPOrzDAAufRI1LKABmIqC1POl74=;
        b=FC9KviZYwc9S5ERAS8To1lA2gOE8bR9Pv8k199vryUzfqaLgRpv3EWRzdE3uji1nHVJIMv
        HTuDu4wUkntr5ZEriVMfZpKgJi8QLh69Bovm8T+b1pVUvsP4htbeUJeWQYnkPfQgTY4Y6s
        Kf9M3timZMhkZ3njwGLufjicBqgc9DM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-iBt-QOFLMiCkpRYs6_L1Ng-1; Wed, 04 Nov 2020 02:24:30 -0500
X-MC-Unique: iBt-QOFLMiCkpRYs6_L1Ng-1
Received: by mail-lj1-f200.google.com with SMTP id r17so7988146lji.7
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2020 23:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugvi3gdLDaClpwJBcPOrzDAAufRI1LKABmIqC1POl74=;
        b=iaJnAXZpr0369xejyHAHLycB/7hsoqIfJSqlObP8m/ZLn+I7mTNvVdFRimDHneWNOq
         963P/tDbw259ApJP97sjSldHWspvBPFDZAAIyY0TxAqOcIJTL07JgjWckCN5L+FD6wuI
         4JWzn6r1JZpiGmGTUTtqLS9pSLQlhVtTDChKxqYHAP/t0sn6UG/h/y0uxcalic+3Qx85
         wMQZ7W6UqUi3gv5KXDk3gVcDU6Ev2Hh4KlJh7h+CgFdRwqZrIRBfMzkERkHhP9QfLBL/
         JZmajQeARcgfWyS1RcnKdfHVzz5I73UAhgkhoj2TnLWgUpYOvgDyLTqhPWpWEeVEVM4r
         1XUw==
X-Gm-Message-State: AOAM530nD/X/ZAlFL/qjfVZYtj5TBIhzH7H5ofOhkdMCWJwo3EUxB+RG
        rXZ/rDpwrJbsuqcEgd4DdsFDjfsvPsKlEBGz3Sgw2V04rvqB8oo6LglIaLX5oEoq69WqY2ght4C
        NblTK5oAIPH3d/+3wSXuDtC/O38lxuqQusQ==
X-Received: by 2002:a2e:b60e:: with SMTP id r14mr10429753ljn.77.1604474669145;
        Tue, 03 Nov 2020 23:24:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzK97DixDLecn2RPiqmT5GeKHaL1yluPbGFaIh/qaEXZbet8KPa8RdsyiWO8iRsXEQI3s7aTsR843xLYWJNEZQ=
X-Received: by 2002:a2e:b60e:: with SMTP id r14mr10429747ljn.77.1604474668970;
 Tue, 03 Nov 2020 23:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20201103110121.53919-1-richard_c_haines@btinternet.com> <20201103110121.53919-2-richard_c_haines@btinternet.com>
In-Reply-To: <20201103110121.53919-2-richard_c_haines@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 4 Nov 2020 08:24:18 +0100
Message-ID: <CAFqZXNtcZpr-cyvUP-Z65as+Gp0phVFX5v3WF+8spYZDhAix3Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Add btrfs support for
 filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 3, 2020 at 12:02 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> This allows btrfs filesystems to be created to support the
> filesystem mount(2) type calls and the fs_filesystem fsmount(2)
> type calls.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  README.md                      |  3 +++
>  defconfig                      |  4 ++++
>  tests/Makefile                 |  2 +-
>  tests/filesystem/Filesystem.pm | 10 +++++++++-
>  tests/filesystem/btrfs         |  1 +
>  tests/filesystem/test          |  6 ++++++
>  tests/fs_filesystem/btrfs      |  1 +
>  tests/fs_filesystem/test       |  6 ++++++
>  travis-ci/run-testsuite.sh     |  1 +
>  9 files changed, 32 insertions(+), 2 deletions(-)
>  create mode 120000 tests/filesystem/btrfs
>  create mode 120000 tests/fs_filesystem/btrfs

Thanks! The patch looks good to me and passes in CI (except the known
bug). However, I'm going to hold off on merging the patch until the
btrfs fsconfig issue is fixed (still working on that). If that doesn't
happen for a long time, I'll consider adding a condition for btrfs to
skip the failing part of the tests and merging it like that.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

