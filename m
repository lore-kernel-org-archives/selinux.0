Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF08C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A440821736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nzXD2+bQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfDSAru (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:47:50 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:38320
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbfDSAru (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634869; bh=K172cq+NB5Z0YjmWFKPzhzudN0HRFKrT7HKe6u3/BmU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nzXD2+bQYO38xu7UgLFdGGf5SKMTtTleMNNLsVp9dDFoUiFW+pHv1UZefZcQ1TsexhfmAKpxHK9u/FmXJ9P38Jhk1bD63/+QdAv2Duk6SKeziqJYJhLtLOvtwVO4D1mqmyt6WF99RKc+HOT6LX3mxNCN4vP1ulho7xw5KWAGDc8S/2I7rHeCBD/nE/qFRZxPgoldAX7dz7FM0RZRNQCMclm6giI9AT4z1Pv9X8XDoPUkxiPG7oFRI5p8b3KPrsu9hq2DYbBWRYdKwF7TLaMcbzKM+WI5+3rtBmIakY8d3ztmafOeZpldqxaToOne/KRYz51fhIw3ZMaYsNf8vAVKyg==
X-YMail-OSG: nVWlN8MVM1lXi26I7SMPXh4.OfuxbipT9ucHFBbN78c0AtljGj0glW.FDD_Nhv9
 L27zALGry.cfYWWhsQieZznzXRLFvXYKAZVFVbBcICCy_9Zcd6P9B1LRTTiuNdMv.zGWT8xcnj5P
 d6Q8VxDhZ2_CBsrGqSXSh2filGnY6QPx2UomnRCARReuotLdrEtK1w6bsf7G5Sbth6Wf8EweW2jT
 GggAvOU_I92CUhVDyEEJlCdGNxa6gSkHXe5d0CxDDL8iiry1UCOnUT0GNDTS6Svu4IzlYo1_.Owp
 xlFhMB6CnHOeV6RWBEP2BnrNXpkgyvMy0jn7ClIFoz6tWptTWmg0P6C629bEa9r4o.88xBdTJD1j
 80RfY3naRLHqedob66UA66V9lacdj0pV_7tBWcJOiyqHUCkycezjqr4_xeO00pJZnj2Igk3ceOVC
 R.ZUY3biBIG_jseaktehJfwEN_A1Ed5NzNPCSt9VAxhBFJYgwnAqG4IqImB4.ZC8z1w0uT4f6CE_
 JpNPIojsBX3OSHrysgO0l40OMposGejKC7smHXvx.2rc4..crEXZES6OnBEWaX1THv9YSg0t1C6I
 UrkhpirdvBT.xx7y3L_19a3zzHj8B_WVw_UXYqGfVd.ExdVVW3NYND607VnoYc9SW1cqWuCZk5FJ
 nA_Q_7DjVdaFbjtfdaZK6i8PTTZns.bo4WZHLzZHscxK1FmqNbfQLHBeSb90gqhikPq4QnAZkRS9
 .Q.nnheZHD9iiiUNZVDoxT1eqngZ0GPuzv4e0qZumcVB8NWH5lbFVi.Ufb9qF_lqNpWw2Pl4aarM
 4DukNWG9RzYLquOgU0CqKoOhvWRom1mt2kZNfTmdD_IAh_vUPHHIRhDKEyhca0gKFYU0YJqR7Xub
 rIQL6OYCHNJSQ.8Aj5M6Z.X.uxq4K6pPUqAcz4Si9TlMbExSb5wjvpJmVes636tnGAArxKaCYwyE
 Rbpe9p4dQrJk7SMSYMWvQTtZcuD8tE1fZmogogaxlyjbO.NxFHVrN3IJ7NM289DQL19E_GPzRaU0
 zGeXJU2jTGFHNiWiZ4hrtvVA6khdbQz11uRfYE3VYvdva5R99qFBFTRcifU9bZK6z17ghkrFlNhv
 KdMSw5m9ZYnEAk_55CwdNrMuSPROcDSQCNsGm6S57gIEj6Naq_St6Pahg2jZgCdMy53GCLzkftVv
 cqW3Gtvx5_opS
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:47:49 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID be9fa3e2c75d2b77c1de47e4a712b0c9;
          Fri, 19 Apr 2019 00:47:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 37/90] LSM: Create a data structure for a security context
Date:   Thu, 18 Apr 2019 17:45:24 -0700
Message-Id: <20190419004617.64627-38-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
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
index dde36e850cf0..e12b169deed6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -116,6 +116,17 @@ static inline bool lsm_export_equal(struct lsm_export *l, struct lsm_export *m)
 	return true;
 }
 
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

