Return-Path: <SRS0=kEwY=UU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB7FC4646B
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AD7208C3
	for <selinux@archiver.kernel.org>; Fri, 21 Jun 2019 18:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OWrzYeSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfFUSxc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:53:32 -0400
Received: from sonic314-27.consmr.mail.ne1.yahoo.com ([66.163.189.153]:34552
        "EHLO sonic314-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbfFUSxc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Jun 2019 14:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561143211; bh=+DHcojUoQ8IuHntkanXyB7Lj9l/wLodbgw6JTfapwDM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OWrzYeSG6XTMV8q+r/qB0uuqe6K1y2c9pG1eKP06uyfmZG1hREpY7IDISo9arfZAoL1h6ga9fM0J6ZamSj2jHZOaEkg7JN2fS7HDoXeQAVxQA7kz9ymF1g0RBBYPLOvuANnmmG6dOlp7NOhCiGbki66r2NJwmj3gxKSV592haDXGfL16fH4bsBZUJ493qw1G1vpJe/THlXHjd9MqBWM+BQTQx7DdHPT7Sb5OGYdAdbYI6yrBwkpqTTk6hlEy+bdGsKBlrfjAyT2aW8/upFJxpSy4+RAUeaiuZ7SXmVR2l7z8rASLUVJRYiqilAHF+7mQtlVspM3BwxSU/iaqNDLDJw==
X-YMail-OSG: D5V43UIVM1kT32kgwSQzicpnudc4P3ddVZTjpupTLiOqk5OJYqF4h_YT65xIv2F
 jNoz1WBQcgWRqfag.v5N_xf9baBbuatFxw4WgEqESjhSBEGtR9uzTSLqGxOb7CV78UKTv_fjGDVf
 CSpcDiHgXZSPJbVeq6WVepGmnyXbZdpN.8wu.H6XiicSdd6NqJ.u39t.465z5APrNSlF2B3OtV6B
 TTmsmHWhT3_ZCGaWFh7LvSibWsN90gRvh.jqfwxWGvtr6TXw4CdcO_tK5dubYypF1VZ40XO6z8Pw
 HArOvsDvtjs2GzmsUtMRfSww74IOAAIU_t.E9pFjQWdBx8KnVa7ZuCWRhdWQCIEaz2xvFI6.tqRw
 pR4Oo3oH89li5.GItjQY.wDl5fAnqfnud7kHColgmfavpYDyAfngLiwfzfXZIyjSPK59XbkCckpv
 nm4FNEk6TvLzkg6ro2cL5EKGlVEZorFywiVOKkACAIhcxgpoJ2DFPUUX3yGA.t.SMOqlYmxTxef6
 MKtkodtjY0wm6IrSuvkvhZlB35uOyX0amtck1OTVq__IV8xup7gB6mQCJJv0y5u6jnVfSVjH2blT
 .htmucDoQVpa7nOy8TPfmKbN5WLmjC6f6A8jO8vbML.seGzrJJYo5vAfjJxWlAVj6k7ZzLwBvsaq
 GhgZh7B4NJs6wCOzT0oqylxJEUCWb6lwSXYwVUjcCZkmp1Y6TzL.5agdKk.dFCEOofZ8ZV0QE4D7
 WLX.XxYHKsoy7Vj9pbH82N_tlRIzTyX607RuA_kwkBfDvRPVRs.txpHDBdhw7eH0K9n1IbwP2uNV
 zEf4fFSYuNkp6KCMxYILm0HBqtp_BpiMXEvVjNDMav6IbOm9K9hMYA4OeA.7W3zSoGDQvQe8Wd5n
 R1TiHLqs8dbi3hpeS8XD9RbkLP.QYFU9rgX3Jpo5J_O9Ki8c6ko.eF4TFIcWhpIt7IcJEPvwnhXB
 mBuxQByO5QYNTJMVL545apULinaGdiHKtXpstCHpAzomLmaUuwbRbwW2hfvaeYxrKRfw1yqQujwY
 aUp7Ucuv9hGe8F9ADsJG6oNZnGqOPt8hbWGZnChp5QWo_iHBSNU_fvJHWtms09zCh1QS5aisycsw
 M434cCzKDPYnXMMq_l0wiF7nFebTvg.h9Ugb6wcZ7jsJMqacvu96C1Q.eoRzLI8Y4YVfenEWVN48
 vfMEm3anT82vFmt9hx_f53LBP4AT4tHT5Mk9TweFQs_bXmG9jf4AbMLq476jsNPgZMXj92hMP0Aw
 hgBmb8A15CIIugjbH5TocmANojzPtzpz5yjrXEI8rdk_HS3FRhQb27FfG
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Jun 2019 18:53:31 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp431.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0eb7bde0fe71be6c1c6028ab1630b25e;
          Fri, 21 Jun 2019 18:53:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v3 24/24] AppArmor: Remove the exclusive flag
Date:   Fri, 21 Jun 2019 11:52:33 -0700
Message-Id: <20190621185233.6766-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621185233.6766-1-casey@schaufler-ca.com>
References: <20190621185233.6766-1-casey@schaufler-ca.com>
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

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index dcbbefbd95ff..c4365434f10b 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1082,22 +1082,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
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
@@ -1196,8 +1180,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1709,7 +1691,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.20.1

