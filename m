Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA5515666D
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836360; cv=none; b=lTHfzTIzgCMP1MmIMies4WNa3hhHD4oEHBINGFxlUs5ZyAl/cl1QxVpBgYFsj28iTLA87m6njhECcs4rRtWkX6/Xh/aQ03bNl7R8zrC5OoiZwZNzaoJPA2U20GZcx0P1iw2VCWnsYKKV8djp4kd6Ma6i+EKGpS8iv/7dgwMLqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836360; c=relaxed/simple;
	bh=tnt+dYF9+EbojKI/nhUuYqtuYU/Q2ehcJ32yJ/WCgZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UjOVGsysSXl4Isg6gVWb1kZFYFulwC/LQm9nXyvKodfP+7Jgeg1FxLDECt1/3DZkhMwlQnpzsdZ4a2dwW8Tc9KKPg/4BHo1yeAEQ3xqFMMvNVVhIG4q7VvIiT9Pw7aaJ9AO8ENoiDPsazOnuNblZQV5Em9tiLXFVBw9PZbfyURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8/74Tqy; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8/74Tqy"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-468f6b3a439so99974571cf.1
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836356; x=1736441156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tgwr+4gxBk66JtaER6US6NxWymV//BwWwTpMKaSgKoU=;
        b=Z8/74TqyFGCR1DXzrwFw5DdMwbHzAQXm1znUrpT6GI+RREb8Ux4YdP72BpWTKPIOc9
         gEWiVewH5Ugb1Zq3y84peXJ80EXAA3srvdy5hQTVo7JQbdHOUBULUJhg9fG2y43yvMBK
         li9jeMyjF+YHEhcXUTR3hPLFUS/y1i6K77e7gmHlG/KOH8IIma2B4iqLEENxuE8GFs8R
         jqx/C1431cC5OHQq7gpSEXJC9Hg3Fhk4aUfUjfcYWd2Rh00Jz+BpRgf0Sb1A9mAhoO/3
         k1YLMEsFM4GRpHg7CPhZ6i39c0VgmeIipumKVUqscuyLIkF5FVAQtw2V2q/6/S0KXzbq
         Yj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836356; x=1736441156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tgwr+4gxBk66JtaER6US6NxWymV//BwWwTpMKaSgKoU=;
        b=YTAwThIbKDF0/KaMLT3svAsuc8k4XqSTBTPyFzU0Sly5eqK75C5fYsuAD0QKTITScQ
         L19+Updy8bVnvezcjnldVFs4UJPwQ/xtr6j/JQHIwJ1Zf3H+GijrpDYQBbJ35nEF4TgE
         Ei36HyKxAVps0ry6vQ7m3my3MYZIzdPPgkLBOFB0ovvK8FpLdmAyHZItQ9Glil47v9Cr
         HcZBDVlMxTFRgWDW00S/SFJCF3k/QePKK5DLlZHo+I0nhLYfMf3TP7zFOa5XU508xch9
         nbW45l2MOUjS4UFWq+IFtfAyT9nE3exUlkzdv3KWxZK3923vbL1WM+pjeSDTvfAqvU8a
         L+9Q==
X-Gm-Message-State: AOJu0YzOMz5taqTQH5dNTpm5dkavoq5WZh3ci0m9mvTlDI8TglU+ljq0
	mB/w0nzhxDCa1LGwDwOCi07zlQ3gW8OFLSWpMLNh/K0f5SRi2J5lQsGUNA==
X-Gm-Gg: ASbGncvK7lhvzT3iH34XWVDOvFmKb/xK3sUfkRi8fxT+s3hB4HVNv8ZSwC23SMcBHHu
	CsPpAn0dIJ8+t4fZt0CHjIGsRc/ZUuXS3KQwIh6Q9Jiozfig+5TvpOfoFLpzFLCb7QHKraLELel
	EQtS0Eb6LHrpDVhF2UckB7uYpnnLlY1KoPiYkFU6TtanQQM3S1H5i89FVo4JVqlJVwxyl4HcLQX
	u5E5lN/PTP3YStYqAlaKlszj9zqDqejfWDqVJdiGDkaR3ypx3e5kN9N64jj+lyfNDzIzdjIFIU5
	KJnCsIiWgm2xBOeswJIql4lLNgOl7gM2bnDCJ8xNLDbP0JXSfmErChTm0H0Pm0j1wONkTA==
X-Google-Smtp-Source: AGHT+IFZGBKouJkfNLlLDgyaYBzB/5LNDNR6bNZWc9x5TL2Cm5Ui+b6+X5kTJmLyWM55enY35gm1sw==
X-Received: by 2002:ac8:5a95:0:b0:467:51d7:e15 with SMTP id d75a77b69052e-46a4a8b8697mr762823341cf.7.1735836356077;
        Thu, 02 Jan 2025 08:45:56 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:55 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 30/44] selinux: add limits for SELinux namespaces
Date: Thu,  2 Jan 2025 11:44:55 -0500
Message-Id: <20250102164509.25606-31-stephen.smalley.work@gmail.com>
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
index d9a1d2e075a8..3bf4428ccfca 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7571,6 +7571,11 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 static void selinux_state_free(struct work_struct *work);
 
+unsigned int selinux_maxns = CONFIG_SECURITY_SELINUX_MAXNS;
+unsigned int selinux_maxnsdepth = CONFIG_SECURITY_SELINUX_MAXNSDEPTH;
+
+static atomic_t selinux_nsnum = ATOMIC_INIT(0);
+
 int selinux_state_create(struct selinux_state *parent,
 			 u32 creator_sid,
 			 struct selinux_state **state)
@@ -7578,6 +7583,12 @@ int selinux_state_create(struct selinux_state *parent,
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
@@ -7594,8 +7605,12 @@ int selinux_state_create(struct selinux_state *parent,
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
@@ -7615,6 +7630,7 @@ static void selinux_state_free(struct work_struct *work)
 			__free_page(state->status_page);
 		selinux_policy_free(state->policy);
 		selinux_avc_free(state->avc);
+		atomic_dec(&selinux_nsnum);
 		kfree(state);
 		state = parent;
 	} while (state && refcount_dec_and_test(&state->count));
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 84285fba2c06..425cd18a1fa8 100644
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
index bf2d13227113..830f890b4cb9 100644
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
index 590c883ae86d..7a0947dece69 100644
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
 		/* last one */ {""}
 	};
 
-- 
2.47.1

