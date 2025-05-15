Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1D29A304
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314645; cv=none; b=fhQaqdkpMmn5A6XCZBYgZKVXTtzvTdm1pogZzqGhCQqZl5QMW77QEuoQF+jmf+Q1LXMIIjwWFUXJRJeyeCtOz+lPMPqsHNUoSuQ2v4+bBrA7x9JR9Ejq6oUJbPwkbwH3hBqhUMZGI48sJUzRkrLi4I0kN2Kcp8GO19yh0v9JjMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314645; c=relaxed/simple;
	bh=9p4HyTgM06EIwtP4BCESVFrJZmHeRrX9KwJnyIlnxqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT7nLdcz450aY1Xvtk3/wPOCKKDm9ghHwUUqYYCzVgoZGRhNavQV/ffDsFwgVK/Sfnx+KcjjqLFhAHtVbJMQHzDE4FtjTLny2Hqa6YVYPwRoYhcXF1zmCEcFI8v/q5sadVeQETS5Lh0rl6DrN6Nra68A7PMcW488d7t9WYu37Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE2pJIyn; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE2pJIyn"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4947635914aso9643711cf.3
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314641; x=1747919441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxVUcGULLVjCGE6DY1zFpKCcXnX+h0AgYXsslw8uhbE=;
        b=bE2pJIynQUGLC88NX8ay9Kk/1oP218vc/CHZPWaZ++Ap2yxgk97zXGrgqIE0QMgaLZ
         b+FJjwDbihVJDH3Qa00SY6vmDj60fEJ2oHSywXadfFf+jTBlfKR+0ep+oR+nTPtBfoaB
         sX6epQ859YFcyzdMwjJrlxRc9sLASWtW5if/hCJerTuBl6PLjK4S2PwFs09IPQZeMK1U
         dTLKfjE4spwuIOYU/+pJMj7PBvkiY3WGjloqhhuFrg74fwAW8yKSJnloCN56Mmq79dxf
         LZz4t38NDL8k6ObbT2iYmsSeQ6m9mb7swpQMLyciprjN46k4Df9m2eLBNYe0OJ+FWvon
         EG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314641; x=1747919441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxVUcGULLVjCGE6DY1zFpKCcXnX+h0AgYXsslw8uhbE=;
        b=Oy0QfOX1HOAuJnr7XueUbwgXZJeFjVPZoeTPjjPVFeu4mFFv7HjxfmWSCE00NeSkCR
         wYES2AUDWpLB+Pa1+NaDOsEptXWPA33cMis0KcnVOScumjqIv8TgiwDAafqdbtVWHALh
         FU7exmlEcJTyHwZxF162F0gi7ECrUEg+HsrrOCvXb2m6d9E8gxoMYUEhMyPL9gLTtkUN
         veOsp8SpmznTxsJ9os20y72jVm8FQyltRoZrB3fj2WtCVwp8J0L4aMhew7D5VIRtuZ7E
         23y3GklF+68DSn+nkJgJzLoX44AWhmi+9k4NOBuln2mbKPYHrzRnZcumcIUCOivdDCb9
         BkAg==
X-Gm-Message-State: AOJu0YzMpBlV04C5HWMEECsjxNC9aPXXgGURSaJHFs2TKUGZJFNHvLjr
	9htkSHjLTtNFfKZsDBmB/LGJIXA9yo7MBbJUrU7TaAl0+Rh0tKydpx4jYg==
X-Gm-Gg: ASbGncvxz+RXaScKnzBw0ivCqS9XvwJekZetDgu4M9wThvo1Fjsyz4BZrRHSU3I5qG3
	aTyksF3cPAb+nKuwieFU3L3JxQ7hRBVtqiTfJv1MWjyCyzmkneMlgvFtR9BrHMAE2IK93S1shuR
	DyiYe9bqlugNZ0LKeauC4NMkEEpknA+j7TzsjwXsdUCUorvMeY2iMmZ49XBm9pNaXDmt5jOT8Am
	2S0lFWXXeAtC2gQsdGMjn0UeGjfMeMvklfxjhifvTjbKjxWVInUckajsr/0PNl2kjVRV6LRoMtN
	+VTsaKFRP0bqgtXXxfr/gwhAABWkmVvztmXry+J4tCqJuoaRP7NLcYBfwT4ZyoFItMWuuJyNKhm
	Aig4n/L4Ojs7H7SGlZGvh4J4eSml/BntPJxa9yFoVZ8VqklzBP7vqMg==
X-Google-Smtp-Source: AGHT+IFfbi0gvOa+PPo+KeSgsFC1aDhn5piUrK6gnpXHpHFH7OQbRQbmStV0UkeO1ZdXkZNON3Cb3w==
X-Received: by 2002:a05:622a:5812:b0:475:39:9d35 with SMTP id d75a77b69052e-49495cc8712mr124622861cf.14.1747314641346;
        Thu, 15 May 2025 06:10:41 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:40 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 30/49] selinux: add limits for SELinux namespaces
Date: Thu, 15 May 2025 09:09:28 -0400
Message-ID: <20250515130947.52806-31-stephen.smalley.work@gmail.com>
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
 security/selinux/include/security.h |   2 +
 security/selinux/selinuxfs.c        | 129 ++++++++++++++++++++++++++++
 5 files changed, 167 insertions(+), 2 deletions(-)

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
index 3c410ffd6c52..8ec6e2295921 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7774,6 +7774,11 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 static void selinux_state_free(struct work_struct *work);
 
+unsigned int selinux_maxns = CONFIG_SECURITY_SELINUX_MAXNS;
+unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
+
+static atomic_t selinux_nsnum = ATOMIC_INIT(0);
+
 int selinux_state_create(struct selinux_state *parent,
 			 u32 creator_sid,
 			 struct selinux_state **state)
@@ -7781,6 +7786,12 @@ int selinux_state_create(struct selinux_state *parent,
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
@@ -7797,8 +7808,12 @@ int selinux_state_create(struct selinux_state *parent,
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
@@ -7818,6 +7833,7 @@ static void selinux_state_free(struct work_struct *work)
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
index 78cbe39b1261..7ade0f7532d8 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -111,10 +111,12 @@ struct selinux_state {
 	refcount_t count;
 	struct work_struct work;
 	u32 creator_sid; /* SID of namespace creator */
+	unsigned short depth;
 } __randomize_layout;
 
 extern struct selinux_state *init_selinux_state;
 
+extern unsigned int selinux_maxns, selinux_maxnsdepth;
 int selinux_state_create(struct selinux_state *parent, u32 creator_sid,
 			 struct selinux_state **state);
 void __put_selinux_state(struct selinux_state *state);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 6a2580a684ff..b084cd2deaf8 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -66,6 +66,8 @@ enum sel_inos {
 	SEL_POLICY,	/* allow userspace to read the in kernel policy */
 	SEL_VALIDATE_TRANS, /* compute validatetrans decision */
 	SEL_UNSHARE,	    /* unshare selinux namespace */
+	SEL_MAXNS,	    /* maximum number of SELinux namespaces */
+	SEL_MAXNSDEPTH,	    /* maximum depth of SELinux namespaces */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -399,6 +401,131 @@ static const struct file_operations sel_unshare_ops = {
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
@@ -2213,6 +2340,8 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
 		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0200},
+		[SEL_MAXNS] = {"maxns", &sel_maxns_ops, 0600},
+		[SEL_MAXNSDEPTH] = {"maxnsdepth", &sel_maxnsdepth_ops, 0600},
 		/* last one */ {"", NULL, 0}
 	};
 
-- 
2.49.0

