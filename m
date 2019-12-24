Return-Path: <SRS0=cgF/=2P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFC0C2D0D2
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D746420679
	for <selinux@archiver.kernel.org>; Wed, 25 Dec 2019 00:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ozV36MQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfLYADi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 19:03:38 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:43379
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfLYADi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 19:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577232216; bh=DJkcoXBN6Len1rmT8hLxo+7iFFtGC2LMsJjtLAQzYm4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ozV36MQy3nbURJ+vSUM4YaPcEI/J78Fw3e2eH3zwnp60j3mMWMNNpdumpibfOhl8gqP4cOsvH2DzrX8csOT7dwnrLJEm339TeMiUAoEQXuKwI5chQ49lG8yMvWoQdAp8JnXNZzaqI0JcBAVH8mj91s7H3rM2tVyH5HYPl4CGuuvOE5GYI8EBlzr/dItTGw2HSILJ9phGw17+UqllFL58AVmhPFESwVXu+z7j5PeHPu4XtiNFvObQrx7bEQVE6EDsFR+rT3aX5gi+8WoKhcR7O7TAZBE1ZqmI/0gbGK+rjncgS0Y9STMciTEFM078PQx6o2vofwNYTiqQ6kf07cbopA==
X-YMail-OSG: IisLKjMVM1nOvtvdaOys5xFvjHyf3EjVCoAFFJOx.5H9m6RONMTKoNueE3yvQkY
 g4Jn34scv3HF5Ai5TokwvMPXvAhLfy.8gQF1S7uFbVcNtrfqwdBMNah4eb05hXnemZGPHJ4TaBz0
 nom_G68bOA160zRIi4zZZIjIcGlJGm9Z7yFVIUYMbc1uIPhqLTB9_jp20PHggikOYEjF4GU0BqJJ
 oFHHZKEGN3gWgSDD1PiPuNBRvy83dBwRYL6J.T7_tm3HMCzwydSixL2_BzxhGBzlU6w3RM99LKdx
 Q7gPu5dL3812BlEYyROGrolZedUv4xxfYn900dAoCbbJwUaAtDzGjucKLIfO8rYcVUOUJFR033xE
 93IydRcC8Svm5XFb8U4N5Q7DXUBNQCAnab.1SInzqOrEOuSGqYeSj9n0JdYWxXNsnr8Z8L0EdyDS
 CQT429pN6.nXZgt.0BQY.anx2fAQmpcocvObxRzAnhD0kwMQkq.DQAt1j2PCpjMpMI.Jw2koAadH
 jSg4LVOpcCBbTBLFKpOop0J9b_KRYfBC_RuF78VgexGY14PcZ69ogpCEVnAVzCaVgXKN9yNw64Mt
 VlBY.9UZ1OCDagdsMN_Wh.jmfUkoHQJeGYDNfvHjitfb9wIc31HI5ATb9ZKv0yOl29LKHfLwaKkj
 Rk8xpld5gJgqe.tr0WKYHs._BWUzWzVaWQf7N4_oNsdZLaCKE9dYhXCLcI_SuRkExIgngcChbSZo
 XRy92.Et.uSrXl3O5A.Jh28qYwcdB5V7BAQ1xnynxGhC5rz3r1ZFPJJaJ9soOuK0VJtMxJawn4As
 nJ4H5soj_rWXDyVp.aBJOOE1iXlPT9ycqQ9yn7Ibw0fsxBwT6pBc8sDZFYEe85T0538mXz1mYD3d
 etPcKn2wCVsBgEjJGvct2ayk5LEEhh4cP02Yb.fcJ6frb5majJZCpdnEj_rI2Qv234FvgipYmfGH
 TkypbsCp_.F2ChPL4lO0mQyh_.S0PL9dcqVrUsRQcMmfeCSnJn_0oGIGYetP2I.LNjt_ess8Iq5Q
 dvefjoFB.wFczP0AYLNXSbf.dPewp..Dg_dvesPCx1Z9bwJOedYWAOUF1_XHDdu.hQkNrvD2to_P
 5TCXUvRV5mMwJoImaIyyr8G6O.Y.JmldZeK56OYLvreX4UIUjRnqRd3WkxLJXTjOX6OrxJl98uIB
 zrh0ccw5fKDjZc2BeuQi_L0QoIrb_qMCNVXV7GoiX7Dvab.LAgpu8fJlmcJrCpuy6A1cKpUMc0T0
 UpZRiCFV62tkFYD83z9iw8sPIVH9yJJCcLd.VpNhtgEh9Xu9l9Y9nLWiz4O8cu9rlSQvOGiV3jnx
 ysFN_nhRu4K3R0gvNOW8VqjipNMA3NAFwHokufdx92tW72xqDqLSkJLmlr28Gx_rKZ._AXbhMvTD
 wNlzNApSbenIxwdofkF0NtBuLZlrOvHPe8a9M0ZFuedCpygYc24oSogOQ7YrQbZLBV_GxXA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 25 Dec 2019 00:03:36 +0000
Received: by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2faa463e998922261a55e476f3a40c8f;
          Wed, 25 Dec 2019 00:03:33 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v13 25/25] AppArmor: Remove the exclusive flag
Date:   Tue, 24 Dec 2019 15:59:39 -0800
Message-Id: <20191224235939.7483-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224235939.7483-1-casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey@schaufler-ca.com>
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
index 34edfd29c32f..402a919190fd 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1112,22 +1112,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
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
@@ -1231,8 +1215,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1901,7 +1883,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.20.1

