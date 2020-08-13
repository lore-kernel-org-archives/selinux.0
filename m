Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A37C433E1
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 20:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCD5120774
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 20:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="v+Ik206z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMUCN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 16:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHMUCN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 16:02:13 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358BAC061757
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2020 13:02:13 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id x7so3232624qvi.5
        for <selinux@vger.kernel.org>; Thu, 13 Aug 2020 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:date:message-id:in-reply-to:references:user-agent:subject
         :mime-version:content-transfer-encoding;
        bh=QIoPJZdR5+4QaH+f20EpkMcURmfhum0M8LtTVL2hMm4=;
        b=v+Ik206z03dIxpQnhrq5XIBEolCGQ9ittilFceWzW2GGkqHbssECHFlPqs1ngdpJmr
         GD7wDMo2Jqsv0sM3R52kQPi0XkGAbrUoXJPDsM+pDWifNkLMICcEq9bxIsvb65Zlux1m
         f/P8OKEou4f5NneWOZauqNU1eNj5W0+SFavcewSTafdj2f7VGTNaZtwdIhd6nOkQ9ozI
         Bv8djOvF1tFi/m2RLYRWlUctkGgnbROnTpq3okkrAHj+tgTjnHLKPgto0F+y83YOowHx
         j/cTld3pneoE2g68EnQ/jnE1uXSy88ttuHYPQLdnzaKoGxSvAyVaWpkPH0xBODvLxHag
         sejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:date:message-id:in-reply-to:references
         :user-agent:subject:mime-version:content-transfer-encoding;
        bh=QIoPJZdR5+4QaH+f20EpkMcURmfhum0M8LtTVL2hMm4=;
        b=b+yJPJDw+dxmn4DUkUHNYde8MTe/mglacKu+QEAuRwWaLTdFkP8IZ8hX/w9/ld+uP1
         RYgR+SbsL0tXLVz4jNJfZW83SHfdVgOta0yyXSZE1f2MV3xjGXgCxM1djqglASDpvBa0
         IEX6cBvHRDBsl3aHRcSWsbsqHuYrG9Ze7mwEQq9XIjst1abgFdKG9sdDHo8tnzoIi/vl
         P185Z9yX5p1bQG9kKfpwIpV56wuFgw773kY8ACZC6IJIVjzITzny+vjtol8x/pcxCuyX
         tKhB0fxRcPTSjfud984w7wY/mHAY3byUPx6fJmQggViKNh57qL5IVY39+zvrVqtHIEJe
         BBiw==
X-Gm-Message-State: AOAM533rg37GAI2dE2qBEnptE89r5FLMErJoFMOpVgRMkeZ6tEaQRICO
        Oea1ERpMQ+KUBuSx86YeElQI
X-Google-Smtp-Source: ABdhPJzJ2nBlU0jjgDjLt/hxoU2BHl7mT/2chbnddvQ4Gp2UqA2Rz265ArygvXAcpf3at0JlZYQ5cw==
X-Received: by 2002:a05:6214:10e8:: with SMTP id q8mr6014245qvt.59.1597348931145;
        Thu, 13 Aug 2020 13:02:11 -0700 (PDT)
Received: from [10.0.0.46] (c-24-91-201-67.hsd1.ma.comcast.net. [24.91.201.67])
        by smtp.gmail.com with ESMTPSA id o2sm6352363qkh.102.2020.08.13.13.02.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Aug 2020 13:02:10 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Date:   Thu, 13 Aug 2020 16:02:09 -0400
Message-ID: <173e96a5de8.27df.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAEjxPJ6b0MM-04XwcE58N-BiOBBi2g-1AZovoBmPGgcfU_wZiQ@mail.gmail.com>
References: <CAEjxPJ6b0MM-04XwcE58N-BiOBBi2g-1AZovoBmPGgcfU_wZiQ@mail.gmail.com>
User-Agent: AquaMail/1.25.2-1672 (build: 102500008)
Subject: Re: potential memory leak in netlbl_mgmt_add_common
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I have limited network access at the moment, if no one looks into it this w=
eek I'll take a look next week.

--
paul moore
www.paul-moore.com
On August 13, 2020 12:32:00 PM Stephen Smalley <stephen.smalley.work@gmail.=
com> wrote:

> I noticed this in /sys/kernel/debug/kmemleak while testing other
> patches.  This is on 5.8.0-rc1 but may be older.
>
> unreferenced object 0xffff888158b40380 (size 32):
>  comm "netlabelctl", pid 2982, jiffies 4295212079 (age 3234.561s)
>  hex dump (first 32 bytes):
>    80 03 b4 58 81 88 ff ff 80 03 b4 58 81 88 ff ff  ...X.......X....
>    90 03 b4 58 81 88 ff ff 90 03 b4 58 81 88 ff ff  ...X.......X....
>  backtrace:
>    [<000000009fe161a4>] netlbl_mgmt_add_common+0x2df/0x9b0
>    [<00000000816cc1d9>] netlbl_mgmt_adddef+0x133/0x190
>    [<00000000f060e456>] genl_rcv_msg+0x2dd/0x490
>    [<000000001c733400>] netlink_rcv_skb+0xd0/0x200
>    [<00000000c42f6f58>] genl_rcv+0x24/0x40
>    [<000000005421c040>] netlink_unicast+0x2b4/0x3e0
>    [<00000000ab107bba>] netlink_sendmsg+0x3a6/0x660
>    [<00000000643024bd>] sock_sendmsg+0x96/0xa0
>    [<00000000ba78e5a6>] ____sys_sendmsg+0x404/0x440
>    [<000000006f3de0f5>] ___sys_sendmsg+0xd8/0x140
>    [<000000009b8c70ea>] __sys_sendmsg+0xa3/0x110
>    [<00000000e65194c3>] do_syscall_64+0x52/0xb0
>    [<00000000367aebc6>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



