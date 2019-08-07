Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F074C32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9C421743
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Bx+aL637"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389607AbfHGWnM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:12 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:39611
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389608AbfHGWnM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217788; bh=AEYYZjFov+FpeHARfZlOtSrlGNS2iAoF8Ic5MRqdp20=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Bx+aL637SRKRLBVgQM0/y4SgqZ478HpmgTpZUyc+qW132jmWaeKf5X+OV2KEFwLlHi3xCp8RLL5z0l9dWkVZ1nhjitAQbu+jr+OwdUcKPXWYoa23y0ZNtn23rDfHZZ3g/iIs/pBDpZDXxdg8CRzK0wRzIYJ/bqnZsVHGws+mVOhrm9cq+Uuy1ZuHSPFs3xXiYpdX1g0SjqAmljDt78UbSxQY8LZRQNeOjQlravt6XY72TQ9wV5qo4VJjbUla5Ci3oDbmto8HPXGg3Hml83+pmoNdjG80siOksHVI+H25Xmc5U58G3HtugmmNF4S3e6GPYSxklhNCTZ7bSixFESZeZA==
X-YMail-OSG: e_eUUl8VM1m_5BW95T1VWAjVh9L3J.oYyPX8WSOFzmSpRZygm8Nv3pq_ALsrf88
 laXZrjeWYSqJGwtSJeMDisyj568AJxFVu5HJAuDJwEBC49akcQ1CjLnCoeBLtJOZiQeiRNJ6C8ue
 DR6kltSUbx__SvChV1dk9OfvBeenJT70FwcObiN_yhNGbWN3JnUA91mOrtK4tLeT30CaeQF_b4.7
 WOlvT79aRwBAF2afZBESC5gdbIkO7CA05IV4TJtEGeh7TzFOVXvjhcN82uHiUr3nH2BcOdcRgguO
 w33sNCdwNIhgs.zSk29IbPh2uej43DQwQpAPrx_K3ppIhgJmEUvgASBz0.Mq8hV9c.JgRJmj3U53
 Wa97jTxpIdIaKjiwFqy_nebuxdAsKCRfREL8hG9p9ySKAk112Zp3DWlLg78nnc10ynJ9fvEu_XgQ
 u9sFdOfFxvtGHdf35EtDegmYpJAz.C2YAVu7_oavPgsIYOqFgS9uGLeCGfCNMmuaTFZTPyg0_dFN
 zmw8Itp.I07i.W3G503GvgmvOV5fR7chNxRBScrIZ0BxPytNMP7DRiP_Xzp_VakvJl3Piu1auywq
 Dy.q03OK3n95vW3t1oHZ1j4dTtLaWTBtaDgOhYo7FCqi934iFwuS.H2wdVuj8XyKrDaQrM9MBXGD
 FlikbXxW_aseRSnpjUOD8SBJ7voE4JEgZo.1X_NoAq5rU8nBrw0l1hyiWDtJBpBS9vd5dIfECqmc
 cwyxDzOdtyBiPXkjmtWcS46cPtB8q5PODiONrZOjdytHhGobnXH1E2sjcGAEo9MiRe46_mywFIMC
 fcsuKXJWzZ_8qo1n.xE8WPdJt.Rs6xqCP3LyQ2QvURU_CMy4ES1qFvua6tIEncPC4PE6UGRptz.B
 Y39GRPYVspDu3fqrSl4pNlVTNiRG7eYbDD2UNGaeKy8OsKwBBSsydC8P_978H0v4ZOYleHvrZRL5
 5Ohzm3oeOQpLrOd0QIHwyjAbpLc_vQP0om.TV26.oZrelFwlOEf6XpLFj91MjF_XdLpp5P_Jyo84
 4V9iEGhnvGzC9C.YJp5kMJCDhkH7P_eoE6iG8dH_oREh05XPDLo492nTl.JUDFh._2RLQkxM0J9u
 v2tjJG78Sjb9hDG9.tIiQ06pfNqyCGpDsgFA5TIBtntKHUR6r8mz4aj4i926cRz.flOoFQmnr976
 KAEJ34iKJQ2ERAFRyy.QmZ.ZJTyZPBSeAr.LEAZmh5hxAeBvhhlWeyn6NVmwoR.ivU1YZiI88tlg
 Vbh6IQCmJ_k.GxrUJwZcK6210MdjiFpUs2dGLTYVImPSaXZ6rcOKKMrY5OoM.U18aqHce0mRgTDZ
 otS6TzSU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 22:43:08 +0000
Received: by smtp401.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 90d0e6b59b40235a6b1cae6254f016be;
          Wed, 07 Aug 2019 22:43:07 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 10/16] LSM: Change error detection for UDP peer security
Date:   Wed,  7 Aug 2019 15:42:39 -0700
Message-Id: <20190807224245.10798-12-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 security/security.c        | 12 ++++--------
 security/selinux/hooks.c   | 10 ++++++----
 security/smack/smack_lsm.c | 15 +++++++++------
 6 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a54a2f4788af..67797c67093b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -881,7 +881,6 @@
  *	@sock contains the peer socket. May be NULL.
  *	@skb is the sk_buff for the packet being queried. May be NULL.
  *	@secid pointer to store the secid of the packet.
- *	Return 0 on success, error on failure.
  * @sk_alloc_security:
  *	Allocate and attach a security structure to the sk->sk_security field,
  *	which is used to copy security attributes between local stream sockets.
@@ -1699,7 +1698,7 @@ union security_list_options {
 	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
 	int (*socket_getpeersec_stream)(struct socket *sock, char **optval,
 					int *optlen, unsigned len);
-	int (*socket_getpeersec_dgram)(struct socket *sock,
+	void (*socket_getpeersec_dgram)(struct socket *sock,
 					struct sk_buff *skb, u32 *secid);
 	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
 	void (*sk_free_security)(struct sock *sk);
diff --git a/include/linux/security.h b/include/linux/security.h
index 2f442746dede..0e699d4ed13a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1329,8 +1329,8 @@ int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len,
 				      int display);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
-				     struct lsmblob *blob);
+void security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				      struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1470,11 +1470,10 @@ static inline int security_socket_getpeersec_stream(struct socket *sock,
 	return -ENOPROTOOPT;
 }
 
-static inline int security_socket_getpeersec_dgram(struct socket *sock,
-						   struct sk_buff *skb,
-						   struct lsmblob *blob)
+static inline void security_socket_getpeersec_dgram(struct socket *sock,
+						    struct sk_buff *skb,
+						    struct lsmblob *blob)
 {
-	return -ENOPROTOOPT;
 }
 
 static inline int security_sk_alloc(struct sock *sk, int family, gfp_t priority)
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 447fe60af0cd..c28cbb15cee2 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -134,9 +134,7 @@ static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 	struct lsmblob lb;
 	int err;
 
-	err = security_socket_getpeersec_dgram(NULL, skb, &lb);
-	if (err)
-		return;
+	security_socket_getpeersec_dgram(NULL, skb, &lb);
 
 	err = security_secid_to_secctx(&lb, &context, LSMBLOB_DISPLAY);
 	if (err)
diff --git a/security/security.c b/security/security.c
index 325e745ac8f5..e726fc7c6712 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2612,22 +2612,18 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 	return rc;
 }
 
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
-				     struct lsmblob *blob)
+void security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				      struct lsmblob *blob)
 {
 	struct security_hook_list *hp;
-	int rc = -ENOPROTOOPT;
 
 	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
 			     list) {
 		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
 			continue;
-		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
-						&blob->secid[hp->lsmid->slot]);
-		if (rc != 0)
-			break;
+		hp->hook.socket_getpeersec_dgram(sock, skb,
+						 &blob->secid[hp->lsmid->slot]);
 	}
-	return rc;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 65bd62dca9e9..91ef2ae77abb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4954,7 +4954,8 @@ static int selinux_socket_getpeersec_stream(struct socket *sock, char **optval,
 	return err;
 }
 
-static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static void selinux_socket_getpeersec_dgram(struct socket *sock,
+					    struct sk_buff *skb, u32 *secid)
 {
 	u32 peer_secid = SECSID_NULL;
 	u16 family;
@@ -4977,9 +4978,7 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 
 out:
 	*secid = peer_secid;
-	if (peer_secid == SECSID_NULL)
-		return -EINVAL;
-	return 0;
+	return;
 }
 
 static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
@@ -6321,6 +6320,9 @@ static int selinux_ismaclabel(const char *name)
 
 static int selinux_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
+	if (secid == SECSID_NULL)
+		return -EINVAL;
+
 	return security_sid_to_context(&selinux_state, secid,
 				       secdata, seclen);
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index a9fb5f53a248..2d88983868e8 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3970,8 +3970,8 @@ static int smack_socket_getpeersec_stream(struct socket *sock, char **optval,
  *
  * Sets the netlabel socket state on sk from parent
  */
-static int smack_socket_getpeersec_dgram(struct socket *sock,
-					 struct sk_buff *skb, u32 *secid)
+static void smack_socket_getpeersec_dgram(struct socket *sock,
+					  struct sk_buff *skb, u32 *secid)
 
 {
 	struct netlbl_lsm_secattr secattr;
@@ -4025,9 +4025,7 @@ static int smack_socket_getpeersec_dgram(struct socket *sock,
 		break;
 	}
 	*secid = s;
-	if (s == 0)
-		return -EINVAL;
-	return 0;
+	return;
 }
 
 /**
@@ -4426,7 +4424,12 @@ static int smack_ismaclabel(const char *name)
  */
 static int smack_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
 {
-	struct smack_known *skp = smack_from_secid(secid);
+	struct smack_known *skp;
+
+	if (secid == 0)
+		return -EINVAL;
+
+	skp = smack_from_secid(secid);
 
 	if (secdata)
 		*secdata = skp->smk_known;
-- 
2.20.1

