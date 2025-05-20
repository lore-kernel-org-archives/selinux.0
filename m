Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E208E27F194;
	Tue, 20 May 2025 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742474; cv=none; b=sdU1LhHAXs1tzb2foduWjUefzmGzv+hxbQl43EknuVFPaqqYFQA9owys4tIyMfhYfnBbnKadZeVoOThSWcazMf/F4JVst9QtzhnFnsdLqFV17Qq9hXUk+0IgHksP2bHSS0BLPVsACJ3q5BL7Vu6837jU1t7nr2PyqPIXWmYkwxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742474; c=relaxed/simple;
	bh=kaSV7WkH7RVcR35zRCAuAJSC63gPGV7kQZXbPdvBE4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bi53c7wrWAhehyjFJV0xL7jDbIxhyZl2dsl90Eih9tN0kLqXwzWE70rD5y5Hq9shSffOf4058rgGr2n1ubsJ/bb6sZEID3jcnFqjFBIs2skQmCaSZUDyVC/agsunuOA5drznY9W3L+rWm23cJ7yOiowwTSAFXOxyab/CaoNbCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCIugkck; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCIugkck"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7cadd46eb07so588386785a.3;
        Tue, 20 May 2025 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742471; x=1748347271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJADd6w0dKGO+5/8NQxidxmn7FLGw4m14ATTFncyvNw=;
        b=DCIugkckw5DLlneCXEbyX96iAZ3aN+Zd1Zn1HYssa/wSiJT8wHkoDCVcUMCjtU5psU
         NL5cJm9Fhe/PgBuOkBpiCZyAwoQVWwphmQ45Gq95KkrNAKroePJ1nLYFG+FE4z1gKm2Q
         ARqf6a0lPeRraCz/wbirHVny7loaKtxv8HKUCXyVMW1hWvg9B/vVTj0zNBlp9GWbCfVq
         iZCYfsGqpHqfXSbXnBWjI4G0s3sItGfCyXRPZC9/M6fJHR/2Phy691JqemTzvj5Gp9Zt
         WSNuOANNuc2o2Whm/OB/IuyywDtWaQ4lRX0GMyJ+UgcXf/8/y3dm2TYGRw/QBFypm0yU
         NiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742471; x=1748347271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJADd6w0dKGO+5/8NQxidxmn7FLGw4m14ATTFncyvNw=;
        b=q1KqiRXZgPLYNiSlxT45B6YnCWs9aN3SXZH1fCuFpWZVb8AKRgPnxf2DW8xU+uh1gJ
         Wu+oruv11heOPnIVw3UU9JCfPc0IujGnIQB91TuQvP3jOk+9/vHKYuKvS+BPHtStHHci
         ljs0Ixh2VMerPaRPujxTuFo8M7TieUGuTX6CzcAMQVPhsbxnF+fCUV07xRwWsYEsGjSE
         SpEezjJo6m9llPGVk8o1shUy+GOdmYX+wAgM4rM1of1/NUzW1krt5JHqXnWHASqeR7uX
         ugWQqy4LF1T4MTebsYSk9eep59UuAr/MlVcd+HN49+DwgaLZ52hwKGVIA3Z/mS2FP3cc
         VDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIKh6vOYsIpYHNsq58/sC2KoeKPP/vuXOEcgG6HX85ma3WcVpPU68i/jVlMpix8GOtof8TiEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxru9gAyCqhUvtSlD2DtP7VgyxvOFSEQSgCkXycqq6d2Cd8MzD1
	EXWk4Oap+AlTXDCY4EgjLmYjrH6+eZr7wYmV5Ynv46CYZGivtK9gSaqXiEi9jg==
X-Gm-Gg: ASbGncsG0hk63uRS4hRxGtEdrEjhY9z0OCPffMFhbeZ8tWzB+htP/JuYfkYJ9UpSJNY
	0doQC0h/DB9HQPxjuvMTIvAxnFWRc2IpIBSModVhKECrpaGMrP/r3nHZUravkJWMDjn9gAYekaH
	blARRW4P+Uy/6wY5pOi9w265RjMQbr3zvgncnoP3vm9XyrACqXvgt/ByRyb7T5Iay+c1ZaJV5tJ
	kllKJ7/5rJDJwPeRmXXTMlcSpt4rchaphQLEfXhImwu1dGADhyfqzWs7wn7wtdB+qjDosxswPbh
	mfP+M6M0SvpboTfc8tJZpLJystsCkXyrZEErWQytkoGSI6bYpc0fd1Gd5isO4bb2YFEGqHtbzBy
	7PBKotejHpjs0zfq7qiMjbyM9S5qG2pLWyOkfi+cNv2KfGRjGHUKhqA==
X-Google-Smtp-Source: AGHT+IGqfdY16SHe3xvQenAc2obS/GG3e2YlybE03yL05Bp2vp1qyhupPk+aTkEJaeB1scAhlX9BsA==
X-Received: by 2002:a05:620a:171f:b0:7c7:b4ba:ebf9 with SMTP id af79cd13be357-7cd467237b7mr2318774285a.22.1747742471121;
        Tue, 20 May 2025 05:01:11 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:10 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 10/42] selinux: add limits for SELinux namespaces
Date: Tue, 20 May 2025 07:59:08 -0400
Message-ID: <20250520120000.25501-12-stephen.smalley.work@gmail.com>
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
index 884c96758624..4cbf4417eb1b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7806,12 +7806,23 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
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
@@ -7826,8 +7837,12 @@ int selinux_state_create(struct selinux_state *parent,
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
@@ -7847,6 +7862,7 @@ static void selinux_state_free(struct work_struct *work)
 			__free_page(state->status_page);
 		selinux_policy_free(state->policy);
 		selinux_avc_free(state->avc);
+		atomic_dec(&selinux_nsnum);
 		kfree(state);
 		state = parent;
 	} while (state && refcount_dec_and_test(&state->count));
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 2fe16994ec71..f2baae69cf6e 100644
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
index a2c833df53f5..cb1c9095cffd 100644
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
index 26b9fe149b2a..b64730bb6596 100644
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
@@ -2118,6 +2245,8 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
 		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0200},
+		[SEL_MAXNS] = {"maxns", &sel_maxns_ops, 0600},
+		[SEL_MAXNSDEPTH] = {"maxnsdepth", &sel_maxnsdepth_ops, 0600},
 		/* last one */ {"", NULL, 0}
 	};
 
-- 
2.49.0

