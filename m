Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B052857F8
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212106; cv=none; b=BvuTd9JIiCVNxrTiolyvzMxNHMRrkvk+YyB9P/mP4V+Aso8k8mpZnBmtZZa4y/Rl95aVifPol+zM5Enml5Nry/EgMDGspy3ha4gERPJqefmENPpsH6pEe+2Z3CWxFuZehHxEHbMPgFJ0ZBSG1OTucqZ9x8e2XfqhyXjf5AbYY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212106; c=relaxed/simple;
	bh=23AsZ9odM9WWEepZeHamcZ3a+bwdjdqFRnl3o2DPr6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwuTy+wSix1Tk2PFBnoIfUn2gP1+C5w2MZb9nyfEpDweLlQjO2HUqJ54xikCA8+ZZMiW30ALIor9KJQxFcxApDxMP9MFDZMgkum/+ko1n2bDRGXlioJmJ3ogGxRLlIPq5uJGcjTev/kVqZqPwqL0XAYEIULNVq3yrB2QgSqUjO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TweKmTi1; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TweKmTi1"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70a9282139fso12859366d6.1
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212103; x=1755816903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2dhyjVYiyy7dlztpxlvKoEqGvEFS3+OD7Wwgm3NoTQ=;
        b=TweKmTi1fTgF4+v/1b7tvKCeqMTLuk3uc7V86UlRz2PO7Q/v+tp93bIzJAigcOkK+Q
         5NieEeUjf87bee3f3U6/gM5BQmiMsX2ry5TpjvmwFwyau2AWmQksyjR6naNsiC3BdAvZ
         ClmoZXw3xm3OR4Gimc2gb4V259WKAtC3xA9hyxFTDtH9BXbHNHpyKB0q5MSZuxGqN1+I
         UPePZ+jhcfBUi4wL0+/zYpHnMoc78yn5No6GtUrCLLDomS4sDzV1V/GUWPX3s0Kqi7xc
         66byAqPBkinVxOdf1AP0eoiZG1p0Yk1mUoyU+LeRaYOGPbc1h4dYaE0k2Qy3HF6X4GQw
         8lBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212103; x=1755816903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2dhyjVYiyy7dlztpxlvKoEqGvEFS3+OD7Wwgm3NoTQ=;
        b=F6vP7rP9Ky2prBRLjIvxuTJUosQddNpwb1A1X3BkUqnujAkthJWeXnGUvbaJ1C8LvG
         nvCdFb+8BONE9ZWBqfodZ+xrupNSj7OgCTRvqg0i+9OZ3nPmkLUd0RKgvhyqTNRw5ryn
         XfX33NiBCQOFL3c3ciWkaO0ozy4Fe9kNwlwy/EJGvPypKM/U27ZcwD6duyGamjA5MfQq
         7fSbindwu7Uku5Z/MMQO+Dsz8J9too3xu+2jIFQ4M2nOALgBVq0EdsfN6roiC4/jXUvu
         kbJtVOHBoTosXwxeDTenJyORneCv5n2XlcGaNX9jJ5on/buHTchF3YNv2cLiOtf7hqOv
         64Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWLm5/0zRsK8NKmfdDYKh9SvQmPoklwyOVLcZ6tsqOmnwOiAR29wLbkdOj23lD8oamjYUnNMBO7@vger.kernel.org
X-Gm-Message-State: AOJu0YwBH+oCF+sjrXmP65mThJKCpXSEL9djsjFoxAuF1Y9srFVCD1Fp
	T2MQJ46VzPs/sIPJdFBvXeiOjXUwJ02+SPiySbsmAWYlijVVEcTI/C+qly4XQy6ZtA==
X-Gm-Gg: ASbGncs24aOYt5z7cYtdrQsLB+RlmAxUWx3lpeOeGF5VLKmBN99l5tCoQ7Rwc4Sl5Xe
	PjUHlMP7KNEWU/muqV8PiGqJ1Tb8I6BOcgnna13IiHahf60pMWHhK06COtL7S8ic3QPUh9RB/gh
	8xutHAkYXKlqj3aWOD0wJ8MYEfxfsblTEoWFRxu+d2eqgRoY6PtW8xdDN9gBerck/ZPEZmQMlGx
	8EpzsiM0J6USNQeNor5zRyTSZ+uFzU3AWkC46xfEd7Ybbe/ydY90RmuOn5KepJqoCFn36NQ4dol
	ygnvxzmlIkFZWjl6A1xGTIhIfgBw8DbG/gKNr17LfY6bqUAfx9+CgBNDyF3XSleZwruE3MLI/S7
	pwIS2EMEwxQfLA7GTIXJI2E8VXHW5pQ9f4qZ3OQKoosjpWOgEtHEdfHgMpv4po+Km+Rt2ifNLmO
	3LeA==
X-Google-Smtp-Source: AGHT+IE1pWVaGPVrnuvUze5zuWOz07/YlWs2ucMYl02RhpnjGjxlOdma/MvcLWHq3st92mmeZ0/wIw==
X-Received: by 2002:a0c:e010:0:b0:70b:9b35:4056 with SMTP id 6a1803df08f44-70b9b354060mr43758236d6.15.1755212103414;
        Thu, 14 Aug 2025 15:55:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70af5b75ca2sm19076166d6.59.2025.08.14.15.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:55:02 -0700 (PDT)
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
Subject: [PATCH v3 32/34] selinux: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:41 -0400
Message-ID: <20250814225159.275901-68-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10960; i=paul@paul-moore.com; h=from:subject; bh=23AsZ9odM9WWEepZeHamcZ3a+bwdjdqFRnl3o2DPr6M=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmj0h+UH88M+MuHq4o8alLQNBFfFePTUSr1YN vElGWP1oZ6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o9AAKCRDqIPLalzeJ c0boEACkx/Qi09ZK+6LyKGcBhbyvKHsM5lMOjL6mlLTJ3JKi0Qg3V+6SDXJ6HX17tnVEFZc5nCu mEMl060u4BersfK+HQ1ClgUJMOhUEkOiBjwJJaEa/llN2bxhg5Ezvk9HOTedSCHw3ueY4C++YrQ Ri7yYYzFvZAMcq9/RooIetTxupUekdqwU3o9BPmDF+n5TFUJUMisTI1yg/GPwI7hCXbqeiTNwbI RcdyUXfKYRTlWrz8fmGXv3Q4Rmwr/evDIqtGOJKkkoVeCOjQRKWgtcxP0XPTvX1dhR8PqFy9bdl snolJvXRTpYcjqTlfv3Iqw2IAkbomX2IgOTAMIl2wwUjfQGs5eFXLzaKci0fJUq2Vy0VDTMqd9L ZoVNdtZZ879cN2xC/htTa9cBcgwPNuFomSGV/hljWqfm23Pl8zlgiwboHgKXPSoA14k9x+3pO6O tgXHxLtwdRJJVKf2YErFCJ6WHYAe1dUfNwiXea8osXItUp4TfKS536p4dGAQJNBI9zBD92m5a6N tQz/eOKawi9qNsYTP0l0he5CKYYlc6UYyqjgQrQ/jajTIAysqZGOXE3lqK40PMmnkyM7FvThQ5q 1nB/01C7nILb7oUW/5Fh0hHtlrBfSSIgKILMt2UnVYtZEmpNsmmTWz99N77p5W0oxlM0SkIVwSp /6ryfu0QE/3MPAg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

SELinux currently has a number of initcalls so we've created a new
function, selinux_initcall(), which wraps all of these initcalls so
that we have a single initcall function that can be registered with the
LSM framework.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/Makefile            |  2 +-
 security/selinux/hooks.c             |  9 +++--
 security/selinux/ibpkey.c            |  5 ++-
 security/selinux/include/audit.h     |  9 +++++
 security/selinux/include/initcalls.h | 19 ++++++++++
 security/selinux/initcalls.c         | 52 ++++++++++++++++++++++++++++
 security/selinux/netif.c             |  5 ++-
 security/selinux/netlink.c           |  5 ++-
 security/selinux/netnode.c           |  5 ++-
 security/selinux/netport.c           |  5 ++-
 security/selinux/selinuxfs.c         |  5 ++-
 security/selinux/ss/services.c       | 26 ++++----------
 12 files changed, 107 insertions(+), 40 deletions(-)
 create mode 100644 security/selinux/include/initcalls.h
 create mode 100644 security/selinux/initcalls.c

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 66e56e9011df..72d3baf7900c 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -15,7 +15,7 @@ ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
 ccflags-$(CONFIG_SECURITY_SELINUX_DEBUG) += -DDEBUG
 
 selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o netif.o \
-	     netnode.o netport.o status.o \
+	     netnode.o netport.o status.o initcalls.o \
 	     ss/ebitmap.o ss/hashtab.o ss/symtab.o ss/sidtab.o ss/avtab.o \
 	     ss/policydb.o ss/services.o ss/conditional.o ss/mls.o ss/context.o
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d94b1ff316ba..faa78d16e1b9 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -94,6 +94,7 @@
 #include <linux/io_uring/cmd.h>
 #include <uapi/linux/lsm.h>
 
+#include "initcalls.h"
 #include "avc.h"
 #include "objsec.h"
 #include "netif.h"
@@ -7603,6 +7604,10 @@ static __init int selinux_init(void)
 	if (avc_add_callback(selinux_lsm_notifier_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC LSM notifier callback\n");
 
+	if (avc_add_callback(selinux_audit_rule_avc_callback,
+			     AVC_CALLBACK_RESET))
+		panic("SELinux: Unable to register AVC audit callback\n");
+
 	if (selinux_enforcing_boot)
 		pr_debug("SELinux:  Starting in enforcing mode\n");
 	else
@@ -7635,6 +7640,7 @@ DEFINE_LSM(selinux) = {
 	.enabled = &selinux_enabled_boot,
 	.blobs = &selinux_blob_sizes,
 	.init = selinux_init,
+	.initcall_device = selinux_initcall,
 };
 
 #if defined(CONFIG_NETFILTER)
@@ -7696,7 +7702,7 @@ static struct pernet_operations selinux_net_ops = {
 	.exit = selinux_nf_unregister,
 };
 
-static int __init selinux_nf_ip_init(void)
+int __init selinux_nf_ip_init(void)
 {
 	int err;
 
@@ -7711,5 +7717,4 @@ static int __init selinux_nf_ip_init(void)
 
 	return 0;
 }
-__initcall(selinux_nf_ip_init);
 #endif /* CONFIG_NETFILTER */
diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index 470481cfe0e8..ea1d9b2c7d2b 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -23,6 +23,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 
+#include "initcalls.h"
 #include "ibpkey.h"
 #include "objsec.h"
 
@@ -218,7 +219,7 @@ void sel_ib_pkey_flush(void)
 	spin_unlock_irqrestore(&sel_ib_pkey_lock, flags);
 }
 
-static __init int sel_ib_pkey_init(void)
+int __init sel_ib_pkey_init(void)
 {
 	int iter;
 
@@ -232,5 +233,3 @@ static __init int sel_ib_pkey_init(void)
 
 	return 0;
 }
-
-subsys_initcall(sel_ib_pkey_init);
diff --git a/security/selinux/include/audit.h b/security/selinux/include/audit.h
index d5b0425055e4..85a531ac737b 100644
--- a/security/selinux/include/audit.h
+++ b/security/selinux/include/audit.h
@@ -15,6 +15,15 @@
 #include <linux/audit.h>
 #include <linux/types.h>
 
+/**
+ * selinux_audit_rule_avc_callback - update the audit LSM rules on AVC events.
+ * @event: the AVC event
+ *
+ * Update any audit LSM rules based on the AVC event specified in @event.
+ * Returns 0 on success, negative values otherwise.
+ */
+int selinux_audit_rule_avc_callback(u32 event);
+
 /**
  * selinux_audit_rule_init - alloc/init an selinux audit rule structure.
  * @field: the field this rule refers to
diff --git a/security/selinux/include/initcalls.h b/security/selinux/include/initcalls.h
new file mode 100644
index 000000000000..6674cf489473
--- /dev/null
+++ b/security/selinux/include/initcalls.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SELinux initcalls
+ */
+
+#ifndef _SELINUX_INITCALLS_H
+#define _SELINUX_INITCALLS_H
+
+int init_sel_fs(void);
+int sel_netport_init(void);
+int sel_netnode_init(void);
+int sel_netif_init(void);
+int sel_netlink_init(void);
+int sel_ib_pkey_init(void);
+int selinux_nf_ip_init(void);
+
+int selinux_initcall(void);
+
+#endif
diff --git a/security/selinux/initcalls.c b/security/selinux/initcalls.c
new file mode 100644
index 000000000000..f6716a1d38c1
--- /dev/null
+++ b/security/selinux/initcalls.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SELinux initcalls
+ */
+
+#include <linux/init.h>
+
+#include "initcalls.h"
+
+/**
+ * selinux_initcall - Perform the SELinux initcalls
+ *
+ * Used as a device initcall in the SELinux LSM definition.
+ */
+int __init selinux_initcall(void)
+{
+	int rc = 0, rc_tmp = 0;
+
+	rc_tmp = init_sel_fs();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_netport_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_netnode_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_netif_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+	rc_tmp = sel_netlink_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+
+#if defined(CONFIG_SECURITY_INFINIBAND)
+	rc_tmp = sel_ib_pkey_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+#endif
+
+#if defined(CONFIG_NETFILTER)
+	rc_tmp = selinux_nf_ip_init();
+	if (!rc && rc_tmp)
+		rc = rc_tmp;
+#endif
+
+	return rc;
+}
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 78afbecdbe57..e24b2cba28ea 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -22,6 +22,7 @@
 #include <linux/rcupdate.h>
 #include <net/net_namespace.h>
 
+#include "initcalls.h"
 #include "security.h"
 #include "objsec.h"
 #include "netif.h"
@@ -265,7 +266,7 @@ static struct notifier_block sel_netif_netdev_notifier = {
 	.notifier_call = sel_netif_netdev_notifier_handler,
 };
 
-static __init int sel_netif_init(void)
+int __init sel_netif_init(void)
 {
 	int i;
 
@@ -280,5 +281,3 @@ static __init int sel_netif_init(void)
 	return 0;
 }
 
-__initcall(sel_netif_init);
-
diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 1760aee712fd..eb40e4603475 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -17,6 +17,7 @@
 #include <net/net_namespace.h>
 #include <net/netlink.h>
 
+#include "initcalls.h"
 #include "security.h"
 
 static struct sock *selnl __ro_after_init;
@@ -105,7 +106,7 @@ void selnl_notify_policyload(u32 seqno)
 	selnl_notify(SELNL_MSG_POLICYLOAD, &seqno);
 }
 
-static int __init selnl_init(void)
+int __init sel_netlink_init(void)
 {
 	struct netlink_kernel_cfg cfg = {
 		.groups	= SELNLGRP_MAX,
@@ -117,5 +118,3 @@ static int __init selnl_init(void)
 		panic("SELinux:  Cannot create netlink socket.");
 	return 0;
 }
-
-__initcall(selnl_init);
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 5d0ed08d46e5..9b3da5ce8d39 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -30,6 +30,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 
+#include "initcalls.h"
 #include "netnode.h"
 #include "objsec.h"
 
@@ -290,7 +291,7 @@ void sel_netnode_flush(void)
 	spin_unlock_bh(&sel_netnode_lock);
 }
 
-static __init int sel_netnode_init(void)
+int __init sel_netnode_init(void)
 {
 	int iter;
 
@@ -304,5 +305,3 @@ static __init int sel_netnode_init(void)
 
 	return 0;
 }
-
-__initcall(sel_netnode_init);
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 6fd7da4b3576..9e62f7285e81 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -29,6 +29,7 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 
+#include "initcalls.h"
 #include "netport.h"
 #include "objsec.h"
 
@@ -218,7 +219,7 @@ void sel_netport_flush(void)
 	spin_unlock_bh(&sel_netport_lock);
 }
 
-static __init int sel_netport_init(void)
+int __init sel_netport_init(void)
 {
 	int iter;
 
@@ -232,5 +233,3 @@ static __init int sel_netport_init(void)
 
 	return 0;
 }
-
-__initcall(sel_netport_init);
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 9aa1d03ab612..657e6ff65be7 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -35,6 +35,7 @@
 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */
 
+#include "initcalls.h"
 #include "flask.h"
 #include "avc.h"
 #include "avc_ss.h"
@@ -2130,7 +2131,7 @@ static struct file_system_type sel_fs_type = {
 
 struct path selinux_null __ro_after_init;
 
-static int __init init_sel_fs(void)
+int __init init_sel_fs(void)
 {
 	struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
 					  sizeof(NULL_FILE_NAME)-1);
@@ -2174,5 +2175,3 @@ static int __init init_sel_fs(void)
 
 	return err;
 }
-
-__initcall(init_sel_fs);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 713130bd43c4..13fc712d5923 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3570,6 +3570,13 @@ struct selinux_audit_rule {
 	struct context au_ctxt;
 };
 
+int selinux_audit_rule_avc_callback(u32 event)
+{
+	if (event == AVC_CALLBACK_RESET)
+		return audit_update_lsm_rules();
+	return 0;
+}
+
 void selinux_audit_rule_free(void *vrule)
 {
 	struct selinux_audit_rule *rule = vrule;
@@ -3820,25 +3827,6 @@ int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vru
 	return match;
 }
 
-static int aurule_avc_callback(u32 event)
-{
-	if (event == AVC_CALLBACK_RESET)
-		return audit_update_lsm_rules();
-	return 0;
-}
-
-static int __init aurule_init(void)
-{
-	int err;
-
-	err = avc_add_callback(aurule_avc_callback, AVC_CALLBACK_RESET);
-	if (err)
-		panic("avc_add_callback() failed, error %d\n", err);
-
-	return err;
-}
-__initcall(aurule_init);
-
 #ifdef CONFIG_NETLABEL
 /**
  * security_netlbl_cache_add - Add an entry to the NetLabel cache
-- 
2.50.1

