Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFD331716E
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739178; cv=none; b=kQDualgzq3BQihHjWkPkaWA1oXZuQRiI4NvrQhy2i5ubSYIyQrJpaN2IM7SluSaOx1O5e9X65ZJgpqgHyAGN+IWtotWjgwIvalHtiK5obP4afewruY8bCrCPa7g6owlDC7cG8vy4GOCECmwMOdnFECgdlGsWtjYkdlozo0x0wFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739178; c=relaxed/simple;
	bh=XB/VTDiqWRSLyCXv8zyZ/0XA9OB7QICikTe6h+Ypc/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pTpm3tuPkrDjeLO50TYayINLzJq+wTV1xZ9ZBKOCEN3e6TzIhHM6QgmeFETHGawnAc7YdKdDdX7/fh0WjxpGHN5dDgZRSQjlRv9vEMOvlTm2JJSBWLpbv/FSMcNdJRkX9siHtvWXp3yZbIyfCvX0PPRGa6cQKSRcJR9QhWfc2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKPxtKlx; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKPxtKlx"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-52fb76ec395so5984431cf.2
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789739176; x=1790343976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tt+LjPfflNlpvie9HnpAaRLp0wxtNQCBzoK4l3wNARg=;
        b=cKPxtKlxhf+v3P5A57CsKQQ85NqD2+s1eTHdAHbv9bagD0rhDD7O/EBm82zyneGSqG
         B9YcE7/+6FKFOEQZZEXpBInywuqorr4gnzc41GqtRagUCcR55QEyuEch695KXN10u1g5
         s9J+dYu+X41BZvCJ7plOukjowkw0jljBlqGFmjpcm1+fSpB8Z/W+/NwyKj03ZS+NEV/O
         bh8oA6+G6fASGtPBAG/Ov8kdQoGw9wLwvRqv8ZtTl0FkY7UovgVfA//g8OOF9hxVygFD
         noKytxZEtfQ9fsn6rSbUR27li88qW4iE6lSPrnNX53fvO5EOoWg8ZLFY8AGpzXI247N5
         +bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789739176; x=1790343976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tt+LjPfflNlpvie9HnpAaRLp0wxtNQCBzoK4l3wNARg=;
        b=tIKfL0+imgP9ZXsIgB3DkeLiAYhDBDCulx/+H9Vsg2V976ri93irxgpIaFvvIsBzha
         SMqSPYVYsJBXIgtSdjJ8AsjCSoa2UcYdLlrTBy3dm6rSBhIOjHTVsZHlkS6mVSsRs5VF
         7QCxi7UMN4CO29o4Q47GG+KjBkmMS8dhsUuYfkvPM/To/GELaSOcKCF4XBSX4HwoTvKZ
         s+2AagaxydcRbnmKXZbu8ttrGY5f+Gzmn5TSLFCjWZbxYaQk4qLh0j+6SDiXsJTRmjdu
         Axx+AX/GFVP2ETWzY5NXOxjPdBgoGWxo0LfifM6zBpKQL8s9cEqChCTRTAV2U2OoKGU6
         V4dg==
X-Forwarded-Encrypted: i=1; AKwUvByJYZTPn2nnqJmOUOfpJUBwBH4K9tGsGDdmRZcGoHvMl8JNo58Uv/ZlOheYozTJ5dic7aBV0DyI@vger.kernel.org
X-Gm-Message-State: AFuF++lQvkPILodi5RkAOXrL2q7pvcGNjgKvL7ds8WHUcmWOpsYrHzbb
	WRC/K7tl4IULD1EoTPrKqX3PQ53J7QsTGUtsawA8zC6cfEKcdxhRtCYZ
X-Gm-Gg: AYBFou3EK/mAZ47dVVvwM3BE/S6EBd2Kp54DJ+CzEdxONtKRQtBaiYvG/8lPoqzLtHm
	MMhXk3ZMH6V9ly6+yVIISMcvodYb/Ws9fa5sRTmfO/43MG5mHzMTh2mHxGdy6SDa+VIySw6DBn8
	/QtiE92VnqBt0y5PkileF+xNdp0NQQZQx24GUXDrg69N74hq22Rkba0LKmoIJ0/AoVHB9l2cjzU
	kjRAhzItIJIYelI8IfJGtgUGVTEeUDxbLDNTP3dO2MvmZyMajt2SFPdrJPvywn6IyPDQFGgNwUF
	3dtHoEHbG5wbPTzRpufoZpTpViDodqMg4bcvRVOITUPmHcW/nnSPjqME57LDAATfHwiav5ztgvi
	KBKuyWP8+KU7C7rlbIK2tOAlI/NFuCZqL8/5TcS7mu8eqZYrcfD7qFLwh2eWG2GDkYmXrvXHKgV
	X8Dfau4Mk1mesALnvcvXdAifdD7W/xYV+5pFRnsltzr4ekAdlbfYs3rA7Cpo+Cx8B7O03vRy19R
	j6Wingq8qcpySXGBYI+hDo3RsEHUqvngc2GcvK93CjEEcwRfbtrs1mkMjmCa8ryxrGQeVm0Nyg=
X-Received: by 2002:a05:620a:45a5:b0:93b:d7b7:b30b with SMTP id af79cd13be357-93bdca24367mr377561185a.86.1789739175790;
        Fri, 18 Sep 2026 06:46:15 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0e508a2sm140889285a.11.2026.09.18.06.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:46:15 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	brauner@kernel.org,
	mic@digikod.net,
	serge@hallyn.com,
	jack@suse.cz,
	jmorris@namei.org,
	omosnacek@gmail.com,
	selinux@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] lsm,nscommon: initialize the security blob for the initial namespaces
Date: Fri, 18 Sep 2026 09:44:23 -0400
Message-ID: <20260918134422.17053-2-stephen.smalley.work@gmail.com>
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

Provide a ns_common_init_security() helper in kernel/nscommon.c so
that the list of statically-defined initial namespaces and their
Kconfig guards live next to the rest of the ns_common
infrastructure. init_net is intentionally excluded: pre-initializing
it here would leak once __ns_common_init() clears ns_security and
re-allocates.

Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 implements Christian Brauner's suggestion to call
security_namespace_init from the ns common code and avoid the
callback since there is only one.

 include/linux/ns_common.h |  3 +++
 kernel/nscommon.c         | 47 +++++++++++++++++++++++++++++++++++++++
 security/lsm_init.c       |  4 ++++
 3 files changed, 54 insertions(+)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index c8e227a3f9e2..9321db8b82a1 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -11,6 +11,9 @@
 bool is_current_namespace(struct ns_common *ns);
 int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
 void __ns_common_free(struct ns_common *ns);
+#ifdef CONFIG_SECURITY
+int ns_common_init_security(void);
+#endif
 struct ns_common *__must_check ns_owner(struct ns_common *ns);
 
 static __always_inline bool is_ns_init_inum(const struct ns_common *ns)
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index e72426bba29a..48df4916d1e2 100644
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
@@ -101,6 +107,47 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
 	return 0;
 }
 
+/**
+ * ns_common_init_security - allocate LSM state for the initial namespaces
+ *
+ * The initial namespaces are set up statically via NS_COMMON_INIT() at compile
+ * time and therefore never pass through __ns_common_init(), so their LSM blob
+ * is left unallocated. Called from security_init() once all ordered LSMs are
+ * registered so every LSM's namespace_init hook fires on them the same way it
+ * does for init_net (which is initialized at runtime via
+ * ns_common_init(&init_net) from net_ns_init() and is therefore excluded
+ * here).
+ */
+#ifdef CONFIG_SECURITY
+int __init ns_common_init_security(void)
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
+		ret = security_namespace_init(set[i]);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+#endif
+
 void __ns_common_free(struct ns_common *ns)
 {
 	security_namespace_free(ns);
diff --git a/security/lsm_init.c b/security/lsm_init.c
index dbda7771013b..7cc2975b287a 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -7,6 +7,7 @@
 
 #include <linux/init.h>
 #include <linux/lsm_hooks.h>
+#include <linux/ns_common.h>
 
 #include "lsm.h"
 
@@ -490,6 +491,9 @@ int __init security_init(void)
 		lsm_init_single(*lsm);
 	}
 
+	if (ns_common_init_security())
+		panic("initial LSM ns alloc failed\n");
+
 	return 0;
 }
 
-- 
2.55.0

