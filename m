Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE82CC10F06
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6E9218AE
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kQ9go5BO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbfB1Wo1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:27 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:37128 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729362AbfB1WoZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393863; bh=0V5B3ZJvSl2yLA32HH/6eUckEyfPwaN1P5MtJbG6pQs=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=kQ9go5BO0EgXbUYlJbRywr6x0AmAXAXZD1nofyPNTDVcxz/IWhGn4im3LSBLTm4BdjZ+/6xzvJQbJHrHao5cWPsj38DFlxzhIo+udvEWZ6s9twLcY7nNxjq2u0izNzsWFuL/kM3PUfOW/K5Z0CA1rJUzdNTGb06wxeU0CR3ebHlAGz82OKvACRwd38EDXyzYq1TrKM82guJAM6uJL/zn8KkYFpgWcRHV5woL62+qOwkg01MKohEtLNItiqStPy3bxY6QqTZO/SJ2YSU3vEt3Samb5sFJKnzmNJu6Q4NDdixgwMjPghyq6WmmUexti8drTJmilsas3+fn5djU5EvZdA==
X-YMail-OSG: 0tJUDOoVM1l7zshoOcLVHopcK4lT4sFxB2NxB5PUU6D8g15Tu9Kgtx7CNPAD1GO
 CvZjtP9IJunZWaMIhdxHQSL3qkq1dnKomJE76rcI6971bAhsSiNsDeB83pltsVg8L20AbMiO0A5j
 03cuKI5TeZQ6OmGmmdvD3WrP6v1k9I9ptMoMJOnyjDfKj_kXMty9o8yJrJIK00gAlQH_9t_T6axP
 gopaCpO.9IX44TonHtUfk1N.NVzO4w9BdpAHV4NfDPc2LD2j3GcCs_GTpjzJB8Fore.Q_NjN99Xf
 Y4PGGBW2hkASff7y6cgD3gpLhmP5qCmMRsJvWdzqw6W9.GOQI36EpNA_jelnQQFfhJEzU3tb2iB5
 IeC.4IHmFR1rN281KMfLM3.W0NshSNTGVXHUw9x7Ev_VNjwMOLmBZefxrN7v6TIr46UXYCUk4rtp
 rRDdMg411YK.SE4Ki53QMj_tv.77LN7cI6CDyzDf5DeyeqeYujnnb70OOKVkpKbqo6NxGIFrM43i
 .M7zFktFTMhNFxOFRcFw5nMqB1LHCEryTPcURX1E9l2X_dkQbZOboPXJXeYPrgEr0lBTm0zgW8NE
 x7uKlEBnct0uoWC_6BWkPV9L9XOW5s1DcV5NglfWBpWhErC4oprzjCagpEdKw8kUC2MIBR4r6MG5
 Kp5vQKVgHGVWmTmvzg3DnqF697B7OjsJbhvP3D_duXoWlF8BwE14GMz.TvYsZ8SXdelrJWoOFj1F
 Qe4ADWVFmTBcK8OuglU2t6jYWcBgy3N_RS8RB6eTQPs2H75LjReZs2oITP5gn6IKLYW6QaWARREf
 NVQU9qi_8.H1EzR6ghOs8n1YC4HsN30RnUJycXAHtLXTjVmleSeeSvDkTC5T8S819amZodFCann1
 bQDBwCxCNn_fwmxNZpsP9JGAWiPmYkhU7llhNE8U2K_e6NKr.ktMQXMZlEJq4NxJ0QFJgMvMAmsl
 5vw.yoO1vSddO3skF2fBQqOTl0Hmw_nZoqVz6SO1_ONRufuTijWJXGR_OhWtXkDqzfkoEaktvm7C
 e1nFdMdfzfewakwjSKxxB75B_2r247CQEKZaFwfhrSEiMx.kUjGsQXufZmddN0soK233lLaPE5Ma
 gStFEmmjoA4m.D6G0VY0htGdgdVewWiUOlezHgqhZsovxgr.FkzBTofU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 46c3ca42412e81058eafbaa96f791691;
          Thu, 28 Feb 2019 22:44:18 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 81/97] LSM: Change error detection for UDP peer security
Date:   Thu, 28 Feb 2019 14:43:40 -0800
Message-Id: <20190228224356.2608-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
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
index 58e5465fdd79..fec7f86897ea 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -867,7 +867,6 @@
  *	@sock is the socket
  *	@skb is the skbuff for the packet being queried
  *	@l is a pointer to a buffer in which to copy the security data
- *	Return 0 on success, error on failure.
  * @sk_alloc_security:
  *	Allocate and attach a security structure to the sk->sk_security field,
  *	which is used to copy security attributes between local stream sockets.
@@ -1681,7 +1680,7 @@ union security_list_options {
 	int (*socket_getpeersec_stream)(struct socket *sock,
 					char __user *optval,
 					int __user *optlen, unsigned len);
-	int (*socket_getpeersec_dgram)(struct socket *sock,
+	void (*socket_getpeersec_dgram)(struct socket *sock,
 					struct sk_buff *skb,
 					struct lsm_export *l);
 	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
diff --git a/include/linux/security.h b/include/linux/security.h
index cb392c6b620f..7edceb91d77f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1274,8 +1274,8 @@ int security_socket_shutdown(struct socket *sock, int how);
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
@@ -1413,11 +1413,10 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
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
index c4265ceb6dd0..ab1050a2dce3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2414,12 +2414,11 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
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
index e149be6226d6..22a190f291c0 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4835,9 +4835,9 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
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
@@ -4860,9 +4860,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock,
 
 out:
 	selinux_export_secid(l, peer_secid);
-	if (peer_secid == SECSID_NULL)
-		return -EINVAL;
-	return 0;
+	return;
 }
 
 static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
@@ -6206,6 +6204,9 @@ static int selinux_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 	u32 secid;
 
 	selinux_import_secid(l, &secid);
+	if (secid == SECSID_NULL)
+		return -EINVAL;
+
 	cp->release = selinux_release_secctx;
 	if (l->flags & LSM_EXPORT_LENGTH)
 		return security_sid_to_context(&selinux_state, secid,
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index f1e0f1378666..a4c8f93534ec 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3902,9 +3902,9 @@ static int smack_socket_getpeersec_stream(struct socket *sock,
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
@@ -3912,7 +3912,6 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 	struct smack_known *skp;
 	int family = PF_UNSPEC;
 	u32 s = 0;	/* 0 is the invalid secid */
-	int rc;
 
 	if (skb != NULL) {
 		if (skb->protocol == htons(ETH_P_IP))
@@ -3942,8 +3941,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		if (sock != NULL && sock->sk != NULL)
 			ssp = smack_sock(sock->sk);
 		netlbl_secattr_init(&secattr);
-		rc = netlbl_skbuff_getattr(skb, family, &secattr);
-		if (rc == 0) {
+		if (netlbl_skbuff_getattr(skb, family, &secattr) == 0) {
 			skp = smack_from_secattr(&secattr, ssp);
 			s = skp->smk_secid;
 		}
@@ -3958,9 +3956,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	}
 	smack_export_secid(l, s);
-	if (s == 0)
-		return -EINVAL;
-	return 0;
+	return;
 }
 
 /**
@@ -4373,6 +4369,9 @@ static int smack_secid_to_secctx(struct lsm_export *l, struct lsm_context *cp)
 	u32 secid;
 
 	smack_import_secid(l, &secid);
+	if (secid == 0)
+		return -EINVAL;
+
 	skp = smack_from_secid(secid);
 
 	cp->context = (l->flags & LSM_EXPORT_LENGTH) ? NULL : skp->smk_known;
-- 
2.17.0

