Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60EFC433F5
	for <selinux@archiver.kernel.org>; Wed, 24 Nov 2021 01:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhKXBsq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:48:46 -0500
Received: from sonic308-16.consmr.mail.ne1.yahoo.com ([66.163.187.39]:33330
        "EHLO sonic308-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237150AbhKXBsp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Nov 2021 20:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637718333; bh=tYmviFOOq/cdxOdS7Z3hPoBGtoE7FfN71PBaagT21F0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Kw2vsXFkYkx+jBIHMcNFOujchzZlRwtOvQ91PGpjulXQKwuQj4YWJB1T4iGa6LAlsevHrJQGCac7xgw7uCwWDYPe1XRA1eEj2dVOppYB/+j3zyhL5Hwzx4zq7zVeFsMOrqgO9qY9MBbLEaB9WtIk46JO4ghTdSTwLd/HUyRDoWCl93aavxVGrlzDYwRzJadcdJc6ZOrBSt4JZBRsgAs1YRhfImS3RZk7x8jXy2q3+byCVBSV54q6TNfuOLY+c0SU//utlym2DhjnQ+bUpQZYKbxQBWeXSiHvOfZ9zGEyP9iNaCNuz0B336HQDGOtXfTH0ZHtZFxuQ1fvC5T3inlnTg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637718333; bh=u0FHKw56I2nb+SmEG3SqZqHpT7KeR7K/luV17G4601i=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kD18qMN8fJ+aKs8/x8ovlXIsirFm1sB1HqUedzWW4wCv9t8rMq4MyVUrsrOEWu+W3QtjaZcEh5Z/YOwM8hmS8SsFJ33Axcvm69fXuz8TK0gqx4T0S1UExY8DN2JUGRSB8ZNIq346jxIBxhVay1dgTIWX1mpkXpwqwr5ik6ohiblCDBlPfHkEPNs3J9twOdVvXp93Bo/oIbNZph1C2zYhPcxWCLQx8eJFsZpdwSW5svi5Xt8N+1UTrJUmpGzuAK8bye1GnlNtmFT+JaQQwB5pVzrGNu+su91ZP/vf+rAkdMHunFpn+2z/4nhlkOwH82iHuZlqDCu2zEBRp9oig8CKOQ==
X-YMail-OSG: l6yDQxIVM1n_8nTwQ6UfrPKMsuO1t_VWcbETcM.t98NZ74YZK9FaZWdjX5IKmLz
 Qff.IxrMC_i6s8dV2XhiX0Ax.8bdudV97Ico7aIWZuY1LRr2VeKXQRp.pa2i0ZwZilUyppUF4Lnj
 Cr_B9eGwKwwCni0CFFZlG1G1aiSsaq7w7pRvABBQkklcOlJB53844XiKNqeb_V76_Ra_X64Xfmhs
 jL.VO.HTOcho8K.GDcxbszXmAYD08Fv4dh2kCTSSGBgaRcUvnnuCveqZvJhWau5p60Uxu8yDsKr4
 D7EorCiswMsrCHtDGVW82HqNlYsGLsYPP0Xu0eKuLYlmNZC0SAAd1iLLRFsOyHVyuxtbZzfnp7oh
 _PFxupOD1osfxfPFgSNm5wVlLBEcFcVnWwsosV6Ov4qLIqDNhM9D.oiB_YQxZtg9DfW1ok1WoOVU
 4ACTDWZ26r0wwFZXhEqjGFPfxqelb20osfDL8vBOJMDaq9qd91gryx3oNCg2gAuv0eIcZHqYQnTY
 TVnki3jxDW01CH5nIyzACXA2tD8Dio6r3uQnerHDy4eggOF8gxMVDdnItDgXW.Z_fNQKQcfpxlAM
 u78BeS.NeIsxmW8_5J4JGTIC6aT.t8Uue8ZIVzX6U.UMc2p.qFVy249EvELeR1L_DO0M_9THPBX.
 SUDRQLMsJA0QQCO2CvnOy6Jiuk_0YXggY_1nc1LGKvyThZNA3Ssw_ONVLXRXqzI_WvZ_Ss7ps7nw
 03O6CM_yR2o6uWzOvhKykNJoWyDsDmfE7wFxLlPr8QJp11Tzm4gIqu9IzUKzJIVbXZjXMQXoGnno
 FB7yqcXK3l7lmI.HGZZhhGdHIAXnf3uUyeRJ9k7FVgRwYlPaiDG9doNOt1Y2gmgOS210lGW0Xp1B
 xLYaFTgtl.d_uCPGI33sMr20Dm3rCMC.nXcd.8hT3Ct2Lzjwl05E8NBLGW554W00rdkblblf2cNA
 hb_5FdHyiarnYOeCCBkS04rozshUYRVHQfp1eMqen4aM9HnTLamsmwXSnUSRoimsNgXmzMWz0Jkl
 WHc1cbwIM0W2IoVQ7ROkiWLlrK6F0LXudIzkZN5lTjziehBTqNkEfev8SbYyAOFR8TaxcP8K84_C
 VKkVPBoROimXmMVmskCJ3udVKkOSOdNsUXIDuVhKyTkGWfmVcnRTp3iYnNE.AbtNfS1oOuWtGjhg
 2yELCcKz2RC4oAlkc7mTW3uwBPRcv9YtmnDsn.YMfpaOFu37LJPuRuOenNJYNI8h5.BVAEzGvfNU
 g_l0RIZ6EKtD9uzzeUAg_WHaGXzxYPp6roL1AfXIp3Odtoau7cNK7y2hugE_yNpscXnlNfmbIEAG
 Xonj8EkqMXKVuEkEXUo0JSHxrXm27PhvuHjI.PvB6bJOXddyA7kj6ElGTxZFSabmCIM8BBk1jcKw
 uK7WnK2lGn_9m0qLTROYzE_fh_W1bT7lDdocMpiPb7X2IwSwjy9ObR4AY4HBAUrFhN9TA7wPcCRI
 jbOpEK8PYD3LbzvIKJJIxUShueIBEIZRD4Xpv.MD5GSi1bsxYqkixNk3Medq63c3KCYglTOz2sl.
 JseusQDkZOtgW28TB8upC.4sjrlzCNiYiI0JYm0GkJOXFgB_NR0OdUbh.moghai_ygpc6iJM81El
 nugeIyJCuQ0IJUiLaNGSh5TONmEK9XvUkdbkDaYIN1J0PGHqMaSUW3P7G2LIx_nWzUNUWd3iM48M
 PK6dKY8Bn5brr3U8VtEdHbtLA5t.HrQcvudzghogcIfFD0GyFXRIeFRqIRrhVz7MepE0_2126cGZ
 GILLAIfLI9020LekiPF2LMwVZ4VuUsQ98b1_MdxAlrYlWaeCDGq5lPeGBhjbVTBNlU3WmKhzba5I
 SURNsCDW_cMhwG8jzDv_xQqzHUkwpGUhBMEtMTOJtDuUwkgMteGhJLMkHdVBNPHMwpa2TfZ8Btj8
 Sl895TL7X_.9.yCOuE5jiIHDVUGL6f34Q0GFsmNBHOwaIcSyW_SaRehH.4Bcp.0JYrCHbNj0Z02b
 iA4y3h0cHO8vez4jGLYVF6OwxWc9PCq_KuYi18TN1hYS8ckLTUHuqeUhn20FoSZcB.kWLo1iqYCl
 Fe9xUSuXcot_BexVTrJf.dB6uf9NA7RqWvGRq0XpYe6DrOLdSj6VncMJHgD_pz78IgaLkLEgsqbh
 x6gnqgpwAvn5bdA23xmEYRRNiENfE8LdGczEnhTGSCw0g3QRqocQRmMa7irSmlhMg60SX68oAci4
 wp3JJleawI9QBAR75OfQEtiIJWnc-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 01:45:33 +0000
Received: by kubenode536.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fe85aae97f01a62fa1c76c1f4afa6f87;
          Wed, 24 Nov 2021 01:44:43 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v30 01/28] integrity: disassociate ima_filter_rule from security_audit_rule
Date:   Tue, 23 Nov 2021 17:43:05 -0800
Message-Id: <20211124014332.36128-2-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Create real functions for the ima_filter_rule interfaces.
These replace #defines that obscure the reuse of audit
interfaces. The new fuctions are put in security.c because
they use security module registered hooks that we don't
want exported.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h     | 26 ++++++++++++++++++++++++++
 security/integrity/ima/ima.h | 26 --------------------------
 security/security.c          | 21 +++++++++++++++++++++
 3 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index bbf44a466832..71eac35bfa21 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1917,6 +1917,32 @@ static inline void security_audit_rule_free(void *lsmrule)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_AUDIT */
 
+#ifdef CONFIG_IMA_LSM_RULES
+#ifdef CONFIG_SECURITY
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
+void ima_filter_rule_free(void *lsmrule);
+
+#else
+
+static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
+					   void **lsmrule)
+{
+	return 0;
+}
+
+static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
+					    void *lsmrule)
+{
+	return 0;
+}
+
+static inline void ima_filter_rule_free(void *lsmrule)
+{ }
+
+#endif /* CONFIG_SECURITY */
+#endif /* CONFIG_IMA_LSM_RULES */
+
 #ifdef CONFIG_SECURITYFS
 
 extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..1b5d70ac2dc9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -418,32 +418,6 @@ static inline void ima_free_modsig(struct modsig *modsig)
 }
 #endif /* CONFIG_IMA_APPRAISE_MODSIG */
 
-/* LSM based policy rules require audit */
-#ifdef CONFIG_IMA_LSM_RULES
-
-#define ima_filter_rule_init security_audit_rule_init
-#define ima_filter_rule_free security_audit_rule_free
-#define ima_filter_rule_match security_audit_rule_match
-
-#else
-
-static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
-				       void **lsmrule)
-{
-	return -EINVAL;
-}
-
-static inline void ima_filter_rule_free(void *lsmrule)
-{
-}
-
-static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
-					void *lsmrule)
-{
-	return -EINVAL;
-}
-#endif /* CONFIG_IMA_LSM_RULES */
-
 #ifdef	CONFIG_IMA_READ_POLICY
 #define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR)
 #else
diff --git a/security/security.c b/security/security.c
index c88167a414b4..063c9cbbcea6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2563,6 +2563,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 }
 #endif /* CONFIG_AUDIT */
 
+#ifdef CONFIG_IMA_LSM_RULES
+/*
+ * The integrity subsystem uses the same hooks as
+ * the audit subsystem.
+ */
+int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
+{
+	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
+}
+
+void ima_filter_rule_free(void *lsmrule)
+{
+	call_void_hook(audit_rule_free, lsmrule);
+}
+
+int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
+{
+	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
+}
+#endif /* CONFIG_IMA_LSM_RULES */
+
 #ifdef CONFIG_BPF_SYSCALL
 int security_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 {
-- 
2.31.1

