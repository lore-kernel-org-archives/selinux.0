Return-Path: <SRS0=4d9t=ZF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B10C17441
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860B321872
	for <selinux@archiver.kernel.org>; Wed, 13 Nov 2019 00:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XguIZOOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKMAA4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:00:56 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:41093
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726969AbfKMAA4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Nov 2019 19:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1573603254; bh=LCpRAal86o/xAMqGwYkdQW9t87uiX/01PxsMjwVKvIc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XguIZOOr9hKgExTzpjJWlulbudNJGliKHz0ORO2d9fqTPBjXJ41qcxoXxspdFl/im1lB9xcQ01x40Om5/1Xlk7mHu0nn5FsDxe2GEqxko5XZ5ol+JKV7I7uNKVf9kqG6PjYWnNbsxpVsOr9tdLfSDZaSvdftSmJKO+IDUwKaA8VddIE4fETIsAofjSvSIGQFaNbpwTPeMXwrXHNAyPRaf9sS4o0YnPILO/ZWr027FSY4Z/gh6vb5verRX/11TFlhoJ9yEKUokqJubaFGj7EQr7pY/PoVYBC3zuUhWr5MBlk+nOpYN9F/ks0dCbPYquzfD4sPnrQFi/iTFSi2JE2mog==
X-YMail-OSG: nz6T0mIVM1n_HJgNL3sqoxYSEXpZNDoQL2X2e9gA5iks93BBoLsDIvAOaqS72Xv
 OKa_hZR0gx9zLC.ZZhBVYzQZNPDQwZ4NuzjhZIPhpb0Y7w9sReJedng7iIX2.mLa02zRezwE60Xz
 1tgbGg1UKruaQMKCHj6exQb3GMaKFvnarp2pjMQwkPsGtrMDx73SJCp7wLStahIbjVq90m7PuYTb
 F5tqDwqpAQ1UxAMbFiYaJ09nH7rpXuj9oL5fAxKThjv03GDMgG7ygHjNw4Nl1ZK8yygTHsY65C7g
 QW5ffIW8nKdVYlRHMzov7OZpLHw2ji5qt0gKaoRiHZECtmyJWRhQXQPkzCT6vBjzH6b6D7w8Z4.L
 JOPK00yZ_JYMGKTqEyj09VCriRjB_31789b56dSWtgxjh3BHQ6jnLnJKwPI07Jla0ClXAhabr5Mf
 XfaVP9TFrjhlb3WsIKl7FFBvhg4bwHDNe3FcYFmnb4qG0StfjMotXj5ssnMHYAVppWxG4VNO4jkc
 aJxeHy8XI9xFmH16KweyTRhLijgUZy66tonyu.FL2JsI72SjiVfZJ7eI227JE20GP8yd96EZvvwc
 fiWX5UGF90yV5Pj9XsRJZuEJF93OUkzbNjGW_2JlcT.j8TI.IXt2YdbbmGDGoxCIQ_Cx0WHqsvEb
 xc1pvToryAiOLzbJvHFrkCeUrNbjaQS_gM8fwfsLoW_A7khq6YNY9n911nF0tq1IZSYHrPdww2AE
 E712o896T3xC7WnYj4BBgy2HfTPXIAeRWRR_Izz5uu8d_mjFogldvW.zLou8DLBTUooo8AhcjQmZ
 bFyukmZscOl5ffb5ooW2V4ceNMHUEhSJ6tC.vdf859wL6nDgHXE_tsAvZ2kK9FbbcCHYY1mQYQBc
 puDheLlWLU8hQ0Q18tsEFKk4Cz.8VXDpreC8UVmGkfTydJlaqpvV0Mrbf5iPKllMdMA6hjRX_1.0
 YKVC_VCN7qTfKbuS8KiI..i83DlEJtIRuwDdBaGs65qQqSEVC9u_7Fw6PbjvDgcbLh5_4FXa.QL8
 65SoVKa2l2Wsn90zkt2ZjXoMdtUJa7AqutLYKyQx0xH5fEROF7MQ7wZkXugFUkh_v_bS6jtIM3HP
 Wd5DaUjdl1PvDDtz_Y.bVF7IoqkGdrYP91PlOptEO9UWr2anTK.RVc44parI1OOrEqU6VbPBCC3L
 ZxlU3Qc68TidOEVoX86q1BZAbg8hJ9BPdN2V3jSgQE3NIgWTvkDAgdkjgm.bCnKlurGNXsQQONfI
 Y8jFfTKJLPXXSeB4Q3hqhBC19OAutN1SBlds6ixHa3z0s95ybzFdUc2Uaedm4k_2GGGzV_F2zKNc
 YOybcbt7j2H8GOBnMW_39kY.8.p9dw_yZBRZmooh7udEvR61Kc4s_83ZIChnXVZfomX0TdzZtxUi
 WZjsn1s2_YCqrQiboiZW6M9ZD5schXGeny14jn2NxdtwG5sdFpLAg08fQrk6bKg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2019 00:00:54 +0000
Received: by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4229ab0c2c09480daae2d5bd36928ec2;
          Wed, 13 Nov 2019 00:00:49 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v10 05/25] net: Prepare UDS for security module stacking
Date:   Tue, 12 Nov 2019 16:00:02 -0800
Message-Id: <20191113000022.5300-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113000022.5300-1-casey@schaufler-ca.com>
References: <20191113000022.5300-1-casey@schaufler-ca.com>
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
---
 include/linux/security.h |  7 +++++--
 include/net/af_unix.h    |  2 +-
 include/net/scm.h        |  8 +++++---
 net/ipv4/ip_sockglue.c   |  8 +++++---
 net/unix/af_unix.c       |  6 +++---
 security/security.c      | 18 +++++++++++++++---
 6 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index cd09e7b1df9f..02ff6250bf2b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1272,7 +1272,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsmblob *blob);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1410,7 +1411,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
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
index 82f341e84fae..2a5c868ce135 100644
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
index 7879da7025d2..bd685be33b56 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2059,10 +2059,22 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
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

