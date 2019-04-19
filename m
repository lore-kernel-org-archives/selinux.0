Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A75CC282DF
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC030217F9
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SpMGU3Mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfDSAtZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:25 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:38424 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727085AbfDSAtZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634963; bh=qO5b58JffRqW0gUzx7cYFmwh1lTk4Tm3ZWXObOuHgSw=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=SpMGU3Mqvao8ch6BNEYwaXlCSIrsJR3/AUWwbzQHw1ctyDo768qE+jnQ9fPoLBo73bB94A0639T6mMAwH1tNPwq3etQB/umjztl41JPn5npDmsDxXQpqpAPV7swQDf9r9jdK/HXNDEdOVvbnUbl7GFsi8Lnb99VAd8GsOiBMyejq/OIPYfJ00c453NBj2vb8QczbCGpHy1cnuFYX6XqtEgwB3ROi9y2icbD0sUGxpt0zEeKF6f6Kncig1gmTu1zvG7ERjBJmkFy/udgr4rZlOgPlspVrxCYaE+2kWtI5pnO/hRdZu0RdgbzCEtFV7MnSeDOYH5JNrR8Y44a8jnbRJw==
X-YMail-OSG: eXQuaAUVM1k5aMZL7Od6U0W57dAWYQEnjhwQDSPa0eVUdspc0qTBReqLQkPLDep
 buxXCdKbZgK8NwD7921x5prEMCvU4SAzJ60BCFmZzcW32lmL1mYFZRAxd4j3wVMn3Ag7BX5T.aqP
 ibXe440mMm42iiZbUQZmPqB0VWB9B7zs3CEQJnaSchEE18MCbteOiGNG5lfax0vHhDqERuOji7Am
 lDIEk2NfWGkHxKQ3qOh.9JjDqxVPw14t_4J.UsBUcJAIyL71T4g6zOrzTaB0TbWR1TgbpQKUsemC
 eAV_oFt5SF78iWG4QTac7qdSPF0lexvaDqKm.w0QbMZ7VnNqPqkdp6HDrOAah..v3Gmxw1yNvzGm
 Ra7ZGbDSdAvkcNngNpQ_xsISxXm9a4d3ZtAKAcVIK9c5FQbVsWFv4.kbVnzgKK68mO2dkOeOaBIB
 WENW0i58pMd.vhzr9c9_MKPP86PmWKxHXGfb1jkqDvbtTu.lGrKcKZSNkt1UDUbbSTVeUgBtXTZt
 POGKxjF7cFI79bzMOCuxhNv1.Tp2YZF1WWO8KOP1ouIj4CiXyay201qWlxHtXGJ.mIUQlbUUJGt5
 36YBnsgIzcKL5Mf3XO4LCREAb4jtjH9LkHdVpGwuvVWzLVHxeaLxhVJqxbfYX9UbUg1J13_R7G.c
 pm3cAZc5VNeiblIyg22pK0FhPjsQkgKYOIA.Sra8tT2Td9O0U2yUmwbJhEXNewkOrrzAx9xaHAhN
 YwcaCKm6MOccP2VpPDPN9o_4.Mb1ibgZeQQd_ZMpmAh6FrjIxI_o95k3SLYqEIl9_DrBE07B0brD
 yeMr7yKzSynHQsqOyaDIuzFZ.K5SA5C9Be8YAA3fNNAWUkBWIue3cwMMDtGdsnOD7DZTjKRT5KyD
 EmamoPm4AriI7..X0iTyJW2qAF0o7GqEE5splc3BtIodGyIdhAq7gjhu0CGEhdEhOZfdFrDNXRkO
 Qh6v_g4NYY3pYYtghqzHDwmKazJYGFaf3aRTXFgCMgSJgwu2dncLDXmiCqG6MKvHXIW9R1RBRz.r
 B6FR1BvbrHNmCiTpUfRdev0uBeko2cfwzPBgUSl3g1wMWao424Y0WePp.QzKiaATrs.ZBfdRAgnx
 gufoCaKpxwAhYReXhykKxzitBc_aLn5mACaYwxMZQxQzbuaz_6zSbsJyHVuFjUwY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp411.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b2fce6e68c800904f23626e111be9fc8;
          Fri, 19 Apr 2019 00:49:19 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 78/90] Smack: Let netlabel do the work on the ambient domain
Date:   Thu, 18 Apr 2019 17:46:05 -0700
Message-Id: <20190419004617.64627-79-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Don't delete the netlabel data from sockets on the
ambient domain as netlabel will do it correctly without
any help.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index e18245a52e80..ace5b48f90dc 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2403,37 +2403,27 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
 /**
  * smack_netlabel - Set the secattr on a socket
  * @sk: the socket
- * @labeled: socket label scheme
  *
  * Convert the outbound smack value (smk_out) to a
  * secattr and attach it to the socket.
  *
  * Returns 0 on success or an error code
  */
-static int smack_netlabel(struct sock *sk, int labeled)
+static int smack_netlabel(struct sock *sk)
 {
 	struct smack_known *skp;
 	struct socket_smack *ssp = smack_sock(sk);
 	int rc = 0;
 
 	/*
-	 * Usually the netlabel code will handle changing the
+	 * The netlabel code will handle changing the
 	 * packet labeling based on the label.
-	 * The case of a single label host is different, because
-	 * a single label host should never get a labeled packet
-	 * even though the label is usually associated with a packet
-	 * label.
 	 */
 	local_bh_disable();
 	bh_lock_sock_nested(sk);
 
-	if (ssp->smk_out == smack_net_ambient ||
-	    labeled == SMACK_UNLABELED_SOCKET)
-		netlbl_sock_delattr(sk);
-	else {
-		skp = ssp->smk_out;
-		rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
-	}
+	skp = ssp->smk_out;
+	rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
@@ -2455,8 +2445,7 @@ static int smack_netlabel(struct sock *sk, int labeled)
 static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
 {
 	struct smack_known *skp;
-	int rc;
-	int sk_lbl;
+	int rc = 0;
 	struct smack_known *hkp;
 	struct socket_smack *ssp = smack_sock(sk);
 	struct smk_audit_info ad;
@@ -2472,19 +2461,15 @@ static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
 		ad.a.u.net->dport = sap->sin_port;
 		ad.a.u.net->v4info.daddr = sap->sin_addr.s_addr;
 #endif
-		sk_lbl = SMACK_UNLABELED_SOCKET;
 		skp = ssp->smk_out;
 		rc = smk_access(skp, hkp, MAY_WRITE, &ad);
 		rc = smk_bu_note("IPv4 host check", skp, hkp, MAY_WRITE, rc);
-	} else {
-		sk_lbl = SMACK_CIPSO_SOCKET;
-		rc = 0;
 	}
 	rcu_read_unlock();
 	if (rc != 0)
 		return rc;
 
-	return smack_netlabel(sk, sk_lbl);
+	return smack_netlabel(sk);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -2722,7 +2707,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	else if (strcmp(name, XATTR_SMACK_IPOUT) == 0) {
 		ssp->smk_out = skp;
 		if (sock->sk->sk_family == PF_INET) {
-			rc = smack_netlabel(sock->sk, SMACK_CIPSO_SOCKET);
+			rc = smack_netlabel(sock->sk);
 			if (rc != 0)
 				printk(KERN_WARNING
 					"Smack: \"%s\" netlbl error %d.\n",
@@ -2773,7 +2758,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	/*
 	 * Set the outbound netlbl.
 	 */
-	return smack_netlabel(sock->sk, SMACK_CIPSO_SOCKET);
+	return smack_netlabel(sock->sk);
 }
 
 /**
-- 
2.19.1

