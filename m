Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CD0C4360F
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0122133D
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KKmzWYhz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfB1WT7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:19:59 -0500
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:44040
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729576AbfB1WT4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551392395; bh=yBnhoz8U+buCNblcgn/U8UJglf8q679q3pCQpXPRINI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KKmzWYhzjb3PY3h93nwMrB3tm/P7yUb/H1BSSudp/KyagtrRLLeCU44Jys0E03zRP24Lnmns1r7zZW52QIV6beY158PBQ3+XVNCFBSLwvCOrVigY8I1pjwxXqLKc0zqUp90aaGFhaILh3on/j+I9yFX1egzISBq/vHXcdouwvx5t+MVnM5GBmNtnuWcUQL/EKHbV2C69/7364GVicHaDzo8DuIpSOFMHAMnahLyi8JmrRXzSDH+UN+uqu7bdovcDz0QQ1SQekyjARViP021dOuOGqH5q0CxsAJkT+l5qIMkrYCSQrA58Z/B47StdFultFbDzKZmmspywYVtZTmWKMQ==
X-YMail-OSG: aKU1ytcVM1l5Wgj2n1Ijvh057WMu4_22Mr.5pfe1lg7nKACal1R6RXc4CNGzHPr
 kn3l99TEY4mYgvpWwQOOahd0edNX7W6M79ybDrcVQ7Q3_oOTqOeymuQN20g956l44IV4ySXHV7dc
 597Bo7QWTdpNQ8aizAUs8mvMtXWS6nEySwa48AVWCrfkZXIszQlVo4aPwFEbAD0bYZ_wwcEL6smE
 PkVDkUYKLUIHZiorMvcjUOsCqMC.sYn5g76zQflOetuRTxF93p.GmVVbxtEj3gNq6pjBK61fcc6p
 oFD4u6PK8N_hATzTk84m1B0ycdEMuw73u_OxaNWQ4KxN3TqrD26kg_X1gIohWabFmSfWDsW.q8Mj
 sIRmA.hoGlFM8it8gTXK4xf45_cWdY9Y3_s0NWq2JJ0GtR7DJittVnw3cgXOJh_HyBFIbQYr5zbv
 LhXMHLeot4351JK2TFvE6c.1Eox8vW9bhyJGUI46jmRmXwwrTz90R7iO2uwcHkSmvJ9K6XrbA8L4
 gDSMcPzm6Xfq1AaJ_DVjyhoEBbOtnmzt2yBRePId3F3gxP0mjUVJG1Pp3y8Pu8mr2YLuRZQ7RVCi
 PMCEhMPXocWuyVMOJ8hlsUvNrE7Rig.1bz0LMcJXUowpupZwxspIzZcjthYUexNksOU.1QJGBjaa
 nDAyQ8mAbPalv4Zi4LYCdsGy5ADf8fIY7K40Fq8acYMVQAB9SHq.CehW9gq.IwVW2Qb4es9sdis1
 HBBn7NGtHhuTCKYinAXgYRsH1JOpF6RJWOBwE9DGimZR76cOQ3R2FbBQz4h4hlzwhhe4AnKZqJoO
 tiskV1SzQFGv1lb.KBxpzauMEMSFuoDYWANDDlMslLVm71hHblyGCY72xUovMpEFZ_P2ABTHtpA2
 pUx0.XWr8y9m2F2yZWhAYyvbCcazJGbSbH_fqg0kTiT9.gdUZsBuPJN8uZ.pmDnxVmvQoNnThGtp
 6E4e4QPBwKpvzXvga2.joeDYy24J2_q37USpSWp7yV7_y5mZyX9kvGkyZgqETfxor19623cL4B_P
 I4FnqfhVS_YbUgMD1yg24BSfMqoIOxoyDh3yhdyuD1pqCMcX5z7Ou0fEGLmERI68Rrw1hYMGM9D_
 lv4iAzJXbv44vn0LYctOaa6WHbzlAJtg2IrOtcDBy.z3Bby4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 28 Feb 2019 22:19:55 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp427.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0da9962b364e649f4905df2b440bd211;
          Thu, 28 Feb 2019 22:19:54 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 19/97] LSM: Use lsm_export in security_socket_getpeersec_dgram
Date:   Thu, 28 Feb 2019 14:18:15 -0800
Message-Id: <20190228221933.2551-20-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228221933.2551-1-casey@schaufler-ca.com>
References: <20190228221933.2551-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Convert security_socket_getpeersec_dgram to use the lsm_export structure
instead of a u32 secid. There is some scaffolding involved
that will be removed when the related data is updated.
In particular, the le entry in scm_cookie includes the secid
data. The secid will go away.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  7 +++++--
 include/net/scm.h        |  4 +++-
 net/ipv4/ip_sockglue.c   |  4 +++-
 security/security.c      | 13 ++++---------
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 08fb928cc86b..5837cc2a5dad 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1254,7 +1254,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsm_export *l);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1392,7 +1393,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
 	return -ENOPROTOOPT;
 }
 
-static inline int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static inline int security_socket_getpeersec_dgram(struct socket *sock,
+						   struct sk_buff *skb,
+						   struct lsm_export *l)
 {
 	return -ENOPROTOOPT;
 }
diff --git a/include/net/scm.h b/include/net/scm.h
index 1ce365f4c256..13b8a369fd89 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -34,6 +34,7 @@ struct scm_cookie {
 	struct scm_creds	creds;		/* Skb credentials	*/
 #ifdef CONFIG_SECURITY_NETWORK
 	u32			secid;		/* Passed security ID 	*/
+	struct lsm_export	le;		/* Passed LSM data */
 #endif
 };
 
@@ -46,7 +47,8 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl);
 #ifdef CONFIG_SECURITY_NETWORK
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
 {
-	security_socket_getpeersec_dgram(sock, NULL, &scm->secid);
+	security_socket_getpeersec_dgram(sock, NULL, &scm->le);
+	lsm_export_secid(&scm->le, &scm->secid);
 }
 #else
 static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_cookie *scm)
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 82f341e84fae..b8ef7677a7e5 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -130,14 +130,16 @@ static void ip_cmsg_recv_checksum(struct msghdr *msg, struct sk_buff *skb,
 
 static void ip_cmsg_recv_security(struct msghdr *msg, struct sk_buff *skb)
 {
+	struct lsm_export le;
 	char *secdata;
 	u32 seclen, secid;
 	int err;
 
-	err = security_socket_getpeersec_dgram(NULL, skb, &secid);
+	err = security_socket_getpeersec_dgram(NULL, skb, &le);
 	if (err)
 		return;
 
+	lsm_export_secid(&le, &secid);
 	err = security_secid_to_secctx(secid, &secdata, &seclen);
 	if (err)
 		return;
diff --git a/security/security.c b/security/security.c
index 1607f19f2824..b86ac7b8a946 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2096,16 +2096,11 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 }
 
 int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
-				     u32 *secid)
+				     struct lsm_export *l)
 {
-	int rc;
-	struct lsm_export data = { .flags = LSM_EXPORT_NONE };
-
-	rc = call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock, skb,
-			   &data);
-
-	lsm_export_secid(&data, secid);
-	return rc;
+	lsm_export_init(l);
+	return call_int_hook(socket_getpeersec_dgram, -ENOPROTOOPT, sock, skb,
+			     l);
 }
 EXPORT_SYMBOL(security_socket_getpeersec_dgram);
 
-- 
2.17.0

