Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E81C10F0A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9715C2184A
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KI6gA2Z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbfB1WUd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:20:33 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:43330
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732199AbfB1WUc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392430; bh=KFOiqmYPHUmlyvGrhA826bf8EqEN7bZYPDEB3JWKNcY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KI6gA2Z02+q0XLsgNxalO73ZEAKfU+H0kLPBe84KFQ/tcfiz7gevQFybth4U04ecq+hR37LQFBVhphCMZQok6Dj3iMZs5d1gcWh2fLDSEdR8+3TJFrtUI+tlpu+VQ2bXyzDlQ3B1gckqPwsQofIB7TySFm+DKuSd/TiLX1Xco93TF/WzDEoAkOtpz92nKDEYzvtHZ6p/y4GpG10htvS/ReOsmLo4aTNapV0dm6qI4uKjFPoALahQKShwbta6HXHdztnVCnaULLARsJzfF9fTxugMVqCzgaG/gdnMo3Gy4OcS4R5W6zM0KGaIWyLPt/YPdnfUl9afGeKRFtODTEReyA==
X-YMail-OSG: bh3kiuQVM1lt6BUXbcDg0JX6sjeAZIqQZYXSc6C4iomDpz5kKendjP1TWFhhJ3Y
 3o8J.qTzuG.nhFfwCyBBp5V.WLrHWwM1UuvF4YgQ7.pt7Dti5tJTUVaLv69FMVAzUMNbSbbPgiih
 88jXe217oLzgZOkkeG_G_vtKNZIdUk1GA5JHfgzf5e_CNOUvKbZqazthiV6IAsom4wvwZ8mo.LbY
 AXVb.iFeJ6NsF.i6fLK8b4wntAz8IfqozbaGpUUFfdN78U7RZBU.XlwYEKz_JhdMsPueja3MQGdK
 JdmfXdrX5qP0p3NW515V2kD2LPuJNUlXyKTqTYa5bAHGcS84rj67doQMUbs5jo8mRNMDw6SwWRN2
 mRg_nbOrJVSTMtrD5PfWPzqvGXbrBjm_beLBvrcudmBbCA1BPXjgDyE_amtBKLh2AjnUmpp0qbD0
 XHOBoFtwYQpjQ9p3JS2NdJlx0avVMxd3_AbIM915mVrbJz6q3tJ33ELwrEqljkdsfY2IiCzD6znZ
 OyUxKW4Fg_8zAGEgY_utCfrYyLYSWPZ4mTOiVAFMKX03750moZ.UzifTHOG1TMqu4KSeKAWbLo4j
 G4SZSeNZJl3DJ1tRav9rIwJ7ZA5U8cMAtCM.xGsfeLS9k_RtR6tdVUSE3RWuxZxT4gjxg6KSrv6p
 y7px2UfdW7jGcI0ZWNE6n3nYnfXYQG9yAyUrtDVF8mzEpmw4MrcoenSHZ0KwYOJEmdy0Wcaosi44
 u8DG0WDaLPV79jz_UV68GyM5ClH_UUtjDXxMEj7PNE668M8DuFs_gdC0z8wPjd0XoAVaeOzSR3ul
 quI1tNhFWfVY8nQm4NVzURq57C5Jj7PHPc6pmhBi902rfAEUvepNIKhCmcPOggDVS8NbPl33Zn5f
 yJlfB5bxY26xPpejRTmH8MaNyja9u3WVRtRooeEc8CBJ2OeGsWVPu17rwSRovpGzQsM5RP71LPaP
 5N4eFeFRY7QvgpFfJ46jF.kVzV316cgmCiwfSpRjfbOfX5m6WidNNuItBDhY8NNejARY3HjSQFKT
 tLbp.ateQ7wLFgY94tLgTW9sg8rH8CNjZPfKzkROaRK2jJg7HyHlpI03.diVyv_UO2CovGJdzkVX
 ug0W1z9l9QvJf73HCO.8JRw91sgPZkjcWnkKGWOIjb93.13dKUiKsHMATLFg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:20:30 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp404.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4ed72522ccf44343c47df9c8f8a3f798;
          Thu, 28 Feb 2019 22:20:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 70/97] netfilter: Remove unnecessary NULL check in lsm_context
Date:   Thu, 28 Feb 2019 14:19:06 -0800
Message-Id: <20190228221933.2551-71-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There is a redundant NULL check when releasing a security context.
Remove it.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/nfnetlink_queue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 7a095b9d0a10..83bb44d70582 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -638,8 +638,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	kfree_skb(skb);
 	net_err_ratelimited("nf_queue: error creating packet message\n");
 nlmsg_failure:
-	if (lc.context)
-		security_release_secctx(&lc);
+	security_release_secctx(&lc);
 	return NULL;
 }
 
-- 
2.17.0

