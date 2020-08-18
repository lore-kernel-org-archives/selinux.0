Return-Path: <SRS0=if39=B4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AABCC433DF
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 02:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62491206DA
	for <selinux@archiver.kernel.org>; Tue, 18 Aug 2020 02:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="HZ938OYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHRCZF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 22:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHRCZD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Aug 2020 22:25:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3B3C061389
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 19:25:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f24so20214011ejx.6
        for <selinux@vger.kernel.org>; Mon, 17 Aug 2020 19:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEg6bv0hzxDsUrgH/YFAkVPv2q0Fp7vfZjUHlbjrj+s=;
        b=HZ938OYxokf+xacGkHNx6b0uIdz3hx0PHoBNKDyFnVAgxvJTzFKlK3/ebSv9UhXD0R
         bUxyfccSfqYjE3WivVubl1NYZgYcLos7nJS4zey4wRv9D1jLaSxJ+Z99rM+tspEQS7yj
         r2q6aFSETwFvlPETzxccVa2Zon/mT10XavHkLEZI6ng6VLn8z8XW1h0vkDScAzjIQBsi
         TeunZH6ecX2BYNNAvbR4Sr8cy5iq5yPPctCyQF14cx0uFkl4gmAWcettwbdiEMwL1O2K
         VDynzqQ4Z+W4BPU7F3OMMyc1OULZL2yZn9Y+23cuIEIREz/mU8eaWrO8uvRQaftT2lJ8
         0I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEg6bv0hzxDsUrgH/YFAkVPv2q0Fp7vfZjUHlbjrj+s=;
        b=X4I/M3tf9QVZu/4Jwtvfzu5Vjo/cxmvbS1bLgniYEAsdGNxK0TiEnQFhuHC5FtBP6h
         YtvoWzjeggpYGiYAhSshMLsjEwHC/LGVZsicqCBVFkSqG6mU64fUQth1X7V4nVDJi9wL
         Zb4PO3aXqW+yrNWCZbKBMUK9+lfxLDsxM04hX5bKQMXvXS9H8v0WHQ57U0YGGIchkstA
         FnvJn+ovpsMaTCRIyMdvLt8ienf5z4ZfkKmSBvWB+L1K3MqYZwfYvjX1JXNww4xzC/hy
         Xc1UdqaK25+5Tyq3t9gmToQYcpCAIV+PYmuLztj8nJIiK6nCnFv2K+V13MlY/+Bkr+so
         3H2w==
X-Gm-Message-State: AOAM532htR9ALg1qycITiMg05POfYtBLGTBjYMDI9Nt5IyBNVjbtANNU
        95WEmZ6Sbw6nkGG5IRxjupFohQGClz9tYZI7s152
X-Google-Smtp-Source: ABdhPJwOV+IHE2Gk8U2m54uBgA5/548J6SaCUpxDBGPd5dyoWC4GJREk7cSMFSuVVAhlX6S5GOvikVjbnuTcA4o8oj4=
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr17742055ejb.91.1597717501759;
 Mon, 17 Aug 2020 19:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6b0MM-04XwcE58N-BiOBBi2g-1AZovoBmPGgcfU_wZiQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6b0MM-04XwcE58N-BiOBBi2g-1AZovoBmPGgcfU_wZiQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Aug 2020 22:24:50 -0400
Message-ID: <CAHC9VhQurFFNfjx22RxKp-QG_GJ6VDZy3yEOWwWY++wfn+2C9Q@mail.gmail.com>
Subject: Re: potential memory leak in netlbl_mgmt_add_common
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 13, 2020 at 12:32 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> I noticed this in /sys/kernel/debug/kmemleak while testing other
> patches.  This is on 5.8.0-rc1 but may be older.
>
> unreferenced object 0xffff888158b40380 (size 32):
>   comm "netlabelctl", pid 2982, jiffies 4295212079 (age 3234.561s)
>   hex dump (first 32 bytes):
>     80 03 b4 58 81 88 ff ff 80 03 b4 58 81 88 ff ff  ...X.......X....
>     90 03 b4 58 81 88 ff ff 90 03 b4 58 81 88 ff ff  ...X.......X....
>   backtrace:
>     [<000000009fe161a4>] netlbl_mgmt_add_common+0x2df/0x9b0
>     [<00000000816cc1d9>] netlbl_mgmt_adddef+0x133/0x190
>     [<00000000f060e456>] genl_rcv_msg+0x2dd/0x490
>     [<000000001c733400>] netlink_rcv_skb+0xd0/0x200
>     [<00000000c42f6f58>] genl_rcv+0x24/0x40
>     [<000000005421c040>] netlink_unicast+0x2b4/0x3e0
>     [<00000000ab107bba>] netlink_sendmsg+0x3a6/0x660
>     [<00000000643024bd>] sock_sendmsg+0x96/0xa0
>     [<00000000ba78e5a6>] ____sys_sendmsg+0x404/0x440
>     [<000000006f3de0f5>] ___sys_sendmsg+0xd8/0x140
>     [<000000009b8c70ea>] __sys_sendmsg+0xa3/0x110
>     [<00000000e65194c3>] do_syscall_64+0x52/0xb0
>     [<00000000367aebc6>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Hmmm, that's interesting, a quick look at the code doesn't reveal
anything obvious and it looks like I don't currently have kmemleak
enabled in my kernel so I'll need to rebuild ... you wouldn't happen
to have line numbers for the backtrace above would you?  Anything
special you did to reproduce this?

-- 
paul moore
www.paul-moore.com
