Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E2C22339
	for <selinux@vger.kernel.org>; Thu,  9 Oct 2025 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016497; cv=none; b=uBdhqFThEAUZLFGpXqP6exMQ/Dlf+Y/umVGm6z+lasWE8rNklEfHGZA9meHJ1qu6diwqFQIYHViHubbNa1wW93qzyCTqWnbFCa1aTmM12ewcCe74K6CB+xMNfoEQf0H6J6/R+ozQDTHjnGrJ9PTIjNVoRS1GsXwJsntBeVo6qH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016497; c=relaxed/simple;
	bh=IxDF66aeOEGTH38YnznDukFezdAwUMPJPg2gWjBu1ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDcrv11v72f3DCCtidOkHO5JtAb6MMilxo9KG3EGvHYZoBv1+fcyw6i7A/UEyvWLA4fMy1u3+K5wQ13U0N7t+GufRcGPX5/Llvz+eXMiBhfb9Foyb0txpfjrMzeLl+hK/j7v3gSyygQbJJ545jH7IqBUEU5TgcXotwXqtNRqark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd0xAjZ1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd0xAjZ1"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4da7a3d0402so13671931cf.0
        for <selinux@vger.kernel.org>; Thu, 09 Oct 2025 06:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760016494; x=1760621294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zt7RIbURk+F16Lfa2pG4eLeTKDxy+cqwkqwEj0MDUA8=;
        b=Sd0xAjZ14LLiZ8mEdKhEQZYDMc7c2iK85WhdTZ6giC4D5e0AvNulcYYeNpsg1xyd2w
         KQEK+z2+aV5QGe0qtD+g22Czo+kms2xUDYKfCATcFTHMiNmx6MMbYJzsPK2Hg+SVOA0T
         EY+v5VGolw4Ws4tv48NAs+BBgxv8+cSR5pZIMK6hKRcegg/r1jxhMuI/sXuc5x6tnYA5
         deDzlp3bdMGui1Ov+NGC9RHZpe5jrAhwMJPEkFoK+uClcsYgU2skY3Tr24yveCdX5ThC
         ESUFYsQk7mLvN9YBQqpYP7awF/3HIVlG8OJarWyjuMpWYvYm2UJqVq2Rrm4NBDJYFvUi
         z7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760016494; x=1760621294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zt7RIbURk+F16Lfa2pG4eLeTKDxy+cqwkqwEj0MDUA8=;
        b=ilI+6u9wkyZ3AGXy0lPGEe+XnqEDqX+jrOScv5ZiCmmMdpbhzrZVleY7gHbuyxCHlM
         4GCZU9rFkx4bZQjjo9zAPHQAyCjQCjAt0i7AZ1M2nHPmA356B3Y2ysEpvZSKGN2E6SzW
         bp5anyeZO7VZ9RVYxmOiiCCdOYApWUQu2HN9Nuf6hkwapdGiGT5L1d+A6nuVVHwikKLM
         VujkLCwVedGVodLOmxUIKfh0ws4ae7O4m3uTII2B0naKDjaAJqPklYdRkmJ3mj/cVFJH
         sCH2Za6yU3DT880DJJM4NCcE6Ef1fx8F58QV5N2PQnRiPQUo3dB3b8A0y4A10k/V41iE
         PieQ==
X-Gm-Message-State: AOJu0YzWGrIqXYknkJU5LQdX2z8e2K8IU3jeqLG/H0kEwxr0iCiSAmvq
	mqLCTwHSc9Jlg6oG+BYwcuaSKM/0oNMwiUo5fv9xjsmFlCQ3lw1s58BLTpuaAQ==
X-Gm-Gg: ASbGnctuMvNs/URkF5hbgUgmUNUSj7NatvXZc/OJBVjvHpGzyyV2jVc52BJvRp6GEMg
	bwkAAUNoTHBVxu8I/AVbso4N1SA4K146wCuM9pKx6TPG+g78DUrCd6eO8c74qtIWyPWMaNptWBC
	yqF8OGTd2Ibn6t/b9TvYGr7U90XBH7pLbfWRORDOUrFl5kBd4uy+FHWnijbHGvYTYKZIc9wGPUA
	8x/tP0eBpW1ZBpxRwUO7QbNGxbbAi2b8Q94Uf6TmqDdvTX2q/Dv4CAKcdzl9N/QDhYewjt3Me/J
	YdpXs9KgjL2j4PdxMxKSuxn5B6hIbHYLjL1FEyZqSDUaKlexWOQNpurnTplV1KPy6xXlgrTWbD1
	N4CwIaZ/MZWv76R5m1zOOGyq7VCcdzwAVOtS9VHnWIkLZx55Ojk9ayPijldwnUTpXLZ3rQgetY/
	Xgg21TyfiJk8W/j3iZUqEOWnpZasXBN41jY8wfCMP0bC9mfCU=
X-Google-Smtp-Source: AGHT+IHYQBYiTbOL9znibg1IurOrVPMZJu00kyKFxwp8RSUr741c6KxAA4/VqQW/dUFPn9+Ka/kgMw==
X-Received: by 2002:ac8:7c56:0:b0:4b5:dc4f:7d67 with SMTP id d75a77b69052e-4e6de86ac27mr138685001cf.27.1760016493601;
        Thu, 09 Oct 2025 06:28:13 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bbb1d5c0sm179395846d6.30.2025.10.09.06.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:28:13 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	john.johansen@canonical.com,
	casey@schaufler-ca.com,
	serge@hallyn.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH v3] libselinux: add selinux_unshare() and is_selinux_unshared()
Date: Thu,  9 Oct 2025 09:24:21 -0400
Message-ID: <20251009132421.20903-2-stephen.smalley.work@gmail.com>
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
v3 changes is_selinux_unshared() to return 0 if lsm_get_self_attr(2)
sets errno to ENOSYS or EOPNOTSUPP to allow callers to treat its
return value as a boolean and avoid needing to handle these cases
themselves.

 libselinux/include/selinux/selinux.h |  23 ++++++
 libselinux/src/libselinux.map        |   6 ++
 libselinux/src/unshare.c             | 117 +++++++++++++++++++++++++++
 libselinux/utils/.gitignore          |   2 +
 libselinux/utils/selinuxunshared.c   |  24 ++++++
 libselinux/utils/unshareselinux.c    |  42 ++++++++++
 6 files changed, 214 insertions(+)
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
index 00000000..cd3ec78c
--- /dev/null
+++ b/libselinux/src/unshare.c
@@ -0,0 +1,117 @@
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

