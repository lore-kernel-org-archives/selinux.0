Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815DFC433EF
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 20:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EBBC6128B
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 20:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhJSUmS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 16:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhJSUmR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 16:42:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AADC06161C;
        Tue, 19 Oct 2021 13:40:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g39so10167976wmp.3;
        Tue, 19 Oct 2021 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=7tLQeLa2x5i/+XMaCzczVBKuY00ylvW0ba2CPofMt5Y=;
        b=D+0GZ7tcuWBxgT9NmIuvt6B7RkFRgwIyyezwHWbA2KDHbaDxE6PT5AamboDczuQjzQ
         hX/I31XBbllZD/PiuxrFvcsFHd1sfd3X9oG8FkK+CW+sSnHfCOuVAPQ7NZq5sq9mLjdq
         N+QU7F2IBro5igGTlDkrHmNyAzXi6a8AW7yIPgACGZyLlfB0ME5PlxV+X0nlbpa8py3P
         6GG434TFl3iyzEQDC/s02kDT7V+bT17auOQ3zNtRO4ZPTfVgLxR6lk7Dkp5GpFQPNJ5A
         pUY9EbOpOcPG7U7v4vBn/UIvZYiWyImU13tZKz5w0uBgztkfZ7j3CZ3iol9UAv1/bDxY
         p9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=7tLQeLa2x5i/+XMaCzczVBKuY00ylvW0ba2CPofMt5Y=;
        b=eHByzHn//KyPpRz5y3ekv+Kik1sy6oYNZKQFEbz5Gmzek0R+p7SFIfeuoM3aoOI0Y8
         Q4Uo17J8BAHm+WewN+Vr5cMo/sGfQyBDW2cYTw3VM4fqkgysBwBcrFAqKnGieaG2+Jlh
         X0o5XHVt2lRYenulsespfTRMlsjkopyPhCg9xhJrU3QxqPUEDCQIQIp31VLR3v3P7/s+
         1Fc6f3YOwH0frz8a4JwuQjLNMWHniO1zKQxuoA9QfANBtrEepqBAy+/ZY66RAPeFrEkI
         mws4yYWhTQ4R1JVWcOXP9ySrshfKkJGAsi0Q3FPuFpUJeRp6enDWlEb3KdAhwkMhAsod
         XjDQ==
X-Gm-Message-State: AOAM530IVzP3dEwT3fUqWdjgkV6L6Q98L9i83bK9SOn7us4iij007d5R
        gXsds4pI2466SjzpIXDs6LE=
X-Google-Smtp-Source: ABdhPJwr0xj4M2HF2JyyenRKjAyInWxqBZ6WyUsj7ERJgaT1oyhv4bwPsSgpgJleJbI2vvkRG49Jag==
X-Received: by 2002:a05:600c:4646:: with SMTP id n6mr9100576wmo.134.1634676003109;
        Tue, 19 Oct 2021 13:40:03 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id q18sm3163444wmc.7.2021.10.19.13.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:40:02 -0700 (PDT)
Date:   Tue, 19 Oct 2021 22:40:01 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: kernel NULL pointer dereference on selinux_ip_postroute
Message-ID: <YW8tIfTzZUeyVgpu@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello

since next-20211018 I got the following crash:
   56.084594] BUG: kernel NULL pointer dereference, address: 0000000000000290
[   56.092367] #PF: supervisor read access in kernel mode
[   56.097495] #PF: error_code(0x0000) - not-present page
[   56.102628] PGD 11ceb3067 P4D 11ceb3067 PUD 11ce68067 PMD 0 
[   56.108288] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   56.112646] CPU: 0 PID: 171 Comm: dhcpcd Tainted: G         C        5.15.0-rc6-next-20211019+ #114
[   56.121684] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./K10N78, BIOS P2.00 07/01/2010
[   56.130978] RIP: 0010:selinux_ip_postroute_compat+0x4f/0x110
[   56.136645] Code: 7e 18 00 48 89 d7 f3 48 ab 0f 84 9b 00 00 00 48 8b 43 18 48 85 c0 74 0d 0f b6 48 12 80 f9 0c 0f 84 ad 00 00 00 48 89 54 24 10 <48> 8b a8 90 02 00 00 31 c9 31 d2 48 8b 46 10 4c 8d 44 24 07 48 89
[   56.155391] RSP: 0018:ffff9a5f4036f8f0 EFLAGS: 00010246
[   56.160615] RAX: 0000000000000000 RBX: ffff895d9cee8200 RCX: 0000000000000000
[   56.167740] RDX: ffff9a5f4036f918 RSI: ffff9a5f4036fa88 RDI: ffff9a5f4036f950
[   56.174865] RBP: ffff895d9cee8200 R08: ffff9a5f4036f9b8 R09: ffffffffb3a2d140
[   56.181987] R10: ffff895d9d2eb180 R11: ffff895d9cee8200 R12: ffff9a5f4036fa88
[   56.189113] R13: ffff895d9cee8200 R14: ffff9a5f4036fa88 R15: ffff895d80175218
[   56.196236] FS:  00007fe0b206a740(0000) GS:ffff895d9fc00000(0000) knlGS:0000000000000000
[   56.204314] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.210050] CR2: 0000000000000290 CR3: 000000011ceec000 CR4: 00000000000006f0
[   56.217175] Call Trace:
[   56.219622]  <TASK>
[   56.221728]  selinux_ip_postroute+0x177/0x440
[   56.226084]  ? selinux_ip_postroute+0x177/0x440
[   56.230616]  ? __ip6_append_data.isra.0+0xc38/0xff0
[   56.235496]  nf_hook_slow+0x3a/0xa0
[   56.238988]  ip6_finish_output2+0x56c/0x5f0
[   56.243167]  ? ip6_fragment+0x3d4/0x710
[   56.247005]  ? netif_rx_ni+0x100/0x100
[   56.250758]  ip6_send_skb+0x19/0x60
[   56.254243]  rawv6_sendmsg+0xc99/0xf90
[   56.257996]  ? __wake_up_common+0x74/0x140
[   56.262095]  ? sock_sendmsg+0x52/0x60
[   56.265761]  sock_sendmsg+0x52/0x60
[   56.269245]  ____sys_sendmsg+0x20c/0x260
[   56.273162]  ? sendmsg_copy_msghdr+0x74/0x90
[   56.277434]  ___sys_sendmsg+0x7c/0xc0
[   56.281094]  ? sock_read_iter+0x8d/0xf0
[   56.284932]  ? new_sync_read+0x185/0x1a0
[   56.288858]  __sys_sendmsg+0x54/0xa0
[   56.292436]  ? fpregs_assert_state_consistent+0x18/0x40
[   56.297663]  do_syscall_64+0x3b/0x90
[   56.301241]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   56.306295] RIP: 0033:0x7fe0b2162163
[   56.309873] Code: 64 89 02 48 c7 c0 ff ff ff ff eb b7 66 2e 0f 1f 84 00 00 00 00 00 90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
[   56.328610] RSP: 002b:00007fffa63fa0e8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   56.336168] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fe0b2162163
[   56.343291] RDX: 0000000000000000 RSI: 00007fffa640a248 RDI: 0000000000000006
[   56.350415] RBP: 00007fffa641a430 R08: 00007fffa640a280 R09: 00007fffa640a248
[   56.357540] R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000000
[   56.364663] R13: 00007fffa640a304 R14: 0000000000000020 R15: 0000000000000002
[   56.371789]  </TASK>
[   56.373973] Modules linked in: fc0013 it913x tea5767 tda8290 mxl5005s tda18218 mxl5007t tda18212 xc4000 tuner_xc2028 max2165 tea5761 m88rs6000t mt2060 e4000 mc44s803 qt1010 tuner_simple si2157 tuner_types fc0011 regmap_i2c iscsi_target_mod target_core_file target_core_mod configfs crct10dif_generic crc_t10dif crct10dif_common iptable_nat xt_addrtype nf_log_syslog xt_nat xt_LOG xt_mark xt_MASQUERADE adv7175 saa7110 zr36067(C) videobuf2_dma_contig
[   56.413371] CR2: 0000000000000290
[   56.416756] ---[ end trace ffe54c3f1e62823e ]---
[   56.422726] RIP: 0010:selinux_ip_postroute_compat+0x4f/0x110
[   56.429765] Code: 7e 18 00 48 89 d7 f3 48 ab 0f 84 9b 00 00 00 48 8b 43 18 48 85 c0 74 0d 0f b6 48 12 80 f9 0c 0f 84 ad 00 00 00 48 89 54 24 10 <48> 8b a8 90 02 00 00 31 c9 31 d2 48 8b 46 10 4c 8d 44 24 07 48 89
[   56.449899] RSP: 0018:ffff9a5f4036f8f0 EFLAGS: 00010246
[   56.456506] RAX: 0000000000000000 RBX: ffff895d9cee8200 RCX: 0000000000000000
[   56.465020] RDX: ffff9a5f4036f918 RSI: ffff9a5f4036fa88 RDI: ffff9a5f4036f950
[   56.473510] RBP: ffff895d9cee8200 R08: ffff9a5f4036f9b8 R09: ffffffffb3a2d140
[   56.482042] R10: ffff895d9d2eb180 R11: ffff895d9cee8200 R12: ffff9a5f4036fa88
[   56.489762] R13: ffff895d9cee8200 R14: ffff9a5f4036fa88 R15: ffff895d80175218
[   56.496896] FS:  00007fe0b206a740(0000) GS:ffff895d9fc00000(0000) knlGS:0000000000000000
[   56.504980] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   56.510728] CR2: 0000000000000290 CR3: 000000011ceec000 CR4: 00000000000006f0

Reverting 1d1e1ded1356 ("selinux: make better use of the nf_hook_state passed to the NF hooks") seems to remove this crash.

This is tested on a x86_64 board with x86_64_defconfig

Regards
