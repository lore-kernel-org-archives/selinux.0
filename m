Return-Path: <SRS0=/AWk=UR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F47C31E5B
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3102080C
	for <selinux@archiver.kernel.org>; Tue, 18 Jun 2019 23:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="THPqksN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbfFRXGT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:06:19 -0400
Received: from sonic303-28.consmr.mail.ne1.yahoo.com ([66.163.188.154]:36103
        "EHLO sonic303-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730879AbfFRXGT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jun 2019 19:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1560899177; bh=hrIB1HH4Pd6L2mJ7miMQVswdfAO8sC04SqOZqTRmlfQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=THPqksN2Mmn8ZtcdUPfQMQ6zsKa5ZCZ+6vOsVGex9MOCwO/AWxJo5ZU+JF1hgIwjfvrVGPDBFyQ9i3csR6SQKEdfFTbLZasVZVWyVVwm6BbnBALFnMewZH75ZNIpMJAFAs5hSI2tASv8h1bqJ1SlRSxZkoNRAO9LRyABd7OnBPOkbERR1H6m0r4IXJ+BX/jcVfN++VAG4g8ix5HZcXuGMI47oKRoKjprV7aJHITYr6Kmc10QSpPM1d+CAzFEKyrC80YxgWyQalLAqH9/7b+xFhrzp5zTp1DCYa2LuTlsdy6RnDN4f7PdeM1cGo4MU7+1S0L8RNvz4X6hN4v8SrHEnw==
X-YMail-OSG: uqLjJeYVM1kaXHoATdOsUhnO.dc7KrD63ffq7TbZo2VdM3yDiPZdar7zrub2P8d
 gGGLkmcOi2u29IdPmpunaMwIXDDZnaA8dZ1sL5L4AhtQgJzv3vPjLO5x23oK8IuiG4LBshosZGUo
 2t2NP8mvTUgHXTjiNhXJpX6NeNVq9mqDM_TcqjB1RKsvr97nqBbBCv7An89aIJ1GBjK2Wily4jK8
 K2QC7i7FgJAJ23loG.4ATEskPztcVg_15_uC387KhDwq_VEArkTXqUUhPI6ZXMt3CiRRAyRBvRKU
 TdM4iyKijYXRcqski4jNkxI7qKNQaOKPBkFLgFjPCq4xnNQLagsFqgKvH4lIeeXSjJF.cAJw8y89
 lQ..z031YArX7w12p2aTI1a1heqJTzSvtrAjwnjyAw11pyUEdBS.fLI0kdFPJZwLoy2yJ5np70mG
 PpNLkO6Ic210CNOB3EyRzjEmJMz_V.MHvVb.vNuzCYyBeUinWz35777JDEm4WultNvo06t3Wg5TI
 y.JOO7euzyuwWU7A_s8brhnFTELNZq2mLPl21RBf5Obov5ZFmPPX962ZoCKVr6_XGIX.9_de93Cz
 ZztamXtnmJzPzPOk_OSJqWsZqMoPJjH4hCFg4Jbr.JtGk55G6UeYiocUqGUDQB1TK5sv57j8rBaM
 8GrQf081t0bZInDGUKhXrorW9d8419dOhOIVq1Aw_89L3_IEVyI7riQbEdNmryoBIfrYkzHjiR7y
 4iAiiOpawnlvbcWWQRhjeS99XmoVH6wTvQKTfe8sNkgm1xjAbPVOoP7MRUKLrI61l12bVOL8etF0
 3yxhjTDPdAE.S4YKb50D3.W0y7268kr0_AzYyUysEMsadrsHpBltvnRvrMxVt.R52_98CwaS3e7L
 uaydcLs9QuEcj_Er90P0wItBI3wbPy1G.2HJ52evfM.dykawUZB5AkJymeT6AuixL.xTKLk_2oUb
 9lxP_66yhc13aIktjZEfnVToJXOoe7PcFa16Q5kO0z_DZhwcBu0zMYwa5HvTQ2P7vY6TGiTmB.4r
 cutxzw1JgdNcI_a_ONqSg471BJqCarV3TprJ66MOUutlCc0oLkWiVUfcTm4ZjIPcrS2owGRpJnVT
 3B674toeSssG4MeWaPxfk6UfKj6ChapObJYSazrQp2d882iVdyaDLcvP2FdTSYPhUJBHnSD7GoOZ
 loR0Bud13SKFVUYpLFjdysiDlWJSQvtTOsv9VHJv.reJ1KWj6N0XH98WD5775pIEGFmgsKrkJUYS
 KJgMEi9xxRDKvE6T3xSZLo7KmHerrz0J0QvEUjutYGQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Jun 2019 23:06:17 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO localhost.net) ([73.223.4.185])
          by smtp402.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ad2be8c6eeca573a242b1447ca635ae0;
          Tue, 18 Jun 2019 23:06:12 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v2 07/25] net: Prepare UDS for secuirty module stacking
Date:   Tue, 18 Jun 2019 16:05:33 -0700
Message-Id: <20190618230551.7475-8-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
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

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  7 +++++--
 include/net/af_unix.h    |  2 +-
 include/net/scm.h        |  8 +++++---
 net/ipv4/ip_sockglue.c   |  8 +++++---
 net/unix/af_unix.c       |  6 +++---
 security/security.c      | 16 +++++++++++++---
 6 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 89a5391f2441..64f5cc2dd249 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1276,7 +1276,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *l);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1414,7 +1415,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
 	return -ENOPROTOOPT;
 }
 
-static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static inline int security_socket_getpeersec_dgram(struct socket *sock,
+						   struct sk_buff *skb,
+						   struct lsmblob *l)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 3426d6dacc45..933492c08b8c 100644
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
index 1ce365f4c256..c87a17101c86 100644
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
+		/* Scaffolding - it has to be element 1 for now */
+		err = security_secid_to_secctx(scm->lsmblob.secid[1],
+					       &secdata, &seclen);
 
 		if (!err) {
 			put_cmsg(msg, SOL_SOCKET, SCM_SECURITY, seclen, secdata);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 82f341e84fae..fbe2147ee595 100644
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
+	/* Scaffolding - it has to be element 1 */
+	err = security_secid_to_secctx(lb.secid[1], &secdata, &seclen);
 	if (err)
 		return;
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ddb838a1b74c..c50a004a1389 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -143,17 +143,17 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
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
index 4296cd2ca508..5ed818699e15 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2132,10 +2132,20 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				optval, optlen, len);
 }
 
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *l)
 {
-	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock,
-			     skb, secid);
+	struct security_hook_list *hp;
+	int rc = -ENOPROTOOPT;
+
+	hlist_for_each_entry(hp, &security_hook_heads.socket_getpeersec_dgram,
+			     list) {
+		rc = hp->hook.socket_getpeersec_dgram(sock, skb,
+						      &l->secid[hp->slot]);
+		if (rc != 0)
+			break;
+	}
+	return rc;
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.20.1

