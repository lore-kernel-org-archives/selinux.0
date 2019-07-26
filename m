Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4815FC76191
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D83222BEF
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mmPyax7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfGZXkC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:40:02 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:46763
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728099AbfGZXkC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184400; bh=y/mPhKNoq6nbt3w7HpbSUZG3e7LYtWMMfbakz1o/bfQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mmPyax7wKHDvoVXTV33pvtpEEwHCPSnkgKJcPtML6y8j1A1ZLBCop5f9Iv4idgj/RhvfC94eOVB8EaMQfSeSbKslm2JfuC1BJ/V0hy2fkvR8fml7kSdGnWycftxheWhx+vRFJ+5pBldpxdgLNgU/zzv9QNXxNJhMcL0WnhUAAxO6Izrx4Mne0Fyxqvhe/NbXVI9GlgJhocpd8zvOHpj9dmfjcWsr7/YADxxTbXUSMDDH/K/+wGYZ0k99BL7SWazs/MSgHdIixj5h5w29t11CSRtv8E4FlylNs1g3Wa8nQpR38UhBEnZG0lSIL/SG4xksA2tlXbDMgwjHX8j+TPMREQ==
X-YMail-OSG: k2E21PAVM1nySLGGxXaAqwtqtcdfA.10j3cSgalSGiUkALw_b8IXa50CS0pWH9x
 I404BEtUmsG6v3rEzMM7Suzcj4Hnr7Z6FgfFSTa7tAc5E_OxHEHuHSZDZ9wiCQxLe6vFgGXWngNM
 oqv39hlIioOUcMzCPDibPtJzZuu8V7TKXNQYUlAtMgDz7xGcjAVi6Ur0pqpBcVHz7ZhIZ5mVFQMH
 wTlcXtQUHu83GBxtCMkQTLyRf0R76yvJ70ADutexy4Y0PMDd_fDyzI5boLW_GYKOAqC2wKr_0Kj0
 I2NOtoDd7.S1BdsTWxnOGI9miHk.p9H8RDoL2aa4yf.qSlaqA.qvR8BQ.0qHzYke8pj4xuH9OXI_
 Q4bK7BB_P70XCGhCj7YM3srURoFYlarPAjrloXadO8uj.Ad35o_mc28dh1WwTs0IqJCvsoNhapoZ
 OBS54gtDXUqg1lubQEACe_GlNPuDcIs3U8_2JotkJZbxiQBOU0VeIpTqYKJEs_D8dVB7TpMIoAWn
 dMdxjpSwA8vC.XahrulgqjYeDI72QpU9fa9FquhdiCCchIMerVrkqPBgp9CWSJdvvf_.eDAcYhK5
 pNpoTTlpe_YBamIjBa4bgcTu53xpHyuXYCyJ.hb.3FQqyW2PVuBhW0BmoIEQxwdnbUFTD0X1ejLW
 Qsl56FlAo2mXbd3TaWorjx0MX85OnBlE75_8v1mWQMTmtUccI6nlZnBz02AymuZWV56iv1psE8fK
 6mzbqs2o5LakFepvJ_1U4DlkUTv6LsmlvXqSs2haNUZKjoNqOQW8_2_sfJnk7egOFUvWdwN4ttYY
 Wzv2LJDXdZykG.Wtsa3lbfpb16crLfraVJJlL6DfiOeevfU0G77kT6SDAmx8eh31PlWpvzKSzZ1U
 5g.9SQtq9QegziZxVChySNjBlL1XoyRx_V13ufiZ6rxlARZ8Gv8FzoXG3cdgS5MsRO4pP0bOezBq
 qrGGOyVxbfUHcuim0vqhdRZUVoTcKaWTEXCF566R64wYHTh3m2UtymUJ9ZkvGt8vcIvjUgfLkPXR
 a_3U_mo9jzor3BnEvL9Vh47ABewjVSHcMc2vkrw3bZe.jayGltLmMMoVo2D4ioXbqq59yaQMkGl3
 vwHEHsd_KyFFwWUUY1dsLLgy3p2AiLs12PNbypm5aQqrovZ5Ph2VqYE5vruv507PjdmxEfeVLSwe
 AJPOP34Ha8OyMHm3Qt1JwA_bN3L40eGKQz4tnnnsi.pUgfR4GiY2blRi2vKXhxLkippc9PKQKQTr
 CzFUOMqyoMV_mbFO2cTRuVlNBzqzh2PcDo5zg_6wgQYH9Wejfils-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:40:00 +0000
Received: by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 18e1fd6e499df9a683528f197f9ab77d;
          Fri, 26 Jul 2019 23:39:57 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 21/27] SELinux: Verify LSM display sanity in binder
Date:   Fri, 26 Jul 2019 16:39:17 -0700
Message-Id: <20190726233923.2570-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
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

