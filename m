Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAD43E1D0B
	for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 23:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785455144; cv=none; b=W5GkCm9qtw+hzkV2crHK/+rEPdNjTrraWE88TTpJqrBnojQZKnRb07l9T1PZFRgDqokZ1/N+SJLnrpZ/vj2wa4ThnvOs15mBDyt0I6MBjVFma3u/qd4v75vefXHhZrgDpk9XhHmFAW1iLnM1J6cGT6YxsVPMEJrnFOQCG89NO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785455144; c=relaxed/simple;
	bh=1DTCO6Bphw0A6swBhP7c6bJyoFiSm1Y7s6/4c16HD9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfOnYlMOxSeZh3o5N7F22mgKfHsu8ygZUREvU6qmd3dJM5pCcjeAQGSe8DiL0gMLONWCQ9KkbwHgjb308f/iNmfYrfWE8kAl+km4y6gH3XoyDBKNZLBmCE2XLD9YvJ0rzdKJ5XcROvh8L0RfhJJcXza0WLY03z8HlL1auycnCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfjLWygk; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfjLWygk"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90004d2f7b7so5050486d6.1
        for <selinux@vger.kernel.org>; Thu, 30 Jul 2026 16:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785455141; x=1786059941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jdbK3fdfrv5d4sVx1r+AaPHs8i/JcdSeTVatYSVLKYc=;
        b=IfjLWygk/NIv3NmVPxmrP0TVaSWqUaKbpCY7M9WzUtfFuEvvAXTDbmNJ/2QImMbswN
         p3ojJExcqU2ybISntSW7GlrGZNXFo0+L68/9R2OxhV+YLPaSrvO/oXASSbHcagwWGLSe
         CWeMpmdTq3+TQoXronRoU73X6YKjfONZRXQ6hjX5hyT3td56+psaOvhIDq+q0e9Tqskc
         BIM7UBcK5d/lVN7trRdHWPQPh0tLHd3dT8riSf74/wy7THJpzjHFZqYv+GiZ0dGvhjiK
         3G/7qQen3YmJlZgK3SIfvN99ViIWa/7J3/20b8kqbrOPk661+TryN+3RBOH0oq9GAJWh
         pDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785455141; x=1786059941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jdbK3fdfrv5d4sVx1r+AaPHs8i/JcdSeTVatYSVLKYc=;
        b=F5c3yRUumXLRUC34V/yPdJnIVCYIUTUUKYSjsrvY5MoxbBBcgY4RdklpQ9lTGIveGF
         2qilbQU2WDjkHboyv8Hi7W/AQGgYudH9eg891++yQzibqisBl0Kak8TO8t0hhNmgMsCZ
         OPt++PuAo3PjRlBhrK/+64YudjdGaryac8TsvGtE6VEwrhprfI9q5USt+PGobmxSwI+5
         wX60GYYzR/TAbWRjsLJ5sIvf9S5wXz9b5xiSy7Xemz2LYg6wZ48Al+M0a7G2c+KPdcd8
         gssz7/9cp3HWajVnr9unLNpw+euMVPlCE7ZZTlCdYqcbkw5iAp/nByXgvN6PF2YCsg7v
         LM8g==
X-Forwarded-Encrypted: i=1; AHgh+RqYRf9cTWHZ/Yv9i0n45xZs5N3l2ssojNzpMOLAguSv6/CA4u4tIRxlK2T7k3j4KTavt1+GyhmS@vger.kernel.org
X-Gm-Message-State: AOJu0YyHayypUMuLoO8NtTaw3HzpTMRVBTS19H2TPhAw3yXWYsRD47cn
	gtKtKF9tIkiHTat0/gh0xqnAGh/y8ZUQire050y/BBCm8NTIzIgcaphs
X-Gm-Gg: AR+sD139i8DWXjsZHwR7W6rzsGIqEeAFU/H3jf0NETE+fwVxdonUZrcmp5pjk45bC1e
	h1nZFY/7Ahe1ZEsB3qMlTCndoVg/XHpeiuXOF41nez6rBCRzx0FuhJf8w9ND2LWZYDhTa4jMLBa
	EY/aYLWrpp14GAO/tH/UzJvxuU7EI6PBgl0omrWHPtb3AA2No8BXxG0KYGVSN0CYhZKuh0AxVUT
	lR4ZltK9VOP9Z9gzkVdmha2XZaxCvD5vbmA78jUt2RqU+QmU3BAvUEmqW4D+Ax00MonGSg3T1qh
	/mmsUbyFc+OGJ2K44rOqyF4kNPZjUNCiYud3j+9ONeHSyIsHCrf6GyFBxk/EaqMRgkyOAMGJURa
	6X+l+mfS7SnSNCu0TBV5J/hKIs6+ViegVOvAYzdCPzjDvXRz5wr9sZmPRneo/d+F3zYvgWk6dST
	+voq0nhv8mjpASN6UGsTFY2hQKvmQsCps3/NqulO7eCNsXWKZhxcPN5gmy/rrI6ufe9PiII9uVC
	QzpuZto42ltRhVreW4gzn6gBjqLCRluVp7wJiaOjJnIxkZgVA6pf5Qf2t/4e00=
X-Received: by 2002:a05:6214:5409:b0:8fe:9e2d:ce4f with SMTP id 6a1803df08f44-9083484849emr49532596d6.65.1785455140622;
        Thu, 30 Jul 2026 16:45:40 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908323e8bc0sm28991836d6.26.2026.07.30.16.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 16:45:40 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v6 bpf-next 2/4] security: add security_lsmxattr_add()
Date: Thu, 30 Jul 2026 19:45:31 -0400
Message-ID: <20260730234533.1912709-3-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730234533.1912709-1-dwindsor@gmail.com>
References: <20260730234533.1912709-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add security_lsmxattr_add(), which claims a slot in the
inode_init_security xattr array on behalf of the calling LSM and
fills it with a copy of the given name and value.

Callers pass only the name components beyond their LSM's standard
xattr suffix; security_lsmxattr_add() builds the full xattr name from
the suffix associated with the given lsm_id.

Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 include/linux/bpf_lsm.h  |  3 ++
 include/linux/security.h | 10 +++++
 security/bpf/hooks.c     |  1 +
 security/security.c      | 96 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 110 insertions(+)

diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index dda272d78f01..4bf350ef02f4 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -12,6 +12,9 @@
 #include <linux/bpf_verifier.h>
 #include <linux/lsm_hooks.h>
 
+/* max bpf xattrs per inode */
+#define BPF_LSM_INODE_INIT_XATTRS 4
+
 #ifdef CONFIG_BPF_LSM
 
 extern bool bpf_lsm_initialized __ro_after_init;
diff --git a/include/linux/security.h b/include/linux/security.h
index 0be590c40689..d35fde7aa11f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -406,6 +406,9 @@ void security_inode_free(struct inode *inode);
 int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const struct qstr *qstr,
 				 initxattrs initxattrs, void *fs_data);
+int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
+			  const char *name_extra, const void *value,
+			  size_t value_len);
 int security_inode_init_security_anon(struct inode *inode,
 				      const struct qstr *name,
 				      const struct inode *context_inode);
@@ -900,6 +903,13 @@ static inline int security_inode_init_security(struct inode *inode,
 	return 0;
 }
 
+static inline int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
+					const char *name_extra,
+					const void *value, size_t value_len)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int security_inode_init_security_anon(struct inode *inode,
 						    const struct qstr *name,
 						    const struct inode *context_inode)
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 7b98f5d1e2be..8f8c3de3035f 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -33,6 +33,7 @@ static int __init bpf_lsm_init(void)
 
 struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct bpf_storage_blob),
+	.lbs_xattr_count = BPF_LSM_INODE_INIT_XATTRS,
 };
 
 DEFINE_LSM(bpf) = {
diff --git a/security/security.c b/security/security.c
index 2ad7f09c1a61..ae72102cd29b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) "LSM: " fmt
 
 #include <linux/bpf.h>
+#include <linux/bpf_lsm.h>
 #include <linux/capability.h>
 #include <linux/dcache.h>
 #include <linux/export.h>
@@ -1376,6 +1377,101 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 }
 EXPORT_SYMBOL(security_inode_init_security);
 
+static unsigned int lsm_xattrs_used(const struct lsm_xattrs *xattrs,
+				    const char *prefix)
+{
+	size_t prefix_len = strlen(prefix);
+	unsigned int i, n = 0;
+
+	for (i = 0; i < xattrs->xattr_count; i++) {
+		const char *name = xattrs->xattrs[i].name;
+
+		if (name && !strncmp(name, prefix, prefix_len))
+			n++;
+	}
+	return n;
+}
+
+/**
+ * security_lsmxattr_add() - Add an xattr during inode_init_security
+ * @xattrs: xattr state shared by inode_init_security hooks
+ * @lsm_id: LSM_ID_* value identifying the calling LSM
+ * @name_extra: xattr name components beyond the calling LSM's standard
+ *              xattr suffix, NULL if the standard suffix is the full name
+ * @value: xattr value
+ * @value_len: length of @value
+ *
+ * Claim an xattr slot in @xattrs on behalf of the LSM identified by
+ * @lsm_id and fill it with a copy of @value. The xattr name is built from
+ * the standard xattr suffix of the calling LSM, followed by @name_extra.
+ * Callers can invoke this function from non-sleepable context.
+ *
+ * Return: Returns 0 on success or if the filesystem does not accept xattrs
+ *         at inode creation, -ENOSPC if the calling LSM's slot budget is
+ *         exhausted, negative values on other errors.
+ */
+int security_lsmxattr_add(struct lsm_xattrs *xattrs, u64 lsm_id,
+			  const char *name_extra, const void *value,
+			  size_t value_len)
+{
+	struct xattr *xattr;
+	void *xattr_value;
+	const char *suffix;
+	size_t suffix_len, extra_len, name_len;
+
+	if (!xattrs || !value)
+		return -EINVAL;
+
+	/* The filesystem did not provide an initxattrs callback. */
+	if (!xattrs->xattrs)
+		return 0;
+
+	switch (lsm_id) {
+	case LSM_ID_BPF:
+		if (!name_extra || !name_extra[0])
+			return -EINVAL;
+		suffix = XATTR_BPF_LSM_SUFFIX;
+		if (lsm_xattrs_used(xattrs, XATTR_BPF_LSM_SUFFIX) >=
+		    BPF_LSM_INODE_INIT_XATTRS)
+			return -ENOSPC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	suffix_len = strlen(suffix);
+	extra_len = name_extra ? strlen(name_extra) : 0;
+	name_len = suffix_len + extra_len;
+	if (name_len > XATTR_NAME_MAX)
+		return -EINVAL;
+	if (value_len == 0 || value_len > XATTR_SIZE_MAX)
+		return -EINVAL;
+
+	/* Combine xattr value + name into one allocation. */
+	xattr_value = kmalloc(value_len + name_len + 1, GFP_NOWAIT);
+	if (!xattr_value)
+		return -ENOMEM;
+
+	memcpy(xattr_value, value, value_len);
+	memcpy(xattr_value + value_len, suffix, suffix_len);
+	if (extra_len)
+		memcpy(xattr_value + value_len + suffix_len, name_extra,
+		       extra_len);
+	((char *)xattr_value)[value_len + name_len] = '\0';
+
+	xattr = lsm_get_xattr_slot(xattrs);
+	if (!xattr) {
+		kfree(xattr_value);
+		return -ENOSPC;
+	}
+
+	xattr->value = xattr_value;
+	xattr->name = (const char *)xattr_value + value_len;
+	xattr->value_len = value_len;
+
+	return 0;
+}
+
 /**
  * security_inode_init_security_anon() - Initialize an anonymous inode
  * @inode: the inode
-- 
2.53.0

