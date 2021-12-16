Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FDEC433EF
	for <selinux@archiver.kernel.org>; Thu, 16 Dec 2021 22:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhLPWxZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Dec 2021 17:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhLPWxZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Dec 2021 17:53:25 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F16C061574
        for <selinux@vger.kernel.org>; Thu, 16 Dec 2021 14:53:25 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so994093edb.8
        for <selinux@vger.kernel.org>; Thu, 16 Dec 2021 14:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vrw9ZHhGke8kgcgyP0L8S7hQolgx2MIdXfRsmTF5uH4=;
        b=NMwipB/OMXXWW/8E9ZJSW0BYdqoAQcMvlJGxmjYb2APv+zNTFl+zOMaygvL0CxWlpO
         qYt15XKW4WSgBgLrM2/QlLfqVfj7xPGEfxA+jFK5Qwmh/Fa1ON7z3yw7+cqMHtLxIfdk
         FDnVhGReNCBxgPpDrY6/vdSPno5p8lJp0RcXj+ViAcXehbFVaBJqy/WnLy8Q9CV+7SMi
         GFnv/V0k2+n65HoqP3Kiw8Bq9Dh2lr/+nI1VxY5aCaBJcZl+QD2M0LD9HczkWTUNeEos
         pqBx9I3qttF/zg1egSy+XoZGh9SabKGcquHznKAT5FrsrI3U9MxgWPNO/8eyDpakN9nd
         3OxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vrw9ZHhGke8kgcgyP0L8S7hQolgx2MIdXfRsmTF5uH4=;
        b=rAK/Of3JHlHZ9+oXKib16qvW/aqg81lWhaqMGYWEitTCyhmI4Ff+gs9kXylk+tOu/x
         VlC6llT+wGT4L9Z3HyeMPqvf3zFv5wZUlAiFFDkvNtL+Ckri9bIiIBnM3VgXomzpm3mp
         YQbEO4lEvk91EU4Ywdt9Gpkkw84y0S2Aq6h5Fb+urrtQByNAZcynyAUxNbFhJZMnN22/
         n566F2462tD+bCiW1dfcxtfsgQ6ja4Fu0p4UfO/9n5QOy50HJaYou0LmKn10DecE1GCD
         6b9NfHrKYPtZLMYwprA4fU5/rpWj3id0h314aSpZzxwwwha3qhd0W1sdJ8gvi57r3m7y
         5A0A==
X-Gm-Message-State: AOAM530q1ztamUFm8XmIxIaz2xROe6dnwjB8swrmUevZm11xXOtCopdv
        9AWk4CbPIlxWbQBhrCFqQs0ZjdISRxylGtTMzllCP9ThdQ==
X-Google-Smtp-Source: ABdhPJxC8yC6f5JJOaoSqo1Evy1K543+exqENRYhU5+U6f+MaMi5v+uLZx+OEraXw5VULnSoq7bqbvAjeKhphuf0Puc=
X-Received: by 2002:a17:906:8241:: with SMTP id f1mr233058ejx.112.1639695203655;
 Thu, 16 Dec 2021 14:53:23 -0800 (PST)
MIME-Version: 1.0
References: <20211215212840.1022859-1-smayhew@redhat.com>
In-Reply-To: <20211215212840.1022859-1-smayhew@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Dec 2021 17:53:12 -0500
Message-ID: <CAHC9VhSR+2A+JNntMhpgHxTR657E0Dq3tc_bzvQhWqt=F3kxzw@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: Fix sleeping function called from invalid context
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 15, 2021 at 4:28 PM Scott Mayhew <smayhew@redhat.com> wrote:
>
> selinux_sb_mnt_opts_compat() is called via sget_fc() under the sb_lock
> spinlock, so it can't use GFP_KERNEL allocations:
>
> [  868.565200] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:230
> [  868.568246] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4914, name: mount.nfs
> [  868.569626] preempt_count: 1, expected: 0
> [  868.570215] RCU nest depth: 0, expected: 0
> [  868.570809] Preemption disabled at:
> [  868.570810] [<0000000000000000>] 0x0
> [  868.571848] CPU: 1 PID: 4914 Comm: mount.nfs Kdump: loaded Tainted: G        W         5.16.0-rc5.2585cf9dfa #1
> [  868.573273] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-4.fc34 04/01/2014
> [  868.574478] Call Trace:
> [  868.574844]  <TASK>
> [  868.575156]  dump_stack_lvl+0x34/0x44
> [  868.575692]  __might_resched.cold+0xd6/0x10f
> [  868.576308]  slab_pre_alloc_hook.constprop.0+0x89/0xf0
> [  868.577046]  __kmalloc_track_caller+0x72/0x420
> [  868.577684]  ? security_context_to_sid_core+0x48/0x2b0
> [  868.578569]  kmemdup_nul+0x22/0x50
> [  868.579108]  security_context_to_sid_core+0x48/0x2b0
> [  868.579854]  ? _nfs4_proc_pathconf+0xff/0x110 [nfsv4]
> [  868.580742]  ? nfs_reconfigure+0x80/0x80 [nfs]
> [  868.581355]  security_context_str_to_sid+0x36/0x40
> [  868.581960]  selinux_sb_mnt_opts_compat+0xb5/0x1e0
> [  868.582550]  ? nfs_reconfigure+0x80/0x80 [nfs]
> [  868.583098]  security_sb_mnt_opts_compat+0x2a/0x40
> [  868.583676]  nfs_compare_super+0x113/0x220 [nfs]
> [  868.584249]  ? nfs_try_mount_request+0x210/0x210 [nfs]
> [  868.584879]  sget_fc+0xb5/0x2f0
> [  868.585267]  nfs_get_tree_common+0x91/0x4a0 [nfs]
> [  868.585834]  vfs_get_tree+0x25/0xb0
> [  868.586241]  fc_mount+0xe/0x30
> [  868.586605]  do_nfs4_mount+0x130/0x380 [nfsv4]
> [  868.587160]  nfs4_try_get_tree+0x47/0xb0 [nfsv4]
> [  868.587724]  vfs_get_tree+0x25/0xb0
> [  868.588193]  do_new_mount+0x176/0x310
> [  868.588782]  __x64_sys_mount+0x103/0x140
> [  868.589388]  do_syscall_64+0x3b/0x90
> [  868.589935]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  868.590699] RIP: 0033:0x7f2b371c6c4e
> [  868.591239] Code: 48 8b 0d dd 71 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d aa 71 0e 00 f7 d8 64 89 01 48
> [  868.593810] RSP: 002b:00007ffc83775d88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> [  868.594691] RAX: ffffffffffffffda RBX: 00007ffc83775f10 RCX: 00007f2b371c6c4e
> [  868.595504] RDX: 0000555d517247a0 RSI: 0000555d51724700 RDI: 0000555d51724540
> [  868.596317] RBP: 00007ffc83775f10 R08: 0000555d51726890 R09: 0000555d51726890
> [  868.597162] R10: 0000000000000000 R11: 0000000000000246 R12: 0000555d51726890
> [  868.598005] R13: 0000000000000003 R14: 0000555d517246e0 R15: 0000555d511ac925
> [  868.598826]  </TASK>
>
> Fixes: 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an existing mount")
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  security/selinux/hooks.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)

Merged into selinux/stable-5.16, thanks Scott.  Assuming all goes well
with the automated testing I'll send this to Linus tomorrow.

-- 
paul moore
www.paul-moore.com
