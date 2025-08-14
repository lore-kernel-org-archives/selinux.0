Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234CD3019A2;
	Thu, 14 Aug 2025 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178036; cv=none; b=pQb5yQulXw1we7dGNy1awTOfKXgFKIxGKvpvUb+l0t78bSGwf/iwgdTz9sWSlHJ9Nsn0PSuVqwZcePkd3CtRTzoDS7VDfIdIQioK9YWO0zmNngYJAwhdCE4p98SmwuY5fMJiLGxB4FIz4ZWdUEUWxWiSQnbVY1szvYqRcsYIPSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178036; c=relaxed/simple;
	bh=ljmrHu/zDTDuUrh/nO2b+TMis2wz3zF8XzNiSExnHc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3HBZahgBpSHNCGo2mnB7COKsex8jaA2xrbYcV8pWZdz/D8xrCz3sS4jjbcGZOFdIYh7lprAxrDMznWsv/WURGacrfFNvyqf266em9EJlN0XizBGRwhTaH/YIiPtWSiuNiQDJdU0Pv5/VYaI7BTc3beUlI+5dehLSHotsr8OyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnaY4AyA; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnaY4AyA"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109acc6c6so13249291cf.1;
        Thu, 14 Aug 2025 06:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178034; x=1755782834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv5hJO7pmx08JZp3b8abOcmYL1K7PY87EnKhcYbc4OU=;
        b=jnaY4AyAuTjm/WOS3MpPxZhdWK0JB2WjFzUBFzM6udhBw9dT/7ewMjdHVazqnd78ZJ
         PQAAZN95LTBk/Q2Qb9WhIbiRwzcF2jKJcHMB2ymYQWMfslvVcSdYwZY9bqgYe4CDqdYH
         0i/GOEn8lwzpID243Z50pHR/yGTCUEGGyyh30DeaIiRseakBwL9JvuAzoi2+4SBdTnJc
         AOuRhnAWFpx/2QX9HkKdweFSlgmgZOyI+B/WkAr7jKyDpI6XC8zsO2XLSbpdCYDtqj3t
         oxEA8LIV71aQgRvwMtmHaIrZ04GIdxYv57EY+CcgTQ9b5wnGYropyWQaTgrvwOPcUsOW
         EabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178034; x=1755782834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv5hJO7pmx08JZp3b8abOcmYL1K7PY87EnKhcYbc4OU=;
        b=Gku6MvG/gQT5G8fHyceASKG7s1tjON94hPner5lT4t9++DOGJT3xaLD5C876OTRQuX
         Tn8/6BI/bhK1eT7wHGTOR6Zdq0NrO4dHdgMkQ36wF0opE3Nug9ZHZrmxWGoyDUboN91T
         njVO8cKFoMD4f9cGhm/ecIPbkStnr/6xBKrmfaGI4GPfQe7IbZgZwRRiJYrzTI0HQoYP
         JNFAMEE3XI/NBiH99+UJ7M5l212sfyuNF8f1kf8w5ONAgTHq6Wr7snSRMvW5gBLV6PWV
         oQbvBrEWU568vdGomqi9KJ4H4i8gK3bVKuCQDa+XK8qRnG1vDXCYCz6sMFoKTqd+Yl/Y
         RKfw==
X-Forwarded-Encrypted: i=1; AJvYcCVZhrzz2yME1uVn/j8mmLM3H4nPOVjtF3AgqmOGH1XNTG+qgdJ9iWTpUeJamf3U464lwbLp/Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznAwR3shEX7QY4FRKOfIh5OzfQxM5gn5+enM6YaoTnyOcVlGwp
	eCUFow22IstIQmXVDMS/pQSQYkfq9Lf0a4Gx3fSn90gyjGpvfGr/JZDbISUifQ==
X-Gm-Gg: ASbGncvNXPO8uNc7OmzIW2R/mX/EjwCZUEqILornrMZGllOO41ao1h2ZK1WxeICB5fx
	iFkgeAPp1G0mp5q7GF6jEQjB5uZ8GWeXitjCvxAPPxRs7ko+WZwDbK41yTwDTJhpK1VadALBbgg
	g11eWHjkcxtH+rKNs4ZD0Ul6i1COP1FB3b5gNW+QtIlgfauLcxTCbafS5mUGaENyoqsVpSkhdlq
	NTrTku6UkHDoQniuNQaaWQKAEaBViTkRXa3l87CHasyn5auIF26i6sLot5oIT0xnxdjDPLMh/fB
	We8DkQr/0JZEpOsAW76lNcVEV3eEYuFnf/axYcatkYFc8q14EA2F8r6R3x1twjF+uLlKYYWokkn
	TS8UitAMPr5t6Q5pdlIOqDh6C1zvhtekcteIXtFlaSlF478kOEG6QsJnPZ9tkjgC4tkoISpqYnb
	vobR1VVTO0xoJWv6nEeVIF6h6UwQ==
X-Google-Smtp-Source: AGHT+IHYT7a78QQbVQqLuQVLypZAsnb56iHAr13WqU7lLnt78YaZgpJ38PGH+cb3Vh2ygxOX4MNZOQ==
X-Received: by 2002:a05:622a:243:b0:4b0:67c2:8fc4 with SMTP id d75a77b69052e-4b10aa7685cmr40527661cf.32.1755178033583;
        Thu, 14 Aug 2025 06:27:13 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 10/42] selinux: add a selinuxfs interface to unshare selinux namespace
Date: Thu, 14 Aug 2025 09:26:01 -0400
Message-ID: <20250814132637.1659-11-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index 28d0fe3b3244..70dc9fb3269e 100644
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
2.50.1

