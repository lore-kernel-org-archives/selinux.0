Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708A1078F
	for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203602; cv=none; b=WVvxdsshv1ROc8/q8TsNwqrb2454J5ltYQd5wdEdEdd5kMcTK6AKUWfOjBdi2OaFfoZ8ZDOGv2XetlfrncAr6hARU1yp831v4979lKebAJDQxWR6G8iBMcEf/E1Rz6xVZDPucGVmLTRxHk23X3wO9IX88KJ/37pV5QRwTeRx3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203602; c=relaxed/simple;
	bh=LdTAMbnHtSPO+MTgMv5ZSrhSnz8WrGoEICXtBi8dt/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYkbuPYmLqBmFBa9TbvO6Tei76CdoXbw3t2pbVIOo4tRIqH7kCdPID7toiTlP9cIjrc5fgOU4z1RoNPgHkLqiSWOT2cSdlyeb+6bsXY+mGbpvsJKD3cRWtDmM5g+9ED4u040iQ/Z1wOOuxr4/1XbBME4RUbZFL0zclhG9+o1Zm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVW1Kpt3; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVW1Kpt3"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b5eee40cc0so10091151cf.0
        for <selinux@vger.kernel.org>; Thu, 18 Sep 2025 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758203599; x=1758808399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hx2YvD9QRvb353ps8UgCxX/k7kcKxIYizSJaLbSOLo=;
        b=iVW1Kpt3p9E1B/sVCWg7ClZE6vgVTnEU7Hb/vM2N2ir1y9/o8HL1XvvY1ibox/MNNq
         s1rLxFKc32F/TfbF/DbM4Ai+5vxQgdGVnzI4CHMbN5l/6sDNyoCN0lrWUczAdVJZYi8l
         YnRuHJRdwjaq+Agq+KGhfPKQV5472XVrv2ayNBoYVp3GeZiZtx0+M18tXT3T83u/h6o/
         nZ9NEdRDpyS87GejhxS2E/75bROBfvj2k1LV6B5/QJr9rpPAAO+TvFThD0OGWJ/ZpOSn
         lOpCs0pc/pQUccreye8s2dfiPQ/re9/Tfak3c/QVnW3CKt3GCMZ3aH8w8JrgQE/TjW30
         3MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758203599; x=1758808399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hx2YvD9QRvb353ps8UgCxX/k7kcKxIYizSJaLbSOLo=;
        b=n5bAyZ3OjUmyTF/Aup6KpOjqCVvCAx/VC9hp9fsskeigImw9YKTsgZlH4dnYQvhIFQ
         5dlkEHBICAC7N1DsX0GyzajcHOvDicclnt1hPOUIg6X+W0l+jupDV6otPJXDV3hTiWyH
         w3ABiGV7W0cnihw/5O4yTKz2PZN1trFU6wAOftLHeOiJiWZjo5qmK34MDiqrHvG6Hp6w
         aeEv6v15iDgAc/lOWXY7IFY2k9BHiyObredPBdkxdzZDUSNZOGyHsBLHQv8u3fjoCJdw
         y6/ga9dyP+SUUXuZzXKwm7b0+E4PAxeA/nJTVN1W1x9yaLCE51HjcePGrIIcVwhPsXgl
         sBpA==
X-Gm-Message-State: AOJu0YxPS/CcS29G1sgfmzPf8SV/B+WgTtL4ginzFXMPXPZ+QyNihC6L
	ZQVhHtC0qUO8IqBkiQxuPZSTDOt8Atv+s2RrUtRKDpd1PyWgeFP5fem8Q6b2ng==
X-Gm-Gg: ASbGncvZb7NrPO0E/TfbzUe5aQDtRCQ7RKBCnCFoafwQrfzoJC8jMiW2o9+oD1PP/y8
	IF2TObEB4ExmVqIQHc5q2nc0e9EdObR/SOoIaXFZFBDl6h3K6yKDr6qxBBzJghqdGBikCgdgLkj
	7VWBKROjglGzl1PDSHUF8B3wp8CEwbr6OjliPu5UQEnNuQV30inqsvvdHvxPLN9gmHFBrNUlIgM
	zojaz6/tFwfhUWP9hjdpOE+8h0QR6lYadkQerIxBhSBz5MlshUsFg4s70ESGrw7bxMZco80WiZ4
	Hoor4QVZwHMBljhyEf2vcAQzBS42DKqxrvS8g0lsLBBjj6N0eNL2wu/TKOOrGdf6VfirDNM24hw
	0ESds3LDo401fCuHRgkYnWaWhvD1H+dOslViI7tF2dJ1yA4zBwi3L2L/DG0PqTviZvCdbWzp7Xy
	bIh4gX/eUKAeNe7dIBzYuRUGUdHujjkUPaL27m/0SHjeRd
X-Google-Smtp-Source: AGHT+IH5KGcKr9J19rPYm8Wo4HPDJXuCdhEHGQSEK7SUN6sztVGxkBaqYvdF/UVjRzqgQPIeXKhcgA==
X-Received: by 2002:ac8:5d41:0:b0:4b7:a559:54ab with SMTP id d75a77b69052e-4ba6a200204mr74423021cf.44.1758203598704;
        Thu, 18 Sep 2025 06:53:18 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793516d6df9sm13384346d6.46.2025.09.18.06.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:53:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH selinuxns] libselinux: add selinux_unshare()
Date: Thu, 18 Sep 2025 09:51:19 -0400
Message-ID: <20250918135118.9896-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC only, this demonstrates how to implement unsharing of the SELinux
namespace using the lsm_set_self_attr(LSM_UNSHARE_SELINUX...) system
call instead of the /sys/fs/selinux/unshare interface.

Provide a selinux_unshare() wrapper for
lsm_set_self_attr(LSM_ATTR_UNSHARE...) and other required processing
when unsharing the SELinux namespace.

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

If/when this gets merged, the new selinux_unshare() symbol should
be moved to its own version in libselinux.map.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/include/selinux/selinux.h | 13 +++++
 libselinux/src/libselinux.map        |  1 +
 libselinux/src/unshare.c             | 71 ++++++++++++++++++++++++++++
 libselinux/utils/.gitignore          |  1 +
 libselinux/utils/unshareselinux.c    | 42 ++++++++++++++++
 5 files changed, 128 insertions(+)
 create mode 100644 libselinux/src/unshare.c
 create mode 100644 libselinux/utils/unshareselinux.c

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index b1431e5d..1a68c29f 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -760,6 +760,19 @@ extern int selinux_lsetfilecon_default(const char *path);
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
 #ifdef __cplusplus
 }
 #endif
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index ab002f01..f3966880 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -251,6 +251,7 @@ LIBSELINUX_3.5 {
   global:
     getpidprevcon;
     getpidprevcon_raw;
+    selinux_unshare;
 } LIBSELINUX_3.4;
 
 LIBSELINUX_3.8 {
diff --git a/libselinux/src/unshare.c b/libselinux/src/unshare.c
new file mode 100644
index 00000000..d2fc7e20
--- /dev/null
+++ b/libselinux/src/unshare.c
@@ -0,0 +1,71 @@
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
diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index 2e10b14f..bb290d90 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -30,3 +30,4 @@ setfilecon
 togglesebool
 selinux_check_access
 validatetrans
+unshareselinux
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
2.50.1

