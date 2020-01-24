Return-Path: <SRS0=mP8O=3N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D34CC35240
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C022087E
	for <selinux@archiver.kernel.org>; Fri, 24 Jan 2020 00:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rmx90JhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgAXAX6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:23:58 -0500
Received: from sonic305-28.consmr.mail.ne1.yahoo.com ([66.163.185.154]:43589
        "EHLO sonic305-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729304AbgAXAX6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 Jan 2020 19:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1579825436; bh=Fz8sEzRXo6xINH4w52JD4gheNiJHSvDE+xrbo49TNrQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=rmx90JhHCe/0Lps6JUlI1/Zkfs5yns4XcPRTQHQUr5A+tFXeOjaeomNylRw00oWop3UQ2T8mBBLrZsmsmxtparoxtc27rJcBOzLhDY3Itvpp6wu0E//4GHIxB1S6mHtKbpdZGZSZ6XdRmwBkSUPvl+GFbi0O7x57a+cL2QUiDdH5bJdCL2S8UP7BVLgwgcJU2+tPafxeGz3XRrG4upQSDWndXa2usqhG3gI5dRklojiU5hXZIjm5+FmVmv3TK/BIFeG8v3gMaNqKsyfDlBbotkjkXD+7aZdqlXQJZKGdAQujXPtqN8ra7kAlenUuB+Z8zxkhl/+UrnzyIxao+TlNFQ==
X-YMail-OSG: rPEL.DUVM1lAQI2cHcM56XvrIwVir4kqESBnhiz9zy16Y9TETzV4hltjHcKhefe
 A6Z_FXnBE4YuYjNNdCjT8z3hLgsnTCoxcJmUtDUSQZ2RXJ_UTAwe0A6rPF_KGDBvOThPIp6mDbU0
 83G3VhuBTFh3RBY_7LASKmoLThFu8jWbqyGPcM4xUcxyN_QFs6Sykf4Xgz0fE8SPghg3xK6rOLuu
 rEXsig6anag8k8Wk4ZM6xqxOgzhA_eLrgZMdzTQw19wlgsLQWrmkmFV4x9oE1ApSYwaSx4ZD8nkc
 Bm8KnmU8_h3Pkmy77SD5Aaj9LF0hp3fSvGdjdHy3CWIKNZkMrMz6rEKylAN_0BT1xHYlr7zbdH2n
 erO6ucxtPx_Ev.pKYdR7rcur2zNVJwQReMP7smDJjW1Gfcrmf1nmDrIJOtFeORRgrGYgNo4Wc_dO
 4Tc88FXS2ywyYv4auHEwdveu6rQtzSJ3rNKXbGZs0rawWsMihrtZ2LlptcctqAKvHHVwULQmMtJg
 gR4SHYOhzSjxtUp9SMBlM9FaxQRNyEngH89Pl9iltBnKRZBBbPSrfeSZlHbcibBAG1ZE32vnSiEe
 pEIavEAwW0zQumppHKyd5RlTz5cjFvGCy32nwJjc6jPQzWkbbBj.2l.1Cupfvj6ei1LMcMVYzjIR
 Od80SGXzVNhf9H_N6b7J3qbkBCfodLpDrZm9JoXCBFZZsGgDELdvNVpp24M9.D.In.z_cLC5ZieS
 R8W7LF0Ijd5AdGtus_I0gJ4pz1YwjRwYPImhYPBDjjDj._kf6OtPCd_Ijbd59R_K8MUIr3fE.Ojt
 3g5UnUgwYdIn6v2nublQe7U2ME68pAijVnJHeRrGU5YEaTilEvJ0jv3fiNbOE9ZNemvvBuvOzbHR
 zfi63gW2fU61I9UKv0McSzyrxYbWu6s3PsJGXlXDT4swS5EtkNmj4hrkYqPdOuBOrh4xNlf7lex7
 y.Ztmrh8TEDcjG1h4m9qkKrRJwlJjy3bgLGQkanUK1oYSRdWYYfrCcr9O.KZA_1tjKNFJUgAlOAb
 I_0yXwtfFivprf.VDRBlTF75Mbl1oOPqhsttu93q0KNOS0KlyQ.8lbnu_qKuqV_IkJOltrRw2rK2
 boV2c6bCcXvbPcZHWVVjyQqOVtzTDXmHU6mx8Kjxrk7EEyT2OsEfcCz9bPXDK8auP6lME7YUdIz7
 exHHjGJUjOTNjgrozD8lsDw0AQufSbvneo_mpYxo2E7T1fCKS10qAvkb0fA4DTg3b_Ul02cmU3oV
 hbtXml8bzFricqcK8hkpXPaPqxJfLHNLVN5cKcye2jFms7CrQR6Di5u_ldLyZDTSeRvre1u_outW
 gqge_kAqVjX3AFfDpYavI.lwtMnvHW0q1raOI07by.VLtajfFY3G.lMPQ_FjBc8hRJBuLHhP50KM
 z6bOXA3IxJ8gXPnyIMOXFwIxICLDpKrztsa6hPXofWXIrD1app3Kt8gmqm9uRPIqCEw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Jan 2020 00:23:56 +0000
Received: by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7441c4768916c3ca0a3a0d8b691cbd8c;
          Fri, 24 Jan 2020 00:23:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v14 05/23] net: Prepare UDS for security module stacking
Date:   Thu, 23 Jan 2020 16:22:48 -0800
Message-Id: <20200124002306.3552-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124002306.3552-1-casey@schaufler-ca.com>
References: <20200124002306.3552-1-casey@schaufler-ca.com>
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
index 4f01878ca5d8..e53ff7eebcc5 100644
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
index 774babbee045..f0b1d741ab6c 100644
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
index f53805de4343..b7404bfc8938 100644
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
2.24.1

