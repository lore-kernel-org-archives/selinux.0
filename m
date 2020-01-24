Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB29C35240
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDACD214AF
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mbwwLXSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgAXA0S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:26:18 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:46481
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730009AbgAXA0S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825577; bh=6/o+2FxbQlHM4gCFaNOF3UkoCGhRevq/xwDOzwpEtLs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mbwwLXSwIT+BqvtgjfSD2vD/kXIMIQ2iYPAAz9qt3JwGCYpbrUwCOTMpbNYTKqhLLwgNv+KPrdVPo9Kjy3qRhtGOb7W7L1yrrQwOy+Bop9Ky2T+oDOIUXH/E9QMeEULOfHZeDa9rBceTVP45S26RjyMXnDKTVe9EiKh1bx5VZIdwGa7weaohLqYHazCR2h57wvb+f4PS5qBhGSKm6OMi71d+J4oBzod8umLBFk+rzjGffxe2Kv1OkMcqshnkbhIo4fN91jJzTTOhl3ea7kASnqVSzAwvaxL9cdfULyRHQIW9099KXZxsV5ZLOsVDEQFw1non2TXY0+PKkIYNv8zVlA==
X-YMail-OSG: fBVJ2r0VM1kyaWjg1lmKDGNq5.N33pI4_8u00ueleX_9cawyiFGciZWLRoQgL2R
 ahUC0CQHlpvV7.WATo15xKNTXwQpjnct8bdNK80co14pQB.8I3zar3T53bWDxLfihd.CCbnv3Sht
 QIV1q04vlqfApMUi6Idqo2voNr2qV9dHEOHTc6_o2k0sMN1vm0cki5VTHpCcTDXTFky8nL09UzE0
 8mKV7WwL_d4WdTU800eY6uE2U4znLfbGf7Elt_FA2hC_qR9CMvgMwfC4pLkmRJAPrxtTzMV_vxDJ
 KAbHAtq2.iwGtNoTEKf99Ye3dMn5Z4MTH5yy94MgOy1Ucm2kw5694_WdL9IveUe.41CyRKyMu7i2
 YYE..Kpc1ynt9w4Gb_IOQmSAWpTxZSAV2FSFrHMt.Gc7tkOEDbUYoQBijHYHYr2OpdFTEgwzLQaY
 GKeKuLVRBsdabD.LPMgRE.9yQsOMZ30GlvjKtWKoinzO5MqPLRciQkguoMo.H.nUr.2EZYnnjUx1
 E7Co4636GxvCWmrYSmjYec6Ytx5j7l_va02pBHQl6AteXVzgX7RSdaMum1pA.tZid8I2RSrUiA2r
 K2Se1OcSymtUk5nkmBLUSdEf_c7VDoBTW0AF.RGVtSg2iGZjPVj0cISPKIbGHviAiLaSV5jNzfn9
 eYREOBd9A51x0hAyBHGAzSVQDRA6iSB1kOjwxD0T7BhvX6HLpL3h3B.a_hgp7.VGVq7Lyj9VOfvB
 QDWJo6UyRJXbp_zGo1G.O6TkHuvxYxdZ.Lo5cOitokAlwlRyusnkKTD45W2pj9SB_lFGFPpvBsod
 liaH7w3oF9UQJn8W_QAm1npUFakG8kJUOYzgKYBwbARClVinEXfBKi5va5fPu6sp9pPCl3izNueB
 cWoGnbRVtKQDZ4jNX4wMp66st6l6Ok.cvAk_Z_z90ywFbSl.rG4Rz5MnUNxd0A9YbVe.3v1owBVR
 va_mpFhdoFD3Y.ey8YNoT6sLfowHMe7HcSj4KFF2ibl6mXDoV..05S_VEakCIF4CruoTjcCcI6SD
 tYrX4DdEucxE1y_04jbrOVZdvHeNfQ_h16z.y9UOajM4jnUnrt59lXB.bGiLpsEIG3bRLuTdtX0k
 RlxG949EHmyECOItLe0.CIbNM_mulCKehx97N6EK3SvJWx02psYc14FRjBcmufOSgS16CPvnS.2s
 GD8vAvq6noFU555pyREAEp6sCETi9xaIrAJa0DWfjbByslgK43Gkz9FBPlyWLNkbVkv15NeNhKEI
 moesnnjzUx7.8QTsu4VGnmCI0xbyNMQt9f8f9qCxVUnH.bfinYNBOEZlvrOn187LXSwyC.C7ZvZ7
 yzHGZ5z_OiAfSIeD.5XSqiLd4wYZsyoEAhxb4dz7fluz.h5Bos6DfXhJTvgrRVr7lTkpRmART6.g
 .nKJUBriQr_cpOHywPVcj3nPZjcud36Lbt47wCMmX77n4xgWnDIBJiGpfOjU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:26:17 +0000
Received: by smtp402.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 88a34912a4ffd8dfd14def0eecc3bd0e;
          Fri, 24 Jan 2020 00:26:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 19/23] LSM: Verify LSM display sanity in binder
Date:   Thu, 23 Jan 2020 16:23:02 -0800
Message-Id: <20200124002306.3552-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
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
index c2e5350e0f63..6002075b4c8e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -737,9 +737,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
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

