Return-Path: <SRS0=Plie=RK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8885C43381
	for <selinux@archiver.kernel.org>; Thu,  7 Mar 2019 02:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1B42064A
	for <selinux@archiver.kernel.org>; Thu,  7 Mar 2019 02:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfCGCos (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:44:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfCGCos (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 Mar 2019 21:44:48 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 13F13704BF0505E5836D;
        Thu,  7 Mar 2019 10:44:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Thu, 7 Mar 2019 10:44:41 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <paul@paul-moore.com>, <sds@tycho.nsa.gov>,
        <eparis@parisplace.org>, <selinux@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: selinux: fix memory leak in selinux_netlbl_socket_post_create()
Date:   Thu, 7 Mar 2019 10:57:31 +0800
Message-ID: <20190307025731.49369-1-maowenan@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If netlbl_sock_setattr() is failed, it directly returns rc and forgets
to free secattr.

BUG: memory leak
unreferenced object 0xffff8883c3ea4200 (size 2664):
  comm "syz-executor.2", pid 8813, jiffies 4297264419 (age 156.090s)
  hex dump (first 32 bytes):
    7f 00 00 01 7f 00 00 01 eb 7f ed 71 4e 24 00 00  ...........qN$..
    02 00 07 40 00 00 00 00 00 00 00 00 00 00 00 00  ...@............
  backtrace:
    [<000000004c0228da>] sk_alloc+0x3d/0xc00 net/core/sock.c:1523
    [<00000000535a3da2>] inet_create+0x339/0xe10 net/ipv4/af_inet.c:321
    [<000000009aec3cfe>] __sock_create+0x3fa/0x790 net/socket.c:1275
    [<000000004274b384>] sock_create net/socket.c:1315 [inline]
    [<000000004274b384>] __sys_socket+0xe7/0x1d0 net/socket.c:1345
    [<00000000b3fdc826>] __do_sys_socket net/socket.c:1354 [inline]
    [<00000000b3fdc826>] __se_sys_socket net/socket.c:1352 [inline]
    [<00000000b3fdc826>] __x64_sys_socket+0x74/0xb0 net/socket.c:1352
    [<000000004ae3186e>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
    [<00000000bc0d2230>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000f737e62f>] 0xffffffffffffffff

BUG: memory leak
unreferenced object 0xffff8883de23d570 (size 32):
  comm "syz-executor.2", pid 8813, jiffies 4297264419 (age 156.090s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 60 a9 40 ce 83 88 ff ff  ........`.@.....
    01 00 00 00 03 00 00 00 10 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000035ba8b75>] security_sk_alloc+0x5e/0xb0 security/security.c:1473
    [<00000000302cc426>] sk_prot_alloc+0x8e/0x290 net/core/sock.c:1472
    [<000000004c0228da>] sk_alloc+0x3d/0xc00 net/core/sock.c:1523
    [<00000000535a3da2>] inet_create+0x339/0xe10 net/ipv4/af_inet.c:321
    [<000000009aec3cfe>] __sock_create+0x3fa/0x790 net/socket.c:1275
    [<000000004274b384>] sock_create net/socket.c:1315 [inline]
    [<000000004274b384>] __sys_socket+0xe7/0x1d0 net/socket.c:1345
    [<00000000b3fdc826>] __do_sys_socket net/socket.c:1354 [inline]
    [<00000000b3fdc826>] __se_sys_socket net/socket.c:1352 [inline]
    [<00000000b3fdc826>] __x64_sys_socket+0x74/0xb0 net/socket.c:1352
    [<000000004ae3186e>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
    [<00000000bc0d2230>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000f737e62f>] 0xffffffffffffffff

BUG: memory leak
unreferenced object 0xffff8883ce40a960 (size 64):
  comm "syz-executor.2", pid 8813, jiffies 4297264420 (age 156.089s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000029add401>] selinux_netlbl_socket_post_create+0x68/0x130 security/selinux/netlabel.c:416
    [<000000005368a19c>] selinux_socket_post_create+0x31a/0x7f0 security/selinux/hooks.c:4597
    [<00000000bd4730e2>] security_socket_post_create+0x70/0xc0 security/security.c:1385
    [<00000000671052a4>] __sock_create+0x5a6/0x790 net/socket.c:1291
    [<000000004274b384>] sock_create net/socket.c:1315 [inline]
    [<000000004274b384>] __sys_socket+0xe7/0x1d0 net/socket.c:1345
    [<00000000b3fdc826>] __do_sys_socket net/socket.c:1354 [inline]
    [<00000000b3fdc826>] __se_sys_socket net/socket.c:1352 [inline]
    [<00000000b3fdc826>] __x64_sys_socket+0x74/0xb0 net/socket.c:1352
    [<000000004ae3186e>] do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
    [<00000000bc0d2230>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
    [<00000000f737e62f>] 0xffffffffffffffff

Fixes: 389fb800ac8b("netlabel: Label incoming TCP connections correctly in SELinux")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 security/selinux/netlabel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 186e727b737b..f3da05338580 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -426,6 +426,9 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 		rc = 0;
 		break;
 	}
+	if (rc != 0) {
+		netlbl_secattr_free(secattr);
+	}
 
 	return rc;
 }
-- 
2.20.1

