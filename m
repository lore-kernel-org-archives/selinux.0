Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D345C33C9E
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 11:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B2A2077B
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 11:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrNubQQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgAHLnJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:43:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49598 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727650AbgAHLnI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 06:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578483786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bgnShBkcUouvreqGPWTdxhtBpLBwnjhEz8xa0lAL268=;
        b=OrNubQQCQX8YweKkrPDcPA0/He0FezhNnCVy6g1mBhZ7P3v0m6xbKWDhx+irjABKSwGgUk
        dsLEI9c5eMwDzEWj2jM3cxvpsATWSkBxGpBT9gcvPhNu0ScZbEoQmlCkpA5e/iLYuYv2mJ
        iZvAD2IPxz66CcqRzYbQkSi/xT2u2Gs=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-DGYrbLwyNbabJpaAjZjTWQ-1; Wed, 08 Jan 2020 06:43:04 -0500
X-MC-Unique: DGYrbLwyNbabJpaAjZjTWQ-1
Received: by mail-oi1-f199.google.com with SMTP id u125so1455981oia.20
        for <selinux@vger.kernel.org>; Wed, 08 Jan 2020 03:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgnShBkcUouvreqGPWTdxhtBpLBwnjhEz8xa0lAL268=;
        b=rlaPrkmZabqOi0e2bC/peCwbERrCznmOezKZHHNMBl1Xt4qiEgJKE35fKAObQwFSCV
         O/xF+5wmLrN1cmujCxg5hyb5qo8TIJ41sHH71IH0cNLfv1yKw57kci61yaET50oq+up4
         7MddC924b159iwX416GjBuW0QawX27WWzOghT0Gqpi60JF+TWmN1zrmcj4LGQqVBpY5F
         ilQGfltaSF75JXr1dlCKvO7XmKnjscfxknh9lPGapkSpBrw1tbr7daH/5wucjIJNS9lt
         1scb+SgPS4DjYYBHG78tNInaNHGgUVztVX8NsB73nqyEy8mMrRIIcd7c0KUi0WBP9GIJ
         dN6g==
X-Gm-Message-State: APjAAAU611pfnsGXcehpuO3bu3/BdBFnPc27gRGgRaaXMqqIVTXGtdDD
        Kn6yRSN4sdrg+nmrm2+IjyMJ1DRZvXEfauKTPeE2GXhXuYkxK2AaoEvFOtuO//g7PFwtN0Wj6KF
        0obbp2Np9Gh2ekJLsYTEUVq3HNRPJtokFbA==
X-Received: by 2002:a05:6830:1481:: with SMTP id s1mr3865302otq.66.1578483783303;
        Wed, 08 Jan 2020 03:43:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzIW/S3IzTt4xWYJQDR5bYb2wj40gcNcUGat8VxN4STKqFrZIKCLdVnJDP7sTWV7fQ07vWa4yqjVpEO4JP9/s=
X-Received: by 2002:a05:6830:1481:: with SMTP id s1mr3865274otq.66.1578483782989;
 Wed, 08 Jan 2020 03:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20200108083430.57412-1-yehs2007@zoho.com>
In-Reply-To: <20200108083430.57412-1-yehs2007@zoho.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 8 Jan 2020 12:42:52 +0100
Message-ID: <CAFqZXNujo1px1=JVc+Chr_trVDRpwcXv7pqWVSxi+yifvWoMuA@mail.gmail.com>
Subject: Re: [PATCH] LSM: Delete hooks in reverse order for avoiding race
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, efremov@ispras.ru,
        Paul Moore <paul@paul-moore.com>,
        David Howells <dhowells@redhat.com>, joel@joelfernandes.org,
        tyu1@lenovo.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Huaisheng Ye <yehs1@lenovo.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

On Wed, Jan 8, 2020 at 9:51 AM Huaisheng Ye <yehs2007@zoho.com> wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
>
> There is small possibility as race condition when selinux_disable
> has been triggered. security_delete_hooks deletes all selinux hooks
> from security_hook_heads, but there are some selinux functions which
> are being called at the same time.
>
> Here is a panic accident scene from 4.18 based kernel,
>
> [   26.654494] SELinux:  Disabled at runtime.
> [   26.654507] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000020
> [   26.654508] PGD 0 P4D 0
> [   26.654510] Oops: 0002 [#1] SMP NOPTI
> [   26.654512] CPU: 53 PID: 2614 Comm: systemd-cgroups Tainted: G
>      OE    --------- -  - 4.18.0-80.el8.x86_64 #1
> [   26.654512] Hardware name: Lenovo ThinkSystem SR850P
>  -[7D2H]-/-[7D2H]-, BIOS -[TEE145P-1.10]- 12/06/2019
> [   26.654519] RIP: 0010:selinux_socket_post_create+0x80/0x390
> [   26.654520] Code: e9 95 6a 89 00 bd 16 00 00 00 c7 44 24 04 01
>  00 00 00 45 85 c0 0f 85 f6 00 00 00 8b 56 14 85 d2 0f 84 26 01 00
>  00 89 54 24 04 <66> 41 89 6c 24 20 31 c0 41 89 54 24 1c 41 c6 44
>  24 22 01 49 8b 4d
> [   26.654521] RSP: 0018:ffffbf515cc63e48 EFLAGS: 00010246
> [   26.654522] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000019
> [   26.654522] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffffab46f680
> [   26.654523] RBP: 0000000000000019 R08: 0000000000000000 R09: ffffbf515cc63e4c
> [   26.654523] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [   26.654524] R13: ffff97d7bb6cbc80 R14: 0000000000000001 R15: ffff97d7bb6cbc80
> [   26.654525] FS:  00007f5c608ea380(0000) GS:ffff97d7bf140000(0000) knlGS:0000000000000000
> [   26.654525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   26.654526] CR2: 0000000000000020 CR3: 0000011ebc934004 CR4: 00000000007606e0
> [   26.654527] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   26.654528] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   26.654528] PKRU: 55555554
> [   26.654528] Call Trace:
> [   26.654535]  security_socket_post_create+0x42/0x60
> [   26.654537] SELinux:  Unregistering netfilter hooks
> [   26.654542]  __sock_create+0x106/0x1a0
> [   26.654545]  __sys_socket+0x57/0xe0
> [   26.654547]  __x64_sys_socket+0x16/0x20
> [   26.654551]  do_syscall_64+0x5b/0x1b0
> [   26.654554]  entry_SYSCALL_64_after_hwframe+0x65/0xca
>
> The root cause is that, selinux_inode_alloc_security has been deleted
> firstly from security_hook_heads, so security_inode_alloc directly
> return 0, that means the value of pointer inode->i_security equalling
> to NULL.
>
> But selinux_socket_post_create hasn't been deleted at that moment, so
> which would involked by mistake. Inside the function, pointer isec
> needs to point to inode->i_security, then a NULL pointer defect happens.
>
> For current upstream kernel, because of commit
> afb1cbe37440c7f38b9cf46fc331cc9dfd5cce21
> the inode security has been moved out to LSM infrastructure from
> individual security modules like selinux.
>
> But this patch still can be applied for solving similar issue when
> security_delete_hooks has been used. Also for stable branch v4.19,
> the inode security still need to be created in individual modules.

Thank you for the patch, however there are already existing proposed
patches to fix this issue, see [1], [2], and [3]. At the moment it
looks like the SELinux hooks reorder approach ([1]) will be accepted
as a temporary solution (the SELinux runtime disable is being
deprecated [4] in favor of properly disabling SELinux by setting
selinux=0 on the kernel command line).

Your approach unfortunately isn't robust (depends on assumptions about
how hooks are ordered by LSMs) nor complete (even the inverse order
still has some race conditions that may lead to a crash - e.g.
selinux_bpf_map() vs. selinux_bpf_map_alloc()).

Also, please, don't forget to Cc the LSM/SELinux mailing lists
(linux-security-module@vger.kernel.org/selinux@vger.kernel.org,
respectively) for patches related to the LSM framework/SELinux.

[1] https://lore.kernel.org/selinux/20191209075756.123157-1-omosnace@redhat.com/T/
[2] https://lore.kernel.org/selinux/20191211140833.939845-1-omosnace@redhat.com/T/
[3] https://lore.kernel.org/selinux/20200107133154.588958-1-omosnace@redhat.com/T/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?h=next&id=89b223bfb8a89731bea4c84982b5d2ad7ba460e3

>
> The patch has been verified by Lenovo SR850P server through overnight
> reboot cycles.
>
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  include/linux/lsm_hooks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 20d8cf1..57cb2ac 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2164,7 +2164,7 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
>         int i;
>
>         for (i = 0; i < count; i++)
> -               hlist_del_rcu(&hooks[i].list);
> +               hlist_del_rcu(&hooks[count - 1 - i].list);
>  }
>  #endif /* CONFIG_SECURITY_SELINUX_DISABLE */
>
> --
> 1.8.3.1
>
>

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

