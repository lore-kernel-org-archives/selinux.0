Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066A3C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD54526FE1
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mrpHv9+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfEaXLK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:11:10 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:35060
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbfEaXLK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344269; bh=is2u5Y0DRwzBY1W00Se6/XMCwBAVUpvFG8LStFYaqTs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=mrpHv9+PbGUv0MBY66jS014njGItz7RK0fvUnkRCuJOfEBl91kgsG4vZhAkyiFYb8RXAP67KE3GCfS4FrYg/7Ek4r1DlyHzI0mbDVZMP+oDRlMwSba8lZg9f3+QmailOHanVA9AN/2Ej5M4xR4wpcd9dX4Qr4ogUAuWlhOlgy6X5MNmCpC9h8gXULlTNbSt4jnym7WTS8fTkzUdFxIKnaQo66eQJRfyTMfRStcFH6afngDYWzR2e4e6ryHX7RmTCiMsqMRG1CldqdUl5jyfDFi7KWDszKPnUn+1KWUyfY0OAgIz/MppwNbFQ2J02rGfR1txLz4JtheWr2Dj9TNSfRA==
X-YMail-OSG: AsJGGhsVM1mJAScsqoZKMMu.BEa4V5DNovtBL0Q9BStOzG6ai_B9kWibN7qSrGu
 VNgPt9kBtrPyd7BAwxanDimgAhXBVYvxb4wJG8hkGMN47L1EQa6R44BOyGKRN2QMwG5BayVLILu8
 R72srpoOvFPT7LM0lzMQTUKXejkWdsMejzHY8iGPB4spq23ON71gElDp7q1bKAsJk2MFNoqInm6m
 b0occqrhS1nc_dxVkvVL7ofK0XRYnfrkyNI1SwUb3FO_h65yhkT7yiS1FSgUUs3Lb.cT0EP3s8BE
 DCKd7tsDVkFap7fanqpDrrmcJJ.6kqm7vJnCS9HIRenmw_xlSWmBxKpc9ZFSw9r3_zvg3R7zULlH
 osma9KR0Dzfa832chP8w0ve3W7aPgrAwThDpgG43H0cSMyOBHDEdbL6kVq9iby1V6arF3WY2LpDr
 p5.3gLpSEcv9I_FOROvfep2jxtAkhSi9XOYUAYq2qj55WIspwTMCoHpQX0xazNWaGtbzmHeSuDyR
 .m78vpjH2VNQVMe3pVpi1K66Utut8ef79t9.amvjG.uE0wAznJyH_cykBvPhV16XRx4bVO05x3Fv
 1VhN3tX9mRnBUiMBbnjwFoZsOZGwEyJovk3dv23ge4kV5s4Jd6HBvDy3.LvWeutujW_hgOa53flr
 uW4CirUePrdYnZy_EN8FnhEDL6mA7qMN9gIua2keGwN6Y2T1NmCz3rPbky.edx7f6JKHENTA0VPp
 yc_TxGfTpeXYvJ20xegbQr4J_j7oOqcIFMLqO4S_Y.Lt24Gl_qek6c7wCysl_HBW8.816wg2B1aF
 dYXHArGf7W5hft8nKNsAxVxu6fy126broI2TxVqjztHQ9blmyUEnI7NHgMYOZvlp.M2LYnqpiKfD
 nil4Koq7fwzn1kT3S9kJSf.6TByISFnbxoAboXVSbsvJh..zGRIBTio2gbe0NLrFTUi1Pk3rXJcn
 oFNvTBgVOT3JSPa5ySqUdOeGjnCk_i4IDJgGaDrgdBtj8k4Mhk6gTn6d2IkpzSiKG49EzaFhCf58
 T3ZiKT4p5t7vRmhGCddZl_4JW2EGk6eRBHKuUFbI68.OASRRHiNVEWeGZucaDp8zAMJhengvc0A6
 xqOM7M9ZuwLb.frMmtzQDav2J_h91cXlX6IbSCaXIu.Y9UkmvEJhyrkzhaDPJCwlrZFFZMdw850_
 B.ZWY6qa_hUyUt98TOtj_TDAEaVFP8G779G3xa19DMiByq5CjMGsSuf8HG6OWikRiSW8iU66lyac
 pL78CFJTpxs4FRJbUQkT2mw7zqPxUu3RBDaXG3w2MOhwrHq6ADO2t3A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 31 May 2019 23:11:09 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp417.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 05c923e95feac0af6c979bf599e1c80d;
          Fri, 31 May 2019 23:11:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 04/58] LSM: Create an lsm_export data structure.
Date:   Fri, 31 May 2019 16:09:26 -0700
Message-Id: <20190531231020.628-5-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When more than one security module is exporting data to
audit and networking sub-systems a single 32 bit integer
is no longer sufficient to represent the data. Add a
structure to be used instead.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 49f2685324b0..81f9f79f9a1e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -76,6 +76,18 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/* Data exported by the security modules */
+struct lsm_export {
+	u32	selinux;
+	u32	smack;
+	u32	apparmor;
+	u32	flags;
+};
+#define LSM_EXPORT_NONE		0x00
+#define LSM_EXPORT_SELINUX	0x01
+#define LSM_EXPORT_SMACK	0x02
+#define LSM_EXPORT_APPARMOR	0x04
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
-- 
2.19.1

