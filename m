Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A9A2EACF7;
	Tue, 17 Jun 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169190; cv=none; b=OQ8IXMOJ2TYkB+Oyy2cQRwwOGPEETQj8AOHzssnkkyRWvXgTNQPjSfnlEW81TkOFv99sb9rWSL6idICzGwv2KzlMNeAkcRQ2OFmVgR+COL6WpCynVkjxKubF9KxuOR71bBYamoTZWfN8N14+5/9WiUbTmtzNeKRJ/T7lwCAt40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169190; c=relaxed/simple;
	bh=TsgpJCbtVgCAp2Uo7513oFX9dtM2Jv6rZ7gO/pwoc/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOW0j4N2Nxg33I/M/Igi6JgbkFErJ9DZET9DNTO+uNSHvlr3Z+x5nfgMm4m8wCS+pOhP+LxzvccP5khkgQu3XnzYUmv4Ssiv7gE2cwG8w5bv5079JIJ5J3hLQlLg9JEB2Z21/rbTkvJsBgmZhjlKotXaOy27/gFVEtheezPKNyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMsgPg7a; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMsgPg7a"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c56a3def84so587631885a.0;
        Tue, 17 Jun 2025 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169187; x=1750773987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqqqEbH9vDYYMHh7ge6xs6SzJb+d/Puv4173/h9rmBw=;
        b=WMsgPg7aMAv4L+QgYWxcDB+hW63JQoaL6d/KzZipwLskWl3aF505WI+8TZbUExGtGi
         wJ1n97YwVs/EL5bWOsTR/VSo3rOfmHmdzFBNWl0KkY0/fbw5luSAZFXz7twD6XWOdAxl
         hmaU4RuFnmKOYihRvqLVUsxEqaTmBv5aOi9gcOL/uOogYXeD2RTZij7u/KNZa1sWYUw8
         9jPFgDEJy54tENy4g3tLZPfqX/KSZ746xjd9ZMA9Yv0RfDj1CTWeAcFXgquSSI2TK5Qn
         q0gjW8YIfA9+AXoKPZikHwyQXiHzwNAkZ/Z1h0jSS8MmB+p1aelEjFBJP3nTEOri4QKU
         h5hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169187; x=1750773987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqqqEbH9vDYYMHh7ge6xs6SzJb+d/Puv4173/h9rmBw=;
        b=alSzGr054elgsX+tXPeKcK3fe3y8FOLya1t0sznz0EvKYMY5b5cjUKWU7q358TyQUE
         bQrVWOXKN4xLt7f9MXHFfzoTeSLTlc1KSV1XbFbgGyATEHFAnw1ZPqLAFYS1c45akVrJ
         6AfQf8R5QWyAgKnw+PuGRBe6uow08kcrMLt9a7Q94+sl75jAerPdnPiuRh3Rzd3Eq/bT
         58+akzUyqWbAvpxBORLsQY7W63Eyku8F3fEj07RQLkVcVvOBg8YF808jorjLCp89A9qM
         bDyXw9IatjL4z1WPdsphIjvpL5evanGCFfXWGVt19X+e0KNh/UaFapcBLBIQD3oAaYio
         2UmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdjG3Z6MzLLEjTLqc/bm5puuDZAGBXKC0j4Zsmsre03PleaeQEtAwHywqLhR/HYDUXWdT5kvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYFKGHB1F04OtUr6tSo/nrnVw8ur12B9DTqRwcej/m5Bdrm7l
	zZssM5WrOzUqb0wmR7MxlG6sphbiB72Fg2XhSX+9tLhPG2l02YwxaKleERtozA==
X-Gm-Gg: ASbGncu8OfXTNno1rbgNKyKUqi1nHmD6z/A7oNz3euMLnYMEDy639au/6P1dkif9/iI
	ShQgGg0jAQ5f0y4ESxdHdjEjHLdxpw0zZaoHYINRGJMtNPbULsRZUpQmvhdGnAeh0syPZNZRhPm
	uGlmJl9yUW+zMST80A8F/Lv4QKEe3JvLXGJjdvBt5IbnX1e3xjHGRJcVpZ0Xz2bDOnn0/4jFw6k
	6cuYXUqjzzSD2Am9VMH0IUx/l88sXV0lpLTtWdJJ2FuBXVP4aB1Lp0aEFKsPq7U+wxx+XxWjkcn
	756Se6is5oJqrbav8nkPRkw2RQuamJknjzilraA95k3AXh5fRSTWRAh59PkTiwy9PW30VsMws5Q
	3bt0YRZEEZR0j4YbUJK+ZvfkqJ/dymhs937FaOwYqQ4l1ELV+f/6Je5ucEi84CyUYSQ==
X-Google-Smtp-Source: AGHT+IEelbJczTwPhc8hNoQ6M0zmd24tk4pZUbmgHt87aicszxfozhOiWqjEQNU4NEFilroB69+blw==
X-Received: by 2002:a05:620a:28d4:b0:7c5:9788:1762 with SMTP id af79cd13be357-7d3c6ceb891mr1775881085a.45.1750169187107;
        Tue, 17 Jun 2025 07:06:27 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:26 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 18/42] selinux: introduce a Kconfig option for SELinux namespaces
Date: Tue, 17 Jun 2025 10:05:05 -0400
Message-ID: <20250617140531.2036-19-stephen.smalley.work@gmail.com>
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
index f82c33225991..ff8f89c9a324 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7764,8 +7764,10 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 static void selinux_state_free(struct work_struct *work);
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 unsigned int selinux_maxns = CONFIG_SECURITY_SELINUX_MAXNS;
 unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
+#endif
 
 static atomic_t selinux_nsnum = ATOMIC_INIT(0);
 
@@ -7776,11 +7778,13 @@ int selinux_state_create(const struct cred *cred)
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

