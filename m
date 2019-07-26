Return-Path: <SRS0=eUs8=VX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C98C761A9
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE96421994
	for <selinux@archiver.kernel.org>; Fri, 26 Jul 2019 23:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Q88vLzqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfGZXkJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:40:09 -0400
Received: from sonic316-13.consmr.mail.gq1.yahoo.com ([98.137.69.37]:44180
        "EHLO sonic316-13.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728238AbfGZXkJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Jul 2019 19:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564184407; bh=bTpYSfOPPyQC93rL07mL99qbU5sEPagdbqHFlgN48s4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Q88vLzqAzKEnGcm8056LFXT8RVyT7t/ENMnGauW9j/nUrlGTwMBGFt+HVLrqZyvHBmsmS71UHspj2exV37pim6ob9mvG5rty2VgkG837hJJBF8WHCp3ENun0582OOtkGtkB4eJJc7lvsP1D5+2492W52GiccQ7LEqZJ6ArUtLsA9ugtkJMP2dCs3sZmrRUrmCK3y/4654ThHtuDmP1SBCUbXgDLLUpl3xFx2tjggHkPUynp1mZijz2VaH1SCG0qG2n+Wud33BQtJWEbpk8sGtMDKK8FOFwGI7l9LDQyBH0KWjbDWuIlpJxjdxGTCRsiGt4loby9OD9Te0d0y/NojSA==
X-YMail-OSG: fWq4d30VM1lvzrEGfkLBA1z_bO5Y5F611d258S6PsqeUVdZxddmQnpZJ_uME2SY
 TiUiPAtwITHB00dGtlRx7Sb_vH.vEXDjYIGCobB1mB5Gf1PboWQkjf.xaLMJobgu4WYz84_afN3y
 6h8uH8K8fw0mVdHQQqhQdQVIp1P7pycCQAOSSLcCjc2jS8Xe448TxUUpk4iAZXGAbbTXg8ZHyx0y
 qjSC02WJOdR1SMOkFDjgYK0U1lJKExyVbwUpajYgLz6VZ.fT4wx4PYlX78T3zoSPflHacxnHciLl
 c7MyVcwFheSS1re_4xPjdEHMFNaVzsVW46vhVzVQQVtcqa7Ecbvg.iv3IfAV1dQDXXRZkiwfJBva
 Ux12VYPbLyeRp3prVjlxPlVvw6d1qBJ3vDSr6YEeLCzL1ZYNnV7TcwYjFaWYKx9ACI72_n_3cl2i
 d5H5O2JYDEk9W0D_R0zqw2_rXy6N9rT.8lYGnfCbWaAjgWNPOb9V6mMQPs.9qY4aWMgqJv7hPjFN
 4KwCMwcJ438Kn6i_R1sqq3pkrDS43SxXk59XnXQVVJ3A0PZfagFbcwYojYa0Mt5UCLvJqIlD4_q1
 zqT1wMMu_B5tsmqL_99A1dkywtpGZJcTECHGF.6o7TJaMxhS5hOcgZOzMTnpWYHp7etKmHExUEHP
 HP4xufPj7BYXAnQbM9gr0ALrjzMUCE6PofAYBzNNeAs.X1AH87C0fEa_hP7mkelHDuRM1zWpaayE
 Frs9IcZwKWqtAWaHZdiAr2BKUhRdUGkO7Ejz2odaRKbszs1hlJAh1BddDcLccPZrvPRsO.oWB4_l
 qyLCnAkynabQinLJ2r6WAhgJQ9Smu4R8nKjDm758brkccoGJUUVEu3xrlZqahR1iM3zmqZ8D2IPx
 C7FGfTPWiS3r_Z0BaiBTL0AngVPmDj7fqFaUDBb8ncBqAQ7VRB85oZbLy_mCjQgrbZASLjfU9Oyx
 fn3YwMCduwdcHK83.rQpCLrIHU3n0r_xZ9ayBfstoOwWWHIrnaF.Yqca49sH7FFTM11PB4g2Qbp6
 VKgpX1Yv3GTy3Ukadcxaz4ML9yB2.Fvl_tzYHJXqQ0tGu7giELRpF.O3VMrA8PhoyngCDbxoxnLU
 SvVW0jg3nLt49wuRbo5ZxJ9dRas14ZBtuqWt7yTQ9fOn54W7DVI2lQ8nyQ1HxHfHWpadibH9ha_3
 RO_7OoFAW.tKCZCFg8aBSv_5tbCbueuDybqUE9PwU3I6WrZM1LsS3mwNnKbOwD.E_q9qWrmRf0N7
 5aajEWhiBsunb35KpEjKTljD9B8.7oPzfcDMe8hZUG_XkLoKXfaNQKtXLn_Rd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 26 Jul 2019 23:40:07 +0000
Received: by smtp408.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 02b21d14c7b696f5715c06f7c0a494d4;
          Fri, 26 Jul 2019 23:40:04 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH 27/27] AppArmor: Remove the exclusive flag
Date:   Fri, 26 Jul 2019 16:39:23 -0700
Message-Id: <20190726233923.2570-28-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726233923.2570-1-casey@schaufler-ca.com>
References: <20190726233923.2570-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

With the inclusion of the "display" process attribute
mechanism AppArmor no longer needs to be treated as an
"exclusive" security module. Remove the flag that indicates
it is exclusive. Remove the stub getpeersec_dgram AppArmor
hook as it has no effect in the single LSM case and
interferes in the multiple LSM case.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 5d25959610f9..fb5d5af426c6 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1071,22 +1071,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
 	return error;
 }
 
-/**
- * apparmor_socket_getpeersec_dgram - get security label of packet
- * @sock: the peer socket
- * @skb: packet data
- * @secid: pointer to where to put the secid of the packet
- *
- * Sets the netlabel socket state on sk from parent
- */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb, u32 *secid)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
-
 /**
  * apparmor_sock_graft - Initialize newly created socket
  * @sk: child sock
@@ -1190,8 +1174,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1702,7 +1684,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.20.1

