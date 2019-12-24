Return-Path: <SRS0=lMs6=2O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73438C2D0C3
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45661206CB
	for <selinux@archiver.kernel.org>; Tue, 24 Dec 2019 23:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="g3QnXVVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfLXXXQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Dec 2019 18:23:16 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:36759
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbfLXXXP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Dec 2019 18:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577229794; bh=DJkcoXBN6Len1rmT8hLxo+7iFFtGC2LMsJjtLAQzYm4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=g3QnXVVPQKqV4LFDZYDQZzxwzi84pGbG0Gt040oh1c3JfFBtTdOHXha9j4cGPYz0xuCYZquYT3OdEa2wTmU4TUSvUc8OvS7CbLazdHVqHC6a8MGbMIlvCUFpBEPC5afg9f5/KF8ipPbhWsJZEHJMigkusaytUzq0fBQ2MCG4rMI7tjieIP//OKz+iVY3nQfPACoxdwau/7dXYHfjlIpFjTpl7e/CsrCkXdGKSWmL5mLbYtJtE7bdQj7TycgV3Y+8qAuAplMXLpz+RkNTq3dqLjYTb0OqoIxT0PP9WaJGPqr2a3AajoFPfRdlDzmmgWdAd/aXAghlKI0Q3OqI2CF1rw==
X-YMail-OSG: qICLHIoVM1lMs_gxnSt349KIuyhK9x3uf3l8XHTvr_A._hL1EWOCPRhMF.YrBKW
 Vcx05vZh_KmNrBh7NVQWzEWD_9KY9beOKHT_YF7wRKmqEeMHaQ.zT82Ep1luxNx9LM8yPsJCioTe
 awOvT93U4gG8Wy9ceyJZXfNI4neZ3ri3gfsh5vdpjfoCk6IUwgwL.T0ucLAota6IP1UCdevklGah
 Jqppriaeunqjk8ell_GbhNdsKrMEx5obbG4PfxR0h1Q.TqMZz438h2IjLUJ2py.9elyrGBuEFUhv
 sXeNYhbeJC4LWlX6wQg85Petp6YcYA8jgd7OuMxAhp1kiFcCH4ExYhLTupALKTHxSMYSqYnTgRmI
 4OQqj3AZ1KS7g9cNVn08tR6ihzLHogI9ETFDQh7kH8P2sT1FO1Tkkb50XAmOqMCkzKVsBv2kDSiI
 K0.hmNtYaJbHP7VrD6ClTbiRWBS4mTbCN2zAbQe8DQjOxRP8V7KhDZzGbc_HZFW7M584isj9SE_K
 _MMJmb6o3l6Drj2uAZdko1HGQ2TnvjAXiVyqXeD0d9iJQRY74txgN.J9X3RRYxECVWpcK.J7vC4X
 DBdzw8ITVEM1Wpo6Y0HTIID3DljORLX9kygDtvXXbWwoTUABOb241rpWH7D3coRqHn49j62GU5WZ
 5F_f9QHkU8x.GCaW4rXwv0ZV_EUEKrAxhNClRmZCIz5FVeIPj0tqzq9G96HUtIk9ThwDENR81tbo
 d3Z3ceOEi0AxKodc3eHcn24d4I.muIWY0rat5LOZafDKxFOUFcfCOjP8i8_VMmjaWctVaYR6HwLz
 8IiN9JwM8P2Rho89ENvmGh_Cf2B1qwGYdcSiP01TQKgsgGf6VjMpD.euG.s2ocOos3fS6g9EzwE4
 Clkg.055rfDxxRgiSMv7lpLJqA0CybAZk96FRF9b5mgYPSq8vrfMwIkVCya3e7mSUFRrSzxQlYDn
 QXiWkW6Ti52EgMWLyHHclCrozQTF0SD7jSNS3Red9XhqwvXCy1O.IpL0zlna5J07cBvKpi22amhZ
 2ixi0qVSm6O7uZ_eujL4qBw2zRjW9qsI1oU.ut4V9QlXnz_mM1v2.ONjM9tIUZwoRqhXZCNnlFoF
 .dq8NbmPVGTUfW2OtzHyRmW1mys836_ugtkmfmvfPAjCqpKCXynkJK.cxTEmID2o81KcMnJDOI37
 G37BZDRjulab.JEuE7Zr9m9yv8ugVzdrPhfo756rpz50OP0mmE7IfdhZtf.IoDnfRUIc5To79p8b
 .bFVvW9nbS44sl3Fq85STU4PjLPx9OfWtzR0ivjnwVxS7A4_ZWceP20wlyQvU_3gIuaw3sB8Ngm.
 JbN2cnQ17kkY.F236KuKhFCKd1l2.NUtBOmm6sUt3cyHzz7jtChSRUv0qukG6la2MEFY232ucyb1
 .MxyVoU5uSoWC4T3zjdRWJeg97nThTrqau0lFBWkhsqLbIYaTI1CIpgeH6UbA9SrhIvK2.Gpyzw-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 24 Dec 2019 23:23:14 +0000
Received: by smtp407.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9bc54365a424de579ba55ddb8289553e;
          Tue, 24 Dec 2019 23:23:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v12 25/25] AppArmor: Remove the exclusive flag
Date:   Tue, 24 Dec 2019 15:19:15 -0800
Message-Id: <20191224231915.7208-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224231915.7208-1-casey@schaufler-ca.com>
References: <20191224231915.7208-1-casey@schaufler-ca.com>
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

