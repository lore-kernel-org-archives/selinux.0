Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C77127FB03;
	Tue, 20 May 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742468; cv=none; b=uzv5vAfJ3Xw/p8dgmM5p1ihPwhZvogqg8JyZp+VRQ/DvifaXmGGMOhWqFudApYBIueu777XwMAG1iP2pun4JIFV6mdgjmMUEltuWPhdoA8gnvKoix282Osr0SGta0u34eFeawX++5adMQ8fLX1r9tXz6ScUxDkzzaTDu0QLYEag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742468; c=relaxed/simple;
	bh=2UaiaJfht3Bix45RaDPsDkdAXNHT9kOZ7OSCjHs4tdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bv4gYkYdFH5lcYVCutqAjLl06wxwSC4YE2w2e+PGE4+/uR7NN7m4WPUGmGRXcn3GmClerRObgenMBnPfbLZz4k33tn6Eu6juqvgn5uwgJeWIYriTeK27QqVcBuJrwd8XsqQbxPoRjMq40tyXaqsWADtmBYvelsX0uQqg0O1VwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrH3/QcV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrH3/QcV"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c597760323so625491585a.3;
        Tue, 20 May 2025 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742465; x=1748347265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MglPldXg1b3ggt8/SxS//1h/Pgz/z0VFCnNVNFl0e64=;
        b=SrH3/QcVn1+GbL6hvevVobhtLxwvFMURlMaM5nmh+rcxD/0G9Yn6IaTPafMScTzDxj
         Ew5yHX0ZqhgUN3wypWeBXHn0/ZE+VrJGrnw267ehUjHDVAafYPUVrxTaSB5qzMveR0jk
         eOdyN+3wXHAn65wlhIaVKbGBNjnMM3QG3R8MghzKf22kVl4z/pksl4x3h1GoeAZH/Ej0
         qPfo5K0EjkAU+75YXfmNmWMYs/gz3EnvHdld2PSD5NKBUlMjYJTirs7VuqPc9BKZ2Zp1
         ZBBqjyi1Vf4d6e9zJLXi8/cfqbU0hte5y6/CivFg+eqm6c+Xyb+9ftFP4rHKtni8vQoN
         UD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742465; x=1748347265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MglPldXg1b3ggt8/SxS//1h/Pgz/z0VFCnNVNFl0e64=;
        b=t9C/WXS0QORQHre80m6uNqShljt3mbVsCQFxbYm+2iubquL8kYj6CRJnurfCI5Xz2i
         8H3qx93yyLu4VY5LpoSpfRdn9XMhNwJom9PblK6znxdPAeoyAKQkGDeGwG2WFdq/VpLV
         wEVkKIbJp9iNUUT8syyOLZ5Za4RJtITvxnGu5Oj2GIiCFcAA/IMDpbsTIw6aPEOb6PQo
         O3ds1SknuwV3CJ3iLwJoTxws6ASq/ZlgvoJGZWK4LeGniK4GlmWTNmdFRkn7qKOvNHbm
         dMM6d/7nOUa6L3J0Dzi3da/1iSnIPUmfZRe2ap6EeKKlo/JF2Ao/KoQLDC7EkxCKSEPd
         aY7A==
X-Forwarded-Encrypted: i=1; AJvYcCWodilwQM2KjbJ+b4yhUKFmFBarW2q8gdAGlxF7a2UcL4rdf+q4oOPeQJXCBTFn3tPjtUWMgqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw071udWJbFFCEDPdMsQeBuq9Mar9hGZN0/7b6cm7RzqY2s84T+
	Ggrj4CKR+xdP9J56UuqTE0QELIEAwzqBniAiYiY7LHYipAiKAQixsLYtE2J6Tg==
X-Gm-Gg: ASbGncsUriWR7LlaavYaidKBJp5MkJZGfd2Mpp7qdUWyX3FSi7sn3evwXEa40EmwSVf
	jsXbL5imnStKs2VxGIKcntLcmyaJZvzet4+blqzcs7qoxOxSFIwEGobaFx5S47Dq6qiuodFW7Xa
	G+R1JsalTXX5DKeza3FnQu14478eZ0N0pCG2eZQTupQJfXAelrpE2y/H+xaPSvHNlBtWxh/mBZd
	EnkmKR4QzG6+NmuteO1pNW6GKfg/E+evyuHt4GY7IONYw1u5jXjzPu/5zixcbz8JM5Jju64pliK
	Y5kZ3KaB39omoh2W5UX3ZSoso2W3vzA/lSaTIR+d3Eh3oXDRX6Q7JlcEcan2YSfm8Vo8FvUDinE
	kejXh1aITsepqie8No+PBHIPXvfMrFScne1YMEu2mGRGNNw20gXrusw==
X-Google-Smtp-Source: AGHT+IGTQaLOGBRag+lfGaMowA2CKpbHwWGbk7AWdYgHnnqDpJzMnXKtpadD62YOSlRYFpBgP67mjg==
X-Received: by 2002:a05:620a:44cf:b0:7c5:95e6:ce1d with SMTP id af79cd13be357-7cd4608ea23mr2432081985a.0.1747742465141;
        Tue, 20 May 2025 05:01:05 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:04 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 05/42] netstate,selinux: create the selinux netlink socket per network namespace
Date: Tue, 20 May 2025 07:59:03 -0400
Message-ID: <20250520120000.25501-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index bd57d8fb54f1..e9c7db604b8b 100644
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

