Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A29243378
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140277; cv=none; b=qLX03tIbPIDHcrtzkUPcskj4bQmQNjG22aRyQzMOc7j2/yp7BFmK+Oagb/AW2lDBzhBpW2xsbd0EvEb/70kndGJ+AUmQkbEnqtUQBArSwuhSDvXxdT8niPpOPRFWfyC+6poxi9qsH7oBTQgz0JFlB/0EQR56uId4rGzl6wR/VOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140277; c=relaxed/simple;
	bh=zpeAO69OEWmJVWMVG7ri+86ZB9Q65U1Y8GdJVeIPsBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tmr8CHMd+cYgGRHD+HGxZgIgkgcwH07ux0xXrBbIEkdpVE0jb91tbGgLrogUgctQRrsxevh0iqNwPUKLQM323EdjguePH4Zw4lvdH9q2saEjNBqkpYgqskw92Eeccsc2PwNv1WZcjJkaa1+HOi3GBNA6P3sPr3yZyuuaEsLXCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PHrEQ6yS; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PHrEQ6yS"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e29d5f7672so449105485a.3
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140274; x=1753745074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WszSZhhah8zUU7olR2ZTPUB6rke93lNkXZvLL4LMtI=;
        b=PHrEQ6yS/jcMFWCpPd28Of5H6wZd4f8odo/+novJMl68Gb9ilDXqOK13H0Qe6hBkEh
         oSwQQFVtIL0013UtAcHcl6su0gfBRI8APKxRYviHDzIMFKxq2aJsJzxxjt6+enqDLsfG
         StlR2C62JGUPkDaXzZgQI4Rvlh3mnr7IRcgIh9rdA80pE141QOHTAhlso851RfRwMQyF
         fR7PQSUO49FMzHNsS41ALM3sBBfHBNFQluXr9DnnY7vbjaXYY0unO2XXtKRR99w6zp4E
         QwZCgI5mpw0IBf9YEHfeKGGS2vKVUe3yHqZtuzIGFXgiM2HAiDja0l4ghuKArja1pcJy
         0wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140274; x=1753745074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WszSZhhah8zUU7olR2ZTPUB6rke93lNkXZvLL4LMtI=;
        b=qO+xQCPxw/LBZMrxyrJiAlvTKPVm+pNcN8lEqrAziJsgp9xi4PXSYtOp35kZ22A/Cn
         nlrkmGMMKFlOBAxtKBt1hmzYbpP4Ft7XGHTKhl772hfOTwDomh2i87isRFOfiQIKz/Nb
         lvMCN3h67BV3LYq5RbHQkTG9aR/v5yTWn8+rB7V7DoZ6h3VaVLaL3sNydSrzy5JZiSmh
         S/r76LsSX0E91NJaVN4h4j9IYy58J1P8Ncg8Ll4B5vQPUuY92rUT2+S8vXX/y/htVdew
         Yl5z2HhPlOdsboCVJUiGkFF1JD1rtHVxN19R/y/Wtll97w87LN7veKBW1rFagg0D1LOf
         k68A==
X-Forwarded-Encrypted: i=1; AJvYcCUK9CMdFfRyqRny7JrOl0q3zJWuoB147re8GQKw/genqNxNLQzKu/+WCiM+D2QD8Cmt+jQhswLY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3i3wpBJx+Nc9owCBtvGJXnBxf8sGfgIsC2prE+7LdBZTXS9tZ
	XC+aqSgu39m21H2l+H/ZE7qv/yKP3Je5IDmtBeQQ9/thDYZ6BrdEniwHiy2AOi9H8w==
X-Gm-Gg: ASbGnctENBlUEITQS7WMeBU1nBDtAB9q7Jn+dwQgRk/VW4Mlr/gRQ3cZwJoi4n+Cg1b
	QRPGQS8343F/YNMQlJzgqYPo9vl/jbYns1L/+kEmUKf89ArLLTYKr9xqxI5ez5vjncPLqzmDvG9
	wPzBJu/4F0qGdiHMOO0HmSmfOSVW0vxNOZOvWqNnTgmu4zzM8Mp4JZv/NRW63efI69+EGSgHb0L
	7rMx03do+IhejCxvhOMpUym5BgenOckJytYlgvGZwk8VI7FsRWFWLUh4AoFCX2IK9ApLkj6fAYJ
	2sSwBk/dR4v7T2ylqMRnRfewPA8wXT2PP1hVw0Npvyrm4/W8dWd1iU/BOvSoLcXsshwsl/atxRO
	7fFJySoE/GJKL0oKc4M8Mdnr0tr3HPoBWlu2ZWXZpy66PMMcxspPc7HgeHbcoNJZHqn8=
X-Google-Smtp-Source: AGHT+IFWtt4J+WhYDOkAUgwK+SwuA+JsLkN4md/MkPCSV/XwbkuR+7il9DZWGP0yndbSn/DJLuUOYw==
X-Received: by 2002:a05:620a:198a:b0:7d2:25df:8127 with SMTP id af79cd13be357-7e342a5ee5fmr3199158185a.3.1753140274516;
        Mon, 21 Jul 2025 16:24:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051ba6b02dsm43945576d6.63.2025.07.21.16.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:34 -0700 (PDT)
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
Subject: [RFC PATCH v2 32/34] selinux: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:35 -0400
Message-ID: <20250721232142.77224-68-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10960; i=paul@paul-moore.com; h=from:subject; bh=zpeAO69OEWmJVWMVG7ri+86ZB9Q65U1Y8GdJVeIPsBc=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsv5U7IapjY029dG069FW+4SyJuZbrxMKGWC+ z0mDAA7KcOJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L+QAKCRDqIPLalzeJ c806D/wPpmCiaYpv4+eub4nDlxQcWpQ2SBrmbI45zBVg3rGxhBxnoI/CghwPg0bRz4PjgDpe12q 3cZfXGvdKsGE0sGMEZcCXA5ogb/ccangHrQVwtavxysOMe6G/5OU+hiSvOTT4jZ7v/dFyyEpxwU DCEn314N7tmjbjulqzRuds4dJ1K+LGtbylVfrEWwf/x6UtY6NfwDqpjJxKShUREUNCGUVn1UJCH r1iwQEnuRiIfwnhKexcd6on1J39fX7RULBCuRG08EkvcXW9yREBzhboCxWXVfBfFjhnV2zxUiv2 F5aKj/4gLjf3UFc4dRJTmk5jlV7D8/RTti0Jw35NfCXvF/rxXeRStrJcv/xu0rMgutN8ABucH87 f7q/nbWmBHVuHRAA7h+jQaxRkkYzy9nFDfiRCkkFxJBi90KE3ycgxN1veOKcF205BcriNXTPoiV DB+UojxRhYi4HGE7BqaM/LP7VcGukjXJd0+RNcJlMJ0BrYGJTQhuqN3hqbtaWi23I9j749xo6YQ 64f/EkMqRpSTKpfqMLbVTj1QhRw3FuBQ7GAqnKPSs+w04KS34sL6emkGjVYG5CsvRC5PuKIvBDj NSJXrBXQrCXvPsEamLpPVaxt5igTdlo08shkTmF/smhepWBQG8g0E7YDJhbyif4OC+sojOKlk/r 4q5iPTWXT/vxv4Q==
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
index d7ec6bc6168b..d7dca1e23312 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -94,6 +94,7 @@
 #include <linux/io_uring/cmd.h>
 #include <uapi/linux/lsm.h>
 
+#include "initcalls.h"
 #include "avc.h"
 #include "objsec.h"
 #include "netif.h"
@@ -7613,6 +7614,10 @@ static __init int selinux_init(void)
 	if (avc_add_callback(selinux_lsm_notifier_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC LSM notifier callback\n");
 
+	if (avc_add_callback(selinux_audit_rule_avc_callback,
+			     AVC_CALLBACK_RESET))
+		panic("SELinux: Unable to register AVC audit callback\n");
+
 	if (selinux_enforcing_boot)
 		pr_debug("SELinux:  Starting in enforcing mode\n");
 	else
@@ -7645,6 +7650,7 @@ DEFINE_LSM(selinux) = {
 	.enabled = &selinux_enabled_boot,
 	.blobs = &selinux_blob_sizes,
 	.init = selinux_init,
+	.initcall_device = selinux_initcall,
 };
 
 #if defined(CONFIG_NETFILTER)
@@ -7706,7 +7712,7 @@ static struct pernet_operations selinux_net_ops = {
 	.exit = selinux_nf_unregister,
 };
 
-static int __init selinux_nf_ip_init(void)
+int __init selinux_nf_ip_init(void)
 {
 	int err;
 
@@ -7721,5 +7727,4 @@ static int __init selinux_nf_ip_init(void)
 
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
index e67a8ce4b64c..840f675c1d58 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -35,6 +35,7 @@
 /* selinuxfs pseudo filesystem for exporting the security policy API.
    Based on the proc code and the fs/nfsd/nfsctl.c code. */
 
+#include "initcalls.h"
 #include "flask.h"
 #include "avc.h"
 #include "avc_ss.h"
@@ -2131,7 +2132,7 @@ static struct file_system_type sel_fs_type = {
 
 struct path selinux_null __ro_after_init;
 
-static int __init init_sel_fs(void)
+int __init init_sel_fs(void)
 {
 	struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
 					  sizeof(NULL_FILE_NAME)-1);
@@ -2175,5 +2176,3 @@ static int __init init_sel_fs(void)
 
 	return err;
 }
-
-__initcall(init_sel_fs);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 7becf3808818..9329486ddc5b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3544,6 +3544,13 @@ struct selinux_audit_rule {
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
@@ -3794,25 +3801,6 @@ int selinux_audit_rule_match(struct lsm_prop *prop, u32 field, u32 op, void *vru
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

