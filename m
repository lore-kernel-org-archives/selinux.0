Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB77C28CC6
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AE027987
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ca6crS2A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfFBQwm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:52:42 -0400
Received: from sonic310-27.consmr.mail.gq1.yahoo.com ([98.137.69.153]:42217
        "EHLO sonic310-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbfFBQwl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494360; bh=DXZobVlHba7NLExIjhRRZRkmastZlDIkiPrs42J8njM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Ca6crS2AbXGqaqYcaD8ikm/maUYQox3BNJJLjfp/JwCLD+O1YtPzQoAZwSKGQM4z3uWaPy8CFjn1CJghphqMWfSi8jAP/qsRjQ3xuQ7vLqIevAxTYP3P93c8u8M+gLExXhlOrFq7VAL4cze49CsmLclXSkKYQGTtMKe2s4M2efb+K5I4a8hBa2euBrwTmkphN8Hg0Q/EjlK7nPpk9whmkOrTdFqcxX66FQLAonjqW6Q9XyHMUDQp1xHMPx4vRT+4j9+PXG17sHXIvg+6zE926H1Mk5+Vk3dw3uT6BAFRmezAYrn9vKrOre+mypKjuW+3US1G6uajf2Vxq69ZY4eqsQ==
X-YMail-OSG: s6n1_YQVM1lDPVC8A3OMrgySjobyxi4XPDRH9utBp2sIWlyw4X8wreJR6qiO7n4
 xS9Sd20mg_Wx8lXWLsOwDz05PuiRWPI0urPT7raTA12cbJdOv4zEmMvd61PJKefOlRfdxrp6Bvii
 a091fqFfeCkZy7I1kNFC8t3e.cdkiEUdUQg9iM4BBlktEytf_6gxVBfyjhhQrfk.WuE5SN00b1Gl
 ysrVO4fYa9Qw1qaxOLDbKM4BXUAinVngfdkUBsdR6rTOpSslfLzcHT3k_JwjKPySqhx9oZJjxqRN
 oKhjGHWMOThB9yhfFS9fEAczfDaPaDEgaycEPmonTmY4jsVN.f_Zcc7yMdu2PJhqVxh_4kWygjZa
 YdFZDVJIzI5mm0fI6I3fxlaSKyPh75oJON7Ixw30FydD7djwVm9xaq0N9hZCmsUFzQr6siWJEHvz
 cc4pHAH0cdVMOAaRhl2lxSne2XP4nVi3R2byeagoVBLIY5xHGwAtFAkpv5lofT0KffRi.ZMvuYSN
 m.W9EyYmLoOraujbk6B2jjJAHokWCusKU72PHrSoRKLHyqLpDpeKkTHoQAye2NfN8k2YnQCApVxj
 6N1xaDvRFYnFz.ihP_4MgP3rO93TzSsOa1dDQC77VFMMENUjmRXPMAiB6M1MEIyDwZG.SdYR9YGT
 yR_Pst2gKOX7aqccY7G39BHtVES_Xtt___3fgpOBUbnjhkmhOp.8akNVU8aR7YpNOsrEWftE_5W3
 sJktvi6PabaJR.SasjudTx4WtNHjNlzG0jIfUwiD5JstVWhMxxd8XqHizV5.212TshAcKPBZJ2lQ
 diE14esBYO6CL6M8GDXbQrFS0GVX62LS32825p46iNOeyQr4ERoWduWU4vrjC_.xsHvMsIwF.K.f
 WtKLXPOM6e3TpvzvrzyKEjNj0f4ktzUeKMlZplw8Y6ukP0MyQMJUmTbPFgPUBoWkKTE4vAAdn.PT
 PhzvvZipHXRF99KXQuVwildUC96lAU.cKOGSPzGdaxLJyOH3FcF4gmMSnxZzcbpIjRf3ZpDeh_ht
 9tW8l.SLhXSaqhaacCBiPve5Bjzzg9whzpxO0AOv3fTgE6mTLZkB0i7UcGuR_IncIYP0CTVga_h3
 NfkppaFBwwHgGXAgT_ynWaWrjkpXUh9p7oTZK0Z08wflqDDaRyNQLjpnZW1XMIyJRhkR6.1.fG1e
 6pVnkYaDET6sWJF4vdmhfGwvWMZHi.VbAXlsRKfoNN73RBx4UYBMge_6nycRh4TKAm4trR2LATeM
 GTS9x7AlUXZxmxunN5Dltg_ukA6MatyleO0aJ.opJqSpCAKPrZPwL2gQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sun, 2 Jun 2019 16:52:40 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 225d748664d0767f72d028f09ace7268;
          Sun, 02 Jun 2019 16:52:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 27/58] NET: Remove scaffolding on secmarks
Date:   Sun,  2 Jun 2019 09:50:30 -0700
Message-Id: <20190602165101.25079-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Replace the lsm_export scaffolding in xt_SECMARK.c
This raises an issue, in that Smack users have been
using SECMARK_MODE_SEL, which is suppoed to be exclusively
for SELinux. This is worked around in the code, but not
fully addressed.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/xt_SECMARK.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/xt_SECMARK.c b/net/netfilter/xt_SECMARK.c
index 2def8d8898e6..9a2a97c200a2 100644
--- a/net/netfilter/xt_SECMARK.c
+++ b/net/netfilter/xt_SECMARK.c
@@ -55,6 +55,7 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 	info->secctx[SECMARK_SECCTX_MAX - 1] = '\0';
 	info->secid = 0;
 
+	lsm_export_init(&le);
 	err = security_secctx_to_secid(info->secctx, strlen(info->secctx), &le);
 	if (err) {
 		if (err == -EINVAL)
@@ -63,7 +64,12 @@ static int checkentry_lsm(struct xt_secmark_target_info *info)
 		return err;
 	}
 
-	lsm_export_secid(&le, &info->secid);
+	/* Smack is cheating, using SECMARK_MODE_SEL */
+	if (le.selinux)
+		info->secid = le.selinux;
+	else
+		info->secid = le.smack;
+
 	if (!info->secid) {
 		pr_info_ratelimited("unable to map security context \'%s\'\n",
 				    info->secctx);
-- 
2.19.1

