Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E148C282E1
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A848204FD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AxAAR7ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfDSAtN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:13 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:46045 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727058AbfDSAtK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634948; bh=2i685M1eG2IMjP8G8c/VGp+hY4YBwtj8BDfBKWWf31E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=AxAAR7ul0jNwVxu8TKCgLkmEaHshny4a9q6baVXT3guKsnlgF5ytkdr8mWzRxjIKPVs/zSKx2/tJvipMXtJ72QB9o0HN8dvebY0FjA5ZiD9lYIzkuWolo/orM9siJRH/1OuidKGR8NV/AEmOapxyoo1LH0psX9xh690ANzdWjH12ffC/E2BbAHvGGI0IRmZN7WjSAZPaMIdU6gjmIi41oRVCZOjRxqQFW9KEnVZPFw1/i6+fqEdcnzOY0OlIFoBUDNjODhU+Xj7d1mmlMGhmZFLe1gDQsc3xFcMAOMhH9imbK8wbMdPxgbj0tfMb9E1kkH8w2jHimigChlZ37Y1tGA==
X-YMail-OSG: bUDfF4sVM1kkD6PcDoB_Oug6DbRkVon2yThd1N9xX_X5EGaIDrpIu0GrMN1GX1v
 ..q65e2gSxsTuK.R_I5XZbgxUvzrrIsPKh.xg7IdQxh5qXMASXhHxgASSE8FYOSCnYQ8ZwSJwkFO
 MgDS306ZPmDyrtooO4xixYq1QeIWpK9xXP8n7uUF5jhJNtooQt8vQJjwyr5gNFszhxk7l.jkqb18
 _j0fyGc295btQvDs4_cYYCwB0bEglvimuoNfIjZ4aeP326hymoaVpZEGmTDWdo0uUgJnCq_XMyje
 vwJS_O5doVXatwbMhQW8Oy6_RGXedZMDwJJCRrw4svI7R2ug9_ZEMIwl43P8nexAwsEI5o8K1z1I
 gb8wZ2J7ev6nZrKuq8k0cMRf7I4cBZjybYnd_WGpCLnt0CFdiq70LAo.hr6CyBiOGypuN252Ksas
 Huo2MMVVThKp1_hyY9WBWXeKZbZpP77VigbzoXQw8BpacyosHh2LFSEZJzBqweqHjoE5expWOYr2
 3NFL5v7vafGkPBxxbQtwuQLYr78Ly5r3G0NQFGSNbtgXHQMMzvkyK29eKd2P_s6VoA3HD4yEqT_N
 L5zlDKgUAzlMNDfcnc0iZz5JXGms3IigxBGwL7sCx.5SVEyNevGfdVtghe2HGR7NWeGINbiBi8kh
 JA2seJm5rJo3feLI99n06AOB4__H4OHhE45jeaP2Lhd1TxbgAhgAMeGMFnXiQXbTFffl.582m0NO
 xJgSqphZ40h5bThUDxZEkfpuvm5LLoGne2ec4MAK.6J976u0RxH5GdoFaTTcQepmR6oNR0sJCiLq
 ZDmNC_FbpGie09QidHz7gLIqV.mYYw_RKMhEevg4x1ambmzSYhr1LVhEF4vt3kShN89SMJv0pwCl
 7SEhgtqp79yMg9sM8qZlGoGTuqMcVJivsYFee8M23FGD7Lzm_UEY1yLjYMgdhOFGyMceIU9zIGYj
 LKJLBltB2EYOgL2YtWETheYm8d89nK7D3dRIMzhev.c4GO3y25Z5aIqF46I4is27HFJLcZBpx_MB
 chibMgUKev_teVABhxyK8G48ekdqyjhIJwX89y0V4LogiLAK91eB3Rh1NItJXFqmIS.3dM7ZRhKf
 YBRma.4oJrhflmzSAHFttGDwsP2PncOZSDya9vhw9YGBlWI9bEjWehwkz.a6W64ydRBZ9shTUUN1
 wbcWLo9tNf.2YKg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:08 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp419.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 524225efee00edb3a1e75559f6c5c8ed;
          Fri, 19 Apr 2019 00:49:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 74/90] LSM: Change error detection for UDP peer security
Date:   Thu, 18 Apr 2019 17:46:01 -0700
Message-Id: <20190419004617.64627-75-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

security_socket_getpeercred_dgram() supplies secids for use
by security_secid_to_secctx(). Sometimes a secid will be invalid.
Move the check for an invalid secid from the LSM specific
socket_getpeercred_dgram hooks into the secid_to_secctx hooks.
This allows for the case where one LSM (Smack) will provide a
secid and another (SELinux) to have an error for the same call.
Regardless of which LSM the caller wants to see the peer security
attributes for the correct result will be provided.

As there is no longer any reason for security_secid_to_secctx()
to return a value make all the secid_to_secctx functions void
instead of int. Add checking for a invalid secid to the Smack
and SELinux secid_to_secctx hooks.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/lsm_hooks.h  |  3 +--
 include/linux/security.h   | 11 +++++------
 net/ipv4/ip_sockglue.c     |  4 +---
 security/security.c        |  7 +++----
 security/selinux/hooks.c   | 13 +++++++------
 security/smack/smack_lsm.c | 17 ++++++++---------
 6 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 34f98cfe2ffd..0bb064c8b2dd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -883,7 +883,6 @@
  *	@sock is the socket
  *	@skb is the skbuff for the packet being queried
  *	@l is a pointer to a buffer in which to copy the security data
- *	Return 0 on success, error on failure.
  * @sk_alloc_security:
  *	Allocate and attach a security structure to the sk->sk_security field,
  *	which is used to copy security attributes between local stream sockets.
@@ -1699,7 +1698,7 @@ union security_list_options {
 	int (*socket_getpeersec_stream)(struct socket *sock,
 					char __user *optval,
 					int __user *optlen, unsigned len);
-	int (*socket_getpeersec_dgram)(struct socket *sock,
+	void (*socket_getpeersec_dgram)(struct socket *sock,
 					struct sk_buff *skb,
 					struct lsm_export *l);
 	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
diff --git a/include/linux/security.h b/include/linux/security.h
index 8eb849d71e9d..99f9824ec230 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1288,8 +1288,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
-				     struct lsm_export *l);
+void security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				      struct lsm_export *l);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1427,11 +1427,10 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
 	return -ENOPROTOOPT;
 }
 
-static inline int security_socket_getpeersec_dgram(struct socket *sock,
-						   struct sk_buff *skb,
-						   struct lsm_export *l)
+static inline void security_socket_getpeersec_dgram(struct socket *sock,
+						    struct sk_buff *skb,
+						    struct lsm_export *l)
 {
-	return -ENOPROTOOPT;
 }
 
 static inline int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 56035b53952d..ae69718d87ae 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -134,9 +134,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 	struct lsm_context lc;
 	int err;
 
-	err = security_socket_getpeersec_dgram(NULL, skb, &le);
-	if (err)
-		return;
+	security_socket_getpeersec_dgram(NULL, skb, &le);
 
 	err = security_secid_to_secctx(&le, &lc);
 	if (err)
diff --git a/security/security.c b/security/security.c
index 1a54e7b1196e..0bbe0dfd3cfc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2402,12 +2402,11 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				optval, optlen, len);
 }
 
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
-				     struct lsm_export *l)
+void security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				      struct lsm_export *l)
 {
 	lsm_export_init(l);
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock, skb,
-			     l);
+	call_void_hook(socket_getpeersec_dgram, sock, skb, l);
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 86578f7de131..93c3982d940c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4939,9 +4939,9 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	return err;
 }
 
-static int selinux_socket_getpeersec_dgram(struct socket *sock,
-					   struct sk_buff *skb,
-					   struct lsm_export *l)
+static void selinux_socket_getpeersec_dgram(struct socket *sock,
+					    struct sk_buff *skb,
+					    struct lsm_export *l)
 {
 	u32 peer_secid = SECSID_NULL;
 	u16 family;
@@ -4964,9 +4964,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock,
 
 out:
 	selinux_export_secid(l, peer_secid);
-	if (peer_secid == SECSID_NULL)
-		return -EINVAL;
-	return 0;
+	return;
 }
 
 static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
@@ -6313,6 +6311,9 @@ static int selinux_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 	u32 secid;
 
 	selinux_import_secid(l, &secid);
+	if (secid == SECSID_NULL)
+		return -EINVAL;
+
 	cp->release = selinux_release_secctx;
 	if (l->flags & LSM_EXPORT_LENGTH)
 		return security_sid_to_context(&selinux_state, secid,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3fd46cd2c4b1..e18245a52e80 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3988,9 +3988,9 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
  *
  * Sets the netlabel socket state on sk from parent
  */
-static int smack_socket_getpeersec_dgram(struct socket *sock,
-					 struct sk_buff *skb,
-					 struct lsm_export *l)
+static void smack_socket_getpeersec_dgram(struct socket *sock,
+					  struct sk_buff *skb,
+					  struct lsm_export *l)
 
 {
 	struct netlbl_lsm_secattr secattr;
@@ -3998,7 +3998,6 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 	struct smack_known *skp;
 	int family = PF_UNSPEC;
 	u32 s = 0;	/* 0 is the invalid secid */
-	int rc;
 
 	if (skb != NULL) {
 		if (skb->protocol == htons(ETH_P_IP))
@@ -4028,8 +4027,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		if (sock != NULL && sock->sk != NULL)
 			ssp = smack_sock(sock->sk);
 		netlbl_secattr_init(&secattr);
-		rc = netlbl_skbuff_getattr(skb, family, &secattr);
-		if (rc == 0) {
+		if (netlbl_skbuff_getattr(skb, family, &secattr) == 0) {
 			skp = smack_from_secattr(&secattr, ssp);
 			s = skp->smk_secid;
 		}
@@ -4044,9 +4042,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	}
 	smack_export_secid(l, s);
-	if (s == 0)
-		return -EINVAL;
-	return 0;
+	return;
 }
 
 /**
@@ -4458,6 +4454,9 @@ static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 	u32 secid;
 
 	smack_import_secid(l, &secid);
+	if (secid == 0)
+		return -EINVAL;
+
 	skp = smack_from_secid(secid);
 
 	cp->context = (l->flags & LSM_EXPORT_LENGTH) ? NULL : skp->smk_known;
-- 
2.19.1

