Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86637C33CBA
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26AD24712
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="obYEMmmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfLMOcJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 09:32:09 -0500
Received: from UPDC19PA20.eemsg.mail.mil ([214.24.27.195]:55077 "EHLO
        UPDC19PA20.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfLMOcI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 09:32:08 -0500
X-EEMSG-check-017: 38058440|UPDC19PA20_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="38058440"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA20.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Dec 2019 14:32:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576247521; x=1607783521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VNPyhgjLibKf5cV89GQTmRSCTi2hb1SWZ4WsNwY/csU=;
  b=obYEMmmJ2GsQDc+o8InFOk9JL6N/bR+2gHaciAoBQf7IqFv01zTndBA3
   72aukKltmVtV6XOQ7IsPA/NnkEth1abyE/OeQ7Nwe7kHVC1TCj1XvMDmy
   fF/BdrYuleHecT/BxzMaYTHTZgydmX9XFNKmWX7fod1BMB+stOoIfRYSZ
   yuOy7krJ+2ms07LT2bbUuysYW1J8uCwlngRrIB8zBIAkfnF4oXlowGyfI
   gW/cXADqesZqQP+8mw6dMxqmWmRgQpIH1pjEUjZ1Ibu1kw47BDI0+zClf
   4HyzBhirTiJP+s5OJLhKFYe6uCrpwuM7zOdeu1s9P4+/oBnY/iOt7TX9J
   w==;
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="31078869"
IronPort-PHdr: =?us-ascii?q?9a23=3AhCm65RUXQ7l9Oe5tXPw7R5ym4MLV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbBKOt8tkgFKBZ4jH8fUM07OQ7/m7HzVRsN3f7DgrS99lb1?=
 =?us-ascii?q?c9k8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUh?=
 =?us-ascii?q?rwOhBoKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmrowjdrNQajI9mJ6o+yx?=
 =?us-ascii?q?bErWZDdvhLy29vOV+dhQv36N2q/J5k/SRQuvYh+NBFXK7nYak2TqFWASo/PW?=
 =?us-ascii?q?wt68LlqRfMTQ2U5nsBSWoWiQZHAxLE7B7hQJj8tDbxu/dn1ymbOc32Sq00WS?=
 =?us-ascii?q?in4qx2RhLklDsLOjgk+27ZkMxwiL9QrgynqRJx3oXYZJiZOfp6c6/Ye94RWG?=
 =?us-ascii?q?hPUdtLVyFZAo2ycZYBAeQCM+hfoIbzqEADoQe9CAS2GO/i0CNEimPw0KYn0+?=
 =?us-ascii?q?ohCwbG3Ak4EtwTrHTbss31NKcMXuCz0aLG0DDDYOlS2Tf59ofJcg0qrPaXXb?=
 =?us-ascii?q?1tasrc0lUvFgPZgVWQrozpJTWV1v8XvGSB4OpgUvyvhnchpgpsoTav3t8hhp?=
 =?us-ascii?q?TGi48a0FzJ9Th1zJwrKdC3VkJ3e8OoHZ1NvC+ALYR2WNktQ2RwtSY/zb0JpI?=
 =?us-ascii?q?C0cTARyJQi2x7fc/uHc5WU4h77VOaePzN4hHV9dbKjnRmy60mgyvDnVsWu0V?=
 =?us-ascii?q?ZKqCRFkt7Xtn8TyxPf8NSHS/th8Ueh3jaDzQbT5f1fIU8oj6bbLp8hwroomp?=
 =?us-ascii?q?oSt0TMADP2lV3rgKKZeUgo4Oil5/n9brn4qZKQKZV4hhzmPqQrgMO/AOA4Mg?=
 =?us-ascii?q?YUX2ic/OSxzKbj8lDiQLhRkv03krXWsJDdJcgBoK65GBVa3pws6xa4ETeqyM?=
 =?us-ascii?q?4YkmUfLFJZZBKHiJDkO1bLIPD/Fve/hU6jnyt1yP3dJL3uHIjCLnjZn7f9Z7?=
 =?us-ascii?q?py90lcyA8rx9BF+51UEq0BIO70WkLpr9zXEBs5Mw2yw+b6B9RwzZ0eWW2RDa?=
 =?us-ascii?q?+DKq/SskGH5vgpI+aSYI8ZojH9K+Iq5/T2l382hUcdfbW13ZsQcH24Bu5pI1?=
 =?us-ascii?q?idYXf3mtcOC3oKvg4nQOzvj12CViRTaGioU60g4TE7DdHuMYCWXomwhJSZ1T?=
 =?us-ascii?q?q/W5hRYXpLTFuLFCTGbYKBDswQZTqSL8kpqTkNUbysWsd1zh21nBPrwLpgaO?=
 =?us-ascii?q?zP82sXsoy1h4s93PHaiRxnrW88NM+ayWzYCjwlkw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DyAADFn/Nd/wHyM5BlGwEBAQEBAQEFAQEBEQEBAwMBA?=
 =?us-ascii?q?QGBfoF0gW0gEiqNBoZuAQEBAQEBBosgkUYJAQEBAQEBAQEBGxwBAYRAgjU4E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFCwcxgjspgygLAUaBUYJjP4JTJa4QM4VPgzaBS?=
 =?us-ascii?q?IE2hz+Ec3mBB4FHgxuKNwSWIoEnlyaCOoI8kzEMG4JCjDeLRwEtqmwigVgrC?=
 =?us-ascii?q?AIYCCEPgydQERSLDIISF45BIwMwkBsBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Dec 2019 14:31:59 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBDEVeIX225215;
        Fri, 13 Dec 2019 09:31:42 -0500
From:   Stephen Smalley <sds@tycho.nsa.gov>
To:     paul@paul-moore.com
Cc:     selinux@vger.kernel.org, omosnace@redhat.com,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC PATCH] selinux: clean up selinux_enabled/disabled
Date:   Fri, 13 Dec 2019 09:32:18 -0500
Message-Id: <20191213143218.149544-1-sds@tycho.nsa.gov>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Rename selinux_enabled to selinux_enabled_boot to make it clear that
it only reflects whether SELinux was enabled at boot.  Further make it
unconditionally read-only-after-init and stop needlessly clearing it
in selinux_disable() since it is only used to skip other SELinux
initialization code.

Wrap the disabled field in the struct selinux_state with
CONFIG_SECURITY_SELINUX_DISABLE since it is only used for
runtime disable.

Introduce a selinux_is_enabled() static inline that tests both
selinux_enabled_boot and selinux_state.disabled as appropriate
to determine whether SELinux is in an enabled state.  Use this function
in the MAC_STATUS audit log message in place of selinux_enabled(_boot).
It is unclear why this information is included in that audit record
since selinuxfs is never registered at all if !selinux_enabled_boot
and is unregistered in the runtime disable case, so this code should never
be reached if SELinux is disabled.  It is also unclear why it is logged
twice under enabled/old-enabled since setenforce does not change its
value. Regardless, we leave it as is for compatibility.

As a further cleanup, we could make selinux_enabled_boot __initdata if
we were to stop testing it for the MAC_STATUS audit record since that
is the only non-init code that uses it.  The selinux_is_enabled()
static inline function could be reduced to only testing
selinux_state.disabled or always being 1 if
CONFIG_SECURITY_SELINUX_DISABLE=n, with it being implicit that we would
not have reached the test if selinux_enabled_boot was not 1.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c            | 10 ++++------
 security/selinux/ibpkey.c           |  2 +-
 security/selinux/include/security.h | 16 +++++++++++++++-
 security/selinux/netif.c            |  2 +-
 security/selinux/netnode.c          |  2 +-
 security/selinux/netport.c          |  2 +-
 security/selinux/selinuxfs.c        |  4 ++--
 7 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 40ec866e48da..7984e72312da 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -123,13 +123,13 @@ __setup("enforcing=", enforcing_setup);
 #define selinux_enforcing_boot 1
 #endif
 
-int selinux_enabled __lsm_ro_after_init = 1;
+int selinux_enabled_boot __ro_after_init = 1;
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
index 8c0dbbd076c6..49737087ad33 100644
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
@@ -136,6 +138,18 @@ static inline void enforcing_set(struct selinux_state *state, bool value)
 }
 #endif
 
+#ifdef CONFIG_SECURITY_SELINUX_DISABLE
+static inline bool selinux_is_enabled(struct selinux_state *state)
+{
+	return selinux_enabled_boot && !state->disabled;
+}
+#else
+static inline bool selinux_is_enabled(struct selinux_state *state)
+{
+	return selinux_enabled_boot;
+}
+#endif
+
 static inline bool selinux_policycap_netpeer(void)
 {
 	struct selinux_state *state = &selinux_state;
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
index dd7bb1f1dc99..3b8397ed87f3 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -172,7 +172,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
 			new_value, old_value,
 			from_kuid(&init_user_ns, audit_get_loginuid(current)),
 			audit_get_sessionid(current),
-			selinux_enabled, selinux_enabled);
+			selinux_is_enabled(state), selinux_is_enabled(state));
 		enforcing_set(state, new_value);
 		if (new_value)
 			avc_ss_reset(state->avc, 0);
@@ -2105,7 +2105,7 @@ static int __init init_sel_fs(void)
 					  sizeof(NULL_FILE_NAME)-1);
 	int err;
 
-	if (!selinux_enabled)
+	if (!selinux_enabled_boot)
 		return 0;
 
 	err = sysfs_create_mount_point(fs_kobj, "selinux");
-- 
2.23.0

