Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA10FC432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 17:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822C020665
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 17:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="TUx7HZ3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfK0REw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:04:52 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:10780 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0REw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 12:04:52 -0500
X-EEMSG-check-017: 55328871|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,250,1571702400"; 
   d="scan'208";a="55328871"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Nov 2019 17:04:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1574874289; x=1606410289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xYdJT5Q8Im3N8WSylXaPmuhl6GqEkpGAwPd0N9KPxko=;
  b=TUx7HZ3U5TVa07DCKvAxlFy34p83WhULHBUaoWn5Dc+zYqG72d0G44Bo
   MIEnkTSAlzJCMVZUCpmVDjF2PbZkf+1HC/1fBSJmwZygJl9ImbG3U+r4V
   ytzrTL70uoJVrNf69Ck6zQ+oUEYHcd5mPJet85My6Fy47ZCaetQQrdT0O
   f4GUS8i4RwhEo47lYzvRBCHv69vs3hgtVXK4EQAOO7CCm5GtGjGkYRl9a
   yF3G2wNUecdAUjzj/Z2dQ3Pn5+SQHl3zlUP5XPQG0q1qGIRyYpZTc5ZOY
   4UM454oIEIN9CjefkI+VR+r3l58mFb+/fK1yYOpkgZyPL1Wa2xnLZSNS3
   A==;
X-IronPort-AV: E=Sophos;i="5.69,250,1571702400"; 
   d="scan'208";a="36092306"
IronPort-PHdr: =?us-ascii?q?9a23=3AapskcxcspfQBru6ThmObAw8tlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc26bBGN2/xhgRfzUJnB7Loc0qyK6vumADJdqsfd+Fk5M7V0Hy?=
 =?us-ascii?q?cfjssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFR?=
 =?us-ascii?q?rwLxd6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAi4oAnLq8UbgItvJqk1xx?=
 =?us-ascii?q?bGv3BFZ/lYyWR0KFyJgh3y/N2w/Jlt8yRRv/Iu6ctNWrjkcqo7ULJVEi0oP3?=
 =?us-ascii?q?g668P3uxbDSxCP5mYHXWUNjhVIGQnF4wrkUZr3ryD3q/By2CiePc3xULA0RT?=
 =?us-ascii?q?Gv5LplRRP0lCsKMSMy/2/Nisx0kalVvhSvqRJiyILQeY2YNP5zcqbbcNgHR2?=
 =?us-ascii?q?ROQ9xRWjRBDI2icoUBAekPM+FXoIfyvFYCsRizCBOwCO711jNEmnn71rA63e?=
 =?us-ascii?q?Q7FgHG2RQtEc8SsHvKtNX1NLkdUeaox6fVyDXMdfdW2TPj54nIbxsspuqMUq?=
 =?us-ascii?q?9rccfK1UkuFx/KjlWXqYD/OTOVzf4Cv3KU7+pnS+KikmgqoBxyrDi33sogl4?=
 =?us-ascii?q?bEi40Pxl3E6Cl12pg5KNKmREJhfNKpFoZbuTuAOItsWMwiRnlluCM9yrIbp5?=
 =?us-ascii?q?G2ZDMKyJE7xx7HbPyHbpSI7grjVOmPJTd4g2poeK6liBao8Eig1/b8WtO10F?=
 =?us-ascii?q?ZMoCpFlcLMuW4R2BDJ9siGSudy/kem2TqV0QDc9vpELlwumareKp4hxqY8lp?=
 =?us-ascii?q?sVsUvdAi/7gFj6gaCZe0k++uWk9v7rbqvpq5OCLYN4lxnyMqE0lcy+BeQ4PB?=
 =?us-ascii?q?IOX2+e+emkz73s4Fb5Ta5Wjvw2jqbZsJfaKd4dpq6iGQBZyIkj6xGhDzu+yt?=
 =?us-ascii?q?QXgWEHLE5ZeBKAl4XpPkvBIOzkDfe/nVutnjhryOrcPr37HJrNMmTDnazufb?=
 =?us-ascii?q?Z67E5cxw4zws5F651IDbEBJer5WlXtu9zAEh85Lwu0zv7lCNV40YMeQ3iPAq?=
 =?us-ascii?q?6CMK7Jt1+H/OcvLPeNZIMPvzb9Mfcl7eb0jXAlgV8dYbWp3ZwPZXCgBPtmPk?=
 =?us-ascii?q?GZbGH0gtgbDGcKuhMyTOntiF2FSz5ceWy+UL475jE+EIimF5vMRpixgLyd2y?=
 =?us-ascii?q?e2BplWZmFAClCRHnbkbp+LW+oRZyKTPs9siSYEWqa8RI8hzx6uqBX2xKZgLu?=
 =?us-ascii?q?rR4icYr47s1MBp5+3PkhE/7Th0D8Wb02GQQGB4h3gISCEq06Biu0x9y0uD0K?=
 =?us-ascii?q?hhj/xdEtxc+u5JUgMkOpPH0ex6BM79WhjbcteKVlmmWNOmDi81Tt4rxN8OeU?=
 =?us-ascii?q?l9Ec24jh/fxyqqH6MVl7uTCZwv7K3c23nxJ8Bgy3fJz6QhkVYmTdVVNWG8ha?=
 =?us-ascii?q?5w6RLTB4jXnEWdjaqqcr4c3CGevFuEmHGDuEBeTR5YT6rIRzYca1HQoNC/4V?=
 =?us-ascii?q?nNHJG0DrFyCRdM0c6PLONxb9TtiVhXDKP4NM/2f3O6m2D2Aw2BgLyLcty5KC?=
 =?us-ascii?q?0mwCzBBR1cwEgo9nGcOF17W3as?=
X-IPAS-Result: =?us-ascii?q?A2CqAgDiq95d/wHyM5BlHAEBAQEBBwEBEQEEBAEBgX6Bb?=
 =?us-ascii?q?wWBbSASKo0ukXeRRAkBAQEBAQEBAQEbHAEBhECCJjgTAhABAQEEAQEBAQEFA?=
 =?us-ascii?q?wEBbIVDgjspgxwLAUaBUYJjP4JTJbQyM4kagUiBNoc9gzuBOHmBB4ERNoMbh?=
 =?us-ascii?q?DWGAgSNFBWKAHSWHII3gjmTEQwbgkCMKYs2qm0igVgrCAIYCCEPgydQERSGV?=
 =?us-ascii?q?BeOQSMDMIt9ASQHghQBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 27 Nov 2019 17:04:48 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xARH4gO5064133;
        Wed, 27 Nov 2019 12:04:42 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, matthewgarrett@google.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH v2] security,lockdown,selinux: implement SELinux lockdown
Date:   Wed, 27 Nov 2019 12:04:36 -0500
Message-Id: <20191127170436.4237-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Implement a SELinux hook for lockdown.  If the lockdown module is also
enabled, then a denial by the lockdown module will take precedence over
SELinux, so SELinux can only further restrict lockdown decisions.
The SELinux hook only distinguishes at the granularity of integrity
versus confidentiality similar to the lockdown module, but includes the
full lockdown reason as part of the audit record as a hint in diagnosing
what triggered the denial.  To support this auditing, move the
lockdown_reasons[] string array from being private to the lockdown
module to the security framework so that it can be used by the lsm audit
code and so that it is always available even when the lockdown module
is disabled.

Note that the SELinux implementation allows the integrity and
confidentiality reasons to be controlled independently from one another.
Thus, in an SELinux policy, one could allow operations that specify
an integrity reason while blocking operations that specify a
confidentiality reason. The SELinux hook implementation is
stricter than the lockdown module in validating the provided reason value.

Sample AVC audit output from denials:
avc:  denied  { integrity } for pid=3402 comm="fwupd"
 lockdown_reason="/dev/mem,kmem,port" scontext=system_u:system_r:fwupd_t:s0
 tcontext=system_u:system_r:fwupd_t:s0 tclass=lockdown permissive=0

avc:  denied  { confidentiality } for pid=4628 comm="cp"
 lockdown_reason="/proc/kcore access"
 scontext=unconfined_u:unconfined_r:test_lockdown_integrity_t:s0-s0:c0.c1023
 tcontext=unconfined_u:unconfined_r:test_lockdown_integrity_t:s0-s0:c0.c1023
 tclass=lockdown permissive=0

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 include/linux/lsm_audit.h           |  2 ++
 include/linux/security.h            |  2 ++
 security/lockdown/lockdown.c        | 24 -----------------------
 security/lsm_audit.c                |  5 +++++
 security/security.c                 | 30 +++++++++++++++++++++++++++++
 security/selinux/hooks.c            | 30 +++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 ++
 7 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 915330abf6e5..99d629fd9944 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -74,6 +74,7 @@ struct common_audit_data {
 #define LSM_AUDIT_DATA_FILE	12
 #define LSM_AUDIT_DATA_IBPKEY	13
 #define LSM_AUDIT_DATA_IBENDPORT 14
+#define LSM_AUDIT_DATA_LOCKDOWN 15
 	union 	{
 		struct path path;
 		struct dentry *dentry;
@@ -93,6 +94,7 @@ struct common_audit_data {
 		struct file *file;
 		struct lsm_ibpkey_audit *ibpkey;
 		struct lsm_ibendport_audit *ibendport;
+		int reason;
 	} u;
 	/* this union contains LSM specific data */
 	union {
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d59d612d27..df7a4d293fe8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -125,6 +125,8 @@ enum lockdown_reason {
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
+extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 8a10b43daf74..5a952617a0eb 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -16,30 +16,6 @@
 
 static enum lockdown_reason kernel_locked_down;
 
-static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
-	[LOCKDOWN_NONE] = "none",
-	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
-	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
-	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
-	[LOCKDOWN_HIBERNATION] = "hibernation",
-	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
-	[LOCKDOWN_IOPORT] = "raw io port access",
-	[LOCKDOWN_MSR] = "raw MSR access",
-	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
-	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
-	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
-	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
-	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
-	[LOCKDOWN_DEBUGFS] = "debugfs access",
-	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
-	[LOCKDOWN_KCORE] = "/proc/kcore access",
-	[LOCKDOWN_KPROBES] = "use of kprobes",
-	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
-	[LOCKDOWN_PERF] = "unsafe use of perf",
-	[LOCKDOWN_TRACEFS] = "use of tracefs",
-	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
-};
-
 static const enum lockdown_reason lockdown_levels[] = {LOCKDOWN_NONE,
 						 LOCKDOWN_INTEGRITY_MAX,
 						 LOCKDOWN_CONFIDENTIALITY_MAX};
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index e40874373f2b..2d2bf49016f4 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -27,6 +27,7 @@
 #include <linux/dccp.h>
 #include <linux/sctp.h>
 #include <linux/lsm_audit.h>
+#include <linux/security.h>
 
 /**
  * ipv4_skb_to_auditdata : fill auditdata from skb
@@ -425,6 +426,10 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 				 a->u.ibendport->dev_name,
 				 a->u.ibendport->port);
 		break;
+	case LSM_AUDIT_DATA_LOCKDOWN:
+		audit_log_format(ab, " lockdown_reason=");
+		audit_log_string(ab, lockdown_reasons[a->u.reason]);
+		break;
 	} /* switch (a->type) */
 }
 
diff --git a/security/security.c b/security/security.c
index 1bc000f834e2..f439c1102b1a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -35,6 +35,36 @@
 #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
 #define EARLY_LSM_COUNT (__end_early_lsm_info - __start_early_lsm_info)
 
+/*
+ * These are descriptions of the reasons that can be passed to the
+ * security_locked_down() LSM hook. Placing this array here allows
+ * all security modules to use the same descriptions for auditing
+ * purposes.
+ */
+const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
+	[LOCKDOWN_NONE] = "none",
+	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
+	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
+	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
+	[LOCKDOWN_HIBERNATION] = "hibernation",
+	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
+	[LOCKDOWN_IOPORT] = "raw io port access",
+	[LOCKDOWN_MSR] = "raw MSR access",
+	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
+	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
+	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
+	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
+	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
+	[LOCKDOWN_DEBUGFS] = "debugfs access",
+	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
+	[LOCKDOWN_KCORE] = "/proc/kcore access",
+	[LOCKDOWN_KPROBES] = "use of kprobes",
+	[LOCKDOWN_BPF_READ] = "use of bpf to read kernel RAM",
+	[LOCKDOWN_PERF] = "unsafe use of perf",
+	[LOCKDOWN_TRACEFS] = "use of tracefs",
+	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
+};
+
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static BLOCKING_NOTIFIER_HEAD(blocking_lsm_notifier_chain);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 36e531b91df2..ca8a9d1b3ffd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6799,6 +6799,34 @@ static void selinux_bpf_prog_free(struct bpf_prog_aux *aux)
 }
 #endif
 
+static int selinux_lockdown(enum lockdown_reason what)
+{
+	struct common_audit_data ad;
+	u32 sid = current_sid();
+	int invalid_reason = (what <= LOCKDOWN_NONE) ||
+			     (what == LOCKDOWN_INTEGRITY_MAX) ||
+			     (what >= LOCKDOWN_CONFIDENTIALITY_MAX);
+
+	if (WARN(invalid_reason, "Invalid lockdown reason")) {
+		audit_log(audit_context(),
+			  GFP_ATOMIC, AUDIT_SELINUX_ERR,
+			  "lockdown_reason=invalid");
+		return -EINVAL;
+	}
+
+	ad.type = LSM_AUDIT_DATA_LOCKDOWN;
+	ad.u.reason = what;
+
+	if (what <= LOCKDOWN_INTEGRITY_MAX)
+		return avc_has_perm(&selinux_state,
+				    sid, sid, SECCLASS_LOCKDOWN,
+				    LOCKDOWN__INTEGRITY, &ad);
+	else
+		return avc_has_perm(&selinux_state,
+				    sid, sid, SECCLASS_LOCKDOWN,
+				    LOCKDOWN__CONFIDENTIALITY, &ad);
+}
+
 struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct task_security_struct),
 	.lbs_file = sizeof(struct file_security_struct),
@@ -7042,6 +7070,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bpf_map_free_security, selinux_bpf_map_free),
 	LSM_HOOK_INIT(bpf_prog_free_security, selinux_bpf_prog_free),
 #endif
+
+	LSM_HOOK_INIT(locked_down, selinux_lockdown),
 };
 
 static __init int selinux_init(void)
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 32e9b03be3dd..594c32febcd8 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -244,6 +244,8 @@ struct security_class_mapping secclass_map[] = {
 	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
 	{ "xdp_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "lockdown",
+	  { "integrity", "confidentiality", NULL } },
 	{ NULL }
   };
 
-- 
2.23.0

