Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DEFC2BA1A
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E7B2072A
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 00:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="g4zJXlli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDGA1T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:27:19 -0400
Received: from sonic311-31.consmr.mail.ne1.yahoo.com ([66.163.188.212]:44617
        "EHLO sonic311-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbgDGA1T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 20:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586219238; bh=FbskZu1uJmt74RwlZaMCKCQ2JxCUUFNQy9qKTk6yMgg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=g4zJXlliYXtTilKF7g6zp+wAU8t2J1vAFDoSB9XK+Wo5av8DLJtYo5Z+wElC/cKzZY4i/3ZNuJdq4+a0Kb5Hn+h1UZPPfiu0Jv3X3KUcI/9W9xCTVDVoLfnuG625CAA9RZ5lNVGdDQp9VF34Cgq+gHCDTPSB7E9XGkTnwh21UCRG/S9GFtxmz998SQ9/FBmqriX+F1jp9scTWy2jFnlHrYKhAfM5MtCP+bOweB/RkgHcAZ0daV+7f/2bTqXuB0ZdEU8vW20h0Mf4QZAnvXXQfb8i1BhOE9zW9gIefVrxR7pAzDk37dhB8kj2Pey9+xhG45sldAobdWQlD1IlxqqARw==
X-YMail-OSG: 2ZZ7EmoVM1m1RmrGzpha4baPQ1qzlWD8qhPSY9Vk2ct_OgnsNLIQOdZgRQDeJeu
 8lrT2PflhdzlbFeIo6eXAmAEmatdrjElwpRPZqHtDxqJrrh9BSOTz_t.6QSASY__wtP94t5gBHF8
 Q8zlGA1dc.7L8NLQWtJ.hllDF3K8Yh.P6T2zR4.haIxWi_NIjffnr8TL6Yuq2nl342JfBTTqL.nq
 pszkvdmGKrHoPyyPYuAobg8_l4DL7i9R.xyqBXO2NgyRE6R5QowVXvZs6ldFQVinvVEpOnm1Mxni
 4LzxkuaQqdr.MJJfRk2RNjrAz.jaSJavIRpTNZqFCCYHBkp1jeupur52R9N.0mnzttlTLmBxNiCv
 ScoHcwZhHrmgPsAGEK5UfqcZInpMLQIBZgfnCdsSW9geThX96QYCrBOfdGkrSiiSk7kbm3l8kxw1
 IlgC2xZ05M3KUFMnQY_d2rBbxh.wtQBd7wcPlHYvolGA6e03EBlp7F6jvJV2ie5qksYBWqmxKPT3
 ACx8X2_QELz99WROPeN1kjlaWYDmzMfelT1qSbqv6tYg6nH8DXVD8.gZrBRzOGejup0eHeWKiF8A
 uX2BwkLrmErxynDjcSp8EkUgnK5FReoMMYcZCdc49ZXZVr6ml7gpBNDG3QrepHGmT0SnMLfAb1JK
 TAkc4nGiXp40S4woqzgTdq59hogPFEaKK0HZ_U9Vv_5aaZzbcReDfaSvxePLI8zmG9faGgL4xJbn
 zdqocjRo0BWd.MikVi.st.kaFimXVinmY469Odt4wkqsQqaftA2gOvApNw8CiHr_ZDl6v5Df5fIk
 IYAksJhEbjdRWWAb8LDrxg8nN9vRbBQVKMA9238MdAaW.TC90fX4ECLzM_ntWyIy_QKafov7_i99
 v6DiZ.hdzcnX5ewkTG8RKztU5.bFbQPwcosPqu_ylTU9XGzfkztS2_ADFksS2QLoRgvSInDn.e7H
 zvPeBbdijzBszDc0Ln_aZGV5is_sw.n7bEL8sn1_Jo1zHHmyLF3Uhs.Pd1VJ.7b4aqJUmEuYz8UT
 J19bO3c5jn9WHJ5lbUsaxj5omaihpLo.W0iv5pscBgCnahGvs.SQC2F2pslKV62ei1ubsnenFeMJ
 KmeEevS55hoGQkOQHdFc9QnfFLyQn5lIo9Cu513uyg99AeZgpTwEgL4ZMmqHkNP56oyuLuuE1Gek
 3OP4ANfHUf3nO6hoiRjsJ4l1rqmUBIJgWKykyK16KBJ3Q5qcfOnnQehT3fZLdGVjvCqr.j59IP6B
 Qhm5xdU1ygt6rrRcnIcQAXvfuhUHsLv4y6ZvtLVTiZ6iof1P6Yko.0zRzZd2H2etzW_efNvXRVid
 vpHGup.uRUcYs2s7ssNCpo4VgA9VM_Y56mBqBWk2jGGsZBreExzFY9MJx2XtnM0EDuINQwOnbvNl
 FuUd7En8vaEJr55muuYkNGAhRC4vXCSbYpFSjpxX4lGMe.qzRSJKX0ZTDfR1P
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 7 Apr 2020 00:27:18 +0000
Received: by smtp431.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7593e4dc8c01eb675fc5184df100ea11;
          Tue, 07 Apr 2020 00:27:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v16 23/23] AppArmor: Remove the exclusive flag
Date:   Mon,  6 Apr 2020 17:01:59 -0700
Message-Id: <20200407000159.43602-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200407000159.43602-1-casey@schaufler-ca.com>
References: <20200407000159.43602-1-casey@schaufler-ca.com>
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

