Return-Path: <SRS0=ovs9=T7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5416C04AB6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A895326FE6
	for <selinux@archiver.kernel.org>; Fri, 31 May 2019 23:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YadM9O9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfEaXQs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 May 2019 19:16:48 -0400
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:46554 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbfEaXQs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 May 2019 19:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559344607; bh=K172cq+NB5Z0YjmWFKPzhzudN0HRFKrT7HKe6u3/BmU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=YadM9O9a9d/nr3xctE1hIo/iNaMfTOPybE2GHPiPYnYCFM9T3p5BwWWCEJVYt9oB9HylW9QpXiLqvVi9CPN6DmZBYyopgvj6Q0UxOweQFQCDSOpUmOPZfmGc3FPkLX/bFml7dVGhieCCcVARzwueG3dScqaz7i5OKXaZbw9igju6D0fNePmy4mAc9AR81mScPCygE1C6pZmpHDqD7RFx3ag+r84/7TcgyiJ/yeHeEmdKcxVoNyMY32WSP1OVsJlFL99mahgw7cxOqPhyMNSxcjYhvqp4VVGVWMxtU2pM0hbRxAlG3WQLTwUtURB0/+xHrJusFB/HrAARGaFWAHaLMA==
X-YMail-OSG: 6cSnbRgVM1miUV5fsSZGOevEzHzFsIQlVBUEbePndRjDepfky07A89E7xzzkopN
 OpkeyijE5CDrpy4oocPo.tBKhRFyxCsKhAR6TzM2OFzBAUfAGfUMMkv6RAHo3JT48PANiLgBZmVh
 zACMecPN69bJWsqanksk6ksaBGhqlCNh9w2My_GRU6W6bEzE77nHogBTQ3NdS60TMWdc60HSmSSm
 pUV4VkosJyH_unwf1p4WUr3MQ0eSkJoWUUcovxc4TgRukeNssXCZgr_6iCMABUUwqz6sbTmWil7G
 rOJBWpO8gQ8jSE2eF5hvMWX4jt.DYzp_0vAqjns4n3lyf1Bx7KHbGyFLr97WWWbNJG9ywTjHNSt_
 SLvTgDHyhGD13kCLIIbk83Q3o8VTl2jGv6ueNVgqVXSQyCveis.tyCFNIAsX1OVEbkMIASEkDWYp
 2hd54eX7teuyjcdtVQKkswTpNWZksEk6f76v94e94kyv.SY28Z4h2W.xXV_jcb37iK_Igc.F2K81
 CG4AS.R5aFmEpkPir3rnBnD3jRhCtGg8IXRv7pAeh1KqqUla3jNo_ewt_X1MeV98eBzlZ3Lhs0lb
 9OPqmtpknr74nCiZzybtNeWzIu58TlfNxozPJN1IpB4eskMkz5eim4erNN7hwgfjKYDwJnABPnNe
 72wcCHXywofKQ9EbEu1bb_x.hstAi.83I512dmQYUYHYTyipGP0RDOpXN8NOpLmJNGE9jqdXkqQY
 ePPbJNnzkaf0jmlbiJC.574H.N.AFrRpT_mBPW_xD1gh5LA78ZjzL5iGNOEcpCgLmT5UU5Qqxd7z
 rxS1o8H_RgRL.wtr990_Mz7pIhyJvoceddlmOcM_9I0vJ6.5woxhn_uXjoJ9.y74_6WaEhb54qNP
 Sr9LXiP_PTVstx_xBKwx_ooYH25opzbYvV3RXZSvNOt4L7JCRtNnZkfmlKdesriYyRE_6vGbhk0L
 9vUJL7YQW6BML7l038FADbEWFHeHuPIhUhdvwWbrilfxi61Iw8X7RACazSOErEaIaHtpP_uezZGC
 vrACRXEo3duA54aTk5Ne4TE3ploFlyWDWtkYzdZC6DuG2PMHqrZ8CkADv2B77zJkzoif06bPOk9A
 4hnWIfZ5ICuIzaNZOwPWEDPRicrGWj2B5r7eL_I.vyCMuWdqRNHx3.LbE9N9e4eEB7nulfKNqVFA
 RHl9CTBSgynX8y9CoPlP2IYbYtDaIHphkdEC86FjKiQDkn4yEh04h0iDK8kkIMecchVcbV4fSC0b
 Oofomkmw.2gO1W.AuhKWZsBkv.kg6LF_M7HqDEkL2rw.heYEtLhi4egErUA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 31 May 2019 23:16:47 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([73.223.4.185])
          by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9cd5788d30d0fe2cc7baddaa2babae62;
          Fri, 31 May 2019 23:16:46 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 36/58] LSM: Create a data structure for a security context
Date:   Fri, 31 May 2019 16:09:58 -0700
Message-Id: <20190531231020.628-37-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190531231020.628-1-casey@schaufler-ca.com>
References: <20190531231020.628-1-casey@schaufler-ca.com>
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

