Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEDFC43613
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669BE20673
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="leNmuwPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfFUSwu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:52:50 -0400
Received: from sonic316-19.consmr.mail.bf2.yahoo.com ([74.6.130.193]:33228
        "EHLO sonic316-19.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbfFUSwt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143168; bh=PGKvRCSbqIDWodkhP6/xWBfRSUfC+5W3L8GTguf1008=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=leNmuwPxAoaslQIj0AbEbKkwVfWQVrvGhght7ln/k+WIiR/C8jAKtwqnibF6PYAlqAkGO88tm4ZAQ+Zjl1Mrj81Z6F5ShnX+QOc1FfheqnHhfqu6vHoCwapSVbx7np11MZi0EUJsOfFKVzW4waQVuubZ90CCSX9RZuT7eTFrR1m0A+WJARucmNJrAHBRSPEZEY5YJVjkWEnOSCcVaRQzxmSRnrU0b4KbYjP9fcbcQ+bqv5+Vx2sLfjG8bouPhIl2R/bYRD/xAEGv/lzBRounkqN16AQEtDGOHbMlfBih6oD0hJ61xTlV8KjsNhja6VMVCpBIDhgdqH8COjkhNJfgPg==
X-YMail-OSG: yeP05PYVM1kmnSofwU6aQ1c4RTb_Xb17zImUM_UN2GNnwAXlIN5x7z9SAJCWqEN
 1rjf3WsfqNA60ZSCeFveyXCdJYyHEkJ14egprkREhkKghoBtVTblPBjJViiAZ_y19IgRuZnBSGii
 Ha.WxuHAWim1pGlD8PceB6qntAKnrYpLfbBMYxq9Z9L6o9aD3cFk0FivZrKVQlk4WfKdZe2CJRZl
 AtLx0NheVjoEdTgG0hsp8.IjhWxgQCCF1fYLPcNsTEeDkmPcARBiPBSr.10WBtElRe6bznmfsrLa
 P1zCw_FPSKflAj8CWfb36QalgCxV_.P4.KSUda2nY7DBAw4z2nlnYOOPnhyA4S92HIafem31rNdG
 4zktNKCFheYpsP84CjwYlffkzXM3pTDH0.YxrSgjUDCXPbnFOYwAlLuJuCcWwHpGyaq8GmeCDWa8
 Paihs6Rn0m3xd8E1CmsxdSBQzbNKgsp2ZSnD4CAWXQ0l.KdX9lu9f.KBa0rIXKdHhi4lFx_7qmre
 ogsayuhV..ruC7biq6w16gn4MgGF8RspKOjJur7pRUMKGloTYF9C0zdW08fM_6LmkuxfN8gNJOx5
 DXWcqiuAY0oZR7UUiKtWPNKQmS0yv0u31bImnfmpiH9uYoXUKIvDd0MN2KcUZ44ecqeeALakfOhN
 KRVoXpj6ZSFkxdHlJxceNZpySYxDYLaheXrtxK3ZnpvAVL4RzlUiqZnaflTuC6nG7dSGmsWVeYwR
 _ceebzDyfYMPYrWYLkKlzF0yFaiyXxpbaOkSV32pbXKb7RoCxdIQOeUOCvagLvrKuYLfvPNNE89J
 FkJ.zoNe6KGUvhL2O7CHjwNJjqBzc61YTg5x4opyVsKZy8U4.7BYNzrSu2NMGQ0vZMRtLSggsHaf
 cRB2XAbRHsF2KUkWHLs8ZHFFCHwSCO.VfBXqm6oNKptBsYJBcAvuhpaVlcpjV6xVkJw3Im7_cEHr
 tVFvT4V2SBEO1B1nuHRv9kwlVfHNaZZBLF6N1H1K_VKPvNQaY_5STiVflgb4rwcF0453NIbWyrho
 bew5Wd34lb5NL_D4YvgGyyWYC3Yp3i_Bf1B8DOUZGH7dWNsIIxWwx_WUSN.plKAvkBiEIYr_84Ly
 jknqxg5QDXiwg_RI4lTnxhHAXpJqndl_On31zQNYcWUznT3FX8coRMNYveVDW.0XKh4gvm968o4x
 2KGneGRzQU6KYL2OGhPZiEiQDGvnVQle3jrYwbY137NMI8rYv7S3EoSd4_Ojfp7WSyldidLpaCBP
 .NRZNa_VxHAEwH8y.5xCTkG7GSkwo81BRQi4SVtITqK043w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Fri, 21 Jun 2019 18:52:48 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 122e533cfde98c3a149e6bf82aad3f9b;
          Fri, 21 Jun 2019 18:52:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 04/24] LSM: Create and manage the lsmblob data structure.
Date:   Fri, 21 Jun 2019 11:52:13 -0700
Message-Id: <20190621185233.6766-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When more than one security module is exporting data to
audit and networking sub-systems a single 32 bit integer
is no longer sufficient to represent the data. Add a
structure to be used instead.

The lsmblob structure is currently an array of
u32 "secids". There is an entry for each of the
security modules built into the system that would
use secids if active. The system assigns the module
a "slot" when it registers hooks. If modules are
compiled in but not registered there will be unused
slots.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h |  1 +
 include/linux/security.h  | 62 +++++++++++++++++++++++++++++++++++++++
 security/security.c       | 36 +++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 3fe39abccc8f..4d1ddf1a2aa6 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2038,6 +2038,7 @@ struct security_hook_list {
 	struct hlist_head		*head;
 	union security_list_options	hook;
 	char				*lsm;
+	int				slot;
 } __randomize_layout;
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 49f2685324b0..0aa9417a5762 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -76,6 +76,68 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/*
+ * Data exported by the security modules
+ */
+#define LSMBLOB_ENTRIES ( \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0))
+
+struct lsmblob {
+	u32     secid[LSMBLOB_ENTRIES];
+};
+
+#define LSMBLOB_INVALID	-1
+
+/**
+ * lsmblob_init - initialize an lsmblob structure.
+ * @blob: Pointer to the data to initialize
+ * @secid: The initial secid value
+ *
+ * Set all secid for all modules to the specified value.
+ */
+static inline void lsmblob_init(struct lsmblob *blob, u32 secid)
+{
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		blob->secid[i] = secid;
+}
+
+/**
+ * lsmblob_is_set - report if there is an value in the lsmblob
+ * @blob: Pointer to the exported LSM data
+ *
+ * Returns true if there is a secid set, false otherwise
+ */
+static inline bool lsmblob_is_set(struct lsmblob *blob)
+{
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		if (blob->secid[i] != 0)
+			return true;
+	return false;
+}
+
+/**
+ * lsmblob_equal - report if the two lsmblob's are equal
+ * @bloba: Pointer to one LSM data
+ * @blobb: Pointer to the other LSM data
+ *
+ * Returns true if all entries in the two are equal, false otherwise
+ */
+static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
+{
+	int i;
+
+	for (i = 0; i < LSMBLOB_ENTRIES; i++)
+		if (bloba->secid[i] != blobb->secid[i])
+			return false;
+	return true;
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/security.c b/security/security.c
index d05f00a40e82..7618c761060d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -317,6 +317,7 @@ static void __init ordered_lsm_init(void)
 	init_debug("sock blob size       = %d\n", blob_sizes.lbs_sock);
 	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
 	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
+	init_debug("lsmblob size         = %lu\n", sizeof(struct lsmblob));
 
 	/*
 	 * Create any kmem_caches needed for blobs
@@ -420,6 +421,11 @@ static int lsm_append(char *new, char **result)
 	return 0;
 }
 
+/*
+ * Current index to use while initializing the lsmblob secid list.
+ */
+static int lsm_slot __initdata;
+
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
  * @hooks: the hooks to add
@@ -427,15 +433,45 @@ static int lsm_append(char *new, char **result)
  * @lsm: the name of the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
+ * If the LSM is using hooks that export secids allocate a slot
+ * for it in the lsmblob.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm)
 {
+	int slot = LSMBLOB_INVALID;
 	int i;
 
 	for (i = 0; i < count; i++) {
 		hooks[i].lsm = lsm;
 		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
+		/*
+		 * If this is one of the hooks that uses a secid
+		 * note it so that a slot can in allocated for the
+		 * secid in the lsmblob structure.
+		 */
+		if (hooks[i].head == &security_hook_heads.audit_rule_match ||
+		    hooks[i].head == &security_hook_heads.kernel_act_as ||
+		    hooks[i].head ==
+			&security_hook_heads.socket_getpeersec_dgram ||
+		    hooks[i].head == &security_hook_heads.getprocattr ||
+		    hooks[i].head == &security_hook_heads.setprocattr ||
+		    hooks[i].head == &security_hook_heads.secctx_to_secid ||
+		    hooks[i].head == &security_hook_heads.secid_to_secctx ||
+		    hooks[i].head == &security_hook_heads.ipc_getsecid ||
+		    hooks[i].head == &security_hook_heads.task_getsecid ||
+		    hooks[i].head == &security_hook_heads.inode_getsecid ||
+		    hooks[i].head == &security_hook_heads.cred_getsecid) {
+			if (slot == LSMBLOB_INVALID) {
+				slot = lsm_slot++;
+				if (slot >= LSMBLOB_ENTRIES)
+					panic("%s Too many LSMs registered.\n",
+					      __func__);
+				init_debug("%s assigned lsmblob slot %d\n",
+					hooks[i].lsm, slot);
+			}
+		}
+		hooks[i].slot = slot;
 	}
 	if (lsm_append(lsm, &lsm_names) < 0)
 		panic("%s - Cannot get early memory.\n", __func__);
-- 
2.20.1

