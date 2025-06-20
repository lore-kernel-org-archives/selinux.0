Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA8F2ECD00;
	Fri, 20 Jun 2025 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441532; cv=none; b=eb6sAngulqxBYneASM5vXLs7QfqTjcRPYoz70ZSR6di/r8YePRroFaWwNSj3YSMR038fVgpkPMuAwZGYMNv3I/xhWsOX0jRl8PGSrkrROfdnsH3PxUkVBBm6GoUFlDyJCBR/BiA2H8WzSqAbTc5ggk3rgP7a55v0iW6rpHYnU2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441532; c=relaxed/simple;
	bh=NWrJRP1BDnTC4hHbJryAXpcO2Xz0XI6wpmwPC3KH4tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPsQOO2pWAkKj/iEiJ/l0Wt1uOOcQk1epo4F5cmgjE8wdkuok9pNNHnUIXbuclaEG6VHNWpnGcTwTL+FCOZWlwc06UhqMZji2Qux2RBCGEhBgnlnrY3xLiAgVb83RdvNYzmZYl1JmTDURxeOQN+ZgUwDix6Co+rJKTZmP4aDEq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irflUGum; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irflUGum"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso22909146d6.1;
        Fri, 20 Jun 2025 10:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441529; x=1751046329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGbLtR/yFMO+YftuZOGPO0vupcz4A4/8uAE84LbuSxI=;
        b=irflUGumixQ6/4z1A5KJyqeVkYME2pVqpVXIHoR8OxWXGtIqnAsuIzpDETDWn9gFDR
         Rb/cWNt8xB/su0/1d67zOg28sbfd7v1zqbJnv3rjZoEc/me61Jo3m8SIatzHhsBxcn6e
         kCiP8I6QreXsz8/CHKSPprysacNJnfBOjqDaC3/TmwwiU+nFoXnQmMIflJ30SPjoA1E9
         IiX2DuCualdsZClR0FCleYXQqzFMUu/dh8GYAchcK/26ftaleQ+VKSUXwoKFW+2/Jb3H
         xxULwDIyJDIUankHLODOdpdnlc+8Orh7hPUnsXOy9Z8ONQm0P7GwuDbTEgDKcgb2IoO3
         QybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441529; x=1751046329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGbLtR/yFMO+YftuZOGPO0vupcz4A4/8uAE84LbuSxI=;
        b=Or3+LnRRxZfMMNK4u7OFTzFmMh2zaLnm60UIS7Cwej1p5jAbvEgv+c+319GPq/OfU3
         6lJfA22MkQANkbXVdFmoeVxMvf2q/trwj6vOvEMU3ok0px1BeM13v7PMaMsCs/2NRnAl
         s2OmIJhC/wxPmWoCa4XvFIpxQSGI17CmtA9WJQ8U5O09qe5OvD3gqL2AWirB9awx2Zww
         AriqaV0mGWG8RnpGsHDAmveTZjx/9IUI1SFmOwnyP19w8TjhFca/XPXwDVJDXOHfn9cN
         g8+3J2chiIpfcDzXZr3SX4jAyAzVWbQN7AzxEBiuydhcxaA8JbIFD8jmnzc5xocXJOda
         ymDg==
X-Forwarded-Encrypted: i=1; AJvYcCWvoUPqBG8keEXkWSh/Q4vGvDVrgHCBn8lrtUdZECnFRGszGzLpEbIp0rRMtaiTlsfIKexXWCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObvyy6Garo3I3R7gUTdWbiymv2B2HKFocKkcFMSt/QAa+X1MH
	UqhFKVTixtQ5HQJS6/Z3YYegARhADupLmRJtUYHv4oZVwp7y2OLMt35BmzfZUQ==
X-Gm-Gg: ASbGnctFQ3S90NnU38k1uamtYVpdTHoKZnTSYEFXn4NpARAxjkVIfTNgCLl7BIVkAxi
	11oHV6xPzenzAVv+PSGvT6llPSQLOVVO6jw8EACLPKf8O6XqCE9w/bw+ie01k4Oc186dLpX34JE
	SZN5nf6nR6/jYR/Pc6SrqO5dlAC1p2W8tJAOAL+U3sYn3g+yIyl/kdo5n/0gpjyFnvWZBZic1kl
	U8XijEGi8rGKi3pUCnlxGYGNa3Xddp8tc1MKwxCFgUM1bh7NoF/Nl7/6qH/Sf6+103cw6YbZeAK
	H0sEdc/5QQAtyjXW8r8sPzdxqQqMFjqfq2qbWT3275mdNEHXvmeVwR+6JVB6gpls3WaR/jWLHaU
	INZJihz3wZ1Nr/DZVQ7AoGSPUwt+vFiwtKaaLSawjp1BmF0eIbDaiK5r5hXkEB/uzrg==
X-Google-Smtp-Source: AGHT+IEwFpOcQg0pfw1Goph2SrhQjOf2bagKIu8tR4a/KciBRiuWpW9A0iAByuh01vZRSVSCpDBC0w==
X-Received: by 2002:a05:6214:5405:b0:6e6:5b8e:7604 with SMTP id 6a1803df08f44-6fd0c94d42amr47435806d6.12.1750441528987;
        Fri, 20 Jun 2025 10:45:28 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 11/42] selinux: add limits for SELinux namespaces
Date: Fri, 20 Jun 2025 13:44:23 -0400
Message-ID: <20250620174502.1838-12-stephen.smalley.work@gmail.com>
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
index 986fec6c8e4b..bf75cabdc86f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7788,12 +7788,23 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
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
@@ -7808,8 +7819,12 @@ int selinux_state_create(struct selinux_state *parent,
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
@@ -7829,6 +7844,7 @@ static void selinux_state_free(struct work_struct *work)
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
index c8934489098f..176db64d8afe 100644
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

