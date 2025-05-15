Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59AD298C12
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314625; cv=none; b=rpoyXmM+MdKsKEgfvOshU/KG11HRb5BT++nl0dQKaf3h3b5xnj85kmuJ5snIUiJlmhzqhAy81vFwtSX4aqIhxt0CG8Ek64NdCmP0xgwZ4p5xaX9rn0ExOjbGQmEY4ZMA6GHBaOa8ALDAh96AtchBSVD5/Dx2nBpidpixTgGu6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314625; c=relaxed/simple;
	bh=z7P5jwjln5ArorXdtascTzDFuH8o9nfqU2Z0ypqk7Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXWGi6wJ+N9u0YyCny7uF9p84t9vc8QvtFvAFkfMiiQ4dA+pJr2MapdJybym6Cbi+F+F4fO1CEUfNDtvfrM+oyAvnIpvzwBqcKfT7Ee4qK5eRWAmDRGocScYBrpC5zykBDEk+z3Sgq38YzOGP389zmOQtzX8lBMfRu9sYYSVQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iax90AJA; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iax90AJA"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47698757053so12507981cf.0
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314622; x=1747919422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMrJ8/oSn1yApWIOAqQgQyWyP+U/PHKy/9q2nKb9Ov8=;
        b=iax90AJAWrw0CHbDq8Zs84/piVBz/tZ2MJtehEkUhBF2yZ5z4s0BpzKBKw/tB/J8fP
         Jl+36GtXrpLNSUA62HWNBFQqDTSEyRRGSPzOKazljtBXVuzVGQBA0Q40T3ePIQz09pIH
         Wx0H+jQh0FB1dqJuLZJimFiySCYz06Oh/KRn4V1yvpNDToJ5glO0E5ykBF0kugTudJhF
         gJXWRYnFKfVyYsN9wRRRAtBbkqVqMdK1yzm2XFVgTRsoYdKPwY5zqbtUIe5Byg4mO6Bs
         hQHG49jJ+J4++1PWvLbUbFoSuSD/lU5ZHy56pSjxM6npFv7y/mI+/o0ijpBGc2WoJPqz
         13cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314622; x=1747919422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMrJ8/oSn1yApWIOAqQgQyWyP+U/PHKy/9q2nKb9Ov8=;
        b=Y5U93A78YKJ/cPIBvVlSPkUKMjhWJgfOumaffL9Rva311oSYpCyofLaUgLMR2qkTGe
         b3oQOb/cbm2/nHKWg1WuZJXEQ488SkrXw/nSvKKIR4ffX2ITOanHC1cXClm/A8FAdNpW
         WYMdYun2yhQM584TDDX9hsuAyOdzKLxjE4NYLZ8gO169zPt34TCjzCHXBrKSaEwxuKC7
         AC0xjQa7h3HhvzlvfH+034g5EXnh6BeI6nUWN5Tb8XnGK7q5ii3tJ7bwCViofKwYueZj
         q4diARFabsEveAu3GY+xn6MWc/Z9SDdKw9yUbCu70kV7qKCcoQJNIuHeEu4iVg45MHg2
         Ak1A==
X-Gm-Message-State: AOJu0YzhFdsIM83ILLEAaQ+ROiOGBsa+jhyf3ehDOAvjuPgeDAUyn+nq
	JDHPobpiRqO/z25pc922HpHauAYPwDLNHCECmaC8wearfsmpa/jh5f2fJg==
X-Gm-Gg: ASbGncvd6JEB6Gl8wRrVraKV3ylNQRa9UrzS+kA+9FF/pVWHsQf+vxOtwCGkSWxZ4NT
	h95se6l7Z1EPEbF43PXXSmjEQKwKQalpJpqzCzEXwT49Vmu6/CFQT3Wkul3uTsgx3F3aPaquqBD
	yj2y8rm61Sqi1nZRJ2nvF4a5XTvLIHkeCrJ7M/a96tBv8bAdIjnEsykXWvMPZHBDZzrKhlY+Zfs
	5usLxmWLes+m3LR5+0pT2fI1Lsi4Dn2/oosRg58NPF7GW1blclm1PEhmo0pqDlFhQplDTcIoOVp
	aGKU4QQ9/6rUUXSsLDkYUfWsnGvPlzCzjPFTNcRboiGXZr6VdVdv1qLNfMztzXedf9ae3XgMHJy
	C3k+E0liNbNOHCFzVPuLvNVZLxm0aXjCL6CQUaTiYHi8EhEWQ8yDHTQ==
X-Google-Smtp-Source: AGHT+IFbrd2dWRma+ioBo9ACkb3r/BHIGhgi+6ROgBhkDBW99XjeAWuw5ZjBPivvrR9E9OvD5rrycw==
X-Received: by 2002:a05:622a:40c8:b0:477:887f:29ce with SMTP id d75a77b69052e-49495c61e1fmr120105611cf.5.1747314622439;
        Thu, 15 May 2025 06:10:22 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:22 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 05/49] netstate,selinux: create the selinux netlink socket per network namespace
Date: Thu, 15 May 2025 09:09:03 -0400
Message-ID: <20250515130947.52806-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
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

