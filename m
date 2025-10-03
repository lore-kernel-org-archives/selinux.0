Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEFC6FBF
	for <selinux@vger.kernel.org>; Fri,  3 Oct 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759519194; cv=none; b=Xa4JNeCl/aiTVusVB67kA4KPAw7bNYW5fqRrnmPVq+HXG3f5IrwEO7mFV4WFcH9QCt4kp2o36jbWSOKBXt+CS00iGua8UPF7Gq0SXq2X9Z8NyUi55HDHQttQiqgidLLUVpq29Y2adMix+VJl9aaKB2CWKYnlu0ViBK882hw29fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759519194; c=relaxed/simple;
	bh=7Tl1mP/ZB3rWwIkYNl6r4tms0G8IIweqH51T0x8EWMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GqN6T90zvO1Wfkf93lCXDu4ZQ88MYQCnbfGl8nhLqTtEpaqzOpS/EAO+vwJWSjtn2AXYfr1XssDGsHohH/fH9m2aCdJsvE+YeQSvmJhvSD0E0Y7jGAK41HXPmNhyH9vU0iOSoVHtwbGexxLAPoh6ttb/YkqaMYzpWabS3kMO5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bikbltj0; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bikbltj0"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-85b94fe19e2so258528485a.3
        for <selinux@vger.kernel.org>; Fri, 03 Oct 2025 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759519191; x=1760123991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZF+zKROGso6ahU8PQiIs8ycJGs5psvHbeoz3dSTrPY=;
        b=Bikbltj0wlt3GE+rBDOeOtpYL5rLN4w5eQdLHxHuol9ajTYIRdAH5Tj2ZFsOXNNyme
         tiNkWCpD6sIQ8Ff3Ok6mZfAFRVw55O6KnDRv5mJzGa8eKTTVmUMwIK9fCi68TaTa4lMK
         QSGHRFrbjtyBRet4nk1lttG6EY4JCJfJwQON2n1zw8bMnVDMfggRlqYC9tyYgk829VnH
         O89Hz+XgdfS/QQMtxdSpbd34Cq8MDzRGOFMkMn8uiMp0+rGFkaCsSIhxVWHaFlqZNSF6
         TPxXvZxvbPQDV/oi4oD8mzrnhkWHfnmS82M1w+qnjYHdlrzj7xXH4UXIyP7vjBbTbRJu
         lyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759519191; x=1760123991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZF+zKROGso6ahU8PQiIs8ycJGs5psvHbeoz3dSTrPY=;
        b=PAvIeIofLmX9CmPBJ6aaHRksjC0BufdaExTi2yU13o9cS5otji3i5ZqP9XxXuOo8Or
         +3fZJ0WjuutMIPbp1+nSrPG/e8PpR5s2pjqNu3XB16Vqd3J/UheqMwgWwnjOYcNkgDEV
         KMtjfF7BYw9ohPWnG3pudHAIBCHxY1OWIcT/kJUywmZGaibHSqxjvsKeKpWEuTzRI6OL
         6WoP86ilT1roi6bav1wypxLdLiT8UrmAGriGX73Ay7B2GEgu491qr3RtpHvRYXCokm+0
         e1vg6EFuD4lmSpAp+xqC6LMvUthp3e8BPmhLHqFZBJj3odiIJZROeTyQcRwvcyFQ2+xJ
         LtWg==
X-Gm-Message-State: AOJu0YyKscphs7qM/MGsWIumZfitJe0N48wRl4ViHc0wOYjEldcs4sge
	Zz46SNC8UyVR0DrsvRilgyMgPESLlxr1FzhocxQGezIWFypOkJaCpRaCKamnnw==
X-Gm-Gg: ASbGncu4+3Ge+7NtV/cQGyU06tPF3aewjI36mInEM60SiDWgmJe6qlccbL/3hkUz0ZE
	yRyvUoPwUjSrkIvbpg+c2Zp97DCY82Vlij4SBHmZLDsn1awwOb3XDbmHqDHtVF9SsJHBuYHGfh7
	WvnpZxV57duZmbk8sFvQBUQRgyFkxoHoUd1sOqGzxjIVrJczRQhCk2UvizpjBfNUr0U7SJ7DyaI
	mIhHTXkaXCXAFrB9/HIh466WPW7qpRRrmZ5LIv6gjrUKdmhvYECLQdcmJLy8zXKmbXysawjmMjC
	6qjF9l3JQ27wcRor+Se7+1Kdr8negSQt4gM4mSck9KRaYF+6d+wzsB0N3tdA7/KMIL8qOzmwvcV
	8BNNNUN/ZlCZTCrb1n+7AxttxD2BaF8tqBSEYCQfYZJKm49Yop8pTsJRbUxvzsPajKgAK8y4JPI
	/QlOVjmvA6yP7KOCpdvVBV7bpIXLh3kWQIYOOSIY8kXOb41vzY4F5JLAvVj67LtKfYS2dab9RIR
	T8HYe1z1Tp7Qw==
X-Google-Smtp-Source: AGHT+IGTFC2vnI7STZrRrhYdP7MP49bZYF1Zm6FUgZcDiYMVyUru45UO85ZXtHZachn94fFdz7bKKg==
X-Received: by 2002:a05:620a:45a0:b0:865:f7bd:f333 with SMTP id af79cd13be357-87a34aa53d3mr607914485a.28.1759519190897;
        Fri, 03 Oct 2025 12:19:50 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777892eadasm491833985a.39.2025.10.03.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:19:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH v2] libselinux: add selinux_unshare() and is_selinux_unshared()
Date: Fri,  3 Oct 2025 15:19:23 -0400
Message-ID: <20251003191922.5326-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC only, this demonstrates how to implement unsharing of the SELinux
namespace using the lsm_set_self_attr(LSM_ATTR_UNSHARE, ...) system
call and how to implement detection of whether one is in an unshared
SELinux namespace that has not yet been fully initialized using
the lsm_get_self_attr(LSM_ATTR_UNSHARE, ...) system call.

Provide a selinux_unshare() wrapper for
lsm_set_self_attr(LSM_ATTR_UNSHARE, ...) and other required processing
when unsharing the SELinux namespace, and an is_selinux_unshared()
wrapper for lsm_get_self_attr(LSM_ATTR_UNSHARE, ...) for detecting
whether one is in an unshared SELinux namespace that has not yet
been fully initialized.

Add a selinux_unshare() interface to unshare the SELinux namespace, and
a unshareselinux utility to run a shell or command in its own SELinux
and mount namespaces. The selinux_unshare() interface expects the caller
to have already unshared its mount namespace and created a
MS_REC|MS_PRIVATE mount of / prior to invoking it so that it can freely
modify the selinuxfs mount as needed by the unshare operation. The
unshareselinux utility demonstrates how to do this prior to calling
selinux_unshare(). Upon a successful return from selinux_unshare(),
the SELinux namespace will be unshared and there will be no selinuxfs
mount on /sys/fs/selinux.  The caller can then proceed to mount a new
selinuxfs filesystem private to the new namespace, load a policy,
set enforcing mode, etc, as is commonly handled by init/systemd during
boot.

Add an is_selinux_unshared() interface to detect whether one is in
an unshared SELinux namespace that has not yet been fully initialized
(i.e. no policy loaded yet), and a selinuxunshared utility to use
it from a shell or script.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/include/selinux/selinux.h |  22 ++++++
 libselinux/src/libselinux.map        |   6 ++
 libselinux/src/unshare.c             | 114 +++++++++++++++++++++++++++
 libselinux/utils/.gitignore          |   2 +
 libselinux/utils/selinuxunshared.c   |  24 ++++++
 libselinux/utils/unshareselinux.c    |  42 ++++++++++
 6 files changed, 210 insertions(+)
 create mode 100644 libselinux/src/unshare.c
 create mode 100644 libselinux/utils/selinuxunshared.c
 create mode 100644 libselinux/utils/unshareselinux.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index b1431e5d..4cac6283 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -760,6 +760,28 @@ extern int selinux_lsetfilecon_default(const char *path);
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
+ * Returns 0 if the SELinux namespace was either not unshared or
+ * has been fully initialized.
+ * Returns -1 if not supported.
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
index 00000000..16edb2c0
--- /dev/null
+++ b/libselinux/src/unshare.c
@@ -0,0 +1,114 @@
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
+ * Returns 0 if the SELinux namespace was either not unshared or
+ * has been fully initialized.
+ * Returns -1 on any other case, e.g. operation not supported.
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
index 00000000..b396b4fe
--- /dev/null
+++ b/libselinux/utils/unshareselinux.c
@@ -0,0 +1,42 @@
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
+}
-- 
2.51.0

