Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8C1C282DE
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782A02084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rtasWKTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfDITTZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:25 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:42088
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbfDITTY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837563; bh=VEDYIM3R1NMqedNbn6scDMcxUUfpt0y9Ccbwl5mHx6o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=rtasWKThaB+GJuHhd2Et4xlpkGfiGvbqMTWO6V/NKpydOA5IuuguIbB/UddAZdkzWOB01nIYRrbsg/kA6l2vn9cRCykRDWqUdCyDLVQmxCNT2NSAeSY/hfBRgKOw82MkklacWt+7weBvb89eTTBI++zsf2mjl3eThFnM9ES8M7JSVHnveo56QiHxA0eO62w45FWh+AZrMIf0SjiOuAHRNuQyAMpPhuvWPucdDel3FEOrJYj/gc9s0hn6171ZxKdQXLLQZFcAHnpXRiIxEktYchysPPdv1Jxgl+8rpoVrFfH0lfHcIwu5qrnLhSGuA3ae+If7Ljrv2WwejV2UILrWEA==
X-YMail-OSG: gYAbMCoVM1n1QB1g5wAfdrhOLwuAxrlGTVmFXiQ5LDosZA8N_mKxI.adn3hn.X8
 7NFaZ1ml5Kq6iwFWIn5FyPlzGtU3vl334MxGRIlXeBNm_WVFzDkCxVwYPGrC5JR4I51AsKtQb93i
 NFyQZLyCfdF5tGap2EbIzJ9tjmvGp.0kWfhrorEFRNlu67.rEq9SYawT_7QCaXGx7rbHvHn3fE_w
 _pUghuq9yJz0SkMEm0xyTJzLpDRVBR4cNq7RIAzY99NkJRIcZu01cp2TizWAqZ8PdElqCuF03S1.
 RM.yQCFxSTCWDJSmFVRfQJH_lIjM.SPBGWElqykRs1Cgf_7UcCBfmfPohqjvRpEqsaphUDfsGxFc
 f.XIvWjXeaAgQWGsgEYDVD9EU12Wugl8.FM2JQiKriYvYGrM5oRUVDfJFxPy2bnILpP.21LVZ04C
 KgG7UvzMnfdTM8ukbkgpCrrAMM5bU.suSMx1kokhpOe1hY1wuS7TdCXrJxVnlgRZHj9C5ffsp46r
 K1u0md3XlmHlyVbWEsiB.MJGWvjIUttzK8S1gbizT.CYJu92V4oP2BQ3BY4eo78nXvlvxm541OyF
 Wmq8dqqmjKAjl8jpPjJMNS5WnjkmM24BnqOJX4RhsAUaFWuJ6TEiU5MsaaTkB.1LF20CJ.40Lmw1
 wT6ca.Vngg5g61RtK7tAV6S3bWooDxOF2M0NikJPCWjLMnFnA7RurLprkNTf7oKlThW4h25LGXBP
 ortjk.BEyM2adK55EBZ4f47RVhUah029pFkoQ3_nu.7yfC5MtkTDcWjpqNtDQZu05GhVoUpXWzw1
 mgLGx.2uwfiXZRIeHf3HE5aCzjEZL6LXYOQWWnNVKOnb2Ntzng41QbMgkwNGPrymi20ipkTcSc.S
 L5_VkmyivX8g_e85A9IIEtvRmLguGyquxYCtfozwZtacyuZcsKRvggWeo.06xbvdgdjhexT4b7Gb
 7Sccxng1_xXnwi0zzMd0GXyDJOjB8bZzxoFl21EHB0hgjO_5dvvAbu7YKLfq_nsGhxfXxnfuEk0u
 T0RN9cEJDO42s5XjrwpfzMsiaMBPsFqjPRzEt9.eR3MmP914.vX7.63EcLYlaftIUCbjfYa3NKNe
 PWll2B26CYv9s.d8ifQGw4gelGJHKfzn4mC_vgGy0Mg_A5RVCXgIOUg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:19:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 564a224fa9abd9f41816cac9472f1914;
          Tue, 09 Apr 2019 19:19:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 35/59] AppArmor: Remove unnecessary hook stub
Date:   Tue,  9 Apr 2019 12:18:24 -0700
Message-Id: <20190409191848.1380-36-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
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

