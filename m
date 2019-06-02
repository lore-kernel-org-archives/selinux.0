Return-Path: <SRS0=/A+P=UB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5C7C28CC6
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376452794D
	for <selinux@archiver.kernel.org>; Sun,  2 Jun 2019 16:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BHxUuw7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfFBQxL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:53:11 -0400
Received: from sonic305-8.consmr.mail.bf2.yahoo.com ([74.6.133.47]:37449 "EHLO
        sonic305-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbfFBQxL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 2 Jun 2019 12:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1559494390; bh=VEDYIM3R1NMqedNbn6scDMcxUUfpt0y9Ccbwl5mHx6o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=BHxUuw7ir0TiQjAsxuK9YW3NBArfHpRoIYgkkYDalA+VwNbHW5P5XfspRUU+TiJM6TNn6DpXKTdWfcU3649JJ47WxfjJD5aNMnS7rXqtqY3XyaCUK9sf7joPDXctgmRSvlFAftcXuS8j/EU0yCkIlG4k2isGSvPKh1UXY9UTDmyUOEGa1ldBz0xMNhlFIbU3R/aBTqVOT1yjp37laDrQeSGpRkiLFjB7AVaz03rNR0Ur+LruUvqmtNeq0m8aiu0y60vJvciSXeBMVGGHWWZ/etXMj1/4Aa8EaHw+XNlcLngX4EtTIC70h3DqR5ry4keKgngoqELmE0xUAFE9rgxczA==
X-YMail-OSG: UnHewdQVM1npGHJz0_Zujs2p_zDfigqvXyaTFxBdwvP_cdShwwsURiVO7Q7geQG
 bVhgjKFJ1mEZpOsi24UHrJtelqmVIIhvDdtiyBMsZr0FE7nU.VGu3O09fIOyyxzJiZZX2JyLrvNM
 oJpDauGX1V27ZEmUx.uedbL7tPzRG3QqspWCIR9YBYD.kEuS5VJTnpH_qGcufdE76a5nQy5EmNCw
 2igF8G48Ievc_b4_3VDp6QYkUbMVLEzLL1eRtDmLmeVE.e_YbykudhrOU.pIebB609Q_BTR20j1m
 _IJq15C_gGC8tAaLKJu9S3CgyGk2LWUQc9rNvm5SV7IJgSB_BhBATob08Pa6pBSU8xFcHh0T4qBn
 63obH6R9HD_x.w.wVzFTr3vxVAImjqzRg1J1r0dtYCiOOljLyhbvkB9xoP8BaNOPDTwvJ6_2dCmW
 mczKnkGtZslOI4JJjzG85UuhjBgX1QVYIjSbqB9Bxw0lkZy3jO.1lYuV3ubMbzbmNs77pFVdk1dl
 XxVFTijrs.YPdMXRJtfDF4s5E.1UNAzta6VUkmMKNZMARHm5iGQ19_w.9hwPF1rHtBlSi3c7dnOR
 y8X6lTrkcnkQcPyBe6hp0w.1FSpsfMQyp2KYxLnHfqHPIvlrbEJkEX_.YpR_r3w5ivY2b.gekLe_
 NNqFqGmOyHSE855QV7HNwMt2.DN5SOmVrWy6tMrwtTbSl8urMinWRZz8ytCKx6mqowrwWsClFVYg
 Dugkk4LHo1j9MI1PGbjYgbveLbtsAwbQN788aGaZjK9DW6qcSI38.P15TGU150_sq0d49jF5.5Ke
 jCk3ng0yv7bBFNUIs35Dg9L8YfYNHlPMFqsVmKGIh41DbSwVAI5zB_S3y1qk23qa7aDLR0n6jaV1
 m1HytTUZPWiISpyYBQYwroAbDZO9EXqivQS1CcT8pz9IysuLlnvIyAi1DbNmZVrLYeF14seni9WV
 Rlg2Yp2Dntn3WYwTlZbs26QGm1Z5pW46TC33_XCmwA.3PVQ1xLWpHhEtQOg9b7p7DfTzlVeFP5y6
 UV22nzMVYY6aR31qVv9pCejPHL1TyeMlkn6TUXUApQkKrU9xeZzqMOXFglImEOHz1r44hOCN18pQ
 rcpoYvfF.9XWvEYGxz9_hiBXQKnfXDtv8mxWyfFMA04fsvwu3yg2TlMYYyBb_EbGdbI3OPK9TRe6
 Mv8R7X1GjMMgVJ5X4jXiGgbaNF8W4uPZ6UG7kDi6oaPJC8_m.xMSfp6TSHYtzxQrCKFuTSHyA872
 xOx1dORDTcB8GI6BD1bX2D7JkZfCHVikR.kfUchSu9b2FjQfTXxzKGNQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sun, 2 Jun 2019 16:53:10 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 740888a1156cdff0756b5bee8a218310;
          Sun, 02 Jun 2019 16:53:09 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 34/58] AppArmor: Remove unnecessary hook stub
Date:   Sun,  2 Jun 2019 09:50:37 -0700
Message-Id: <20190602165101.25079-35-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190602165101.25079-1-casey@schaufler-ca.com>
References: <20190602165101.25079-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Remove the getpeersec_dgram hook stub. It's unnecessary
and disrupts stacking.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 24b638bd4305..76c409737370 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1094,15 +1094,9 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
  * @secid: pointer to where to put the secid of the packet
  *
  * Sets the netlabel socket state on sk from parent
+ *
+ * The TODO stub interfered with stacking and was removed - Casey
  */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb,
-					    struct lsm_export *l)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
 
 /**
  * apparmor_sock_graft - Initialize newly created socket
@@ -1202,8 +1196,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
-- 
2.19.1

