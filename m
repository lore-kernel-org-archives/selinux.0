Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98378C282DA
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CCD2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ZJUuOcVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfDITTX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:23 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:37307
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726588AbfDITTU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837560; bh=vbPmsKchcYujFbsoTOZdCYFpnfZ1qp/ZBXWOn5HufTo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ZJUuOcVnj+GWxVxAKcJfykYBCMJRdtfI6dnR3DyCFAgefQS6V5u1Qu+SjbLe2wLk9Drr82hSqce9OxcOjYcGAgo80hKSLfek8ik7SabFO2w+HssvNVkdyMkKDwdibf+GfMolCeDpGlEJ04IUFOqCAk27FPCE5zA5/6m/UAd3a+r0AjP7wq7bE10sFWP5nFBzkpyk2OZgdp2EHdKAE6OSdu1n5j0nyeBDDA0tqcwnrB6GlgagwbGA4krhqMDhe510DJRnpPky8g4Zc69SVNghdfLDWbZGcCE0nStYLyXNgUJouJ++078VGKqt2olCV0VRbI8buAkp/dJfFixV+ZHjew==
X-YMail-OSG: C44HdawVM1kD1wqnZjpE1CEnupGsKN6v3T.Y4IIHYY3hNoN8jYFLs3pAJ9jCcJG
 gPIdjHcxC9sYpnC48a56XQfsseT4gAVDw_0a4GWpz28RsPuJn9Bs0cP7ll8Mdm7ZNCgCghUisAzT
 0jk_VrJU0Nkbq59O5.feqOnhAfCKJhABsXBR2LSuYIOlyUCfamPNDdIfkXk1bVOSddEeirUg9FYV
 gXPX2.pbiOgoTEs8KwWda9xnhpx5J7j0ohy5l3gK8cYxXuz.XVfbP__ychxWb2ONA9T7nSumhGRA
 _uiESYAevuBDUL3qWfLF_JP.mJLFFii4g1TvKEnqY_mAW28M3N850v9P5QxM09JBKF2acGVl6KUZ
 pobZ8Xk7Tb1OhZYEAfFRwfNyNQdFruch9vlqGlxCBNJdFvKs5rydHyHY4FSZrAbwfpV7by.Oxagr
 aMvOmQSPkt01gV5ewZBRQftoT6FDqv705eNrRuL7xYskqry7IP4.Q9j6mW2zVJW_3U3kw8zaCKpC
 fvzTG3DCCH80cHrNBs2ahxzg5ZBriESGGtRNS9JHuRqi157tEiE1MD6zEja74Rb7yzP9YRgJ5Crp
 ZZt9rX02jWvem0o7wjEmLfF3FaN6JUUe6TC_EU1VpCz5c.e_9dVImf4KUDvrV069j8SvwMzkO.QG
 71ZToFvMzvjUXEci2cXYu5VozIU1bijiTBEtu8UqclzH61ViYxsWTkewqBC.vcSgCyaUEqY2_zEA
 f8PR7rQaMfeYiVUqntGOHhCtNd.qBXQ3I32nXEHWoDd.0PNI6KkkEGmt0aDCv1h97FRTZk25zb.z
 RqA_xrzbTocvip6bWc9ttKAZghnvSneU1vDiWBA9WUqNA0lU8Ar1QcMDcFICKbKvq88xtWCXmyV4
 O1ua5x1M3e8myPDRrcHjAEVOlYksbd2iPZ7MvW3dxSG8sOve_s7I3HGyci75JzJ72dH1TCoK2OfO
 evGJzMWvD0YzkaKDqirF_SYtjhx9k86LchOJufujIrdJFFBHDAjUt9Qj4itndfjsW2wzfoo47DQ.
 LLq5VeokbfL6hQy.b9Dwoy3geyj_Fc.KGr.pVZtn1Ic.b9qtWZWpiYp1UVwLcKvY4jeEwjaXTQzc
 x__RHGxFS4lu2jnUfzlIz513hCCQidoKp.3f1i_5FxREjhyYJcxmm1p8f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:20 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 564a224fa9abd9f41816cac9472f1914;
          Tue, 09 Apr 2019 19:19:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 37/59] LSM: Create a data structure for a security context
Date:   Tue,  9 Apr 2019 12:18:26 -0700
Message-Id: <20190409191848.1380-38-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A "security context" is the text representation of
the information used by LSMs. This provides a structure
so that the use can be made consistant.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 6c44aca19c65..8dd21133ede8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -119,6 +119,17 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 
 extern struct lsm_export *lsm_export_skb(struct sk_buff *skb);
 
+/* Text representation of LSM specific security information - a "context" */
+struct lsm_context {
+	char	*context;
+	u32	len;
+};
+
+static inline void lsm_context_init(struct lsm_context *cp)
+{
+	memset(cp, 0, sizeof(*cp));
+}
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.19.1

