Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750E8C32756
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D19F21EF2
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 19:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tw+3P1XE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbfHGTpJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 15:45:09 -0400
Received: from sonic301-9.consmr.mail.bf2.yahoo.com ([74.6.129.48]:42404 "EHLO
        sonic301-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389260AbfHGTpJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 15:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565207108; bh=bTpYSfOPPyQC93rL07mL99qbU5sEPagdbqHFlgN48s4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=tw+3P1XEFD3ADBS+z1Upx6bvNAK7ODCTSlByG+jxcz2UCT9a1rADI2UTSMoSeZwwOqyPsyQsEl8R00dd52FRatVEDtrAu5a+juAMhB5cqHOtYqzhFIXBsymRB8H/E3CpTsq9frgBMkGM+0WBBis6qe+nOpXT99J5614DdlO+HNQqE/ej/e8qZ6lFU/91TUhFQXIUIznrpwiOGpdUjVdwLkYxSepDPNUEDv6tWFnWRHbHARy2QEMsZsXSSyyINIrx2Fxbkm3l9gt3OPE53II5Py+rgDsCDLA6RF/sczYFnrXOAABssHRdDhUTRSwGB1bGE/nMdbKMC2F6T2UnPvQN0w==
X-YMail-OSG: qBWBBxoVM1mFs1Fadg5tf9mjoCVuftksRDCV6lRKe7lJFKwDcH_q5TYSdwW_3CS
 DmDHUh26DhZ8ULSI5m5adSPOHnONsTGW8FBx1gM9ZP6BFoLKuCsgCiIsRxg4SH04W8naV63RFChd
 rJfLtcmPhhosGD2oaKVIDV0sc9oWMw.U_EzRC7i9caBsXCpA7srxpsEGxzBJBkmfgRlzPGHNqMX5
 6gmY_1I9.J1o_t_699JvEdPdKT3m5evUSH9Mc_F510A0L0gPatDOiOGbv_yiksIUSBos6LwSqhdL
 jr0MTx9zKl9YTD0Um3LcmubQLvGw4x2Qd1iFvMOKhElsEdYuOpP6lo9b3WHgtlIqsLVz5wFqapfh
 6wODNWk9BUHJwzzS9gH8MwclxQK_ZycQmAKV7PSwxx3188aQVeLEn9w.S_gnw0Ww_vhiSHPtkVxR
 qFAk.ChHajo04IcY6Jy7pKbZuc5p237N6VIlUeWTUVpUZ0okI_KT92ES4ibyuIIgTUbjogG0m1e0
 6Sa1u81bjdE032pnjveu4SpFZnyV.f1m3ATxby9fdG58Lzc9AcTVj542NvJrEhPwYx0yWo3uEF7k
 eEG_Vz7.UyHC70l2ky9bzo0Ni0Np0gUeMm8V7uTR9QR.WnngNV0.EKP99XjMhRg0gYTr4xJ8zaJV
 hX.TYmyMhQsnqe3065YhojNC5g1M7TaDmsmKPzSX8ZFuuUtM8YZ7qYSRf3uzdVLrrzakVpBOZwQC
 G_sYR1edb2Ad2OcMeVv_MgU.qwH58q1C0dyZIK0VGAgKCi36muXHKuv0SgNgN2uu495xlFZfrFm9
 tSD71U6GMFCkq0VHHpboKG.OYu0ACaQf8o4rwLxuwe9NXSu9DgqaRGNLwUh0nMXGTpumZQDlZdgc
 xHyIl2aWNR94202n7BvzTFgAJmOw97nvf6qpqbqrh9q.wEN47p.fNodfyutVaYM5voOf7QKlNL02
 E1e4IAIQdw8S_EQnP9t_KGXLS4NKmbwlxPj8I4COGq2bMgyEq77usUnqysxupXhiOCzU6WaPMuRZ
 NrPgUU.jDvzxrWVs9KDHru_DdSsU9KDSQ6xmryCf4pyV80.hJW4_yxcdVy8.99sVHFaPWujGD2ek
 IXLJ38kHRPs9QeucgpkP_eKYw_rbQA5P_aj1THfE_cFqHM0dp7BarlklQhBs.YIKocjcWs.mWHz2
 lU.ZvH7YolZBinQt_gQD94Rg4SH2ZSR1ciIxHNWOyZoHpbWXWlcD_HsTDIJ5zKrsq2b9dWFOysey
 qySrkZWZA_LnE2xI3pfSbx0JjS1hdt6UqrAV5rE0pq2yQegL3vTA9jJw3.npOngtX28TBQVgHkJ9
 a15DeNyp91ifEVUWGIU6vuw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 19:45:08 +0000
Received: by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 47b71907c10558f94678ade4ae66d1b7;
          Wed, 07 Aug 2019 19:45:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 28/28] AppArmor: Remove the exclusive flag
Date:   Wed,  7 Aug 2019 12:44:10 -0700
Message-Id: <20190807194410.9762-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807194410.9762-1-casey@schaufler-ca.com>
References: <20190807194410.9762-1-casey@schaufler-ca.com>
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

