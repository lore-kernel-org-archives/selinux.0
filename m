Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12681245031;
	Tue, 10 Jun 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576188; cv=none; b=kSlTZpUCTj89jaA3HTZk7pojenOIOrXxxeodSjH5yKmGxADv0fjW79Lw09kHNaFXpmT6PATAMkwp7a8Q1pBmiKPDliAkTEOJRUIsAJdvqtmsKAApbf8AnTC2xo8nwN9JtBoEFNIJt1Xr01xENzZ1+prtlfz2JtnKWWYmqybbEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576188; c=relaxed/simple;
	bh=MjSRQf4W1COv4FWfijrfdQ8AL637aTSDUMMuxPmDEX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRUR8axBgSDiCPH3YiSZQIbpjYWiREWfn2ii5nWW+zkLaLZwpLZQ8nL9PbF8rO49+m2BmKbXBXub9Q3jeRUx9HZ3Ffgmke3DyWS0vDe3CboVOOCb3mI1f8+NwtIH+F0niXigOjM5o0cSyLIXVDMjFqwcxS4KzH4QnJ0nHBf8NC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/xTWfd4; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/xTWfd4"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d09a032914so466104385a.3;
        Tue, 10 Jun 2025 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576186; x=1750180986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jmk+ZAlQ1vOFCxkryPYE4KraaL64/vcDKofTARFzz4=;
        b=i/xTWfd4vZlBJ4f95R0fGOOClImeg+HGoouP4CBxMHoENaF5oUN6vkMlYsa9xaOusR
         jzpBgcnzxcnw0Wvc2+wupWGyqy2asNScTvRvYCDd+vsf+fKPNSzFsfiWKmD+oUh+HVJd
         DI+frRoJ4VOEh7Sv6IVypUlGEfP+UizC34o0/VrczpYhlzzet0PrTosB+BW/oevoJieY
         fLeqyoFVzsgLATLVm8O993E4f6f7GAAyjW0tazgFjtR1OUpOH8vvfrkrXyRLtbiVkHid
         ipP9qx2Iz1zZQJcLEv9Hf5yqtFLAfaqdPDfkXrQWv0lO6Di6nwAStK8LcKIcJBJccasw
         2TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576186; x=1750180986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jmk+ZAlQ1vOFCxkryPYE4KraaL64/vcDKofTARFzz4=;
        b=oRxHBhN7UtVI4Rv+7y9wm5YPPoLLdSp1x69n2WcbI2mtCf4HveJdxtNt2SRgtJUe3X
         zCpXT8EBHFSydNO2pabmt9U8U/NI26w9i30UOnTi8qGMcbSFuNavT0Bwe1zK40OKbW6n
         Oq8Ll/JCtakfFxDF52NRxKmDoKYL0yiZM6uTIx0wcVyY+7WXkYRf/55f4f9kSctVfLPC
         gSqh+p6+f8p773B3QHvOOML1ZwI0Gl/ugzZVhEZet9f4Ak4NCy/unJWX/OftQYX8xqhT
         UJLMx2E1bqWXEFYnh9VuOY7C2jYSFTPRSoLvZmBzIrlCEbI5ygSyEcKmhScAKbetTz/V
         dz4w==
X-Forwarded-Encrypted: i=1; AJvYcCUbK21RmbL8R4N4CGOoXflOI/yTw1P/0ViY8D4eJi1Go3ErXmX5F69N1PUwV8dHonv9H5+7YS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Awrahi+faGNxUNLB+ecVvasAwzQugop4e7lafBBw7prsDYmk
	WXz1hTQD90Y0skwnsr5OBWxosjQ+zd43trzed46kqWsVdjaJbext4MCRCcU49w==
X-Gm-Gg: ASbGncs876sVUtt1a6zjeF0xGDx/HI5CXU7rxEx9KIe2/pjYdwY41l6YZzu6CH2LM1Y
	pOHVGHv3N0+HVBpSWlLwFejCiSk0kHw53WrqqfDH3XIh3lfh2AukyUxjYMhYfM/k1eE3fGnqwgv
	mVwlkwuiN++H0nUNR6XNWkF8xbcpuz2wWzuUOjy4nfnZtEgeRf5wV2SsXo9w/WITA6WhBP+AdaG
	EQ3RN1tZH8cWA1ExADSv1oXTrE+WT173ygdd0Nd4Pbt5zK1Zni6ezk8buW0x4VAZUxkaNtu+6oZ
	YxO5frNkRUf4PICPP8CnkYkZQ4MOsyld9KOxiTxFCYlcZjkMZrG0lqhtx11+yxFgutf1P6YxGIN
	ot8L1DofISwqqoX0bmb7/5vMqklg2tDOYitKmcbYTV9ganOjhmPP+xeAzkSZ56b5OCA==
X-Google-Smtp-Source: AGHT+IHo/F0SQy3PuXOhvxcGJnSN9nYwk6u4/EfRpcZqdOg81QhiZYmaAZ0mDQL1m1S6RXqyr4HUeA==
X-Received: by 2002:a05:620a:470c:b0:7d0:9782:9b05 with SMTP id af79cd13be357-7d3a884dc18mr32110585a.25.1749576185534;
        Tue, 10 Jun 2025 10:23:05 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:05 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 05/42] netstate,selinux: create the selinux netlink socket per network namespace
Date: Tue, 10 Jun 2025 13:21:36 -0400
Message-ID: <20250610172226.1470741-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 include/net/net_namespace.h |  3 +++
 security/selinux/netlink.c  | 31 +++++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 025a7574b275..06f2501ad9a9 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -196,6 +196,9 @@ struct net {
 	/* Move to a better place when the config guard is removed. */
 	struct mutex		rtnl_mutex;
 #endif
+#if IS_ENABLED(CONFIG_SECURITY_SELINUX)
+	struct sock		*selnl;
+#endif
 } __randomize_layout;
 
 #include <linux/seq_file_net.h>
diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 1760aee712fd..03678a76f4bb 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -19,8 +19,6 @@
 
 #include "security.h"
 
-static struct sock *selnl __ro_after_init;
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
2.49.0

