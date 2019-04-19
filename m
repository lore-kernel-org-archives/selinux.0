Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DAFC10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE2B21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="RkQB256/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfDSAt0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:26 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:39386 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbfDSAt0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634965; bh=29V7H+gcN+aWTxtcORV9RWWZhXjh/E92Uaha4IKqRvk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=RkQB256/Gml8mL2A8z0baNePCZJGmXX7Q8uBePJW8vKyUvtBBwTRLOHBTlGxfO2+9Sv18mjlstpY3japhP5NojzkOJtYcdPDsV8cSGO9f4OwrRa7Jjp916cx25xCT+GtZWYN8xDs/QryJxSEtDX1GOOsa/qRT/An9DXbcKzn7NOi0eezZokxJ2acdT/ScI2KbrS7m/lIWT7wnN9UYjvCwuwPmgL2al8d4KyanjWgezB5wFnT8gXYd83XYuMQIRAoNURFy/RJH01PP8wwQJMSzVaX0nZbRWx43yr9E7a7+gexyonPchpuUl0JqTd9zmy1aNYYmyY2IQQaZVjuZMOdYw==
X-YMail-OSG: 7UC.jSwVM1n4p2Pe9LZQOarJeatkkLIQCnDom2U5Vh07LXaTi4VOZvBRroPrPa.
 nFcNDyZRNEm.2j1LV1UUop5ROhU4h9q4_oaMfVqfJ4lMUcYxcHf8cv3_ZvV_p085KQtgQQnjufck
 X3wgNBKm12dzkt763i1qWFxWct8BaWAEhDe3tPY6.w8GS4WVRBCZ5rFvEDzXXAU0N5TTd11feRCp
 8QzQmB_ORN47aAwrrarzeF0_ZixKCw1pG.x4W4l1XzlX.or696ZTvHKyl6cIDHTkRoqtwY7u1P0t
 Ea.73j.j9eVdG_.UeYkNTf7gU.Hy7_21PWBk8.zBOzXdmgjYFfRhctly1DMXHe_Np60RRgDBd6ho
 9t6kvA1fBVNW2r6jDT291VY3BGr1QvYMCUEfNTyxIlh213gNqEvlDZoZ75ySZDdz794MAhBJ3R1T
 EkJCE9YDo_Vg2Yym3TgCxHbLaGMxq.SeRuHcLyF2Ft5plbpNrGw.G55UDuW0mbIfF67tULh8OI.c
 214MU1Z1HZJuUDLluoIf5ueZ3IGzh.UG8B87dHbrZOjHP7yaumtrZGLVRhjuKfENuJO7CwnL8mSD
 NW6zFLVIMRBNEKfH5Ly5srloST1TwnUHOPcm717hSjWPGt2CAVXjr1L5K3w4VLVk16mY.xF7kuwZ
 zLRJZyeNKcyvpj3O7RNeD0Xz_kGP1GN9Ld9LnBi6S8fM_HL_cRtM7wi8vfIrs83p2MsW8Qmi1yD_
 C1kS5YFv1MezcYmqEWRz.C7ZEMyUFFfRN_8QE_H9mDOapOMzQhQ_DodW2JfxCshxaXQtdIl5Tr.H
 MZL6bkJg3e_UDnTeQFdNkCIqgDb4AzDWUZIpTluxcFAw1ORMVPehOkPtQ2.2uN.ZTkUZMKYQVvv0
 cqT2Tcye1u85sZj6gUMXJz_Qh20oVuvW2yKeCNZ4ydH1H3s0mIC3BETPIgfHYj9r.BlbJ_gOie21
 PsEwpwqLSk6VjsQ9F4nUDhosaxM4cFtKVV3kok3f3wKnVm2ZLzk7li9pvoibLP.GRvZJZVEdFWo0
 asY0inOObXOkFOUY1Lir_EMNxvHrY8TQGcgPyvljY_38bRaaC2y6V0O96GrKGVT33NBmk7N_Iemy
 27WZqG707A6prDvvIBapAF.Da1_l2Xgv4PVuSw4jYyAY_TKgtfBxpfD90TV3OPzE9ef3_cWqNHaU
 13V2xbBGlbDZC9w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:25 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b2fce6e68c800904f23626e111be9fc8;
          Fri, 19 Apr 2019 00:49:20 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 79/90] Smack: Don't set the socket label on each send
Date:   Thu, 18 Apr 2019 17:46:06 -0700
Message-Id: <20190419004617.64627-80-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The socket does not need to be relabeled on each send.
Remove the code that does that.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ace5b48f90dc..25b5160e343b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2466,10 +2466,7 @@ static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
 		rc = smk_bu_note("IPv4 host check", skp, hkp, MAY_WRITE, rc);
 	}
 	rcu_read_unlock();
-	if (rc != 0)
-		return rc;
-
-	return smack_netlabel(sk);
+	return rc;
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.19.1

