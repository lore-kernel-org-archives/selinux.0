Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D615B554
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836368; cv=none; b=tUntjFenJKbfVR+PsOm3boNdAP+2nMeIMttdNB5l8dqqduBi+8GWL9jQM/c9GaXoXUqRsUHFMGsVEqIQ2VzjFZU4V5nYdwc+5wcXwBf3agSejfOs9gi+4o1PcEVmwU7RB+t39WIvAucAz/2Hp4vewBQUnPN9eLFCXHPMx4HsXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836368; c=relaxed/simple;
	bh=K8R8kC3jcmlf0rDFUv28CZDFUfJ0vqtVQSVDSGRDxvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8y+KhTURb8bFHDRXQsKhDQxpbi1zE6M7G4hhjfvf9sXHpwO6JRQArKLDgkk5T2CEkXCkiF1YdZ/d2rPrPSKNsZWitBiY7W+3HXzyhvNQ/gleO8KjItyCVXkcCLZlCyCA08+Zan0ZAHE6eVJEM2+eJPR6Gmdu/J46osTMBw318I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDU3xeh9; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDU3xeh9"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467a3f1e667so66794931cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836364; x=1736441164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRpte4Yj3L0lxneuJsucmfxqmY0Gdyz1zaBITUyNYP8=;
        b=MDU3xeh9hPwyY2cBQ18hKSzgEGVEWvL7lH3pRc2FoOpkjSVjGAfvR/ZNod6fV7O9dt
         WM62RDex/Qms6zbTJvVVisY7jj6MNR8+mDkOKL93m5uZTYoi3iwamT26MESFGMXHWS6U
         Ki1c64D/SY22bNJs8r6pWXbE69WL4nUTPuE49UX3lMoaX6J3PQhSfhSwB8NgbjiRvgZ+
         qqsbMgA5VFe0PCltR09E7vlNnHXf5BvOZRsG5XFZ2me3CKG+2tl3GM+eVOYl0/94qkJd
         XOjEkW9EgTHza5LxTB8rKdKjMs6ZO/t78Ub9bBblWU0QHE0OKyUtebO8ldouf5fV8Ebf
         Sbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836364; x=1736441164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRpte4Yj3L0lxneuJsucmfxqmY0Gdyz1zaBITUyNYP8=;
        b=SY8jSvpmUtkNWQ6AsCiAVicl2ykLRwNuMzcoyYOmw3vB2WKSnQVi/+dnSEXAp8JvKM
         Jk4Qyzr+KWmwXVkgnFQlF7j4AOvC5y1eqVowNem11IeD14OY1t362cp0sAh3F/CUFXLB
         T4hMEfB4zoJ0RVBk9Ms9kgXw7ygAyIKhAZXafXvJW6stQjnaQ1rFPYvZlsl4CFtLBxSZ
         ANagLIT8/m53LOBZfgI+++jLVP087UBtsp+QUEij+B5hO7A9lQ1u6Q/KoOMZAEBAF3QG
         jWfstaimTYyjgZze8/aLSeFBtEYC9qfmzTE5qNP2eu/ziBY9IWpBc6Iff9FrWkxQkJLB
         GsCA==
X-Gm-Message-State: AOJu0Yx+r1fRRbldWOH+U1mH6l/Xj45zhJteGhu5Jt6YB0dZT4kE1O6A
	d0khYNE6wKBgcm4Rhe4LaNLYKTPQi/IP3/GrPNL+nAud1olUPimKXAgTWQ==
X-Gm-Gg: ASbGncs/9b9aCrfUs8W4moEY2zziSkjwl2TrHw/9ola4VyUjo4m+Duf3YUACeErZAii
	GCnEFD12DQfZIE365HPCNd6HhTaCCrPkSkpXijIqr8zjHfcV01Icf1NTTTfYP5MmcU67U/jY0LY
	rLdL//eJQ+be8tnemBeuNgCDKjhiO+cr9dRqgebkFXEdKAUqJL+LdA/sovZwdlJFSH0GvmqgW6n
	83+p5P4NCVwbnznulYtTLNhWt276nKHweFlJMT81Vb2UlbfQjP4NzN2FUiRUBmHEy+4rLcPTOUa
	p6EKf/XHYQ0D6l9ObRV5xyZVXdrOhc71KUCQ8KtOtlGH8gN5gUxheThB/7HYiY7Xh1bTlQ==
X-Google-Smtp-Source: AGHT+IHj+jiISNkqg/TKfNxAlmeSW9VyqQL4jLiVFvRCCXPBOvMkevROIcQZWtX7DNqktmBINUnJbw==
X-Received: by 2002:ac8:5d51:0:b0:467:5144:8374 with SMTP id d75a77b69052e-46a4a8eb034mr685568111cf.25.1735836364079;
        Thu, 02 Jan 2025 08:46:04 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.46.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:46:03 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 43/44] selinux: introduce a Kconfig option for SELinux namespaces
Date: Thu,  2 Jan 2025 11:45:08 -0500
Message-Id: <20250102164509.25606-44-stephen.smalley.work@gmail.com>
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
index 8c0e44effdbc..a6c980f9117b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7622,8 +7622,10 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 static void selinux_state_free(struct work_struct *work);
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 unsigned int selinux_maxns = CONFIG_SECURITY_SELINUX_MAXNS;
 unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
+#endif
 
 static atomic_t selinux_nsnum = ATOMIC_INIT(0);
 
@@ -7635,11 +7637,13 @@ int selinux_state_create(const struct cred *cred)
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
index efceb3ac9157..785991d77166 100644
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
@@ -2353,9 +2356,11 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
+#ifdef CONFIG_SECURITY_SELINUX_NS
 		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0600},
 		[SEL_MAXNS] = {"maxns", &sel_maxns_ops, 0600},
 		[SEL_MAXNSDEPTH] = {"maxnsdepth", &sel_maxnsdepth_ops, 0600},
+#endif
 		/* last one */ {""}
 	};
 
-- 
2.47.1

