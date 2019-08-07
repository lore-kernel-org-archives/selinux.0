Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E36C32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB282217D9
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fXvUeNN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389636AbfHGWnT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:43:19 -0400
Received: from sonic317-27.consmr.mail.gq1.yahoo.com ([98.137.66.153]:44975
        "EHLO sonic317-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389627AbfHGWnT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217798; bh=Veu3kjDA/1pLCZ4fZrBLZYYlkvuefge0fWjtW5fbMhk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=fXvUeNN9CyTQQtHMv2jTJ0qbKtktOS06lV4zki0BSoTF/APj1cL7DIeV4HpCNQPwvIBDNSKfkIUPFk6AWvEHhjyJbSVuQbyPcllAoYny1klJWirH3x/Xar9o1QbFVPW8F9zEBSvYmKR62dmaFisr4TWhCNL/nn0deXIBRyI/Dc0ncXGYbsoIaOnflMXpz89MI7ECsEQh+u+28lEqJ1Gq8j3R3qmjnm5m1wJNBMY5jldvRajflfyxsb2O7940DjAG9gqKr5P2ou5odXkvoOpLBfT1qIB+yE+QswMGsTZms5ifpxzDbNgWeNdED0srUVxm7oQbjhsmp+bhg6e9UgyuMQ==
X-YMail-OSG: KNeEXVUVM1nFH.F2eK23RxL3.g3308O.5CEXkwPV2iYV_KlzzhFs8K3XqfpQgga
 HEA8un0l0bk9S3POa5h4eP70wIT695qf5XQ9eGV21svF7MbypdmB64CsyAg54ukgrrgmoqOuIZf_
 5cc2UylWwKuk2DSnOJeasTdQDaiZuRgRmx2m_7lGCAiQHUAhdliPLuO48RmgXuUqTLOOVMypwCOW
 k92Cv._Fe.tbvAxV.fBfY6Wp_cQN6VvUmfP0CbffrTmQOdgkwds0bE_oxb.ubdmoNjD2DMsL6fdV
 U5XhlzPTfky2cDRwU42ax5kOfk4BynIIToO2xpKknTRnrwDDy1BMC100Vg7HcoxI_cfPca4t307m
 CQDTw7zRICrjLbEKEhT9kmFE3RiVuI3wOSOleJvvKhI4Id6knnAL1zcQBH5Rc9sBzzhO9RSvxd.y
 ptXR2P39Bg2fnmCb3reB1xl2a2FXw.GQ_weKROlcbclQYxcWdIJhy4K08ChPG5xWBIEhv3dJzHS9
 2KaKPK2k9eCVyYdyxuzOa.ljF1ltqTn8_oXwEJETp6ZrFS0aq76Lv8VRHCthXoV2zqQDwfoaSssu
 QMoq6a2P_Nx.aUAn9DPnpPm3CLYnIxh6CWLfilEHovHlWqE.jD1_p8Ph6OAbYW4NwOv3Wk2aHRoN
 nTSjoyCIE8_0fPYj31jmq0uDYm3SaJVBxfY8kKGSTdddL7TB2uCPS_WlVUteelNodMaGQQbUdJaO
 u_y.PTwZFnJNqRkswzJi1lrO0EBKIVZe8wzW64jtBm861kBnlVP1acHcblrErYVKFUFCI93YCI1Q
 dqTvqlOmHgi3A0R2Aymj1.0hofb_PpAmDyndsjtNYeqei_e.bklQsVWaDrnVo1_MSQ6iKM2LtQTa
 LEK9H6O0dEWNdStU85iT3YMsiRZBOgHYZtbVnOpx1AeMLA2MXR1gmPS0Gg9ii7xeVH0y_1cuMg4T
 bftvDCo9o8y4EX5TDePfYdwSKRPmb7nmOf2dd6Q7KJnZtdo1xy6OXJ2U9KEOK2RXxA7_Rad08H5.
 X5MTrO.vOYQbc_1DgYVe.xdrcM.wDcaj_KbCIrXGv_VshtLIbVvsUP6R_1NslJKlTISYi3mWiSuj
 ThPbG8Gk5WKjTdDrDKtdEY9PK2apj3b2AHETSl6J4g2LBF.lQJvG.Zduy.ujbwC9n2RQxJblYrAS
 L0YRiXxjJaXVnVxpGS6mBVP4cRoYFlHfCEH7l9LZMzn89_Usife3SL9JEVzOn4xNamXRmgDUenLE
 V7a89tZn_BqJFTL_mSmdu4vRCZnc72R01Enw009NLRoiPOfwgfEMSkdqaKTrPVZM2NxlfO_tKoyv
 PGknV
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Wed, 7 Aug 2019 22:43:18 +0000
Received: by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b31e22a1723893410aaa66faa171513d;
          Wed, 07 Aug 2019 22:43:16 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 15/16] LSM: Avoid network conflicts in SELinux and Smack
Date:   Wed,  7 Aug 2019 15:42:44 -0700
Message-Id: <20190807224245.10798-17-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add calls to security_reconcile_netlbl() in SELinux and
Smack to ensure that only packets that are acceptable to
all active security modules get sent. Verify that all
security modules agree on the network labeling for sendmsg
and connect.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c              | 43 ++++++++++++++++++++++----------
 security/selinux/hooks.c         |  3 +++
 security/smack/smack_netfilter.c |  8 ++++--
 3 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/security/security.c b/security/security.c
index bfe40c11f5bf..4897c68cdb71 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2496,7 +2496,13 @@ int security_socket_bind(struct socket *sock, struct sockaddr *address, int addr
 
 int security_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return call_int_hook(socket_connect, 0, sock, address, addrlen);
+	int rc;
+
+	rc = call_int_hook(socket_connect, 0, sock, address, addrlen);
+	if (rc)
+		return rc;
+
+	return security_reconcile_netlbl(sock->sk);
 }
 
 int security_socket_listen(struct socket *sock, int backlog)
@@ -2511,6 +2517,12 @@ int security_socket_accept(struct socket *sock, struct socket *newsock)
 
 int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size)
 {
+	int rc;
+
+	rc = security_reconcile_netlbl(sock->sk);
+	if (rc)
+		return rc;
+
 	return call_int_hook(socket_sendmsg, 0, sock, msg, size);
 }
 
@@ -3016,28 +3028,33 @@ int security_reconcile_netlbl(struct sock *sk)
 	int this_set = 0;
 	struct security_hook_list *hp;
 
+	if (sk->sk_family != PF_INET && sk->sk_family != PF_INET6)
+		return 0;
+
 	hlist_for_each_entry(hp, &security_hook_heads.socket_netlbl_secattr,
 				list) {
 		hp->hook.socket_netlbl_secattr(sk, &this, &this_set);
+		/*
+		 * If the NLTYPE has been deferred it's not
+		 * possible to decide now. A decision will be made
+		 * later.
+		 */
+		if (this_set == NETLBL_NLTYPE_ADDRSELECT)
+			return 0;
 		if (this_set == 0 || this == NULL)
 			continue;
 		if (prev != NULL) {
-			/*
-			 * Both unlabeled is easily acceptable.
-			 */
-			if (prev_set == NETLBL_NLTYPE_UNLABELED &&
-			    this_set == NETLBL_NLTYPE_UNLABELED)
-				continue;
 			/*
 			 * The nltype being different means that
-			 * the secattrs aren't comparible. Except
-			 * that ADDRSELECT means that couldn't know
-			 * when the socket was created.
+			 * the secattrs aren't comparible.
 			 */
-			if (prev_set != this_set &&
-			    prev_set != NETLBL_NLTYPE_ADDRSELECT &&
-			    this_set != NETLBL_NLTYPE_ADDRSELECT)
+			if (prev_set != this_set)
 				return -EACCES;
+			/*
+			 * Both unlabeled is easily acceptable.
+			 */
+			if (this_set == NETLBL_NLTYPE_UNLABELED)
+				continue;
 			/*
 			 * Count on the Netlabel system's judgement.
 			 */
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 48468a4b478c..293350b672a8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5522,6 +5522,9 @@ static unsigned int selinux_ip_output(struct sk_buff *skb,
 	if (selinux_netlbl_skbuff_setsid(skb, family, sid) != 0)
 		return NF_DROP;
 
+	if (sk && security_reconcile_netlbl(sk))
+		return NF_DROP;
+
 	return NF_ACCEPT;
 }
 
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 7b9c8d5d8408..92aeffbbb27c 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -75,7 +75,7 @@ static unsigned int smack_ipv4_output(void *priv,
 					const struct nf_hook_state *state)
 {
 	struct sock *sk = skb_to_full_sk(skb);
-	struct socket_smack *ssp;
+	struct socket_smack *ssp = NULL;
 	struct smack_known *skp;
 
 	if (!smack_checked_secmark) {
@@ -84,11 +84,15 @@ static unsigned int smack_ipv4_output(void *priv,
 		smack_checked_secmark = true;
 	}
 
-	if (smack_use_secmark && sk && smack_sock(sk)) {
+	if (sk && smack_sock(sk))
 		ssp = smack_sock(sk);
+
+	if (smack_use_secmark && ssp) {
 		skp = ssp->smk_out;
 		skb->secmark = skp->smk_secid;
 	}
+	if (sk && security_reconcile_netlbl(sk))
+		return NF_DROP;
 
 	return NF_ACCEPT;
 }
-- 
2.20.1

