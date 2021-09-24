Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C859C433FE
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 17:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3296A61250
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 17:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbhIXR7m (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:59:42 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:41617
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344317AbhIXR7m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 13:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506288; bh=l3Mc2RMMJVgwD8pkAa//9IWy6Z+N7Gm1TtJ8A2ZCDEY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=ZoT6ZQ1Mm7wIqNdA9xp7RKkk36BogNRJkHX9N4p8/4Vg4RmANyCdSzbbTxzbWRw8OvZceNYxgaLrrbgG2/fiQTzlJpFWopSzSJ4hHkFRhvD5O37VNye4QMlcKsLVhGLE8ot0FMnXRpj8R4u5zJL9N8a/AEzmNywYvbefFIgaZFNuh5UkQMXNt2vpwV3ijZ04/0kII/sERkpd47YpH3t65qPib1W9PMJtojJwp52RSy48SKsVLiRY02OuQ266fcdAX8JZiRFxkGHARMxaFaF/Bt7eileYxrwIJV77x0+F07swL7QUgeYaMs6UWuGprvsLYGsY3F1nUV+y70Fu5jm+MA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1632506288; bh=B1I2Sl6kfc2DrUYCNLHo31pb0pKLo28Iva7bXYVlhV0=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EEKHMuOmPHa/XF9vjW7NWYWGXmujLRkv6Vhk4d2lSxZkUQN1dSZO2W9g4CDrfN3j5Qt94CASGE95yiw20YJiJY7I5fLBhJ0/qifRRXSgkqQp1Aq+frMx/43yWZumj0w9U6HKubW+IsAct2c0677rrkaz1lxP1USC4XpIuzfRYpknRngp6ZVWZBIstDxIyIQOFO8/s2jgjagTSU4raCnhx0vtZM4CWBdqJrbMAxYNvfjMgMQGc/Hq76HZ31/rGJ4cianGCV4pHRcU+t4gyDxsmTHmRSLGLrC8J8LXBhG6mCCnKynnL99JAeUBOXhrZAlQSVq4l8lBY4+6wBig5oeRLA==
X-YMail-OSG: oZ.DAwkVM1lsqnZVlDtz4rnvMZC2zHXahjHxrc5g0tRgBJd_mrUnYCv6U8MKfax
 pz1ghxJcDMWXvh3.1jvEd.L9ys9pxpkDq6xawueqw0chAn0qKBuvoLb6sZu3UOwfxjV7WA229035
 e84dt9MM7WLNMbSIShHt_0bZimasdy8.s2FA744iGfN1OY.SX2aoaPiWB.T3im6HEhjJIn8kZt_L
 LpnNjFGqK4EKsIbnyb2GwiT8TOHCtEmZmOU_Tiq0W8rfy_1g1.qpK4bWnefhvV3bW5tbvQm3Q2bL
 SQnPJOZAc9HI_IardWcZo_uvFR07rpayIDeAR9fU25nuzZhA3FMw2cwACp7HS2ySeVaecFmUnhAA
 BvqWMEwqPVHQmjTgahQqkLzTC4wHXDw7uJ._4FT64BusQ29mWSvrmYLs0NEShCd_T2XeANqTbm5_
 SskWx1SqBWb88jt0tlvtudu17G8iMssUJvTgCGoAwAMD0mITKiTrWKssEAj3PogYhsXjb5542qKJ
 pWlFfxfEboI29m04kTuc1YD5py5k43Yx4RVJh4ALVHvxLCCmRWAe05p_ifGK_IBzLVF4SkmATCk7
 3KCn7uJ4mAdR.jApBDHHKPyOwoHgLSoE79mMGX_Vc_gIyfcBx.BXhYsq9jgIXV1Po7MWtx5dUEyY
 iVyPr8ExhaopQ8lbVd8Zf9.WUL1U_HG4wmzWU_EPv2fz1SBc5CNO8rb6QbwWI5dROcRmX8Srp5qW
 9Eojh4fARmJwaY56v7aSk7Ecgf38lC5_Tvg.rRPoFY5gpZKL_827vH1gCbQU_iGH93zqI1GmEVv4
 hDut1sm63jGdj9kNNaGC1NyA5T__S2FOVMewaSrGMBDlo7FcYdx6zzK3GKYQ1bvd.ZUBC.Py6YZ_
 r8sSPV.EEhBfGyllLTiFAOyCyi1awxzitWy7LAuABMNdhv5lLVuBzBl3otdRZGjJu__3kGkkhaq3
 4__bzwEso6zfkyPnjqRIQ_ikZ5uR9ilZVDerhwbdGamvtehvypPhtmkI45Wpwx5XOiTF9bMFXflJ
 cURZHKethCrndDoa053yjl6ABj520agnJWu25xW97X2oIbM5V9sd84beDr8VbLS2PYkhn6QqBDtV
 wMpfcMRh4Y9dY8DcaHR7dSsbUdUUojWfvivJxOS_TQ_KNto_ed2LAnozHsVXjIlvxD5hlLaFJFWk
 A33Gf.hSs4RnwDufvtSOjtVQwVqh1VlcN.IjtILnAZyldj2.XZPeoprQIiaTlkUrHjbxvevUcq.D
 2.zQInUE6JxYuyxxOIYGdXwXxq515A_WCbzXi994szex1UagPPzajrqL1T3RDfMyU7BNzGBbIYj7
 mD9z8rZkTEY5zcg84wYjuwJtOKHMGcRzRDDJ2pgETq_xsBvaer6bGp4su2ZwOO8pLgj_qiBe0RFx
 6vV5to8y1LHMxLaMI7MPx6aphuQXO_6HdOpzk9Y_uiMEdjPEEmHCn5DFPo8yPCA7lTwRqtzCPDQM
 uk3sS786Vw0LXbLmBsWYV8GAk99NaJh2NmMlb92O.xCNmI5NRuTSfyJw1V1u6jAiYDNjlNE6QYnx
 xTF4w_x2gC7Pp2ZrtU_jquAhH1sE6WrvrN1TXZxcJKSOr.OHC.geHyBb5jhkX8P2vKJ.KaYP0RTr
 n2Et65eUlEphOuNZ_qJ0tf6Jquh9PnXRDyakAvZC1d_hYo_rRCHjKjmhvDOMDL7fJO8S4pQmTCQC
 e9aDd91YPpM6LdHtCZiTaLWFZvcCCwMMTviuZuzNbJTnE.1.9.v5ZbOWHLMxpILO0DFRa9zp3EJN
 EzdYpBVBnd64hYff9Uot1msTJj0q21Yy4lwokUXkHzOvofK9mSQ5TtjmfIK8iEdzfFsibLv9sb7j
 wdR35tdZJixKJf6qUqCdfp5pCA6B8oAPvnfxYZVo5fhqXWYGAoOlupFiXzlRqQKEwMQCdEYrOvcA
 .tj61QB0w5aQrM6tZ8wXt1ZjNYW2A9eKFMEzrBqNuLj0Kk1lYey0P4ADzXqtAK_OTpiCZDwCuInO
 ka.osTjhgIqgvppPZIBCgRWVuY1f2DxVhbb2qvNmKdazCf39H.QMROSB1lCNGNAMNZsEj99W3BcX
 iyXmi2BbdG.nNi8znqcjBHAXztwgtXQm31KCgZIwIWfk5MkxlnK3SaVVXu4u67.ekPy6y1vCKo23
 NumBuNEe3CLdcsnUBUyulQZuROyqqFG8XYzMRhn9mwY.uwFBBc0oUy_xc9bAceOb9sNYxiXqpiWI
 j0JhaPRyxhaIW0vh9lVUpnOy4T06j.T1v2tE9WoFF1OG6IsDZGh0CQbxj.yrl6Cc7b5NsaxZrgdT
 yODZZ36lp4axuWwl5RelFq003SDEd1hbQKpQspkDDvZJ8NuZQTLASg2sRe2np51MYaF0t37tlolZ
 bBrk-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Sep 2021 17:58:08 +0000
Received: by kubenode549.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 2ce910062c9f02cce3b80cae8d9bd9cb;
          Fri, 24 Sep 2021 17:58:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v29 03/28] LSM: provide lsm name and id slot mappings
Date:   Fri, 24 Sep 2021 10:54:16 -0700
Message-Id: <20210924175441.7943-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210924175441.7943-1-casey@schaufler-ca.com>
References: <20210924175441.7943-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Provide interfaces to map LSM slot numbers and LSM names.
Update the LSM registration code to save this information.

Acked-by: Paul Moore <paul@paul-moore.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  4 ++++
 security/security.c      | 45 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 1b05094468b7..b10b10afd04f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -193,6 +193,10 @@ static inline bool lsmblob_equal(struct lsmblob *bloba, struct lsmblob *blobb)
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
index b4af710fbb90..8ca554e1dbeb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -477,6 +477,50 @@ static int lsm_append(const char *new, char **result)
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
@@ -498,6 +542,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_slotlist[lsm_slot] = lsmid;
 		lsmid->slot = lsm_slot++;
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
-- 
2.31.1

