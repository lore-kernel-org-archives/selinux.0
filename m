Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080E224A06D;
	Tue, 10 Jun 2025 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576204; cv=none; b=lx3oD1Azwfu+BvgG3hKoatSi/Yf1omE6d6vulgPW/NElydH4v6/LXULM9iSiWdlJL2l9glXMjlwaxldsGH6nXGUkYCV3X05PA95v+7yiNUMN8Z1AlDcnaDkbRi0Ca6vyYGOUz3QCTBDkSpP5k7VWW8uyIoQvdq5E21wCjlWvbpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576204; c=relaxed/simple;
	bh=2s7eYhNWdjdCQT1xs3tOQULe7zxFsA0oPPFzDl5L1LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3MxqoCvNnffDwEIVzyECh9hWV0i3azQg1aOztzV2QsWpZc0Dn6b4rrthnZn+hlTgx4RUHs8eM4T/J5y2wvrpaDhh15xSY9GJmeW6vhxpvDGISUx+8snh+fqjTn7Z+IpPPG5XUKKK+oSg4CvSPwA/7XbmV65pGu8It49DUZPWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfOz4dr+; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfOz4dr+"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4066a0d0256so3735302b6e.3;
        Tue, 10 Jun 2025 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576202; x=1750181002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJbVtZAav3aiZcviiomWacGDEGYVgID48n9l8xpC0Fg=;
        b=hfOz4dr+V4HzBtGPjeW+9S1qV5dSr2K5KKVEx70nkSESnIjA/Ru+jjztxCt0UrZLWo
         yKQ41ffQwWrYszM7v6ehr5W3cZl0Ys9jhTtP1v6aPX1RO6jKUU8IFevs3Qsg4HvNMeqI
         MaFqXAzHm7+2GAQeE1XqLT1CbMgWGzUGbMKFv1RHoVmgky0fcszzlbTWfGlUcYwN69IN
         5SDx2+CRWicXr+APdSx6mpNfKbQBjx10p9cm53ftPaagDlcKCOeR22wiTZ5XkOKU1jvZ
         /3rGSNKsdhHmlWVPBH+9t2638UFRxokGmDOK2wjedXz1wVPoBrvIKtYXSCHZvpbJGAdU
         KZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576202; x=1750181002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJbVtZAav3aiZcviiomWacGDEGYVgID48n9l8xpC0Fg=;
        b=SyX6tQRKRBehL7Uom49jCIPCYJTgLivpA7XgDqzs8MT81fhSX8ML1mPavlmW03AMh7
         YPHDrFOTd9zggqgiAVGEVUZ98M/47Tni7hViCCXPMUU8+5egUBNevwvz0/HEpYCgUVzm
         LlhwTCrW7RureZY/yraNxLa718I7QyeW2CIOXnubzgCScsAeQlJ3zeJoQi9B6RWq2Kij
         WPmdMinF5qUeqiJkq9xdtE2RHuj79UmJPr4j4zdDSJyJUwHJ/jfS8pnX2mzioE55g12i
         IB/+wNg/JTaN8zaVBVL1SpKzEMEDAGeylnoVRapHPFDciOuLyrSwob8v2HZQ70lbe0o8
         Fr/g==
X-Forwarded-Encrypted: i=1; AJvYcCXHSN+ZKHV9IKiQfaZGvlK1NTSqnSQ7WlKu3ycmVajJEZnhwe3iRB9TyfgceOjPWkJkEiKHZbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YystRQRGiZXRG+r7c/G9HgdKBQOQ15UrqC6E+LYo3OwZ8QctAiC
	Nip4mLX4xiG0dRux2uv2pevZRyIjHnYk359ZU+YpNPdXq6aJq+nCUSsV26qIUQ==
X-Gm-Gg: ASbGncsdmwsGX5FREUSBjxgrlY9TBzObrD96gHO/jeKBlOWpZpETllNIB9GS96tIBsg
	Xp6Je8wAdVSLF+URmmwllriv0VlHpbnyd2T/l4tWAYp6rdVHbpbqIhkl6y2tljz/nqirisZnWWF
	btfEQqova214Lmw4GqhNpye9c7v3Pbk3MIRcIBqoRCMARE/DAolCD4VLW/9QZJ1TC2/VAcqxBlr
	JHWWAIRWCeLcJ+N18Ad+AnSMwrZOGTPzJaVvMo4BtjkVQWTYnvfr/C0EY4XW4XYivTACgHI2dHe
	TgcSz2+NlFbjSRX962Z0G8mYhsgU65MYoveRqxB0Fze0IYlNQjG+0sXrhPiJH/2ks2+KtkgCUAK
	QhuSx1jR1fWhPgTKYsDYWLArhg+UIIpzo8CZTzcVQa4Hd7bzYpjKZ+7jeRzFaWJXxaRK65mYxV8
	1/
X-Google-Smtp-Source: AGHT+IGQUEGOsx1H/FVBJKH/zxXNOiY+UOHPYsnK4Z2HSM8ClyL1FQA4UBoUnseutlyADN5jaVSKfQ==
X-Received: by 2002:a05:620a:199b:b0:7d3:89ed:6cc2 with SMTP id af79cd13be357-7d3a88043d5mr36079985a.1.1749576190439;
        Tue, 10 Jun 2025 10:23:10 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:10 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 11/42] selinux: add limits for SELinux namespaces
Date: Tue, 10 Jun 2025 13:21:42 -0400
Message-ID: <20250610172226.1470741-12-stephen.smalley.work@gmail.com>
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

Add maxns and maxnsdepth limits for SELinux namespaces
to enable control over the max number of SELinux namespaces
and the max depth to which one can nest SELinux namespaces.
Provide Kconfig options to control the default values for both
limits, and allow them to be overridden via selinuxfs in the
init SELinux namespace only.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/Kconfig            |  18 ++++
 security/selinux/hooks.c            |  18 +++-
 security/selinux/include/classmap.h |   2 +-
 security/selinux/include/security.h |   6 +-
 security/selinux/selinuxfs.c        | 129 ++++++++++++++++++++++++++++
 5 files changed, 169 insertions(+), 4 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 61abc1e094a8..82db54462253 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -87,3 +87,21 @@ config SECURITY_SELINUX_DEBUG
 
 		echo -n 'file "security/selinux/*" +p' > \
 			/proc/dynamic_debug/control
+
+config SECURITY_SELINUX_MAXNS
+	int "SELinux default maximum number of namespaces"
+	depends on SECURITY_SELINUX
+	range 0 65535
+	default 65535
+	help
+	  This option sets the default maximum number of SELinux namespaces.
+	  The value may be viewed or modified via /sys/fs/selinux/maxns.
+
+config SECURITY_SELINUX_MAXNSDEPTH
+	int "SELinux default maximum depth of namespaces"
+	depends on SECURITY_SELINUX
+	range 0 32
+	default 32
+	help
+	  This option sets the default maximum depth of SELinux namespaces.
+	  The value may be viewed or modified via /sys/fs/selinux/maxnsdepth.
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f5979a6f1cce..eaac0ed9fcd2 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7776,12 +7776,23 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 static void selinux_state_free(struct work_struct *work);
 
+unsigned int selinux_maxns = CONFIG_SECURITY_SELINUX_MAXNS;
+unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
+
+static atomic_t selinux_nsnum = ATOMIC_INIT(0);
+
 int selinux_state_create(struct selinux_state *parent,
 			 struct selinux_state **state)
 {
 	struct selinux_state *newstate;
 	int rc;
 
+	if (atomic_read(&selinux_nsnum) >= selinux_maxns)
+		return -ENOSPC;
+
+	if (parent && parent->depth >= selinux_maxnsdepth)
+		return -ENOSPC;
+
 	newstate = kzalloc(sizeof(*newstate), GFP_KERNEL);
 	if (!newstate)
 		return -ENOMEM;
@@ -7796,8 +7807,12 @@ int selinux_state_create(struct selinux_state *parent,
 	if (rc)
 		goto err;
 
-	if (parent)
+	if (parent) {
 		newstate->parent = get_selinux_state(parent);
+		newstate->depth = parent->depth + 1;
+	}
+
+	atomic_inc(&selinux_nsnum);
 
 	*state = newstate;
 	return 0;
@@ -7817,6 +7832,7 @@ static void selinux_state_free(struct work_struct *work)
 			__free_page(state->status_page);
 		selinux_policy_free(state->policy);
 		selinux_avc_free(state->avc);
+		atomic_dec(&selinux_nsnum);
 		kfree(state);
 		state = parent;
 	} while (state && refcount_dec_and_test(&state->count));
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 55903f68e285..be52ebb6b94a 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -50,7 +50,7 @@ const struct security_class_mapping secclass_map[] = {
 	  { "compute_av", "compute_create", "compute_member", "check_context",
 	    "load_policy", "compute_relabel", "compute_user", "setenforce",
 	    "setbool", "setsecparam", "setcheckreqprot", "read_policy",
-	    "validate_trans", "unshare", NULL } },
+	    "validate_trans", "unshare", "setmaxns", "setmaxnsdepth", NULL } },
 	{ "process",
 	  { "fork",	    "transition",    "sigchld",	    "sigkill",
 	    "sigstop",	    "signull",	     "signal",	    "ptrace",
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 33e8673266eb..221a02f3f9fe 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -110,8 +110,12 @@ struct selinux_state {
 
 	refcount_t count;
 	struct work_struct work;
+	unsigned short depth;
 } __randomize_layout;
 
+extern struct selinux_state *init_selinux_state;
+
+extern unsigned int selinux_maxns, selinux_maxnsdepth;
 int selinux_state_create(struct selinux_state *parent,
 			 struct selinux_state **state);
 void __put_selinux_state(struct selinux_state *state);
@@ -134,8 +138,6 @@ get_selinux_state(struct selinux_state *state)
 	return state;
 }
 
-extern struct selinux_state *init_selinux_state;
-
 struct avdc_entry {
 	u32 isid; /* inode SID */
 	u32 allowed; /* allowed permission bitmask */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index d279f072a91f..1ff044d17805 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -65,6 +65,8 @@ enum sel_inos {
 	SEL_POLICY,	/* allow userspace to read the in kernel policy */
 	SEL_VALIDATE_TRANS, /* compute validatetrans decision */
 	SEL_UNSHARE,	    /* unshare selinux namespace */
+	SEL_MAXNS,	    /* maximum number of SELinux namespaces */
+	SEL_MAXNSDEPTH,	    /* maximum depth of SELinux namespaces */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -383,6 +385,131 @@ static const struct file_operations sel_unshare_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t sel_read_maxns(struct file *filp, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	char tmpbuf[TMPBUFLEN];
+	ssize_t length;
+
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", selinux_maxns);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+
+static ssize_t sel_write_maxns(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+
+{
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
+	char *page = NULL;
+	ssize_t length;
+
+	/*
+	 * Only permit setting from the init SELinux namespace, and only
+	 * on the init SELinux namespace.
+	 */
+	if (current_selinux_state != init_selinux_state ||
+	    state != init_selinux_state)
+		return -EPERM;
+
+	length = avc_has_perm(current_selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__SETMAXNS,
+			      NULL);
+	if (length)
+		return length;
+
+	if (count >= PAGE_SIZE)
+		return -ENOMEM;
+
+	/* No partial writes. */
+	if (*ppos != 0)
+		return -EINVAL;
+
+	page = memdup_user_nul(buf, count);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	length = kstrtouint(page, 0, &selinux_maxns);
+	if (length)
+		goto out;
+
+	length = count;
+out:
+	kfree(page);
+	return length;
+}
+
+static const struct file_operations sel_maxns_ops = {
+	.read		= sel_read_maxns,
+	.write		= sel_write_maxns,
+	.llseek		= generic_file_llseek,
+};
+
+static ssize_t sel_read_maxnsdepth(struct file *filp, char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	char tmpbuf[TMPBUFLEN];
+	ssize_t length;
+
+	length = scnprintf(tmpbuf, TMPBUFLEN, "%u", selinux_maxnsdepth);
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
+}
+
+
+static ssize_t sel_write_maxnsdepth(struct file *file, const char __user *buf,
+				    size_t count, loff_t *ppos)
+
+{
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
+	char *page = NULL;
+	ssize_t length;
+
+	/*
+	 * Only permit setting from the init SELinux namespace, and only
+	 * on the init SELinux namespace.
+	 */
+	if (current_selinux_state != init_selinux_state ||
+	    state != init_selinux_state)
+		return -EPERM;
+
+	length = avc_has_perm(current_selinux_state,
+			      current_sid(), SECINITSID_SECURITY,
+			      SECCLASS_SECURITY, SECURITY__SETMAXNSDEPTH,
+			      NULL);
+	if (length)
+		return length;
+
+	if (count >= PAGE_SIZE)
+		return -ENOMEM;
+
+	/* No partial writes. */
+	if (*ppos != 0)
+		return -EINVAL;
+
+	page = memdup_user_nul(buf, count);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	length = kstrtouint(page, 0, &selinux_maxnsdepth);
+	if (length)
+		goto out;
+
+	length = count;
+out:
+	kfree(page);
+	return length;
+}
+
+static const struct file_operations sel_maxnsdepth_ops = {
+	.read		= sel_read_maxnsdepth,
+	.write		= sel_write_maxnsdepth,
+	.llseek		= generic_file_llseek,
+};
+
+
 static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
 				   size_t count, loff_t *ppos)
 {
@@ -2119,6 +2246,8 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
 		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0200},
+		[SEL_MAXNS] = {"maxns", &sel_maxns_ops, 0600},
+		[SEL_MAXNSDEPTH] = {"maxnsdepth", &sel_maxnsdepth_ops, 0600},
 		/* last one */ {"", NULL, 0}
 	};
 
-- 
2.49.0

