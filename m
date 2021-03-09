Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB17C433E6
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 14:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F0B365244
	for <selinux@archiver.kernel.org>; Tue,  9 Mar 2021 14:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhCIOql (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Mar 2021 09:46:41 -0500
Received: from sonic309-26.consmr.mail.ne1.yahoo.com ([66.163.184.152]:46010
        "EHLO sonic309-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231640AbhCIOqR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Mar 2021 09:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301177; bh=ELfkMIqQZDbJxjrBnglPQxfy+hyae5QnAksuBOVHLAg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kaK9bOyPLs1QOyAIYHXQt0Za/Kd1owiVlp6X0m5IXypD8wfj0yk26QfQxqN0IxxiB685phwqb5SjcWHVDQ0MNcHGLYXX3Xy7do60UXX7YJmN930+5Jr3zbTreH2YPJYPhR8JRYmNn4MDsh4qtjFAscAA0AN4i2gMCdYR2Nhlw/FVkMH1GjQA9wO37IbqRBRrU6+kQnJy7lCeFpIrPQS6eX132C7T5mhBvp56f+yGlLYiJ9/8InTh2MpXd889iG4VWpLhjL519jj0223xag87FjYyIMmWtUtqZcZs0z9G+Po3JsHfBLUYV9x9/l8+PllYQjjQSWoHoFmgcgaazaNUVw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1615301177; bh=OQT5ztZtSstuHNSKu28bO5+x2n9Hj3zFazqcRSUYedT=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FLqRtZmXfsTu4/0h6rJasPC1yn+7+Cl3UO2QBMcgB7UKGOCq8SODw3pW1kNTUhl/tx6MsdCP/kqudTNP8b3p+3fqHhvWJlGThNqGgjsfTjBNhb05UUQurRBpE/RGFakNdstyM28Kt+UrOg7M9dJMPo6pfpbhC+3AE8+jbUkRjgkUuI605uF1tqomt0+nABhVeXJHoRKRP5EnvhsdAFOnNMmUCNpvlcAdEVLBlcu7toXrem6o/rwxTMGUPInC98zvFtg8HA5+HxNRNk6raeKsT1JuzOeC7P/3tpyv0KFjqnQhB+6oVoGflM5FERLYM4cVpzzXFhYXin62Edr7wxFqlA==
X-YMail-OSG: B2YtZ58VM1mQsI7Q82M3QMZG1D6estPoZCW8ypDicsEfHaNVo3FX793hcayQk0w
 kPlo7hHq640e35HJOWXXcbVMjvvQlgBFaCng7FxjiMTRT8cVm2zrzOqcQ2Alrrp_HQw9q5fvcd1g
 t0kzb.ldpP3AMQBJPZhXtCV36aDkcvnvFSYz1461.PmhTusNskFhZI4lxhR_tJ72WlQtX0KOhvry
 Fm4IT0s4KMVRpF.w0Y5iWpX6PfA_xsTCrtytSXFwxaNbR2.HuGhbjnqE6lagVEb1TIWUSRH4W1HP
 TUMcOvukWlkLyRulauBvgthp_D187wpbS_heTf36.0FDsSpjOalfE6YxXiehpaCFFf0fXWGZCajm
 SVTdB5j2.81DOSXcFEUv.vOz3y0UnLakQ.P0F7aE.4Rq6mmyw_jnIdFteFeDi2eNBHCL3Z5Z7xq1
 87skDm09i_r_F_IZtepduAptDEG_HxiJ93OHKbNqLlhYyRKKfMdgVOChU9l8X0P83kxVcGblFPAw
 _9l6eN24sdo8s1TRgnCwUfKXIdZYuknL9iqNVDNa5qsYrzm9lphfCmHw9kQd09PtiT0E6IG_wWOq
 pSU9aUWQ.wOGm6IgsqiWboZKYgznaf0wR2ygeG84YvH52hITXuxVSQGeHTiVFY2aWq9Q_oeJFU_d
 zlSQFJpWKlU1I5k7KYOIHnRmSmjL3oMOFPIbxl92qTJkvfSIaBXNV9W4GYZnBhu62IRN2VzVJcLd
 61TonqVrgFsOSy.xFnKmeLOXQ1n5OltOKRtMvjnS.parmn6DVqbdBJFX8qM_vBG2Dt7tO_U6Jcrl
 h6TzbJamZKn3AOBLENWIZ6PpbildTTrRcafcHivpokTcrn3LrApQYM4I7hsmUTu8HtNbmIUMaPNR
 MSAM4NN7K.qDWTpAyEMgFievpBg86v0XOldJgde..5cvjwmE4haBJmCtMgoeUgelvjZ9kvIkMOJW
 v4k4Rbkmrj3XBiGdkhb0p_Sgv9ZmhNQ3i2FXEd7WVZFYioZ7PnqaQ0DmRNyM.wYloLU4rUmoIGWE
 IMzU2pOuMFjEV_wCW1it7J9rPAO_hbcDEyzDrzeTDKjczIIuSRR01a24Og9tSXoJm3xGw1OoUJ6B
 gIaxKUoXg4OAL124nfHE6Hqtn57vUY9oEQBqCHiGhkeGqmpUpYESLVUBCxhB5An_llJjYrTsWoks
 J2t09M4eu6gGXnUlr6Bhc_9TGrRdnpl5pVo6ruFLkR9Wqx1KKnFmXXKslNSP77TXWys_yOuC9jxU
 i8wiT8rq0YsOIW9.yEioZqG1Iv6mWcpHCf9tPd1yh25pVB9OxEOyXAqVb5plp4Y9DjKqn3xj7Hv6
 f_EUvwDxer7jBckcXW5oTfPhCjlJV7odqUVPbeHF8GakHgsvfp7aO9Cs.E_zZVYhcZmnq5AKrjxc
 nojW2K7_aViXwLfI.E_AbZHucY89pAyw3pD837TtY8rtUVGVSHtToulQ67XWlc0.1yPz3fPA5Dxv
 ocVZ6QkMBfhNorVMiJHRuN6ed4EJ2W3xv9lAHAMMZ0MHyQ8Ck0ebqGhEzmxR71pzDGRxlltEH17G
 QTXrsOUsjs7hL6vV73gO4F90Y5roneeriemjPCDqlECwWR_wyy6F5o0b8BA_Aj8OrivvA7OD.VmK
 4xXrRHjtbLmvDUVCJmjqXkwFVDItXk5lbiJ_GfZIJtNm9vFrMRlHeowguCeyRDhr56wVYd6FbbDK
 3Bt0zEJXcuaroxBLU5x8rU3eROh1ECHv3xuYYDYsZYPIaoaKxuaW9APwXvSqSpqqEk6KL4lZJjJr
 pa2vFkYmMA6cvDY2izODA4sml6VzGk9Sa2QOs1uxVTx5fLw06jgCS1AN9yWCK7i8qKk.nPHBlokG
 E29jqpk16wo.Abp0dKbJtPgf5VCkpN50aOhZGCrx6AJ_lkO5GqPil8E_d0SSwJ.SUDKeYkbs5uCr
 a9XMQ96zEqxC70bRIsW6T9a2rthScS9LKm.i9LNkGfC4ixoM4Hr8a5ZqdrcaFixs_aQUSTwDudQn
 4h09rbD.eP1.BCplmHIE.JIgKV8XDuPdY_.ot_uY7kRt6p2_NB8L62ivbZIIQnJPUzUUkHwcYLZ5
 D4fl_KbYdKZRut6L.Lg2NvITe6aWMgV.kba0a5rRWvulbiPtkU8iB054t9rljIdfxP6KYYE1Ns5x
 4JHvh0FNipSher4z3I2oBfeUMYB9ObOR.IJX5HNP_TDW7F.TgUWajA6MOgFCyDcDYp69BEN4ABkf
 L4gi1W9AZKGwdtJK5NiitCkeJP4G.61uyudl.MQ3YdxcNdF.3HZ15Us2H3dXzlBWEC4XuFXcg2QB
 QVsaI4Swh8pQrSkLLpve4dCRtdVsmdZCMDtEafZy0SvCLMBHkfAV8wBGdZbDQ91qJNG.3R5mCA37
 h8Y3Z4i0KI.fPwEA_9eP5_Vo7A6sqHSeIzj0RHCytYOgZKsFbCJX6siABOcqt20kgIS.dsEdiHpS
 TCjK._NEmFLnsSct3mxgYA5nAjUCNdAECny.9fBOZukqm7qJI9Nh4aiTgzyk3uL.LUC1St.RGU3M
 NIa42Pz5iUzDhYIryW2Olpir2aCs7CtGM7YQ5LzK6lLI5.sx4m.WyMuvKHtRR5lAWLwXFQcdtIdP
 w.LUL.ilOoO0FgHlKEvcbs4B52Vow2JfUcDpMOJXiU.1HpIcvKVRl.1HEAbvQmBWd6ICBOSXnzyW
 3u0qj_ls7qKeLkOFZvR_9UsqRQ2C_3Em_Gl_KFc_EJZ2txshFTAwnORgFoiYvmD77QlqUlA9rFFU
 RI3U3KyEYbbGVJsIMDvIm4aYfWRrxVCTUDTZaKnqvh6LZBIEeL8.t9wvj8JV7heV_2UMB9BU7QGI
 TxKCRa3YqHI44f26ddsq9eOKCs82aekybaE8QLe1RUA._UaQY5Z05LzMK9X9XA5V97UNa9GeGUPu
 Dk44Q8S8rYlkctPYn.FuYpfhU5jIb4BeKVHvGqOd9ki2TN4jvyJw0EMm_Q4p93YynRVc.cbL72UM
 kOnXu6dM.SoJiUX9dIMO6eoYiTkTga2mU1iqo7EsyIetyNvfYa_r97D87.MciqU4iyA.GcQ2M5jl
 b6Uzsg4qxWMNIvkXIVBwET8G0xG_aLCK9Es3agJh_YUy9BSCdH_77__vXDFRa
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Mar 2021 14:46:17 +0000
Received: by smtp409.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 613545a3f8ca8cbed6c440bc569ebfa0;
          Tue, 09 Mar 2021 14:46:11 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v25 03/25] LSM: provide lsm name and id slot mappings
Date:   Tue,  9 Mar 2021 06:42:21 -0800
Message-Id: <20210309144243.12519-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210309144243.12519-1-casey@schaufler-ca.com>
References: <20210309144243.12519-1-casey@schaufler-ca.com>
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
index 0be689d0fd69..38059fedb693 100644
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
index 2d780e82b527..4d4b0a21bea2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -474,6 +474,50 @@ static int lsm_append(const char *new, char **result)
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
@@ -493,6 +537,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_slotlist[lsm_slot] = lsmid;
 		lsmid->slot = lsm_slot++;
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
-- 
2.29.2

