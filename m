Return-Path: <SRS0=7twf=PR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F367C43387
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 08:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E77320821
	for <selinux@archiver.kernel.org>; Wed,  9 Jan 2019 08:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hLEsvWQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbfAIIjq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:39:46 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1532 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbfAIIjp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jan 2019 03:39:45 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c35b3440001>; Wed, 09 Jan 2019 00:39:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 09 Jan 2019 00:39:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 09 Jan 2019 00:39:44 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 9 Jan
 2019 08:39:44 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 9 Jan 2019 08:39:44 +0000
Received: from prpatel.nvidia.com (Not Verified[10.24.229.63]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c35b34c0006>; Wed, 09 Jan 2019 00:39:44 -0800
From:   Prateek Patel <prpatel@nvidia.com>
To:     <paul@paul-moore.com>, <sds@tycho.nsa.gov>,
        <eparis@parisplace.org>, <linux-kernel@vger.kernel.org>,
        <catalin.marinas@arm.com>, <selinux@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <talho@nvidia.com>,
        <swarren@nvidia.com>, <prpatel@nvidia.com>, <linux-mm@kvack.org>,
        <snikam@nvidia.com>, <vdumpa@nvidia.com>,
        Sri Krishna chowdary <schowdary@nvidia.com>
Subject: [PATCH] selinux: avc: mark avc node as not a leak
Date:   Wed, 9 Jan 2019 14:09:22 +0530
Message-ID: <1547023162-6381-1-git-send-email-prpatel@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547023172; bh=d8nk7slwlRpiZg/raOdY1xeZB8HZ56EW4GxJN3oaLI4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=hLEsvWQOHdvqppyoGhavWWiwtZHwSrIOoTQRuR78d2ScVatIwkp8OmLC69zts+iBf
         rsYu5zBXuve4SBmFveLWtpGwKsN55oKASYwIZl5Sc03RASnWufgc1HAJ6fcLTCXyWS
         k4jxYJkeBhaN2237bCl4Nj/Hq1rNbnsjWVJjOkRfrDUamBVpv2ydK51cEuhLo7IOKI
         1PlqVrim5zVM/NoBOy3IirQw2x4hE/+Vy+Jxax+zSGEYfC2QUybzY7jqzFGBvvJIHF
         5QhqomtxUsdzzeQOK5ssYb7M725bS95iCtix76TycWyH0bjc8zb/9ztsLv6nWJvpzM
         UTuAJev+smbpg==
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Sri Krishna chowdary <schowdary@nvidia.com>

kmemleak detects allocated objects as leaks if not accessed for
default scan time. The memory allocated using avc_alloc_node
is freed using rcu mechanism when nodes are reclaimed or on
avc_flush. So, there is no real leak here and kmemleak_scan
detects it as a leak which is false positive. Hence, mark it as
kmemleak_not_leak.

Following is the log for avc_alloc_node detected as leak:
unreferenced object 0xffffffc0dd1a0e60 (size 64):
  comm "InputDispatcher", pid 648, jiffies 4294944629 (age 698.180s)
  hex dump (first 32 bytes):
    ed 00 00 00 ed 00 00 00 17 00 00 00 3f fe 41 00  ............?.A.
    00 00 00 00 ff ff ff ff 01 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffc000192390>] __save_stack_trace+0x24/0x34
    [<ffffffc000192dcc>] create_object+0x13c/0x290
    [<ffffffc000b926f0>] kmemleak_alloc+0x80/0xbc
    [<ffffffc00018e018>] kmem_cache_alloc+0x128/0x1f8
    [<ffffffc000313d40>] avc_alloc_node+0x2c/0x1e8
    [<ffffffc000313f34>] avc_insert+0x38/0x13c
    [<ffffffc000314084>] avc_compute_av+0x4c/0x60
    [<ffffffc00031461c>] avc_has_perm_flags+0x90/0x188
    [<ffffffc000319430>] sock_has_perm+0x84/0x98
    [<ffffffc0003194e4>] selinux_socket_sendmsg+0x1c/0x28
    [<ffffffc000312f58>] security_socket_sendmsg+0x14/0x20
    [<ffffffc0009c60c4>] sock_sendmsg+0x70/0xc8
    [<ffffffc0009c8884>] SyS_sendto+0x140/0x1ec
    [<ffffffc0000853c0>] el0_svc_naked+0x34/0x38
    [<ffffffffffffffff>] 0xffffffffffffffff

Signed-off-by: Sri Krishna chowdary <schowdary@nvidia.com>
Signed-off-by: Prateek <prpatel@nvidia.com>
---
 security/selinux/avc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 635e5c1..ecfd0cd 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -30,6 +30,7 @@
 #include <linux/audit.h>
 #include <linux/ipv6.h>
 #include <net/ipv6.h>
+#include <linux/kmemleak.h>
 #include "avc.h"
 #include "avc_ss.h"
 #include "classmap.h"
@@ -573,6 +574,7 @@ static struct avc_node *avc_alloc_node(struct selinux_avc *avc)
 	if (!node)
 		goto out;
 
+	kmemleak_not_leak(node);
 	INIT_HLIST_NODE(&node->list);
 	avc_cache_stats_incr(allocations);
 
-- 
2.7.4

