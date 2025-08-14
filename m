Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7BC303CA7;
	Thu, 14 Aug 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178044; cv=none; b=Ssrjzxi7i7Jop2lmgMRw95JswzhtsXtaeclDT3ybKFJTYmMBPms4HO3HMthoETZjEdkxL6pQLMa4FpCXpAfqcuHOdMCRd2dDhEHmUDye6c075Q5nNzaHgywE86gnKNcWbwEA+MIn66fxkmiwBn6/oEi2ZUEp8ppV91EX/BnyOjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178044; c=relaxed/simple;
	bh=3/JBBLiPls3bOg/ZG4KIQFiC7L3TgZattpaDJgTjpvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gvj8qGV+FRtIhmLlqrYxZq85YwVPz/QzBAnveBVKuLUwT/s/L/gr+YnwXHoK8mexmpZeaTqptBdkj3qRLiFsZKGMRsocB8pam+KM0b5bc8LL8I8z6vH6kWq7nQR6JKx/pE1zUEuEduT3sR6zzcIGv9KhCHhwbLAnRG4vH1WvgZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5Mh/BX5; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5Mh/BX5"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109914034so9373171cf.0;
        Thu, 14 Aug 2025 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178042; x=1755782842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uina9wnHjrr8fYbwm9Tnh/y5Py6Kx9HlC6hYiJBhvdY=;
        b=L5Mh/BX53xRqrw5p7R6EwSLrydNPRmEznNtZ6snB+oF2IoYGMapS/Axh3gHoAJFF68
         BS+4R2j85A8hsUsOrLb9WMEWagqNe+/qcLvlhrLW9s80rsQUCCAbbL7+igKXF1mDWlOx
         ZKMti4PzHgF7IATLRJ139bGXqJPrCeJJ40jG5xDLyMXJl0LNp7Y6fGMMKypZTt27VT5D
         Y+8pJRHlbz4uAJ7wHK6PP9qGyu3FMCcVv0DplAKO0YraEUWSqSU3pdOcuA9bJYHzdTu4
         WGigY8F6u+rJnORFFpV57Y48RAp5LcPvlcoRsorJ4o0yy4OIOZ+DXfRUsU2v98Qe1MuW
         t7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178042; x=1755782842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uina9wnHjrr8fYbwm9Tnh/y5Py6Kx9HlC6hYiJBhvdY=;
        b=aFO9BrLnP2DY8Lg4uYeOFW7xpzdSJwltVX9MilhklY7ifSA2X8eEuopO2rWRdSpGho
         cTziNtrqP2Tkh521EYi18OO3JB2ebbRoNqbMMDoDTnl5ooxA7x8jEEoILMfDL24je9Gs
         jPbp/1bJb+YSQcp7Fl/ZT30+1bUkSO6nxtZ9BYEyJTqQ0pPfOwvBAPyhElKiuum/2bPu
         uT4+hlSzfBNc632P+S0F68X6RXFrAZYb/+GoByg6P/Dfno7m+Z7iYqSYveTDROK3wJoA
         HlVwQTKL5uxv29hILRqeFpSrHervDvZu/k4ZHMO3NYD+7V+TwqrmW9GN1ixWwYf0BuLP
         Mo6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/CPAJJUekUAlTZ4KjOPn5PG3nOeqTA+lMWIRFD+1qsdfHqhODbcV1mGhXRK7HQsVVpoIa8t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8QZRBCu5ANvVglyhDpRr8GLYbAX1NuwecQbiFP1+CJKnyzDB
	iqJ1n9bwrPtrcXwpAWJaiAr3H1DA6EVep4WsZprR6Ch2Abxap4W1pGnVSeTXyg==
X-Gm-Gg: ASbGncsjIBlOSpqGP7Ewp/pbLmikc2tghLDGwD7/RR+nGidHOpWA9venuqL/H5CHEEP
	rMAbwvSzhSX1kUpwTVOvTNdcldC6FwQKBNa0vF1qPYpW38iM6VO/FBX9Ftz17saUtHgAT4MBPzP
	celhiBGCgIsG9hwJeeAv4fzTe8Stn99yw7FzFmIgpqqL58poFbXUFkipu0DXR3Wa3Z6TXEa36Uy
	Vp6yEVWNvX/U+7kho59zQK+skYfns+Omairi3qxjSrtlHVmz1S8oh7q6dABkdN9N/0sY7WzPL20
	vwzcCj9zDazEzZi0Yy7bmXkDQn/l9FFXaUuy7/OwBoNt340OKLpwg8bmTLWC9IRFHg8qhndHdx8
	GrBqxub0lM8RYETjANKHvLQWpEV1nDlmeE9KtbTjp80hCPUUpZEz7nKh9YHlr8L6vY7711oydAC
	nhi3dRzKlA6WaWilF5C461b7JgfQ==
X-Google-Smtp-Source: AGHT+IFTscg2qyMpFvjyuqH0yoihuNxXAfzTljPMySM/y6+6whJnkYYcRslzY7hEUtConBlB34C5FA==
X-Received: by 2002:a05:622a:5916:b0:4b0:7575:7de9 with SMTP id d75a77b69052e-4b10aa70a0amr41959601cf.29.1755178041820;
        Thu, 14 Aug 2025 06:27:21 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:21 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 18/42] selinux: introduce a Kconfig option for SELinux namespaces
Date: Thu, 14 Aug 2025 09:26:09 -0400
Message-ID: <20250814132637.1659-19-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index 471992376507..98347ddae2e9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7790,8 +7790,10 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 static void selinux_state_free(struct work_struct *work);
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
 unsigned int selinux_maxns = CONFIG_SECURITY_SELINUX_MAXNS;
 unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
+#endif
 
 static atomic_t selinux_nsnum = ATOMIC_INIT(0);
 
@@ -7802,11 +7804,13 @@ int selinux_state_create(const struct cred *cred)
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
index 46933452f961..be78b71b7fcd 100644
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
2.50.1

