Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980CA2EBBBB;
	Fri, 20 Jun 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441531; cv=none; b=L2roz0Rj4ANug2mm9yGPr/3sdiC2ODSkvsC7asyUCJHLFR4RSoELlHgXyrd8lkCQiS1i5K2QHlf2AsqslWix9qx9MsVQSnxZrEaTYb7kGz114T3rxElHj7TPjXdItgN0uX09TenmnoQZmVcT1QnIkzL3MpWA6LbT408D+PwKvEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441531; c=relaxed/simple;
	bh=eiU1hBXvPX9LHhzBCwKOi+zJi9qnSjSQ0av0UiQLz1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mq3/XeGCtLhUq7ClsCbx9mjkQtnpTsGts9gajUO+5AjvIp4k1hr+CtVjiAL79Nki56krel59rR7a/LZKxmK9bbbZZVFg6ntWC2tf8+XdWrd19psFM/FpEgbn4ycpCtGujNHshf5s2Id2TDGLLPF+L65RbzKrr4r8K27l1sqPwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOHK3L8G; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOHK3L8G"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a752944794so21897601cf.3;
        Fri, 20 Jun 2025 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441528; x=1751046328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6/309NkatcbnNgqBqvDNj3NXNvLLODoDO28oSj0E58=;
        b=ZOHK3L8GeLPC2R58IJUPQVHDdsY74GTUe5WdoiUL3fOUtNzqJAvO9GMqfATahMmflk
         zKfL1+33cLDs/QN08C/vI7w3PqWTyCgFw3wT2DF0hmuDwiI9hfk4AdNfikNMBqnPZ/X5
         dV69JqVLB0kcRzajbwNz/5AZxD5HKjmTQXyrwNykJWm7kkib0BKlo7JHe15FWmzc8sa/
         PjlpmyQ77w9PIaYJaoDS59uHBKz9Mu0Rt3H0dBafYWtRor5EBzEshP9o9EG2QBt+DisA
         RgyksgfymJJ+kd+vx+UKpIGw1QAU52OGJ0+6W2Sq3uBQ9G6w8JmuVXVYLlyuOUDY3znE
         yLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441528; x=1751046328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6/309NkatcbnNgqBqvDNj3NXNvLLODoDO28oSj0E58=;
        b=TDTpIjfC1qQZCwKEXWNjrBRa2GyA4gPkkNj3stbTIOYAk23Zl9lnjqzWS6f0PYMY/6
         OOqZywFb8J3QjizqMXABvKZC59TgAw9xhTzPsQMo/OruymwdtAN+NkomUKDijQ8zHSel
         sdTm7uuy4ZVN67zB/5t0TDhgp4UuJSkv9U0LbI9FrWjRHLxFCuRzJQnlJJfjE/wHC4C6
         KFIDbxct96Ne6x/7NxMm3RLe3u+cGl4irO58HxlWSl7FAICUTrBkTrXUZYGm+UGbfKxL
         SDWUpjZFznNXHyw2r/xld1YdL+NJCCdjNYHlwxGrksRqGo/B+Bo73/X6GGSmVjQ04uj4
         Nwmg==
X-Forwarded-Encrypted: i=1; AJvYcCWQmcsdlxFMh8+fXnE2dFLntOWudN0oUO3YxaK152Z1UlRcJeIOoKBZ5ENr3mwkF62Msc7Ly5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrE7yaOqwjtv9EXu/H8Mw0M/4lRDyIdy510rfVpmXjed+wd9G5
	bH4MUfSEfvvFgqvePBDCYZ+sgwuRSsfoArW2ibT6eUaNwI/IdYMz7kSa+piiRg==
X-Gm-Gg: ASbGncscU+Mg1OKCtOgm/MhpvCZsMV7uoRAqBKOqrDfq8fm5cwsGx/PAE/Kc0k17bW/
	abUeb8IGVb1dwqH8tw9StrwxJcoVa/hIe/8sRn6dfRZGcGDc+7W0tmx00ELDk6Qq0Y2HmXPOGbP
	ZVXZUYvWudR66IrkKZPH/PGrn/iZxq0DJOaPaa3gXm3MBZEbriLJpgKSxGKm1z6Nkh5zri9F3Bj
	3ITwnYAqG2YnnoCTgXJ+1xd3QEbEFqr4h6lpfasM1svm0vv/FACHPJBjz+HS1d2J/A0NPcm0s5u
	mPenphOwcU7W+tr1/SD9Hp4aMC4xQatIVtrU5vH0zIQFVKsa6OECE7ojSl8stCI4am0HhdT/8Qg
	4n4TKNxeKEAfNMkMl1NTweY5F4p9IfeJzG05iHrzNI6vwYq+lZsErONoxcSwEsDnaCA==
X-Google-Smtp-Source: AGHT+IFhg6TkiZBCueKnA7VBEQiCvwZdu5ndA4/SIyd9lroJRW1Cz2eHJWzIEZ9tB8GX/GEe8ASvUQ==
X-Received: by 2002:a05:6214:2f92:b0:6fa:fbde:7e2c with SMTP id 6a1803df08f44-6fd0a466834mr69264916d6.5.1750441528164;
        Fri, 20 Jun 2025 10:45:28 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:27 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 10/42] selinux: add a selinuxfs interface to unshare selinux namespace
Date: Fri, 20 Jun 2025 13:44:22 -0400
Message-ID: <20250620174502.1838-11-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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

