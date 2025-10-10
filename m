Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823484A02
	for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117461; cv=none; b=N9uxGBK5xIXBXuRXkyJxZuuO+6dYKGkVEoGTGwWuczEHaj1FmaxmeAVLVwWqdfJ+uOCRpZnwQeicukU54rMRurNnCmRZERJNtU5SWAO3B4vlTLsPMEH9rvJGAdMHdX3t/VF52EgRwMX7qDtr0KM8Fizlhvr6coJRtuwPP+mJeqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117461; c=relaxed/simple;
	bh=vB/cYcI8x+gTwvwPhVduLTkqkbgAKKhGGYi6O+IhHng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NhNzSPLSPijRzmV5Ia+8Qo7f476Uf4Q9zOHUSUvwfx5nnID+gztbYU3vqOChtABHEH/ssJpgMUn9LsICez7ry0Hgmbv00IPzR6BJHshqT76HWX79Im+zyKM4nSKxr7hBR9v/7HlMkMwJNokRgdUvvFawgJpZyig57OlBawibduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWH7GcC3; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWH7GcC3"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-85c66a8a462so336420285a.0
        for <selinux@vger.kernel.org>; Fri, 10 Oct 2025 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760117458; x=1760722258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RxZrt5JfnjJInGP8+AAgo7CXNqoTAKoTqnBi0GJ25Rw=;
        b=BWH7GcC3gUtbZxPOn5VCWS/DoqFxgTuwxNtzn2oA/sQhWCMOXcuWYGJz2AEKuxZyTQ
         HCSO1ExULfozQs0Z9pvRmPZXi90GnpzepOPpyJTRDeoCuhw3tDXv6l2xjY120RxaIPHS
         S0irui22FpmeFzMm3y/vrgO7P0AUNuEUkgF90vbgvP1jWeg2d/78kP/SIXXU3z8k1SS2
         NhyaGXknn11hWGpiknODpbNyP0837Oy5SjTxwt9r59C95Xl0CHTRNeOstThkITno8XAQ
         Urz9fpLowpUKz2j0apA8TmMrrd+A3V+qSDrwe7vwo0LuO++vRG6cv06PvzH/tSAxdEaV
         sFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760117458; x=1760722258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxZrt5JfnjJInGP8+AAgo7CXNqoTAKoTqnBi0GJ25Rw=;
        b=tn6DntQsApJIxgDu5mtDGW4hA8fH5Nh/TVrFFgVqjYyaNPKBkA1xASwd/W0Psdd4PE
         MXWb0J160hEFOkEoEXwMr76ATJZ/D7Cez5FKqjCtlCHrEqQZGrbp4rtuSgiDxVogld+z
         nkUEuorkXxZXnI0FbCLRwOuNFRb0Dl/znS433PW5ulDZDmwvDGfabfvHdYuRsqyf2u4B
         zyJNqtvv82/pv/fOI8HRFisILljtnLb8HqFLpjpM4eoVXZWgR5IOnyozj5sPU2YeeYiM
         FO76CylQA/bGNyB8QxOKez+/T8VBhZuVEEHy/Udb7eAX88bPefur7xpJNho67IpL9dDG
         +fwg==
X-Gm-Message-State: AOJu0YwZ3C78SQZj1LLyzTTCBYLYV1liE9nEcOAOlY7gsbtX8JC9q26a
	8AUm3lk+K3paPTzGiMtP4RDIqqLC8faeEzyHYREKPVAsKznXooOd7+RrxiNfSw==
X-Gm-Gg: ASbGncsh/vpIDTdHIHwyRmVvtL7RdUwzn3iMkEH1dsvqoyU0O05sFJCw5896sZN0ICY
	jXnqTMFEQfh+0dmizN33Lqx6/QfLu/9hdyxLueYR8YGWIdSQeC7R6Y0hOOJC75b8mlX1z0fJdTb
	Sg8RBTYq8cjRt3arxh9xVJdiol71PvizQ38DJL0Rq0JEfg9+Pddh97apYlhRhdlkGSzH5otcuhX
	xC5o+KKHL9a7BfwEccOndUDGqBIKRebkKGcqKKt8fAn3lO7QAUXqOo0vZt3chltwazS6TYYPmc/
	EpIrSvLpu1ZqwNkUEmCZ/+m6tAb0h6Oo300HbRlSTNQ+XLNA0tNgKYmaiYbvrsesmSAj+c6LKll
	6JwxCSgL0DePz35GfBQF/qJrsjeGMo3tuvT/l+/6vF5wx02WrXUd9vUegcb7Y8nEOrtLmYx9ZWl
	ihRqgwPfZgdmloI0tdnNg0Ue7uEkiHql6Em0oe9LH6Sg9LHDEn/gyO
X-Google-Smtp-Source: AGHT+IGcR45CGiyjY+anih6jy59wtB8jArTXMrqhRSQk+lH3uZWKOqjdA4uUoJn6k4Ch/HEXOKfuPA==
X-Received: by 2002:a05:622a:593:b0:4d3:a453:c503 with SMTP id d75a77b69052e-4e6ead7c972mr187719901cf.84.1760117457773;
        Fri, 10 Oct 2025 10:30:57 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e706db1f35sm22026241cf.37.2025.10.10.10.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 10:30:57 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	john.johansen@canonical.com,
	casey@schaufler-ca.com,
	serge@hallyn.com,
	cgzones@googlemail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH v4] libselinux: add selinux_unshare() and is_selinux_unshared()
Date: Fri, 10 Oct 2025 13:24:55 -0400
Message-ID: <20251010172454.3097-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a selinux_unshare() wrapper for
lsm_set_self_attr(LSM_ATTR_UNSHARE, ...) and other required processing
when unsharing the SELinux namespace, and an is_selinux_unshared()
wrapper for lsm_get_self_attr(LSM_ATTR_UNSHARE, ...) for detecting
whether one is in an unshared SELinux namespace that has not yet been
fully initialized.

Add a selinux_unshare() interface to unshare the SELinux namespace,
and an unshareselinux utility to run a shell or command in its own
SELinux and mount namespaces. The selinux_unshare() interface expects
the caller to have already unshared its mount namespace and created a
MS_REC|MS_PRIVATE mount of / prior to invoking it so that it can
freely modify the selinuxfs mount as needed by the unshare
operation. The unshareselinux utility demonstrates how to do this
prior to calling selinux_unshare(). Upon a successful return from
selinux_unshare(), the SELinux namespace will be unshared and there
will be no selinuxfs mount on /sys/fs/selinux. The caller can then
proceed to mount a new selinuxfs filesystem private to the new
namespace, load a policy, set enforcing mode, etc, as is commonly
handled by init/systemd during boot.

Add an is_selinux_unshared() interface to detect whether one is in an
unshared SELinux namespace that has not yet been fully initialized
(i.e. no policy loaded yet), and a selinuxunshared utility to use it
from a shell or script. The is_selinux_unshared() interface returns 1
iff the SELinux namespace has been unshared and has not yet been fully
initialized. It returns 0 if SELinux namespaces are not supported or
the namespace has not been unshared or the namespace has been fully
initialized. If lsm_get_self_attr(2) return -1 with an errno other
than ENOSYS (not implemented) or EOPNOTSUPP (not supported by any
active LSM), then is_selinux_unshared() will return -1 with the same
errno.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v4 fixes a nit noted by	Christian Göttsche <cgzones@googlemail.com>
and also adds a conditionally wrapped definition for LSM_FLAG_SINGLE
and struct lsm_ctx (necessary for building with older kernel headers
e.g. on Rocky Linux 9). Also revises the patch description.

 libselinux/include/selinux/selinux.h |  23 +++++
 libselinux/src/libselinux.map        |   6 ++
 libselinux/src/unshare.c             | 130 +++++++++++++++++++++++++++
 libselinux/utils/.gitignore          |   2 +
 libselinux/utils/selinuxunshared.c   |  24 +++++
 libselinux/utils/unshareselinux.c    |  43 +++++++++
 6 files changed, 228 insertions(+)
 create mode 100644 libselinux/src/unshare.c
 create mode 100644 libselinux/utils/selinuxunshared.c
 create mode 100644 libselinux/utils/unshareselinux.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index b1431e5d..92186ddc 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -760,6 +760,29 @@ extern int selinux_lsetfilecon_default(const char *path);
  */
 extern void selinux_reset_config(void);
 
+/*
+ * Unshare the SELinux namespace.
+ * Prior to invoking this API, the caller must have unshared the
+ * mount namespace (CLONE_NEWNS) and mounted a MS_REC|MS_PRIVATE
+ * / filesystem so that selinux_unshare() can freely modify any
+ * existing selinuxfs mount as needed for the unshare.
+ * Returns 0 on success, in which case the SELinux namespace has
+ * been unshared and any old selinuxfs mount will have been unmounted.
+ * The caller can then proceed to mount a new selinuxfs filesystem
+ * for the new namespace, load a policy, set enforcing mode, etc.
+ */
+extern int selinux_unshare(void);
+
+/*
+ * Returns 1 if the SELinux namespace was unshared and has not
+ * yet been fully initialized (i.e. policy not yet loaded).
+ * Returns 0 if SELinux namespaces are not supported by the kernel,
+ * or the SELinux namespace was not unshared, or the namespace has
+ * been fully initialized already.
+ * Return < 0 on any error other than ENOSYS or EOPNOTSUPP.
+ */
+extern int is_selinux_unshared(void);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index ab002f01..77f5790c 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -262,3 +262,9 @@ LIBSELINUX_3.9 {
   global:
     context_to_str;
 } LIBSELINUX_3.8;
+
+LIBSELINUX_4.0 {
+  global:
+    selinux_unshare;
+    is_selinux_unshared;
+} LIBSELINUX_3.9;
diff --git a/libselinux/src/unshare.c b/libselinux/src/unshare.c
new file mode 100644
index 00000000..9ce5cf74
--- /dev/null
+++ b/libselinux/src/unshare.c
@@ -0,0 +1,130 @@
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <sched.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/mount.h>
+#include <sys/vfs.h>
+#include <sys/statvfs.h>
+#include <sys/syscall.h>
+#include <linux/lsm.h>
+
+#include "selinux_internal.h"
+#include "policy.h"
+
+
+#ifndef LSM_FLAG_SINGLE
+#define LSM_FLAG_SINGLE 0x0001
+
+struct lsm_ctx {
+	__u64 id;
+	__u64 flags;
+	__u64 len;
+	__u64 ctx_len;
+	__u8 ctx[] __counted_by(ctx_len);
+};
+#endif
+
+#ifndef LSM_ATTR_UNSHARE
+#define LSM_ATTR_UNSHARE 106
+#endif
+
+#ifndef __NR_lsm_get_self_attr
+#define __NR_lsm_get_self_attr 459
+#endif
+
+#ifndef __NR_lsm_set_self_attr
+#define __NR_lsm_set_self_attr 460
+#endif
+
+#ifndef HAVE_LSM_SET_SELF_ATTR
+#define HAVE_LSM_SET_SELF_ATTR 1
+static int lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+			     uint32_t size, uint32_t flags)
+{
+	return syscall(__NR_lsm_set_self_attr, attr, ctx, size, flags);
+}
+#endif
+
+#ifndef HAVE_LSM_GET_SELF_ATTR
+#define HAVE_LSM_GET_SELF_ATTR 1
+static int lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
+			     uint32_t *size, uint32_t flags)
+{
+	return syscall(__NR_lsm_get_self_attr, attr, ctx, size, flags);
+}
+#endif
+
+/*
+ * Precondition: caller must have already done unshare(CLONE_NEWNS) or
+ * been created via clone(CLONE_NEWNS) and mounted a MS_REC|MS_PRIVATE
+ * / filesystem so that any pre-existing selinuxfs mount can be
+ * modified freely by selinux_unshare(). See ../utils/unshareselinux.c
+ * for an example.
+ */
+int selinux_unshare(void)
+{
+	struct lsm_ctx ctx;
+	int ret;
+
+	ctx.id = LSM_ID_SELINUX;
+	ctx.flags = 0;
+	ctx.len = sizeof(ctx);
+	ctx.ctx_len = 0;
+
+	/* Unshare the SELinux namespace */
+	ret = lsm_set_self_attr(LSM_ATTR_UNSHARE, &ctx, sizeof(ctx), 0);
+	if (ret < 0)
+		return -1;
+
+	/* Unmount the selinuxfs which refers to the old/parent namespace */
+	ret = umount(SELINUXMNT);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Caller is responsible for mounting new selinuxfs, loading policy,
+	 * setting enforcing mode, etc.
+	 */
+
+	return 0;
+}
+
+struct selinux_ctx {
+	struct lsm_ctx lsmctx;
+	char unshared;
+};
+
+/*
+ * Returns 1 if the SELinux namespace was unshared and has not
+ * yet been fully initialized (i.e. policy not yet loaded).
+ * Returns 0 if SELinux namespaces are not supported by the kernel,
+ * or the SELinux namespace was not unshared, or the namespace has
+ * been fully initialized already.
+ * Return < 0 on any error other than ENOSYS or EOPNOTSUPP.
+ */
+int is_selinux_unshared(void)
+{
+	struct selinux_ctx ctx;
+	uint32_t size = sizeof(ctx);
+	int ret;
+
+	ctx.lsmctx.id = LSM_ID_SELINUX;
+	ctx.lsmctx.flags = 0;
+	ctx.lsmctx.len = sizeof(ctx);
+	ctx.lsmctx.ctx_len = 0;
+
+	ret = lsm_get_self_attr(LSM_ATTR_UNSHARE, (struct lsm_ctx *)&ctx,
+				&size, LSM_FLAG_SINGLE);
+	if (ret < 0 && (errno == ENOSYS || errno == EOPNOTSUPP))
+		return 0;
+	if (ret < 0)
+		return ret;
+	return ctx.unshared;
+}
diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index 2e10b14f..ffd2bc8e 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -30,3 +30,5 @@ setfilecon
 togglesebool
 selinux_check_access
 validatetrans
+unshareselinux
+selinuxunshared
diff --git a/libselinux/utils/selinuxunshared.c b/libselinux/utils/selinuxunshared.c
new file mode 100644
index 00000000..965f7ba3
--- /dev/null
+++ b/libselinux/utils/selinuxunshared.c
@@ -0,0 +1,24 @@
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <selinux/selinux.h>
+
+int main(int argc, char **argv)
+{
+	int ret;
+
+	if (argc != 1) {
+		fprintf(stderr, "usage: %s\n", argv[0]);
+		exit(-1);
+	}
+
+	ret = is_selinux_unshared();
+	if (ret < 0) {
+		perror(argv[0]);
+		exit(-1);
+	}
+
+	printf("%d\n", ret);
+
+	exit(!ret);
+}
diff --git a/libselinux/utils/unshareselinux.c b/libselinux/utils/unshareselinux.c
new file mode 100644
index 00000000..06a7b6e8
--- /dev/null
+++ b/libselinux/utils/unshareselinux.c
@@ -0,0 +1,43 @@
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/mount.h>
+#include <selinux/selinux.h>
+
+int main(int argc, char **argv)
+{
+	int ret;
+
+	ret = unshare(CLONE_NEWNS);
+	if (ret < 0) {
+		perror("unshare(CLONE_NEWNS)");
+		exit(1);
+	}
+
+	ret = mount("none", "/", NULL, MS_REC | MS_PRIVATE, NULL);
+	if (ret < 0) {
+		perror("mount(/)");
+		exit(1);
+	}
+
+	ret = selinux_unshare();
+	if (ret < 0) {
+		perror("selinux_unshare");
+		exit(1);
+	}
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s command args...\n", argv[0]);
+		exit(1);
+	}
+
+	execvp(argv[1], &argv[1]);
+	perror(argv[1]);
+	exit(1);
+}
-- 
2.51.0

