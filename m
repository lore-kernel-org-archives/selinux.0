Return-Path: <SRS0=MX5b=5W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FBBC2BA1A
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F5B20748
	for <selinux@archiver.kernel.org>; Mon,  6 Apr 2020 20:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CyU34kKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgDFUvP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:51:15 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:33626
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbgDFUvP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 6 Apr 2020 16:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586206274; bh=6SOK7+hRra9jNEqK0YVEKQXdCbnnZbAk5X8b8iNnurU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=CyU34kKFJFreuUN/KllzppKRgwcPuIQ3EVE4O0oVyAvRzIwrJDRp0fXcyrDhG/2W5Qhi6RQZsvM0UgBFLPNEsfXjxy87boqE4TmMAE8tMnfi8NP/nAx4ID246uIq+AOQ2qSqeaaWK7RqP/iv9fjyaMLTp7E2eYOeFJmER9g3DO3tYeQzcjJGMwz9Coe41/rbkMPUYQBFco/I9x2jJOV1cal7rz56QgjcrGe6vdFzjo4cOrQjlVWa5KZNr83H1Ov2QUsvo6nD2dnJY8Qs/mRH/gBGzJPWfq0SCUMOA5N6cjaGwEmvwXpa1+3rP+BnPFkcISqkdI7Wg9lGVGQ/d+Nijg==
X-YMail-OSG: M_WYke0VM1mqckL5qJ4FrwlYH99XrARcdRUWmQQrI8O1UbzX5F.9QLQyMow7ekQ
 xkLmvkOEhkfzp9HH9KSezqoXjZq.jWev2O6RygP7MVtRQGFa2StUK9YcPR6NJ9p9Q4xANXlyTLzQ
 8dO2.gaieqfFyDfsgHVgRKh9Br_oDb.5ktrk7LnXZfnUgs00ibaK_RY64o_y2gvPs2PDYpCX1bz6
 Z.8mFXQftKN0nM78ueQewB35ffmcbFP2papusAXLBRnWYpkR4iSUK7ZmdPBCNQFhiB1Fs469uITk
 Py3Ams3_.3M8eGhGMH5NZzwc1iPNgT8Hnsj9Yjo9T3I.8Ma9ProPxv7DvAx1pFoRLZMfgORjvk_P
 HhSLr4Kswlx_UN8DrOiFSDZ.ShMiGorYBHbgwi5r8QJHcsN2N20Pn.MtvQNpWh7GPZ563lBtXPkq
 DeKaSv_T_8tYe8eL4bYcKRtWBnDrgmPQbztMlsUO5ZZWQXfi5unjrtQxChTEcMX.jrNy2ng5DfXO
 epLhJTmqetKHgRwmGs7AeJt3jTW_bPIVZmCDpQQXjsdk_Zw2apHkj3dEP7ABdiNeTDeP0dXXcvAo
 hT907l9IhlaTppTVWe6uPsNBNL5IuE_kjuhKnXdjlpxz4CUlL4AfIdgUzzopaghrWpyrsw71MdUq
 16K0JUNipHVnT8kGz8BQyRDjL9AZYLzb0DcDnng3nVnzi5KwArplKN7jSgpvHbKa4u1zQErqhPFv
 toTLEn_lU9xpDPHSg2UibcZt9dwH586AA3hexQkyaszkdpQExs3zx.j4pFdKNrbRknhcDGuaD1zT
 thrDGuWEqkllurMxc1hYYDbisEsOGIMy8PIgIhxTVg9WaVWPvTRop1E4g9afy9q8pq9_bk7DiFfP
 dxeR8ixYcKpIxJA1SJAnBPXYr6Ofa.U.jZvazd8l0SlcUIYnOQ0ytvDyV7Sx8COukfMEIgEmEnXr
 wAy3JHHQ9Lkw9PF5PAwSqBycmczZ_j00QunrmUysH6bGW7rvpvov.GBrdBk3yrga1UHh8KxQ3cs7
 qgFuCXTKVaU6o1J4dcQut5yJ8Zk0PgazykXVbRur62QlUD.QOL5ie85gFg1Kgrmlp66aY5pDgwjv
 0d5FeYEsKh2GdO3poTasKEiEW6WSdfthdRTZAnHWs1Dq_NHeW..2g2sZdnvOZhF_ojVbzhnWeZc9
 R6QEn2XZR9eIacq8WYNexGgSpyoevZq5avDiPKUXbgPgctFRfqf5kqUK6CgLK_sQCZhLaykdIJAN
 AApc5fb0FQHVDKcELwMNhAHnNB5iT3pf0lGnOR6xi0Fl_IptqVP6mYgdW4uZRobHMQCjPJTzI4sd
 E1.x_OOJR.4LNLOLTqBfPfowHCViy.MBpdXWaxxUUb2s43Q93oHiWMm6IVK_9k_mcs2UOGuPZuww
 IlaeIhTBcDkvFKnatqoqzNor22yIFVqv1tKvofLT46lfSzQaaUMYWy68vL1Y-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 6 Apr 2020 20:51:14 +0000
Received: by smtp417.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 2eb94594504b5b7128e51d68e6c17b33;
          Mon, 06 Apr 2020 20:51:08 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v16 05/23] net: Prepare UDS for security module stacking
Date:   Mon,  6 Apr 2020 13:50:05 -0700
Message-Id: <20200406205023.42338-6-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200406205023.42338-1-casey@schaufler-ca.com>
References: <20200406205023.42338-1-casey@schaufler-ca.com>
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

