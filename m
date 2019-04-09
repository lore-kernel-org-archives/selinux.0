Return-Path: <SRS0=G6LX=SL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE49BC282E0
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC332082A
	for <selinux@archiver.kernel.org>; Tue,  9 Apr 2019 21:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="etZPwlRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfDIVlv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 9 Apr 2019 17:41:51 -0400
Received: from sonic304-28.consmr.mail.ne1.yahoo.com ([66.163.191.154]:40285
        "EHLO sonic304-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727074AbfDIVlo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 9 Apr 2019 17:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1554846093; bh=wTEQTvklkThW7Dll4nUn/vb0sTDbloo0pZigu96CHzg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=etZPwlRLz48pcVAHb/WMGYP9Ji7XI8t/SBHO/bT7puS4qioQG/ahpPXTWkAw5ZbJFDhRXH/PZ6mK4ckSGGuR7XgNOrvcSR3KyIogHzPNhD31/he0p3x4eku42NEUhH8BfVXfeukB4J9Y1jvxb/0yLVip24Q1B/MFu2KeboHkLWPFIAHzFWnIAfBkO/rnxKcQ4hy2ymt2Xh5DSfk51dfsADC0GT2fQfusmiVLNfXZJA3IUXWg4I/Cf7TREK27MrNZtYdV7btoPnqlybYjidZDqP5ld6xTzh02/avInA3D5yJFU6A4L9dFlbnP28RTjenNn3aDG/5j8ZVrynf5tV5B/Q==
X-YMail-OSG: X6ZAkZkVM1lM3.Qk5hX00OPjy2X37_62mrHMGeZMw5m88iaqYVGKM5d0_M_KUUO
 JFDS5QoBJGn7r2I1glrUOigM7.tOTP9JD.TlpGdXUm76WWRChnRLxNTC1HhEEEY65N5aDBShw8X8
 bNXCRiWz.I_oA6jThi3WsdkAU6cemFWEyc0QW3DbrUThbkJ5eKq6nchs_wLU6xJTNSUZ8prj9WpE
 zoEeizZiGdkUzTayh1NUGuL3GQEogX5AxOtWHNXnbiOfUBj6yggh9zVW_NTcdrX1I9JHBeAX38aN
 Rl0fNe73sdThOTTxZV0IwsqQeY7GAgBq_5U2QKoT0kxc7uncMMkFAwZ.1OnJi_Agn849i8CS8n3C
 TFPDPc.0b5CXf9g4mivGJZ6aJmVSP1jZHnSsg_UBYlR3Ii0OxcblU9ASgG4eZBd4McPtJmyMKrHS
 7IRdPDXBGyREwUmfjUxlETB2l.YWpLia2SUNUrl7m5WXygk9bGRiN3cu4z.npeWAr0Txn_47DTbg
 _Hp_RL0cLtq.3RSWE5TDHqlrDIp9IwSeHcIoQZ4m6LLbxgj3joe8qDeE5i1YjFwrgjNjfr4cilkf
 EU.Jak14axZXrGG0WB6ovBiUOebEVE3coSke6gq0B.AHa_qtcddDET4BP9pljtygKup2xsEzEAN4
 .1jUx5O4GawoXhkl5NVfD9iDnQwZ5d7umVcm5KjNVsNqERTpn7b8IO2EAo.gQWM29gmTDKZxnfh0
 VctO5ECRYyy5bfuYAAPGSl0Nllf4Srb98w6s0tZHmmQiIAYxCRNs0aNTvzpE2AvP_bMpGhrVVrin
 EbZnfGIdfkAZFnFvYgEmA2kvajiplHi6hG0K.ARL_I_SQ4mRfef9mS97tYtOznkpsH93Opde2BMu
 LFcjWFfNdu7lkWwR.V.NDsFUW.h3DTHqGQyB4mZCCcuYktUsW3FkzAX7H_9qmM.Ci4ubJd3XG_op
 NnUveWioY.j0z6SRT1g3lhRnNlBAZtQeDyJ2DdVqSDo.28PPHKEexFDP.NgNCKBDtoiOYTaASbbO
 erc.drmScJlga3FpH_g715KUSgiK0vA4QRJ2rTPvjjutIVOVmOO13sl1tmqkB8SfqtWdTB5DCrtZ
 T7o7kj7imHpiscGNnjsYWMME_tdIeG1udiTHnOfzr3lKK4Nteh_VtbiSFSmQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Apr 2019 21:41:33 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID d8fc391abae2ed5c1368bb3c988d9ffd;
          Tue, 09 Apr 2019 21:40:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 16/59] LSM: Use lsm_export in security_socket_getpeersec_dgram
Date:   Tue,  9 Apr 2019 14:39:03 -0700
Message-Id: <20190409213946.1667-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190409213946.1667-1-casey@schaufler-ca.com>
References: <20190409213946.1667-1-casey@schaufler-ca.com>
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
index 7369cdc3a681..e3f5c61b9b2c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1270,7 +1270,8 @@ int security_socket_shutdown(struct socket *sock, int how);
 int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
 int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
 				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
+int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb,
+				     struct lsm_export *l);
 int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
 void security_sk_free(struct sock *sk);
 void security_sk_clone(const struct sock *sk, struct sock *newsk);
@@ -1408,7 +1409,9 @@ static inline int security_socket_getpeersec_stream(struct socket *sock, char __
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
index edaaaef54239..d8300a6400c3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2110,16 +2110,11 @@ int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
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
2.19.1

