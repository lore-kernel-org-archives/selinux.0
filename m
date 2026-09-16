Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3474218A4
	for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588132; cv=none; b=T9Fsfm/6eaxRvv32JvvsFzPl+TFKfkM8auWtrGzzs3hJB8I2qM7+LloRAlr8iP4lZdc4r7AddBD0pPiHGULGgFdULRbm/S9YZs7Tl8elsN1ZuSUso+9ntzx1+e2MhsdR2Tx6O2qWT35xbUTHAXC1reZocMqwH6esbdSL8v2sF4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588132; c=relaxed/simple;
	bh=knldyJyGeCw6r9CPbVqq5+yktTZFJvNyL9I5DvHLKts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pilv4ZE/wWMqGSy/zDzC2zHoxUU/WiIJq0ObLpQggXTE4GBeUo+p+sn85JXeniAA6M+ffBHe0JD6DwTQcAYlTOWqn21Dvac+2AxIX/DhBVfWkgB+UQTrlQjGpCK4JnmAItqk5XmRPLpin6b60H1SOz0sJ2yT+FWGcAtriwMPxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnHUGA/i; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnHUGA/i"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109fafd7so1661785a.2
        for <selinux@vger.kernel.org>; Wed, 16 Sep 2026 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789588120; x=1790192920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c1bOnz0v9eTKbvguaCiE7qIR45GeNS/vixR+MamjQGw=;
        b=ZnHUGA/iaGPfXxDt/s6kkH8nda38hmYntlPMIRFBSaSrE7X8vdvY3pQdF6Ge94Ju5T
         XF10v0fCzwC8sBom7i+mePOOD+n0Y/ZgyfYj29IckwIZI10WXOyw5unZZNqejMbJWaPi
         gQJH9b9P+D1fzYdeA7yVf8/itarBNoABPkuPh5fVWgqBks0ZDjTJcfOg3t25+sAoDrpp
         m5q8gfAyVMz69GCz7QuQx4YX8cUSL4R5cz0UnG003crDh/ifdGebyqNui6byDjrvP5lQ
         6WMhSed4N2f4CUkw8lWwdJOaK+1BztBKJCVyDfUjNni0FsukEz2YVkff2LqI0GlCUGfJ
         UuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789588120; x=1790192920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c1bOnz0v9eTKbvguaCiE7qIR45GeNS/vixR+MamjQGw=;
        b=OaCRqZVNFQGcK/ovZdgOWkEzCMs3Aq0kiOsakxbjHnwmaOoji03H1RSul72TdRvSd+
         oEKwEvDvzF0DcufMwU3wNtxReLAzBD7PdJr6AouqMEqkD5uRKqLw81zJCzXAXaoZL0N7
         N4nB59030N8ct3ygYSI9FGyZtfPlE6dHcngpBy6E1XBRvOuyr0He48e/S2CtmX+YDiT8
         OGGRZDEV+DHvS2iEJk58BDPGasjRTvs0LQoGWmKIrCGWBR7sX8y9ZAgAZP1nmoi2ST5m
         ZjlKlGk3VNGK9aduGpSJaZEWnlnjsk3R45N0prS/LSEYvGYLJz/jN4oPG3h0fEYLPinp
         tFsQ==
X-Gm-Message-State: AFuF++mBm0Bw+xmn3K1lEHIm8CjZXU5CUQjDBRB52haAnUmq7bYc4k2f
	uTNVGlwP6hmo/YlWuM2tg7ongzjtbjUK27UP8qu+V5ui3l5W9li1gRJSh0UXGA==
X-Gm-Gg: AYBFou0i4aMpihYH78U8/TPDAtmkTBSCmABGfzpfx4jxcghuqcszCJZv2P7HJfFX0Y0
	2vCNbSTpsVM4f8UOmruylgwfYBGo5P/q3UIZKHVSQzd/jlKcZTShTypwmjQIlqgDVWMKK9swLLp
	nsvcBQi/mdX0PrmIWj8HperUO9fge8rLuoTauvAVACb0QZRJXE+Yh0BKpwRR7v1oWoo7s8sGB6C
	UEbcUgfRUDL0fy3L+0OXZI1wZsZbP1J/JsI7XUEwQ/42Rh4nrAokJgXHW+DKVybGThaIIUx7Jte
	HB/1VrZ6xtV80N805AiAjpiJtpFRZHjKw1ROwc11nz70bLsw2klRFhFavy/r5tN3OfET+aiPg+D
	g2dcBb3hctKcl3wy+F8je+X47dAYmbbU/tMv1/6TRwXD/zaKm2UF28UwJOe7k2hpQQWIjIHDnWF
	lFa38q29BCPwj9LGpK1UXpkM6eNnHUY6LOTbj8UI6bdwrEZFVMhBv+dQsLp/vUca4xayHquIQkh
	dLP9+3uArGbR96BcfJ/ostqoUGk86xicIlXrGLvJ5U0TYmz7iV2rCRwc/WeSi1FJMu9TkyS4q4=
X-Received: by 2002:a05:620a:84c3:b0:939:c555:efb6 with SMTP id af79cd13be357-93bb7739892mr612145985a.12.1789588119533;
        Wed, 16 Sep 2026 12:48:39 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781dfbe6sm287128085a.13.2026.09.16.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 12:48:38 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnacek@gmail.com,
	linux-security-module@vger.kernel.org,
	brauner@kernel.org,
	mic@digikod.net,
	serge@hallyn.com,
	jack@suse.cz,
	jmorris@namei.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] lsm: initialize the security blob for the initial namespaces
Date: Wed, 16 Sep 2026 15:48:24 -0400
Message-ID: <20260916194824.37332-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
added a security blob to struct ns_common and allocates it from
__ns_common_init(). Most initial namespaces (init_user_ns,
init_uts_ns, init_pid_ns, init_mnt_ns, and, depending on
configuration, init_ipc_ns, init_cgroup_ns and init_time_ns) are
however set up statically via NS_COMMON_INIT() and never pass through
__ns_common_init(), so their ns_security pointer is left NULL for the
lifetime of the system. Any LSM that registers an lbs_ns blob and
dereferences its slice on one of those namespaces (for example from
the namespace_install hook when a task setns()'s back into an initial
namespace) will fault.

Allocate the blob and run the namespace_init hook for each of these
namespaces at the end of security_init(), after all ordered LSMs have
registered their hooks, so every LSM sees the initial namespaces the
same way it sees init_net (which is initialized at runtime via
ns_common_init(&init_net) from net_ns_init() immediately after
security_init()) and does not need to special-case them in its own
->init() callback.

Provide an init_ns_common_for_each() iterator in kernel/nscommon.c so
the list of statically-defined initial namespaces and their Kconfig
guards live next to the rest of the ns_common infrastructure. init_net
is intentionally excluded: pre-initializing it here would leak once
__ns_common_init() clears ns_security and re-allocates.

Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 include/linux/ns_common.h |  1 +
 kernel/nscommon.c         | 45 +++++++++++++++++++++++++++++++++++++++
 security/lsm_init.c       | 11 ++++++++++
 3 files changed, 57 insertions(+)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index c8e227a3f9e2..742627000453 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -11,6 +11,7 @@
 bool is_current_namespace(struct ns_common *ns);
 int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
 void __ns_common_free(struct ns_common *ns);
+int init_ns_common_for_each(int (*fn)(struct ns_common *ns));
 struct ns_common *__must_check ns_owner(struct ns_common *ns);
 
 static __always_inline bool is_ns_init_inum(const struct ns_common *ns)
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index e72426bba29a..4f3cba5518d7 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -1,11 +1,17 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
 
+#include <linux/cgroup.h>
+#include <linux/ipc_namespace.h>
+#include <linux/mnt_namespace.h>
 #include <linux/ns_common.h>
 #include <linux/nstree.h>
+#include <linux/pid_namespace.h>
 #include <linux/proc_ns.h>
 #include <linux/security.h>
+#include <linux/time_namespace.h>
 #include <linux/user_namespace.h>
+#include <linux/uts_namespace.h>
 #include <linux/vfsdebug.h>
 
 #ifdef CONFIG_DEBUG_VFS
@@ -101,6 +107,45 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	return 0;
 }
 
+/**
+ * init_ns_common_for_each - iterate the statically-defined initial namespaces
+ * @fn: callback invoked with each initial ns_common
+ *
+ * Walk the initial namespaces that are set up via NS_COMMON_INIT() at compile
+ * time and therefore never pass through __ns_common_init(). The initial
+ * network namespace is intentionally excluded: it is initialized at runtime
+ * via ns_common_init(&init_net) from net_ns_init().
+ *
+ * Return: the first non-zero return from @fn, or 0.
+ */
+int __init init_ns_common_for_each(int (*fn)(struct ns_common *ns))
+{
+	struct ns_common *set[] = {
+		to_ns_common(&init_user_ns),
+		to_ns_common(&init_uts_ns),
+		to_ns_common(&init_pid_ns),
+		from_mnt_ns(&init_mnt_ns),
+#if defined(CONFIG_POSIX_MQUEUE) || defined(CONFIG_SYSVIPC)
+		to_ns_common(&init_ipc_ns),
+#endif
+#ifdef CONFIG_CGROUPS
+		to_ns_common(&init_cgroup_ns),
+#endif
+#ifdef CONFIG_TIME_NS
+		to_ns_common(&init_time_ns),
+#endif
+	};
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(set); i++) {
+		ret = fn(set[i]);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 void __ns_common_free(struct ns_common *ns)
 {
 	security_namespace_free(ns);
diff --git a/security/lsm_init.c b/security/lsm_init.c
index dbda7771013b..60e15215f6bd 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -7,6 +7,7 @@
 
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
+#include <linux/ns_common.h>
 
 #include "lsm.h"
 
@@ -490,6 +491,16 @@ int __init security_init(void)
 		lsm_init_single(*lsm);
 	}
 
+	/*
+	 * The initial namespaces are set up statically via NS_COMMON_INIT()
+	 * and never pass through __ns_common_init(), so allocate their
+	 * security blobs and run the namespace_init hooks now that all LSMs
+	 * are registered. init_net is not covered here; it is initialized
+	 * at runtime from net_ns_init() shortly after security_init().
+	 */
+	if (init_ns_common_for_each(security_namespace_init))
+		panic("initial LSM ns alloc failed\n");
+
 	return 0;
 }
 
-- 
2.55.0

