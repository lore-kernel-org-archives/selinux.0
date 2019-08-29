Return-Path: <SRS0=Y9t7=WZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD8AC41514
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6084F21874
	for <selinux@archiver.kernel.org>; Thu, 29 Aug 2019 23:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sf8FaplB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfH2Xa0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:30:26 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:39293
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728299AbfH2XaZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Aug 2019 19:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1567121424; bh=bTpYSfOPPyQC93rL07mL99qbU5sEPagdbqHFlgN48s4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=sf8FaplBhhdBf6vSm5Xr17BLtcflyUsZ6fcvJoA46sg2FpsBSiUTYYHbVJ5o7x04YDYxL1iKutuvfzmL3y2eIJQzMIRQAtdm4g9vZmLdfA+ASMLsT2HxM8ZvkNqE73Gw7z9ajSEClRYnKrthhJi8pmqsg0Bd3SSWMG1e9FSx1wAhXDb5pKAhYtK9ZLptHkJ9I0li2sGsqAOzaF5l6BpkHggXKTs0/jwHzeS7Vph3N2cVXYgV1k4zntB1blkmHjtHJpQ0Sd0AkR0aNNZ2P9BVQOin1baKkakRL/YmZCUQvFoKsXaJum0YQVwZRoDnfB9CCOh4ubF/OCRMO3Q1TaGlow==
X-YMail-OSG: G76YARAVM1nujaGxjU1QYhUmz4a2wGhNuid9b1IXb4ype2nnTG7mEyoYVSqZNBl
 cDf3P8LCE0eSUsawEs3NiTYzRwO07w1_bmpWfj7lMKWXM7xc50A5E7FUNXPjU0NmpnsRCvTz5tT1
 3oodvAhKbz2uCC_qMlBEs.Qcoi5IVtfd9dNgY0WBV5NwcdQRKBLOLeUF_PBQ4qblK2hjTYAvHqJw
 aW2azpVybcMzCbIncyK5ojyeLPz0sEmWi1LdSNi4YjT9RYkgktSciNwbLIbf56wmFwPN6LKhpDas
 4rM8_0KwsR2pw.9kwbpW2lVSwTa9.ho4Po43A22tZJtrTgfjNDGgfWKtKb6MecF49q1awif.hjQt
 AV5EXSMzo1sItZon3QfU8i1.tElTizkDYo9rXZwzcVbgkJ0fQnfNpKFswHvXsVhkuPQ86RZba5ja
 jOJ2w823e6wZHPNFMjHw5LZECdpclqNV6CFUB6YSy8lcBx5LcAZ_nAm9dgljW45N12JVjOr9bFdo
 JJpjRjhp.ufdYYbFtbZtwmwwxqyiM.7epWve_GdRAKElAKtPASCO32e.siYjsXVLaPPjKZGWfw0C
 73dVHamUb7gWauuCgGn0ku.WJ_Fyq_y.H4h8r62mGGFBn5ukjEkb03eziiXwsVNgbfBHVAVSLTUc
 Iq9sJwCKzxbSUyFjNlKA7z4PPy7jpYA_8AF1McDh.8HlXAIIHwTgFLOoQ6As6wnXUlbIuiNSu.b.
 nUDvSuN361JBBKAt8kQFF5RcDbBfCgSvTVKQBEy8AM74gxzaS6Bi1ia5oo6lXj4oafV5AsnZuj2U
 RIrzGCG5Wi6u.WOsXK42NbOsBhg1e3PlCgMwYichFJg3pyFLBM9TTxmnf26_pK817vfEyectkf7H
 rwiaQplicU8WhubsOTqSoMJVvUKDY0sbUxqsRiYNAL9EYhTn5inYl4DSDRKNAdaVpOrVV1Jxis_n
 7qzFOZTmqgw0rgZL5H0o.8mNlIy2jhAfdVN_uumGxWUJIZP_sbTOwLxbBP05Tnd1uP0IbT9FfWVy
 7J5x3WAXLUJLJ0KQ_hlmCcsTvzGWF9kCSJu3.m8zUeZg.hB00VFKj5xmRxbnj8b7YwVKigl.DEBZ
 BA_9u0j.aI6gYpCbxnyEbdexZQJZXoORb_HHXxRAzMyeKtPenIpDhRr_dkNTFGIcWwUIWwMbK8iV
 QGSiMEmBNTsCe6pHddWMoz1lytqNeAtAqsFchJ68y6GZIDig6Ep07HKMjMWWE0UCCXKrcMcwBnFR
 ZY_ii1omXdOHP3c14Ixk7tY9Us4HlK5G_2eBQsrWG0llnfXxSuQsWleIeY6YvraD9lYWuR4UAaW1
 CiYkVm1fLvgMJJla8TmAOJg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 29 Aug 2019 23:30:24 +0000
Received: by smtp408.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d0dbf8f29a1f39b20bf1052e42e06980;
          Thu, 29 Aug 2019 23:30:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v8 28/28] AppArmor: Remove the exclusive flag
Date:   Thu, 29 Aug 2019 16:29:35 -0700
Message-Id: <20190829232935.7099-29-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829232935.7099-1-casey@schaufler-ca.com>
References: <20190829232935.7099-1-casey@schaufler-ca.com>
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

