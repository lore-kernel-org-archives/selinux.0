Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CAFC35242
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8DC222C4
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 23:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aHfthvdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgBNXmz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:42:55 -0500
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:39611
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728093AbgBNXmz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 18:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1581723773; bh=GV4fsCtl9Zu3zO8p52d7tePzz4dql89E4KeJ6OVte2s=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=aHfthvdhxBCEpghpEwVICH77e5AmGG6th09NF51eT0SmqRHRA9KY4vBYhgtslKvXtv+6NfFFjhI5ab0hkhCmUcLk4q/XBycSvW8mcfHJGIyIAs/29cGAEQcLnstunkeVpxrwKOD+IkMgE3/aY2EpObJUMpXpn7gM4FQnFqQsKVfoyK4/vcDLzBCmoWU2GGMnpwF1oml2GmiJyR1LNdG4voeLmRrAa3NN7HwPfb3a06eD8bTp9eehqEYpj6CWa7ZvSUEx8KGQVmvC9/scmO4VaeyGN4lxC7I2H06oPbbcZg4+FbYrUNxcOfy6XX0Tr+lfVNY0abdHXa2AalYtSuLo8A==
X-YMail-OSG: 34W5cikVM1kIV8pzdR9IKr2KZpCedlWAjIT0YnpOOMWH6uX.p4b9COqBiZr6vKs
 s4cudLTqHJaVVQ8y2mJhCNl2_5F6hhvuYJiW.nSgesQmHv7LKLT_YSR_G5YRRcl1kSzpw8eW3_E.
 Bv.Q.1zkC_VkP4ieQv9ZlNButA4CHVTPIS_.t3zNiKc8E2rfCqutEUY6uYaMs18xfT51XKsTZ3Xg
 Bn3coRmor09FzASuqVkyUN3Ze8imqIAGNXW2o02Lrd_5SIpxBXckBsSI4d_lvyaBnq3szoawwSvg
 so.Qar0ms24oyv9162sNPpLFrn24nJjvhq6sBU3Y37mH32JHvN5PgKeycoflby6YCAqU7tsSof6L
 TkxX8DIR2pxJ_bBiuNRIJmwuni2RYsYzZ.N757txfkMIrUyIfhiPVulgg82p4HwYcpdlvQW1hr5Z
 uRJm2LsOcB.6PLF3jCEXdlgPhfYOzsEvAjjI_j1NBdKB7947F8qmVoPzly3kBvkG3L4qFm3.tNJf
 xLYZlUkG0_rthjWp.9LGZTiQDbT7q2idB2gRV2KZjuvKF1Iapn9PZTWGzQVue6_R.UARgQ2nke2p
 D7ZYp91epcIhRd0gUe6zmyDZmB8I.TbCHZb9EeSpyWfTInRAagp.PZmBTlQRIXbQOhwQ3UWEqmLD
 traEJLf9OIuTTfng5l4d8a6dcNj.JKIIC37IKBq9YbZgRXxY3GTDgaIE3ypHQI8HH5PGVEuuOyc5
 Qk4r4zvi2chGhQW76BymngUt0lHsO3s_g3Cth5BJSeYa2_UdBUQSyFd7FEG9PUEh7WtV3T99jWhK
 vmbwr.Gu_kO0O_HMEY0z.T71_3A1yZX5oO4HuOtOeuprdcUTCBKex9RxWASncck8kDu69XbtQoaQ
 p.e4S0DwuXGyjz0DqW8qaRhNSOQIMEDuijaP91FdqTZodEtqAVREgN_YtN7uetV1rjQbO0llaCjI
 LLp6N3yLksmqevaTrZVqgDLPMYouxjze3Z.hYVRpz9mT52W.dje6auKQwy4_JLEaRv.6sNoDQBKT
 Xgibt_NUTgFsI_DT6j8VMWNEcM55oJS49zX3rPb2pIY0VqGblfAtc5xDsUdLWOB9inNu9BDzpwzn
 6Jpu1LczOuAzR5wBI9n3eNecg2EuGCQFD02oSm9IW3JbJwucfxfnwst7jYpYmZGestZvbBWMvv2B
 0cpGDo6Xg7m.5c2uh0qJScRdBv_RsHQpX6kpn9F1fQc2vXzuipYr60OVQvpp9.BhIgxgu4HFtx3r
 Q7wetZzxwUAXA_5uMM_74.jlpvEjqu2tFY_qGsuqGEYwBdLSgEHMSy53X9X9XUsOhl2zdc1JuSpy
 yFBvGyQf1LCV4DCZMaZPLYy.AHKMAL_KqwTxoANFTq7GOR.yIUl0cJvOJZ..uJs46cIot6GnO8bV
 Hy5acV9Kdn3_rtCIblgXPIa6W_ylUknXELWzWCj_M5hSy3D2fEHRSRO3s9e45bVYqPaoj
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 14 Feb 2020 23:42:53 +0000
Received: by smtp404.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b292bb0fd345409316b9003c09784b73;
          Fri, 14 Feb 2020 23:42:48 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v15 05/23] net: Prepare UDS for security module stacking
Date:   Fri, 14 Feb 2020 15:41:45 -0800
Message-Id: <20200214234203.7086-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214234203.7086-1-casey@schaufler-ca.com>
References: <20200214234203.7086-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change the data used in UDS SO_PEERSEC processing from a
secid to a more general struct lsmblob. Update the
security_socket_getpeersec_dgram() interface to use the
lsmblob. There is a small amount of scaffolding code
that will come out when the security_secid_to_secctx()
code is brought in line with the lsmblob.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: netdev@vger.kernel.org
---
 include/linux/security.h |  7 +++++--
 include/net/af_unix.h    |  2 +-
 include/net/scm.h        |  8 +++++---
 net/ipv4/ip_sockglue.c   |  8 +++++---
 net/unix/af_unix.c       |  6 +++---
 security/security.c      | 18 +++++++++++++++---
 6 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 1bfaf9ece13e..2ad58e2900e7 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1358,7 +1358,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1496,7 +1497,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
 	return -ENOPROTOOPT;
 }
 
-static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static inline int security_socket_getpeersec_dgram(struct socket *sock,
+						   struct sk_buff *skb,
+						   struct lsmblob *blob)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 17e10fba2152..59af08ca802f 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -36,7 +36,7 @@ struct unix_skb_parms {
 	kgid_t			gid;
 	struct scm_fp_list	*fp;		/* Passed files		*/
 #ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Security ID		*/
+	struct lsmblob		lsmblob;	/* Security LSM data	*/
 #endif
 	u32			consumed;
 } __randomize_layout;
diff --git a/include/net/scm.h b/include/net/scm.h
index 1ce365f4c256..e2e71c4bf9d0 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -33,7 +33,7 @@ struct scm_cookie {
 	struct scm_fp_list	*fp;		/* Passed files		*/
 	struct scm_creds	creds;		/* Skb credentials	*/
 #ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Passed security ID 	*/
+	struct lsmblob		lsmblob;	/* Passed LSM data	*/
 #endif
 };
 
@@ -46,7 +46,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
 #ifdef CONFIG_SECURITY_NETWORK
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
 {
-	security_socket_getpeersec_dgram(sock, NULL, &scm->secid);
+	security_socket_getpeersec_dgram(sock, NULL, &scm->lsmblob);
 }
 #else
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
@@ -97,7 +97,9 @@ static inline void scm_passec(struct socket *sock, struct msghdr *msg, struct sc
 	int err;
 
 	if (test_bit(SOCK_PASSSEC, &sock->flags)) {
-		err = security_secid_to_secctx(scm->secid, &secdata, &seclen);
+		/* Scaffolding - it has to be element 0 for now */
+		err = security_secid_to_secctx(scm->lsmblob.secid[0],
+					       &secdata, &seclen);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index aa3fd61818c4..6cf57d5ac899 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -130,15 +130,17 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
 
 static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 {
+	struct lsmblob lb;
 	char *secdata;
-	u32 seclen, secid;
+	u32 seclen;
 	int err;
 
-	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
+	err = security_socket_getpeersec_dgram(NULL, skb, &lb);
 	if (err)
 		return;
 
-	err = security_secid_to_secctx(secid, &secdata, &seclen);
+	/* Scaffolding - it has to be element 0 */
+	err = security_secid_to_secctx(lb.secid[0], &secdata, &seclen);
 	if (err)
 		return;
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 62c12cb5763e..5bed7361ec4c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -138,17 +138,17 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
 #ifdef CONFIG_SECURITY_NETWORK
 static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	UNIXCB(skb).secid = scm->secid;
+	UNIXCB(skb).lsmblob = scm->lsmblob;
 }
 
 static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	scm->secid = UNIXCB(skb).secid;
+	scm->lsmblob = UNIXCB(skb).lsmblob;
 }
 
 static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	return (scm->secid == UNIXCB(skb).secid);
+	return lsmblob_equal(&scm->lsmblob, &(UNIXCB(skb).lsmblob));
 }
 #else
 static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
diff --git a/security/security.c b/security/security.c
index 914aecd89822..2fa826000889 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2140,10 +2140,22 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				optval, optlen, len);
 }
 
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	struct security_hook_list *hp;
+	int rc = -ENOPROTOOPT;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+			     list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
+						&blob->secid[hp->lsmid->slot]);
+		if (rc != 0)
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.24.1

