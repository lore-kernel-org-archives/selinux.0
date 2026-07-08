Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01490175A94
	for <selinux@vger.kernel.org>; Wed,  8 Jul 2026 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783469406; cv=none; b=famzv9XFbclIiLzf3fPfIw7U5g4vEpfB6TNvnqA/qqqtUdvMq5iGGJDQanzdr+drA8TMoj3BukJZ6ZpooiZyg82rgZPbOvQT0nQ5eXmdndcE0qOIYCwUF0NVLxLpasfXRvveZnLIKlgqp0w4Guy8Ai4POcT4sQSDLuM4EhC6+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783469406; c=relaxed/simple;
	bh=5paAE7FcwR2EAGMv6ATIvCwCHK8moB/MJ/jdRXtXdK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6O/darolTCDr1hNPvJeSHlzuM+wcvv22gl6I3+dS9lX1/32hx4B9owsRP/JMA7MFJeakSGPmQ9lMtOEiNcbu89p4yTbS/gOciyeYUmC3cwWXOyqakx/wbaifAj4ju8ZcjdHT36TndRvvwbEuPGN9w2vjIvA39P3Oa6sPqp2rOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuAn6QDg; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuAn6QDg"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e50c5d14cso1944385a.2
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2026 17:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783469403; x=1784074203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5d7fbQwym2HIgVRnDv1JutJFyLmAUJ8aFrpYmfGtZs=;
        b=UuAn6QDg7TzhKkdh0r7yGQXXc3Uq+WJb9ODMXtF6L17F4PL1UWjCZl3Uw25JjIhGht
         QBvIw6FC6dz0zTcQ+pgOleJY5gjbuMrKzjJR2kLYFG/NVsz/9KbOS6vBCtHyfaGw0RH+
         GezOXCtCDkWLZ2qaeDO9KKPQkvRvxvRJJxVnmCxsB40eJMmwnpdBlBN+CQH8RweOYAIy
         hw4rUrrzVFqq+wSAQfDfNRIwq0FF3FjyXonh6AimYjWWtzVsJmer8erzylurjvN6ZHLM
         KAQV8Cj6C3/xXUwOe6FNc3UATVxC90S0r0BXZ+dNK1YuSg9xq2x7Y6NfV/HWvxdnkCCu
         2Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783469403; x=1784074203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H5d7fbQwym2HIgVRnDv1JutJFyLmAUJ8aFrpYmfGtZs=;
        b=NLleOh7XB2d1bg09KkRQ7e6ohwNKKx6bzuYg5yeM5zhGJlUWRxiJ49s2WKMcPiSu0k
         sGFdJwOOB9LwCAzbdoXkYyqdnA9/EBvGrlzQGPduJ3FNMonQvuXp15Uxk6YThholq4dl
         c8qsm1gSBV52VYng9dmR3+F7BnWBthDY4gY4Hxz53pOB1qDERxPbmnjdbqrYKNROvBLr
         hkD+pexi7MkX4dLOMkrmdZtSNJrllWuHE2YnSLD9ClOz/LUmvMcTulsoq06mHx1nFYkF
         s0CJYt9eqil7awhqU8pVJ7kpf2qJnGhHgbe/vXLoO1d8w532O7DADrI8XmkYIwDZ5H+1
         a/kg==
X-Forwarded-Encrypted: i=1; AHgh+RqT2LTmoNeowNE/81cFM1O6BfpOuRUeWBxjeV08ixLGgUGM01lFDNNwW+uL6wolxWiUkNztaF5C@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1LqOatb72NAcfNKx6fS2P9YWsJrqNm0AQv0dh+GM2tNmcP0H3
	6OusBSck2sewxrrSdmYUhP85IdaDs47NCPgVFZ0QNcovjaWJ4URveA1r
X-Gm-Gg: AfdE7cmuxirEMC3y1DphGrJ7VMcnfk8J9OMrSLYaqDtTiukBeOIeOBgUNJULrLNzpfW
	O74QarFPt2moA2RJdDr6CO1/IOISsvWkO0CaiNUxw7QqQXAnNLo1HX/h/08ZBD38aHapQ4dp1eU
	8ngfI2y8RY9/U8DgL8q1GYSbFE+tdBVDSaoZ82x2AwBYUETPq4N6n367bOTX8ZkjUOK3OsAWN9r
	yG3qrJ3MFqcE89BcjcqHwrumJA3ePGzXFH4DtQHAx3T3CmxHMiYh2cxj7efwept9bABx5oXeMK1
	An658PzQ/CQ51/5Pi83wI2lUNTD9hXgqEB/HbBEC3/wrzzL2P1+J/4RRDUiCnUYtSaA5wBb45OP
	RmzYNJvfeSET5BBmaYdaSnrg/LUqqYpCiZrESqdDGAd1VU5rB2K7ZPoKJr2Tvw5Gwc8tTgcU5uo
	nevlTXHfCUTtXVBpMrYPXUCY9k7r00bmwmLHGIqPyPi4PCShFR+pkeZvhMvZ5noii6tDfreKgiR
	DljOg35aGkhZi0=
X-Received: by 2002:a05:620a:8804:b0:92e:59b0:df08 with SMTP id af79cd13be357-92ecf5bf0d2mr8803585a.3.1783469402697;
        Tue, 07 Jul 2026 17:10:02 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e93ea5ed3sm1191281885a.29.2026.07.07.17.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:10:02 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Tue,  7 Jul 2026 20:09:55 -0400
Message-ID: <20260708000956.46138-3-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708000956.46138-1-dwindsor@gmail.com>
References: <20260708000956.46138-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
xattrs via the inode_init_security hook using security_lsmxattr_add().
The hook now passes its xattr state as a single struct lsm_xattrs
object, which the kfunc takes directly.

This kfunc is only callable from inode_init_security; the verifier
rejects attempts to call it elsewhere.

A previous attempt [1] required a kmalloc string output protocol for
the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
provide xattrs for inode_init_security hook") [2], the xattr name is no
longer allocated; it is a static constant.

Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 768aca2dc0f0..ad0025f2264a 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -11,7 +11,9 @@
 #include <linux/file.h>
 #include <linux/kernfs.h>
 #include <linux/mm.h>
+#include <linux/security.h>
 #include <linux/xattr.h>
+#include <uapi/linux/lsm.h>
 
 __bpf_kfunc_start_defs();
 
@@ -374,6 +376,39 @@ __bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
 	return d_real_inode(dentry);
 }
 
+/**
+ * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_security
+ * @xattrs: inode_init_security xattr state from the hook context
+ * @name__str: xattr name (e.g., "bpf.file_label")
+ * @value_p: dynptr containing the xattr value
+ *
+ * Only callable from lsm/inode_init_security programs.
+ *
+ * Return: 0 on success, negative error on failure.
+ */
+__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
+				     const char *name__str,
+				     const struct bpf_dynptr *value_p)
+{
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	const void *value;
+	u32 value_len;
+
+	if (!name__str)
+		return -EINVAL;
+	if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
+		    sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
+		return -EPERM;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	value = __bpf_dynptr_data(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+
+	return security_lsmxattr_add(xattrs, LSM_ID_BPF, name__str, value,
+				     value_len);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -385,6 +420,7 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_init_inode_xattr)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.53.0

