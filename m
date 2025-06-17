Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BBD215787;
	Tue, 17 Jun 2025 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169173; cv=none; b=cy2purtT5zcr5lpwJaMmG5aVRJKV1bdB7Zz/GGTVvhG1qbXvn+MJgQ1+oMLh8Io5mwLX6B/bVV+2nA7MjZrkbr9lRGOlE2B+P6vtotVw3tk1OQePEwIsjqF66oMYQiD6LuOBvM050b7x9JBZeNHWW4ZVDeoHxeyphQG2zrupe2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169173; c=relaxed/simple;
	bh=MjSRQf4W1COv4FWfijrfdQ8AL637aTSDUMMuxPmDEX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9Dau2loIyVnlKNOhRkkvvM0qXPbuMOubfMCaP+VWJ+qKWxNz8GPq9feJRlMfeE5+pnYG/4uTOS98t57Wg03wsXVZ8c18umtOHL50hPnQ76PifbN6nlx5Ybrzh9ReUTrQ4xYAZI6WPpAtiLtgPyNKeMsTToxxks9CcXSSRSJn5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHh7FBfQ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHh7FBfQ"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d3cc0017fdso344434785a.3;
        Tue, 17 Jun 2025 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169170; x=1750773970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jmk+ZAlQ1vOFCxkryPYE4KraaL64/vcDKofTARFzz4=;
        b=EHh7FBfQomOFYPTFYorlOqxId9w95KGtJ9oB4ceQrH3ouLp8mHRSS+03aWqYzM9SeI
         8criTBmwRRnQ0ZO5CYGMfpEXkN8x3iHpfOF5g6T64KYYCMdr3BTh3WwcJ66gg2T2SDot
         khHBkucKPEnxAnoDxG0v/qDN11WzhQ4qdGt9bLkJSACN0eUZEVnTXVmh7wYXS3iTsoqV
         NURYacfu6RTVwgtYUkzG4BBNycMjcudoLpUvKWBwF1/gyy/YLeD/8Aw93KkOFKEiU6mM
         RiRoiQLrRX9PautQeZ4ge60HAOfgh3emoE7FdEck+gbTGRplLtFSYYdAyK79wWLhKi+3
         Outw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169170; x=1750773970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jmk+ZAlQ1vOFCxkryPYE4KraaL64/vcDKofTARFzz4=;
        b=wq+U24Me1DiHE4tg+HwfThkec+yHHkmZpM8UG5yAuugtuw2jCq38VIFChcKf+5sTlV
         UZrUyjJT09hB8Us4zV4xBNccHXy7a9ZhKE7jwCK3lTncqyRkvaob2IbAaNTQeZtMuzx8
         X++QpA3qDmsl2VaJjaGHRM/X6MixHCnIqI/HvB5ZXMB2lc5k1MjMR/cOMrmmcjOpmonf
         i5uQpD2/qG8GYtZ1a1Za3qA3k0kPnfw27NFxotf6vMy3sHYO87rS+V0iU7SXmv8U4kcb
         Xi3Fnp5MxWfqui1CPOwHqVBvYg+L8iSh3421umCOGxp+d9EilQ7kpNzpoLBh5Oy0DSCY
         MTUw==
X-Forwarded-Encrypted: i=1; AJvYcCUzxlVYixi4idioMamXhwx6n+DkHkifVYoUkBqeFyzuorgSZ09XiYRgSP1ikrwhwPRqZ7nvVH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfw0vI5/TyMY1rriGgHZUbBwVCQBCUoxI6jhqocUxN9jAMLBK
	jR43ur+u84q0S92IKw4aRmf1qURMtKxUDnfjCjfEcACgmSBhMGour8JwJ47aKQ==
X-Gm-Gg: ASbGncthcZQUpkwlI/vWpNbREIOPT/hsvPs/OHpPvjzZi482ZD35Hdy7B2YHCLB1VZj
	9l0/agxVK5csUFrQVm9xKmcXQj7oqaz6nJPIFY438z553EJOyRiqpKKaBIRSOwf9yUjZbBbUIos
	qvffKc33iQbOPhzWIHSo5ntEi07juzcHah33EJEUBxIWJp2KgFPRHgwc4TXydftnICow182ITB1
	V+HAR0wLWU/Nh+Jr0im61k+CHx/8MZrxVJcYyouv7Wh0mfyUq55qBq7ncuamzKi7DPnjgTZ2uKu
	mlusF4WKwGcpE+8tIGfTGJavvQ7nbs2qAGO9GqABDl38vu0F0HZCREF3dxGhAx5cImZ0gskEWWO
	Ew1FrPTTxulp8OQPaax+A6gIIfI+5LXEIuxxXKSWplt2afG6zF5bHES2yBM+ZO/hLHQ==
X-Google-Smtp-Source: AGHT+IGy1z8bqymna9kQgiF8QDFQg1du3Q4vIQnXUvlUbWNwXWlJQFXOKh3SOtXPzBc41+RWV0lT5A==
X-Received: by 2002:a05:620a:40cb:b0:7d3:9203:206c with SMTP id af79cd13be357-7d3c6c0c77emr1905888485a.9.1750169170348;
        Tue, 17 Jun 2025 07:06:10 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 05/42] netstate,selinux: create the selinux netlink socket per network namespace
Date: Tue, 17 Jun 2025 10:04:52 -0400
Message-ID: <20250617140531.2036-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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

