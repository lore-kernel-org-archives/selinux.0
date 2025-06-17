Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842892E427C;
	Tue, 17 Jun 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169180; cv=none; b=beCgcjZwCdWoZXkrr9WdTSw1VyVUpP7uKDI4LLEQYZy6YOvezVDvLNE7YKGuVV1Mkl1viiUN+wZZCAxCBBs8S94OfnRAUMZ6sWdZdu47OSEW5CKbqdzTHeYeTzR0mnY5LQEGCPrrmxie9Tl246OeRudtLBsHL14P8KDVrich1bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169180; c=relaxed/simple;
	bh=eiU1hBXvPX9LHhzBCwKOi+zJi9qnSjSQ0av0UiQLz1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYxSBPV43LpOKrDwUmt8+wCvGnXSR262hcX2Fyya3smIbyVpd2m5HtQdyqxN+y6P+yRw93fLN5YVt5iFsZc8wXh6KnhRNsO12b6fBQlyHL0pv4DCu3DLB0WkjES8MgGE9pup/T6BeJfLIhWocuXpfElEI6AWDruVvquRoEK8qX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec84FMye; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec84FMye"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d09a032914so505654285a.3;
        Tue, 17 Jun 2025 07:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169177; x=1750773977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6/309NkatcbnNgqBqvDNj3NXNvLLODoDO28oSj0E58=;
        b=Ec84FMyep3xU3ImQ2mdO/f39hTGE/FzUrS+d2SxYUST2eBo4EP4hez4YrDPeG54LsT
         S/1IuI+K5Bf5bVpcHvTDf2L877TlWUEj4Yki2K3tLRt53DXeHtxUH336LVkZa6TMu/rF
         eH3+vFnUp7AmrTQMy7Eu8JCho+zhEJ1IZT1e7VZB1966WDoR5iYZs1GDNjqbnm+WaU4u
         v1Ev6swiyf6M0LSDvcAdJO7jYn3Y2HQIBdzMBPX2BlIp60LG5QgnArTYNUwTO+gI0MDb
         WWyTSrSocvu3FJq2RU3YdDFs0C9Sf/yz5mwQ2UrYq8gAfnkpTZxoMtOKqD7znNTWkZq9
         4tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169177; x=1750773977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6/309NkatcbnNgqBqvDNj3NXNvLLODoDO28oSj0E58=;
        b=mFM/Kw2HPP1uFB81yi93WLYlBLGSjMX9cGYxOEc9THTfvFrIZP4bvmOBVePsT/oBL8
         EGC4WxWV9U85DBTy1GG8wwbpZkkDM/r8e5uN1ZmaB4Z3mKpZK+CpB4NrEBXNHNoLvIdn
         Q7veWHbjDR9pbym6fDuaKAxHlKMmIBd2Z3IqLsIslhqlWgq9AUug68lXtNX8PdbN0GQj
         9SNTtitTXuPsFZc7bW4XjjzMqIMhSWUMgkS2kpJ7aYX8XN2rM992yVCOd9KSVI5JPxIJ
         Rp1LZ4tNjBjuIgoAxd7iRvaVoC2q5lffMHDLI6kWURIIy9I+XM6M4Uc0fVLSsBSs09pe
         vLAw==
X-Forwarded-Encrypted: i=1; AJvYcCVNThLMYgc9ItAQsU+HvjaB/8L5uhLuS0HzHiPcgbOUkflFoQzVuDkRb5GNU6mgIQMdZQ3JDHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi8D22tcb4LxGa/IC/GV1ran1Ty8IUQI0iSagwB5akb/1sWcG6
	NuVXCZMYDZBpKJUewl5IgLAPtf9uyDZ8VsQ21Crwi8bHVlDCygI5YXctELxhkg==
X-Gm-Gg: ASbGncuBdVRp83dbQpket6ZCaVjcBUXai3+3KlKK8S0xDyov0itizq4BDyL+UhrJUh1
	F/1Yd8v4P+bwJRk1hNpjSQuWvksyzICkbR88ZlezJi9HU/tpKFlZ0BlPd/YadeP31Omwn9PC0pF
	rqIJlP3WtQrbvqoJdozxD1IfgomvL22kQWym/xc8WSFW7dvZjCjfjdmxVZ3tbqGr59awwKDLEZm
	+i0SyMyBLjvQxUjctSrm/0PnZ2kEMvW9e6hlpH+agT1JEGIJm9fG+0E31WaapPFhYRqyQStjRm5
	i1CeaTx9e/OP4y9zIEmOt8j8Yka7dg73QK2AX4PPVkUdBxwCpjz/vZkAqbWD4XeTs+C4dB3+8Eh
	AG1OWz2tCgLxaAsRWEI18FhEi16RlS+UaTkzaDlIXiIcf1mLZhbHwdU6OFf2aFTlqbA==
X-Google-Smtp-Source: AGHT+IFTak8/HlJoEfkjMutrDK4zvepXVbyrdrKlsIZ6am//7aO0R94NAYjt55xnU69CnTLQqtx5mQ==
X-Received: by 2002:a05:620a:1aa1:b0:7cc:c07d:e3d4 with SMTP id af79cd13be357-7d3c6cda212mr2078751685a.35.1750169176885;
        Tue, 17 Jun 2025 07:06:16 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 10/42] selinux: add a selinuxfs interface to unshare selinux namespace
Date: Tue, 17 Jun 2025 10:04:57 -0400
Message-ID: <20250617140531.2036-11-stephen.smalley.work@gmail.com>
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

