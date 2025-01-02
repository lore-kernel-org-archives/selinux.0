Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A7B47A73
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836342; cv=none; b=O5srxTdPNNAH6+8gOukqRVBYB3a6QLFj2QlkLPrPXRfSdl11rH7SjPL/A2qqVZ+5M6BVL8vtIgY/3Z3LxgJaPa5rbO6vbkls9ajSp+g7wIYLErzG2zeh672MkyTo1MCxpNwcM+EWiNxclthJ+CxVtDlwaC7wHkxRrYL1iOkevb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836342; c=relaxed/simple;
	bh=HMoh+CVAagzEUUs7NbFsEdUMiBQqgYYbI58FoRU0m2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptdsJtdYOcYOmZs1bhWOB6lx7AAMVsZiYwD+ZxzfW2u3WgvmGaR6ouqQ85O/r0CA53YNkhrdqBiEHIG/LmoXGTxoD8tPTlqQwJaFiat86f5a9tRbdZWLBCH7hJenwDuFuInoCr7Fz6jfqPjlnzbXSmR0ANynfWAShAFh5IfniAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERH3Rmrv; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERH3Rmrv"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46769b34cbfso171273761cf.0
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836338; x=1736441138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnTaYUE0YNGHxKzd9uyIbsHleaxCw57uQdQFo4wr8To=;
        b=ERH3RmrvqO66SPqVmksNdK0AncvbukiI5Pf016fiXnzII8zZZhqyP/RiWgMo6DEU08
         oNRdxm32WW2OwDQNeBTI0Hhc3ApsVCybvIH7PRcpg5kCzBq7yIYZlxhRFkPPiXC+UNLU
         NI42NBa5PkjaUx7HsG6KKc8/NN8X09kf6Hx3yhD+woAvrZc60wFrb3SeUROdGeB0m3k6
         bIQTgz8W7y9RqJDi4Aw5tRN0L2q4vaCk6KB6wynkl8hMsqKFuBmGrVbWsly7ceDApoH0
         l/e0TpZn8RZnIojcj94ggQtX2cVMUCVG4nSlNvjP9XkJC8Qi49oyZPcOOblb2elC+NfZ
         9LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836338; x=1736441138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnTaYUE0YNGHxKzd9uyIbsHleaxCw57uQdQFo4wr8To=;
        b=XkEEZ6i9sOF9HceK0ToItdlNqnuC6nKm9rGcu652VBfrddg+yw98R5deNSnjbPREiw
         wXg5dZ34k8GMLXVZIIzt11adt+O0ouMVMw+y8cLF4+zFsHMkZW8jMIcKWvEMQVi+yLc3
         TNw26Ihex8U1tStzpHJEJRdwJPTW0rzfgQTYCBkNOpW8tT52/AdOpRJnVqQXvp6mzFPc
         um2eMXJKS7AF893h5IfI+gjLqvZnCY+ZVMwpduvqsvno8tPRZimYUL1DtF66ys9hJWbA
         WXvUa6isCEnnS/Pzbh2Kk4CdAn/VAAO3Dt37beIFk1UazGDSp0PwjJ9Ksy6H8RNu5R5C
         YAXw==
X-Gm-Message-State: AOJu0YwED+lALFXsAjqWvnixrMS1Zh5SOl1hUB2eFJOOR37iGKGpIIQI
	rMdlzC/2ZYQLCvQrEVloD9L+UaW0MX19w+AC3+k6TI218QNCBO5Cv8OPWg==
X-Gm-Gg: ASbGnctTv2GC3llcEXD0BbUCqG2s3Lak7lj2ogNNbMDnLrBJ65Ar/xIOL4Yaup9zx5I
	DgaO8xWmHWuDzj+90t13yFxzGUNuWdMzMz8+YQ4ZrwgOzvXpYhh6T7leBgGhde2vpJrvMAPt3Yo
	8AFnhYyz6vFhtX2N4G1nbpjxodnrpgfIe36SS3Mrv9oEIuYzrI4jXlsvjBn90kxeKkL3qhUfq3M
	wcFWYTOUkPz4ENh1uNG/cBi6YTEwcWaASt60OHgh93esIkgFpDiNGpPcbWwrGrkdyA6lmD6BQef
	QjHFKsiutZYrXK0JPozkt0y3WNQD07zp4QgqBnjNTOyFgnzVMbnO7qcpIgqzyEFzmQdDxg==
X-Google-Smtp-Source: AGHT+IHXOpxSt3OKD9vxkC3dCEVUuhap6BiHFQu9sANqzIU4SpAtMYwsGUhtsyO/Td5cs7UqcnyZ2w==
X-Received: by 2002:ac8:5952:0:b0:467:b7de:da93 with SMTP id d75a77b69052e-46a4a8baed3mr645614251cf.6.1735836338356;
        Thu, 02 Jan 2025 08:45:38 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:38 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 08/44] selinux: add a selinuxfs interface to unshare selinux namespace
Date: Thu,  2 Jan 2025 11:44:33 -0500
Message-Id: <20250102164509.25606-9-stephen.smalley.work@gmail.com>
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
index 2bc20135324a..84285fba2c06 100644
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
index a59153c322cc..120cfff35029 100644
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
+		tsec->osid = tsec->sid = SECINITSID_KERNEL;
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
@@ -2052,6 +2117,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
+		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0200},
 		/* last one */ {""}
 	};
 
-- 
2.47.1

