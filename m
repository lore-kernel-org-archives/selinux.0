Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F15299AAB
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314652; cv=none; b=IUYtqdvahvk6U+RoCBnPPLzdUVU2EtgbAk3RZxSioWIxw9ejXJ/Y5l9w+NObKA1pRZe76XpyEYti1BrNK7QlFMSdsDtfSmVfZG4fvmgsRq9lzr8SeE+zfjCEVXriXptpBNNRpFWs2zQnupaNcLp89bqmKTOe/nAV7GlilTrTToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314652; c=relaxed/simple;
	bh=teNd89GJEnKkoFokmO7cyqPurJ6/JZNCSGyiJ/Nb3ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QDgNC9ZcXYHhCmlzMCkZhO54Jj2wqzEP4BokSqkrqkWfDqG3j2r3GJuhzPdruPTLy77mrSROJUQIeTkakCdJyb+NsqwGdf0egmjQFPakjLOUr8CW/hPwKLe+t7hwcA/0zY1EuCPcWGhc7uLFrgKv8IvrZZJQRQ4YQVk/5MwK0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itkt2akg; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itkt2akg"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-476ac73c76fso13458601cf.0
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314650; x=1747919450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asK5yayocXpgxTP/lvP9DdmgvQ59hQnp7WZi9joTqlc=;
        b=itkt2akgP+Wr2sdDesfW3kZAaFkLZOE1FklsZZkCdvxVOcDfUAtIxCAUX/H+OdnMOD
         Onpxsx8EmNrB+kg2X8cyCAVj9Fs/qUupFZjBrTcr8FjQxOTmeogD/6TR/4FnpG2ttOYy
         AXkXx7uMwgXQ+S+0rfwDOjpIDStg11DUct5sbJkuNWz79uHD2E8rgykErdrTQ/ARq4v/
         NZS0ulH9beA2+fRtxEouwu+w32V/BBH54IFaNhGVqC45iD/X74d1vLqmOky5YoUXjWiE
         nA25HJqVK1nclJR52NtJD/0t9J0iAV0a5RdwFt4K/SuIxK8YMhb8nkvAEFZS6fJRqYma
         1ItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314650; x=1747919450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asK5yayocXpgxTP/lvP9DdmgvQ59hQnp7WZi9joTqlc=;
        b=nRypbcwTmWNOKpH6XvoBa4PkEUgygIG5wExLp7wS/gDaYlvzoE/sCtD/PVZ5wlW3x+
         yQMRKcon61BWziLYBBnk+ykGw778MHoDmdWJkWv+Qn7xnMtQMGpvH31c2WLDU5k382qc
         K+dZiLJ+DZZThEc4mIXfFXGE9dUhElhQfm5+ADowsa5FNWOVnW4yz2y3qEBlkBAIYHWp
         QPvuxVrDYYUGAB929D4kS4DbwpAfBDcHGiDf+lcLNUSmJoIyW32UlSIIURAtGGukZ4wH
         N0pMGUPXymsjvXIs3Kv31iJtCGXnUOypMNYED9UuXDuFio53rIjBzrppKBHChT7kZk2B
         v9rA==
X-Gm-Message-State: AOJu0YwBtS8FhDy3NXB16EXdQ+HAs4zfxvIhFyol4BHh/frJo19lIFhv
	VBZdijNPtNvt2LljvQIWY4EWh5gp93pb+Ybei9GBO0PnaHIwIgZQsjvgSA==
X-Gm-Gg: ASbGncuOkPFe/IGJt2ZAmPO24JOipeFJgTv5dOiGNO7yBCSVjwSrnyDLxIeVm5wrEG9
	mC8lz559Asezw+hc6iN4nr0BLpDTHYLcnJRiDvolqW19BIAdOebF2TmUnJG0doa4j1N23hfofAY
	O7Pj+KPYC8OkITWOry1Rc3oSFqU76bW0pbIGHemWNMg3fZTpvOT/YiGVHVM4RBrWKlRx82G0wdX
	4cdMdl7qYbaZ0STApUTYg+cFM2f/JJg8GIZOhVcvf1chl1I6xsKX+m8k5o14f9ot/6wxPTtY0H4
	cGC7bPnuQi7vosVW1qBE0u9AhVSQE2J4Ja1M6GG94mHzwPqWPHkQ4CQA8ypEd6csl3FoOColclj
	NDk16quG+wJ6yMomPIIEiD695iOvacDjnwV6XdB7/PwuUvYsZPM4MvQ==
X-Google-Smtp-Source: AGHT+IFsyi3DYzpcgnmfcgpjUvZGr4ytH6jInAUjCAXEoi7Au8+abu+X411Uw+umDBYIBkwZewuscQ==
X-Received: by 2002:ac8:4452:0:b0:494:993d:ec2f with SMTP id d75a77b69052e-494993df080mr70086141cf.12.1747314649763;
        Thu, 15 May 2025 06:10:49 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:49 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 42/49] selinux: introduce a Kconfig option for SELinux namespaces
Date: Thu, 15 May 2025 09:09:40 -0400
Message-ID: <20250515130947.52806-43-stephen.smalley.work@gmail.com>
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
index 66882d7f678d..710815e79a81 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7822,8 +7822,10 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 static void selinux_state_free(struct work_struct *work);
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 unsigned int selinux_maxns = CONFIG_SECURITY_SELINUX_MAXNS;
 unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
+#endif
 
 static atomic_t selinux_nsnum = ATOMIC_INIT(0);
 
@@ -7835,11 +7837,13 @@ int selinux_state_create(const struct cred *cred)
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
index f15652d971c9..2ddcaea0394c 100644
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
 
@@ -329,6 +331,7 @@ static const struct file_operations sel_disable_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 static ssize_t sel_read_unshare(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
 {
@@ -531,7 +534,7 @@ static const struct file_operations sel_maxnsdepth_ops = {
 	.write		= sel_write_maxnsdepth,
 	.llseek		= generic_file_llseek,
 };
-
+#endif
 
 static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
 				   size_t count, loff_t *ppos)
@@ -2356,9 +2359,11 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
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

