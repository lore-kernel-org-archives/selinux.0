Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5782CC3A5A6
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291F521874
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="PB5Oojsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfH2XaS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:30:18 -0400
Received: from sonic312-30.consmr.mail.gq1.yahoo.com ([98.137.69.211]:39018
        "EHLO sonic312-30.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728262AbfH2XaS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121417; bh=VuF+R1SSIeu+9VfIQQL5nQZN69AkuS8IP6jyAKY1P6I=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=PB5OojsqoBlN4MkA09ncNyc/7fSOxYAOtzGHUZLabbcN/fqmyKt/GUnBG+KHSi16MfTO5hL3Sc4D3O9g0FIMypWqCrA+AifjXD3zZgFuctdHFlhiS1Hk7/idMAyjcx3rWvRnuJ90QV7yQfexlDSONvdnH4dREGZ2W2SmzuiqeZwOsYz94bDyOFo1I7lPm9aI4Z74u6u+2JOxLSP3oC8F1F9epjOgmxOBQxX8FsL577lIJ/w5GAgYuusLjGFnaM4BRSX2vlGNV7lH99H6G0cRHwzeFk2vnsz8FuEbs69GpaPWSd8McjxBcbcaHkjiTQws/W17LgKgDPSCsQQ399sGpw==
X-YMail-OSG: wDCVl.kVM1nlmjYO7JxxWg3wKl_t.IqtfpMPhJn6GTIWOtOxTw7tCkkUbMCGuD2
 XYjUU1szFFQpIOPkZtnpL0NgixQ8r4F6V2qkelQ11Ak65aGgQUNiA9phcGKisVKE2GvGJDwSOkB3
 e8fep4Nz2qyqlc1Fcwyrg2yDN2UMQONH7MChepRhPM91jzHfpXaf7UB8VoOtb.VkDdG90geqlWQM
 QTGgBDZH1jX1iKOgJhNl.TYXEGi0T_0FcejW.eJ9xzeUtzwBBkxj4p_enwm1CqjJu35dIRIOjeQK
 4JBlyE4f8tOOPORDdze7gNms68BDcfwb.oCP5HHFX_CvEAfyqTVFReIrD6W3wbyZPFKxjYCV545T
 5XdvVaEtdPGj3sDqls5AK1VAprG83NVK9hs2llN58Ma1GqfjfLtYV03EkW83O40yFyDVytAtWkv8
 BCtxNKBIoLve5hdU.E__uclGKz_An5Bg8mrmyP04zbsmMHD.Jeng.GRQUhLeUwJC2c3.tti0iEc5
 MZwDZNaj8MlAMkWUUENak.XqaD5w3Ol2zZDt4SkxfdedHVnAMAdLEDojeENuLMv7cyvwnL5HTbPH
 URlJgvmv4lauCiP729Ih.FDSzh60M6hlW6sdjdv6auNkkANVL7RFfHg0WR7alGV0sHH9.GQ1pMzQ
 xsiJuTR1RImqiig0sTRDt8BfEaOA9XdAd3IEhrmlYcNQPvtwQmI7Ks3EPz7BwJJH42ab5yEau173
 Il1Vib9prDBgKnREW2zBVnyPI1D5LOhQx9aLQywAZEtZ3IN5fCL4BboOFTuQCjtEGcTZ8s9ppMYH
 22X.tSvqEUB22jpeiTXWDpUEYm7RiUWRyQWzXH6PeIB1uYsTxSradVmjIYulwiuE1PqsZPpVlyMG
 ONBEI5BRIevx93XNAitQMX_OlB49ChuFejau5lPbDL3L5urWUIM0DEMDVbYRDcexcffQsCxCtxOy
 GBzmuk2Au4JTjk3r8zz8J90_v_9.Hi8saOtHX8DqccJY1lL7pFv3wSnijM1fAVwy17EXeMvNipdr
 vl4q8J5.RIkROFjWH3z7240vXC3yCDkayqRXKzfsDI41Ytzlq_LEc.Iny9R2G9brqAaFvwdbL.TT
 n0Js2ODf1Ghv1jpfgTius8DSw2dB9Ye3WzT80U9jVNhRwwyLrm4bkjMshxXTSc1d.SZKoWtf1T6J
 ZXC05Vf1b4Lx4IsdXlgBacbIbmvENmMh9uiGR_wumNMnEvjqnB4.vU4agugN2KT.ld1C0zA3Bxxs
 tUW5Z6Q2kbC1VeySIejv05z7MOrRppRbxn5zOH.b0qSDqTOlCkWUly_rjuzkoXDEjw06sfLMTysN
 lykg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Thu, 29 Aug 2019 23:30:17 +0000
Received: by smtp402.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID f8639e220c8a96cf24b2b0474e56d17f;
          Thu, 29 Aug 2019 23:30:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 22/28] SELinux: Verify LSM display sanity in binder
Date:   Thu, 29 Aug 2019 16:29:29 -0700
Message-Id: <20190829232935.7099-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829232935.7099-1-casey@schaufler-ca.com>
References: <20190829232935.7099-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Verify that the tasks on the ends of a binder transaction
use LSM display values that don't cause SELinux contexts
to be interpreted by another LSM or another LSM's context
to be interpreted by SELinux. No judgement is made in cases
that where SELinux contexts are not used in the binder
transaction.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  1 +
 security/selinux/hooks.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index c16aea55be97..7fcc94ec8e04 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -125,6 +125,7 @@ struct lsmblob {
 	u32     secid[LSMBLOB_ENTRIES];
 };
 
+#define LSMBLOB_FIRST		0	/* First valid LSM slot number */
 #define LSMBLOB_INVALID		-1	/* Not a valid LSM slot number */
 #define LSMBLOB_NEEDED		-2	/* Slot requested on initialization */
 #define LSMBLOB_NOT_NEEDED	-3	/* Slot not requested */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 352be16a887d..2844f2ab7706 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2009,6 +2009,28 @@ static inline u32 open_file_to_av(struct file *file)
 	return av;
 }
 
+/*
+ * Verify that if the "display" LSM is SELinux for either task
+ * that it is for both tasks.
+ */
+static inline bool compatible_task_displays(struct task_struct *here,
+					    struct task_struct *there)
+{
+	int h = lsm_task_display(here);
+	int t = lsm_task_display(there);
+
+	if (h == t)
+		return true;
+
+	/* unspecified is only ok if SELinux isn't going to be involved */
+	if (selinux_lsmid.slot == LSMBLOB_FIRST)
+		return ((h == LSMBLOB_FIRST && t == LSMBLOB_INVALID) ||
+			(t == LSMBLOB_FIRST && h == LSMBLOB_INVALID));
+
+	/* it's ok only if neither display is SELinux */
+	return (h != selinux_lsmid.slot && t != selinux_lsmid.slot);
+}
+
 /* Hook functions begin here. */
 
 static int selinux_binder_set_context_mgr(struct task_struct *mgr)
@@ -2016,6 +2038,9 @@ static int selinux_binder_set_context_mgr(struct task_struct *mgr)
 	u32 mysid = current_sid();
 	u32 mgrsid = task_sid(mgr);
 
+	if (!compatible_task_displays(current, mgr))
+		return -EINVAL;
+
 	return avc_has_perm(&selinux_state,
 			    mysid, mgrsid, SECCLASS_BINDER,
 			    BINDER__SET_CONTEXT_MGR, NULL);
@@ -2029,6 +2054,9 @@ static int selinux_binder_transaction(struct task_struct *from,
 	u32 tosid = task_sid(to);
 	int rc;
 
+	if (!compatible_task_displays(from, to))
+		return -EINVAL;
+
 	if (mysid != fromsid) {
 		rc = avc_has_perm(&selinux_state,
 				  mysid, fromsid, SECCLASS_BINDER,
@@ -2048,6 +2076,9 @@ static int selinux_binder_transfer_binder(struct task_struct *from,
 	u32 fromsid = task_sid(from);
 	u32 tosid = task_sid(to);
 
+	if (!compatible_task_displays(from, to))
+		return -EINVAL;
+
 	return avc_has_perm(&selinux_state,
 			    fromsid, tosid, SECCLASS_BINDER, BINDER__TRANSFER,
 			    NULL);
@@ -2064,6 +2095,9 @@ static int selinux_binder_transfer_file(struct task_struct *from,
 	struct common_audit_data ad;
 	int rc;
 
+	if (!compatible_task_displays(from, to))
+		return -EINVAL;
+
 	ad.type = LSM_AUDIT_DATA_PATH;
 	ad.u.path = file->f_path;
 
-- 
2.20.1

