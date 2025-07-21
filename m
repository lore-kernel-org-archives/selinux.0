Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1F14D70E
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140245; cv=none; b=FnS2vNyoA4hpSrSYni97hmIZFhZ4U8xAiyGqKN7UjMcZsuVzYc0yEYDdWrGiZHzw5B9s53fCrGQDDjfDK3jD+cHz+RftZ6jpJNGn7A5FeMTERnvuK4UZCdkL+li422Z5mtqo0QjoOLfTYNaeATGY/jzw7vSbonkP2MWX/lAz/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140245; c=relaxed/simple;
	bh=T4cgqrT8TgJTc00o1qhrH/ZPjxbLxlw+MJgQluRQ0tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEi1AIlVApPs3y/eDk0dTIOAXDpw9ZssSN2OF1nWwH70fyLCJLsO7U/qwxI1okg4PqVG1kbhBgOUydhDEFgg7mdVTQ8Iy5vn/cTkSlgPWbaHvIdas2Okb8+Eh2Ee5Hw+xKPZ2HGPiRqmlnR9DFFGIAfmJswlrhEKziJJLT2tzbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UUfH+q5t; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UUfH+q5t"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fd0a3cd326so52991736d6.1
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140242; x=1753745042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9U4Nf7DEMLZ2gBl/0lpzEXounOU32BApRJstmNDf06o=;
        b=UUfH+q5tdO5tnrCvA+Yh/XAL/TFtbE5JEzttLCgeFF634S5tPwkiz6RiMdvLnxmRg3
         41A4nl8BPs4IpJOGARdTuwacEHwRRl+N/JB0O5jnjmxf3/mUMMUn/c+GzN6tPlT7IAgg
         I3rNv4bXyy+WhWRUzZhICSRP0XXQNKeohdH++lnURuow7KucslGTedAHJcIrgsoqCuW7
         jxvvQtRjSwHc1zQumCCWU+aofguFhC6IHMvsKFUTDer/gDGtJ+9DxGfd6RLK7W2uYE1g
         h3b/v1AEclO7UfyqZIgWP8tKskJbJiZAHkW8REXKsM3cGeXusyQhd7xfV+iWfjFY3+bR
         ZOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140242; x=1753745042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9U4Nf7DEMLZ2gBl/0lpzEXounOU32BApRJstmNDf06o=;
        b=xPJfXX6fvADBSdxjK7bosSB+L0THBQXMqky2mpquH6kyo3kNbajJGJqavbmAVqiCll
         rYBxLeH1DXFMwaCZ/nIrB1uYtnTXYMZraIJYMcSjEA6GmD0bIlUwTrSgtnHbL/mxMWiJ
         J5lzNf8z/g5wFn9o6EQb8W2rt/VxS4DUhr+CALoYUr4MfRBrl8hG6GbnyBd/2BrwW1y6
         OUreJL9eFMmI4lsWyxey/xvQJovAba5c8yRvhODZdd2GtBUxsmvlCOoYxfV5xtEaCNUp
         VjLpO4S3AXCxSeOMaMEpht4ZoM6EjNl9fE7Cv98uEhy27V89HYYK00AaDEqt/LgQasVD
         pinQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHAq4JiBsUhZCU4mkS/5FjgEyvTviSGXIaYUu0tcPCP8U4bJtPeuv+BVS5PXltVlnmzOG7ujMQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyDfOvU9dQjIZQD97jzU+YD6rkW57JhuFIjkqUHIi/GYJHqddmf
	2VFK8VUj0K6sOiqZ5aXKfpBFbV7TVug8vDzKkzy909HKwUtZqSd0m0BhtxmhxxnVnA==
X-Gm-Gg: ASbGnctcNhbsTTqcLg0voGYjvN8CIrkeaQGU0Q6BMovcZjjbbVZNlPqI76sAoNrEMV9
	tSmr0Xk4uxzQW5eT7PHZYz8xMciVcv6D4LDyuw42BqCk2gYBzIOfRNTDk16BMmRKgHivgAVt6Qp
	+iqcs4y+er83ZPXYu6rJAVp3VBDqt3Sc3FIrh76gsqTbdUT0F59+Vp9ub4rM1rROwUy4pb879yh
	gwlaqvfNxxWgE0nUhfc1HEZLFT0Nt19m5tFnbf5DrhpQr653sBDneHJfPDSJ6tBpNpe2ZGSrp7j
	3UDEIV8rDbHaAz4N0uc0QWieMjFloLogOXNpF0j4n1UZU0OFqW0BURXJUOzxmDA+qdBL8Rh2r1o
	cNscgBJxasV1oP3K9EGJ6UEMe6RENApeL+vnAP8VDmS5g2RIhj8zQBdFRpWvFEaprofY=
X-Google-Smtp-Source: AGHT+IGf9oDl9pWfgJ5Vj3eJ1wAsvHH+jth+Sim8kn8huQuTiGWN7md2tCDYcHYJJV74SAokdO7K8A==
X-Received: by 2002:a05:6214:1cce:b0:706:6967:71da with SMTP id 6a1803df08f44-70669677c2bmr169965666d6.38.1753140241478;
        Mon, 21 Jul 2025 16:24:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356cb9d0fsm462875085a.109.2025.07.21.16.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:01 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v2 02/34] lsm: split the init code out into lsm_init.c
Date: Mon, 21 Jul 2025 19:21:05 -0400
Message-ID: <20250721232142.77224-38-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=37558; i=paul@paul-moore.com; h=from:subject; bh=T4cgqrT8TgJTc00o1qhrH/ZPjxbLxlw+MJgQluRQ0tc=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsuROU27MLhpucWEiAxM0UQkj8SD9fZ2g8rlS SDNKUPYNqSJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LkQAKCRDqIPLalzeJ cz8RD/9tJlhpJRR+AfsaEK/8kpl19h+dt5fDkXG/BHWDU3gzNO6wO8zWuNR3A73H/dJtr+xCZT2 GGiZlxIMNuaib9+jit2J5xhGjzkpmya4CB5FwZtOuaDpOkLfE03bnM+aC4q6olT7X/A0320hBdG AOmD8gqm352yoZR+jhxEwOb9ycfqlOklIDIs72WhZI6Q6UTAxTp8x9qaTYjvkDVZoAMYO+9nnk7 hRBCn5S9QKHhggSbCxlSdq4GDF9y3mSL0oGnJYEIqkVbLG1151Lw11nYRpFwBCGdsdM9wrftmul im9TKMIhrvjFTNRZxVmmxUF8vNovYVbUSTLBu2J0iwqx/bGk9Mw9zAHpuCxPdAsP8V6YiIpHldS 9XhhQEVmijE2Jv64dgEWLeNKO093VjwbWgt9E6fFu4YX8fBrddfKa7rEcexzINwQObJTz63njJ0 dLsENZmJ8kCBFl1Njh6jtQUcY6KMjMu0GdLW7QMd/GiuDLqdjN4AAK7OIrwTQ8z+TF2Yz9Old4b khpl0B/NsuU7JIRzPHbE2Z4A/s1YloWq7fnwfQ9n384wOGx0lj+fe3YbbiV0nKNs7sZZg9ddrGk uB+WQprZJZPg0UkotFu7MXCLwU5I32vXOCF5Sw50ubw6JKBwq4FHtHqewtM4hy0PsYt81dLir/t BnzyBqqXleX+uMQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Continue to pull code out of security/security.c to help improve
readability by pulling all of the LSM framework initialization
code out into a new file.

No code changes.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h |   3 +-
 security/Makefile         |   2 +-
 security/lsm.h            |  22 ++
 security/lsm_init.c       | 537 ++++++++++++++++++++++++++++++++++
 security/security.c       | 591 +++-----------------------------------
 5 files changed, 595 insertions(+), 560 deletions(-)
 create mode 100644 security/lsm.h
 create mode 100644 security/lsm_init.c

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 090d1d3e19fe..eeb4bfd60b79 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -167,11 +167,10 @@ struct lsm_info {
 		__used __section(".early_lsm_info.init")		\
 		__aligned(sizeof(unsigned long))
 
+
 /* DO NOT tamper with these variables outside of the LSM framework */
 extern char *lsm_names;
 extern struct lsm_static_calls_table static_calls_table __ro_after_init;
-extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
-extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
 
 /**
  * lsm_get_xattr_slot - Return the next available slot and increment the index
diff --git a/security/Makefile b/security/Makefile
index 14d87847bce8..4601230ba442 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
 obj-$(CONFIG_MMU)			+= min_addr.o
 
 # Object file lists
-obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o
+obj-$(CONFIG_SECURITY)			+= security.o lsm_notifier.o lsm_init.o
 obj-$(CONFIG_SECURITYFS)		+= inode.o
 obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/
 obj-$(CONFIG_SECURITY_SMACK)		+= smack/
diff --git a/security/lsm.h b/security/lsm.h
new file mode 100644
index 000000000000..0e1731bad4a7
--- /dev/null
+++ b/security/lsm.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LSM functions
+ */
+
+#ifndef _LSM_H_
+#define _LSM_H_
+
+#include <linux/lsm_hooks.h>
+
+/* LSM blob configuration */
+extern struct lsm_blob_sizes blob_sizes;
+
+/* LSM blob caches */
+extern struct kmem_cache *lsm_file_cache;
+extern struct kmem_cache *lsm_inode_cache;
+
+/* LSM blob allocators */
+int lsm_cred_alloc(struct cred *cred, gfp_t gfp);
+int lsm_task_alloc(struct task_struct *task);
+
+#endif /* _LSM_H_ */
diff --git a/security/lsm_init.c b/security/lsm_init.c
new file mode 100644
index 000000000000..70e7d4207dae
--- /dev/null
+++ b/security/lsm_init.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * LSM initialization functions
+ */
+
+#define pr_fmt(fmt) "LSM: " fmt
+
+#include <linux/init.h>
+#include <linux/lsm_hooks.h>
+
+#include "lsm.h"
+
+char *lsm_names;
+
+/* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h */
+extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
+extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
+
+/* Boot-time LSM user choice */
+static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
+static __initdata const char *chosen_lsm_order;
+static __initdata const char *chosen_major_lsm;
+
+/* Ordered list of LSMs to initialize. */
+static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
+static __initdata struct lsm_info *exclusive;
+
+static __initdata bool debug;
+#define init_debug(...)							\
+	do {								\
+		if (debug)						\
+			pr_info(__VA_ARGS__);				\
+	} while (0)
+
+static int lsm_append(const char *new, char **result);
+
+/* Save user chosen LSM */
+static int __init choose_major_lsm(char *str)
+{
+	chosen_major_lsm = str;
+	return 1;
+}
+__setup("security=", choose_major_lsm);
+
+/* Explicitly choose LSM initialization order. */
+static int __init choose_lsm_order(char *str)
+{
+	chosen_lsm_order = str;
+	return 1;
+}
+__setup("lsm=", choose_lsm_order);
+
+/* Enable LSM order debugging. */
+static int __init enable_debug(char *str)
+{
+	debug = true;
+	return 1;
+}
+__setup("lsm.debug", enable_debug);
+
+/* Mark an LSM's enabled flag. */
+static int lsm_enabled_true __initdata = 1;
+static int lsm_enabled_false __initdata = 0;
+static void __init set_enabled(struct lsm_info *lsm, bool enabled)
+{
+	/*
+	 * When an LSM hasn't configured an enable variable, we can use
+	 * a hard-coded location for storing the default enabled state.
+	 */
+	if (!lsm->enabled) {
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+		else
+			lsm->enabled = &lsm_enabled_false;
+	} else if (lsm->enabled == &lsm_enabled_true) {
+		if (!enabled)
+			lsm->enabled = &lsm_enabled_false;
+	} else if (lsm->enabled == &lsm_enabled_false) {
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+	} else {
+		*lsm->enabled = enabled;
+	}
+}
+
+static inline bool is_enabled(struct lsm_info *lsm)
+{
+	if (!lsm->enabled)
+		return false;
+
+	return *lsm->enabled;
+}
+
+/* Is an LSM already listed in the ordered LSMs list? */
+static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+{
+	struct lsm_info **check;
+
+	for (check = ordered_lsms; *check; check++)
+		if (*check == lsm)
+			return true;
+
+	return false;
+}
+
+/* Append an LSM to the list of ordered LSMs to initialize. */
+static int last_lsm __initdata;
+static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
+{
+	/* Ignore duplicate selections. */
+	if (exists_ordered_lsm(lsm))
+		return;
+
+	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
+		return;
+
+	/* Enable this LSM, if it is not already set. */
+	if (!lsm->enabled)
+		lsm->enabled = &lsm_enabled_true;
+	ordered_lsms[last_lsm++] = lsm;
+
+	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
+		   is_enabled(lsm) ? "enabled" : "disabled");
+}
+
+/* Is an LSM allowed to be initialized? */
+static bool __init lsm_allowed(struct lsm_info *lsm)
+{
+	/* Skip if the LSM is disabled. */
+	if (!is_enabled(lsm))
+		return false;
+
+	/* Not allowed if another exclusive LSM already initialized. */
+	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
+		init_debug("exclusive disabled: %s\n", lsm->name);
+		return false;
+	}
+
+	return true;
+}
+
+static void __init lsm_set_blob_size(int *need, int *lbs)
+{
+	int offset;
+
+	if (*need <= 0)
+		return;
+
+	offset = ALIGN(*lbs, sizeof(void *));
+	*lbs = offset + *need;
+	*need = offset;
+}
+
+static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
+{
+	if (!needed)
+		return;
+
+	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
+	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
+	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
+	/*
+	 * The inode blob gets an rcu_head in addition to
+	 * what the modules might need.
+	 */
+	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
+		blob_sizes.lbs_inode = sizeof(struct rcu_head);
+	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
+	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
+	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
+	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
+	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
+	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
+	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
+	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
+	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
+	lsm_set_blob_size(&needed->lbs_xattr_count,
+			  &blob_sizes.lbs_xattr_count);
+	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
+}
+
+/* Prepare LSM for initialization. */
+static void __init prepare_lsm(struct lsm_info *lsm)
+{
+	int enabled = lsm_allowed(lsm);
+
+	/* Record enablement (to handle any following exclusive LSMs). */
+	set_enabled(lsm, enabled);
+
+	/* If enabled, do pre-initialization work. */
+	if (enabled) {
+		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
+			exclusive = lsm;
+			init_debug("exclusive chosen:   %s\n", lsm->name);
+		}
+
+		lsm_set_blob_sizes(lsm->blobs);
+	}
+}
+
+/* Initialize a given LSM, if it is enabled. */
+static void __init initialize_lsm(struct lsm_info *lsm)
+{
+	if (is_enabled(lsm)) {
+		int ret;
+
+		init_debug("initializing %s\n", lsm->name);
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+	}
+}
+
+/*
+ * Current index to use while initializing the lsm id list.
+ */
+u32 lsm_active_cnt __ro_after_init;
+const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
+
+/* Populate ordered LSMs list from comma-separated LSM name list. */
+static void __init ordered_lsm_parse(const char *order, const char *origin)
+{
+	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	/* LSM_ORDER_FIRST is always first. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			append_ordered_lsm(lsm, "  first");
+	}
+
+	/* Process "security=", if given. */
+	if (chosen_major_lsm) {
+		struct lsm_info *major;
+
+		/*
+		 * To match the original "security=" behavior, this
+		 * explicitly does NOT fallback to another Legacy Major
+		 * if the selected one was separately disabled: disable
+		 * all non-matching Legacy Major LSMs.
+		 */
+		for (major = __start_lsm_info; major < __end_lsm_info;
+		     major++) {
+			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			    strcmp(major->name, chosen_major_lsm) != 0) {
+				set_enabled(major, false);
+				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
+					   chosen_major_lsm, major->name);
+			}
+		}
+	}
+
+	sep = kstrdup(order, GFP_KERNEL);
+	next = sep;
+	/* Walk the list, looking for matching LSMs. */
+	while ((name = strsep(&next, ",")) != NULL) {
+		bool found = false;
+
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if (strcmp(lsm->name, name) == 0) {
+				if (lsm->order == LSM_ORDER_MUTABLE)
+					append_ordered_lsm(lsm, origin);
+				found = true;
+			}
+		}
+
+		if (!found)
+			init_debug("%s ignored: %s (not built into kernel)\n",
+				   origin, name);
+	}
+
+	/* Process "security=", if given. */
+	if (chosen_major_lsm) {
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if (exists_ordered_lsm(lsm))
+				continue;
+			if (strcmp(lsm->name, chosen_major_lsm) == 0)
+				append_ordered_lsm(lsm, "security=");
+		}
+	}
+
+	/* LSM_ORDER_LAST is always last. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_LAST)
+			append_ordered_lsm(lsm, "   last");
+	}
+
+	/* Disable all LSMs not in the ordered list. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (exists_ordered_lsm(lsm))
+			continue;
+		set_enabled(lsm, false);
+		init_debug("%s skipped: %s (not in requested order)\n",
+			   origin, lsm->name);
+	}
+
+	kfree(sep);
+}
+
+static void __init report_lsm_order(void)
+{
+	struct lsm_info **lsm, *early;
+	int first = 0;
+
+	pr_info("initializing lsm=");
+
+	/* Report each enabled LSM name, comma separated. */
+	for (early = __start_early_lsm_info;
+	     early < __end_early_lsm_info; early++)
+		if (is_enabled(early))
+			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		if (is_enabled(*lsm))
+			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
+
+	pr_cont("\n");
+}
+
+/**
+ * lsm_early_cred - during initialization allocate a composite cred blob
+ * @cred: the cred that needs a blob
+ *
+ * Allocate the cred blob for all the modules
+ */
+static void __init lsm_early_cred(struct cred *cred)
+{
+	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
+
+	if (rc)
+		panic("%s: Early cred alloc failed.\n", __func__);
+}
+
+/**
+ * lsm_early_task - during initialization allocate a composite task blob
+ * @task: the task that needs a blob
+ *
+ * Allocate the task blob for all the modules
+ */
+static void __init lsm_early_task(struct task_struct *task)
+{
+	int rc = lsm_task_alloc(task);
+
+	if (rc)
+		panic("%s: Early task alloc failed.\n", __func__);
+}
+
+static void __init ordered_lsm_init(void)
+{
+	struct lsm_info **lsm;
+
+	if (chosen_lsm_order) {
+		if (chosen_major_lsm) {
+			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
+				chosen_major_lsm, chosen_lsm_order);
+			chosen_major_lsm = NULL;
+		}
+		ordered_lsm_parse(chosen_lsm_order, "cmdline");
+	} else
+		ordered_lsm_parse(builtin_lsm_order, "builtin");
+
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		prepare_lsm(*lsm);
+
+	report_lsm_order();
+
+	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
+	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
+	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
+	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
+	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
+#ifdef CONFIG_KEYS
+	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
+#endif /* CONFIG_KEYS */
+	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
+	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
+	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
+	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
+	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
+	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
+	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
+	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
+
+	/*
+	 * Create any kmem_caches needed for blobs
+	 */
+	if (blob_sizes.lbs_file)
+		lsm_file_cache = kmem_cache_create("lsm_file_cache",
+						   blob_sizes.lbs_file, 0,
+						   SLAB_PANIC, NULL);
+	if (blob_sizes.lbs_inode)
+		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
+						    blob_sizes.lbs_inode, 0,
+						    SLAB_PANIC, NULL);
+
+	lsm_early_cred((struct cred *) current->cred);
+	lsm_early_task(current);
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		initialize_lsm(*lsm);
+}
+
+static bool match_last_lsm(const char *list, const char *lsm)
+{
+	const char *last;
+
+	if (WARN_ON(!list || !lsm))
+		return false;
+	last = strrchr(list, ',');
+	if (last)
+		/* Pass the comma, strcmp() will check for '\0' */
+		last++;
+	else
+		last = list;
+	return !strcmp(last, lsm);
+}
+
+static int lsm_append(const char *new, char **result)
+{
+	char *cp;
+
+	if (*result == NULL) {
+		*result = kstrdup(new, GFP_KERNEL);
+		if (*result == NULL)
+			return -ENOMEM;
+	} else {
+		/* Check if it is the last registered name */
+		if (match_last_lsm(*result, new))
+			return 0;
+		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
+		if (cp == NULL)
+			return -ENOMEM;
+		kfree(*result);
+		*result = cp;
+	}
+	return 0;
+}
+
+static void __init lsm_static_call_init(struct security_hook_list *hl)
+{
+	struct lsm_static_call *scall = hl->scalls;
+	int i;
+
+	for (i = 0; i < MAX_LSM_COUNT; i++) {
+		/* Update the first static call that is not used yet */
+		if (!scall->hl) {
+			__static_call_update(scall->key, scall->trampoline,
+					     hl->hook.lsm_func_addr);
+			scall->hl = hl;
+			static_branch_enable(scall->active);
+			return;
+		}
+		scall++;
+	}
+	panic("%s - Ran out of static slots.\n", __func__);
+}
+
+/**
+ * security_add_hooks - Add a modules hooks to the hook lists.
+ * @hooks: the hooks to add
+ * @count: the number of hooks to add
+ * @lsmid: the identification information for the security module
+ *
+ * Each LSM has to register its hooks with the infrastructure.
+ */
+void __init security_add_hooks(struct security_hook_list *hooks, int count,
+			       const struct lsm_id *lsmid)
+{
+	int i;
+
+	/*
+	 * A security module may call security_add_hooks() more
+	 * than once during initialization, and LSM initialization
+	 * is serialized. Landlock is one such case.
+	 * Look at the previous entry, if there is one, for duplication.
+	 */
+	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid) {
+		if (lsm_active_cnt >= MAX_LSM_COUNT)
+			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_idlist[lsm_active_cnt++] = lsmid;
+	}
+
+	for (i = 0; i < count; i++) {
+		hooks[i].lsmid = lsmid;
+		lsm_static_call_init(&hooks[i]);
+	}
+
+	/*
+	 * Don't try to append during early_security_init(), we'll come back
+	 * and fix this up afterwards.
+	 */
+	if (slab_is_available()) {
+		if (lsm_append(lsmid->name, &lsm_names) < 0)
+			panic("%s - Cannot get early memory.\n", __func__);
+	}
+}
+
+int __init early_security_init(void)
+{
+	struct lsm_info *lsm;
+
+	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+		if (!lsm->enabled)
+			lsm->enabled = &lsm_enabled_true;
+		prepare_lsm(lsm);
+		initialize_lsm(lsm);
+	}
+
+	return 0;
+}
+
+/**
+ * security_init - initializes the security framework
+ *
+ * This should be called early in the kernel initialization sequence.
+ */
+int __init security_init(void)
+{
+	struct lsm_info *lsm;
+
+	init_debug("legacy security=%s\n", chosen_major_lsm ? : " *unspecified*");
+	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
+	init_debug("boot arg lsm=%s\n", chosen_lsm_order ? : " *unspecified*");
+
+	/*
+	 * Append the names of the early LSM modules now that kmalloc() is
+	 * available
+	 */
+	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
+		init_debug("  early started: %s (%s)\n", lsm->name,
+			   is_enabled(lsm) ? "enabled" : "disabled");
+		if (lsm->enabled)
+			lsm_append(lsm->name, &lsm_names);
+	}
+
+	/* Load LSMs in specified order. */
+	ordered_lsm_init();
+
+	return 0;
+}
diff --git a/security/security.c b/security/security.c
index ea09a71d9767..e77791058086 100644
--- a/security/security.c
+++ b/security/security.c
@@ -32,24 +32,7 @@
 #include <net/flow.h>
 #include <net/sock.h>
 
-#define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK##_##IDX
-
-/*
- * Identifier for the LSM static calls.
- * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
- * IDX is the index of the static call. 0 <= NUM < MAX_LSM_COUNT
- */
-#define LSM_STATIC_CALL(HOOK, IDX) lsm_static_call_##HOOK##_##IDX
-
-/*
- * Call the macro M for each LSM hook MAX_LSM_COUNT times.
- */
-#define LSM_LOOP_UNROLL(M, ...) 		\
-do {						\
-	UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)	\
-} while (0)
-
-#define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
+#include "lsm.h"
 
 /*
  * These are descriptions of the reasons that can be passed to the
@@ -90,21 +73,29 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-static struct kmem_cache *lsm_file_cache;
-static struct kmem_cache *lsm_inode_cache;
+struct lsm_blob_sizes blob_sizes;
 
-char *lsm_names;
-static struct lsm_blob_sizes blob_sizes __ro_after_init;
+struct kmem_cache *lsm_file_cache;
+struct kmem_cache *lsm_inode_cache;
 
-/* Boot-time LSM user choice */
-static __initdata const char *chosen_lsm_order;
-static __initdata const char *chosen_major_lsm;
+#define SECURITY_HOOK_ACTIVE_KEY(HOOK, IDX) security_hook_active_##HOOK##_##IDX
 
-static __initconst const char *const builtin_lsm_order = CONFIG_LSM;
+/*
+ * Identifier for the LSM static calls.
+ * HOOK is an LSM hook as defined in linux/lsm_hookdefs.h
+ * IDX is the index of the static call. 0 <= NUM < MAX_LSM_COUNT
+ */
+#define LSM_STATIC_CALL(HOOK, IDX) lsm_static_call_##HOOK##_##IDX
 
-/* Ordered list of LSMs to initialize. */
-static __initdata struct lsm_info *ordered_lsms[MAX_LSM_COUNT + 1];
-static __initdata struct lsm_info *exclusive;
+/*
+ * Call the macro M for each LSM hook MAX_LSM_COUNT times.
+ */
+#define LSM_LOOP_UNROLL(M, ...) 		\
+do {						\
+	UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)	\
+} while (0)
+
+#define LSM_DEFINE_UNROLL(M, ...) UNROLL(MAX_LSM_COUNT, M, __VA_ARGS__)
 
 #ifdef CONFIG_HAVE_STATIC_CALL
 #define LSM_HOOK_TRAMP(NAME, NUM) \
@@ -155,490 +146,25 @@ struct lsm_static_calls_table
 #undef INIT_LSM_STATIC_CALL
 	};
 
-static __initdata bool debug;
-#define init_debug(...)						\
-	do {							\
-		if (debug)					\
-			pr_info(__VA_ARGS__);			\
-	} while (0)
-
-static bool __init is_enabled(struct lsm_info *lsm)
-{
-	if (!lsm->enabled)
-		return false;
-
-	return *lsm->enabled;
-}
-
-/* Mark an LSM's enabled flag. */
-static int lsm_enabled_true __initdata = 1;
-static int lsm_enabled_false __initdata = 0;
-static void __init set_enabled(struct lsm_info *lsm, bool enabled)
-{
-	/*
-	 * When an LSM hasn't configured an enable variable, we can use
-	 * a hard-coded location for storing the default enabled state.
-	 */
-	if (!lsm->enabled) {
-		if (enabled)
-			lsm->enabled = &lsm_enabled_true;
-		else
-			lsm->enabled = &lsm_enabled_false;
-	} else if (lsm->enabled == &lsm_enabled_true) {
-		if (!enabled)
-			lsm->enabled = &lsm_enabled_false;
-	} else if (lsm->enabled == &lsm_enabled_false) {
-		if (enabled)
-			lsm->enabled = &lsm_enabled_true;
-	} else {
-		*lsm->enabled = enabled;
-	}
-}
-
-/* Is an LSM already listed in the ordered LSMs list? */
-static bool __init exists_ordered_lsm(struct lsm_info *lsm)
-{
-	struct lsm_info **check;
-
-	for (check = ordered_lsms; *check; check++)
-		if (*check == lsm)
-			return true;
-
-	return false;
-}
-
-/* Append an LSM to the list of ordered LSMs to initialize. */
-static int last_lsm __initdata;
-static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
-{
-	/* Ignore duplicate selections. */
-	if (exists_ordered_lsm(lsm))
-		return;
-
-	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
-		return;
-
-	/* Enable this LSM, if it is not already set. */
-	if (!lsm->enabled)
-		lsm->enabled = &lsm_enabled_true;
-	ordered_lsms[last_lsm++] = lsm;
-
-	init_debug("%s ordered: %s (%s)\n", from, lsm->name,
-		   is_enabled(lsm) ? "enabled" : "disabled");
-}
-
-/* Is an LSM allowed to be initialized? */
-static bool __init lsm_allowed(struct lsm_info *lsm)
-{
-	/* Skip if the LSM is disabled. */
-	if (!is_enabled(lsm))
-		return false;
-
-	/* Not allowed if another exclusive LSM already initialized. */
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->name);
-		return false;
-	}
-
-	return true;
-}
-
-static void __init lsm_set_blob_size(int *need, int *lbs)
-{
-	int offset;
-
-	if (*need <= 0)
-		return;
-
-	offset = ALIGN(*lbs, sizeof(void *));
-	*lbs = offset + *need;
-	*need = offset;
-}
-
-static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
-{
-	if (!needed)
-		return;
-
-	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
-	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
-	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
-	/*
-	 * The inode blob gets an rcu_head in addition to
-	 * what the modules might need.
-	 */
-	if (needed->lbs_inode && blob_sizes.lbs_inode == 0)
-		blob_sizes.lbs_inode = sizeof(struct rcu_head);
-	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
-	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
-	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
-	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
-	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
-	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
-	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
-	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
-	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
-	lsm_set_blob_size(&needed->lbs_xattr_count,
-			  &blob_sizes.lbs_xattr_count);
-	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
-}
-
-/* Prepare LSM for initialization. */
-static void __init prepare_lsm(struct lsm_info *lsm)
-{
-	int enabled = lsm_allowed(lsm);
-
-	/* Record enablement (to handle any following exclusive LSMs). */
-	set_enabled(lsm, enabled);
-
-	/* If enabled, do pre-initialization work. */
-	if (enabled) {
-		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
-			exclusive = lsm;
-			init_debug("exclusive chosen:   %s\n", lsm->name);
-		}
-
-		lsm_set_blob_sizes(lsm->blobs);
-	}
-}
-
-/* Initialize a given LSM, if it is enabled. */
-static void __init initialize_lsm(struct lsm_info *lsm)
-{
-	if (is_enabled(lsm)) {
-		int ret;
-
-		init_debug("initializing %s\n", lsm->name);
-		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
-	}
-}
-
-/*
- * Current index to use while initializing the lsm id list.
- */
-u32 lsm_active_cnt __ro_after_init;
-const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
-
-/* Populate ordered LSMs list from comma-separated LSM name list. */
-static void __init ordered_lsm_parse(const char *order, const char *origin)
-{
-	struct lsm_info *lsm;
-	char *sep, *name, *next;
-
-	/* LSM_ORDER_FIRST is always first. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (lsm->order == LSM_ORDER_FIRST)
-			append_ordered_lsm(lsm, "  first");
-	}
-
-	/* Process "security=", if given. */
-	if (chosen_major_lsm) {
-		struct lsm_info *major;
-
-		/*
-		 * To match the original "security=" behavior, this
-		 * explicitly does NOT fallback to another Legacy Major
-		 * if the selected one was separately disabled: disable
-		 * all non-matching Legacy Major LSMs.
-		 */
-		for (major = __start_lsm_info; major < __end_lsm_info;
-		     major++) {
-			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			    strcmp(major->name, chosen_major_lsm) != 0) {
-				set_enabled(major, false);
-				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   chosen_major_lsm, major->name);
-			}
-		}
-	}
-
-	sep = kstrdup(order, GFP_KERNEL);
-	next = sep;
-	/* Walk the list, looking for matching LSMs. */
-	while ((name = strsep(&next, ",")) != NULL) {
-		bool found = false;
-
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (strcmp(lsm->name, name) == 0) {
-				if (lsm->order == LSM_ORDER_MUTABLE)
-					append_ordered_lsm(lsm, origin);
-				found = true;
-			}
-		}
-
-		if (!found)
-			init_debug("%s ignored: %s (not built into kernel)\n",
-				   origin, name);
-	}
-
-	/* Process "security=", if given. */
-	if (chosen_major_lsm) {
-		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if (exists_ordered_lsm(lsm))
-				continue;
-			if (strcmp(lsm->name, chosen_major_lsm) == 0)
-				append_ordered_lsm(lsm, "security=");
-		}
-	}
-
-	/* LSM_ORDER_LAST is always last. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (lsm->order == LSM_ORDER_LAST)
-			append_ordered_lsm(lsm, "   last");
-	}
-
-	/* Disable all LSMs not in the ordered list. */
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if (exists_ordered_lsm(lsm))
-			continue;
-		set_enabled(lsm, false);
-		init_debug("%s skipped: %s (not in requested order)\n",
-			   origin, lsm->name);
-	}
-
-	kfree(sep);
-}
-
-static void __init lsm_static_call_init(struct security_hook_list *hl)
-{
-	struct lsm_static_call *scall = hl->scalls;
-	int i;
-
-	for (i = 0; i < MAX_LSM_COUNT; i++) {
-		/* Update the first static call that is not used yet */
-		if (!scall->hl) {
-			__static_call_update(scall->key, scall->trampoline,
-					     hl->hook.lsm_func_addr);
-			scall->hl = hl;
-			static_branch_enable(scall->active);
-			return;
-		}
-		scall++;
-	}
-	panic("%s - Ran out of static slots.\n", __func__);
-}
-
-static void __init lsm_early_cred(struct cred *cred);
-static void __init lsm_early_task(struct task_struct *task);
-
-static int lsm_append(const char *new, char **result);
-
-static void __init report_lsm_order(void)
-{
-	struct lsm_info **lsm, *early;
-	int first = 0;
-
-	pr_info("initializing lsm=");
-
-	/* Report each enabled LSM name, comma separated. */
-	for (early = __start_early_lsm_info;
-	     early < __end_early_lsm_info; early++)
-		if (is_enabled(early))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
-	for (lsm = ordered_lsms; *lsm; lsm++)
-		if (is_enabled(*lsm))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
-
-	pr_cont("\n");
-}
-
-static void __init ordered_lsm_init(void)
-{
-	struct lsm_info **lsm;
-
-	if (chosen_lsm_order) {
-		if (chosen_major_lsm) {
-			pr_warn("security=%s is ignored because it is superseded by lsm=%s\n",
-				chosen_major_lsm, chosen_lsm_order);
-			chosen_major_lsm = NULL;
-		}
-		ordered_lsm_parse(chosen_lsm_order, "cmdline");
-	} else
-		ordered_lsm_parse(builtin_lsm_order, "builtin");
-
-	for (lsm = ordered_lsms; *lsm; lsm++)
-		prepare_lsm(*lsm);
-
-	report_lsm_order();
-
-	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
-	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
-	init_debug("ib blob size         = %d\n", blob_sizes.lbs_ib);
-	init_debug("inode blob size      = %d\n", blob_sizes.lbs_inode);
-	init_debug("ipc blob size        = %d\n", blob_sizes.lbs_ipc);
-#ifdef CONFIG_KEYS
-	init_debug("key blob size        = %d\n", blob_sizes.lbs_key);
-#endif /* CONFIG_KEYS */
-	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
-	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
-	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
-	init_debug("perf event blob size = %d\n", blob_sizes.lbs_perf_event);
-	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
-	init_debug("tun device blob size = %d\n", blob_sizes.lbs_tun_dev);
-	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr_count);
-	init_debug("bdev blob size       = %d\n", blob_sizes.lbs_bdev);
-
-	/*
-	 * Create any kmem_caches needed for blobs
-	 */
-	if (blob_sizes.lbs_file)
-		lsm_file_cache = kmem_cache_create("lsm_file_cache",
-						   blob_sizes.lbs_file, 0,
-						   SLAB_PANIC, NULL);
-	if (blob_sizes.lbs_inode)
-		lsm_inode_cache = kmem_cache_create("lsm_inode_cache",
-						    blob_sizes.lbs_inode, 0,
-						    SLAB_PANIC, NULL);
-
-	lsm_early_cred((struct cred *) current->cred);
-	lsm_early_task(current);
-	for (lsm = ordered_lsms; *lsm; lsm++)
-		initialize_lsm(*lsm);
-}
-
-int __init early_security_init(void)
-{
-	struct lsm_info *lsm;
-
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
-		if (!lsm->enabled)
-			lsm->enabled = &lsm_enabled_true;
-		prepare_lsm(lsm);
-		initialize_lsm(lsm);
-	}
-
-	return 0;
-}
-
 /**
- * security_init - initializes the security framework
+ * lsm_file_alloc - allocate a composite file blob
+ * @file: the file that needs a blob
  *
- * This should be called early in the kernel initialization sequence.
- */
-int __init security_init(void)
-{
-	struct lsm_info *lsm;
-
-	init_debug("legacy security=%s\n", chosen_major_lsm ? : " *unspecified*");
-	init_debug("  CONFIG_LSM=%s\n", builtin_lsm_order);
-	init_debug("boot arg lsm=%s\n", chosen_lsm_order ? : " *unspecified*");
-
-	/*
-	 * Append the names of the early LSM modules now that kmalloc() is
-	 * available
-	 */
-	for (lsm = __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++) {
-		init_debug("  early started: %s (%s)\n", lsm->name,
-			   is_enabled(lsm) ? "enabled" : "disabled");
-		if (lsm->enabled)
-			lsm_append(lsm->name, &lsm_names);
-	}
-
-	/* Load LSMs in specified order. */
-	ordered_lsm_init();
-
-	return 0;
-}
-
-/* Save user chosen LSM */
-static int __init choose_major_lsm(char *str)
-{
-	chosen_major_lsm = str;
-	return 1;
-}
-__setup("security=", choose_major_lsm);
-
-/* Explicitly choose LSM initialization order. */
-static int __init choose_lsm_order(char *str)
-{
-	chosen_lsm_order = str;
-	return 1;
-}
-__setup("lsm=", choose_lsm_order);
-
-/* Enable LSM order debugging. */
-static int __init enable_debug(char *str)
-{
-	debug = true;
-	return 1;
-}
-__setup("lsm.debug", enable_debug);
-
-static bool match_last_lsm(const char *list, const char *lsm)
-{
-	const char *last;
-
-	if (WARN_ON(!list || !lsm))
-		return false;
-	last = strrchr(list, ',');
-	if (last)
-		/* Pass the comma, strcmp() will check for '\0' */
-		last++;
-	else
-		last = list;
-	return !strcmp(last, lsm);
-}
-
-static int lsm_append(const char *new, char **result)
-{
-	char *cp;
-
-	if (*result == NULL) {
-		*result = kstrdup(new, GFP_KERNEL);
-		if (*result == NULL)
-			return -ENOMEM;
-	} else {
-		/* Check if it is the last registered name */
-		if (match_last_lsm(*result, new))
-			return 0;
-		cp = kasprintf(GFP_KERNEL, "%s,%s", *result, new);
-		if (cp == NULL)
-			return -ENOMEM;
-		kfree(*result);
-		*result = cp;
-	}
-	return 0;
-}
-
-/**
- * security_add_hooks - Add a modules hooks to the hook lists.
- * @hooks: the hooks to add
- * @count: the number of hooks to add
- * @lsmid: the identification information for the security module
+ * Allocate the file blob for all the modules
  *
- * Each LSM has to register its hooks with the infrastructure.
+ * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-			       const struct lsm_id *lsmid)
+static int lsm_file_alloc(struct file *file)
 {
-	int i;
-
-	/*
-	 * A security module may call security_add_hooks() more
-	 * than once during initialization, and LSM initialization
-	 * is serialized. Landlock is one such case.
-	 * Look at the previous entry, if there is one, for duplication.
-	 */
-	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid) {
-		if (lsm_active_cnt >= MAX_LSM_COUNT)
-			panic("%s Too many LSMs registered.\n", __func__);
-		lsm_idlist[lsm_active_cnt++] = lsmid;
+	if (!lsm_file_cache) {
+		file->f_security = NULL;
+		return 0;
 	}
 
-	for (i = 0; i < count; i++) {
-		hooks[i].lsmid = lsmid;
-		lsm_static_call_init(&hooks[i]);
-	}
-
-	/*
-	 * Don't try to append during early_security_init(), we'll come back
-	 * and fix this up afterwards.
-	 */
-	if (slab_is_available()) {
-		if (lsm_append(lsmid->name, &lsm_names) < 0)
-			panic("%s - Cannot get early memory.\n", __func__);
-	}
+	file->f_security = kmem_cache_zalloc(lsm_file_cache, GFP_KERNEL);
+	if (file->f_security == NULL)
+		return -ENOMEM;
+	return 0;
 }
 
 /**
@@ -673,46 +199,11 @@ static int lsm_blob_alloc(void **dest, size_t size, gfp_t gfp)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-static int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
+int lsm_cred_alloc(struct cred *cred, gfp_t gfp)
 {
 	return lsm_blob_alloc(&cred->security, blob_sizes.lbs_cred, gfp);
 }
 
-/**
- * lsm_early_cred - during initialization allocate a composite cred blob
- * @cred: the cred that needs a blob
- *
- * Allocate the cred blob for all the modules
- */
-static void __init lsm_early_cred(struct cred *cred)
-{
-	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
-
-	if (rc)
-		panic("%s: Early cred alloc failed.\n", __func__);
-}
-
-/**
- * lsm_file_alloc - allocate a composite file blob
- * @file: the file that needs a blob
- *
- * Allocate the file blob for all the modules
- *
- * Returns 0, or -ENOMEM if memory can't be allocated.
- */
-static int lsm_file_alloc(struct file *file)
-{
-	if (!lsm_file_cache) {
-		file->f_security = NULL;
-		return 0;
-	}
-
-	file->f_security = kmem_cache_zalloc(lsm_file_cache, GFP_KERNEL);
-	if (file->f_security == NULL)
-		return -ENOMEM;
-	return 0;
-}
-
 /**
  * lsm_inode_alloc - allocate a composite inode blob
  * @inode: the inode that needs a blob
@@ -743,7 +234,7 @@ static int lsm_inode_alloc(struct inode *inode, gfp_t gfp)
  *
  * Returns 0, or -ENOMEM if memory can't be allocated.
  */
-static int lsm_task_alloc(struct task_struct *task)
+int lsm_task_alloc(struct task_struct *task)
 {
 	return lsm_blob_alloc(&task->security, blob_sizes.lbs_task, GFP_KERNEL);
 }
@@ -812,20 +303,6 @@ static int lsm_bdev_alloc(struct block_device *bdev)
 	return 0;
 }
 
-/**
- * lsm_early_task - during initialization allocate a composite task blob
- * @task: the task that needs a blob
- *
- * Allocate the task blob for all the modules
- */
-static void __init lsm_early_task(struct task_struct *task)
-{
-	int rc = lsm_task_alloc(task);
-
-	if (rc)
-		panic("%s: Early task alloc failed.\n", __func__);
-}
-
 /**
  * lsm_superblock_alloc - allocate a composite superblock blob
  * @sb: the superblock that needs a blob
-- 
2.50.1

