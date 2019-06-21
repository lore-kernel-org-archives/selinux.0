Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806D2C48BE3
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DED0208CA
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RLi30A2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFUSxd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:53:33 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:42738
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbfFUSxc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143210; bh=JV4k84aA84796aCCyXruqFDFhNDXiK+eAbVb+KTHU0o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RLi30A2bO+kqyrlQqBcQ4OF8cmMGHYWs3+lSh/qxxprnMaEC8DHHt35MLH6/+Qpbs/7ws9Q8/sHcoErXeeWSK8hbkyu46x/G6pQDO39gH87bq/LekFSjuP7aLkHgIethz0LmPHFvp4raI/2qvuqdrOHIvAxwc3dUX3OGdInHVrp3n7JVNTNnQStlPX4stnGTuneScIEnqgs+QYV0qT/KkKlt0HmPuz9w1LTeo5mFDlaFO5s7Reg9BPse9cQkpGlUAEUs1Y9BsNHHOfBlA7MQdbdifsfubYbrZYr644z0wPFQzuVsIQT2gnBn+ci3gSDG7Bjg3xlVOCuB7OOPlZcVbQ==
X-YMail-OSG: m.nXCEIVM1lQc4lYOxCggdmNFDwk.d3SZuv7wMZIeFD_81ljpDLTXlrMDuKF5kX
 cZf8CUSilQX_ebBx.Mmr4cMPcCTFivgf_HfC8A_a.PyhXr0neV1qkMS0VFxtVMGmdOSJRkocJzcd
 WUxX_PVEA44Spd2jUk.TJ.LKdpaIE_eLTJzl7lsEmXTKIvxP4WHLCzincqS.PfXwnxaLBmnPLzth
 JmpGvG8hiuOkye12UNU3zRpR_M58F8IkrZPO8qW7ceaS_.gnn8wI0GG0ZjKFzD0h4kImFAqJEbXl
 whs.ZoSX1OX3kf59FquAYEqHr3VdiwOhX_uozem2.s6hivk7dl51EeiGRBG2YL.zWEhMGJyts6gt
 GL376LOnjCA0SevXmVZZV4qsJpHs8dylf9cFc36E9.jZvOvE7Sik7GdHrKWdIh7YPC96JcuWy2cs
 kCdyT3tBjxYknMLX6ojq9mliDHmL1XyuveUvaInr2L9DGXjnzrzdwtKqNQKJaEWQiZOyfu0lWu1U
 RjwHsYEQNECLd57fc98LWr8pZsbh0CocjG77kIij0uagjrYXRSzqw_rCcqIzQ2GGVr8z_IzJ34.L
 gf0BXDira6UpOvqOyMIQ.FrRlZgTRi.cDeeDK5kn2QMQOYKoxR3LjA.b7aAJWQpE6u7Kmbd_FX.l
 L7G7bN49s1bL.Mr2DeB5YwnT5XOgjOA5_1jK_ZXWP5TTu0bK7rO_UEsg0EzJtxYzPDnr5THRNNHh
 aBnpg3n2Y6kuK.p_ipIlfhbNXSNql3tAllIq76BOieiXVjwDhz37eObTdDB8haSHEMzDBTqVcfJJ
 mXvuelfxoGaEi69jj6x9puXibAlqqbK5uKpU4OmepML5ahyvOIr1T6LsC5Vwk5RdfxUFSef5d2Mx
 FzmmS1Pr5hEmq0GaW1Tksj12VOsWBmclQaPdEdM8vGWm74Me7LznkZj3SljAc0YHF0KX5Tg8biMs
 LldKIJVNzU4n8aPymBwQHNjy3xlnPwVXLvQd.CT5H2CUwN1fLrD8BRbYHikhddlspo6wknjAdYHz
 xvh8_sCBQrQRLFSUsWA5TIcczLHWsBJUwcVVQOtsLINnYIX_DjNX9fq9l_yRRV_wJQ3Uffd1W2Xh
 ze6DB1jz8HT.Xj1JV3nj7cDwm4jAyEGmS_z3Itb72DeKBKknseWHnW25Y.rJFHecjIIju_TqH97h
 JmNQuRu8tFgIRqFwi9.4K2OMeL6VsN2QFzu3SVulEAckLozrRQ7kfEOM24nzg5_MWJ3X3bc6iIwI
 pOqLlI_je9P2bDdZZgHTlozYCrUBY6KrP03O8CLQsiEnJvCA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2019 18:53:30 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp431.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0eb7bde0fe71be6c1c6028ab1630b25e;
          Fri, 21 Jun 2019 18:53:26 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 22/24] LSM: Return the lsmblob slot on initialization
Date:   Fri, 21 Jun 2019 11:52:31 -0700
Message-Id: <20190621185233.6766-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Return the slot allocated to the calling LSM in the lsmblob
structure. This can be used to set lsmblobs explicitly for
netlabel interfaces.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  | 4 ++--
 security/apparmor/lsm.c    | 8 ++++++--
 security/security.c        | 9 +++++++--
 security/selinux/hooks.c   | 5 ++++-
 security/smack/smack_lsm.c | 5 ++++-
 5 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 4d1ddf1a2aa6..ce341bcbce5d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2068,8 +2068,8 @@ struct lsm_blob_sizes {
 extern struct security_hook_heads security_hook_heads;
 extern char *lsm_names;
 
-extern void security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm);
+extern int security_add_hooks(struct security_hook_list *hooks, int count,
+			      char *lsm);
 
 #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
 #define LSM_FLAG_EXCLUSIVE	BIT(1)
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 2716e7731279..dcbbefbd95ff 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -47,6 +47,9 @@
 /* Flag indicating whether initialization completed */
 int apparmor_initialized;
 
+/* Slot for the AppArmor secid in the lsmblob structure */
+int apparmor_lsmblob_slot;
+
 DEFINE_PER_CPU(struct aa_buffers, aa_buffers);
 
 
@@ -1678,8 +1681,9 @@ static int __init apparmor_init(void)
 		aa_free_root_ns();
 		goto buffers_out;
 	}
-	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
-				"apparmor");
+	apparmor_lsmblob_slot = security_add_hooks(apparmor_hooks,
+						   ARRAY_SIZE(apparmor_hooks),
+						   "apparmor");
 
 	/* Report that AppArmor successfully initialized */
 	apparmor_initialized = 1;
diff --git a/security/security.c b/security/security.c
index b2ffcd1f3057..c93a368b697b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -437,9 +437,12 @@ static int lsm_slot __initdata;
  * Each LSM has to register its hooks with the infrastructure.
  * If the LSM is using hooks that export secids allocate a slot
  * for it in the lsmblob.
+ *
+ * Returns the slot number in the lsmblob structure if one is
+ * allocated or LSMBLOB_INVALID if one was not allocated.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+int __init security_add_hooks(struct security_hook_list *hooks, int count,
+			      char *lsm)
 {
 	int slot = LSMBLOB_INVALID;
 	int i;
@@ -479,6 +482,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 	if (lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
+
+	return slot;
 }
 
 int call_lsm_notifier(enum lsm_event event, void *data)
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ee840fecfebb..1e09acbf9630 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -103,6 +103,7 @@
 #include "avc_ss.h"
 
 struct selinux_state selinux_state;
+int selinux_lsmblob_slot;
 
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
@@ -6877,7 +6878,9 @@ static __init int selinux_init(void)
 
 	hashtab_cache_init();
 
-	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks), "selinux");
+	selinux_lsmblob_slot = security_add_hooks(selinux_hooks,
+						  ARRAY_SIZE(selinux_hooks),
+						  "selinux");
 
 	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3834b751d1e9..273f311fb153 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -60,6 +60,7 @@ static LIST_HEAD(smk_ipv6_port_list);
 #endif
 static struct kmem_cache *smack_inode_cache;
 int smack_enabled;
+int smack_lsmblob_slot;
 
 #define A(s) {"smack"#s, sizeof("smack"#s) - 1, Opt_##s}
 static struct {
@@ -4749,7 +4750,9 @@ static __init int smack_init(void)
 	/*
 	 * Register with LSM
 	 */
-	security_add_hooks(smack_hooks, ARRAY_SIZE(smack_hooks), "smack");
+	smack_lsmblob_slot = security_add_hooks(smack_hooks,
+						ARRAY_SIZE(smack_hooks),
+						"smack");
 	smack_enabled = 1;
 
 	pr_info("Smack:  Initializing.\n");
-- 
2.20.1

