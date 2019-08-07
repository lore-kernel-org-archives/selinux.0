Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21E9C32754
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F4B2229C
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gYPaJUsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389196AbfHGTo4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:44:56 -0400
Received: from sonic317-26.consmr.mail.gq1.yahoo.com ([98.137.66.152]:41586
        "EHLO sonic317-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389191AbfHGToz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207094; bh=y/mPhKNoq6nbt3w7HpbSUZG3e7LYtWMMfbakz1o/bfQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=gYPaJUsjFTfFKYs9Oa/o9c0L9lqQu7OHF2Hxb8QVWWcmmHOjQ58I3lktzQgwY5ywYc26VpQ+dmneCgk4O5hisJHjpLig0GdMgcbtWnURo+u0Z6JjlP5g4mvKimDp3LIDgsEtbjPc+E8QYzdxjLI7cYqXjAinG2cv7ZVOzjDb6aDGV1q8lldWogQnG+2bcAk0ea/RauB4njMrQW1gwIVicAzU8AEWUBFYbJveDvojfVA+qEbaxASbdp8PZsJRC5j/edhQsuEQa7bDMAfLt6GGl47F5EYBcEEyrsxcqH6Z5Nituxzdnh3fFgJBAdbh6XxsFSKjPBp2IVgAfRmU/eduxw==
X-YMail-OSG: Dc8Sc8MVM1kFc7lEHUG7l8QRW5YmuCBr0Tdd6rOuusoNCMv2PI92qm.6lSVRUfM
 iO4RWLvLSIQh_YrfBFACJccNaprW8VwV.UBruijUPK89SHc2Hc8a.aV0koqLRnWMriMhtFaXjvdf
 5LPR7TotA6Y5n8__53fQ7gIUoqIYL7tofEBjKG34iQww9Xixra54Nwiy44cgvT2RIwdkTQUxvZ_W
 eYzaLs_NlgIBxd0rmevtOiN.ZSu1fThQjnsdUzHrCEc2RX7.4LItPEIS8sWRdodCpDFRyqh5ukDu
 cLayzNn5APxZCMOUkTH.wi6vWSHJ1DajmA1jL3Dpa8GAZFpDCkk1VmUKWMv8pwhBe_E.DOGwyHBM
 tuxAhAqZ2H0Zw0b4YpkpTG8p9MICx1zTUFyTN.MN5dY2jU.EfnieNGcXLSEHeFXSTqph8e2XlSot
 MxXGZrHsnIJUusTlIuLyS472TYjLmZ2hC15bMwX7aYtbhO427M816.JlcIDDbzE73zQ4FTV0A_Wk
 kPmMK5yMcEnfZPtx0nVlt3IfxzFTlaa.zVpX_TSp.G7esOEwbr0wwY5owZVo5ecvpRgRX5Z5Bm7s
 bX662gxFPK8N.v7lPAcK4.njmGudAtuFvVjhESxkDsOm2oEOM5ywuBB62_143EmyCsRvJ1ROSL.H
 NXGLTLptlaRyleFZM54UwMr5VJWMZqG6cx7ZqyiuWXO3I4M9oVdK_cDeTYjtpRy_.medBJeJRSxZ
 V7xAaOtFt_Uq.5VXGTP_0Jf2AW36nHLE6Bzm4ErzkoahwIbLb3DFAZVrjXQbX_fkUfEniH6mGkl7
 Bv2ezG8xU1y4NmTiO_f_dniK5Q6rtDLPmRC6R1rrCswMlrJwdykbE2TsHPjUC8wwKF1PXKE2xCmU
 gI1ujel3evfsRYRNQmZpM_neSZCWgJo8e84_FSm4x6Jq6faJC0P_MWD.Y49_VXbuxFCsLsTtpT1U
 u0zN5SzYPg0xwZV2iw70YtWHITCuhpcUUlXhYyxlzM7NWzwb083zGDjkdLA80Ei3Qr5ur0bRNj6I
 lsGc5JrruUTfIC0ZUgYp2UvCpKCDsNykZgF4dcTGLG3MPqXXKcctBhSiVlk7ssJldZaly6.pvV7d
 26b2sCs289Lm0G.IWXoB73PAH4al27cfrxeDQLhU3vrry6UjdZkwPkZ3WqsOaHL_siCBs.D5VhJX
 vbOHAvkxNjZVLj8sUc.XmgatqXCrHNv6XQ_smXNlHAFul5OQDpami0CtOG3q1Iw5WAfYv6c0Tprx
 8py4fJIYO8GlnhQjR6y7YKm.xIXtrq0N0k2yxf0S3_zJw64giUFDLZqdkIjt0ohsXdj9.aCcgQ5p
 L
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Wed, 7 Aug 2019 19:44:54 +0000
Received: by smtp426.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e1e2368a1a71816f77f09bb43c177f80;
          Wed, 07 Aug 2019 19:44:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 22/28] SELinux: Verify LSM display sanity in binder
Date:   Wed,  7 Aug 2019 12:44:04 -0700
Message-Id: <20190807194410.9762-23-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
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
 security/selinux/hooks.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 352be16a887d..fcad2e3432d2 100644
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
+	if (selinux_lsmid.slot == 0)
+		return ((h == 0 && t == LSMBLOB_INVALID) ||
+			(t == 0 && h == LSMBLOB_INVALID));
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

