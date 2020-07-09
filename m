Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C7DC433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41AB020775
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 00:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ccit/g8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgGIAnO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:43:14 -0400
Received: from sonic311-23.consmr.mail.bf2.yahoo.com ([74.6.131.197]:43504
        "EHLO sonic311-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbgGIAnO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 20:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594255393; bh=P0P3phkgM+q4+dCSn6fYmPJId8J/SlEaW2WbbitI8v4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ccit/g8coZBMQU0/zN/nj9Q5GsueNFkwXq9BEEbOfieVRGUw3Wwzna6haVFkA3xmW8Dtx1rvd4rqrcBc47ZYCaMxfo1Z1ZsSKz1fR6r87AJtWD1qcGCZ0zsG8rMr3nwiDqXr/RqX81vRPM8Oc4rHsfGWdyNahDq8JO+TGynolQ8Z2bhMamf3WFA4npdqS318xMw39Go7SthRR3cf9gZn7O+2oBH84ESIcv3DIT8BJSai/6iPkljb2WYjxiI4t+fERlToyNnERnJhI9CUAl2K9ADKv5sAMNmuBmFZVGFbgepaKaM646ukotjoLF6ekHJJVuyBLFFTKVdPE8/XDYLm1A==
X-YMail-OSG: 6eUUNxQVM1nBpz1KitWX1LRDuA06HV7vFxgcgNpZIbQsnxCd8SCgY.1MWyYvyyN
 9sQshsoQvq7IwAYfL5ZRH1XSfych1A9xstQGNjt9PMLdiKUOIjcLEgnEY32CDP136.4UwadzWecf
 WB7zmAkzz1mgVFOI39Hf36DAxM4J37TM7950c88TkJ5biMFrQUrAZgyWbZCGi1nS_QF4s3mz_SEo
 _YzgL_ocdOI8_tgSgsoSQ1NqbqgjArCApI8xyxtNPCiuhAJpDaQRdgv_lT.H4AY.RZvuO9yDSSxC
 tSMkX2E72n4t269gUVaq.PgPcFSuj8A9kXKuMDzK1YFb72GaRao8CbbSi6WJLcPSA25MYMT_TEYX
 SRpOfrZQDR.xdzgiYqtHk6v2ZEgETrrLeOALI7nDamqWUv5NJ2KxX8L1jSSLxUPbKVXwuDBxIJzz
 IvBVaHS3LullaXQfUWAcknjGHJZ3OPZYyPFv_ac_2G.mDPQU3Ap2XaLFPjVrwCGkeCGCg6urlA9k
 Gd4cDz36xkFCHr9XJ1msJBeApnobNZuh1f4gwJ2KgQhVrvs9vFJqt6OxdUsHzMptxv_6iGIC78co
 OXnKcm_5FXtR6zy4wMWpIzaIkvkjK6Asd0AtJfHMBUP0m.3QDF1vyBpKyOi3fVlmkT07VS3ltd1p
 lCt665tfB0k_6tJ2mj.i_sfmhJi2gR1BF0jnM3FYWz3p9IYZ5.rRX5MlL3j9Ib41V9mYRL.MMrHF
 Cg471u4dQ9.V3rmJBLhiQMDICE1lP_EpbgANm4Gof58cHvgwLcMHo7bz7gyIDLqQ7dJACLz6pXuZ
 ZLP67j7vn6rRXIKf72C9089FKeVWWVs2txyvmqqWy39htMOoiRF_8RpFgRml_6boVA1W7AipuC3m
 7Bf2_rvswTIH_Uie7mVvmr2d3evugS7Eq6z7IwVgYUu_9p.VZhI_ANDtOMDLFGThZuMxePyRRUxE
 ECopkEcRiM3sHMr.8pvatR7hw9TvRPAD1UW.RD_fSXqC_Nx.kGmTjwcN3rCiIK5MtRrRkZMAjVpD
 1TJxUPddgE_q3On5xyWD87KJz0opOEZo9PsXYnxlw0x4ZjgSZgoWKJifYZTUtYsUHZOiZyHDbOtu
 4JG3nSSp1wRHaqom_TPx_rEXzTOvO7xDsG9K9pva37jUJMs6OTUhbWYPu7SJ47Uyh.53l9EZdW2G
 ck7L1THR0RDY6l11t5CLEAFKxPRXK4I7AB8xogz2jEHZQzQFcfSbOkmw4KmyTVPP.y8BM5yil3Wy
 aB0rHU31_bBp6IYl29M3X6_ZaK_rR5kI6zJpMcm9w19cUROIqieX2U9t.i5TTTJA2jB3uNupBJKV
 lo6nRiIz2SELnH7_.9Sc_Fckm5ydIsy4at9P0YhZtF9KBKLxP4GN89zaR2VNXwXp9QCM6ERZMV3D
 awXeFpxhD8NvAHU4bk6b_Ax0.CtA7uaWeng--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Thu, 9 Jul 2020 00:43:13 +0000
Received: by smtp412.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 9bdf81a05f141ab84b80c4af1dc1ea58;
          Thu, 09 Jul 2020 00:43:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v18 23/23] AppArmor: Remove the exclusive flag
Date:   Wed,  8 Jul 2020 17:12:34 -0700
Message-Id: <20200709001234.9719-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200709001234.9719-1-casey@schaufler-ca.com>
References: <20200709001234.9719-1-casey@schaufler-ca.com>
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

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 7ce570b0f491..4b7cbe9bb1be 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1129,22 +1129,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
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
@@ -1248,8 +1232,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1918,7 +1900,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.24.1

