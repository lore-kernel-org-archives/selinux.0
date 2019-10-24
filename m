Return-Path: <SRS0=vsEg=YR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62A5CA9EAF
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D6921929
	for <selinux@archiver.kernel.org>; Thu, 24 Oct 2019 20:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="hOd+HKuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbfJXUyX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:54:23 -0400
Received: from sonic317-26.consmr.mail.gq1.yahoo.com ([98.137.66.152]:38663
        "EHLO sonic317-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728736AbfJXUyX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Oct 2019 16:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571950462; bh=iwsRob8mPxB0HBTr6zJlKet/+mwbmqKHtrH1kfUdiQ4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=hOd+HKuJY7+tSf1z7k5MiC18YLE/zCzeH8/xmOW2/DbxD7VVTrU/7lZxWF1TQ2eP+XyciY5qcUohck3IrbwWmSTxxMXKHB0OPgZG9CCU2yh5qoaey5PL/aCKmHGbw0Y/j8iN2fi3Juz7+maKbt2wLc7reAiKRD/JDcCMPFCvGDv0YvY+3kY8GK5WCUB6U9aLYR7Db1oOwlFDX4M49W4MAm29KH4pu13dVFES7OCKKSFg/EkVnsxLQcWrThB8kdq8h9oPAEZrWInX9/HovowcoTE+D/Eu8XUsDMeHoz8g9nn6KcBLloTkecf1qIU0yqobdjKIP/aAepRlZ1tSoE1A1g==
X-YMail-OSG: vMLqY.AVM1nG3P8Xwi2RBRkok9gAo.PA8upUxYzde5fO5uq0vL33Y6C5UcVbcEB
 .gqmTfyYro63WUc1uOBTd5gSa4X67b4xfZKgj9IuvasH4tdZGwJiEGOZNayCd.YCRol3xoy.8TSf
 ScqRnJbhnVDJsWRPDk4TgXr.qQ8jT7G2Wt6myepLdEZw.M3Ps8yN7nIcxJvGI9hF0aPwGEPnjoCx
 DyJ4wSa7Ad9ZCIKtsQfEQzFqVR840ow.f9XDg3rANj3xFBqUjuJ2hKrqD_LF4OKbTNX.Eacn0EYd
 wxq.7lDE3NWjGsPxdWiybOOCUccQRxxUldO3wvPpELZ2jUazu2BvgikEiTN35ThHvCV.Sti3SOkS
 DaFlglfNfugkqTwOS1jr9DiNBnNp4h2O5tzw74QwfAHuF0Wsan4Kr8T.yrV1XZN8i_nNT_NitKmB
 9rb3GwsKfiZQFKB.Iet9LjGUuslrDZp71DBBUoSQp1VS7Z._purpxWfrh.iSyvtK.l0xLIJZ5mBp
 8aHYfkfCEDx.m4P25aaUbcNZ8w_QJaEw.tqaehiOauHcMkvEDHlRD00d98kK_zKXeoxTNy.CBYZw
 2Naj5i02.2gBHiSDjSGnVNWokWGUGRA7lRh.Th4C1QRaBpBkYoxx21vXzxwyNgj2hV7MQXB5Oofr
 KPFFUAQkoYEaoTUonBCALu8VtQOPuogyd73XwSO8SB1j8J3gKXM_QKYCuGIa_dEPOM.4MLnxK686
 Kb3Xma0Y3fBI0639GjD6Li_sTca1VbOBQoUzLKN4Q.uAz9RI6B0pHxP2bnl0rsmEHRIo7H_z_cV8
 2KTZe4UJ_tdqa5CbsknJZGXBfVx7u5P1mQzcKdOZMDjkl38d7X2ZU_B6gRkjnJPUsrDAGiNsFvQy
 xrwYs446aeOUTGGRf15se0Yk4hUCRUmExVo3xmBMxBfbUla5iHio7W3r34.HeV2q_IcpneHX1U83
 ehIDmhURYz_2cp9boygCD91F0.cocG5RO8NpALKuGVDfOzTfdrrY7ES5OgoGeBdbK0SUraKzY_ak
 CtUhlTDpo_G_WnHXp3OWcC6Bffgt5LU1peZtMAjfVk3VF8eKkwk42P3fg9mFgX0AhLb6P_ncNDdM
 FrxaIjNTrryZYlaz_DRpGhTha1mXDYfFtQAvAPojRD9PYGUceJHWIQ9wyrlgKlAjesaVEUHkzKUc
 NbqqMuwTMMu6BnSY_1MayTfKCWqpGeW38vp4anbPrOpXdCwrBi2NKGONnEmwJncSX_4KY2kLgQY2
 AyRKMRQ_JPiQSjnxWbjGadOCbdOMIR0zgFAH99_qMNku7L5TMoBttm0piAja1hMUB_hAhq.LJJ.z
 anncN_f6TsN7RZKTt3Q1DDkPDO_HG5Mgrdgvy3b99vRdhNrZdkoBuLn.2sYLIXurM9K8IkUQQ9Cu
 wWR1hEGA.mm0tDufbZchiFlgQ8QjF
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Thu, 24 Oct 2019 20:54:22 +0000
Received: by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 35bc741c4cc33d8052afba24f4af420a;
          Thu, 24 Oct 2019 20:54:21 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 25/25] AppArmor: Remove the exclusive flag
Date:   Thu, 24 Oct 2019 13:52:28 -0700
Message-Id: <20191024205228.6922-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024205228.6922-1-casey@schaufler-ca.com>
References: <20191024205228.6922-1-casey@schaufler-ca.com>
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
index ef6035a4fa7e..0e7997a3a9d9 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1107,22 +1107,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
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
@@ -1226,8 +1210,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1738,7 +1720,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.20.1

