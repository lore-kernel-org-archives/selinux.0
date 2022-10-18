Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2435CC433FE
	for <selinux@archiver.kernel.org>; Tue, 18 Oct 2022 19:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiJRT6b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJRT6a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Oct 2022 15:58:30 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DE84F3B2
        for <selinux@vger.kernel.org>; Tue, 18 Oct 2022 12:58:29 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-35711e5a5ceso147499497b3.13
        for <selinux@vger.kernel.org>; Tue, 18 Oct 2022 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iBrqEpawYJv3cxsK3xzwh5t6DQof6LrcEZ82/gem1SQ=;
        b=NLnv10UaB3PWFt+iFwWkj1mNN0NFm/JQVrn+Ad0dy12NXLJlJOZ4S1d+9mXPyfwuBA
         RTFzFM6QlMdHodZBkp7EVOr8+D9w2QT6SRYX7PPH56siMvJRW8e7E1TGx0RwpTyMyNAG
         n5NIVfHqK7jGPBZ0X6432v2OS0y+mFlAj+5QQgFTkHA0mF81/y6ZBCXp8vjdKmyXzfeK
         FlT5UglceuBNvOIeq6WHCS38PC1ET6Le+t2cbO1J3OgL8CuSLsuTv4kCN/Lb9Sdedu/L
         iEfpVOu5zcDn6dtciWTd5EDrORr9TLia38YY57EsZW46jJ0/7NNbJwBrq0bfwWeNxvWy
         5QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBrqEpawYJv3cxsK3xzwh5t6DQof6LrcEZ82/gem1SQ=;
        b=UTiGreeWvfxY7LnYg8SDWKE09iuY6S9WWE22uKDKgMVSNQL0booE0bBsm/xIMtOQFh
         jM+hoJXodLZxl26CjsDtoKZloqJOlsQD5hBdH9LzkWNPnW4JKW3GPOu2XxpC5ypf2Je0
         zHmyUZnMtVK2CGdVZIrBF4UbKvW2uqW0s4kWnKEJyjWbvaMiRNI+yrhw/dpLDmVx1Ij0
         cSdfnxFdyitsgo5qlc6gBPlSxk+b1FHppFDIXMggaljVqdLqNqSiJjJCxD6fTjSBBsU+
         MkIvLCPTlYjbAmNIUEdj8RUyZy0T3w+cfZP8CuBdXa5tmBOeLHtgW5GAa16JyOMYE+WN
         d+ew==
X-Gm-Message-State: ACrzQf2H0sqo55i5wbbfLUjAetmJ3EO9PMEM96+7pab8NNyCLuyUhHD9
        algcQphergLl0XdWNm6Qa04w9VClhBuOP4MHDO+6+/WjRg==
X-Google-Smtp-Source: AMsMyM6MPcb99poZMf7Gb2NCFplRXXlrEI0c+GJWHuTI1LFw7eTqaz0G8HUXlqQ4XNOTewrH5SBKuNhgp+dyL/AnzWU=
X-Received: by 2002:a0d:e64f:0:b0:357:815d:614 with SMTP id
 p76-20020a0de64f000000b00357815d0614mr3951352ywe.276.1666123108866; Tue, 18
 Oct 2022 12:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221018120111.1474581-1-gongruiqi1@huawei.com> <CAFqZXNsxx+uaox5xqKYHsrj-aVzQk6WVWDgd1L7V9goQWgMTFw@mail.gmail.com>
In-Reply-To: <CAFqZXNsxx+uaox5xqKYHsrj-aVzQk6WVWDgd1L7V9goQWgMTFw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Oct 2022 15:58:17 -0400
Message-ID: <CAHC9VhQsCRknn8VQN57q+Op6ijV1osgb9bZG5v96gyyCYusV2w@mail.gmail.com>
Subject: Re: [PATCH] selinux: use GFP_ATOMIC in convert_context()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 18, 2022 at 8:46 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Oct 18, 2022 at 2:01 PM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
> > The following BUG_ON was triggered on a hardware environment:
> >
> >   SELinux: Converting 162 SID table entries...
> >   BUG: sleeping function called from invalid context at __might_sleep_rtos+0x60/0x74 0x0
> >   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 5943, name: tar
> >   CPU: 7 PID: 5943 Comm: tar Tainted: P O 5.10.0 #1
> >   Call trace:
> >    dump_backtrace+0x0/0x1c8
> >    show_stack+0x18/0x28
> >    dump_stack+0xe8/0x15c
> >    ___might_sleep_rtos+0x168/0x17c
> >    __might_sleep_rtos+0x60/0x74
> >    __kmalloc_track_caller+0xa0/0x7dc
> >    kstrdup+0x54/0xac
> >    convert_context+0x48/0x2e4
> >    sidtab_context_to_sid+0x1c4/0x36c
> >    security_context_to_sid_core+0x168/0x238
> >    security_context_to_sid_default+0x14/0x24
> >    inode_doinit_use_xattr+0x164/0x1e4
> >    inode_doinit_with_dentry+0x1c0/0x488
> >    selinux_d_instantiate+0x20/0x34
> >    security_d_instantiate+0x70/0xbc
> >    d_splice_alias+0x4c/0x3c0
> >    ext4_lookup+0x1d8/0x200 [ext4]
> >    __lookup_slow+0x12c/0x1e4
> >    walk_component+0x100/0x200
> >    path_lookupat+0x88/0x118
> >    filename_lookup+0x98/0x130
> >    user_path_at_empty+0x48/0x60
> >    vfs_statx+0x84/0x140
> >    vfs_fstatat+0x20/0x30
> >    __se_sys_newfstatat+0x30/0x74
> >    __arm64_sys_newfstatat+0x1c/0x2c
> >    el0_svc_common.constprop.0+0x100/0x184
> >    do_el0_svc+0x1c/0x2c
> >    el0_svc+0x20/0x34
> >    el0_sync_handler+0x80/0x17c
> >    el0_sync+0x13c/0x140
> >   SELinux: Context system_u:object_r:pssp_rsyslog_log_t:s0:c0 is not valid (left unmapped).
> >
> > It was found that convert_context() (hooked by convert->func) might
> > sleep in a critial section of spin_lock_irqsave in
> > sidtab_context_to_sid(). Fix this problem by changing the memory
> > allocation in convert_context() from GFP_KERNEL to GFP_ATOMIC.
>
> Good catch! However, convert_context() (and
> sidtab_convert_params::func) has two callers:
> 1. sidtab_context_to_sid(), which requires GFP_ATOMIC,
> 2. sidtab_convert_tree()/sidtab_convert(), where GFP_KERNEL would be okay.
>
> So a more optimal fix would be to add a gfp_t argument to
> convert_context()/sidtab_convert_params::func and pass
> GFP_KERNEL/_ATOMIC as appropriate in the individual callers.

Agreed.  Please make the changes Ondrej is suggesting.

-- 
paul-moore.com
