Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDFFC43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051B3206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EP6a1oZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfB1WoJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:09 -0500
Received: from sonic307-10.consmr.mail.bf2.yahoo.com ([74.6.134.49]:43232 "EHLO
        sonic307-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727908AbfB1WoJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393848; bh=eJSihQlHJC7zAJUsB7t9oIkvmwu96BhjijJbgq/9xEw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=EP6a1oZCwMh3KcKr4GFs98L3q6VtZfDEl2GipoCOl7IOsnOInqPUtDXImsUsC30YhJJ7t+D7PsroAbOVef30JhjhXr/89L1ITiMExbrgPQ79bSwF6zb+WHlUuXPoYgG5er/hpNq8nefRF0RyHVNNM8Lkf+/tDoG3brivFbdvTASPuYwXaaybjPNY3x20PDl9x9HTCNoH6zP7EjKQLYtVtLt18/z18z7gNTOHO2HKLtWs+ttmtPMTEzDGRU68XV327ZrMCZiO6AjihxJ7pL4uig1YiRET17GTFZOS8FzbfutHpPxhzg0J8Je8QjdsTTSAm4oa+DOUpPA+2sybEM7AKQ==
X-YMail-OSG: zWkIrMkVM1k2dd5M9yfz5vUV6LDNziSs39xNb5uu8EzF3biSqycvsXGqANDZWwF
 bjngep9PxcfrFS.z0o4hU0.ZOqk7iuft2siGvOkhgQmHs967KQvd1ZPP2Q4TB4BmoytGOePJ6cet
 VRZoUgstWxmCObupTLhugnmjZx2Z_lxkmv8cKcq2SJ78X9_44ZAfnqWT4mvCNz9L_B_ME1uhsXUO
 h7N5ScSQz9KruDLo6OiOmlzQrTQg1ZF0kwCCbTQ5w9RyOADdos2GqoRpvcwp3CMiNQ.uJRGpBl7q
 Xuv8y657N4UxLPH.4hjbHxt79HxW0J4cv5Ncds2oNU9fS0ME_AenTqIJ5CMcZHiWl223su8weA.t
 yXFbqfUpGkUO19u6bC6A7lWnwwOz.AvbKvmnPzxNKq7SpOpVe9s80JkTAVCru2Au4NRqnAZPXLe2
 vwyjiFN4nxzge1OJPV1raG28Wi3VMuIeAp558.PRze_migEidtchCF2kTocQJ7SzmfOZIW2Zefv7
 6_bvxEeF0MdCwizw0_FGLpETTUzk463u29YbZlODPBp0Fu3SJyemtAe5S5e3UV0kOgnYk83WOjbT
 UMUZsMiZHAy_edTutq5AgxLH7cXhEOBbqTtZr.WVYXbh4egzFP82LRFwXXasF9ung68eiawqWVHL
 73iuCeJaHwBPfQD1DMiQLk5ymP4KbxjIZi3UhL37kKuIGiAEC2X2rRRM2ggnLSCgf3totZrRaxXV
 5_xNp3.HxPK_MLhYjWRrAP4VS3h6xO4zw0I9pMFrRTA_nMPRY6cFBpUL9hyRA5SPk0DWBbzOG1n5
 4s8hbryRxAUA5w1qc1R6K64XW14vZSFebKG7PG6sTkNFVLiJ8lOaFP_kcSE8cDVUF29rwavBgKMo
 krd7wGS3SE1EGw4AklmdFTIYwQlioY5Yu3VgEbvbV4oUawfM.tyeiR8dlg6dpUYnwQH.2Suq6QOS
 lCZQncRIkDcRl2H6bcIE.qa.dGqCTFPQXdnSBhma4kYYM.AYJS0ugIrxtFpgdne3Wy2jgrnH.4DQ
 2wP3SrgFjz3vT8f82diwPpIglhc3KNj2KkBcUYlf.uJDzTybKtHPcEIyMgqwys6QqiKY3WhCNqGO
 7Zl7Gt6whq1StHu.9UfedkVfP6HqjPv.lF57qYUb.bKUhmEM5tj.WXOJU
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:08 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp428.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 731ec5e129ec3fdeedd3a533970a7e62;
          Thu, 28 Feb 2019 22:44:06 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 72/97] LSM: Add secmark refcounting to call_one list - part 2
Date:   Thu, 28 Feb 2019 14:43:31 -0800
Message-Id: <20190228224356.2608-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add secmark_refcount_dec and secmark_refcount_inc to the
LSM hooks for which only the designated module is called.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/security.c b/security/security.c
index af3f6a89ee88..fc446af4c3bf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2125,6 +2125,8 @@ int security_setprocattr(const char *lsm, const char *name, void *value,
 		loh->secctx_to_secid = secctx_to_secid;
 		loh->socket_getpeersec_stream = socket_getpeersec_stream;
 		loh->secmark_relabel_packet = secmark_relabel_packet;
+		loh->secmark_refcount_inc = secmark_refcount_inc;
+		loh->secmark_refcount_dec = secmark_refcount_dec;
 
 		return size;
 	}
-- 
2.17.0

