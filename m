Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB822C2BA1A
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995CA2076E
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="C78uLjPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgDGAW7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:22:59 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:43801
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbgDGAW6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 20:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586218978; bh=/fnffqTEA/0DaZe47mjPbyqSQbsHYyxZdjwhQkMneco=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=C78uLjPjq2sCAFWbOJFdkxPNVMXTKQB3759Qz25nrfg8I+NyUPGXBGox2yV7qCN2915XgowEWIe8R2hNkV0q7oghhqkr/eAEKF3Fhp3oT30ihEk4AOgMDvUnPcJvtHs/5y3MCb2SMRFUS3rzDLI7VzDymxDnePbTu3IcQn8HBshBnwRtH2ko8Psw0PWUT0+lmAUiSsUwejsiUW56lZrzsoXaWuKFXxorWxbx+t6vJvX/+wreWUX+Xtzr9NwupRtjmf3yR0OgVQSkCvxohgmxhVDRi4+rnHXDP9C0nTAfbIJscEjxLFNTsbUYP9fxUPXW8IJsNXTkXHXV9HAj9Tz4QA==
X-YMail-OSG: GCpqnqQVM1mIprFvyLYc7yHx_1u1ig7fy5uAmDSJY630AjJPe1.Z5EbVVWyaPif
 SH_dET8_vWTDiyDQmXndlFTsHu64xflK08n3uKkyFBLu3Y3GzUS9V.OQOpu5mODBrGjobHMDE68k
 KiGs.PcVMJGphg8gih_CJLlho81BS6.f3iVLSWwpZCkbj6TKmwioh54G6TFnXuB.5eKUULzCly2q
 gzhkYsRGYkGHCZ8l1yK1dxeQ9TIuh12afQDVtdiMCOxZBiWMDp2vlzYS.0ACOwm39e1wmtNluvAj
 PYAAX.I83D9mKSjtTxz8Is_062w3lx38ohoeqvbxfmzEzCdSe1w53ERFL2Oe.JVhOnFhgHBI7lWx
 jpMJccI1yXtFFZ.MCBX.IpB1OqWz.W5wjzPDaGhToS_d1k3DN9Fiz2ngWGDFc1TAYFpLA3rxbb6h
 OrqSquTdpjUogkXx1VXbk4ooQYWUaCTJznNRziKeoF7VndU1KvNbB0oovAOYeyvhrd4SGV23YnLf
 Ac6SqeO3rB_91EvBU4LY9r0cdmnb2J0DSmQf1b1MbPGgVkW.n2lFv78hmxwyiDtmOhnglZeq4bvx
 AFrJx5aeqMjbA64agAapKrQYpY8cu.Cnyn0U9JyCCizqnudyXbPXmzXoPTrJQAMXT_1IsppuKu_X
 HDmufzQ5vOoE0_rrlTi1s5XM7W7XJz1MghjQHVZtDP6IV1GjdDT1GLEsZxJGcCUAHdlGS1czSzfy
 SLdiI5s4Q.6xAWZeGDQhitvQkdvNk8D4x1SzRB0M_gFetfW3UlgQYqDXkB9_T31CtktZGT7Pq.c6
 BKZhyRg5Af8KuLr0.Yg3spZzpDkTK7ZvZg2ESfK_ktQQYl2ACj8V8gtgRzgxFhkCYygT7WrlG1fJ
 kJGmbWy.ENV46hJ1uWRu.l7bp.Pn4vUuqUrDDtmV0s5bcnryww_AtpRKcXVzT9JNe5nmnSbmWgXV
 Byn0hSJcaU99Ua1xzmEj4E.gDxnT6ujtK0.QQ0XkfTYl6Z2sH7JiifbL9fnDGbMm6Ps3Ea6CBd2Q
 E6ezmQXXw0WfW4Wzyj6zu3CwlKZQkBTP3GlrQb2t2P1Km_m9O6mjjbkjIYErbVp40ADaapyyfngK
 PBX50KwEVwQ3zpHmm2JXyKcy7u_ybvCUv6X4xErcE1w70QmVACzg8_QW2eCRnKOClVjUS1nC5lrq
 aiDmPC21oAUdK3BerVUTArZo87arpBkKU3u4VBVtNCeZjEMh7v.5U2_ruVdLZmdnaGzUxyF4rqdZ
 ZyGQ_2Y1EOMo5op68t3a_H.SmMhvu4EaFNlfQFxVnO1TJ70zGUbb6ZKPdPImFgSyWzty4FnpqhEj
 dYX_q44k5lu19Y2w2FGpyUSLIryvHo4DKIi2YoxX3350TRSvn7_pymLwErlbWodre4h4wXhhhHcv
 RffNCx3.CMOxjFLuJYCXkQjR042fMFy9.y9Vo0KZUsVwsOEDUcQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Apr 2020 00:22:58 +0000
Received: by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1b2fba97d77f9ea95418fb25b4adff9b;
          Tue, 07 Apr 2020 00:22:53 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v16 19/23] LSM: Verify LSM display sanity in binder
Date:   Mon,  6 Apr 2020 17:01:55 -0700
Message-Id: <20200407000159.43602-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200407000159.43602-1-casey@schaufler-ca.com>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Verify that the tasks on the ends of a binder transaction
use the same "display" security module. This prevents confusion
of security "contexts".

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/security.c b/security/security.c
index 84f33bd4990a..b7c2ed1eee42 100644
--- a/security/security.c
+++ b/security/security.c
@@ -769,9 +769,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
 	return call_int_hook(binder_set_context_mgr, 0, mgr);
 }
 
+/**
+ * security_binder_transaction - Binder driver transaction check
+ * @from: source of the transaction
+ * @to: destination of the transaction
+ *
+ * Verify that the tasks have the same LSM "display", then
+ * call the security module hooks.
+ *
+ * Returns -EINVAL if the displays don't match, or the
+ * result of the security module checks.
+ */
 int security_binder_transaction(struct task_struct *from,
 				struct task_struct *to)
 {
+	int from_display = lsm_task_display(from);
+	int to_display = lsm_task_display(to);
+
+	/*
+	 * If the display is LSMBLOB_INVALID the first module that has
+	 * an entry is used. This will be in the 0 slot.
+	 *
+	 * This is currently only required if the server has requested
+	 * peer contexts, but it would be unwieldly to have too much of
+	 * the binder driver detail here.
+	 */
+	if (from_display == LSMBLOB_INVALID)
+		from_display = 0;
+	if (to_display == LSMBLOB_INVALID)
+		to_display = 0;
+	if (from_display != to_display)
+		return -EINVAL;
+
 	return call_int_hook(binder_transaction, 0, from, to);
 }
 
-- 
2.24.1

