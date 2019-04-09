Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7844C10F0E
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8429B2084B
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 19:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QZIetdkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDITTC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:19:02 -0400
Received: from sonic313-26.consmr.mail.gq1.yahoo.com ([98.137.65.89]:33373
        "EHLO sonic313-26.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbfDITTB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 15:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554837539; bh=FXPJ6Gfz/Kw1RJDXF2OhaTmACwfJr6C43ZPwo4T1SLA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QZIetdkpv5AMXQ6dcyblbbtC9iIeyb8eiEqV5pezknjjosDcQtmGP8HheP4tZXkSXHemMuF3z+Z28tPx2Oq2fHjNTQzpmnm9aeAasBs2rfFcPYZXAWCIuHx8AzolrgG8BavV9EBhpRJpka+pkZXMQh5QMyhTUVKgmEtFUxyXeKX1arwX4omIN1+FX0nGktZFBWY8Kcj9Zql49evoXOFNMUzvJWS+l1LbSjUbYyuSO/zVLsIjREqdCFEEdeowkyMclPoXJFZQm7U71vobHNC8/8gIPKObCZBC0LBGdEjzEkd6LLuzTVKpdY7ef72vsrrd8AZFWwnR0+OIUN51DzTgKQ==
X-YMail-OSG: 5UuEYYkVM1mtAiN6YJ_H02kOnX9jZTQ7K_NwT2oGAGJUn6Do5foIt5QjNGk3oMk
 wHhKtMM8YGc2C1TXNjXdGE6gsK1GwjjidTD9tWGVdbU1w6.IwiiWs6HTvG41L_0A6hiN8Malq.x0
 fuHZQVZJnByX7V2Z6DtkKP_x.rB0Xaz.rAIDx7ymxP7p9mMM9YPkLSS.tdaHqSYK6UmYDCFTzGD0
 G0vqehYHkg5Ka36qVCdjlQqCt48k.qvMDrbJR2jnaNomqJLEXU456TUuDFDmvbSNNbF7_zO1CVsu
 hf1Sm9owNROsiftFR8dI0bD4EKxUPf4FwCzuEo_S1NBVnbDQEvle3YmwnbEOM_eh0i4n.OU.WZlQ
 7wwkevw6quPVzg8XtxSmi5aixqiBxz2JBt4qDdoooK5hhLd2knbZ0lZP2bhujso80.mqtTuyd7ZW
 AbMfx4m_kWBRs8cVZ1QQrseS5bnQeVBW8p.afs5AsQjCPJuoqFP1qaZq8OXO7sV09_ukHN_l5Wa9
 Egb2CnE9G95bQ.VGCTwjWR_TvZFcBa5EfOZehASEFyKRs_lbVuvfobZ9uNIaNiappmEWlWY.HoSF
 xm9wWSnlAHsuw8hhxis5k16ni8kLn4rm.zy8LLweqshqkdAKearTx7hCGBB5EItyU0YhFwT51aUR
 Kd02pynvB4OGe8LNRUXkEcvuby.y.rsu0q_KpC8r6Az7XM9NZ52jtko4TIVioQlwCm1aQ09WVgyE
 k6cSzvQNqcj2_4hZ1h1SHqwGe6T7BBnqcfQkjtMIcN9EpTUMg2soTQ0FNJhBTmtAFQ19NH4oNXZs
 uUyMLm.78NXn62K2G8FhYUguw_2hYFTN4O_zFwRY4vQ57LGy4qcPtv.9nU.A2Pu4oyZNju9_6WCr
 F8Ias.HWraQWZ2v1A0W9WIYc0uBTm1eoctr6N7ZdAGxa88YPLSsJG2MSgu9Ez73yorBtqNybXOmp
 V5u_9BXvN6C8NAQjQ6.v1d3G8vua36cLOfe7x2ixNWexn4gypI5yWDtbVasclAc7ZnQ1UappEahp
 v5eJFVdGzV1Tf5kN3Pe.5fAbAqCZQcmA3P4WDunNsng3q8phFH9J4wejHiPuqUIx3KmKpiHMAqLJ
 RZjrebMYypLcM6UbOt.dXHBqoDQoSku3cmIZjLJncgmWN85.lC0dXrw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2019 19:18:59 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b77b874e22efcf04356cc7acbadd009c;
          Tue, 09 Apr 2019 19:18:59 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, casey.schaufler@intel.com
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH 09/59] LSM: Use lsm_export in the getpeersec_dgram hooks
Date:   Tue,  9 Apr 2019 12:17:58 -0700
Message-Id: <20190409191848.1380-10-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409191848.1380-1-casey@schaufler-ca.com>
References: <20190409191848.1380-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert the getpeersec_dgram hooks to use the lsm_export
structure instead of a u32 secid. There is some scaffolding
involved that will be removed when security_getpeersec_dgram()
is updated.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  7 ++++---
 security/apparmor/lsm.c    |  3 ++-
 security/security.c        | 13 ++++++++++---
 security/selinux/hooks.c   |  6 ++++--
 security/smack/smack_lsm.c |  5 +++--
 5 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 85b8217ce2f2..59f38c18426a 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -881,9 +881,9 @@
  *	the IP_PASSSEC option via getsockopt.  It can then retrieve the
  *	security state returned by this hook for a packet via the SCM_SECURITY
  *	ancillary message type.
+ *	@sock is the socket
  *	@skb is the skbuff for the packet being queried
- *	@secdata is a pointer to a buffer in which to copy the security data
- *	@seclen is the maximum length for @secdata
+ *	@l is a pointer to a buffer in which to copy the security data
  *	Return 0 on success, error on failure.
  * @sk_alloc_security:
  *	Allocate and attach a security structure to the sk->sk_security field,
@@ -1710,7 +1710,8 @@ union security_list_options {
 					char __user *optval,
 					int __user *optlen, unsigned len);
 	int (*socket_getpeersec_dgram)(struct socket *sock,
-					struct sk_buff *skb, u32 *secid);
+					struct sk_buff *skb,
+					struct lsm_export *l);
 	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
 	void (*sk_free_security)(struct sock *sk);
 	void (*sk_clone_security)(const struct sock *sk, struct sock *newsk);
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 706e5ae09170..24b638bd4305 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1096,7 +1096,8 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock,
  * Sets the netlabel socket state on sk from parent
  */
 static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb, u32 *secid)
+					    struct sk_buff *skb,
+					    struct lsm_export *l)
 
 {
 	/* TODO: requires secid support */
diff --git a/security/security.c b/security/security.c
index 3a766755b722..2f1355d10e0d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2145,10 +2145,17 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				optval, optlen, len);
 }
 
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     u32 *secid)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	int rc;
+	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
+
+	rc = call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock, skb,
+			   &data);
+
+	lsm_export_secid(&data, secid);
+	return rc;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8d4334f68a65..03dfa0cd6739 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4949,7 +4949,9 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	return err;
 }
 
-static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static int selinux_socket_getpeersec_dgram(struct socket *sock,
+					   struct sk_buff *skb,
+					   struct lsm_export *l)
 {
 	u32 peer_secid = SECSID_NULL;
 	u16 family;
@@ -4971,7 +4973,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 		selinux_skb_peerlbl_sid(skb, family, &peer_secid);
 
 out:
-	*secid = peer_secid;
+	selinux_export_secid(l, peer_secid);
 	if (peer_secid == SECSID_NULL)
 		return -EINVAL;
 	return 0;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index da85d607d40a..5318b9e6820a 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3973,7 +3973,8 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
  * Sets the netlabel socket state on sk from parent
  */
 static int smack_socket_getpeersec_dgram(struct socket *sock,
-					 struct sk_buff *skb, u32 *secid)
+					 struct sk_buff *skb,
+					 struct lsm_export *l)
 
 {
 	struct netlbl_lsm_secattr secattr;
@@ -4024,7 +4025,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 #endif
 		break;
 	}
-	*secid = s;
+	smack_export_secid(l, s);
 	if (s == 0)
 		return -EINVAL;
 	return 0;
-- 
2.19.1

