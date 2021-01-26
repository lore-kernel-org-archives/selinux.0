Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A74C43219
	for <selinux@archiver.kernel.org>; Tue, 26 Jan 2021 18:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AB22224C
	for <selinux@archiver.kernel.org>; Tue, 26 Jan 2021 18:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbhAZRXV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:23:21 -0500
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:42186
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730333AbhAZQz6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Jan 2021 11:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680112; bh=QhZ83QJyQqzSmvmwZ8sIhqHvRsC5fnat22jXhctKw2g=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NurB3uVgSR0BIbXvGvUO8g5lrYp6gFqsg0PWGTFtlgeSF5QlebOK8PoUWhB1hB14LiJ/u0Q0xNN+zYFIBFZ02HC9sA3OM6lWbp6EHlz9DKavSkftQC/Bz2Sho2wtD4UNGpjmSmjuZL1+USNmskI1m7bc/fqkpHRn93nAEiudu+JzjanE1LrtG4K/GlMTc2Y6kBZFOfZIAR8Tkd236x1Gn2AH3GhVok8rjqb/ziZDGgZLEPCWv+PpuAk8XKEN796ortSrPvYre8WsN2uZzRo8blbRcOLCx/+lwVaKkP4yFcYhfeVfF0LOSTQ9gOhj0nUq/B0r9Mb3bm28FE5FLMQIdw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1611680112; bh=gUm88rG4ePIysTXD/P4inWw/BsAkGDXTXGDxn8sSVYQ=; h=From:To:Subject:Date:From:Subject:Reply-To; b=jhWTNZ1T4G8HtBcIPw3NjKRgylWSBo2vlMbkJa5bKaJbs8yqeDZfAcJx/n0ALfRIZhPLpc1lohyOf+QHh2wzCK2z8ZZACJL/Rpqvtzlar5sN5pZeb55Za3ryPQ8TzoxcOMEzCEh+5p24Sm4ua8Xp2GKqMa6BihcKGJVQiM16EjDBJ9nb94PLFnwZep0OgKU6VORp0F4T5+Zuwk5UN+7WxC6oQhg+zCluVypQxX4KvMFpztEz9ix7lFyDhsSLzdIZV0o0+UUBrZe1eYEPviQIbacDvuTBFbk/uDAlpVF3q4ke9IchNbOzrhp42u1DBwOq17oHzePc3Z77obhzIQ+KwA==
X-YMail-OSG: NC79Fv0VM1lH9HNO2chcdPJNBBpM.6GyJ8GW_0Li_hNMjxLy19W6Y6UyOHU3_m3
 HYHiGBx38UTfa_Dqc1hS8H7X0UfopaUJsfTMTcLRyN5W_DZjU1O8TNdgBQzoVt3kedxJg4S1zXef
 YAUak0p0A5yyWuemHn6fS1Ek5bzOLlKW50pM2zXtAKIyxYqt28tYIztHxEA2X44OXF63T0uwPGy1
 DYqkjDrAEfAe2toUcx_fvxv8_qCB93nyU2LxZvcXfExlfHfxTAPdph61b.ZYhGw_AApy.gKj3bw6
 9PqNlGskzwuUuJwB9PMLZdAny0yJwKKWU4bHDN0n4iu9yu6t_N_v9qFqFSgrVKRYDs4DZ7gHoize
 UOGxIV0gnjBovHA5RlyZEBph.g7zbZcIyiKKQrxoWNI3uICSUz1fkpd9tG_.GuH7_m3x_P7zBw_G
 tCdyLSdlt90pG.liiXm3f8dzTK0oqofO3opG_CznEXud_ShwNbggH5OCMvrnrn0ekr3dn_IfOxkk
 8arBaN.wuR604LetDn9sA1l8SUVjzD3qFvChydwf4uyP9Fr4FzGJpnuC.TH.q1Uo6XFG.OAqfu4Z
 zOW9XTH7hijwkL29LE8LEH8Dbk2Z7jRC9dGrfeys8ROFuBKD0FVYj9DRwNpKTznH01INyzHudyGN
 K1m2ZIKRCdoJsLAHBlXxMud5VEZrNi6WjGD31pjD65wpNS_fBGYAnwK_ACkC89jmulQ_vdzGlEcK
 RYuCtlBowX9c.3oPVfgHnO_QMSZev16saqmtBdSPrZQF_dW1.PlsHSJvdngP5W.dzOLruhkP2DsQ
 DCj8Ob6CvClD_EJgP3ZYaH8nPqWeKj_7lvsWF0u_E5Ft2.yAGpZ6Nz4Dptgz5B8HM.vc7a1KQOhZ
 4z0DnhH_rhUghyhR8SMWeBU4Y8vbEDfQN6lsKohqdDHAxOWqOJkB1OIHCfmhGXxiUmdWC1c0d7x7
 Cg0VEaLvY997MUG4u8r2bP7voqQutrfUCmRzO8nm7l3L9gxN7JFWhwor9I53QWwzBvy_rV6qKwsd
 BXc02uzrfFwm4nVm.GJFfuEbMsfGIGVi2idD2_S4uUA3oAVaI3FHlStXnKmiuvCQpe_UF.UGzc7Q
 .88yQrmpXaJsd4ayY87EzdZa9q1Sj7xs8H8MUQ19A4Ab7E3kX4PCx8Tgd3BoHmSE7Mx33JbVXtrC
 Wd26b.e5OEtcU.kXzvPUPqHHW3637stwhuq.reoUZ6xnKnRW2kgygmxLN3MHC7ffKuyWaOk8M.tz
 X2duwed11aoVMU2BLndgm3rbkznhpkBoB7HOT0e84An0lhEOLxWg1t3emKnMOgGb0HHgn9XQxYbW
 uBxhGSfk7XSrnhCOsjhldLTZKAsji5JOIXkRgdIyPGDkPwV2bFd9yPsRMRMvJwLXa.gSZBnkKjQO
 ZHj37HtfU7I.DMUPHVKO.mDDTwbMIHi_jpey8JMYXQvX_NE_y.3DPxlWOFFj8gkjej4itur_N8TE
 SSEKYHUyeYcdxLXvwQKP8aPynCl_SaJl7h4gaufmUfEz.lhVdtf.aC70ZA_7pPtSMfx2Q0EPm9..
 d6WisVM9xQGcQ57HRwBIFzxrLAUG9nZ61WFDyEFQ8l3w7pfwoT6EwgbTD7vxcsSCgWANDliYAEnz
 e8peTIoo6g9XXOo78y6.9ebgR.g6J1B6MCD5pjjB.r65wO_m0cdwb.BZSQjl2eYcZNBkwHjsvEDm
 BsFBEVWEGAbX..8VjKSI74HqB9jeNvbcHY9Y46d5bWmxXQtBUt9jieaKkY0_wkQ.0e3GU7xaSdid
 4EA.fZpQhJNu.vRLpJtbATNrGDG7w7YskJoeyem1pr2t9FliNDA8953gvDKcGH12r.eJJ.ybK_4c
 AWjXEIlAzkFZWJf8BNcwoFnWKM_b44cH6KouOkrfDpxmifAS2JJwyKhaPEKRR1FCilVlTm.0jD8F
 XKbTVxE3HZyXpxU6YKOKTWHt79w4ynlZkP4I49vkwQyD.rvL.kVCjUyhurFR8girXVnYIfmS6Uj1
 rt9lJJXNd4uGf1q9LFK1VjK2F8flLhgkI.Im9CMP3e2ymUNxcKchBqaOTR37Qo7.YRhIe57tyb6l
 TgOGEL7Chw_1T2zsaQFA9c4oQkkG9vfW6pHcYTtoOBD.HtFgBJB_LaIEPqDayQ8cfxijZd6URzLz
 wbZBQ7N15j47GHqroyC0QUWkayfQdYgGab_QQSgzdAXG7mCTkrFR27vbPNmW2kGT9qVL9nrOdpBS
 fQExJCHay9OdJk8qHD8QCTaFhtrZMr1gHUQWeUS9tqADYO9h4InL6.o.zCMFfndQ3OCNixCRbVsc
 8moTfH65PhUDgmUqToyB1Xk.uQfYRwOb0It2uaFJezYmSUmC9sVcpUhn3iEfadyfNwrF_B22JGC1
 Ha5Qb7S1BB7J_3Ste5zmxd7GYdPDAUcMR9Yzh.jNph9TfdU0EMpK9zD9dcfraANqlpa5hjxFhsHK
 VcL3dJej2PAHMVg_wtps4ZGf1i7yAxoUPLCd_FSqchzqcSyrIZpks4WEj3AReNJhMARBDQHjHrg0
 dEIaRmanFFoeoNbwJ3PoLOMjX7.8t1qEReGHBhGqbf58MW8UBHiCiNyDm078_587xWaJiV27DyJ7
 9t4nZxJA9Y8v3bJ0o7qCt9zf4I5XNAZjA5lb0CyfbhuPTt1MUsInxkufbL6ftFRjL4b4sd0mSW7b
 MxNQCXo0hRh4vkO5fct_fDulMtXt7_LSZCr0_r4qaBkQhQosvky65DjTQJWtYslI3O6FGrEs0mJD
 J4j8r2EpK4UyWfq8BtvEiTMn3ctLoHNqn3TtiDsYPtHQPItcGqGgoEINUjkcr6bF4SDVBd_.ITSJ
 j6gWT8.0OU_NlOqN938J2NiRmpTraMkOtm7.YD77KCeO8RwUs8jvL.K3F6.OKD7iMAZIw2zOwdbH
 51X0VOu1xSV9LJm_lvhUDX7oy776hMARSdiRrT58wIzSMkheaBUSc2TnvskK7CwFkismwCb45rC1
 ZRIQy11vRjv2Zv7LmoSWuvyCJ2NM6P5vy5t_0189IntzXJr_1FzZepvJ3WKshCeSXMENtu4_10r1
 ehjNvSjWOkS5DbZzOGgWY4JFX_0yb6g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Jan 2021 16:55:12 +0000
Received: by smtp419.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 013cd3b533e951467ad2ef403e668437;
          Tue, 26 Jan 2021 16:44:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v24 03/25] LSM: provide lsm name and id slot mappings
Date:   Tue, 26 Jan 2021 08:40:46 -0800
Message-Id: <20210126164108.1958-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210126164108.1958-1-casey@schaufler-ca.com>
References: <20210126164108.1958-1-casey@schaufler-ca.com>
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
index 4a109092a8d7..a99a4307176f 100644
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
index 39dce9eb3bcd..05ce02ae7c46 100644
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
2.25.4

