Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C06244697;
	Tue, 10 Jun 2025 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576193; cv=none; b=qMlgEGSY3VuLlWWtu0SPMNDppua1XfnWZRdA68E/ordXErrza/oXRX1LHGwLPSZSooYSdj5U9r2h+Ryt0n7rJd52yqHVSzz854OMTMeFmhPiQsHkoguVXYgElxH6aMsShSAysDgQkfpmMVj42HLL5rlY7srQCW34tWyuDYnU5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576193; c=relaxed/simple;
	bh=eiU1hBXvPX9LHhzBCwKOi+zJi9qnSjSQ0av0UiQLz1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gr3jDDO2ALC9ZejAzh5pFjGsKmwhxRV/Iau+BawTdWBnSWvG14hVJGvXx90+4NkJN8qfyzVAkuuYGP4gvjX63chAk0j38NbtRNV82CWeUFSDSJJEN38nGLsai5UDqRupYi/Dn8CCyCjwjCvlReyOKAMhclPG+gF6w/Qigg6ASW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duDLItlb; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duDLItlb"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c5a88b34a6so560694185a.3;
        Tue, 10 Jun 2025 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576190; x=1750180990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6/309NkatcbnNgqBqvDNj3NXNvLLODoDO28oSj0E58=;
        b=duDLItlb64DH1yjqrY7MRVi6kE7FSRR6M4M6NlPulkilbe5QC1KJeuAR6KKOjfY/72
         CV5qYcjPlr7Shf0L6FyDT8+T4y8IsJ5apmYFC0bB8vwoPYB9zBKqOcL2tclJTyMRCuy1
         67CQu8GBWmZnKpp+HjmdSHJ/qc0IVf3TPYuilaCzSnB3U7+19Y+5axmuJuOcHMUyb6ao
         Vp8f4MF9IDIOyuE/BPlOFDJ25PHfixtgESePekNSulYk10tgQTiQwCzwiz0GApy4yKgN
         hxiM3BriVQMaVNTqCw4NeEkr45O0GzdlLXMAC6mLw3DqqAMfEuxRDmo6k9TVqL5kQV9x
         Dkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576190; x=1750180990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6/309NkatcbnNgqBqvDNj3NXNvLLODoDO28oSj0E58=;
        b=M6xMCMtqvY98L0sD5eiG78fsXxdEq+7/rTlPdd++CRJ/Xw2YzVrNXF9SOsKUZuvNUI
         QoDh2IBb7uYWPDJw8mRLGUBg9yf94dtScMLng89/BCx5ir8S255t4MyUB43lSDZQfOA/
         7FcVFZzWYwc+8mMdUuUIpkavyNmBcxCZUrLiL1E/2PyEolN85knN86A70nI2FLD/jQAV
         yIMJqjyknCcRBszHvzfSLrLLBbkQe9E2tTp00NHdRgd2SDSk1nPJktM6va5q9AYFpIr9
         VnzUR1C7cB8/K2TRqKAsdI9hnUHpclRb9VPIFwDVA2wjrXoXone6TI9g8rRXcM/uY4rh
         8kfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfr4B3rMvp5qXSnR0zxuEMuZF4rlcT2KDklfuRS+av3oKeiEojiVFHuE9dwgImWuU0bs/UeFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww92fjFjwflXObiBEs8dwW7lcI29N3fnBlYrRKd12q592qD/Pg
	WtLDL76hAxcLGTN8A8CvAmzRhifYPdPsr/fGUdPOi0hBZHB37hzYCdAF/aFtzw==
X-Gm-Gg: ASbGncvw4vOXVwe4nxquXcH6apNRl+6m7lfjbN/NuoAUiIeSgXIWOsq9aVIvyiHqfXV
	IuCKnvsf0MYGfj/29C/Ak/XF4oXdXfk+YsUrA9UetnTeQ5c7jI+f/krf0e81J3C4y+V53+ysO17
	CYViEMdms5hZ0iGKxgulhG4gJW9nDFpccoWAQHohK42nQ4inj0BQIqHYsEnNoJZmWC2sqVhJeu8
	+KQ1sFH5/T91cISj98NGxEj2mVM22P9vuv9Iib6BhQ9foKZ+qYRq+otr+M+7Phbe5eHmLVYlB+g
	sZT00nQ02qcOcKBFYVcKna57JkLBJG83YOeKUh1NgN+2s5nuSYHHmFMb3dnGt9u6ndaa4RAsGzx
	gBXfVqQxRS+rxBlIADgBMNEQ/n4dyr+aR8dpNeIyxZ8KPpERUSZg1sn0gAOw/iX3AVg==
X-Google-Smtp-Source: AGHT+IHw0/4c5YIrTVc9H1zIAoTqPPtoalyljR9XC9wVg609fy5Ld3FNEw8jgECaAK5firlCkxREtQ==
X-Received: by 2002:a05:620a:254e:b0:7c5:99a6:a1ae with SMTP id af79cd13be357-7d3a872f195mr40036985a.0.1749576189768;
        Tue, 10 Jun 2025 10:23:09 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 10/42] selinux: add a selinuxfs interface to unshare selinux namespace
Date: Tue, 10 Jun 2025 13:21:41 -0400
Message-ID: <20250610172226.1470741-11-stephen.smalley.work@gmail.com>
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

Provide a userspace API to unshare the selinux namespace.
Currently implemented via a selinuxfs node. This could be
coupled with unsharing of other namespaces (e.g.  mount namespace,
network namespace) that will always be needed or left independent.
Don't get hung up on the interface itself, it is just to allow
experimentation and testing.

Sample usage:
sudo bash
echo 1 > /sys/fs/selinux/unshare # unshare SELinux namespace
unshare -m -n # unshare mount and network namespaces
umount /sys/fs/selinux # unmount parent selinuxns
mount -t selinuxfs none /sys/fs/selinux # mount child selinuxns
id # view initial SID in child namespace, now kernel/init
load_policy # load a policy into child namespace
id # view context in child namespace after policy load
getenforce # check enforcing status of child namespace

The above will show that the process now views itself as running in the
kernel/init domain in permissive mode, as would be the case at boot.
From a different shell on the host system, running ps -eZ or
cat /proc/<pid>/attr/current will show that the process that
unshared its selinux namespace is still running in its original
context in the initial namespace, and getenforce will show the
the initial namespace remains enforcing.  Enforcing mode or policy
changes in the child will not affect the parent.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/include/classmap.h |  2 +-
 security/selinux/selinuxfs.c        | 66 +++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 5665aa5e7853..55903f68e285 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -50,7 +50,7 @@ const struct security_class_mapping secclass_map[] = {
 	  { "compute_av", "compute_create", "compute_member", "check_context",
 	    "load_policy", "compute_relabel", "compute_user", "setenforce",
 	    "setbool", "setsecparam", "setcheckreqprot", "read_policy",
-	    "validate_trans", NULL } },
+	    "validate_trans", "unshare", NULL } },
 	{ "process",
 	  { "fork",	    "transition",    "sigchld",	    "sigkill",
 	    "sigstop",	    "signull",	     "signal",	    "ptrace",
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 6e67b7a9f3e5..d279f072a91f 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -64,6 +64,7 @@ enum sel_inos {
 	SEL_STATUS,	/* export current status using mmap() */
 	SEL_POLICY,	/* allow userspace to read the in kernel policy */
 	SEL_VALIDATE_TRANS, /* compute validatetrans decision */
+	SEL_UNSHARE,	    /* unshare selinux namespace */
 	SEL_INO_NEXT,	/* The next inode number to use */
 };
 
@@ -318,6 +319,70 @@ static const struct file_operations sel_disable_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+
+{
+	struct selinux_fs_info *fsi = file_inode(file)->i_sb->s_fs_info;
+	struct selinux_state *state = fsi->state;
+	char *page;
+	ssize_t length;
+	bool set;
+	int rc;
+
+	if (count >= PAGE_SIZE)
+		return -ENOMEM;
+
+	/* No partial writes. */
+	if (*ppos != 0)
+		return -EINVAL;
+
+	rc = avc_has_perm(current_selinux_state, current_sid(),
+			  SECINITSID_SECURITY, SECCLASS_SECURITY,
+			  SECURITY__UNSHARE, NULL);
+	if (rc)
+		return rc;
+
+	page = memdup_user_nul(buf, count);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	length = -EINVAL;
+	if (kstrtobool(page, &set))
+		goto out;
+
+	if (set) {
+		struct cred *cred = prepare_creds();
+		struct task_security_struct *tsec;
+
+		if (!cred) {
+			length = -ENOMEM;
+			goto out;
+		}
+		tsec = selinux_cred(cred);
+		if (selinux_state_create(state, &tsec->state)) {
+			abort_creds(cred);
+			length = -ENOMEM;
+			goto out;
+		}
+		tsec->osid = tsec->sid = SECINITSID_INIT;
+		tsec->exec_sid = tsec->create_sid = tsec->keycreate_sid =
+			tsec->sockcreate_sid = SECSID_NULL;
+		tsec->parent_cred = get_current_cred();
+		commit_creds(cred);
+	}
+
+	length = count;
+out:
+	kfree(page);
+	return length;
+}
+
+static const struct file_operations sel_unshare_ops = {
+	.write		= sel_write_unshare,
+	.llseek		= generic_file_llseek,
+};
+
 static ssize_t sel_read_policyvers(struct file *filp, char __user *buf,
 				   size_t count, loff_t *ppos)
 {
@@ -2053,6 +2118,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
+		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0200},
 		/* last one */ {"", NULL, 0}
 	};
 
-- 
2.49.0

