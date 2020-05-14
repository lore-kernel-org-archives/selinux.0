Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062F9C433E2
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D63F82065F
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Mfe3z4m0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgENWcn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 18:32:43 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:40663
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728662AbgENWcn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 18:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589495562; bh=CXLrghL2246zzEWsu94Kcqk12JO7Gj9mpePZWe08Rd4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Mfe3z4m0S5X90LWsM9JYvl4r1nieCtCpWxZET/SY1EQHKxlIRIawTYFE4ame5aWYPkDWYG+cZtb3koTjZUR2NcX63bFmgELiTHNPI+AWamnvxRIF0Ji5vYtAPs87SA19IJkRkrC77gYXtneuoQKNuBhpJe/MGUD8PUqkTffWZTX5kcDfwnKw58II4ZN+ujwtspaIMjKkW+5xbdTfCTATKAS4FRNVBX1b70InC24TYNPA49En9UcXLF61QhrOuetSKDm9vvVDSe/nwFByBBJepINsGL4mo3eWSur87GZL4/6xoZ4sLdHgbYYoIl9klyXSum6w3x0EF/lm+8eeZ87SDw==
X-YMail-OSG: vVtq8UsVM1lUjzWLpFiIOeWUwK19WFeVgJ3rrIhIEElbqapw9nprRKVsfUc7g96
 gKQ1zeX4fOZAXVRqJKkIyQH20jXIi4_f1y_hguiiTOKvJXFrG6ZrIdZbADa3_rGm.CLaDozW9e9W
 _4pK6qCdAJUKLCegYpTNEyYDCAla_nbcCKZH.kyo1OhQwAUb9RTQR.zLMEcibXwcBBK7jfo8mF20
 Q_M2PPmYa6huj8Y7Hk1E9ZitFpQNk59rf6pG7.eLIJYb05B7cxUP8VW58DHw5U0BOTOK9bUAVWaE
 1QcrVt5sk25JrPaDEjzqKGZ9uPinBRJXUMdrU9UWimKjg7zHebVlF5EBqJZvTTpPAYy7RMIMQ2K6
 Lmqjayg5S5Mc7xVPFUoJaB2ZBl4mmtJFL5rvIyVf61ISirsYLCO.avTZQ0F48Zvp8keDvBJQ7Gs3
 p2F4uoZGWkrkwAuc6MQIAlzLU.kibM7K1M71SxUrc0SB5BoZzNa3uvNaK7v6HeLflBDEQUwIXmuN
 sZr3hIK595L4lKFZf6tfpS5jsVoAkbL3fszuLVX_qa18raRDVXV5Ef63eEGToA5XWQ41llupO6za
 YSLKjhPcNzpEDXPlrziBJQvcIYyTTxWKHMW5AzbrSitBZzKFnz2s4xrMD64B.4xoyvZH0WoduMTf
 lRUXt2iTiRby.BNKY.VwizBVMMdS07tICMgPAk562l0TE.8qUhJ0NVII3q3ycZTIBj6EASsr.pOW
 UhVDDNdGvb_xI4yrfxqYnzS2T.y8MV5unp05a4dWP1d_QaW3zkuq8EeIRNbjMXMmTncxVINKJq5W
 b3Zgv.fMwHu5Fy6iZWiAz11IcGSoRny41Pt07AWuXQubOwPRGmIIvfidn6btKf6bMrSRDmLBpcR1
 ocmV0C77yzUZ7v_DWDh0qjQYseWy4eMEw6m5z0HHfih9.J3MUOP6A9tCvjEy1Y71Z_7YYXBM4jIf
 AikrSUlq0j8I5xEwUmLQTPprORLN4PAMO9wu9S3M.ZQj52YdFQnbMQi8gbKwQsdywXi0WxbYggMp
 kIRgMpvUhhPe.uz6KY66Uv_Dbfc13pjPfT.JqqDykBCvU5_ySJEcUOlhF3TPvV55NnhyZh1vOzQS
 7c3AIqp8YTeXSznGPWl5rzdv85.3kgVA69ffbCVeRJJsc9Zs3r2JI.LJICTcZZ3zCeL8uoAJVjMJ
 KvdGtw_r6S1ZtELvJ91Zfhcjfi37ygKLWZJ4nUGn7pQr660HLwUmBo5bf3Z5ZmNXCDHQ61xBr3xV
 mfFHNs9xNE1jBs.ppsGEEhUEzaYa6Nb2gJ1On2xgM66y2oFFn9AbsgkHIyJ9OHFtuwDa62Tbv9eN
 pwV1ANvoJI566CpLBL9PbvOIRbmBFxM85hMx2dwBJ0FhJDDvf006cQ7HK0PaorAMgUbv.xUnHVQu
 i8kP5BH17Wyg1ZoqusQDz8mvJ8b_ukcaCsdfmRnDlLhZ9tcNWIehgZij92C8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 May 2020 22:32:42 +0000
Received: by smtp405.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a21fe4c302c24d17582575c2e3e82ae3;
          Thu, 14 May 2020 22:32:36 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v17 19/23] LSM: Verify LSM display sanity in binder
Date:   Thu, 14 May 2020 15:11:38 -0700
Message-Id: <20200514221142.11857-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200514221142.11857-1-casey@schaufler-ca.com>
References: <20200514221142.11857-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Verify that the tasks on the ends of a binder transaction
use the same "display" security module. This prevents confusion
of security "contexts".

Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/security/security.c b/security/security.c
index d082ef0673d0..677a9f409dc2 100644
--- a/security/security.c
+++ b/security/security.c
@@ -788,9 +788,38 @@ int security_binder_set_context_mgr(struct task_struct *mgr)
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

