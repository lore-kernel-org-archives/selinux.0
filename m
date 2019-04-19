Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5983EC282DD
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CDF21736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nQembyU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfDSAtb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:31 -0400
Received: from sonic308-9.consmr.mail.bf2.yahoo.com ([74.6.130.48]:42593 "EHLO
        sonic308-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727095AbfDSAtb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634970; bh=WeQ9/eWmuruZSiDJgZFggZKJXxBbEdWiScLQJMN/Pb0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nQembyU73CSTwi6in3h5bINBoTRHaImC16svWcS3mMfMZf4FWLoISWVx2xFKsBS6lBZ8oIRwnwPM4g3GE8F/VrRKt6dH4Ckvm0KyaPLZW9Tk42csPEH8qdevfJsYp36PXJcSr/nB+keqrLcC3LhXLgJk/jFhsz1n8on85/wf/bpWWAoYVpyMj6BoAvRyrf5OKqDjGmlLH0/TwSP1NLK0z5QrgGL3TBnS12UeRVr73QQ3XC0Suplqmh3wQnVlkC7is8ly/0mUKHy5VZF4tjSes4qVu4H4XKGaIVCY2OhiitRbGpyom/N6hcEJXsgGTW10F+IUU27C/qaH+sVZGowyhw==
X-YMail-OSG: pqax2xsVM1kjHojgrI_08tcscmoz0O1GtEDpnDx8FN0pOCALbBRW6Lc4o4dHctj
 GYM2yWGYO_oJv4E2ODc_.e0d74_bs02ccKfhQRKTZc8XRfeVMx448.YoS7EbWpiWh4N_toWUzJ7S
 DKFOGkE1do9KUjtgSoIpQXy7HYGpqm4nJRI3K.JLZ_JLahT9dZ2b25WgA3BAb.54pK7LaE1yZcwT
 tUeNOqiWAJyhhnN4bdYb_6XHLPtrAoaK_wlUazyINn1rLT7viSnyswJpPjiK7clRyCiusQVe4WDO
 GNZEtIfnGG3NHRMvIX1GxLxW3Rh6Tz6rK_wfZxCXX6igaOkFRs9NhDk2fWoUHk_Vnw4teo6VBQ7.
 04A2ogrA02o3zGBQZhlozwcI.w_mAKjfPzjlAe_nxE3NyFIRH8Tx2KZpW8AnHfHtP_N1HG80ctWZ
 OKCBdnyCEBtynb4FllNPyjEwHeIp1l8CLaqNs1Y5ZXq7deDjmDjlY2n3a_bG6TuTI1hvKouVPBWL
 PSBKhGLV4lnusnSzAl0LjipgsWNCHQPkh.P_fxldBJ2zFfGNwvMxFbfpSNVk7fThUoDtT5MZ8IyW
 748IXNtE_BnZhPziavUedCeZrBkUD6QnSrsd8d6hGEh7whz9vnuHt9F6jAh6qD585moX4rpyh3K1
 5NTBmelhxUTafGAa1qaN0YbHafS12AzAl6ylrLetikAyxyYI2qRFK3u6PASvkmi7tj3J1C5S1PXQ
 8l9XYHK1DnPUfuJNiZb0GoVoXsGNUO5WF8w7KAVmv3W84hXs8VSvfZARcENJWS7o4r_5WEbjpe_b
 w2Wv.TukBaH5heo7GtToULiQIPcMxZp.6tuiGTWExYnorq6nIH0Ch6ECx_uzFoyhbwUkZHdQ6B02
 Pq8SI.jFEzJR_M9gBviDPxdFqzZo2j2BJ77gfDL.cMGMUKqNH5MkNpO2NaCH75S2RNsvFMGp5eUJ
 l84UbF1wtM0xCRWb5Tckddv58JJHja4vAZZ0Wbg4HQJK1fbnMpLju6XqT12lePdD2cBDXd7JYYK7
 3JHVnp9J9v4LCVysO2qntYCkxiDHsjEeN6sZaZvdWsYLseWNChQLVNfIExXv2qbwcFxTs_MMsKVs
 rz3.bNUWr20PgZtigaM.Kakfz4cHALzLoO9zfQKo5Md6tdEE3SY.8bMSmAcG.lQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:30 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cd54bbdbca338d2b8f0b466ae999e136;
          Fri, 19 Apr 2019 00:49:28 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 81/90] Netlabel: Return the labeling type on socket
Date:   Thu, 18 Apr 2019 17:46:08 -0700
Message-Id: <20190419004617.64627-82-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change netlbl_sock_setattr() to return the labeling
type of the domain. This allows the labeling types to
be compared when two LSMs want to determine how a socket
should be used.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netlabel/netlabel_kapi.c | 25 ++++++++++++-------------
 security/selinux/netlabel.c  | 11 ++++-------
 security/smack/smack_lsm.c   |  2 ++
 3 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 648103ecc48b..2f7ba0e2e436 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -974,15 +974,14 @@ int netlbl_enabled(void)
  * Attach the correct label to the given socket using the security attributes
  * specified in @secattr.  This function requires exclusive access to @sk,
  * which means it either needs to be in the process of being created or locked.
- * Returns zero on success, -EDESTADDRREQ if the domain is configured to use
- * network address selectors (can't blindly label the socket), and negative
- * values on all other failures.
+ * Returns the labeling type of the domain, or negative values on failures.
  *
  */
 int netlbl_sock_setattr(struct sock *sk,
 			u16 family,
 			const struct netlbl_lsm_secattr *secattr)
 {
+	int rc;
 	int ret_val;
 	struct netlbl_dom_map *dom_entry;
 
@@ -994,17 +993,17 @@ int netlbl_sock_setattr(struct sock *sk,
 	}
 	switch (family) {
 	case AF_INET:
+		ret_val = dom_entry->def.type;
 		switch (dom_entry->def.type) {
 		case NETLBL_NLTYPE_ADDRSELECT:
-			ret_val = -EDESTADDRREQ;
 			break;
 		case NETLBL_NLTYPE_CIPSOV4:
-			ret_val = cipso_v4_sock_setattr(sk,
-							dom_entry->def.cipso,
-							secattr);
+			rc = cipso_v4_sock_setattr(sk, dom_entry->def.cipso,
+						   secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
@@ -1012,17 +1011,17 @@ int netlbl_sock_setattr(struct sock *sk,
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
+		ret_val = dom_entry->def.type;
 		switch (dom_entry->def.type) {
 		case NETLBL_NLTYPE_ADDRSELECT:
-			ret_val = -EDESTADDRREQ;
 			break;
 		case NETLBL_NLTYPE_CALIPSO:
-			ret_val = calipso_sock_setattr(sk,
-						       dom_entry->def.calipso,
-						       secattr);
+			rc = calipso_sock_setattr(sk, dom_entry->def.calipso,
+						  secattr);
+			if (rc < 0)
+				ret_val = rc;
 			break;
 		case NETLBL_NLTYPE_UNLABELED:
-			ret_val = 0;
 			break;
 		default:
 			ret_val = -ENOENT;
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 4bbd50237a8a..85156a0cdfc3 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -418,15 +418,12 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 	if (secattr == NULL)
 		return -ENOMEM;
 	rc = netlbl_sock_setattr(sk, family, secattr);
-	switch (rc) {
-	case 0:
-		sksec->nlbl_state = NLBL_LABELED;
-		break;
-	case -EDESTADDRREQ:
+	if (rc == NETLBL_NLTYPE_ADDRSELECT)
 		sksec->nlbl_state = NLBL_REQSKB;
+	else if (rc >= 0)
+		sksec->nlbl_state = NLBL_LABELED;
+	if (rc > 0)
 		rc = 0;
-		break;
-	}
 
 	return rc;
 }
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 337a05c34931..a787f8010067 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2424,6 +2424,8 @@ static int smack_netlabel(struct sock *sk)
 
 	skp = ssp->smk_out;
 	rc = netlbl_sock_setattr(sk, sk->sk_family, &skp->smk_netlabel);
+	if (rc > 0)
+		rc = 0;
 
 	bh_unlock_sock(sk);
 	local_bh_enable();
-- 
2.19.1

