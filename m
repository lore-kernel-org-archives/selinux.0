Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70867C43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E9C206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OsXOJIEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfB1Woa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:30 -0500
Received: from sonic307-10.consmr.mail.bf2.yahoo.com ([74.6.134.49]:35370 "EHLO
        sonic307-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729999AbfB1Woa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393868; bh=5Tzzr7tzx0u4Co/RelBllwIUxaOD5cmia+v4HkbQgps=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OsXOJIEcTGWE4E9VHsQTTs0vrHO3S4hELMBulatsY40iQZiHXQMPfgwp18WtR90M7787TsmiJu5/3VG+m9OXT6Rjb0bJrNTHn0xXXPt9MrOxqrLzaPTk/cr05jmw21im6SC17ZZvtmUx9SboD2t4OJ9QV4M7bco45cUwoKo4P+q3AoBiRycbzZcvAy6BDuZ2d5hFLIn+BwIqLfZ7AEQdtaXxqDL+r9umVfhSR0cbTrKiFGITwOY5R8XjTqjtq9Te3aIZ+cKE1h1obkTfOvbZFWcNe2dWU2C3P+fmsSkziK80sSdfnmTGDUfcu9u5RHU6IplvgRyNtpVABglKNSERtQ==
X-YMail-OSG: L1z1N3QVM1nYGyyszql1W09yRNvbgOBtj8N8cu8Jgm3OnKSqpmDYMGmC89VG3Z2
 d6lEBeDJZFSrylpFGw3IptqInZuY13A73mbqEFJqunK03dBMMijV0yu8XDBnUv1tmzqEuxMbT8zR
 xrvHuYvlbsdgSvh6aUxfXTI0N7UH5Ewtd4soZoCqjyZ4dqs2ZIjF8oFEueQ7yZLtYoBmfh3MEhkO
 K0vWraH3AHAZjilLqjGdI99GFrZFtoT9C1y9wQFehoVgEvivwPQTRP5WEJQOWd5666t6qTgB5mgN
 wqtamqH5EIC_nJzJmeMDG7VkwUdGZvLO0ZlUsmAwwa7Kxx.809DuFR4aibsRp9lUUH9cyC0q.wPI
 3rT.ffecfUt3VmuA2Fbow3KjEjAPP7i5nnRLdOmFg4go_hNX7FilgEHEXp6bd0LWDc8qUoWGaBG1
 1gWlyjblyytCrv5CutZPd.xCjNpldATJYBWgCdGlC1sMEmBnh49skwp26FN49wqIf6w3_2c_HnBp
 Zwkiv6nwDJBZlFW.sr0DhiTcTu9wgoe0VKFYv9rKW2t1Tj1ZoUIdQNWAcjx6BqbQShG1CaV1Oaie
 3iwFuSnMlivnSOTsgamDYc0Ls9zNhH7ES08Gs7SVpD4Rc.iHWQgIWxdtXPlxx8_95L_d4Ovag96A
 VpK3DskU7hALtaa.7LjCqvyDtxzbSpPHm2gt.cEuWbDybuxa7jwH0d3FGVGViwgnZl8GKT95oKUe
 i.mi.p52VwS5HPMDWS08nrDFDOsB1BTz9JEkzMAgovqFCpmtSi33LIAPr3cW1uOlFJPwxdkNG.Je
 rjRW43dDIZUhWsF81vENQoTeX1dXa7Qc2h5saVrGH_yAygEnDSxZUVbJCPY8iEy2NjA7UCOFDD19
 3QUGJacwgmq.ylkawcHACSso1iYx2a5bMJQTrHCoPHZuWp9NXfllStfmd5svJ2sJhUljb5RSHyvn
 RqbJ_QAwEEtkCdj8tCemft0bxvLHiuP7t0v2z1MhaZs15HXWx_y5xVYeUv6xDrb6LzkM8GhYRvAa
 uJqIXh5tWfHLaJZXYvRc6Xuc74e0JSiIS71pJNYGafF6WAj0K5AKrtqMLim2Fi24EtplL5i0L66_
 ve0V.WPkLKRbP1_PZNjaYtOscVzfddw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 46c3ca42412e81058eafbaa96f791691;
          Thu, 28 Feb 2019 22:44:24 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 85/97] Smack: Let netlabel do the work on the ambient domain
Date:   Thu, 28 Feb 2019 14:43:44 -0800
Message-Id: <20190228224356.2608-16-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
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
index a4c8f93534ec..d2a73d8a6976 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2316,37 +2316,27 @@ static struct smack_known *smack_ipv6host_label(struct sockaddr_in6 *sip)
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
@@ -2368,8 +2358,7 @@ static int smack_netlabel(struct sock *sk, int labeled)
 static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
 {
 	struct smack_known *skp;
-	int rc;
-	int sk_lbl;
+	int rc = 0;
 	struct smack_known *hkp;
 	struct socket_smack *ssp = smack_sock(sk);
 	struct smk_audit_info ad;
@@ -2385,19 +2374,15 @@ static int smack_netlabel_send(struct sock *sk, struct sockaddr_in *sap)
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
@@ -2635,7 +2620,7 @@ static int smack_inode_setsecurity(struct inode *inode, const char *name,
 	else if (strcmp(name, XATTR_SMACK_IPOUT) == 0) {
 		ssp->smk_out = skp;
 		if (sock->sk->sk_family == PF_INET) {
-			rc = smack_netlabel(sock->sk, SMACK_CIPSO_SOCKET);
+			rc = smack_netlabel(sock->sk);
 			if (rc != 0)
 				printk(KERN_WARNING
 					"Smack: \"%s\" netlbl error %d.\n",
@@ -2686,7 +2671,7 @@ static int smack_socket_post_create(struct socket *sock, int family,
 	/*
 	 * Set the outbound netlbl.
 	 */
-	return smack_netlabel(sock->sk, SMACK_CIPSO_SOCKET);
+	return smack_netlabel(sock->sk);
 }
 
 /**
-- 
2.17.0

