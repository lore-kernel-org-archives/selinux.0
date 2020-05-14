Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FDCC433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A282065C
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 22:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fLVUgY1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgENWhE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 18:37:04 -0400
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:37470
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728313AbgENWhE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 18:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589495823; bh=FbskZu1uJmt74RwlZaMCKCQ2JxCUUFNQy9qKTk6yMgg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fLVUgY1p+saXIYg3/j6xizToZ3VMGnQ0i2hB1w6kn5XvtxLf/DFI6PfttkDCLEPVSNqe01yUkxblB9AC9ElLEhnfiwcQfFFUnFr2zbTKdNua90Vmj4ZsDbyks7KCLXTQ9MQwKe3ERsB7eulhVZw/3VgcPzENzZ1jqgNiCsKl8exWVv2+7SIbAO1tojG6TffQrjlEOAv93jFJILUPnnA/U4iasxlM/H3JBthhqlfhokHFo5gTZgH1/tQk01g1nyiv65hjcQpjbCNpDCWMujgOpAKV99ZXZJr6Av+1poRXon5OHLSTpVSUXt+HQ6EH9P8/AOMhl9Yu+pW1v0+pNMxVLQ==
X-YMail-OSG: Ee9g38oVM1kjbDAYZlTG.z3pyp_B6yRYf7oOcp7Yjrz05F4Ljk45kOt7w51AMsW
 _3J6wWi8CfIXqqaI4oMlgW_F_MyIjaMuDgYe4MoL2nruAKV4yMrMkDJqhZ59U0_X6cWSknsmej6P
 kIo1RMK0rl6eV_5M98N5EmtowLbmvRqRzpt5maj59Xcx_daolldOLtJKW5fFfav.5CwLhxCxExbn
 hGIIKvrdEldNfPlSWZD9Nh3L1nU1IxxK1fXaITa4iwHlwwIsQ4.pK8Tfm0j7NXwx6Y14N9O9Jaix
 faDDBRvIdml6Ajs8A9VNMVYo6_CwSVKizr5aoHL.QkOakuU9F8boYpa.ZKx3wiOAP565ZFB2Zc5M
 aCBPSXJaVYpZVLo2ng3N3EK1hWGojMLbDhCx7vhyJo4mAf3JrwpCSabaq342yXbIjlwFTFEqoM8a
 hRazYE7DUA31aIX310H9v7P6m9cE2_SmnenUlKhkd_QdWjiWKDQegGDcNbFfcMy19IogosA7GHvO
 Kbr.x18uFZjqS7IfhdvTQp8Yi3h0PLCT1AKczNW3kn8tpCWWwyz2nrWG9ztNve1vAIBQexu_r0wL
 3myLfvEw1ryPmyyXGZvXOuwL35m1Gp9tCTL3Txtny2HWvO.JZTDdjGcnF0LHvpbHhCZLyvVKORVe
 F0bDTwaZvCacYHAU34RzSF8BuWFL4YR0frVdoSU2qjVTvG77gQc9BZ.bo_hxizEGoWMAXvICIw1d
 BKe9tI66Kfo8R56HskF_JZB57NqwTT5VpbCORyQufbsBOv8mMwVDWAVv7htgkkFK8LEqJGLkRHhT
 v2lctl2pKuAgBI4J7utM_2OrHP0EwR0EDEAbqWz348JjwLvJPVZopX9XAM7zxFqngRCh20_G0nT4
 OSx9yBlGZMJqI2H3dbVdQ22p6jwmSeqMjnrzr0uRynnsWVzWKxUmivmRtjlZxwLbKuYZe8EOIFkl
 tDKoz4pYNK0CL9ILcskGJ9gZWUbJbIGKEY5PDL6_s4rRJq60J6H2D5Vkds7haj6o0tkP1ckOiBMv
 UE1d0NMXstTfqdESz6Vwd1MVy03tHYjVyYJdaIzseRTh7pZL3mWFZk1SJNjUlct_HWJWubiCs8bB
 3fuEF.YmDO_4vKzWgdLgz39Gbhz6D6tPpi6CvUFqgkYi6UvGAjN5K7.2VyOd0XJGnQSxqUrnKEe8
 YU0ixEasKhqvUFkQ9fFSkexKA6FYhw8MQ6B0ECsYrDVXf1e7rpfBtHwIAsNaIENX5V.mFvecQ0Sg
 jKxD4ogivY237L4ypcUdfqJV3YrbOzwFUzOqjKWpv0XWF_xtZNbTJm1NeO.qAoAHD49Bb3gN0V4G
 dT6lPxZkKgCQ4T1h.vVISK3a9.tpGOguIgJVW.zEYOWlfUpx1QyV2TYibs4SX2ZjjzK05Jv0AQR0
 2RWz5Hm19xaK6Wo8kQFu60lVO0q7YrwNt3fNJp_ZTw0BK3JjvC1b9bm4Ezgxg2NrGE9Dr
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 May 2020 22:37:03 +0000
Received: by smtp430.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c2f438aefea8e183cb6d317c26d91500;
          Thu, 14 May 2020 22:37:00 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v17 23/23] AppArmor: Remove the exclusive flag
Date:   Thu, 14 May 2020 15:11:42 -0700
Message-Id: <20200514221142.11857-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200514221142.11857-1-casey@schaufler-ca.com>
References: <20200514221142.11857-1-casey@schaufler-ca.com>
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
index 02f305ab2c69..07729c28275e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1124,22 +1124,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
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
@@ -1243,8 +1227,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1913,7 +1895,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.24.1

