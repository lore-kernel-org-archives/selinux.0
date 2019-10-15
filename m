Return-Path: <SRS0=yIcu=YI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4258EECE588
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF83218DE
	for <selinux@archiver.kernel.org>; Tue, 15 Oct 2019 13:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mFcvs1bT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731966AbfJON1N (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:27:13 -0400
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:20315 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbfJON1N (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Oct 2019 09:27:13 -0400
X-EEMSG-check-017: 22420358|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="22420358"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Oct 2019 13:27:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1571146030; x=1602682030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vq/l0TO6FeMlfrW5EHcGpISdvTr6djho/z9ycI97qrA=;
  b=mFcvs1bTV/WgP/oIyclay+/RPgW+Va+qeLtYqhww4Pm8z6VtD+43y3zo
   vsjxE2fuqhlpzZV3u73e/2q+T4XxE4lNJbM84Rz5dvtLRfzxgFE/8mQSO
   f2Q8wpEVDbAxgKtWFb+rysk4DEOHBNZ4KeWxLoTeHRJYMF13AVo1zm0yB
   5sTuGFyiORFv8Qws7oOWhE18HCxeTBAOoq5vauOZxr+u9R4VEXWnlGTWC
   INKuS4Ew+j5jpX19glXarFiODBzP5+3R8aGhzsM88bhMwt9Y8uP+ozX/u
   Vqo4QKGGREFyo9QShpc1rWIZHz8NeqQjiefV/zXK68bWE7qr4dbPv2eyu
   w==;
X-IronPort-AV: E=Sophos;i="5.67,300,1566864000"; 
   d="scan'208";a="34156706"
IronPort-PHdr: =?us-ascii?q?9a23=3AivGdYhLnydoMHz/jdtmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeKvjxwZ3uMQTl6Ol3ixeRBMOHsqkC1LGd7v6ocFdDyK7JiGoFfp1IWk?=
 =?us-ascii?q?1NouQttCtkPvS4D1bmJuXhdS0wEZcKflZk+3amLRodQ56mNBXdrXKo8DEdBA?=
 =?us-ascii?q?j0OxZrKeTpAI7SiNm82/yv95HJbAhEmTSwbalwIRi4ognctsgbipZ+J6gszR?=
 =?us-ascii?q?fEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3QqBWAzogM2?=
 =?us-ascii?q?Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VS?=
 =?us-ascii?q?ik4qx2RhDokiMHPCMn/m/RhMJ7kaZXrAuhqhF7xoLZZpyeOvhjcaPHZd4URX?=
 =?us-ascii?q?RPUNtfWSJCBY2zbYUPAOUOM+tDs4XwpEEDoQekCAWwGO/izCJDiH/s3a091u?=
 =?us-ascii?q?QsCRzI3BA+ENIWsHTbstP1P7oPX+Cw1qbIyTHDYO1W2Dzg74XIaQ0uoeqXUL?=
 =?us-ascii?q?Jsccve1UkvFwTfglWWsozqJSmZ1usKs2iF9udtU/+khW0/qwxpvzSiycghhp?=
 =?us-ascii?q?PJi44I0FzI6yp0zJgvKdGlTkNwfMSqH4FKty6AMot7WsYiQ2Z1tykk0rAGop?=
 =?us-ascii?q?u7fDQSyJQg2h7fd+SLc4iW7RLnU+acOSt4i2h/eLK+mhay6lKsyvH8V8ao0F?=
 =?us-ascii?q?ZKqTBJkt/QuXAWyxPf8M2HSvp5/ku52DaP0R7c6v1cLEwpmqfWJIQtz74tmp?=
 =?us-ascii?q?YJr0jOETH6lF/rgKOOc0Ur4Omo6+DpYrX8oZ+cMpd5ihrjPaQ1gcG/HeQ5PR?=
 =?us-ascii?q?QOX2ic4+i80qbj8lfjTLVFif02jLHVsIrGKsQDuq65HwhV35476xmlEjem1M?=
 =?us-ascii?q?8VnWEdI1JYfBKLlo3pO1bJIPDiE/izmUijkDBux/reJL3uHo3NLmTfkLfmZb?=
 =?us-ascii?q?t98FBTyA4yzdBZ+pJVBaoMIOz8WkDvrtzUFBw5PBKuw+bhFtp90pkSWWWVAq?=
 =?us-ascii?q?+WY+vutgqT6+YuJfScTJEatSy7KPU/4fPqy3gjlgwzZ66siKALZWi4E/IuGE?=
 =?us-ascii?q?CQZX7hk59VCmsRlhYvR+ztzluZWHhcYGjkDPF03S0yFI/zVdSLfYuqmrHUmX?=
 =?us-ascii?q?rqEw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DnAAAuxaVd/wHyM5BmHAEBAQEBBwEBEQEEBAEBgWkFA?=
 =?us-ascii?q?QELAYFuBSyBPwEyKpNSAQEBAQEBBosujzSBewkBAQEBAQEBAQEbGQECAQGEQ?=
 =?us-ascii?q?AKCayQ2Bw4CDAEBAQQBAQEBAQUDAQFshTmCOimCaQYnCwFGEFFXGYJjP4JTJ?=
 =?us-ascii?q?bArM4VNgy6BSIE0AYc0hFkYeIEHgRGDUIQuhgIErUqCLIIxiXGIbQwbmUGpb?=
 =?us-ascii?q?QsngVgrCAIYCCEPgydQEBSBWxcVjiolAzCBBgEBkEEBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 15 Oct 2019 13:27:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x9FDPV4K010187;
        Tue, 15 Oct 2019 09:27:01 -0400
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH 06/10] netns,selinux: create the selinux netlink socket per network namespace
Date:   Tue, 15 Oct 2019 09:25:24 -0400
Message-Id: <20191015132528.13519-7-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015132528.13519-1-sds@tycho.nsa.gov>
References: <20191015132528.13519-1-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The selinux netlink socket is used to notify userspace of changes to
the enforcing mode and policy reloads.  At present, these notifications
are always sent to the initial network namespace.  In order to support
multiple selinux namespaces, each with its own enforcing mode and
policy, we need to create and use a separate selinux netlink socket
for each network namespace.

Without this change, a policy reload in a child selinux namespace
causes a notification to be sent to processes in the init namespace
with a sequence number that may be higher than the policy sequence
number for that namespace.  As a result, userspace AVC instances in
the init namespace will then end up rejecting any further access
vector results from its own security server instance due to the
policy sequence number appearing to regress, which in turn causes
all subsequent uncached access checks to fail.  Similarly,
without this change, changing enforcing mode in the child selinux
namespace triggers a notification to all userspace AVC instances
in the init namespace that will switch their enforcing modes.

This change does alter SELinux behavior, since previously reloading
policy or changing enforcing mode in a non-init network namespace would
trigger a notification to processes in the init network namespace.
However, this behavior is not being relied upon by existing userspace
AFAICT and is arguably wrong regardless.

This change presumes that one will always unshare the network namespace
when unsharing a new selinux namespace (the reverse is not required).
Otherwise, the same inconsistencies could arise between the notifications
and the relevant policy.  At present, nothing enforces this guarantee
at the kernel level; it is left up to userspace (e.g. container runtimes).
It is an open question as to whether this is a good idea or whether
unsharing of the selinux namespace should automatically unshare the network
namespace.  However, keeping them separate is consistent with the handling
of the mount namespace currently, which also should be unshared so that
a private selinuxfs mount can be created.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 include/net/net_namespace.h |  3 +++
 security/selinux/netlink.c  | 31 +++++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index f8712bbeb2e0..df0737725454 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -172,6 +172,9 @@ struct net {
 #endif
 	struct sock		*diag_nlsk;
 	atomic_t		fnhe_genid;
+#if IS_ENABLED(CONFIG_SECURITY_SELINUX)
+	struct sock		*selnl;
+#endif
 } __randomize_layout;
 
 #include <linux/seq_file_net.h>
diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 621e2e9cd6a1..03678a76f4bb 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -19,8 +19,6 @@
 
 #include "security.h"
 
-static struct sock *selnl;
-
 static int selnl_msglen(int msgtype)
 {
 	int ret = 0;
@@ -66,6 +64,7 @@ static void selnl_add_payload(struct nlmsghdr *nlh, int len, int msgtype, void *
 
 static void selnl_notify(int msgtype, void *data)
 {
+	struct sock *selnl = current->nsproxy->net_ns->selnl;
 	int len;
 	sk_buff_data_t tmp;
 	struct sk_buff *skb;
@@ -105,16 +104,36 @@ void selnl_notify_policyload(u32 seqno)
 	selnl_notify(SELNL_MSG_POLICYLOAD, &seqno);
 }
 
-static int __init selnl_init(void)
+static int __net_init selnl_net_init(struct net *net)
 {
+	struct sock *sk;
 	struct netlink_kernel_cfg cfg = {
 		.groups	= SELNLGRP_MAX,
 		.flags	= NL_CFG_F_NONROOT_RECV,
 	};
 
-	selnl = netlink_kernel_create(&init_net, NETLINK_SELINUX, &cfg);
-	if (selnl == NULL)
-		panic("SELinux:  Cannot create netlink socket.");
+	sk = netlink_kernel_create(net, NETLINK_SELINUX, &cfg);
+	if (!sk)
+		return -ENOMEM;
+	net->selnl = sk;
+	return 0;
+}
+
+static void __net_exit selnl_net_exit(struct net *net)
+{
+	netlink_kernel_release(net->selnl);
+	net->selnl = NULL;
+}
+
+static struct pernet_operations selnl_net_ops = {
+	.init = selnl_net_init,
+	.exit = selnl_net_exit,
+};
+
+static int __init selnl_init(void)
+{
+	if (register_pernet_subsys(&selnl_net_ops))
+		panic("Could not register selinux netlink operations\n");
 	return 0;
 }
 
-- 
2.21.0

