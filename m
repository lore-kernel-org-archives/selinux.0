Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BE2C433FE
	for <selinux@archiver.kernel.org>; Tue, 18 Oct 2022 12:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJRMqz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Oct 2022 08:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiJRMqx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Oct 2022 08:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFDD6CF46
        for <selinux@vger.kernel.org>; Tue, 18 Oct 2022 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666097210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CuBI5jLXo20BMX4c1C2xj9LK3s8zFkpfyu8fI4Qlt+g=;
        b=MmoIfI5dUkRcv5j8Q58pYpGCrn6qw1yrBc2+ItZ28IXd8eB5h3Bmn12nfcZ6n4IakTEBcG
        oMyPjaxnVnwSoZeYH64cFRJFR67RK33AM1ObwUBmf3pa0MajrYZTUcWnWUEOpJOC0vAPnZ
        JaEotbz1oU9XN7vseHAiBIKkjg5aFzk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-474-dAy5MTKfN52tbd4WGs6xfA-1; Tue, 18 Oct 2022 08:46:49 -0400
X-MC-Unique: dAy5MTKfN52tbd4WGs6xfA-1
Received: by mail-pl1-f199.google.com with SMTP id s13-20020a170902ea0d00b00183243c7a0fso9636644plg.3
        for <selinux@vger.kernel.org>; Tue, 18 Oct 2022 05:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuBI5jLXo20BMX4c1C2xj9LK3s8zFkpfyu8fI4Qlt+g=;
        b=TWLhL6OkAOJPV2ThTpXCglPXFozKGufC6K5HvFc13mD/lYKODAkhE5p/WBeN3BikdQ
         McOyr3ci5E3/DZdq4EDRuZZf9u1Sl3nf3WHspKTI/j+b0dfArSrYfcvDnK0pR7j+K0fT
         KKq30bZSys2IziZt70DHciL1N6JwuYKkFFMkOG+bB8hzCMZS5SHLq9+Nm/jb5IyEeBc+
         h6RRWj5DbO/27a8hHAx0UUMMvINrig41B/Yz64lAuZ8BTvGYQkfZGFiEdbYs8/mf6SlE
         NWJxVDNSxBBvAhYzgOXwvYKJnjH+G/JkHceN8gHKYb36b2gUrEqOml4pDFa2JF5CI7rJ
         5jxw==
X-Gm-Message-State: ACrzQf1ppvBMlio7URFZAs3b9IViJfrxt7y3XmG4xgGHbbFGvchsq35V
        pK+GjuHRssvflogZOY8QeNm1RxddcAUGXMbh3nKBq60OtykDlcw8Q5kQlSRWlnw9HoQi8EP5GoC
        1fFKEsMz28OS+ussqfndFeZDlpyiGeFGQ2g==
X-Received: by 2002:a17:90a:fd01:b0:20b:61f:cd49 with SMTP id cv1-20020a17090afd0100b0020b061fcd49mr3448140pjb.239.1666097207765;
        Tue, 18 Oct 2022 05:46:47 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7l3/pf39PuDQ5Q3AtihDHFzSsBBG2eM7CD6Ra3Ot/BCteOGwQn8wh7EvEmJI7vGSoIvyYbCBGI8uY2s+xtsJY=
X-Received: by 2002:a17:90a:fd01:b0:20b:61f:cd49 with SMTP id
 cv1-20020a17090afd0100b0020b061fcd49mr3448119pjb.239.1666097207517; Tue, 18
 Oct 2022 05:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20221018120111.1474581-1-gongruiqi1@huawei.com>
In-Reply-To: <20221018120111.1474581-1-gongruiqi1@huawei.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 18 Oct 2022 14:46:34 +0200
Message-ID: <CAFqZXNsxx+uaox5xqKYHsrj-aVzQk6WVWDgd1L7V9goQWgMTFw@mail.gmail.com>
Subject: Re: [PATCH] selinux: use GFP_ATOMIC in convert_context()
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 18, 2022 at 2:01 PM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
> The following BUG_ON was triggered on a hardware environment:
>
>   SELinux: Converting 162 SID table entries...
>   BUG: sleeping function called from invalid context at __might_sleep_rtos+0x60/0x74 0x0
>   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 5943, name: tar
>   CPU: 7 PID: 5943 Comm: tar Tainted: P O 5.10.0 #1
>   Call trace:
>    dump_backtrace+0x0/0x1c8
>    show_stack+0x18/0x28
>    dump_stack+0xe8/0x15c
>    ___might_sleep_rtos+0x168/0x17c
>    __might_sleep_rtos+0x60/0x74
>    __kmalloc_track_caller+0xa0/0x7dc
>    kstrdup+0x54/0xac
>    convert_context+0x48/0x2e4
>    sidtab_context_to_sid+0x1c4/0x36c
>    security_context_to_sid_core+0x168/0x238
>    security_context_to_sid_default+0x14/0x24
>    inode_doinit_use_xattr+0x164/0x1e4
>    inode_doinit_with_dentry+0x1c0/0x488
>    selinux_d_instantiate+0x20/0x34
>    security_d_instantiate+0x70/0xbc
>    d_splice_alias+0x4c/0x3c0
>    ext4_lookup+0x1d8/0x200 [ext4]
>    __lookup_slow+0x12c/0x1e4
>    walk_component+0x100/0x200
>    path_lookupat+0x88/0x118
>    filename_lookup+0x98/0x130
>    user_path_at_empty+0x48/0x60
>    vfs_statx+0x84/0x140
>    vfs_fstatat+0x20/0x30
>    __se_sys_newfstatat+0x30/0x74
>    __arm64_sys_newfstatat+0x1c/0x2c
>    el0_svc_common.constprop.0+0x100/0x184
>    do_el0_svc+0x1c/0x2c
>    el0_svc+0x20/0x34
>    el0_sync_handler+0x80/0x17c
>    el0_sync+0x13c/0x140
>   SELinux: Context system_u:object_r:pssp_rsyslog_log_t:s0:c0 is not valid (left unmapped).
>
> It was found that convert_context() (hooked by convert->func) might
> sleep in a critial section of spin_lock_irqsave in
> sidtab_context_to_sid(). Fix this problem by changing the memory
> allocation in convert_context() from GFP_KERNEL to GFP_ATOMIC.

Good catch! However, convert_context() (and
sidtab_convert_params::func) has two callers:
1. sidtab_context_to_sid(), which requires GFP_ATOMIC,
2. sidtab_convert_tree()/sidtab_convert(), where GFP_KERNEL would be okay.

So a more optimal fix would be to add a gfp_t argument to
convert_context()/sidtab_convert_params::func and pass
GFP_KERNEL/_ATOMIC as appropriate in the individual callers.

> Reported-by: Tan Ninghao <tanninghao1@huawei.com>
> Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
>  security/selinux/ss/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index fe5fcf571c56..523876bb7df3 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2036,7 +2036,7 @@ static int convert_context(struct context *oldc, struct context *newc, void *p)
>         args = p;
>
>         if (oldc->str) {
> -               s = kstrdup(oldc->str, GFP_KERNEL);
> +               s = kstrdup(oldc->str, GFP_ATOMIC);
>                 if (!s)
>                         return -ENOMEM;
>
> --
> 2.25.1
>

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

