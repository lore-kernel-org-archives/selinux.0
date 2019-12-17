Return-Path: <SRS0=4tRG=2H=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B05C43603
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 14:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2778F20663
	for <selinux@archiver.kernel.org>; Tue, 17 Dec 2019 14:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="J8GfZpET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfLQOPD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:15:03 -0500
Received: from UPDC19PA19.eemsg.mail.mil ([214.24.27.194]:32245 "EHLO
        UPDC19PA19.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbfLQOPD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Dec 2019 09:15:03 -0500
X-EEMSG-check-017: 38959506|UPDC19PA19_ESA_OUT01.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,325,1571702400"; 
   d="scan'208";a="38959506"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA19.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 17 Dec 2019 14:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576592100; x=1608128100;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zalttHRqR+q1I3Hm9CsR4v9PxtiZJGhDao2YVRuRlE0=;
  b=J8GfZpETpF7zGOQ8vDLibWjrNc3ggZNy26FCSQ49G9wVTSKmqlOd2C89
   sb3l1vS0YbX4A4v0INh41lDYQmmdBG+OLoj0BuUbAZvvB9oS8Ia0+z3pm
   BzoRz2xExAa5yq619FL8s6ZkZeBXFBqCO6LrgS+9BltlhPowprJ9J2QWi
   R2fhxYmwZD/cQTd+CS39t/i+RhQouX7cFnD4nZnCfNCPhumiDI/fgq6A0
   yFrAySy/hfJSCoa6tuv8p2OKQr+W7for4tomJLocVmsNqW5rPNCtqnyv5
   OzTyNhcef/h/I8a+9J59gnagRjTiC7vbxPnbvacRxoNtWHZEeoiMqKIQ4
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,325,1571702400"; 
   d="scan'208";a="36839132"
IronPort-PHdr: =?us-ascii?q?9a23=3A7FYyfRcZvgMF1IxDTfNjp0w2lGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcW7Zx7h7PlgxGXEQZ/co6odzbaP6Oa6ATNLvMbJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/PusUKg4ZuJaY8xx?=
 =?us-ascii?q?jUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU2/nvXishth6xFphyvqQF0z4rNbIyVMPdye6XQds4YS2?=
 =?us-ascii?q?VcRMZcTyxPDJ2hYYUBDOQPOulXoYbmqlcSrhazHxWgCfnzxjNUgHL9wK000/?=
 =?us-ascii?q?4mEQHDxAEuAs4Ov2rMrNX1KqgSV/2+wrTNzTrZa/NW3Sny6YjVeR0muvGDQK?=
 =?us-ascii?q?lwfNHNyUgvCwzFjlKQpZbjPzOOzOsBqWeb7+1+Ve+2jWMstg9/oj+qxsg2i4?=
 =?us-ascii?q?nJgJoYxUzD9Spk3ok5P8a4R1Bnbt65CptQtj2aNotwT8g/QG9ooD43xqAJtJ?=
 =?us-ascii?q?O0ZiQHyIkrywTBZ/GIbYSE+A/vWeCMKjlinn1lYqiwhxOq/Eilze3zS9e73U?=
 =?us-ascii?q?5RripAjtnMrncN1wHP6sSfSvty4EOh2TGX2gDP8O5EO0E0lbfAK5I7w74wkJ?=
 =?us-ascii?q?QTsUPYHiDohEr6lrOWd0U49eio7OTreLPmqYOHN4BokA3+N6UumsinDeQ5NA?=
 =?us-ascii?q?gBQXSb9Pyh2LDs8kD1WrVHguAsnqXHv53WO94XqrOhDw9QyIkj6hK/Dzm80N?=
 =?us-ascii?q?QfmHkKNElFdw+cj4XyJ1HPIOz3Dfe4g1i2ljdr3OrJMqfuApXKMHjPiK3hcq?=
 =?us-ascii?q?pl605A1AozyshS55VRCrEGO/LzXFX+u8DGARIiKQy73fvoCNVn2YMCQ26AHq?=
 =?us-ascii?q?iZMKbKu1+S+u0vO/WMZJMSuDvlMPgq+frujX4/mV8AcqikxoUXaH+mEfR8OU?=
 =?us-ascii?q?mZYmTjgs0HEWgUugoyVuvqiEeNUTRLfXa9Q7o85i0nCIKhFYrDXpqigKGF3C?=
 =?us-ascii?q?qgBp1ZfH1GClSVHXftcIWEXO0MZzyILsB9lTwEUOvpd4h0zRizsCfiwqdja+?=
 =?us-ascii?q?/T/TcV85nk0Ytb/erWwCou+CR0AsLV6GSES2V5jytcXDMt9Lxuqkx6jFGY2O?=
 =?us-ascii?q?53hOIORo8b3O9ATgpvbc2U9Od9Ed2nH1+Qcw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DwAABM4fhd/wHyM5BlHAEBAQEBBwEBEQEEBAEBgW0EA?=
 =?us-ascii?q?QELAQGBcoFtIBIqjQeGcwQGiyGRRQkBAQEBAQEBAQEbHAEBhECCPjcGDgIQA?=
 =?us-ascii?q?QEBBAEBAQEBBQMBAWyFCwcxQgEQAYFnKYMoCwFGgVGCYz+CUyWvJzOFT4NFg?=
 =?us-ascii?q?UiBNgGHPoRzeYEHgUeDG4o3BJYrgSeXM4I+gkKTQgwbgkOYBi2PZpsXI4FYK?=
 =?us-ascii?q?wgCGAghD4MnUBEUiwyCEheOQSMDMIJSjy4BAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 17 Dec 2019 14:14:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBHEEZ8w038794;
        Tue, 17 Dec 2019 09:14:37 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] selinux: clean up selinux_enabled/disabled/enforcing_boot
Date:   Tue, 17 Dec 2019 09:15:10 -0500
Message-Id: <20191217141510.10941-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Rename selinux_enabled to selinux_enabled_boot to make it clear that
it only reflects whether SELinux was enabled at boot.  Replace the
references to it in the MAC_STATUS audit log in sel_write_enforce()
with hardcoded "1" values because this code is only reachable if SELinux
is enabled and does not change its value, and update the corresponding
MAC_STATUS audit log in sel_write_disable().  Stop clearing
selinux_enabled in selinux_disable() since it is not used outside of
initialization code that runs before selinux_disable() can be reached.
Mark both selinux_enabled_boot and selinux_enforcing_boot as __initdata
since they are only used in initialization code.

Wrap the disabled field in the struct selinux_state with
CONFIG_SECURITY_SELINUX_DISABLE since it is only used for
runtime disable.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 switches to hardcoded values for enabled/old-enabled in the MAC_STATUS
audit records, drops selinux_is_enabled() since it is not needed, and
makes both selinux_enabled_boot and selinux_enforcing_boot __initdata
since they are unused outside of initialization code.
 security/selinux/hooks.c            | 12 +++++-------
 security/selinux/ibpkey.c           |  2 +-
 security/selinux/include/security.h |  4 +++-
 security/selinux/netif.c            |  2 +-
 security/selinux/netnode.c          |  2 +-
 security/selinux/netport.c          |  2 +-
 security/selinux/selinuxfs.c        | 11 +++++------
 7 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 40ec866e48da..659c4a81e897 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -109,7 +109,7 @@ struct selinux_state selinux_state;
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
-static int selinux_enforcing_boot;
+static int selinux_enforcing_boot __initdata;
 
 static int __init enforcing_setup(char *str)
 {
@@ -123,13 +123,13 @@ __setup("enforcing=", enforcing_setup);
 #define selinux_enforcing_boot 1
 #endif
 
-int selinux_enabled __lsm_ro_after_init = 1;
+int selinux_enabled_boot __initdata = 1;
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
 static int __init selinux_enabled_setup(char *str)
 {
 	unsigned long enabled;
 	if (!kstrtoul(str, 0, &enabled))
-		selinux_enabled = enabled ? 1 : 0;
+		selinux_enabled_boot = enabled ? 1 : 0;
 	return 1;
 }
 __setup("selinux=", selinux_enabled_setup);
@@ -7202,7 +7202,7 @@ void selinux_complete_init(void)
 DEFINE_LSM(selinux) = {
 	.name = "selinux",
 	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
-	.enabled = &selinux_enabled,
+	.enabled = &selinux_enabled_boot,
 	.blobs = &selinux_blob_sizes,
 	.init = selinux_init,
 };
@@ -7271,7 +7271,7 @@ static int __init selinux_nf_ip_init(void)
 {
 	int err;
 
-	if (!selinux_enabled)
+	if (!selinux_enabled_boot)
 		return 0;
 
 	pr_debug("SELinux:  Registering netfilter hooks\n");
@@ -7318,8 +7318,6 @@ int selinux_disable(struct selinux_state *state)
 
 	pr_info("SELinux:  Disabled at runtime.\n");
 
-	selinux_enabled = 0;
-
 	security_delete_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
 
 	/* Try to destroy the avc node cache */
diff --git a/security/selinux/ibpkey.c b/security/selinux/ibpkey.c
index de92365e4324..f68a7617cfb9 100644
--- a/security/selinux/ibpkey.c
+++ b/security/selinux/ibpkey.c
@@ -222,7 +222,7 @@ static __init int sel_ib_pkey_init(void)
 {
 	int iter;
 
-	if (!selinux_enabled)
+	if (!selinux_enabled_boot)
 		return 0;
 
 	for (iter = 0; iter < SEL_PKEY_HASH_SIZE; iter++) {
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 8c0dbbd076c6..af623f03922c 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -69,7 +69,7 @@
 
 struct netlbl_lsm_secattr;
 
-extern int selinux_enabled;
+extern int selinux_enabled_boot;
 
 /* Policy capabilities */
 enum {
@@ -99,7 +99,9 @@ struct selinux_avc;
 struct selinux_ss;
 
 struct selinux_state {
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
 	bool disabled;
+#endif
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 	bool enforcing;
 #endif
diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index e40fecd73752..15b8c1bcd7d0 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -266,7 +266,7 @@ static __init int sel_netif_init(void)
 {
 	int i;
 
-	if (!selinux_enabled)
+	if (!selinux_enabled_boot)
 		return 0;
 
 	for (i = 0; i < SEL_NETIF_HASH_SIZE; i++)
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index 9ab84efa46c7..dff587d1e164 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -291,7 +291,7 @@ static __init int sel_netnode_init(void)
 {
 	int iter;
 
-	if (!selinux_enabled)
+	if (!selinux_enabled_boot)
 		return 0;
 
 	for (iter = 0; iter < SEL_NETNODE_HASH_SIZE; iter++) {
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 3f8b2c0458c8..de727f7489b7 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -225,7 +225,7 @@ static __init int sel_netport_init(void)
 {
 	int iter;
 
-	if (!selinux_enabled)
+	if (!selinux_enabled_boot)
 		return 0;
 
 	for (iter = 0; iter < SEL_NETPORT_HASH_SIZE; iter++) {
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index dd7bb1f1dc99..278417e67b4c 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -168,11 +168,10 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 			goto out;
 		audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_STATUS,
 			"enforcing=%d old_enforcing=%d auid=%u ses=%u"
-			" enabled=%d old-enabled=%d lsm=selinux res=1",
+			" enabled=1 old-enabled=1 lsm=selinux res=1",
 			new_value, old_value,
 			from_kuid(&init_user_ns, audit_get_loginuid(current)),
-			audit_get_sessionid(current),
-			selinux_enabled, selinux_enabled);
+			audit_get_sessionid(current));
 		enforcing_set(state, new_value);
 		if (new_value)
 			avc_ss_reset(state->avc, 0);
@@ -304,10 +303,10 @@ static ssize_t sel_write_disable(struct file *file, const char __user *buf,
 			goto out;
 		audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_STATUS,
 			"enforcing=%d old_enforcing=%d auid=%u ses=%u"
-			" enabled=%d old-enabled=%d lsm=selinux res=1",
+			" enabled=0 old-enabled=1 lsm=selinux res=1",
 			enforcing, enforcing,
 			from_kuid(&init_user_ns, audit_get_loginuid(current)),
-			audit_get_sessionid(current), 0, 1);
+			audit_get_sessionid(current));
 	}
 
 	length = count;
@@ -2105,7 +2104,7 @@ static int __init init_sel_fs(void)
 					  sizeof(NULL_FILE_NAME)-1);
 	int err;
 
-	if (!selinux_enabled)
+	if (!selinux_enabled_boot)
 		return 0;
 
 	err = sysfs_create_mount_point(fs_kobj, "selinux");
-- 
2.23.0

