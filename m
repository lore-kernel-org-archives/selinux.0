Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EACDC31E5D
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F7920873
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="T8nkd+0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfFRXHR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:07:17 -0400
Received: from sonic308-14.consmr.mail.gq1.yahoo.com ([98.137.68.38]:39409
        "EHLO sonic308-14.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730966AbfFRXHR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899235; bh=eyqgBvvJA23ZLf4/9BFoPGUk4QhaaiFLYVmXJiVNbWw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=T8nkd+0k+ZUp7Do0vQTp2FdnSFv4BBZ2OFvQxBx2DjDBcuWczwrVkrcrGJpoRfEtz88cOJQHaCsJF7fEe2vTNp2uhsaPgdgrp/2wIR8RxkJo9/LSB7hfVfnZ3mc5DhcVsHdre7aoMfZkUZcGdADM+0xknKfttadTI0b3lPtzy0kZT6C2BC3U71ujbHMSFJ27U8etTzFl94ICqZjxfl0zVYvcCpWf/SyqO1bRBJHSD3TixfZhcXxk3Ua8r+6+hEjdpIIyYOfSsAofWkYkcXFNgAZ72uCNarnJ6SfxxSQLEDCDVEyniQoy1FbaKGel6f10Q0mV5zMHhT7undFFtnx4xA==
X-YMail-OSG: 8C8MMG0VM1ntFj.Cvzkv_B.NBZ3rWFvkZIDyD1EfF3g7jAeF2iuTRjNVLMAeyD3
 LS_9km2GZd2t8nnBhbS3D.WZWPcAUYiPH6Y617DN99k8vvonL33Qb.HANveWiqKK_Tp6t2YzA4zz
 NSD8RpTwenKJRqhrXpaDs3ymCRdMzxZjK5uJq4QRRtMSQAmHUz0I1zet3C3_jyL83osJzFjgzcbl
 KHkgOX5y0HRMcx56g6VYIU1sZ1Bifoi9kH4ZthLZ6YRmGprYTbst83XJ.dBuu.vf6LHMZrM1aQDM
 bLjIxLdpt79N22puN23VSY8M2X5P20VfoejRh34Kch7vqJZDTMhRBK_o26mIy09.XkfCd.43hfEY
 VddKIX4XcMerzOOIJLduCNoziLFIlcdRP4PqvT1ZgiBzkopt5Qx0eqeZofP0ht6zsrNe2H7MGZVl
 I3o7CGPS1tEHUVb.alvrVAjDnNVYzZeji95LpDXL5QRosBBfSiojOBVY1h1lW3s6F7hcdRwmauTc
 2MR8ylcusqslFX5wza1prReoiP_qQzoWxalZu.e685Hf7Qmn4EuG7gPivbnlN9of.yPxMqvqKg3W
 lfivCOHmk.brNDiTWQ9kyYeQWSnMhkgD1jhOrqdARt4PHSuYmKEb0hUuvrbK4Llk9T334QGzw2EB
 BBsw0sS5k8jkvd5HA.mQaRjePbnJb0lBL1LO1wt5CiH9xcAGOW3ASMVTizWoM60S6fgReznekn2t
 COD4RtJ5l3iXViztEwT3ifXJcTiNWDzgrrQ6OE4_HDD_vUTvZ1K5eemLPw.6PP2YzwUtU.V4uSB7
 9ixU1QhDQCLkkGv1tskalIRqoBiYTaaloqFKufMG.qXRgTXm5IAovfOdAEwDTCLddDqkD790ytag
 RG6tL9wefLSnjE11nq0UBxaDltAh0SoPw6Rp4MG9wgGG5Aeg5oZFuE3mxaJseu20lhw1tAQeb65x
 GQI27eR_EHiIIwwawIJNpj1fJdlXJC4CdqOQStGtfdG2GbT9epwnX0mmPT7jvmju0cuDBkgNjuwM
 I3OCpZIRGwN0424l2SWnl6qvd84XLW1yAE5_SqrJ6TYVKACGZlPOJAXBTKx7j6_yVYUY9NfrUl3C
 HELOiKDaaUWBTVucoio47On8QjMVOJItaDKGXamFKbRHdddWOrtWqvqEvzCNpX73.1a2BUru4DED
 lB1EWubMvHDzaFIIl36396We_F8cjmh8g13sIvM_Fc7tHsomJAIEdHNLVvewzBDqp8lbUurOZvIO
 xcCfd2LsI6qiGFUN80K6_f9ekUJInnTYwnDRmNA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Tue, 18 Jun 2019 23:07:15 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp407.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 63d042c01c7ef77757fc0dff1b9276c8;
          Tue, 18 Jun 2019 23:07:14 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 22/25] LSM: Return the lsmblob slot on initialization
Date:   Tue, 18 Jun 2019 16:05:48 -0700
Message-Id: <20190618230551.7475-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
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
index 7b8427560646..5a23ccec7c7b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -437,9 +437,12 @@ static int lsm_slot __initdata;
  * Each LSM has to register its hooks with the infrastructure.
  * If the LSM is using hooks that export secids allocate a slot
  * for it in the lsmblob.
+ *
+ * Returns the slot number in the lsmblob structure if one is
+ * allocated or LSMDATA_INVALID if one was not allocated.
  */
-void __init security_add_hooks(struct security_hook_list *hooks, int count,
-				char *lsm)
+int __init security_add_hooks(struct security_hook_list *hooks, int count,
+			      char *lsm)
 {
 	int slot = LSMDATA_INVALID;
 	int i;
@@ -474,6 +477,8 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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

