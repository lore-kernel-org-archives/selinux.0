Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A4EC10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B7521736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="KZwMdho/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfDSAt3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:49:29 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:37204 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbfDSAt3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634968; bh=4aXj0qNoXdJzkkLTQx3Pn2N2wTtQ7aiN3OSHPR8TXCE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=KZwMdho/mJCeF0GKvf1AkjMz76KO01cahxacIU6CeMleA7i9/LObwSoyzGwCLLkkJ7j4CEW+eqBdkYPjUwRx8pnFuskqMcFjodk3Ei1Hb55G3ohzgtKQaEQiloX9z464YkbBNnc/SRggVu7xTH36WuZ+rrcD1MnL2ivK/0LSmD3DN7a/aSwouuc3NRFs+3RYyPv769Mvy7/C4owq4vxZ76k+qMcOcSVAU35BtZKcYxcOndHPz0gbWpN0X5qXuRlYBnfx6zJtMjcRRt9z2v5pMUUW1DOwkh/SbfSnc1GC7qkV025czQ7YTf6W9QQBliphSo+vfFnQoSX0ubnSxpD49g==
X-YMail-OSG: hjY0AuQVM1kzjIB6acXNqg.f9JJ5ho.z2RgOyh6U7uJvbVK.V_h53EsFC0.LKUl
 ovRoHdBNg6sw7bwIUmbU7ROtSzb.p6RzvRNY_HXS_0uotGiQvHPtvnSPZk0E4Ew9c5RYOXMI3668
 MmrBPcEq_zHPbKtlV5BqZdXbPwP4JmPu49yQVI1mGGiYN7U_zwgMgp3lbyaDcJZXRSunLOQfVHD9
 F4xwnZs0oOMj.7eoC._EIQSoVosXAvAVWOjuSrfYZHH.MVQp81ActhRaaPGX8Uwm4wzvysRhuhyx
 kvVZSpgherYRUoue4M6E7pqCvrBfy.mlZtraLX8t3dZT9AwVCaRvY36kMmfB8ryEPzAXFooSxPMH
 98uVGsxQ9OJVyd9naYS1MYMCT0TF.wul1QtESJ5xsMTRCs255bgVxQSnn7kjPX0JjOPi4_9gAWv_
 _Z5NdQ7A7vhrNyzdJoNRTFcM2x4SKUSBDUwXip58eThq9EUG5DvHnIGybvleb093K2TTnx5jnq45
 Lqtadl_oxOjQw8F1Bx6KS5hTjJg1RQAaduY0XERXzGtWKuD32XX.afRthQUXDSFVQyI9itKsuu4R
 NiqYDPNCn.r1Mua73ON5gGc_XO1loxKqtJjjLe2uRaT3seUO5B4Bb5fIfFxumjHnE1uL4VjGMQyN
 gxdL8.EthwwmADAT5ql.4EMrRKR78sUsc1OFSjPE89t6qcVm9x9ZC4vUMPRMHfB7PPSbeOUb0O_3
 5daHrsNVyDM0IxfZ4MDlmEKXbfvLCZswtTFxHwrHvaGDY4QrFVbo0y51vQEjH_dNPJKRD7AaFLE8
 qpyYYGUnY716Xs6w3CFFvMj_MiRzfKDor3QfmpYk._WuD8KmeTLAJSk2_jmVkUpJ1G.9TTByoyo3
 GLP1B5a2LtWqy61r7Oxi7iwnWDrx39gkPZxq.7u1z1S0ihtUD9oeblcM7eeFUvE9qMH7G59AXx_O
 mI3Wtcdnsmqphkj7hkvsIFXFAcSRE339kuPF30Qf4iJP_igTh4eawOnDjcyf__YyBtv1M2KLgUY9
 5CnrdG1te1aEfFbLMZN15jr34MsnfE8_mypyAHZnUhJS2o6JiYRhCUDXrSWu5kV3kifgkBoFsSwe
 1vzrAqnw7MG5G1h_wt66RnGW7FmZjBjvBO5wJ.BhD5girKqVK5VCKryMRo82S1w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:49:28 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID cd54bbdbca338d2b8f0b466ae999e136;
          Fri, 19 Apr 2019 00:49:27 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 80/90] Smack: Let netlabel do the work on connections
Date:   Thu, 18 Apr 2019 17:46:07 -0700
Message-Id: <20190419004617.64627-81-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Rather than removing the netlabel socket attribute
on connections set the ambient domain. This is more
in line with the way netlabel "should" be used.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 25b5160e343b..337a05c34931 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4143,7 +4143,7 @@ static int smack_inet_conn_request(struct sock *sk, struct sk_buff *skb,
 	if (hskp == NULL)
 		rc = netlbl_req_setattr(req, &skp->smk_netlabel);
 	else
-		netlbl_req_delattr(req);
+		rc = netlbl_req_setattr(req, &smack_net_ambient->smk_netlabel);
 
 	return rc;
 }
-- 
2.19.1

