Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BA52EA17F;
	Fri, 20 Jun 2025 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441525; cv=none; b=gU7onhXbIS+9siPdKa8LISoDh2IzGhvAJAboALAMe05APC/jiaN/5df1mhOA0Y1F1s0+nXDOZZTi8ytZ1w3SrY45i962oDAK7fU1LoIN2bGNZ5tPyl4TJeNhyJJznBzjYZlqmN7HI6lImEnscqwOSlyZTb6UhofeV2kFDjEBYPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441525; c=relaxed/simple;
	bh=MjSRQf4W1COv4FWfijrfdQ8AL637aTSDUMMuxPmDEX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G70coSeZPAtuUHVfhr6r2wOjxnXXGytO5DPsquPkqn+i/SGd/vRerEV8RZIZLLyF9k4DRnsUjbfXCBoJm+uUu4iBUYg2nmSN+g0o4bk6gDIelt8nj8VwCryVYwddnYsKZEsuIl9JD8ObewFkjSi7H9zjLgeX4NtRfI4dI4lXI1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aC7k3v6F; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC7k3v6F"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fafaa60889so13747756d6.3;
        Fri, 20 Jun 2025 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441523; x=1751046323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jmk+ZAlQ1vOFCxkryPYE4KraaL64/vcDKofTARFzz4=;
        b=aC7k3v6Fpu10TTrJtiYgMv47wbCHmJl+Brac3/pFqHLJmC6mKYWBFQVrEeEjArv8KL
         9zB14LdZcRrFuG1hkSvj/b0JeQmZURhMJrbmfJxBJpM0H6SsBszH54C9Ls84996hxN5E
         zBQkNld9UZKT01r/Ky+o/6+++nrqXJVkLd9F01DsJPpl22szoVk2ANBE5uK6oyYRwKzR
         Xd+OHUq/xUWu7Cy7nmt5Nq4SZTACihvQ7A6xQelmcQhQYL7XAIEY7FXEBGXpOeMq7GfR
         L4PSSmP17XCJW9eSroQQ33cBKtd1Y9Vf+2HnVmnNCMJ6vtBfekGECH7OBjuIqSbkscEg
         Jorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441523; x=1751046323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jmk+ZAlQ1vOFCxkryPYE4KraaL64/vcDKofTARFzz4=;
        b=K4Q5+Db/2eGVwGQKaHA+XW4i94VPKaipPUsOPZkDzbrGFNCC5lmKW8vlIZ6TX+rp4b
         jPeiCKDwBfS216f7PhDaHPHUfiNsou3gziUWPaIdTvJXFj/DzqmfutIoTF3Gsmg/A9qG
         gXVOpg7LtBiOtuteX1rHmp5t2CPvgPUX2iN6UwyzEzs0TdoHkKzz4rEuisnLQ3sSAQuv
         JuVwYZxNt0UyR6tNQRaZ793p+tBh5MJ03LrYPO0B7p34LO3T4MBw1uuVA1Ey0BcvCvr2
         FVZBJmZ9DuuFRUHIbQYCiPsWsxA5f0sSplCSW6TQke1Lm+8X6Mk5oNWtJhx1YLZ+VAg+
         yI+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGvrPR3X94n1C0ZAoSKkrx2kYgysfsADXlq7i4WOR+fp+51axOc9IOOGjqFqaLaGWwhd7srqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6XKFvSxwgI1nvRLzOnkyRzJ6eyP+65GLWXh96NyEMVFMsK2tb
	qkxQJY6eIwadr1u76pfj/FZ1k+3hli7DBifgJo/XqVhCCPs85qJAMQ3/L7ChuA==
X-Gm-Gg: ASbGncuVwAgz1LJgFLJ5RnYyULDdUIBqu8sz4kJaMpDPvXDKYF+oZDYto3D7u9MDJAH
	qmPvp4rNvGTYnnEA88NAY9IQvk5FvFuzBqsbLuBGlgfkNYI2Oz/iExkL6jN2lMEtUnqmkjcoeCn
	ZCx+kxquJ7muT0h+H4LRltTIY+Fhanmttk3ZXPBs81iIxJOnzzdy8Myc6oxLtkXbeaQ2HSdMrs3
	aAV1431CvkEfmWEAKnGYQsPq1k+16O5NIrb70KbJzXG/NfLTfshMu32TsXH/K07hT+LprAD9u4A
	JqgCkJFbIW+BX17YYp4j1Ydk3ZfnB+kTPGEi+zvIQeQrc0xB7lX1+DVwcF3DTAVlBePTy/I9+Cn
	wZifekCFoTethbRhljkwseAX6En0LI5AepW9Hp8Or6a71skxOoFOmwE/avGuHMAhZLavxGhZqmL
	Ml
X-Google-Smtp-Source: AGHT+IFa/icoYMG9QJ1Tw5IH6rKz/y9WxnoMcyHzF02+Wc7WtYtCU3J3xosl/OvGdQOLXU78J635Tg==
X-Received: by 2002:a0c:f201:0:b0:6fa:cbe8:b873 with SMTP id 6a1803df08f44-6fd0a4ae344mr59722536d6.14.1750441522640;
        Fri, 20 Jun 2025 10:45:22 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:22 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 05/42] netstate,selinux: create the selinux netlink socket per network namespace
Date: Fri, 20 Jun 2025 13:44:17 -0400
Message-ID: <20250620174502.1838-6-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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

