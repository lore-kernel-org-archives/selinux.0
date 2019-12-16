Return-Path: <SRS0=HHao=2G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C223CC43603
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC07206E0
	for <selinux@archiver.kernel.org>; Mon, 16 Dec 2019 22:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="f3pQ1kfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfLPWeK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:34:10 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:45804
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbfLPWeJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 16 Dec 2019 17:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576535648; bh=yhnI760CPr/sBafiHMdBGzxWiIu4dshXzgZSP8tu4fE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=f3pQ1kfIAO+CCEkdGcjDljDC0DJXZGyrieqiXBCZ2K6hW1Yh5SZDnAhyKAxjKo0BP3Eikb4VqjDnyuViqjcgKEz4DivNK9B0xVmC7qDCI1fWSLa81TXE1bygLGI3YFxwyFQkghE4Fgw4R8ldgxRNezLxNvZyQvuCWmcqIMzMRhvXzr0PBXR3ENEeboQvWGfJeAs+BjPX/2RE/0+xGCDK9jMGKTj3l3daxBoOAz9Ggwi2Gi93i4O9TltjsEO7ooAPiMqAvTwKJYxss/xiMMuEYFSwHXWY4lhayd//z4h+F9WM4CI7WJquwbNoSYVZoh1LLpFMn5HC6jF7OXxDB07tTQ==
X-YMail-OSG: IsgShhsVM1kt2vmCykXhVYidCKSN2HFiGG6YlsDLKZ87.BhBrjgKNs0IWZgr0uq
 9r0C.G5IUTHBG6PP7Udc0IqeyN.j33P4_.IfBaGUkEWffS0RDrvsyq5VquiF6cRZCiNK_uBoJaS8
 tLZJSVIuKNIAtaD8jknuI47ohR7LTpWW1eTyViEYEZ6r8Urc.puZsKnEqJRB8OtkIqsFwqiUwAFK
 5jb2_4eOmoK_XHMGBYbCg7T1ImySg16rVKb_L_hrmjirANrvWIPwTUgeJ1cZFALlVPZpqdsA3Qfc
 CAo.hLUyKbgzSra4vHZLHcFr5Du5WDB5kPhVvdItkQUknn0iz1L88KOXzZiuHrP2sdmWzL1WbxFW
 Fp.bboFp70OLtvLYIIqhJEfw9IHGTEqkoPyn7ZapEMTdoXAnEDN7TlCVViFYH7ICBDyR8NjSi.1i
 Avc2oqhUQ2xOZWPMHgSak1k2pfQ3NmOrfcdAyXtZ_s5DwShtTni_BpPH0gzYijeoHisxazLmbvmf
 nhx6o8ABX.DVqWQ16qjENw4hMachbY5alomwSE9Ox5W0fnzQhqbxBblO36DsKw966owO.YhIfz9h
 4cdnPwQQjA3U4JbUQMfFdXb58KwPI_QcsHhrd.VxZQ.1cFi9q0YYnEqJOy6p.WxMObh3lAHzO2Us
 FDOyUbNyPlRIGAoAaif.kucsQQ45bIVlMN0yEAxn9ewLEg5esiDQLpxqc_wUqQuPSF35PVAKQknY
 6l9JJiMVo3XS7AgNuypET_Xb7bB4qutpkHgKHA7YDowVFJY5JyA8jJFjOsAtRsSmqn91i.2h_Osk
 YapqCeidczzeVz9MXHWUvz67u0JwbBDmzpKSSDWk5sgAqJ2iO09nANd6LvGmfVoUwbXZe5iCwKiJ
 goPWjKJMv4aO8__imtDPtDG8AhJJuTXWels0PFNXb8jo_7egk_nAj4AhwIMwm7OjS6RvwzQCYQhd
 5d1vBZ8970Wyk4ZUmd_98heiRgKomPknX7.cuoj_jwydDxnsPbGsva8Tx2cyyAkAoSdB3V1JOD85
 GBPWgcDPAT.k33ChFrtOS_WPzGEWr_wdpseQYX8WawSoVcCSyye6Jb6DmdLD9TXM1S_X6NQ4oOmI
 ZMGZ8RgZ2Md96vMPmQXdOAmggiMOlC0LNzil38vcW1GuTULAGtt8t5Tr0yMYRCXFdqTq1hGgHbee
 MwGowuhkK4kbyHx358pI.LuyWX5MxSXRe4I7HcoQBpUTkt0Buwfa4xA7g.Vq7hmD_PPxtmiV4g5Y
 eUa0vpD0LTHWHcPDqsz.H8FnWCzGkUJAwy4BvD3hQZ_Kt.z5L5xa0Lc0sP0XhCEl4BLNw3msgl9I
 PGjuJ.9syriqeFAjgVZJLA1YABGOftIolRiTBr9BrXC4HZkvd7IZr6rvFwwyba7ZeoGT9fmpFhvY
 ap_QoIxDzXANvS9yXB58lTIQzNcK6pT00Yr_bkXYny2jOVxSdkykdnKHC122DWA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Dec 2019 22:34:08 +0000
Received: by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID c9d34065d35cf5052e1c371e78fe445d;
          Mon, 16 Dec 2019 22:34:05 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: [PATCH v12 05/25] net: Prepare UDS for security module stacking
Date:   Mon, 16 Dec 2019 14:33:25 -0800
Message-Id: <20191216223345.5066-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216223345.5066-1-casey@schaufler-ca.com>
References: <20191216223345.5066-1-casey@schaufler-ca.com>
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

