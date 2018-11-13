Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05C8C43441
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 15:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A0522510
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 15:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A0522510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeKNBRN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Nov 2018 20:17:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35917 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731422AbeKNBRN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Nov 2018 20:17:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id z13-v6so13748438wrs.3
        for <selinux@vger.kernel.org>; Tue, 13 Nov 2018 07:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TVio5aW1p9jCZScS1P7hnnowI7+E2mp8Lej3u8aWiDc=;
        b=kJSKFVpYe3aWTch2JKlA+eonrGhTPyzJUI8MH8BwjEng8yr3jOURsATcqMxRXWJ53L
         vRx5Yn8OPwmr1u3OyqSDan+iptKqJigzCaNZSNh39iA++f+6K/BDH9XCcRY/d6n/eGvx
         Jp4o8INsGs8rLmN5so0zsBEP8mpLL+boKEkCFpLDuZIteqIRDZS9kOHAxAZ/g6rdpI7e
         smo2iC8k2rkg2AIJBzqcGGEdWMdBoijdc3axvRSwb4y/VVhWT5wd49+zx4f55smUArAp
         h+DQCVCKdWRppMjKub8aGE+DahlvKfePEm/8bl9HFeGfJZpMNOCVZSO9kLJcyhQCNHht
         8Yqg==
X-Gm-Message-State: AGRZ1gLc8vZe2n7rkRMXHpq8t19FZ4dKTDvaqhD34myUN9Q6wZP9btDY
        Qtwqt/qAkiWFOWfuGpwcBj8FZ2fCZeU=
X-Google-Smtp-Source: AJdET5fEHBD5xiUcJl32FTC7Eh3RwjPyD7gwYJf0S4pM9WN6EqyOikKt3ZvHyT5BqlrDcmLhhz9meQ==
X-Received: by 2002:a5d:4406:: with SMTP id z6-v6mr5521253wrq.294.1542122317263;
        Tue, 13 Nov 2018 07:18:37 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u8-v6sm15725493wrr.33.2018.11.13.07.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 07:18:36 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Qian Cai <cai@gmx.us>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>, stable@vger.kernel.org,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH] selinux: check length properly in SCTP bind hook
Date:   Tue, 13 Nov 2018 16:16:08 +0100
Message-Id: <20181113151608.30424-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <53491A18-DD21-4E34-BC2F-AB449C7844E8@gmx.us>
References: <53491A18-DD21-4E34-BC2F-AB449C7844E8@gmx.us>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

selinux_sctp_bind_connect() must verify if the address buffer has
sufficient length before accessing the 'sa_family' field. See
__sctp_connect() for a similar check.

The length of the whole address ('len') is already checked in the
callees.

Reported-by: Qian Cai <cai@gmx.us>
Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Cc: <stable@vger.kernel.org> # 4.17+
Cc: Richard Haines <richard_c_haines@btinternet.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
Hi,

On Mon, Nov 12, 2018 at 8:39 PM Qian Cai <cai@gmx.us> wrote:
> Running the trinity fuzzer on the latest mainline (rc2) generates this,
> 
> [15029.879626] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x60/0x150
> [15029.887275] Read of size 2 at addr ffff801ec53c5080 by task trinity-main/18081
> [15029.887294] 
> [15029.887304] CPU: 28 PID: 18081 Comm: trinity-main Tainted: G        W  OE     4.20.0-rc2+ #15
> [15029.887311] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50 06/01/2018
> [15000.084786] [15029.887320] Call trace:
> [15029.915511]  dump_backtrace+0x0/0x2c8
> [15029.920046]  show_stack+0x24/0x30
> [15029.923367]  dump_stack+0x118/0x19c
> [15029.927539]  print_address_description+0x68/0x2a0
> [15029.932245]  kasan_report+0x1b4/0x348
> [15029.938760]  __asan_load2+0x7c/0xa0
> [15029.945098]  selinux_sctp_bind_connect+0x60/0x150
> 
> [15029.950571]  security_sctp_bind_connect+0x58/0x90
> [15029.955493]  __sctp_setsockopt_connectx+0x68/0x128 [sctp]
> [15029.960943]  sctp_setsockopt+0x764/0x2928 [sctp]
> [15029.965564]  sock_common_setsockopt+0x6c/0x80
> [15029.969923]  __arm64_sys_setsockopt+0x13c/0x1f0
> [15029.974456]  el0_svc_handler+0xd4/0x198
> [15029.978293]  el0_svc+0x8/0xc
> [15029.981174] 
> [15029.982667] Allocated by task 18081:
> [15029.986245]  kasan_kmalloc.part.1+0x40/0x108
> [15029.990517]  kasan_kmalloc+0xb4/0xc8
> [15029.994094]  __kmalloc_node+0x1c4/0x638
> [15029.997933]  kvmalloc_node+0x98/0xa8
> [15030.001511]  vmemdup_user+0x34/0x128
> [15030.005137]  __sctp_setsockopt_connectx+0x44/0x128 [sctp]
> [15030.010586]  sctp_setsockopt+0x764/0x2928 [sctp]
> [15030.015205]  sock_common_setsockopt+0x6c/0x80
> [15030.019564]  __arm64_sys_setsockopt+0x13c/0x1f0
> [15030.024096]  el0_svc_handler+0xd4/0x198
> [15030.027933]  el0_svc+0x8/0xc
> [15030.030814] 
> [15030.032306] Freed by task 3025:
> [15030.035451]  __kasan_slab_free+0x114/0x228
> [15030.039548]  kasan_slab_free+0x10/0x18
> [15030.043299]  kfree+0x114/0x408
> [15030.046357]  selinux_sk_free_security+0x38/0x48
> [15030.050888]  security_sk_free+0x3c/0x58
> [15030.054727]  __sk_destruct+0x3e8/0x570
> [15030.058478]  sk_destruct+0x4c/0x58
> [15030.061881]  __sk_free+0x68/0x138
> [15030.065197]  sk_free+0x3c/0x48
> [15030.068255]  unix_release_sock+0x4a8/0x550
> [15030.072353]  unix_release+0x34/0x50
> [15030.075843]  __sock_release+0x74/0x110
> [15030.079593]  sock_close+0x24/0x38
> [15030.082913]  __fput+0x1b8/0x368
> [15030.086055]  ____fput+0x20/0x30
> [15030.089199]  task_work_run+0x14c/0x1a8
> [15030.092951]  do_notify_resume+0x1e4/0x200
> [15030.096961]  work_pending+0x8/0x14
> [15030.100363] 
> [15030.101856] The buggy address belongs to the object at ffff801ec53c5080
> [15030.101856]  which belongs to the cache kmalloc-128 of size 128
> [15030.114376] The buggy address is located 0 bytes inside of
> [15030.114376]  128-byte region [ffff801ec53c5080, ffff801ec53c5100)
> [15030.125939] The buggy address belongs to the page:
> [15030.130732] page:ffff7fe007b14f00 count:1 mapcount:0 mapping:ffff8016c0010480 index:0x0
> [15030.138738] flags: 0x5fffff0000000200(slab)
> [15030.142926] raw: 5fffff0000000200 ffff7fe007980608 ffff801ec000fd60 ffff8016c0010480
> [15030.150671] raw: 0000000000000000 0000000000660066 00000001ffffffff 0000000000000000
> [15030.158413] page dumped because: kasan: bad access detected
> [15030.163984] 
> [15030.165476] Memory state around the buggy address:
> [15030.170269]  ffff801ec53c4f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [15030.177491]  ffff801ec53c5000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [15030.184714] >ffff801ec53c5080: 01 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [15030.191934]                    ^
> [15030.195164]  ffff801ec53c5100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [15030.202386]  ffff801ec53c5180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [15030.209607] ==================================================================
> [15030.216828] Disabling lock debugging due to kernel taint

I think I found the cause - Qian, can you test this patch if it fixes
the problem?

 security/selinux/hooks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7ce683259357..a67459eb62d5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5318,6 +5318,9 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 	addr_buf = address;
 
 	while (walk_size < addrlen) {
+		if (walk_size + sizeof(sa_family_t) > addrlen)
+			return -EINVAL;
+
 		addr = addr_buf;
 		switch (addr->sa_family) {
 		case AF_UNSPEC:
-- 
2.17.2

