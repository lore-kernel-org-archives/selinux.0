Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33D8C28CC2
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEC326FE4
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="d8cm+ATq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfEaXN1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:13:27 -0400
Received: from sonic302-9.consmr.mail.bf2.yahoo.com ([74.6.135.48]:33246 "EHLO
        sonic302-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbfEaXN0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344404; bh=0JVMKDcgnflVCRGzj1eTsOgE9xKpgnePntpCQbXL9EQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=d8cm+ATqribOEz5vpvUvGACPuWb2flPdG858u6qV0QG+tzol8rdu4HnbeAzrevmtjOuggC4VLInDfvrskdTWldQ+1SCNGf5uOs7doSqHQmRCFD2d2r2gZ1LMstoM9wUs2BKtGRrA5Is5KkoFoM42eev1c2t5iUlC5jfHFHkyDHY/5qPlCxxWJdoYisJw+86xO3Vti1VaULwq7L3GpBpdkykNB96a0MMH8HZfsjRb0fClWpUGXX9cwcD+2JSba++gtwm7PeIiyhTS7K2yDsamGyb/JOV12F/SynGJE2ygotYS8p0egV9zzhYFfM/W3WTEQhs/QLfvhzuE4Tchha/FxA==
X-YMail-OSG: 9ezUybIVM1n8cFgycVsb4SzmJjb8QNQLtFnrKjrFSYBKwGN84HOBghEzK24oxg.
 f7dZPBU3P0kOo60_IGjIdK5OUAmYbb.dRPqoTMC4KIFLtLV6LA9UcD05C64eT7lLrvBm94_IYLcW
 PvE5WPUfG4uqyOCCXB2uDejXBvB.X9U_mNKASYP6TErcni4gTKb.AFsXmHoYQE22hrlUMYPFr4iR
 yJqG8K7MxJuxy4dBOAr9BXRJ_cEGS4fjqeD8rgXhEH4CavJtJ3RPLdikp9yprm6mYyX8fccX6vzO
 uHwr1xv8f0aWSwYF7pJdsmpD7jIcGRnfiSf5x91tW4l8PEB2nAh5FnDm__WJvdyKuDyV0ukbEa1i
 OXtlZ.HqLUUFO0sxbDDuF3qjiEqe6vno81i6tSjWpBQsh6x1FWsy.DvAPb7hSY_5vwyqaeZUC_A5
 o44SpRcaBK5cUICOnY3w_680rNqwkC7iA5GJmbFLyPOA1BzJF2C4Usk5e4N_dGH4Cm2SnAtfmRCL
 eA0wpl3Rm4e6stt_ccbOKEppfTqDJwv.LLzN8sCVeZyOLQmLKx4ThE_ximWz.aBVnUFYIm0FJ101
 xZ0MbOG9zApgQjKoRc2BApjWUcMWBbgabX8WxG9VVNG_EcwyLzLoWrgVt8GXb5W5E8uusNcKV6bA
 rYmEToieVAXIyMM1HOImozvIQ8DMsviqo3y_qv6TRN00WxQlbimVDqtTNZhlDQaTsfSUglMpVxCc
 szzCcErQe9md9gIzWhf520xOGsnfu3oIEGzhSQ.uXhQMn2G1iLTKqNDkelcJ5OdY.PsJkOy9JqGj
 4G2Or0_OdCTJxPdf2L1iGx5p4392.bbu1ptfEmqg4u2m9ja7Rf5h0xesssnNef3TArnwQwkzB3_m
 dn5pJtpF8g7U_zkypr.GJszZsX6GuIcfyGQwOw..h0bD348PTP_P7nyvOgVMPdZ4ImnckZFrHVFZ
 TKxeqv2fwLGlSkKWsbYYtsl_BHAVvTwjdsO4DdX43fBwau0GO_ylBA9BbqJtEx.hAaizMj_IKILv
 PEmMEUXVghdED1yuvS3.a7dHlQ78lv9kZ0q_586esARJwpYPukiAdpZZcRYGeXrwWh40Elu_l0hn
 ShhpycZawCtMs_dQipPIFxQoXAIXCNRkP5sCA5QJzmY4E4S.RuqHhw.Kii9mEiZqkdmrjkpl6SVB
 igY3kvgB9tkG5CyENavuKTBkW60ft.C78O.u7Fycboi1j2PghwsCwLmK2kpP3TXhEBV6Rq9h2nJL
 _4T0I0BnHCcH1awDIcBNF2Mt4jQuYp4kjIybQxp0pivGtbAMmOSoPMb8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:13:24 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8fde30701a6e2f0263f97d374ac02e3d;
          Fri, 31 May 2019 23:13:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 21/58] LSM: Use lsm_export in security_cred_getsecid
Date:   Fri, 31 May 2019 16:09:43 -0700
Message-Id: <20190531231020.628-22-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_cred_getsecid to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h          | 2 +-
 security/integrity/ima/ima_main.c | 3 ++-
 security/security.c               | 8 +++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 2d04687c3fa9..40aa7b9f3c83 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -381,7 +381,7 @@ int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
 void security_cred_free(struct cred *cred);
 int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
 void security_transfer_creds(struct cred *new, const struct cred *old);
-void security_cred_getsecid(const struct cred *c, u32 *secid);
+void security_cred_getsecid(const struct cred *c, struct lsm_export *l);
 int security_kernel_act_as(struct cred *new, struct lsm_export *l);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1e3cfaf0ee5c..f5efa9ef270d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -374,7 +374,8 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	if (ret)
 		return ret;
 
-	security_cred_getsecid(bprm->cred, &secid);
+	security_cred_getsecid(bprm->cred, &le);
+	lsm_export_secid(&le, &secid);
 	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
 				   MAY_EXEC, CREDS_CHECK);
 }
diff --git a/security/security.c b/security/security.c
index e12ce930dfd9..69983ad68233 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1604,12 +1604,10 @@ void security_transfer_creds(struct cred *new, const struct cred *old)
 	call_void_hook(cred_transfer, new, old);
 }
 
-void security_cred_getsecid(const struct cred *c, u32 *secid)
+void security_cred_getsecid(const struct cred *c, struct lsm_export *l)
 {
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	call_void_hook(cred_getsecid, c, &data);
-	lsm_export_secid(&data, secid);
+	lsm_export_init(l);
+	call_void_hook(cred_getsecid, c, l);
 }
 EXPORT_SYMBOL(security_cred_getsecid);
 
-- 
2.19.1

