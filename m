Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994382E763D;
	Tue, 17 Jun 2025 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169181; cv=none; b=NmI8dDjecrVi5R21FynClFv7hV/TEWXaibKkZ4Qc07IAkVGn1ABHwKtO3lP18vv0IK1Q1J9XLsf1WWDNoofC7T5qizU4sne7UFWxmrH7fk8vFZ/n+BIVZf+3R14LcfXIbepcMvUNT0Ap10oWwRnfod1/ozIxNhR3xTlknLIp+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169181; c=relaxed/simple;
	bh=iYHH5CTq3KTjLWHHEmTSgomNAXMYqJprxu349BtFIA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuckFN6NkkMuL4rbrb88FbYme0AXw9B8p3U6Jh0KeVU6R7/VtBjoXJ2L+67z5iIVHFJws6sPmWyNMXL5HLLBvDcBTlavb/Tc1DO4LZjGnvjy+QmmlkZbBO+kam/lwBA7h0+9DqyVGYDGd/5qztxqTsg3zTp4xamDu4u1k9aIX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jr0kgcjr; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jr0kgcjr"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7cadd46ea9aso911402985a.1;
        Tue, 17 Jun 2025 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169178; x=1750773978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGsX+35NCCjQD+dyPiLlKglshSf+jbPWJ9A6uB9FvMQ=;
        b=jr0kgcjr5QDIA2YOQNigHqmIVnGg1OQfwCQpUlqdQhUYDlOKtAmVxGwMvE5Y/Rbkr/
         6EV03Iu3nojtqoAgcOS0vVTNn/iwab0W8zcNY04AwUdWwhATqrA3+2huG0hqcbyBP2eV
         PhcUJP638+cfOWBPn1ZWc9eKqwHFMk8ldfl7/PmAJXDlfXvzKhqApynx/m5aSODqrz8x
         zIN/Vga4JVEck/XF6YV9/qLGQKikz57NnQE6KWhs2XHP0Hxltq53z6ZQeuKYr1aTnm9T
         a5FZJ//RdLy/5g3YYYtdPjO9PXdqKadxm5JT4PWQ7LtSjQ9h4yQe/HkWwjgxRe84HIVQ
         irnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169178; x=1750773978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGsX+35NCCjQD+dyPiLlKglshSf+jbPWJ9A6uB9FvMQ=;
        b=KxIHVN5sQtERYSoURe1suOmu9XgATVZ34Tj3vL7yj+pyr1jFWnNkFfPcMV41fG8/Ob
         VcuaZPCFWK85/amHGtIWsRf9PggEXwKHhSqhP51Q+nbocY02UenJtmmqYuc1PyZw9xT/
         jXhXiun2Pe27osdXNJhU7csFK2IzLTSoxKjh7/YVa9fql9Mpt3BzTuwerIL8+GaW3nvx
         MJ/yaCb9AiAAiNYw7DHOIdP9Rpp83Nudojt/HO9zONCXNxTKRjr4srAyhW6I4G0VH7sn
         22VElo+Nr/rm6bkJu6kNTGhPlLOOyilY9u0vI31IfqlaSwNVxbynX4iBlESEagJwAcSi
         Eb0A==
X-Forwarded-Encrypted: i=1; AJvYcCXQ5Xw0OZDC6Rx2yQDOXi/AVTefPR8kYqEbhgTZI2TknZyoBqa4IerisuSiUgZ6PG+C0jtZCwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywag47PR+fhx+CkIQolbspdW1flrIUw2DYqo4QncyDDqQ4wXoFE
	jPSASx0gKSiGsCxQkOBqMAsHsbbdgzpRlc3AqNO9LOXhYkn8PZ+YMg9Hn+iKsQ==
X-Gm-Gg: ASbGnctVFCmctF8JazskyAQxIzcpJFcX4u9ql6sjHtYl4mlHQAjfCCmH86GBTF6k+st
	p4x5X3Ufas4x8L/ytLDP2xa2qchRwSnpbzrlnNorVpCFDahAaJsn4A+cEmrs6HTZSxWthEs6p3D
	sZSocpn9zJM1Jrl2x59Ge2krclpB7FTqnFF1kXEsB43F7qMjY0eYvUNvjWE2Vp90NL0M8YqxGHM
	xruv8qU5vTavE9k7xjAUM0KD0Bi0wpjKcTRonjC99WK2dBlBwdQ77NZ/r7QRK8qYcBTbrR0zuTx
	Y2yeyEP8wAvebPGximzCxfnTEFnsdV29/2VTWC19/l6vRzFwCwVqydp+4m4Yloppw0DCR2ODo19
	qcNbvPXeLjSJ8dG/q3YQWwaDnxvDocOyFyqVevpPRRKhgdt1EFq9E/KCEc6Hq3ijEeg==
X-Google-Smtp-Source: AGHT+IEr6kBKAvaqmyoP6FsMH2TjTtCGqU2m6RWGuZ3nku1epKFymgXUbvc0MhuojSwgSOOYwdk+YQ==
X-Received: by 2002:a05:620a:2894:b0:7d3:b094:d212 with SMTP id af79cd13be357-7d3c6d02798mr2231065185a.51.1750169177934;
        Tue, 17 Jun 2025 07:06:17 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:17 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 11/42] selinux: add limits for SELinux namespaces
Date: Tue, 17 Jun 2025 10:04:58 -0400
Message-ID: <20250617140531.2036-12-stephen.smalley.work@gmail.com>
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
index db427790b8e4..d65107cc5cb2 100644
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
 		selinux_policy_free_rcu(state->policy);
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
index 3f36ab9e0315..ca025586e9e7 100644
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
@@ -135,8 +139,6 @@ get_selinux_state(struct selinux_state *state)
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

