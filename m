Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91579C31E5E
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686552080C
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TW9i6Pf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbfFRXGQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:16 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:38568
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730879AbfFRXGQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899174; bh=KXp5QpWxgawSz2SrDoqSuCZLMSNGJ0XSmB2KlDtTJE8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=TW9i6Pf0CjJlWCQJYm1RpeyYmYKp+K52JSjAmseYHBvV6L4R5CRSE5aMg1591QjGlHZktvQp7BYxs0OmClHgGUyE28y1y3YVJ75dWYfXyhq1iF3qYRSctIkut2PLrfmcmTwNklUhKuUzW/5i3ntQ1exP2Ppmaw5Zr8HQs9Jelnm1rrYNR13Es8whSbMq0oPYBDvvR/GqgJTk6hKgd/GTnsMCKu0m0fV1q9fdU9cJgyCnc/2kkVcZ11xA5OG8EUWV3hvRGUbvVXV/2c7s9S5/4hoJlaMlDGCdaZGrql3J5EuBc8A4bi72ixZSKgY7AL7XCBt7xvRGU4dhdBlGN6GAeA==
X-YMail-OSG: dQqfZjcVM1kzzUH6G4vJvhakS9U8pL_46B5qqOgqojZX7yQe7T1eSutU7fUxRBp
 fQrCeAXnfEI0yg5mtsAcZoy938Krr4TsZKnDgpZfBesRVE4FrPlkdGmKXKWxPCSxmEnNkV7KXmx5
 ZWi1LcwFZA.j4pQDR_BizqxUkz7UZzxXsPbVn4DRZeqwxUB60qidd4OZ_BOtR6pgpmvnPv06Xkdj
 4sj6JVPcGwQ6xir0u1Fcc9s0N7yAk9rOy0TGAy_07.lZnJ7.9Vlktx5USRuLNEqN8uBHOW2.7et2
 LMfZ3bpoLpFC49pHOR3ijxffSULTFZvIYMYSKZPw5716AtR_QCsc1h.9PdwQ.k3CXtmtF_HypEpZ
 gX9FQD5q3GFWple59V.q5Ecc1ioFZzVmEaURADxHn28A3_MDTq9aZWdxfD7Ny_jQfoFtB0AIedbX
 GvuF2469fqZRf4ZtYhJoctLgeDqEqNy4MFxCECq.wpQYqvJpyRuSRKVod2WCMv62r8UPyHSBWI7p
 kFwuBLCGIMmU_SK7WPYgVOBh5cKxb1H3hBk6yzijz.b9iWz_PFYCcZAIP.9gBIJKjBHVwWRiNEqv
 uJR1ZPUYcJ7pU7X_NBXJyLA9JxZHFSTkGBx0ByHc3clWAonqIyzRUzh2UI.h5q9liGP_AeMCNz6o
 sOB7fPFVTAFFrq1D2vnuIHmpMUhPVNwZGG_018lm80mj2x5OPi5At5oGIfg0UwZTIZkRDT51hocZ
 JIeI4iI3wRmd8_NIS94t7u1bgMSKNR2yCJ9cgC29dX5kFuyIMXyktGxwuwzWWxz3rUk2o1eLnbwA
 lGxvpVA0dxQadEQ2DxidMdIb8QKNMXb.77HUJ2_al_2W4SQy3QY4GQlpxcV1k7jf.uVqw3r3E7dl
 gzchSx32ePI4pxdIl3KiCPYQmle422QFR94sk3WdYFmU7oswG404HaorVfyiL3bpe0OnZtiJpCEn
 oay32.OS9ueZn10QiAtCTQ5k6MCrxY5ZsBWnMdx2Gj5CeTs23aANEc7p0CqeuaPUKAxxhgJ5Fh5z
 MbYNsCuploE3AV38sWwHFFVIFP4e.P81X2mVgmhXdCS4B83_TOIoxyKAbq3IdkfmIYBttc.zs1k9
 wmn1kOA3wi4JyrtrS028XN5dMudtp1Sh4CRYrws8bFeqRUScJFMqIlMQAxTrKXAeAIQw0ad71h0c
 PADjqpZKQBnccpXpYeAv6pkZPyfyuuh2dO1_xZVNie8qTvBLvRpJpjk.I3pxcUfz5WBohhqaFGqq
 PdZHnQPVlN.QTpDgfXfBogsavKwavGQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Jun 2019 23:06:14 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp402.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ad2be8c6eeca573a242b1447ca635ae0;
          Tue, 18 Jun 2019 23:06:10 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 04/25] LSM: Create and manage the lsmblob data structure.
Date:   Tue, 18 Jun 2019 16:05:30 -0700
Message-Id: <20190618230551.7475-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
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
 security/security.c       | 31 ++++++++++++++++++++
 3 files changed, 94 insertions(+)

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
index 49f2685324b0..28d074866895 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -76,6 +76,68 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/*
+ * Data exported by the security modules
+ */
+#define LSMDATA_ENTRIES ( \
+	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
+	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) )
+
+struct lsmblob {
+	u32     secid[LSMDATA_ENTRIES];
+};
+
+#define LSMDATA_INVALID	-1
+
+/**
+ * lsmblob_init - initialize an lsmblob structure.
+ * @l: Pointer to the data to initialize
+ * @secid: The initial secid value
+ *
+ * Set all secid for all modules to the specified value.
+ */
+static inline void lsmblob_init(struct lsmblob *l, u32 secid)
+{
+	int i;
+
+	for (i = 0; i < LSMDATA_ENTRIES; i++)
+		l->secid[i] = secid;
+}
+
+/**
+ * lsmblob_is_set - report if there is an value in the lsmblob
+ * @l: Pointer to the exported LSM data
+ *
+ * Returns true if there is a secid set, false otherwise
+ */
+static inline bool lsmblob_is_set(struct lsmblob *l)
+{
+	int i;
+
+	for (i = 0; i < LSMDATA_ENTRIES; i++)
+		if (l->secid[i] != 0)
+			return true;
+	return false;
+}
+
+/**
+ * lsmblob_equal - report if the two lsmblob's are equal
+ * @l: Pointer to one LSM data
+ * @m: Pointer to the other LSM data
+ *
+ * Returns true if all entries in the two are equal, false otherwise
+ */
+static inline bool lsmblob_equal(struct lsmblob *l, struct lsmblob *m)
+{
+	int i;
+
+	for (i = 0; i < LSMDATA_ENTRIES; i++)
+		if (l->secid[i] != m->secid[i])
+			return false;
+	return true;
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/security.c b/security/security.c
index d05f00a40e82..5aa3c052d702 100644
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
@@ -427,15 +433,40 @@ static int lsm_append(char *new, char **result)
  * @lsm: the name of the security module
  *
  * Each LSM has to register its hooks with the infrastructure.
+ * If the LSM is using hooks that export secids allocate a slot
+ * for it in the lsmblob.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm)
 {
+	int slot = LSMDATA_INVALID;
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
+		    hooks[i].head == &security_hook_heads.secctx_to_secid ||
+		    hooks[i].head == &security_hook_heads.secid_to_secctx ||
+		    hooks[i].head == &security_hook_heads.ipc_getsecid ||
+		    hooks[i].head == &security_hook_heads.task_getsecid ||
+		    hooks[i].head == &security_hook_heads.inode_getsecid ||
+		    hooks[i].head == &security_hook_heads.cred_getsecid) {
+			if (slot == LSMDATA_INVALID) {
+				slot = lsm_slot++;
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

