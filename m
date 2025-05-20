Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF7227FB26;
	Tue, 20 May 2025 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742483; cv=none; b=Ue/JZb1gMsghPh/QzbNTpbCc/khvRn6pJ3QqwgYIUySyAjayd6qwAw2RUq9ucBZ8yzDDVw4gT1A+ooRDPQTgnR+5iFJV3uxma7G1ryEx5HmYWa7YgeHVIGOYf/25KKAfZlpZOlGiVE3IIdaBDSKNSO9XY6gT+koE7RB4r8LXDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742483; c=relaxed/simple;
	bh=NHvELjOInv8yMyBnJSwivJIIMhUBhy+VaoQOI5IyeDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0imdFvEkFcFCKDMN3nbugrdMlIoHKTHbJjwpSXBdtKm94J1kzZSvOxrBU75KjiryQRVxzwSIXkWSlf7syCH9eX9Obf91vuUYrHPU1Z9fwILYHV7CH+42dXPVIX4XH0riATKzWq+HzMtxqcARF+Ih20VzdTYdRsQhyBIRRmfPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kO3YumqI; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO3YumqI"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e740a09eae0so4834897276.1;
        Tue, 20 May 2025 05:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742480; x=1748347280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LynijTR+OE6uZxYCsdLUshyXqR5evguJi86gF905UkE=;
        b=kO3YumqIfRlX2QP/nm6zbuponyJr/nbSUKVR4+a0Pnaa/GsdDKClw+fuApw/hddaiR
         5aC7TF8slCRywCUdITNQm4fuMK3rI63stmtOUh1nW393KzVbb0cjabw5vIpBUTmjwLr+
         vL8VyOBzDTZ2tIaDc3kze2Jm6HxQdH/TIdxgw72ZRj4fPmJsput9gbq8s6BmuVM78Jg0
         Plv2C2WaSXg0xZJbKORGlgR9vMygV0ztzIiENWRlQxQP/z4+aCdErnORZUAJTtMksH1g
         zTKrJs28HwmgArJSvfiUzey2VvqiGr+c5fuJ4BecuET7LUBid5wYHGFJU0WUeTpwCFJG
         f36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742480; x=1748347280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LynijTR+OE6uZxYCsdLUshyXqR5evguJi86gF905UkE=;
        b=FSQ64IeHvGSuIAEZuXJGvm3lOBh7Kp7a2xWLdUYMM7iydCUqOKitmb5eyopir0llOD
         H9tKtTLDayIPoKrQJ8sybiNUUS7fKD3aZyf69dc29hLMT7ufrqhLLvy5YstLfb8VJc2c
         c8LTB3PyQAPnAUnuK96mYKdPLtpBJZNjhrD+jY3HQjzHd8WE1K03Hpw+qyjWr7pg3Tx4
         EYuYaE6EADALZswWJ+h0XRVAbeP/jaXPnHcUdO2CLj2J5FPP8vL0CXgzZww22cdzXi8t
         Uzfp66hc3O8gOM6B/FU7eE5xGylEZXBxFg8z9eUEDlQBHRa0XPOOERBghZJ/p5gzHvns
         6NmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL4GQHNNbWp4bey+/MzmzhbwCfcflZ0KNepAXC2D7zy4Skx7rLHHFZHe886lPfzUkNxg2dEwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzunLI+hat0qhcwN5djvD3kgoKoSoZfFqPGkDcTlPLlNE3DQFh6
	SJMRUS9VDp5AmQbAP3SJehEdzLGKZTc4JrP9vRAeq6qw05/1A+fjkEmtDtxWGg==
X-Gm-Gg: ASbGncuU7cKwI5cNcosZODdwj9NqXRVA66xjYBUT45SR19zBGBkU2b3wnknvm4djA+K
	/sMr2sxBt7JpAr1WhHsOdLbB/gwhp/M4/k5rl7uuZpjSNHwA7oYLD1QjJMY87skGjNvD7ysIthT
	4XR66ogYYkzIzxT9V1toRyvEwI3aC/w2kMjAnKHaqDE+RM+fwf+zCF2MmDMgLvNmmfAHy8sIC+q
	wKhlBS7SeQu6GJkpz1BiXcHihHiVhtOD8XsA3l4p+vauYjvmpXbH63XQkf1fvAtJnwFMz4ajT+Y
	NBUTGmgr9219XaG4GuZ2UGM/ue9qhOthPXTDNX6pIfXYnTqF0wfrTxsi7judL9c3vKFC9fpem3f
	EAWhgxHvHBXU2gNYpjm7wIYp2GV02yjPO/tWzBf5ayYQWohASTdaSqA==
X-Google-Smtp-Source: AGHT+IEfCVQi6dWlsq16K0IKJZu6OPRToXFKGEe4etF6BGCFvaNlCbpLqZzLKFMkkMYCcs8Q1WgxSw==
X-Received: by 2002:a05:620a:44c8:b0:7c7:a6c1:71bc with SMTP id af79cd13be357-7cd4678041fmr2139201285a.43.1747742469790;
        Tue, 20 May 2025 05:01:09 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:09 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 09/42] selinux: add a selinuxfs interface to unshare selinux namespace
Date: Tue, 20 May 2025 07:59:07 -0400
Message-ID: <20250520120000.25501-11-stephen.smalley.work@gmail.com>
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
index 04a9b480885e..2fe16994ec71 100644
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
index b9e3965418f7..26b9fe149b2a 100644
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
@@ -2052,6 +2117,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
+		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0200},
 		/* last one */ {"", NULL, 0}
 	};
 
-- 
2.49.0

