Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608E3C48BD1
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A2B613E3
	for <selinux@archiver.kernel.org>; Fri, 11 Jun 2021 00:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhFKAKC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 20:10:02 -0400
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:43984
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230321AbhFKAKB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 20:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370084; bh=vc75HBdHrsxBmtLktLZ2z+T6Shh8g9//phefY7W7K1w=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=SMdyFVvIwgjRmeyxotY+isB69LBx156QOEqD6kf/y+sz9iQaPc3jwK7r54ht7/RVg5Mp7SUWrh10w5s/7sgEu1UHPcgQEpPniw1Zjs8p7aQkA6W+8z2S61lYRqYarB1psVzdgP5e8Pc2h9q5OBmbDyGhq0dXcfe5f3MEg6NRLU7+F5bFXJcGHqMdWFSsg8A505OYoKLPNe9TQafYkUZg92Z7T7FK8V6mJoVMXQRNO1aOXUqnNkT20pflZrkdP6IHU3J1ogl+f+Q4hr14BXzB4ppPNn5vhojiUr5cPuwoSmmkwMZQ9bDHaOXM17Ezm5JlMgukSLSDom3auu5CQ1B76w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623370084; bh=UHdg3KHqipkvb0tBZwIhJM4dZvAXU8WI1JpHoQS91oC=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bq//Xz6qWASEgnHLWLtVva6YaQyJDCMOA2kmCnFAAjYCg8/Oo4BxV6glFhH4sPGD9+01j4PSKGfOacC+DfyuUO4xi/Qhqb8WfxjYu+T1Xetn/K3Uzui8U85ON66nOau2ImEnMWmMdu8cdePBtbLFE8ID7OnADyZrbAUN02BWvt0UgOOUyHzyQSpkzL3J6RcJGKWOqHsZkdz4Hcv77F4ZqiTrMpFRNbjJp6KO0NfHqsCW1GMcOSo+eH95JIqwG/XfeZZS6RsEu/ZU6SeMSrp/iL/iQrJWIIt/MqjHo56OaCx04gbJ335E5PSCZTpWscmwDDsQa5yjE65HuUh+Laq+7A==
X-YMail-OSG: uNTOlvIVM1lLbkLfAaGd.uxvIDLd0Ie4kYQEqEqvuNEufkgWoipLW0v8.3780ZI
 31oKT00RFWgTbi3txI1HGm1lJh.cP.ITdxQab7b.Nvk_R6HR_LZabOrSX8cnoqUWUOlxSu6mf_lg
 14xJUUyuc.qhWxEnZU38nd6lym6Q0BEL16OrFRoVLZ7KhJtyVPkQPSA9VmXmUcXLqUTvh12405p2
 pc77cJDoWksislZvMOSCulzK0LpGwgEGYSFLnIijXClpN.HYnzMVcGfAm9Feqh24wM7aOQldN9UN
 ReyjoXHuRA7M50ehh_jG9jiAdhyIhcNX8FUWqLw1mRo6r3ahJEm6By6fB_VRSU00Z76OSsoF6V90
 YOyMl0_9SMBAuZ0x91TrKqzYdAlPMVNdYzDzVkvKhnmt4XOKcsmmPhBeQ34chLE8PfntOYC9TnF2
 bXM.yYItqUzMRYmP3cC4M4sAQ7p.f9CkvlpW.VvF9MBKJzPaXfRz10N26IAFe3aSTolW9h3YY.jH
 jT2CkROaG25ukDBc2GcTi3ayeRpH5DZHS1mwsBNjpAf7wM21f.ImVF55BBjbDjrcuIOd2.YVSNhI
 e.FJwlmWIIIkm_WxBSxUzH8URe.JM9aqs9byMu7KNG3s91aFUn1vhGZVI02Vu2U6wxjjdWIjTCo6
 KomCKoXOnXbHnNEXbZ9p9y6UPy3ogTEwXDHqKeB6wOuLJukoYMQEWdVOMiES27fgxWTYzJSn7PAi
 XW7LaZI4Jo.3pHbunCsBQLXdNBf9rd_Jw4jd4RMlKH_JiT_zpM_w2eSPrZflEkTPpg1OtBM4nfx.
 jq58veCZkfc6iEJ.2lRjYnawOVSb3bBWE6xlCs4oFOQDbaT1_73Iefy2RIrtcqCteoAb3f5FMkcY
 jkhiRpxnz0Nh5zcGYRB9ygxG5OLPJhJeGeEM5gKDoLzCEOGrojM53AF0gaD0Ld3OxY02o.nWsjrK
 GZmmSK5gUHXu2DrR.OAr1Tv_AKo2xjSFqyBYO7LrETjRoPaQJCBQiuKbWKqSnGGHRIrD8S4fO5s4
 su8XB1WaaXWqAk4rjnbTaZfPYvmMTFfa_oYHeLAlo8pCLknCfz4Hd3VLsmmmGC5prttByTFawgsg
 Rd_WNF6aYQX2vD7ORgvBd5tHRB8kC3Iw3v4Vp5Qd7dj8d3LzpCX2R3Dho77qCmf43uoxkkMgyUjl
 _lyOsVVbi50s4BXhUx2cIJhe6dejBtMv9h.fH.uxCzG.Mjv9uzQZDcncEONIuYiZi1fES9Nx41iv
 Gn9EGz0_.dmGB0alsLINSEWGumgQvxffXzyBVWTS5kKaoxtn2E9BVEr0ZZkvDJTwomnQ9m.vcmSU
 BTpvVEtAZQCyiJSfp4GVNacgz3oTIuhpSeMpH__XKqlHJ4LxFp.Ih_Q2V7Q4vuvlJ50pv2TukNyF
 Lp1tE77Hd6wRnK1QYnWVPUvvHv0mNyUIQH43Y7zk_PSaxLIbZNtA4I0xLGYIUI36q2MZWtOxIzZS
 qIur8BcGGUjYcCmcBvzHUcUsd4Ohx_PomsxLVAaTtLd6csjBHLIHmG2rgXV_XBDXE8L1pPjOXgY6
 0FelaX.DdnHfBdP0XueKWBaaSwUJHz16NBMREPc21Ud_MDr9r4PkqG.NGRyCTBDvnc_9pvSOLNcz
 EABIT7_BwwXOeaXF8PvIqmWlR0xXR2XbJFUv1H4Jfg3tlNygqXJauo5dmBAp35jrZsZrqDy2VkMi
 xYpK4BL3DTwo41HDnI5xByytIz8srg0TsOQqz9bIuosu.fjfe_LgYxvItKwhs06_A6BTx04kMsbR
 NRFEQdws.X1_v5yLZLE7eJX0V05Ks91DnDv96XqtYV83mfHSTXVbYJXoT_bveuLVnanEdUsh2gU0
 ltCbYCX3NvtIKfVMQITAdrWdt46Pt1KFf8zzPWF2qmRrwODTzlT4PBIzPUKcHcKVd.1MhTHRnHBS
 ifT9Uokrd.wsGml.BFeIlQiS.9OwwXNmoOw7zVeJnyMmqBmE4MnT2CUnzn0wi8fT1vU1SBx5Nuy.
 gtiU8C1Q9g5LYZLDnmxRTtk2sqZervGmJ_QjmsQclU7nNXPH2ufrg3Zs1Jb5NXWdsJQEukxGy1Ls
 m096jyqLa_k4ZVZD4Kml6U8.hiz9dwI.v32zCzRc0l3xY28NwPieDKy3J9YkOyzhFZvQ5T94yYh7
 TbbFprK1L62njeRXald6X21FP9ZTHpt_sZrooPs.FURwmKqFqko_9.UtEBPNIiPsiNTA3qFX4..J
 5zuzRvuCqszO1pyDVSa0hMngzl0PjXSqeLk9cgwpyudwJqn5CHB1jkNi8DYJ68FSTalYNusM6wUn
 o3EOIwo3lKVdMxe5YeQe38lDMCNMHGtU3YAekrAPu3KljI6Bv0O1QysTTXVHfbLJHwKnmALXMhhN
 OZe1M15TGJ0MefixZOSFhTiwtpfb8Lpajb06_LifIjXPz2_wlsrqVXNVpv8IcSjZbLv9xw1aYsNl
 30ouS28b1OxfdLOyvFCdxL37BiuLcJiztwg.l3_m06VGj9fSQovf_b2s7DZwQmWHGldSPe_7Lifa
 nSLaFOd62PMtkiXY2.2KvfO5RkMClIIy0XYqG_FpjgdACVm1NAVCJrO63YrHNDX4JzP052oP3nHh
 yf54Wc1AppAq_o._pQPjdvqBU86s8aPlZCdyyoQmXN5kn88d90YjkA3uB_h3hx2e23d4EH5GfnPP
 TsChLH0AbQCO.iQ7uSWNmEH7EAST9ZPVK1QUW6gHoBQydswcgEbgj2mxzkZ2zmMIQKPz16233Xi5
 gSgEX4wJfEzFm2W17L_vR1VvXWjeboXyDbuQ8kYUdPjRKY45Wjf7LTwvur3LanER2sdfTE2n8Ap5
 enBBwa9WsZ8wLJqZwRc.VEtagMH8jpwJpHrIiRxXywJ.9oOle3gKNMKQpOHYoMel2rEamUGRAfjz
 HFfSKbNAn40XkF6NmBu8aWUrGqFxe0UDG81ZrRaf96sNdDlehCc4FIQ1iZXZPHvfUWTUEU9M6rVr
 akDd0JqbYj5IDP2HSU8HSZOajsPMOT_PNYFSHBtFn5Dl_O2IwApE94C_TUF4ufbsCzK.cfacZJ97
 PTCVsj8PJnmxwpcWyhjO9jdk4IUa0nvQB0SmgFoKW8vMCrg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Jun 2021 00:08:04 +0000
Received: by kubenode502.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d27c7752e1fb9a4c4f97207b6af5182f;
          Fri, 11 Jun 2021 00:08:03 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v27 03/25] LSM: provide lsm name and id slot mappings
Date:   Thu, 10 Jun 2021 17:04:13 -0700
Message-Id: <20210611000435.36398-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611000435.36398-1-casey@schaufler-ca.com>
References: <20210611000435.36398-1-casey@schaufler-ca.com>
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
index 473b49971aab..6387107e4014 100644
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
@@ -497,6 +541,7 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	if (lsmid->slot == LSMBLOB_NEEDED) {
 		if (lsm_slot >= LSMBLOB_ENTRIES)
 			panic("%s Too many LSMs registered.\n", __func__);
+		lsm_slotlist[lsm_slot] = lsmid;
 		lsmid->slot = lsm_slot++;
 		init_debug("%s assigned lsmblob slot %d\n", lsmid->lsm,
 			   lsmid->slot);
-- 
2.29.2

