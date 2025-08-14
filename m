Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184EF3019B4;
	Thu, 14 Aug 2025 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178038; cv=none; b=kvY7fGGCj0E97zCvLW8Roz52PYaQPC2djbitkElg1M83oJEbFBVS6Xx8Scj9gyqyBkyOl6Ir/2s3dS03NK+afTCDyZCLLOfWCYFUg7+Bc9EIycwgdh1M40dHdgEDNVD6f6Rod5Ok1iiuwnonUz4cDWEzQpcryWZHQL0D2mC55WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178038; c=relaxed/simple;
	bh=MQUfFTxqmoL5PpyBnrDWxHzpkEbDYJrAVZ7230S7Qfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skJpBzWq/+ezxvfG82Gj2G8e8spGLgvS3rvFQ4JS9Uxvsopjot/1x3CxtK3a/F3bJ+bGG1L9I+hGkN8U4RFU2CZp1cW81wxVxPhgMncn2q0Wahec1/+LF1ePNLYus3XlVt35wULu9AsL/2HNmoA3PYNp+DyXgiTrcRi8PRV/w9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iu5xY5dn; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iu5xY5dn"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b1098f9e9eso13085201cf.0;
        Thu, 14 Aug 2025 06:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178035; x=1755782835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmoKHqfku7VbpPRm10zu81J1HX6IlO1AjzMUEHaRc1c=;
        b=iu5xY5dnXEP1pMlWzO9RroTR62jtSqMQr00t6rSh7smBkffATU1PUmrn7am/z39I/v
         QDORG4Or1HPQOgk+yVJYMbd+yhJhY+28ArCsf5umwCQWR0KWJQCcf5zhpT0kiIX8iLGw
         NwvaAYrfJvi36iOAvE2Ok6SBbN4U7+l/v20IFg5KXyvr/w0L/+0MgcRQLHHJ9sR9k+nV
         QJitS40NXYktomSNmwFT6bk+dN9wwRhlR/3eh2aaE6hFss9o4tmVVmDOZfXf19TylxjK
         Av/gWxTAlMsGB6L8Qm2hXELZK4LP4fP8eFEcKFNe7mErEYqaknADCsUESLc9d7uuwEJx
         3UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178035; x=1755782835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmoKHqfku7VbpPRm10zu81J1HX6IlO1AjzMUEHaRc1c=;
        b=W7iTUyPnQjGuzR77Gj+tb2nBNnzN8gjnNHYOYGYAtYC+ofmdpHQZNHcjgNeZ/32Y+j
         rGWIQwEq/SwQxRTmpvwUMKr2qHbcPXCAnpkRuUbe1PIfj+yFk3W79hnyhzBVvkJifUEt
         VhbOZRqQyzeg3vBIyw5zo0sV6ca7V+OyerxIX/HgfVUx0gB6AjD1oh2K+3k3m4weQQaw
         rV8n2DxppALegG9w0IgSJor/eZeNVwIN/oQ1rxIykPTyByHYrUCdW6LK2NWSzrv4+kCl
         hDQvAb2EIQs62ZbkWVGMoBgUSG165Fd+8Lu/SqvixtpBBqfKvK4TFA2MEUH/lCjoE4vo
         Ti7w==
X-Forwarded-Encrypted: i=1; AJvYcCURd205sRz06D38QRH1oOb7gHhCLs/2VE8Ampgtc2avzwZzoxyXgaXBnDYJ6ANOF8K7cD8QKJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jCco/Q6L9SiWYcgWW3Png7djUmAkB/YrXw2WV+mTUOhOQ8gx
	xtcTTak+nejjYGUppTG+DFm+PBogAgdnr8EGf9ISK2QYn2lgCj4P1rXT09Cqqw==
X-Gm-Gg: ASbGncu69FZqytNZ6dpOOQgWF/qnYJb0tdocbokq/mUJiV8Rz08mnlt/3mExalGoxy2
	h/n7OlSQ8Aq3PDOGhavb2SR8jDSe8EZYGlsnKwnaUlQcBGbjxdKyr+wQab+aJ22wLH7JNgzAW/C
	BuaOWrTZ9wZ+W1NQ3Ga7AG/0oQstkNMK/qLmKYBVtbYg7CD22Wva9LxHhMefbfmHj9cUgua1t6R
	rPE9ZFcCRPfeXBBMda+slKU6i4UO1gSSJ7Bnenlsrc1KHfRvuiQl+rIgg1j6JhHYpExuQmM02q8
	022Rl9R1DfmhuCpGvHB6xZjYu89BAGYCRMltPwzJj8gFidAo3Oyye/aMIZCYpGkjc/UdD3jFQUQ
	dG3MDMWfqno7SqKaHSOsHJwyXq6bfa6cKKFsBis2S0IA6KFikMY/DLkuxUzrBvYJA3FmTcJMMpO
	JLjGkHkQESCm9Fg3578hDfhKlyQg==
X-Google-Smtp-Source: AGHT+IGFzD7DVc+OsYlNh5My09UFDjd01244oyk0eEfxzWXq+tYG/WgKtM5IWRSIWFCJkN71hTdmUw==
X-Received: by 2002:ac8:5ac3:0:b0:4b0:9814:e225 with SMTP id d75a77b69052e-4b10a849022mr49052291cf.0.1755178034686;
        Thu, 14 Aug 2025 06:27:14 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:14 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 11/42] selinux: add limits for SELinux namespaces
Date: Thu, 14 Aug 2025 09:26:02 -0400
Message-ID: <20250814132637.1659-12-stephen.smalley.work@gmail.com>
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
index 65d9762b992a..739f58b134ed 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7802,12 +7802,23 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
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
@@ -7822,8 +7833,12 @@ int selinux_state_create(struct selinux_state *parent,
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
@@ -7843,6 +7858,7 @@ static void selinux_state_free(struct work_struct *work)
 			__free_page(state->status_page);
 		selinux_state_policy_free(state);
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
index c4a0766aa24e..d8312a39a265 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -111,8 +111,12 @@ struct selinux_state {
 
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
@@ -136,8 +140,6 @@ get_selinux_state(struct selinux_state *state)
 	return state;
 }
 
-extern struct selinux_state *init_selinux_state;
-
 struct avdc_entry {
 	u32 isid; /* inode SID */
 	u32 allowed; /* allowed permission bitmask */
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 70dc9fb3269e..06e2aeb478cd 100644
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
2.50.1

