Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8715C385D97
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741961; cv=none; b=iSDTG7I3p6Dzb+i/AXTLeyne8uf+o5WT3hV9z9oa+tyA20ITLhwFqrU0ZtkiFx9proB/XtJ9nw+Sx69dG2+6QS5EKNdYcbcvAX3QEUL+LGhLQwzR1Iqpbavx/tYWepy7dNU56wQNnPW/KmmhdlXb6vzbgeDMd+D7cSVb+rpVlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741961; c=relaxed/simple;
	bh=zqo6m8LjrfG7bSesx2T9EZa4xizDQh3mdGp3cS7tnOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n+nsE58qlENJCYRsqJEWFomd67eoMMohAAW1xoOz3qfc55BiWMYMcHC6wn7iMDaOoJmmrsTaHbM4j1IXay3RcDgL3BVJNVQafAxbLFKKqFCsjB9w0B9jyNgTgaX9A6wRv3wCLG1e0ypFXgi1bcPsWryqb0sK84mZtukMdQDL16E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4lwY70u; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4lwY70u"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910ad20d4so91945185a.3
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789741958; x=1790346758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjYyNGnoF+SuebSoqm6hERY788R/htkIW/64XrSsiYA=;
        b=U4lwY70u6yQBiRsyow5Yaus7B0psbXhmBU7EAcSIuIDoCPSVKdTukLli3YcZq1H8oe
         IeXJuUwFVFeNgyDUH8iz5vw8CH9q0dC/856TDnz2nurDPfnyQAyhhQ/oz615kRNkWhxr
         gJsZr8WQD1rP8J7yOr03O1zLZq+IwySZIDOSLqhGoMgmTZ1c6zemhKnxxVjJrVWvLrGr
         oX4RmNv9qOdvqxdPQ19jXR2RavvluFBTHNIl6gJU1AUsQacIaNCTadyMh9tgnJ28NvxM
         3oXm3J0ntWIc/SHLpAqGwdYt5uN/gYpGkhNObMDzg2xFPM8HSr69CPV8QwHTq/pLGcY1
         iCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789741958; x=1790346758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjYyNGnoF+SuebSoqm6hERY788R/htkIW/64XrSsiYA=;
        b=xANKjmRvjd0RzjwgldDZKsCWNFaNezxrx20lTGWpwB6Vpvfr989FLfRwBbDQ1icy1w
         +x47ie3jxqVUqO2dPbbxWExdfRP2/DZqbbygev6qFhmCGphCKs9t/78828D6xVHBhjJg
         fNkv8TLovmhK+A0NJWcgFaOTTfgrTGEeE9JbjtvyHZqatdkHbmg+jbh9NScPA8HLydK1
         q8tdM7mNz+vboLG0+Up4jZqQDJbLUI7ymgIHgMPyjUXX4Wo4MfGXNo8wb7sFwbm/dzBn
         RCjPb4GWPhZ5fX7Ulj5hnLWX+MxdG8Q+pCX0e8V2qHlxgxhm8eWO75el6qpnqTEUXQBB
         fddA==
X-Forwarded-Encrypted: i=1; AKwUvBzoaAkB47eGT97Kc9/WExYroDfAxw08djK9QWWe7t1qXEtQC23LyvZmiPwqrt+TEzWFJD6KW7ms@vger.kernel.org
X-Gm-Message-State: AFuF++lrFfKmkGUVzUEkSEz6qW1CXwPLvGumjlSr4vHT9yOibBu6bebi
	wWvl7l9rsJCJNrxm9xsAgpOpTs4Px/Ebi0hM2Ul9vEsiYtySFmJm6K13
X-Gm-Gg: AYBFou3RAXbf8ZAbYplLV1rwKyuHPRQD++2Z6bfxDkUgXHnNvKN0ga9uWTcN6XQw3hW
	QZr2/UPyTX+0aRR700g+yQrQKdK0qmr3D6QwaRaUrSSgRjIuRw1MFYbvU8l5CIe8CZH7YRoQ5eX
	qW2jrYNzvOibGUy5HII/LHmwSco5EDbD7EO+lSa4LDpYNjJqohe0jV4crrs0uoBaMnfbDBp3zxG
	Xv8Al3KD3C2NDyEd/e2BEzRnkrRPK+I9q/9W1wwfVs1a9/SgW0eyrZ+xvwGxnLFcnvdYYMY3K6v
	/rEkNGfv3hnrndK9FfjjAwrX2kOIzDg7INnvHuQA9T8tGv+3Jmy/zljx50nBJYqubdB9CW6sU44
	TvJ4b8Qg79AmXY0/9FRZ9PRbvhcJjQEzyKDng5bZ7p8b8VKCSnP6odGYazUCIfzJbpXWY1llknP
	qJSig4eSGrl/DG4331BkB3u9PkIk6T3aq93IzDzVbd98E9F4Eb2vojgxm+tnVrtpWsN+LdNup1n
	lvAV7FlPAm2IZ3trkbF1jeVksvL3PQnxe7RRUycuJ+HlQ6NUxBEw3be973FX43cZsySSJCBg2o=
X-Received: by 2002:a05:620a:4487:b0:939:a834:98f2 with SMTP id af79cd13be357-93bdc6d5b8fmr392605785a.15.1789741958163;
        Fri, 18 Sep 2026 07:32:38 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0f234ccsm149180385a.44.2026.09.18.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:32:37 -0700 (PDT)
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
Subject: [PATCH v3] lsm,nscommon: initialize the security blob for the initial namespaces
Date: Fri, 18 Sep 2026 10:31:43 -0400
Message-ID: <20260918143142.19435-2-stephen.smalley.work@gmail.com>
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
v3 adds a Return: line in the kerneldoc for ns_common_init_security().

 include/linux/ns_common.h |  3 +++
 kernel/nscommon.c         | 49 +++++++++++++++++++++++++++++++++++++++
 security/lsm_init.c       |  4 ++++
 3 files changed, 56 insertions(+)

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
index e72426bba29a..57e5074b97e3 100644
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
@@ -101,6 +107,49 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_ope
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
+ *
+ * Return: the first non-zero return from security_namespace_init(), or 0.
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

