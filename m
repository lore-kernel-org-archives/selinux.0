Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD662820A3;
	Tue, 20 May 2025 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742484; cv=none; b=QzrDWeGmHjTSP6q2JvaSYPRZ0CovTwJHaJJ6+i6HXwUx6yyp25pgHQGA1zc9eeZSyNefBKHpdusT3SX4F2AhXs6Re19d7BM53hOulRfGvFkKgteE3d4zWJ8PG7X7Dv6LoJsiu3xicxv8fna8vcqkZ5DB9dzBDs1p0R2ZP3bo22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742484; c=relaxed/simple;
	bh=60f8Y3gt1Nz3CIXxYn9V0zsVW7rbTa2SQI/yAdaAlEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fcdx9X41aylvqC2MQROHv877hfjiroM6gykADzUIfDMFpc+3rQM7ndS1+qJW2+AN4ts+8QBpSJgnzhxLNYZLOi3oO5HpCCvOkqzTVJDSZ1HjzC03tL24Drbd5DFmqsNhFKw9MrPEeKziUdmK3dQj33KIKHRFT89N/wBsVoy20wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIZ9+qWM; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIZ9+qWM"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7cd0a7b672bso367438985a.2;
        Tue, 20 May 2025 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742481; x=1748347281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utjz2jwWM6XhNRZgSBU++eEjmnRKA4bFU162NFd71dc=;
        b=MIZ9+qWM/sZPmzznLKlT4rfn3wqvc6rM+Yt9RnVx8DLj28Z9LJTGDUc+J6PSA47Esa
         qtk7zZ/PgjndyJfsq1Bd7p8bZFx7XM5GUVbGqO2NdPG2ADY0zZ9uYLVQ214fP/bpVk1V
         ef2jWNx1lq4DdVhNCuJWpDhHgtO9b1IQlJcWlVGs6bjQvMgT9wwqCGs2ADtnqvZl4Gcf
         bxsS6P3AEdYiMXO0C90punEeywFth0sr4sHeMSoEypfzKUMDfpr88jOdVJEGKzKuml1n
         BpIftTjmPB7y5XjPGYgwI5f+OFt9h95Q/CqeB/ZfdL37MJEsudcywcTvJ/C0j/7ruqbm
         j5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742481; x=1748347281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utjz2jwWM6XhNRZgSBU++eEjmnRKA4bFU162NFd71dc=;
        b=DaXqTwt+Q7R8k47xwUL4YLJ7iwyGj/kxJeWmbXo4Es+GQHQ5gpobyzbwCKPkphA47B
         6rcPLpXXEAd+XFgAvqdHuf3PhzbFprtR30tFW4cs4/pqw3gL5lyvn8YvXW++7+9MkXyk
         0I+AMf+5x9/VYoZrPZMk35UBiCFM6lNY31Q+EONUop2bMZWyh5bd8TF7rPtc7TDHB2Gw
         O08Xzt+Y8E/b29t8OViw9+xW/7MPqYc3Wtg1oFOKgI+/GpGhf62MoELVkLevqlylyiV3
         WY9FJTTNkIqm3Pl+nq/Dcmz7DEEcN9yn/9fwvFBXhDnOq1ENT/oTWBGT1wZ94rdjxfHU
         vvwg==
X-Forwarded-Encrypted: i=1; AJvYcCUExMpRRI5v7ogRAnRnytaOkmBd+WXQGUAj67Kv0lnvlv4SeZ/PWc8EOsaVwBgnlqiHD6cYkic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHfIlkecS+2LSQ8eg/lUPKSRMdcW+j0X2IApMzEmqnr4brBpkr
	ZyK3Bw8cq7Duzf3mx0iX2hpmclMX9jeLZedKetgVtH800ixR1uYlZ+Yd7dCqtg==
X-Gm-Gg: ASbGncv1GjLCBGRedlorlkEwxFpLEaTJSAMhAQH8Ce8q3ShgQe33ZHysjMgZVL7f45S
	2zh43l07peruDcVdyjDBZU0oi6quj+bqTzP1XuE8dduMvngm115djI2D5+eh1bbJZeYxcvf7+fX
	qGChIsYslAJiYscATz4cPEsKyJ4dG9xndP6ie5JAE9cDTIyNFDQw8x2oDhxEFeHgC2/ktLgyTrG
	GcI9eoRG3xZ9Bhu8HbFcD0LJsXhgrEG0L6TyPIITqXMI/A4GsL86lb3PXAZfnnozxZHBAimssuj
	DmkTDfSTaIOpokv79QeeBzg4RxkXnRthhr3ETHRkX4tkjm4vJOt7bWgwFgEheOG9U9MJdgoPHKx
	rok0mAp8SdJAPEKvnXtJtD1oHVgzybcrpf4/gKcSvxWeOQRYpwgD0FA==
X-Google-Smtp-Source: AGHT+IFuGSljSCLUnEkINaNMdciCvL+qhpL+23THRClJYFfnYFmcCr/C+QZ4JG7yiolEhH8f7FI4wQ==
X-Received: by 2002:a05:620a:394e:b0:7c5:4088:e48c with SMTP id af79cd13be357-7cd46731a86mr2389937685a.29.1747742480707;
        Tue, 20 May 2025 05:01:20 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:19 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 17/42] selinux: introduce a Kconfig option for SELinux namespaces
Date: Tue, 20 May 2025 07:59:15 -0400
Message-ID: <20250520120000.25501-19-stephen.smalley.work@gmail.com>
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
index 773d4de15803..f3e13b2d4fb5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7794,8 +7794,10 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 static void selinux_state_free(struct work_struct *work);
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 unsigned int selinux_maxns = CONFIG_SECURITY_SELINUX_MAXNS;
 unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
+#endif
 
 static atomic_t selinux_nsnum = ATOMIC_INIT(0);
 
@@ -7806,11 +7808,13 @@ int selinux_state_create(const struct cred *cred)
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
index aaf826958f30..1651354dfa23 100644
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
@@ -2281,9 +2284,11 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
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

