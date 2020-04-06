Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEE6C2BA80
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453362072A
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cUdCFPWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgDFUl2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:41:28 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:39178
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgDFUl0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 16:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586205685; bh=6SOK7+hRra9jNEqK0YVEKQXdCbnnZbAk5X8b8iNnurU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=cUdCFPWBVDinuzAhKjBcil9wcBwrpNmqtPlqqPagIcfLz2vYB7J7XBdVoGibPCuyLgUog55RrwrvcckF0fZ4qf1Cop+GHPBeKLsH7ZMwy0gC0tGs112h5vNe6S/bB6F04Rniy6q1KQvjbc0psqu1qGJG48Qvbymz0G9An91fTM+7CvkJP/r4XrGTvvSrp4nY5VQIxSE+PuoTioV+oKzEi40S2m6T+TOID4aY9DLQfP2iQbZWlOewrcO41GsZ9zf0fkRZgM9SQkkz7Q8fGziSUNvitN5ZiQZh1R9T8Jn9tOGqrf0i73usRescs+5AD/KOCeAzBaCSbDSZ5VRNmWAmcQ==
X-YMail-OSG: Jl.Oo24VM1mF.edjV8ohtUp.dRt2FqG3_QIbBRS7Uh2OTg0SyAEMVFr5hJApIxX
 rNBCQzkYmEPKCJmtUFB1RqFcJHwZ650qW1ibMVMOeygCuHDp4oPgsS0xkgCI4tHoa656x1Oi6nry
 .kT6bWv_QMp_fwZXEtbOsW_gP1VFvCJmpHG_AJSX0ryveI_g78K9in65XvT6Fh0oUh5PbR6O740X
 .T2YDhcqZr8ZD88JK7X7Uau_nEtmwD_1GWTao.PLVl4s3FdLka.f1ewk.ISHBoYz.HxJljK6fzW.
 ubZM17WR1m7K05PWqsa2yYwgzNI9BDO4e02SuNMENgPctiiDnHXILIPGXvvISr15YRajzcWZ60y8
 yNSaGldsRI1zk4N9F97p3Eh2Xh4AvoB9t5csvZZsvzvBxe3jgHbaeiVyMfX2jdQEWukKFvFVa13X
 7uKhGfc2uldCEg4B36sXPhLbWcxtsGTiq9APUpzrb2884YzqZkMUs9zNGt1WMwxyOYMMwOEZEL1Y
 kPKtU8JxwOoHx0IkLXIEEeQBAmqZuTPOgIE61xtqY1UVt4puP2uARXi_qp1XDHEsAdOTKYyEV.gO
 zkXBGVz4DPS0fSbiQIMCZ_c4lAHHbGCfCNo7TxY6RPOtipnxd152Gu80yMni5nzKCvFfs5sde5lp
 LMi361U0ryBBSnqfDxQAg6.6jQ6pwVb2xurrUvNQRTzbGYBvmUJgObS6onKVUbK6mRpRZI4Zb2Eu
 FJjqcMflW7hLNKYCcqXxV8Ca4E_0MsVRRyHBGjm7XF9wuwug.g6E.fZwejnZgc6.szvZwaF0zKDu
 RgqsUjxcQI76nZUgDSFdl80TRjZSnDqRklgbFJplUJ6yC.iqjyVAJXeWB8CVL.vL6T3_ZkjgGv1O
 JdwH7bvr7NWf0dFaGdChtnZxK99izfCrBxWsvWgL7PE1rHefMFP9e8ywHKoMJQ1EEeULeU6htZ5N
 3VqWoC02fR6S_5Tc47vhk1JZJfaopzLnjMfW5nE7sXsTf7n4e8IkjP.hzNnTeATtIguwA.5uLGHo
 f.1NbwOaYcDyxQe9bo2KJS6w.hsBgRfp0Pm4Kqc1Z9ecQLloUvb9MejJh9YaWQsg3MRcPfi4ABp6
 zOdMI3s.Sk09hq91FC0u2QEc9Ck9foVWp0IJ4aipD8jKvnQL16vW5e.atu.XTmEfGgqgKTWfbvaZ
 TgXYBeyV1ILrrqFFK.htTnluoaTZsFqWPEsT8TRPCt6V_7r7hyXPxFAy14S8MA0CdNJpjX_LTAm.
 .8oFkO0O4KAG5_lttWe6_De58BtNDQVhrYZU_xlkB1BkMF326yU3ikQQ_Xe1OkFAHp_jCOzLH9Js
 OR3Mfj.lZWj3XJ9y8QE3ftURX6Ts3HfX89IrOioXhPCpkDdrWF9WQxR3cSAiYpuy7zG0cL88sQbT
 cym8UwyiKhcZsx22TQt1idlPUNm3nc1VSFTSHWZQ1zEyR
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 20:41:25 +0000
Received: by smtp421.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eac70c79f4175a564e746280ba268c3f;
          Mon, 06 Apr 2020 20:41:23 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov, linux-audit@redhat.com
Subject: [PATCH v16 05/23] net: Prepare UDS for security module stacking
Date:   Mon,  6 Apr 2020 13:40:19 -0700
Message-Id: <20200406204037.42262-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406204037.42262-1-casey@schaufler-ca.com>
References: <20200406204037.42262-1-casey@schaufler-ca.com>
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

The secid field of the unix_skb_parms structure has been
replaced with a pointer to an lsmblob structure, and the
lsmblob is allocated as needed. This is similar to how the
list of passed files is managed. While an lsmblob structure
will fit in the available space today, there is no guarantee
that the addition of other data to the unix_skb_parms or
support for additional security modules wouldn't exceed what
is available.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: netdev@vger.kernel.org
---
 include/linux/security.h |  7 +++++--
 include/net/af_unix.h    |  2 +-
 include/net/scm.h        |  8 +++++---
 net/ipv4/ip_sockglue.c   |  8 +++++---
 net/unix/af_unix.c       |  7 ++++---
 net/unix/scm.c           |  6 ++++++
 security/security.c      | 18 +++++++++++++++---
 7 files changed, 41 insertions(+), 15 deletions(-)

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
index 17e10fba2152..83c3b3034030 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -36,7 +36,7 @@ struct unix_skb_parms {
 	kgid_t			gid;
 	struct scm_fp_list	*fp;		/* Passed files		*/
 #ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Security ID		*/
+	struct lsmblob		*lsmdata;	/* Security LSM data	*/
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
index 68debcb28fa4..179876573d6d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -138,17 +138,18 @@ static struct hlist_head *unix_sockets_unbound(void *addr)
 #ifdef CONFIG_SECURITY_NETWORK
 static void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	UNIXCB(skb).secid = scm->secid;
+	UNIXCB(skb).lsmdata = kmemdup(&scm->lsmblob, sizeof(scm->lsmblob),
+				      GFP_KERNEL);
 }
 
 static inline void unix_set_secdata(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	scm->secid = UNIXCB(skb).secid;
+	scm->lsmblob = *(UNIXCB(skb).lsmdata);
 }
 
 static inline bool unix_secdata_eq(struct scm_cookie *scm, struct sk_buff *skb)
 {
-	return (scm->secid == UNIXCB(skb).secid);
+	return lsmblob_equal(&scm->lsmblob, UNIXCB(skb).lsmdata);
 }
 #else
 static inline void unix_get_secdata(struct scm_cookie *scm, struct sk_buff *skb)
diff --git a/net/unix/scm.c b/net/unix/scm.c
index 8c40f2b32392..3094323935a4 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -142,6 +142,12 @@ void unix_destruct_scm(struct sk_buff *skb)
 	scm.pid  = UNIXCB(skb).pid;
 	if (UNIXCB(skb).fp)
 		unix_detach_fds(&scm, skb);
+#ifdef CONFIG_SECURITY_NETWORK
+	if (UNIXCB(skb).lsmdata) {
+		kfree(UNIXCB(skb).lsmdata);
+		UNIXCB(skb).lsmdata = NULL;
+	}
+#endif
 
 	/* Alas, it calls VFS */
 	/* So fscking what? fput() had been SMP-safe since the last Summer */
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

