Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9464C433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Dec 2021 21:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhLOVDg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Dec 2021 16:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbhLOVDc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Dec 2021 16:03:32 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA42FC061748
        for <selinux@vger.kernel.org>; Wed, 15 Dec 2021 13:03:31 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r25so78535154edq.7
        for <selinux@vger.kernel.org>; Wed, 15 Dec 2021 13:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IfSrzb4994hpe44SLvR10vbt0yQpUmo3yHt5LANHB2I=;
        b=EdNkrwVXLJqRaSza0JUET4rjdPkN2WasPSCGBVSHpF4ulxrA6/KUFo7fucYwvnUbCR
         kFS0j+qLTtcHl8y+WS6wI7NonPbQBk/07lXiwVjnBkjPAM+phBvpTlKFAvPhNpHWosmj
         3m6UGMy1KyTRVBYar2+Y03dbwmgk+u28qMUlqoBP/fTc2WwoeXhF5yvtmw24CIPW0S/H
         YlKBOrbP1d+3mOtt+hzVeXSBAOl4r52mIc8LxZNK5E5Or7z4elSrnnbabKDa3XbxAZb2
         eA+8ljA2rN6UWw1Hrik5LRYsVar+Dp+hnn1hgTJr9CXEAAkMKjkyeHCFCiy1B97rVfrq
         sFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IfSrzb4994hpe44SLvR10vbt0yQpUmo3yHt5LANHB2I=;
        b=NPyij4rq3DXM4ort9cioQwUQ/iiD3uSbd+ITYHCCc6sAfXzbv7S8j8vKZMG0yaciAi
         Qa6/6W7frdtjIYCFNPJeSVgKInbR1fp0B6ReNKC0476nuqKNoDw2KQ05l819w0s6VBcj
         aM9DdyOesmY2ugnOp+oLRTzFvkpZZW92O5sYV/bx0A/7UQyAWxXA/4wDyequkv27PCNz
         6avfgQN7CbxH/GT1iTZ+OVuY+jgPyq+5wINX3wg/SCd/tZRN7HMTZgWhjtQXNystoaF/
         EzQISsbUe4JrJKxIgtO8G/fE10zSgPffB1fXvSLVWDJ8edlU/Y2vKDDr3uKoKMFWobR+
         QDuA==
X-Gm-Message-State: AOAM533vYAHpNyykYT/lzbpYacip84aQqDHL0reRF5V5m7EQKSg/l7ps
        2F/WZ8TMpmGPCr67xSkjMQkw63zVVtxnr/ZqQhZF
X-Google-Smtp-Source: ABdhPJzjFBwWcRzSUxDbl2v8FVHlxUHI97xRIPtM10BWNPpl5ws+2ACDJPeF99vWr4NLBU7v5iYkKViVonCoxU9EWps=
X-Received: by 2002:a05:6402:520e:: with SMTP id s14mr16770367edd.213.1639602210158;
 Wed, 15 Dec 2021 13:03:30 -0800 (PST)
MIME-Version: 1.0
References: <20211215162014.957848-1-smayhew@redhat.com>
In-Reply-To: <20211215162014.957848-1-smayhew@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Dec 2021 16:03:19 -0500
Message-ID: <CAHC9VhTidq4mmjChAVFj4u4_=o5VJ6hyJ9ib-SJrg7BFy-cCgg@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix sleeping function called from invalid context
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 15, 2021 at 11:20 AM Scott Mayhew <smayhew@redhat.com> wrote:
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
>  security/selinux/hooks.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 62d30c0a30c2..534e8a4747f8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -611,10 +611,11 @@ static int bad_option(struct superblock_security_struct *sbsec, char flag,
>         return 0;
>  }
>
> -static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
> +static int __parse_sid(struct super_block *sb, const char *s, u32 *sid,
> +                    gfp_t gfp)
>  {
>         int rc = security_context_str_to_sid(&selinux_state, s,
> -                                            sid, GFP_KERNEL);
> +                                            sid, gfp);
>         if (rc)
>                 pr_warn("SELinux: security_context_str_to_sid"
>                        "(%s) failed for (dev %s, type %s) errno=%d\n",
> @@ -622,6 +623,11 @@ static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
>         return rc;
>  }
>
> +static int parse_sid(struct super_block *sb, const char *s, u32 *sid)
> +{
> +       return __parse_sid(sb, s, sid, GFP_KERNEL);
> +}

Thanks for both reporting the problem and supplying a patch to fix it!

I think I would prefer to see parse_sid() updated to take a gfp
parameter and skip the __parse_sid()/parse_sid() wrapper.  Yes, the
patch will be a bit more intrusive with all of the caller updates, but
we only have to backport up to v5.13 and the resulting code will be
cleaner moving forward.

-- 
paul moore
www.paul-moore.com
