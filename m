Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112D14D2BB
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836341; cv=none; b=Hjk1qnjnOKSHGbzj8XaPA4AB1yTuxmLP15aLpOc8UrS9vJrZe2KPJOqjFK0aEVzGZ3a0a+pG7oDv6ywlvM7wE4AO+pCq0ZRnZhU7M6OV6UHtrtOY4x44Dy5c0hOPPRkEJS+64nf3l7tGQcNQFyF2/FJXrqK7DM/Ftft90+iQ16o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836341; c=relaxed/simple;
	bh=ztXafw18nKBJhPnq0WpT34WGf3+j9jnaMQ0ItyuaR1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TcMA5rzynJhxhJXDwM6wJa1P4ybw29iG/3TSYVafFt8+ZL3Pvs6TCg7LYOh3LfdePAUeSHw3Y60erXkKlL9qXx8TVSKFWVrL9WoTr9OkAZnDsSOIzafI+DDNnxJbIhuk5xftnRZJriojoYPluDD3EFcbwUztEoI0Rt40VL0osM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLf7ckY2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLf7ckY2"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4678664e22fso101979981cf.2
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836337; x=1736441137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3Um5zRV/W7T37Tpj3IijsXpxgyL0XfNem9+py8wIME=;
        b=JLf7ckY2J60hK2fb/1lSB7qALvj35PCZjSMcEmRKWhwNVsVWcZ1Cg+Mok26Ll1qWkk
         7rEMtEQuaXoaF92mDRxetAiMGvMSXqz7Tru2AyeO27HwVHr7RK3lpVyBdjkxcW588Pe4
         +1DHo+lG3QG9g3fY1g2bYYXabqqeS7MOAErXXRqwO4GJqEUbmp1KqXoy/7T0uSfMlSf4
         mLXNWUw4GwhF+B2zlLAUxE1eHJ+8hIJg6mX5ZJfltHVv60MUX5jGNP6/P4jGulGUxiF6
         sDx7juWztEbKfHgpNC8HyuJIqnNaHYcVxkoHjfE8wYnSnXGXHGgOnm92IIIVpqIxOIlr
         8xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836337; x=1736441137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3Um5zRV/W7T37Tpj3IijsXpxgyL0XfNem9+py8wIME=;
        b=IBUCRWF0cty/uv4q8DSr8TR7chY6dD377b1DeKfzF69wipfV3Wa4FPWsW7zVYEuq/A
         +4M6nM9kMSlWWB0RsxVwRSezFL/JGo2MRwCLw9ygU7rt7k5rKfQowoD3R7cDLVzL9YVa
         15PC+rEDv0b1IbPaEOVKKiUzzuMlEBKlem9ojyqc6jjWgmBtovdeOP6qQPCc5Ww36JXU
         QfjeZ286aDotRjTjKBB4jL8SmSzg6PTznsUuq9Rn5qyvP23iYOSx8t0s2WW868qoNPf1
         ONC+J90hr1k5Ze37VsCZ3Vsxs8Gx6cuOrR2x5V1VVVrWtgJpLpj6D1lHTBFovsZF0qYK
         RXpQ==
X-Gm-Message-State: AOJu0Yw9UKRbPI12D7MjjHJNM6n9wOKLjokn3In6SoD/c4ZGjEaDFQk8
	X+bhbVbYiqSIqpKRvxHYHZrDiBO1tLPj72wNqjHMvDFfOlrvM1L/HV4PNA==
X-Gm-Gg: ASbGnctjIvC41VpDBqi3m7Odo01n1Pc9U69dRNM/GGfD+U/hBwsBXqOBmsm7BlAY4MJ
	tYR90uNHBu4agAFLVFJuh5SVRQSx39H7PeqeJi6gFTJB1nQyNSB+aIvsFE2LMmSRopz7+t7RKxV
	Swc+N+/+6G8wDxuCAhvb4yCvx3kxKjJnnhlB0HYj3DIdERv0WKb5lBaxv9LX/SnTzIEesoyg1lt
	OfkbxkpUKVNB5J+pz+Omgrjw84XDDrf3Jl/EaeLklcHjhZAU0PldRZTTxFCCzOkR2EiSaBSVikM
	Gqua9ymENJu31IL1AbNC495CTyfIgrx2ioo/QhxsM5ZJ0nZuMF+BbJ6o6oswFWiF2K7PlA==
X-Google-Smtp-Source: AGHT+IElheFvfvqVqxQ/CC3Qi86lpqBJQhpaiyFvzQ9/FquK3hj68UKvbV2kzYl1Yq0gqEze+hRCUg==
X-Received: by 2002:ac8:5d90:0:b0:46a:3176:f78b with SMTP id d75a77b69052e-46a4a976ef3mr861452851cf.38.1735836336566;
        Thu, 02 Jan 2025 08:45:36 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:35 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 05/44] netstate,selinux: create the selinux netlink socket per network namespace
Date: Thu,  2 Jan 2025 11:44:30 -0500
Message-Id: <20250102164509.25606-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
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
index 873c0f9fdac6..f7d23eca086e 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -192,6 +192,9 @@ struct net {
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
2.47.1

