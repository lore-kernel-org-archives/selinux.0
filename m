Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1846C4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9D0218AE
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cNUW0tGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfB1WoV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:21 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:43504 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728946AbfB1WoU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393858; bh=q6uoWrAShVrIzUTRZ/xFtGhPWu+7m7/p+agiDK8IfOs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=cNUW0tGkIopZ2dGhEWsVDhs+wm5ei7NYgaeaBXyVHsn2565YdmKqrTx5oZfsdBSpQciezA2SwJCVsaOj2PlpVirjw5gVjKIr/G48abhUNasKHJeKNtq99F4CtIDleLnwrJhJfieJow2R/WaJguAGBWVSSw/uoLfmwY2OepWvR00k4qoS4W3YqQb6fE/N+2o7slqCKzEqNbHcbXvFkrJiqSYgBNbEF+VTyx1y9PurcteAIbte6NqAEvDKV65DYTUnT59YsuaKkqPFUNpGec95msHpUMNlYgBia2jo4uHC1NddUHR9U+OI769zwOjqoN3/em9vgPrMZ1LIyTQ64Fa+ow==
X-YMail-OSG: QCWsTtUVM1nDT5rOHpJtMnRxa1dhZYm9mmtloCJL3DxK5Il7UY.3NQXq5KjXFub
 RtRFDnceqmnAb0PLQglRDtfJrM70Id3sMkdjvQV5z77SzsC4yjqpSkV72DATKnrvAEgSSHctff9A
 TBLrhmJc9CdmdJc8AQU3MM81fUskWovBsMgLgkqPjT0OZ.SQg9jUpRX6UQcXzkcKchz6Szd9Bh_f
 1fXGH5KpN.80DcpFY6S2JfeEwZ98VajDViLw8YVfwa.yH7wxYeB7CFnZ.s8bBgv7BHSTrOVoMSd4
 MEylMyYmwfTVRCN8e.e7Dtzqh09n2ixhCEDWws0VQM4gWgCGi2eHJjXONLhcVGU2P01Pk4yuygTf
 VyGdMMl8RtR987Xzs_8Wb1gZHHmumULwGyKnhW8.RrpcKmhgpuSpuLmhaSYtQ._RaKH.I04Vgj60
 Ej2pzVgXEomNu39aqFrC7XwJO2ascZJLTizwm1zYUxO8HzjfHQQu245yK2doFzBU19VqWcZKSXAy
 t2TzJSo.AiALd2nYKYKStwo1McFBDmX67BOIPbM2uQbL86C3vf99Dr5miKEy47Lr815fBKPMWAAX
 976WjJAyexuRO60ksVVlQSdIVj_.EUWTiogvlLIuZrFzPcqgS7cj8NLYwcD0Pw0Yyoai.w7abtl5
 oxyz2zMtMefQv9IiPmIEE2of5r6xb4KonwxS0tP7YsSid0yDGJlPxYldwbiQ_zOWGRsDVirZXo6h
 pxLmE9PIBxr5hGmnuTk_jq5rygM0OqYoXkTJdncD730ki36iWEXzDPEt9cjvUE1xci8iGEc96o6g
 dVAgYGsd2gt38831ou_Zf9PhtzhfHdSX_K4xK2cuceQFVeXkBZCcRazP4SMBcfDhO3j31Ydg.Sf2
 56gfwry2KNll6HjxOjC.uSVnAp2zEz2yesMF2rKnSP3jEAOC0jLJdbbNwfoNcpEZuZk9h8rG1adn
 pzwa83438n4AxY70VCgteCD92QpPqTpUikjyM8mzjAnbcpyiRvxOxJbSGbuZ7HsZwiXL_r2Y.c_n
 f4U4Z.36kzQ3DuqdQzUx00uvbKIjUzrx9UuUoe1uC0HJvJLlF.oHVhphobbdkWka5DFVbxHKaNk2
 FlVRMVH9CI26kCBt9joNPa_JAu9xS8kTU2bpSnwFCLmRODFNTnrgpBtTc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:18 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 731ec5e129ec3fdeedd3a533970a7e62;
          Thu, 28 Feb 2019 22:44:15 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 79/97] LSM: Fix for security_init_inode_security
Date:   Thu, 28 Feb 2019 14:43:38 -0800
Message-Id: <20190228224356.2608-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The code assumes you can call evm_init_inode_security more
than once for an inode, but that won't work because security.evm
is a single value attribute. This does not make EVM work properly,
but does allow the security modules to initialize their attribures.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/security/security.c b/security/security.c
index 780c914df9fb..c4265ceb6dd0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1104,11 +1104,24 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
 
-	if (!initxattrs)
-		return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
-				     dir, qstr, NULL, NULL, NULL);
+	if (!initxattrs) {
+		rc = -EOPNOTSUPP;
+		hlist_for_each_entry(p,
+				     &security_hook_heads.inode_init_security,
+				     list) {
+			rc = p->hook.inode_init_security(inode, dir, qstr,
+							 NULL, NULL, NULL);
+			if (rc == -EOPNOTSUPP) {
+				rc = 0;
+				continue;
+			}
+			if (rc)
+				break;
+		}
+		return rc;
+	}
 
-	repo = kzalloc((LSM_COUNT * 2) * sizeof(*repo), GFP_NOFS);
+	repo = kzalloc((LSM_COUNT + 1) * sizeof(*repo), GFP_NOFS);
 	if (repo == NULL)
 		return -ENOMEM;
 
@@ -1119,18 +1132,20 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		rc = p->hook.inode_init_security(inode, dir, qstr,
 						 &repo[i].name, &repo[i].value,
 						 &repo[i].value_len);
+		if (rc == -EOPNOTSUPP)
+			continue;
 		if (rc)
 			goto out;
 
-		rc = evm_inode_init_security(inode, &repo[i], &repo[i + 1]);
-		if (rc)
-			goto out;
-
-		i += 2;
+		i++;
 	}
+	rc = evm_inode_init_security(inode, &repo[i], &repo[i + 1]);
+	if (rc)
+		goto out;
+
 	rc = initxattrs(inode, repo, fs_data);
 out:
-	for (i-- ; i >= 0; i--)
+	for (i++ ; i >= 0; i--)
 		kfree(repo[i].value);
 	kfree(repo);
 	return (rc == -EOPNOTSUPP) ? 0 : rc;
-- 
2.17.0

