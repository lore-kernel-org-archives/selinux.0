Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666F7C43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 329DC21739
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Lo9JKfAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLPWgw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:36:52 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:33343
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727524AbfLPWgv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535809; bh=yhnI760CPr/sBafiHMdBGzxWiIu4dshXzgZSP8tu4fE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Lo9JKfALLKeRuD+HeToXMWvSUHMMwcaNQxFaWo48Fudu7FSKJBwVBrESr6Woik3DlRDZbQ5UnlTtPbIx1y8OmrKS9HVzHu8F/ewhgGw913zbwUUek2Z0EmMOZ4pNJ3c+LdM4PB+SQvdIeeGas/CQWPP4t8r2cGRZ61t1jpHO/vMUhaN8XiV+tYkbPCEfiKOA5alct4BwYhHfG1IUqTFsTyh9aMQIeTkAWy4jAOm/BkvPgIUeYVhx0+JFMZUHZo7cKdL/jj7Ty5Jh7JmMSKD8WadJrBuR+xBrEEScupf9hFfSRcmC0r9Kdcj++kSuAjwH8lyc3JDn2Y79U49BA0r6fw==
X-YMail-OSG: mEhLnaAVM1kApLDE.biqpQpLTvrXuLjZmaP_.pTCAA.6.tc_9SX8MjC7eqCDhqk
 EicvmViBgr0OAmk8PIRQF38twAIr5WKeR7tgjGJGIR4nLykyZ3D8mcL8E02vf9lcSILwFDO4ZHAK
 uhlN2rqZlyw.OE3yOa0HZ8cnpgis4.sHRGT3cyzQDgu.8.34rlG5koqSWuo68UqZLJhDlyeXUaGz
 eFrFt87aWpMiu_Mj7JE4FOJe8ANs51fy3W3TtvrQJcn4c4hiNq04P055QILq9yuCKBfAHw_ni10x
 KH9grm.NPwE2SbmNaa.HEDr4bxOxI2d2e3bApnF7ywy7whaXRcmU.x1fZABJD63MPM6R60Fw5eSS
 mG_OoKqvrb2Cv07DT9t_M5g6weTxgn70nNJwVz5AI75d5kkJ4OyymURgLQRb3spGO0JE_vYOGbca
 xL.mN9D6VNPCs4BG.mPs2QkYvBRjJELMZZb_lBT3_nrpVCbKms2B5FJR7gbF9UsBUYhvx9J2NMKW
 ROxGsMPnZ1pPgN36.TPcwcSRK0g7KMH_ePuvi_nt0V8lqTzjSDfAj7qj6.5MkOZqt3rgmigxwk3g
 .EAzz.1npIE2A0l0fw1tb_nqISYTGxpQf5QJTFAn7AoiAPTA5BgHYuIneBl.ibZbtaw2HXSrsEsQ
 fvPxIZF.Zk0PcA935FnU1r18mmoO5qGSX9f.paxcouKzRmE3x1XRxfIKJXL0gguI7iN4yJJ0uI6u
 tEyvk8CaihQjOVXpQCasbFIrN1eS1wqSn99UBmMBp4mrffLY..JpDs11QHGyOVswLJwcXaJHITaG
 ipoNkcGmGKzRvD2UPx4ESraX2Z3oK1DQZYtcHN7FSVBaLuP8axNSqzcH4TiD7baJpyILmJjmzFhj
 gsEXF1cszy2mf3SxXSxt5hWXCufqamg2yt_6ugadn9Du9iDte2SFKhBiZkI.X02VQrcOlZecXFr7
 XWy2f.nlAP28yxRpduWdItvpw2TV63nYWFRao8LCFtBV656yhbaujeEBXi63t2hx2L9BhYJ5xQe5
 7KIzPhTErdM7zaR5A0H73yr5DMBReCwnqNegRerpNP2FDH3l2E6X8c0CChrmBhUHkqMCLreOryRe
 ys0jy0ITRl3yMB_ABkSffuj76lejF8AtRQq7Rp_5.hxAYzTNY4iJuz8WulXUeVzh85pWCysAg03N
 DwdcAdjYyeRNiJUCewlouwKyL7fktpeCRpHAnkr6lRgbmrotYA8uCrk96e8bD2OZyrBO6DCmMG5f
 GYEUm82iAIUe3O86C9TL5ElhLuxHrioe_.QXrBnM8RSiyO0bymTWNeCQ14u1djA_wHUvBnPLpAXf
 nN_oH3Oy3RzVpBd9L3Z5buQKAQfkVW.Zrpz1F.lOqgVNfHhc7CeMQi.EotKvby1f3z2AejdR3yJw
 3bwcrSkMQvga9q61kIVhl0HOpwkKX1CGHFAocplEmpzT8FRdmpIcTJrx1YtFOSxZTdw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:36:49 +0000
Received: by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d9d1cdd036ab55d1ad38f3162a989ce6;
          Mon, 16 Dec 2019 22:36:47 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 05/25] net: Prepare UDS for security module stacking
Date:   Mon, 16 Dec 2019 14:36:01 -0800
Message-Id: <20191216223621.5127-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223621.5127-1-casey@schaufler-ca.com>
References: <20191216223621.5127-1-casey@schaufler-ca.com>
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
index 322ed9622819..995faba7393f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1356,7 +1356,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1494,7 +1495,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
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
index 7cfdce10de36..73d32f655f18 100644
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
index cee032b5ce29..a3be3929a60a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2108,10 +2108,22 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
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
2.20.1

