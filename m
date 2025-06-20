Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0D2EA737;
	Fri, 20 Jun 2025 17:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441540; cv=none; b=jDAmTDODXefFAg06n/hWYlT6nTJpfJXpTa3e4xgd5afmal2GLAoaz2ZuakmfndCM1GofWkpIreqCtPY1bmfwZXgjHDjqqI0MEqhdsNQ3E31Y/8wgg8y9qPKUsmwPYGiidJoWnz1DAOfOpcobAFm6KIw7RwzY7fTx7ui1InOIpe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441540; c=relaxed/simple;
	bh=Jpxor6M5jT0Ibk/AI5YwzlNQqnebG3yOj6sfwU9RJa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQwINrqBrzOdzZ5n82BUUhjd/BeFPjrljn1WgvwtsROWk3Qtcr1SlVmh6zm0occTgqlZt71/IaJAio+/P3gHnfQFXVq8JT8VtqCmF6+FKE+t0b45CbX8PEBMvcwY76qGnT0tWTV4Hcw1uRrA4j6H1KZHAfY1uK1x8s8OS9rHRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0u6U7OS; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0u6U7OS"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad4e6d949so11298996d6.0;
        Fri, 20 Jun 2025 10:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441534; x=1751046334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7W6Knx8qgqchPV7qE0a5SfwNFvxDsFQk8ytOpIIRccw=;
        b=Z0u6U7OSK2azfw7jGsSxMxtBkJZrH7fkfe1adcJdZ2o94HUzHBgPRgHA4pAZby07lY
         HxZOj7k+GlWO4SF6shg9dA6oRvIRTVLCWqIhKuM8PsyXLXGqMHiCxNbtPkAjfrLpDysl
         z5RXeNSRmyz4cgMiSciIy2vo0GZNn3WatpZ9nWZ0g2aCsikVbk0JwOv6mFbkOsjvRgpT
         hwd7Jyjlhk67GOyuUidhwU6Fn1bDgv1gPBZSXPyA/Kv2VXVRXjhUItfuiBXA8I0hQjgK
         5CQIm0yw3NDoUcpjGtQs2RSSX/sZ43sRn/tUv2o5M7QKRSb+meKYfyUCTVAiLgDoYJtD
         5zyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441534; x=1751046334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7W6Knx8qgqchPV7qE0a5SfwNFvxDsFQk8ytOpIIRccw=;
        b=DurF5+Uq/sj3UTjgfUU4E1UwGUSV7qu/vniUTvc1itmc4eGzfMXHN2dsGeUzUVnVWr
         cG9Btw1+VQqOpDI8gV5l5pNJoE4VjIPjm0PwXYjixbqHylJa75fapTUEZRVWndDBlza4
         ygox+RmOCBthrBoZgXrjAzJvg4W6ML+7ISUcqcVXiKU8oRVybBcNXlRb8tLE+dibFCP9
         8RVXahklSsdKEzjRwAY//Y9LnYJP5Js+TXjnQRvq0vNxH1R56GB2wXIFcVcQBEDNOvkB
         zgFRNn1D1cq2fP3qxgcH7VPhCwyK0M0Bxg9uBLpMshJw7AkfmoLjrUar3hedchfhznx/
         nEuA==
X-Forwarded-Encrypted: i=1; AJvYcCVMOwsAVqSfccso0YWT9IVyLi0mia6U3tmIQvHd7OlvWlIG9oy38irtkIJwL8/FxVNFIpkTBpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/FYn6QSCh+dg6CzCPdGInAHsuZcfMKuIFs4oht3C9vsFvstU
	oC0OjVoHQdUFATCAXMu4in0pQGsgVnpmfWSFMZ5GF83CE4XMDZH5BgcBGbkaRg==
X-Gm-Gg: ASbGncuCrJGsxC34joOF5IPNNxAPzp9RSfBBVAjFceILXQUn5+NcV08UOuvxPKe38oG
	2/ukvhpgMkYZPPlc+Wu5I86MsVs8pm3N/0mhZ4gMi2yZSS2LI5GzE1PIADh/i/tDBpjza2KS97S
	7d6DDNe2KITHKmg9pYiT3SXKCX71QI5ftQZFQupa2z4f7iIBVz54mJY0/KALt1oumb7OnxWV/dL
	nWFLMrMuWJ3ka+ZRgFKB1Jm97WonRI61W/A7n6lO/v3Zub34WQYt5xBeeEty1sgfBAq+PX0NqXe
	jeiNipjs9h5ojLDNvKYN2J6IeXbuAKIsQHPydJILDKPsSYP8bU3gfWsl/vNGnLSjZtW1wDKdTAT
	7c6Eqts8sTo7HBP1laPQfcG5gSkx6NLqejIJ9nNAsrvUwX1Kr8PR+GGQKI1yE7Tn/IQ==
X-Google-Smtp-Source: AGHT+IHFUL5Lk73aXRILEoA+wvPehK5pjyh7I1afY7aC4A/rjoQEr5lltCcvplJCBKneRPrlajnpPg==
X-Received: by 2002:a05:6214:21aa:b0:6fa:cb9b:a793 with SMTP id 6a1803df08f44-6fd0a5338e0mr54042936d6.26.1750441534138;
        Fri, 20 Jun 2025 10:45:34 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:33 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 18/42] selinux: introduce a Kconfig option for SELinux namespaces
Date: Fri, 20 Jun 2025 13:44:30 -0400
Message-ID: <20250620174502.1838-19-stephen.smalley.work@gmail.com>
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

Introduce a separate SECURITY_SELINUX_NS Kconfig option for enabling
SELinux namespaces and have it default to n since it is experimental.
Make the SECURITY_SELINUX_MAXNS and SECURITY_SELINUX_MAXNSDEPTH Kconfig
options depend on this new option.

This option only controls whether the SELinux namespace support is
exposed to userspace, not the underlying infrastructure support.
When set to n, the kernel APIs for unsharing the SELinux namespace
(/sys/fs/selinux/unshare) and for setting limits on SELinux namespaces
(/sys/fs/selinux/{maxns,maxnsdepth}) are not created and only a
single initial SELinux namespace is created during startup and
associated with all tasks. When set to y, the kernel APIs are created
and userspace can use them (if permitted by policy and constrained by
the limits) to unshare the SELinux namespace.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/Kconfig     | 42 +++++++++++++++++++++++++++++++++---
 security/selinux/hooks.c     |  4 ++++
 security/selinux/selinuxfs.c |  7 +++++-
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 82db54462253..aa25da389c46 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -88,10 +88,46 @@ config SECURITY_SELINUX_DEBUG
 		echo -n 'file "security/selinux/*" +p' > \
 			/proc/dynamic_debug/control
 
+config SECURITY_SELINUX_NS
+	bool "SELinux namespace support (experimental)"
+	depends on SECURITY_SELINUX
+	default n
+	help
+	  This enables (experimental) support for SELinux namespaces,
+	  i.e the ability to create multiple SELinux namespaces where
+	  each namespace has its own independent enforcing mode,
+	  AVC, and policy, accessible through its own independent
+	  selinuxfs instance. When a task unshares its SELinux namespace,
+	  it is associated with a new child namespace whose initial
+	  state is permissive with no policy loaded, and the task is assigned
+	  a separate SID in the new namespace, initially the kernel SID,
+	  which is likewise independent of its SID in ancestor namespaces.
+	  Subsequent actions by the task and its descendants are checked
+	  against the new namespace and all ancestor namespaces, using the
+	  SID it has in each namespace for that namespace's checks. Objects
+	  like inodes only have a single SID irrespective of the namespace
+	  in which they are created or accessed. If the context associated
+	  with a SID is not defined in a namespace, then it is treated as
+	  the unlabeled SID for access checking purposes in that namespace.
+	  The current kernel API for unsharing the SELinux namespace is to
+	  write a "1" to /sys/fs/selinux/unshare; this is likely to change
+	  before upstreaming. Experimental patches for libselinux and
+	  systemd to use this support can be found in the selinuxns
+	  branches of https://github.com/stephensmalley/selinux, which
+	  provides a selinux_unshare() API that wraps the kernel interface,
+	  and https://github.com/stephensmalley/systemd, which has
+	  a modified systemd-nspawn that uses this API when called
+	  with --selinux-namespace and a modified systemd to perform
+	  SELinux initialization when started within a container that
+	  has its own SELinux namespace. Userspace can also detect
+	  whether it is running in a non-init SELinux namespace by
+	  reading /sys/fs/selinux/unshare ("1" means it has been unshared,
+	  "0" means it has not) but an API for this might not be retained.
+
 config SECURITY_SELINUX_MAXNS
 	int "SELinux default maximum number of namespaces"
-	depends on SECURITY_SELINUX
-	range 0 65535
+	depends on SECURITY_SELINUX_NS
+	range 1 65535
 	default 65535
 	help
 	  This option sets the default maximum number of SELinux namespaces.
@@ -99,7 +135,7 @@ config SECURITY_SELINUX_MAXNS
 
 config SECURITY_SELINUX_MAXNSDEPTH
 	int "SELinux default maximum depth of namespaces"
-	depends on SECURITY_SELINUX
+	depends on SECURITY_SELINUX_NS
 	range 0 32
 	default 32
 	help
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 33146fb9a88b..c807c560f04c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7776,8 +7776,10 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 static void selinux_state_free(struct work_struct *work);
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 unsigned int selinux_maxns = CONFIG_SECURITY_SELINUX_MAXNS;
 unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
+#endif
 
 static atomic_t selinux_nsnum = ATOMIC_INIT(0);
 
@@ -7788,11 +7790,13 @@ int selinux_state_create(const struct cred *cred)
 	struct selinux_state *newstate;
 	int rc;
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 	if (parent && atomic_read(&selinux_nsnum) >= selinux_maxns)
 		return -ENOSPC;
 
 	if (parent && parent->depth >= selinux_maxnsdepth)
 		return -ENOSPC;
+#endif
 
 	newstate = kzalloc(sizeof(*newstate), GFP_KERNEL);
 	if (!newstate)
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 19cd4cc4c01a..158994a1dcb3 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -65,9 +65,11 @@ enum sel_inos {
 	SEL_STATUS,	/* export current status using mmap() */
 	SEL_POLICY,	/* allow userspace to read the in kernel policy */
 	SEL_VALIDATE_TRANS, /* compute validatetrans decision */
+#ifdef CONFIG_SECURITY_SELINUX_NS
 	SEL_UNSHARE,	    /* unshare selinux namespace */
 	SEL_MAXNS,	    /* maximum number of SELinux namespaces */
 	SEL_MAXNSDEPTH,	    /* maximum depth of SELinux namespaces */
+#endif
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -325,6 +327,7 @@ static const struct file_operations sel_disable_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 static ssize_t sel_read_unshare(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
 {
@@ -523,7 +526,7 @@ static const struct file_operations sel_maxnsdepth_ops = {
 	.write		= sel_write_maxnsdepth,
 	.llseek		= generic_file_llseek,
 };
-
+#endif
 
 static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
 				   size_t count, loff_t *ppos)
@@ -2282,9 +2285,11 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
+#ifdef CONFIG_SECURITY_SELINUX_NS
 		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0600},
 		[SEL_MAXNS] = {"maxns", &sel_maxns_ops, 0600},
 		[SEL_MAXNSDEPTH] = {"maxnsdepth", &sel_maxnsdepth_ops, 0600},
+#endif
 		/* last one */ {"", NULL, 0}
 	};
 
-- 
2.49.0

