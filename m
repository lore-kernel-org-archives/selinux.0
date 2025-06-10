Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E062248176;
	Tue, 10 Jun 2025 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576199; cv=none; b=MdRtv6zTh641+ACykTj5klDyh6eHpUZ6iEZnVt7cSVBYWsfWhz0DCZtQC9zANnca1YuJGqhNrDGOgX79JUa/h0Zis1zvzAswqtbeen/vZlW/XbzpIssDkyct/pWw7PP332Izax4wpCc5QaTwtjHv+dOC169TsnMorAjbcMUFzmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576199; c=relaxed/simple;
	bh=+p5urnKNW7YHoHJ36IhWhbc1kVteCWM+hZiJEqY2jEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKP/M3Usy7wahb6LQfBeH4z4caTPNJLP6KkcAAejqRvEyiTLa3Gnszis4EtDDLyS59F23HvvfvzR1W27m41z4dY3W4HGdOUdGSXQmbgvqDtaD3LcNmO4erPM+ZOfPobnYIGtOmIGRlDZNQ9urrQVdfP6+GCqDcM4piqN1j/cl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTxZAjbS; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTxZAjbS"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d21f21baf7so527903885a.0;
        Tue, 10 Jun 2025 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576196; x=1750180996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOeTGOOMw0vYN2iwvW3+cJ7SOBRi+bnt+4ECokuSx1c=;
        b=gTxZAjbSctMQPuLqmAo+/Ur28Da8cZHmHADlmBFl1ZMjTbOap1E6cvlBG8ONJaU8dJ
         cqZNLaCCPLtJVvGDisQOWVsL/e2ow/5aIxgH7bXsPLZjMKMiCtNkFHeZFIc6n5qTNc4j
         xFSxu/oWweuTo7IUGqJDzO8lY9Pkg0Mjj4HxMD18Mlcir2wMbcpogMleyxpL48eiI6Rr
         aMVFDt9V3ZI59/5NbCauZd9ivKtQzBOtFJ4QJcbLA0zC28Z1IB4j5SBcHohIgxr5QofA
         JgK9suxB7oyuwVMOP0Lw/cgUol9t5FX+HaYX03vREVcvJ4W9NRdu4Ox4viP4ithuI3Gg
         H1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576196; x=1750180996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOeTGOOMw0vYN2iwvW3+cJ7SOBRi+bnt+4ECokuSx1c=;
        b=m6SBt5nsXXjQnI0tj9sHMmDlKriY4CMX6h2b1TkvFw2sZngJcapBqrrQhXjPYyLI/u
         dCJCW9IO71Pi27YcylkI1hWcfLGbJEL1QzJwQA/ditTboxHZNE91pdNdPCg45UH18daJ
         EEvrvgGe8GtNuEH5I5jVpBUu7SlJnyCwB/bT3mhOgQbpwVFuY4uGfvLhXTUNWRhM4jCh
         pfFpOCp554PhQFZ6/vtVaDoZC2CifJL7CDz+sr77PwY52vZ6uoIeCYncfyKd2yQ/9TwW
         hatglJg/Y1FirvyBD0fUke3i1Zlu7lzCxoyFkQVqkCZYoRfRDPy7t5Gojw+1QRVPtCQ6
         qtOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Ef/CbevnWOV+zDPlQO+afCJtWOB7ypD2bbxwiTuG0Hq7EivwMn+fzXU/1RrKWz8gyA/Qxzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLp+m4WM7rVUEWCB7yw9pl2n3/92QB+NwvG3/T7g5BWX4n5K20
	KwoR79zXeOGhhe6dbOnIoHYYZ+8gcdqxo6ogG6J4ZLPeB7Q2IjbWW05tJXD0Lw==
X-Gm-Gg: ASbGncv+gB3Cj2asM8/nnayUEWOhpq/k3hItCn+Miu9voUuTtHmwmwBOb/ec2UmVgI/
	s4HRF5+VfaG2SW+MtMBsWbufuUJMQoo3eOE5EvBwLPLyZC+2x5Aa0W0PCvqcSpwmYXQ0Wibn5j6
	jZvSNuI1mF13yj15OUMmxTGagN7g5QxSw6+TDZd42nlnqH/BUAS4O8KKgr4lccUzdiHbgJ7/IRX
	ZgvP2aZ3Ik9y48HVDxm18/1XsCji1Cb8aiDbcyt1f+Z9zBOOAoxXlvwxOVVGekO512LiBtajrxG
	Z0l8OG2TUFFllXoGX11lKKcfCA29Sz5gmgPq9weOko7ePyj+5ZMTnyRVhb6no3dQJ+git/5B87s
	KPrbJRNjsGHUQrlQprX3YIoTaqdQhnN1mykHDFCZP9WqEdKd3TWnMdS9nHLJAqq8OAw==
X-Google-Smtp-Source: AGHT+IFqqx0iKWwihsKFE3Q8V0gAMOjRXzLEAMz6PU05pmgmshsMildbHYvYNvZyZppjvNqAiml8Sg==
X-Received: by 2002:a05:620a:1a21:b0:7cd:2857:331c with SMTP id af79cd13be357-7d3a893a2demr27534785a.42.1749576196082;
        Tue, 10 Jun 2025 10:23:16 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 18/42] selinux: introduce a Kconfig option for SELinux namespaces
Date: Tue, 10 Jun 2025 13:21:49 -0400
Message-ID: <20250610172226.1470741-19-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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
index f7ce86f9ef57..1f03c799b4cd 100644
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

