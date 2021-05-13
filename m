Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DBCC433ED
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF171610F8
	for <selinux@archiver.kernel.org>; Thu, 13 May 2021 20:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhEMUMt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 May 2021 16:12:49 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:46260
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232469AbhEMUMq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 May 2021 16:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620936696; bh=qEq8Lj/7uNcH9ecnF3avItFtB/sPchJA6oFxCuhF0rc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=bnrvuvix2PKZCflmUQG6WDCehXPGZjUo6Wgls343NYfdjnOW3iVlF8Y2E6eKp8rdgL4Rw8fSiMoGfP335o9CslehjPBRfvbbOURE9lG5CX7YHfjHZ2wSk994Uc09m5qaOC9IxWKiQRvjDq7hr/OWktPNZOfPOsIbwP00WShlm/zQ3bK98FZ0GmrFUJ9uX2GexNnvYfgTELJtw9JNkdaUugwSC/LfNcjWIB6+vGKzoYsSvl/FrfitI2mV4se7WMLUddWUVlA1BsD8/kHb2ndq/k20smHTWlTn3fRR4FsROlpn/epkIon8SmtHS8yuDzl8hioDeq1ZGxcHySc1rB92zw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1620936696; bh=5B7twyjLZh1dM/79rrNWB/DsIghalvjs563on4k0FZ9=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=tN9b8nAjrEBiwaLcYfJmREgevbDMR4iV9w/nMesglGU10YNFZQawUDDACopbjXhzlfqC7TXVcADSYWq1IDdVXQSPJEuih0LDUg5YlQeHPlLnaKLkYmjO0tuZj391VCmgqWzr77SmLzy8RpBEtQT/AJAiPWGtNU7JCCXml/IX7OqsKaYKV9sHun4XpoI3gEOeSi228s+Jj3m2qUNdMPISkhdApK6LrL6H8tCJ6TpMdt7Vki8Cfnt5U3jNAypNYi8KkSVyKQPI7bgaciXhgaLm1OL5KNKZoQkyDnAwpk3EIqJ5k6vKuDDV8ypnCqXbHwn/HZjIFSfs887K2ch5YjUvIw==
X-YMail-OSG: qMdUm5MVM1kEy7jpbEmZDl3RfNm.fw.Z2HgqskHVVhEzD8spON4gGWxCvf4Fxq5
 tEtDXTafBgXUOsIm33DNhpYF_aqqCSbYA9TDGX55wlMKGSRvjZ_gC4lA_ZyOqNdZX_R3fRU4u2v8
 hfU9GiVBMr1GZKUKC6inrHodI6o14PPkEgCOYjA4z3Vy08_sxvwhoahoIMkAuQpvU9TdJMZSVgkt
 bTW_YXgz_fVjga_7zBY6FVN0olY4WUUKhfL.wghN7pDtv4sV3Pu6J8ynuRvPsxkTFQsqnpK35it5
 Xow1t1BKIs.OT9Os6RI9DFXSwjZvhcnhkVNWEZk881t1sWGPT6rmO3VwYvUNX4cPrRa.HthuT_O8
 6Lw4PdWYC7rNXK12WZQQucdWjuk0TPTIWqrsoumwjfILuvPL6bpyCPzZSZ3IRiibBjbJvgW.eewS
 0yvMZpsKVZMlaJXLf6f38VI9qntiTK6.OWfF_PuBGt3QcszFYxnYScPapOXM6sy40jq4Mj3xb_S2
 _WNBwClCxILo6o6XxRXbZs9LO.Dr3u5b1R6YY.IpJ0bDsSfnWBGK2iE89av2RVveJ6empsj8LtS3
 .1oNqTBJ1RMAHIQjeD7bSr0hKtx4OfZlAT679eMpbb03oysjYneifGUp7w7EC6yzVTlG_Wo8TsxT
 lYNRNfxfKgLyLzStcoWDFfC8naYwYeEGrKibUxrtrJupe3rEWmtJrbCEISIbgT5_kC8qat6UjYgH
 3rrjAreO0GvoaNFgVfhjK6NQj1fFd8tSiboiHXyImekAbNCWtk3ef_Ij7pkTJIALBnnXNAXRJq7s
 bFtmNAe.ryM5NIY75UokYzXj8mXUFxsx5AduM2g.1zjCEUVSnSFPP8HhFdPRYx.HDd_sjk5S3lzT
 dUFJJmOFtmdpVT7brVH3k47DIgWTMxgV.U1oM90mVCwq1nlKv6YdmSuywAj75Pw6ouf_0JKKFp.i
 mwkAdr0wEKW_61MbJ9bQ_hBbhRkRAsHgOnAQGuvNRUq78GJQx.ZFOEyeqh397gzgS308CC7DwZyy
 gpWrpN5mT3dc5IBbRMxV.Cwtj.I3sa36Ox3_15FNZuVbFMei6XtwV0INYgn_qgGN3PN1cAuq4_I1
 FP_hRuNmiLXu8vK0OA3ZgcL5LN9w06KAW3V4VucX9GqNYndUp68vx0XTS_nw3a46TfeeZdFFfWS1
 pxy4.5dqm2ZrAMV9r7SO.3RJy2Pw96Lw00K8vbBbraNH.O53gIz0HqqPC0MSuXvf6vz2rcf1cN8S
 Egu23hxgIIW3uzaM5whsGjWE3j0dSKswY.SiVGsxVpIrvFCwEr_gCEARDT_jmohp8dO4MvPyIlp3
 9b1x53q1yk3UA5vy_gtGlkVfJIYIkfve5bzCfoIwwtuV0FETAVmxvYAUBw9YQGewU4MhV1sMJpE.
 bLF.FKyJ6KaBWb1GNz3KwYP4wct_x3o6e7k.QV4Oz0T.71Ey4G17h6B_Y_DmDOR0cMkTrXriR7dU
 aQ.3vQLiF2TRmOaxHS4fPdhXablmAr9V8vIUVq02Mn5cOOaUGE7h.y8htaWKSqEHKUL3lmAJui9k
 fWsYfR.4dxs89TCxssHXKeT_EUgtp_dYzF2sUy7kaXXj8JOqm4uXOZa4KlFvVYDX.CSCfPUK.rrz
 MVRaZt8Y2QxTz24FSpHvoLkcdgNF_xF_P5ZfD9k7XHEwu04uVeoYBcQsMKR8DLHlW.KSc6HlgBuN
 EVJq42gs4ckWvRsqmhCpkMp8ELCwwZVW3kxjVUTfb9TQKvwVlYpJxsOlg04qw68dtaEXkE_QGWHX
 keuOoE2TEfv6g4EbXBy0teT5FOe4Uhqls3jyUxi1Yqq1FM3t5l8yYSjnaL2Squ.zdPV6eiNtFWs4
 VsAZ7iMRRcxkDfpy2yK7M1RoQRGPGapW2NxaOLuoSReHDbOcvxeEzbLVe5W.tU34pf1i8j2weHwS
 EaLIqUB82q1qKKPiqH60vEsc5bPfy8kFDK0Q5_.BBJdD8DyMwZNQm2H5Jhphf9eZf8Nt0.StifWS
 aGrpyZM4mMZ1lITurbO7ArzJ6dA9b1MGtWiWiWSPAx.S9n_00QfHtDGN_BC4NUx21o3pdYMnQhTQ
 4mWacgZx8p.JZ6rKrlBMe62hhWbamE8oOLTS4ac9PXT7aORTolmCZm57F2F4vvJu7a4M0RhciWNR
 kEqoIHPZm22XRxCxfezXraSg0db7a7MR_cTMugiIj3zKqGlwzdlaA2kgmJH8WvT5_6cNxF3t.uIv
 etilqahXC0qEljJVBk9VcD85DC1svYl4xY3gBG1_8E7JTXKBwdrCEq.vtxGwtB0VTT__bzaMBtvk
 IaqWdrJjSJ6zUXy2e9d7ZgP33xmqg9IJWDQV.UgmzX4hqN.OqRgAfXiFyXCVZlZBYKStJ81792Sb
 Rhtq7sIImjp4lg47hgWrh9ST8cyLwVXwIB5vtmEodPfxRCCemkATSf9lkl0fhZPZDfdO2iKSAtxA
 j4xoV0PRw3YjmXlxpphWX0LLJay2JVmt8Q5uSUxAUkA31xUiO4KZANzi0a6PyPFSxgHytSi0qO3p
 iqV3FnxCNbXdw4uEmE4ksUHmikvRkuu0a__eElVumZ.35mTSPznnaF3mW3gAvqMlIgaySEfOXcHH
 MnUM55JIYVu8Uh8RVtNPpRl2bob_4W.Iw5Sqa_YiaEFwnsY_3X_QgXKxNwFmRYmO3ZzwdkqKCG6X
 SnVSYP31mnRUDuP9wktbYElixfe9mxyKqP2_aEAPsLou.C_bLODWdkMlHcTCcPIdjh_KDs2HWIDo
 mAKD.EBnwx55ocKkF.p3NaMZZzjy2_t3nmarnOP2gU52WoHNOXqtJFzehdm3DILmFbLSyHEV6Auj
 oTYDzXQgvAeABCWCBvhin.rTfHjy5tkPCYWC3jyu1jklN0KZFM32w7ZDcMEnCvWkG9.u0zRnrCpY
 gAnvT4hudISZuALdGDnZpVrSC3y47sLN6cuFtxGotyuPjREBbJPvAvMRrHUzYJVU638sdCj9VDO4
 mo1yHuYUxvdmkNtzW9xm3yJVXQSiPV899FhM0n0duwP1b9SBUy8L_26cNQTA4fhszXqHc4jBe8Sh
 9qGnMT.RhtzAO_wJJq4X2.lj2YaU3gDITZLMqYVl1RvcDeJDJhw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 13 May 2021 20:11:36 +0000
Received: by kubenode512.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ee9e80ae2ed374cb2f7759e49525aaf2;
          Thu, 13 May 2021 20:11:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v26 03/25] LSM: provide lsm name and id slot mappings
Date:   Thu, 13 May 2021 13:07:45 -0700
Message-Id: <20210513200807.15910-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210513200807.15910-1-casey@schaufler-ca.com>
References: <20210513200807.15910-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Provide interfaces to map LSM slot numbers and LSM names.
Update the LSM registration code to save this information.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  4 ++++
 security/security.c      | 45 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 62588bc522ba..ca9485105f00 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -192,6 +192,10 @@ static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
 	return !memcmp(bloba, blobb, sizeof(*bloba));
 }
 
+/* Map lsm names to blob slot numbers */
+extern int lsm_name_to_slot(char *name);
+extern const char *lsm_slot_to_name(int slot);
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
diff --git a/security/security.c b/security/security.c
index a3276deb1b8a..9471bcecc052 100644
--- a/security/security.c
+++ b/security/security.c
@@ -476,6 +476,50 @@ static int lsm_append(const char *new, char **result)
  * Current index to use while initializing the lsmblob secid list.
  */
 static int lsm_slot __lsm_ro_after_init;
+static struct lsm_id *lsm_slotlist[LSMBLOB_ENTRIES] __lsm_ro_after_init;
+
+/**
+ * lsm_name_to_slot - Report the slot number for a security module
+ * @name: name of the security module
+ *
+ * Look up the slot number for the named security module.
+ * Returns the slot number or LSMBLOB_INVALID if @name is not
+ * a registered security module name.
+ */
+int lsm_name_to_slot(char *name)
+{
+	int i;
+
+	for (i = 0; i < lsm_slot; i++)
+		if (strcmp(lsm_slotlist[i]->lsm, name) == 0)
+			return i;
+
+	return LSMBLOB_INVALID;
+}
+
+/**
+ * lsm_slot_to_name - Get the name of the security module in a slot
+ * @slot: index into the interface LSM slot list.
+ *
+ * Provide the name of the security module associated with
+ * a interface LSM slot.
+ *
+ * If @slot is LSMBLOB_INVALID return the value
+ * for slot 0 if it has been set, otherwise NULL.
+ *
+ * Returns a pointer to the name string or NULL.
+ */
+const char *lsm_slot_to_name(int slot)
+{
+	if (slot == LSMBLOB_INVALID)
+		slot = 0;
+	else if (slot >= LSMBLOB_ENTRIES || slot < 0)
+		return NULL;
+
+	if (lsm_slotlist[slot] == NULL)
+		return NULL;
+	return lsm_slotlist[slot]->lsm;
+}
 
 /**
  * security_add_hooks - Add a modules hooks to the hook lists.
@@ -495,6 +539,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_slotlist[lsm_slot] = lsmid;
 		lsmid->slot = lsm_slot++;
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
-- 
2.29.2

