Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37E9C4332F
	for <selinux@archiver.kernel.org>; Wed, 19 Oct 2022 13:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiJSNXA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Oct 2022 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiJSNWb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Oct 2022 09:22:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E181633A7
        for <selinux@vger.kernel.org>; Wed, 19 Oct 2022 06:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666184829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LA6Cza3pSGpXKVU6F+S8U8JWg8ZovqHMMGY0EaLCBBg=;
        b=OUjxL3k9lC4AbKVv9OmTt9h1KLxe/VXFQoDD3mkMoRVKV+G3q+uoKV0D06l28qoBLtvIj/
        QJ7FaOYKsu9qI9Vx4jeMTUwBSdwyGQkNdVWSVjI8UZdLHTs3rFXuE0EoZREL8qtTFBcb8H
        3/uSyJT7G9w0q4eL5PHb7ji5MTADYEE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-228-zZfr8ZGGMK2ZBruWK-RJdw-1; Wed, 19 Oct 2022 04:42:22 -0400
X-MC-Unique: zZfr8ZGGMK2ZBruWK-RJdw-1
Received: by mail-pl1-f199.google.com with SMTP id d18-20020a170902ced200b00180680b8ed1so11253514plg.1
        for <selinux@vger.kernel.org>; Wed, 19 Oct 2022 01:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LA6Cza3pSGpXKVU6F+S8U8JWg8ZovqHMMGY0EaLCBBg=;
        b=yVi1PEZjRXgQ/i5V76xoHTUeql7CGVTLFEge5cMKj5vlqRCiAuj/PLRbw8J1vTYWBA
         Ab1OrStnRJBj9uB2VBmvbgeBZXk1uzoBPLTMxwwAl4FIzjUc8lnH40oFgDoAfzdcWcZ7
         7RbaXEutFm5Bpe7BX63lvDQraGAyZTkvv//9/jYgvC27cPafedZz4OoceK/gtrZ/3Gb7
         lnFKeO7x58r4od88AHvdVGkjByrDfHa5BPLhhl9p8rcliSYOkyi4pQqynQXXwydqFNcy
         AqGIfNs+8f+XEN+Tx8VX+I3r9M6rXLorjqZsnS+dEHRUH4YbDZPxkD9yAU5QbrFvekl/
         YNsw==
X-Gm-Message-State: ACrzQf2Haf6RYWYUudwFAz2w7KlH3DW34MSpj44LHK17UQ6o6PeeD0UY
        8uyiRZXI0tzvDExgiMozJGEsk4AG4LK+uHAVCc5N32pRB8Hh/Z26bJDnWYhtYkPp3XCXAW8cLzJ
        a6dl8/tU+DipRBcnE6LjYjmEHtoQlwwULww==
X-Received: by 2002:a17:90b:4b41:b0:20a:fe8f:5a3 with SMTP id mi1-20020a17090b4b4100b0020afe8f05a3mr43848756pjb.120.1666168941129;
        Wed, 19 Oct 2022 01:42:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6FuVvfJ4E95k0X9Xk8r9zpE8dH9chRXdFCbAhrjjTZD6cYyig2V8giEmVJuPpTRlj8KdTBtxBPT1gpaqW0jcs=
X-Received: by 2002:a17:90b:4b41:b0:20a:fe8f:5a3 with SMTP id
 mi1-20020a17090b4b4100b0020afe8f05a3mr43848724pjb.120.1666168940805; Wed, 19
 Oct 2022 01:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221019025710.2482945-1-gongruiqi1@huawei.com>
In-Reply-To: <20221019025710.2482945-1-gongruiqi1@huawei.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 19 Oct 2022 10:42:07 +0200
Message-ID: <CAFqZXNuyiYEizcPrjCVE=e6bdH9fA0ffAn6VtJswP9JLboGUTw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use GFP_ATOMIC in convert_context()
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

On Wed, Oct 19, 2022 at 4:56 AM GONG, Ruiqi <gongruiqi1@huawei.com> wrote:
>
> The following warning was triggered on a hardware environment:
>
>   SELinux: Converting 162 SID table entries...
>   BUG: sleeping function called from invalid context at __might_sleep+0x60/0x74 0x0
>   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 5943, name: tar
>   CPU: 7 PID: 5943 Comm: tar Tainted: P O 5.10.0 #1
>   Call trace:
>    dump_backtrace+0x0/0x1c8
>    show_stack+0x18/0x28
>    dump_stack+0xe8/0x15c
>    ___might_sleep+0x168/0x17c
>    __might_sleep+0x60/0x74
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
> It was found that within a critical section of spin_lock_irqsave in
> sidtab_context_to_sid(), convert_context() (hooked by
> sidtab_convert_params.func) might cause the process to sleep via
> allocating memory with GFP_KERNEL, which is problematic.
>
> As Ondrej pointed out [1], convert_context()/sidtab_convert_params.func
> has another caller sidtab_convert_tree(), which is okay with GFP_KERNEL.
> Therefore, fix this problem by adding a gfp_t argument for
> convert_context()/sidtab_convert_params.func and pass GFP_KERNEL/_ATOMIC
> properly in individual callers.
>
> Link: https://lore.kernel.org/all/20221018120111.1474581-1-gongruiqi1@huawei.com/ [1]
> Reported-by: Tan Ninghao <tanninghao1@huawei.com>
> Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> ---
>
> v2: change as Ondrej suggests & redraft commit message

This looks good, thanks!

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

>  [...]

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

