Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5491CC10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228B521736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="iTjaza+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDSAse (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:34 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:44116 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726759AbfDSAse (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634913; bh=zgFSe6tWYXYAPxCMjdvNLFgshVy6juLl1RtnFRkSwpk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=iTjaza+XL0+VGSPiSZHDg4RO/X8Z5IGXhkqISo9T0TOk9AyY1D8w+nRHK2T/t4brktF5xEUj/63TyK0v3R4g2bUItbtSE0S98p4AkWuEq/7LVT84OeBmJPGt1m/VoIiZPLoYrmVx2SwNykeLfXc7p28iQWzRGRbwVpIJW7643XtNUxhl0vjFA+VGzfP+CyIS7Wdjqh6cT4YKSyc8EScDpqgP1YYruqtPA9/zZgfqEZsjs3OSmLb92sPcWW3aN/NZItAzbPj8S8LnJ2dcJM55GXcGfqYQsqLlCEhtPplL1spPTp90uqHIdCKIeTDCGd5Rl7TCVNAyhTX+ggLSBLwtUA==
X-YMail-OSG: 2bwMA_4VM1mqWcMp.HRxd6p0mbAwP2aBgSSQ7zvK7xqmPek1ZRMywmT7iKI2REc
 IOrhoEmEChtwiyPGMr4.1jvR3aoD4tBps1.y2LbUyubnuw5WoRLi.AqDko3xhnUe0teSI8YNuPeK
 9E1v0ueCbqkoJCCK0ZwlII8G7PDwHYr8eqC4lRPicE9QqUQqc4oHnUHUiENPa6wfeBQ4X19XX20y
 sxYLDrlMN3.O1IOQDbbUyUs.cNYbLpsqcEcmhJVKXaRI5OMGa5GUu_vgMELosluMYzVUcNHOevQr
 HMJd.0ctmVflHyECqBu4oi.CCWcLF8KGdAsj9K4SkOhbUVz6o5s45kAWXwr5lcy4jDpLqu3BQ6yb
 gzFhRH0hoZ6TxRBYVhQUgwgjF.IH2dkLhRxbj7TTOtYuIzCu4TnEXDhWMevL.yk5aHOJ3mEiT6BR
 kCCcAeqocM5JZS8p0g_iIADdrA.unyzMm4AtlSWCe9z1Onj3VNZfXsRAe7TSpdjKquaO_bBUW7nJ
 AtP2BykwwS9iwTcmYBDr66dZB8HIbmR0iEcG_Pn7T3waWu_RrdZB30l.akG79DOPhJzK0TafML5J
 y0WAGglQIOPxMxUEqUwzCE4F1PQxTuxtOXBOetgVU8t8_hAcu.tOk5ziZTa42TAhjHvCHGtreWSV
 lHmBr.fK1DDo4x2ng56olwcsStKbuWpLOHGbZWOCpDWObbK0w8QU.lUWDe_4mP.EczdF4c1q4.IE
 UdMVtkh9B.0zezHWvp7K96mpT8RkQMIcWTjpM3slDPKcrrdDYIe0vzf8oMGmaqzRIe8uZaOg21k3
 26P4WaAADGj5ziFjffY1OO.yjKDybrIFg4RycU6GaN4tr7f9NUGvNbgtt7lsrlMNKqLwKX1evzZC
 7xpdL7CB6EQcFCU58R20l16yOgjPQ0a0DDle7Gl9lW8_xiJuxLvtrXPu29NTsRMAWDFGPLf2RNbH
 o2JJgBdKI4YDXV_KkKn6iV9Wgg1vFW4X1akIHGejlebg3qKxNFWGkqpbEcxp6cdN.0kXbtwFZtXE
 NA8eX66YaEIFU4A7Qw0zaPXbjPXHkOsi_Tg2guG2F0d8bverMicXFlJ9sh4cdpfmpO8JvZC6KhY.
 dDfPNsZGlFhrWouXpZve4Fifajfpw6idOv60yNuQzikG_Agj0kJgZN0_hDK20En3uXt.Ludy9QW7
 jQzwm8DbTDeL1gw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp432.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 828306e040049ab0082b23fbf6722cca;
          Fri, 19 Apr 2019 00:48:30 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 55/90] LSM: Remove unused macro
Date:   Thu, 18 Apr 2019 17:45:42 -0700
Message-Id: <20190419004617.64627-56-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The call_one_void_hook macro is unused since the change
to how releasing a secctx was made. Remove it.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/security/security.c b/security/security.c
index 363647cf1ae8..ae43735575d6 100644
--- a/security/security.c
+++ b/security/security.c
@@ -698,16 +698,6 @@ int lsm_superblock_alloc(struct super_block *sb)
 			P->hook.FUNC(__VA_ARGS__);		\
 	} while (0)
 
-#define call_one_void_hook(FUNC, ...)				\
-	do {							\
-		struct security_hook_list *P;			\
-								\
-		hlist_for_each_entry(P, &security_hook_heads.FUNC, list) { \
-			P->hook.FUNC(__VA_ARGS__);		\
-			break;					\
-		}						\
-	} while (0)
-
 #define call_int_hook(FUNC, IRC, ...) ({			\
 	int RC = IRC;						\
 	do {							\
-- 
2.19.1

