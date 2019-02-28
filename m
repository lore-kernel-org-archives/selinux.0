Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111E8C10F06
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20F8206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kzUlL1g9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfB1Woa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:30 -0500
Received: from sonic307-10.consmr.mail.bf2.yahoo.com ([74.6.134.49]:46855 "EHLO
        sonic307-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730004AbfB1Wo3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393868; bh=qGaKuPvH/w7dCrt+k3wQrAwy4uZDEs/MFzsCuALfi9k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kzUlL1g9y5ZDmRNdIYLwMrlXxwj+S9UZ+bE2rmjogpFkCW4/FjCNTlgSMnIH3Mie6wBJEKd7hY8dP8Ktv/80/VhByZ/8PF192FkjeO3CScOjTvtY9pFZlO7hQoqfLntkUddnuZ6Zf4rr10ZgAdK6gsx6rjD1YNatiNIMRS0JTUX/qKBqm+BMMTkl+Tjv+kNKT8AyRMyTmttXyuRem5OnOrGJ0QBKbF91N7HlWmUj7SMu1CKe3FfkLLuL0/QSN1+nP5hSck6OGPDojqGoWX3g5KEsFtNqEYyOoxGKo4h9PNDQf9Kk9dlyTR7VEx9mF8rzf9hICv7dRPrJjbcDEEEYNw==
X-YMail-OSG: QBFW0XcVM1nJSybqPMKADURrdJ0GcqCXA6zVoxaKsBssaKgxOsZwUxqUlGAB6MQ
 sZbTCLWAnKwAWq7DVw6k5eBeo24OTIALVfbmu0w6i7J2p2Xt2ND8L1_YI0YG_jImI6yVBBrtyg5A
 ty_EqNdOsF90bDi2Ir..sgUK0Q7_r2jzgtMRDzIOkB8aX0e9gsiol_T0.AVK00MQcEr6A_ZAOKqd
 I8oajewj3ucIXAZ97.NFX2bJmiT7ilC7o2dm29Nrf8_GuVCWcoS25paiUGtx4P30bkVOen6FefIO
 uv_JkQ2KD1J3xZ0LajT9ZxNrpcgQWF0Fs0bkgzIifChP9nxMV.4O5xy8z4FhL2gEVuIkDm98sW_v
 jzVtFDNA0bB_l4nTZ7MG4pjHMW40SWF08oJaOLDDc2EC_Z4LQCWDFJuWSJYCVEjQ41JXf8gW.Ila
 DlqzWNSfVuD0jZosBRierpjRc0WD.PPoyUVaqIzqyROfqWvX_XBxtbUg2fQxpV1kF0IyfG3HVBZp
 Hlj9ThZdYqRxkR0pg.gBn6KzhNZcWHDF0RORpXCeLEluCm.ibF8FPyISEyLQ2yVHsV.6FaCRhzrN
 temfaZ36u94HTKSqnYNIAIO.6iZvBtb1tc2X9X5lS7M8.bNYShw9IY5akZV9MfjmVlwKtuHHsa6_
 Mxk_YZPTPWEgiLi07JENWd5KPVwj8ASZ77ZaH94r1krZDwjs_Gblo3Y1FeFdiDNXIw9Smicuj7Da
 5s1RNHod5z5rGzmAfNBLWAHsXWOsB5SZq6GVMy8adr_VLtCwybOcSm1YPTQ4e791PL5hQDTGPFVG
 B7TYq0joN7i562fhhkFcVzLBD.99173l3MeMwFgvjMqi1q.g.F0bEDqKDz7hDGkCFVvmZTthaTbb
 K4NUy62TRQeKcSX.toEheExUkyIUf2gpR1BQqPlGEatBvBxAgTa5O1A1g7R06fDmiH0obhRMYnOI
 55UuUtAT8shi68HgmPnqApenrlyJbAnfVdacGTXMMc82EvEB4arQilwLwCBzgO.0sx7SEqxppq1W
 JbwTl4HenwISTUeqgGepUoo4CzLBQ0mIHRlEDGs56PM_6bmg.KSZ7yUv8eOVt1Exf_CU0ZvlYF1n
 8UGOdgXmy6RoElCFyc1xl4O5RwRx5Ack8pgBQyOSgj0udQ2D8m2VzNHg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 46c3ca42412e81058eafbaa96f791691;
          Thu, 28 Feb 2019 22:44:25 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 86/97] Smack: Don't set the socket label on each send
Date:   Thu, 28 Feb 2019 14:43:45 -0800
Message-Id: <20190228224356.2608-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
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
index d2a73d8a6976..d9055a0df75c 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2379,10 +2379,7 @@ static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
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
2.17.0

