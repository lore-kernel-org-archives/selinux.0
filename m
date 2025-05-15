Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F7299AA5
	for <selinux@vger.kernel.org>; Thu, 15 May 2025 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314627; cv=none; b=Wb6HHXjd8LYT80vZ8/IsNfS+flnxAoCLyXnV1Som1jYCvAkk0oqlyPfIaWnyxADm2+cmPVWVGKm9nmJWQ8bK3xFI1Qs8+ZfTHkhbuEIdCGQ9GL9N+raXBCGE7mVzsoRjTxpkdVUv0aUNbXdzwIHGSK9zX9/AKrsxqErwEggTY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314627; c=relaxed/simple;
	bh=NHvELjOInv8yMyBnJSwivJIIMhUBhy+VaoQOI5IyeDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKTFOmmv5mShMghetHQy61HqnKpBYGxOO261/bYEwTHBEc7Q07Yxuwh3q5SMXowdEefj2ShvfFBvxsPTnZOKA6AN2yxozXKWdUiIFXl66fcIoj6QeTYWwmpWti3BP4FH8u9kjlV0YDlGWDptQrgF1mT/x+PCnAKaMM8qet3jGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faoqWbCQ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faoqWbCQ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so11121966d6.1
        for <selinux@vger.kernel.org>; Thu, 15 May 2025 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314625; x=1747919425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LynijTR+OE6uZxYCsdLUshyXqR5evguJi86gF905UkE=;
        b=faoqWbCQEcoo7AuH14FxWu5Uc85JBOu0ep3mQ6ZWKs87E9l3mLK4y5eJxtKogpAxKx
         48+4tzuCyIWA6O5ptvT66mgHu53UPUmUNmQNAoUahbOP5eJ+kCcgeGEgj9qAXrO98d5P
         i2tqHe+mspkR927D9ttYi1paa5LnNLCNCBW0UeWKeg5mIoICRJNAs2+PgXqBYyo0syBR
         +Nay5FVzWkJhMMxsO3X+O74efG3k2wV/XYVD0Ov5QZn5IzhwFRV84Hv2XmRTMiMrIw1q
         dYhhlh3Qr99wW2hayu8+T32jMS0HkkOCOf0SpYqpKD5i44kguDbloGcsMjwN+7vPE8lI
         JJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314625; x=1747919425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LynijTR+OE6uZxYCsdLUshyXqR5evguJi86gF905UkE=;
        b=vaF0XGasEOzSvBw4cGjIqIAXAk+iQ7p0n4fxsamDxoXJOWljxz4Pxi3f0twpG76T/P
         5/Tqazp9zssjQdoe9Ulj8v8dWqUtUF0p5hZaUeWxQ/SaDM+ruRtoqOo1rjxpZEGbrty5
         oO/AyOg+gJyjLot5eg5cFcZG+KpID5+rMhTm0GxOSC1y+mDCqyaag7jGG+tU69FuHnMS
         TPWL9m/x98j1pCaB9DbZRZKwzGuuOGxQ/wUYLMIY3zNI1B5NjeQn2DF0KPvCIst/6u07
         Hyiy4CznXOc+e07y/S/VnaymsjiZxUtkvlV3DIMrwBNduH+GlXkIJbSlre4/S7rvRmXw
         70NA==
X-Gm-Message-State: AOJu0YwRkMGEoIXkMtwgQx/zNFB6MvVKA7rbxQ32U7IV80AnWM60EjR7
	4K3sn3vAtxXUu3ugJ/RPj99+lTbDSk7meXx7kFq6hrt4liEUgF3S8bkzyRcW/w==
X-Gm-Gg: ASbGncssfOSmoQLp6vB7BucXgP04/8H2VZClQqpfId204au9EoVWK1QIxw8B2wtBCsD
	jyz6f2SVfS3XiXR4+ls2bc6ebRiB5VEWOvv4cMhcoR+SQr0QAKB44+nAayJYx/fsS7DP7kOF+iR
	HymNaKjIf7+yzEZCq+2uGXIwZiSRrPIjlowK/j+jy424uZ28K4NnZE5wU9EWbjvp/xNmbRXLugE
	7fD9p2FhEWNeBIUx5XilAWGuyJUOZzl/yno9F5lo4Yrs5JAMzC7Pn1rEWuWJlMvO4/DXwBNXILv
	PlZAtn8hphNm2+Tk2XgDF6wj16ULAdOXHDEu44yoYsUgEseUEE8vfbPyjHUxLcX4q/T1cWnwagm
	HJ8RoX71Zv7oO258hK5y3TzqXcHFGv18Ydi2KdfyS+KjD02WuaiVWoQ==
X-Google-Smtp-Source: AGHT+IGRKbqB4+If7Jr3x6xVxhPdZzPRKoGg5SxQa49x81Mz5AdEXzXMTQYV7DUODKG5qSysNN7/zQ==
X-Received: by 2002:a05:6214:252e:b0:6f5:3c52:23df with SMTP id 6a1803df08f44-6f8a31c3c36mr46080926d6.11.1747314624706;
        Thu, 15 May 2025 06:10:24 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49452583e88sm91723891cf.63.2025.05.15.06.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:10:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 08/49] selinux: add a selinuxfs interface to unshare selinux namespace
Date: Thu, 15 May 2025 09:09:06 -0400
Message-ID: <20250515130947.52806-9-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
References: <20250515130947.52806-1-stephen.smalley.work@gmail.com>
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

