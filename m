Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAB2C6377B
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 00:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6098661249
	for <selinux@archiver.kernel.org>; Thu, 22 Jul 2021 00:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhGVAKs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 21 Jul 2021 20:10:48 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:39345
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229783AbhGVAKs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 21 Jul 2021 20:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915084; bh=NI6FKsUvIoDkXNNErtKrmSrGfiCcroRuNjTaXo2SEx4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=CNn5y3wvHvILivbqaVDXCbR/9IGwEG768l+5skJ8CZ4u0UGPLx6sJ5A35SQrjo711A8YdlRSeyjJzyOsCQdB6wipAc22DmzNIMrw+atccyH6SR5Pr+b6AQgCWBvfeUoNzuC85S1LrXeFSekv+F5hqX+JebW+kHTOvZ+uWndME7gGccY4Sor8paBA68B2qX63qtvlwFlfVf4nMsSGNuNVJHlw2nYpYv9YoqS+sFp9sHw9uZ93/v2UNRKUwgCGKpu8jTYHn9SU4+le4hKHSduyxTMJKnghQHCXC1sRgqJGeNeIXjh40M0gkCcugvdi8msJqjXJ7OIBTNQWPIcfNDSnJQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626915084; bh=ZTaVt1xnzzLxUdSM9f4Tfa9H1L2wdMWaY1J9IIKZ1rE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Qfxxg7lA6J8siKDk+5/zSRJc0N4H850XW34kYb+sTiIFhy/ZnIc1oje4eZ8meZ3OuP766hn3qCBuN2QFG8jwtmAGFEGUryTlpTTQDSpaptSQ5IZ+LRA2NyLaszAuPbJOEsdcgm4gULgOUm+ImsjUwVXqGwsKY6+D0p9qdrTtCwJdbLTtk7YXln2Rwd49SyoxylhbF/vDzr8zlOJ0zaaWECyQwe8+A1MHsPyD328oilyorFo4ori4gvqqOlI++OpyJGiVN+xxHnXUCcO1Or7L+sDCC9Dtq9H6rlfMakJQom54t5stNniEQCtYTISp35pbwB8AY31Lyak3obn+/I2h5w==
X-YMail-OSG: zcE7ZYAVM1mqNG7tBtzfGW82kUp8tBh4v0t7h.A416uYi10dAyzv6Sov9s6WLIe
 28y7GbKHgKq3HK2LEmuK6fXAZf2aZbB.vVk2Ful52Mth7e5Vhmk9KhmFdhrCLbYZ9iFMu6.hqPjC
 LzJWSqk38QyBcdiIgzZ6ApfLbG7WngiGCGQGZi9A9htVCOgA2ISIIA6D9xxrXdNSWFo4kb.P9sFw
 h7vp83bVyeAIDOD0n4GeyKRLxcnTfyusazO6yngP3Ndav_qwnvfLzStyI7SQJvO.mk1mqkeH18gW
 F5JxDdei.edBh9X6Adkra.7Sb96mo0xNdgPaaYQXH_8L0Qiln4HhBEUyhS.7AwYVy2b210g9Lldb
 Bw1QM..tq_q366yPM3u5ElUUbQGSqucU726_9AOOH_fW6XHou5oO9f6bSfD.jgy.qIGIc2qyhn2k
 hCyowrneD34dO7waRzAVgrqkA4_bOF_qciuzAp0n8ya8i9avUUleKibXWQXwM7SNNhxeVVpwp_1f
 Pa87T1GeEMUnSbmTO.nVe3C6voSLsDB6ANCptNl8Eu_nCxhUA1Plwn8dXS_m.UJ7LPs.6xBMEn4H
 kzth0hfB5XfMIM.YztUbK.9hPFJyNNUCB4kCeJaEKtaS27oLtFGsJ1LriR4dymwJoN.sCEsvBvD.
 _j7Z8zSmtrTeB2xwNWE2b5zvv5pmufMgtt2vvWGR2zcdjyLwcNBTNYh0quGC34Ql_yO8KGlLSPaX
 lHwKTCkI7KbUhv_4ZaQJsAHrwczuqviuDiTgmCMQXjCjtQknia.Y8VXSRlMrFQMNhNRRk8afUHsV
 _cWhSkSCah_zyYWoXGN0ZnczygH09VBcGY0HWGY687A8c1ph3YgXVH9kVVM9IzezV9774shS4DLb
 wmjf7.XcBXI1_hxpn6iVt7Wvw9Tk7XI2vZOkch6XFuPcuvav7GjlWgfSVOga92qFP0Tm0HynDT.B
 WhGURAFHtd9IxGAYIc5GM1hnsagSyT6z0wWZnTs4Z.aFScjSIB8aU5l6rhQOH.9AkDSoLENgZ_0V
 Hz1xkFh5fDaGu3VwMU8Ugv7az4zHtRPtXo2rKNN4SvEkxAzbiBopCGz.44CDziq88XbBYwK0jtCO
 cEQMqqNfYZNVBjBPq1ok_XCGyfQoOWI1BEvnB.xb2blCxcehXBVK.eVFWPA0VLGNlutvwGiNyHIH
 o6JGextiPzFWmd7K9aV3KSAYnVcI0D7D84ln4MjxDQgecU1SoG87NurIhfgCvRktYOwKdaIUPo0N
 vOLjlcFdWg9DpGxElmDhJ0wTqx7e0DFzMTLip8V3VzMGX26tryX3IvKMZTmIiHnSNDL84twrllHn
 _2spAfcsygKnUT3K72B8k2y.NbdMLZkoWyOfgKunduhnvHpxjaRCUqqNTcDQDPx0kKlV4fumoBPU
 kchi.I10d2Ktssnqtxxz4xzNegi9XaKV1bTzp09VXuSAuLvUj4sG2S1GlSGuvYvF3MBfGY2CDHVs
 4BmD47CAb7_eYiptw4ll6JKLvSf8B2Efui7v7IjiEetQ83LRyMjPCidDpIN03.YvCfUOyMoRYslu
 B0AFCGb6sSCoKUrpEu.nARHOYAQl8hAXOxfpM_eXU6ur8ORw7hVmng5I3LQeYyPcnjv87Z_tyVxl
 W50QF2G2uaofhyxnDEyMAbh22LPFroCBUyS_DquPoxNZrUSS1lXZpqKMNxjIQse1yr8S0NaXwUhd
 vJs1KkSev7jWPZesAGPkHgxKPJ80qxmj9gWrJzgymvr7GyKSIU0MMdSWgEhB_F08R6ilYGB5C4Wc
 LdjX8Y9mFzh2SIaMTTIsqS26IcB0gpm.A4RqpYYeR3CyGyzCcIht9fIRTS0P6PyPk60Y6O1zg1U6
 LkjgIgTDcxHi_YHetJdgknMu9V9x3OV5ZhypauDHYDAAEtEYUf8_ad3AgoRYwkezJ.M0hrZSW2ni
 963rsHCgpymjyw4vxrR08MvswJvaXk7PpxajBf6SeuBXTeS2dTLfbpwLu7mshUQpB1miSMCLwzW.
 dnO9Bwxg36O6n8VcUIihWvz_Wq9NHUy3ye8wFZ4.0oVAyfDPDLQrFdK7sLs.AMARZYBQNwmnENX0
 HxuJfjxuJRSWg8smO9HDVO91wpnpHZ6Jw_bNVs1ns92nTB7z4wkx82pvHjVm0x87Epq3TGQDliEU
 iCBGyR0IQCgS9g9kb0896zxgcpKs6JRLoUZQ0sFam4kA4ymF5hOeBf0lv.w2DX1Ngqwi3Lx7bRO9
 EGoDSi49N2LLoX4OZFVsi_UzvzKPSXKITutHkeGuEJ3iEcjpC13Bh5LThHOy5nDhBjaP30L.TS2T
 7HFoagdlZuBJc64b4iO4QjhedMtEsTx41UYnYhxFxm36de6cvRc5xu4udMW0nWBsrTBnz0aRUEEP
 OAGqdsVB7uJdNUmiijswQju1ANfYSZ_GXVqZNdsYFYMt3_XnuYzwyK3Bf_A7rx0Px71HigB9tdRn
 1PyjhvpDWXWYxx_8Zi74Hz19LGiM5wE4X.LpP9yxDDjEPUaaeW.6peC6CtMc4r5mlNfohoDXDPbO
 8a2UPjm_wqmLJCnMLXWWND..IJaq_nlFdTc2ZWvg8LA7AP9PZW1AtPeeOdAD_QmyOOec7hkbZSoF
 bU0OXlF1xc1PfPgtFDKvoJ5JttI8rsiT7qklsIpw0UwoDW8N4kwWfCXCv_NReSgjxJRsr7qKFclR
 h6wkopvRwUrnVv2BKhBDay86iTzjtUuQu4P.mOpolz9POW9YdepCPT6zzTzoFPEde2YFHmup4VtM
 MO0IBrZUqY4G.36N4CsG.dge5L6PVK2dth1VKT.dYYqse5yYWHY7QlOqylmlJ0trYRqNV4k.yVpe
 v_tzFwXu82wQj0UD4d.qsWiqVbV9rmXjo5PYGe0lU1lxHEfZn.2CLFsEQJDhWP9azQAObD2xMucW
 0xxDDlgdsuEQA9cPj6VlkqENIZPgn6H.NTjR0C5Kt7M.KdKeyCVvNuR6rHSSaM.5KSyRVo_LVxm0
 FaPrG4EUAqxspPUucYjeA_DObpQaF5BcyzqDWI.yjsBewloFp8PXhr.R4tAwTRMMxkRwEGqICLn0
 xcL4JiTFJ9p9H7A2gwtnAsiRQSl_3_c1yMelJVuOSPACQ6Pnd5w--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 22 Jul 2021 00:51:24 +0000
Received: by kubenode537.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ec01d48876c35197f3e77f584a50e351;
          Thu, 22 Jul 2021 00:51:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Subject: [PATCH v28 03/25] LSM: provide lsm name and id slot mappings
Date:   Wed, 21 Jul 2021 17:47:36 -0700
Message-Id: <20210722004758.12371-4-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210722004758.12371-1-casey@schaufler-ca.com>
References: <20210722004758.12371-1-casey@schaufler-ca.com>
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
index 7655bfce4b96..b641b5b96860 100644
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
index 5f1b281511f2..3da6cb8f9d76 100644
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
2.31.1

