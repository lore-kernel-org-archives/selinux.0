Return-Path: <SRS0=dBUy=VA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0102CC0650E
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE7A21882
	for <selinux@archiver.kernel.org>; Wed,  3 Jul 2019 21:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hnsOXjfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfGCV0k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Jul 2019 17:26:40 -0400
Received: from sonic314-22.consmr.mail.bf2.yahoo.com ([74.6.132.196]:45894
        "EHLO sonic314-22.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727349AbfGCV0k (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Jul 2019 17:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1562189198; bh=y/mPhKNoq6nbt3w7HpbSUZG3e7LYtWMMfbakz1o/bfQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=hnsOXjflP5hGJshInumU2QSLwSC0AlUWaDV/xRZcKWr5foFCLKu7ZGg9TCYuE6eLPi3UiRlSzPio7Wx+jIpK+b+CH1AOhAbKjmS6ERwjgFX07jxN3FDoEt3tppgD76T4Acw3dXEYYgpOv1Hoj/D6e7AuVGA17ZindQG8a3NSP1xFhriQMtsvj1n9F23h/zIjLdYH06moT3MsurSMsybr2XFNURwyFJHJJzSKA7ujs5GZVBtA5g0THSNjSeuF7ToHiJq4w6zTgwcWBxdPq1plTUTYz0XQ6cbicV385Hg+XpRJ/+gwKfPvSUSV8KOwHxGsFdb0V9P9SEGo6uTYxwxmTg==
X-YMail-OSG: _766vJMVM1kG_Tp_0kDs0XvYrXkyWLYAzoMgUKtojcUfEsdRt6IkkjQ7gCk6QW6
 bf0bO4jpMAmvb6git3lSOb_tArVx9LSsHXI7OTsuza6hGt4yxBX5lfAcyXfkl3XER7csYG6UqihW
 jWNXzd_7FftK8CgAjVOU07s6TJqtlOpmmeQLiceQitS7K14SjL3Y2ibatScW.fw5HK8Th0neA3o.
 g.Ga1GcWq3.a.ztIjG.RvNBjAiK1vEr2Ok4B9IK9fZEP3rJiZRLYxpYJ6IjbKmz4jar6REerK9Ts
 7ho_pqraoqp5rsKhMe1tdFPRVOXjA._9emBrBBb6zqKV0WmjE3or5DJs.jgbxK6Ls_y12NnNMN8Q
 xKBecu3pK6Xtlk7XJkAiZkJSx.FQOc9rG_0_8A.bY6cClBY4iLTfA_6Ti2uaobNF0h5gTsdp94gj
 XGIKHZa_aLhufBHw8PLiyAlzBQrEMTXcMPzEPE.SkKx44VFi63360U0VeShkrx35Joj1q5qkuf_n
 mBTt94hFocTQoQ807cgWEhHeFcDH9TDG7eoY.15NvlVy53cDQIAhYLf3ErlA0ZLhDnxt49_JIn7g
 qC5UIQ1wdGqAszlacDHFK5FbNb8d9bNsyXmEnKwWjkAitt0HCiAko0icIwL8d2BeXb.enMFXR53N
 ygGY2nOB5NQfA9f.zxLn59g5YvEAS75nPmGehDrM0mlB3Z9AAXCGZFmDK.eSrFKoY3ydrnXhE_47
 cSDLfMISbmDl38wR6_AOEsA0DXYYTnygTgGy3PDTxcSAMRkW41DcTkqmZA5vFYjxWwq_8aGn.bmV
 rVyX_jjnqDWiQOg9gr.90IlXyWWWON2eeQiDz3CdshDri3qG3crSa1dvIpr_HPMBToUIDBpZXX.w
 qwXLe55TgyuiU82jXfULz2J9lWXSHcwG41896pankH2FouGSCPmlvAVJkI5xluwXBjcfkPtv1qHg
 38gS9D4pmV0Cn3Pq8PvlZEqc52JRDisjtv809cP6AkLSeDkHrGXNzh3JpbmQyO4OBTdKT.GLlBA_
 xJKHXw1NL9Y5SzTODdH.ORbnQr3uFlj84GEHYhi6OtbA1K.EEeNhF522UaR.Km0lSJh.NeUCk1z_
 hS0uR_Z_5GAuQU.gq1JkBv7Gm.t1EHdmQygmKrhYwIMvkqe8yejcnWto9ll0F9BCesQIbigm6i6K
 V23.IOEqrcglaV_VaCRJggqXvcVbBdyeox00Bn3moiZClX9Yt3euJB1R.kee1gTWJL2OcDINrDBK
 6IkCxba9x7MT1pvA3pOxWz276moz1Y7aHSjcYTBhJ_zIT1W_6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Wed, 3 Jul 2019 21:26:38 +0000
Received: by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dcee8b60478c08e91221837756b9c2c8;
          Wed, 03 Jul 2019 21:26:37 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v5 23/23] SELinux: Verify LSM display sanity in binder
Date:   Wed,  3 Jul 2019 14:25:38 -0700
Message-Id: <20190703212538.7383-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703212538.7383-1-casey@schaufler-ca.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
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

