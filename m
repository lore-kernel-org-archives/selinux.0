Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F6FC10F09
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3569206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="UexpzEGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfB1WoV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:21 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:41600 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728881AbfB1WoU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393858; bh=/hckqGWaPxP0IFAvTcxg8keP+3zAVRCdGN1rW1SVv0Y=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=UexpzEGVcfYDJEqpBcLfcaVDj3gqUeC61Zdnhg7nLq0KY51wS8wlvqiwvsz2u2bC9c93jKxd0ZXxViSqJ0SvhUe9aw/KqHRHW7i2PpOY52JPGKmEIbJJbX9axwB/27UnkJswhDJa3KFcmFPOmZfl0bD2SBN/Dr7dIWuKlfLBR8ZCmX77gBJu/bMf52tlHdFGJw3sBTIU+m9j3FIryALnRCg/2mQxepDI4JUdFyBgXzf37zyKRFHkVozt7TQkGzPLyn9ansx8NbUrHYlfrFNFG0+biw63+Rv+AjMK/3BwW7MR2sjNUCjDQdg51PUEiCYTNpLzDGHQclTQJMS3O7fhDA==
X-YMail-OSG: yrc1LbsVM1k_hBnRZOipsrHLBPot31hGlJj4Y3oHJDTJ_heWLnM3oT0e5mQZHN3
 mmrK25HpIGjyHKkJK4T6vIS8U8QooxjIeiL_j_Py19NDSk9gW2eHCeyxiGeWmouRbbmGV.AR0ztU
 HZ9knRJlCl4hQIvPU9QO4QLMknXLoRZ4_ytHsMB3pUA19xmphI.SywT45PLnbHdbzvxPmh6bWzla
 pAAR1GkL5lJwIEW213rYjfQGJrJJX6RVsq_SkQG46Fzl.fv.K3ZPxEDNg_iGas3Hn3GNxXg7Uzx5
 UbQzoB6M4Qk9FfY20ZFQN1oNeDRc4jnWaBlw0K5REGs8qqohx44S6ZEdf2Kb4dg9uP5vJ8nbljKH
 jSdV_IJKH0dgmQ8Pid3sUvtRpGCx9lUMvR.PpRhkjUlmNlDm4NEx2P11M2oW_VlX09Ay4wxtsRJK
 kwNj_RZIkDhrLlyaNZ9p7.I4_s77KL2WDQ_U1pjQaWWPebum8Ybx4nUUMZiPt3gTn6aNrZmY3x0w
 r2JofOj7ZUd_XGgN3tExVfRmcA9oG6TlTpsA2.3guxjoAB3Lmi2KFFkRg8d0jcjRsB6PLsKv6ynZ
 hoG2bNKCByiiKN7yCsEiypFBJWkk48i0FhWey21vD6od0VT.3w6XmMxgOaDaP1NwZPlsyKFn6a.9
 1Kab11by4Rh3IxTx6VS6eSigDPjoeaMz09YpsqPpy_UbQ84b0VbXuj9JMFTXJRhOnTH8DckAf0Oc
 cPBkB9FEPVrOHhKUv3ownt2i1bN2IuFoMiDk77WF6B1WhnNn9WmPRLJfb9J5AXbrkaLxQE1VwSXX
 xoLXW6VA64uPU48f2AyTg2NucyRHhho8G1MxG9oYalxl1byqtiJthr4.olggPdr9zUOPPgdeuXHB
 CxHyzt.T3aZp6SB9DXZZDQl5jCGY.0TGLVnOIhT96eu1Sw2eCHbYF1.JwdloBF9tp0F.PXTY3S2C
 kcTkpMhirG1lQNzVx9A5MkcGGl541CmPGCzl9ZgYbwg218x7.iEondeQPeturCvJiSNLODHIBu78
 uW_pTcOmgc14fwdJgxy1uSm.Q.csSe2Ju__sGJqHNr_UUnatBeWykh.iSMKjc0qq4sEkBx_ASBRi
 nmdSEONu4TlVoDdHh1EYy0bYPOwA0b4H9EPa.qDSHwFQM3DLQ_FSTF7s-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 46c3ca42412e81058eafbaa96f791691;
          Thu, 28 Feb 2019 22:44:17 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 80/97] Smack: Advertise the secid to netlabel
Date:   Thu, 28 Feb 2019 14:43:39 -0800
Message-Id: <20190228224356.2608-11-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add the secid to the attributes shared with netlabel.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_access.c | 8 ++++++--
 security/smack/smackfs.c      | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
index fe2ce3a65822..0764bb85daee 100644
--- a/security/smack/smack_access.c
+++ b/security/smack/smack_access.c
@@ -549,8 +549,12 @@ struct smack_known *smk_import_entry(const char *string, int len)
 	skp->smk_known = smack;
 	skp->smk_secid = smack_next_secid++;
 	skp->smk_netlabel.domain = skp->smk_known;
-	skp->smk_netlabel.flags =
-		NETLBL_SECATTR_DOMAIN | NETLBL_SECATTR_MLS_LVL;
+	lsm_export_init(&skp->smk_netlabel.attr.le);
+	skp->smk_netlabel.attr.le.flags = LSM_EXPORT_SMACK;
+	skp->smk_netlabel.attr.le.smack = skp->smk_secid;
+	skp->smk_netlabel.flags = NETLBL_SECATTR_DOMAIN |
+				  NETLBL_SECATTR_MLS_LVL |
+				  NETLBL_SECATTR_SECID;
 	/*
 	 * If direct labeling works use it.
 	 * Otherwise use mapped labeling.
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 28c567465f6c..abaa5325c32f 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2953,8 +2953,12 @@ static struct vfsmount *smackfs_mount;
 static int __init smk_preset_netlabel(struct smack_known *skp)
 {
 	skp->smk_netlabel.domain = skp->smk_known;
-	skp->smk_netlabel.flags =
-		NETLBL_SECATTR_DOMAIN | NETLBL_SECATTR_MLS_LVL;
+	lsm_export_init(&skp->smk_netlabel.attr.le);
+	skp->smk_netlabel.attr.le.flags = LSM_EXPORT_SMACK;
+	skp->smk_netlabel.attr.le.smack = skp->smk_secid;
+	skp->smk_netlabel.flags = NETLBL_SECATTR_DOMAIN |
+				  NETLBL_SECATTR_MLS_LVL |
+				  NETLBL_SECATTR_SECID;
 	return smk_netlbl_mls(smack_cipso_direct, skp->smk_known,
 				&skp->smk_netlabel, strlen(skp->smk_known));
 }
-- 
2.17.0

