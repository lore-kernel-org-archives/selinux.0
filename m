Return-Path: <SRS0=LK0T=WD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7DDC32751
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C85217D9
	for <selinux@archiver.kernel.org>; Wed,  7 Aug 2019 22:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IddPzjEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbfHGWm6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Aug 2019 18:42:58 -0400
Received: from sonic310-23.consmr.mail.bf2.yahoo.com ([74.6.135.197]:39334
        "EHLO sonic310-23.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388910AbfHGWm5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Aug 2019 18:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1565217776; bh=SMs4nli59t3K7f0fj8Nh2Asd3jA9nd4Esaxdw91qRlo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=IddPzjEi4wOcuImHU/3r9mCWoZFGI1OhKFfjX4ZstWP2P2z/BSC7vcCRtaE9+OWYbUOmCVF0TK5rrRX1T2KVnPNHw2SqztroEvGTC1yctUGRkat+dm27K57mdCOTzURSbncIZFnYc9VY0ed6gQB7W1kQBwUVOf0p2QowjeV4klp5we3nnRqC/Yzl0ITp36iGv7HKRcGWUrnCO+/PJUmLcMOmBScnLwiB+PFIEbBpY7mJEdgHBy8jBo9SS/6wcJ17ZeD9wNB0X8E5Ei/vHpp8Z7wy65e0YW3jSfuNQHkSfCxa09FaqGXSs7CWIqNGPq2f3foPw0PeKvL9NnDXACOpFQ==
X-YMail-OSG: EappUH8VM1l8sbpWzrJL3mdhbhgWNAGImrQfakulkhH1oX50YVAD1eb1mjdQQu7
 PEGxU.DNwJUrdgyH3xbVNBXgCCEPAFmBUrmlBAzxGC.pUuHGAE7Ez8QGV3OwOB3uVrDHZl0TKWmA
 XIgQeyKkq6VHs4WTOIqvCTPEKtbrOqfZb9Hj6ORZFzDor_PhKpPeL1XJYWb6Qj4wSI09wISzzQgw
 FMtar_wS4yi8mI0uHRMM9tXwF4nV1r8OhUTYX.mQHUQUS4embBRKYtBBtj5XwzLATjfuZUO2U_6B
 YlDatikro.VazJyIpXocWbsbcdKnMdxCykjHb7Z.j0wLoMujFst3GbYJMxJ_eVd6TI2rl2Ip2Xoy
 sRn5uLZ3KPQp8NRoq1LQptacFyMqu61pKwTC.oD3p0sPw3Y3KsvElfSm.oFhJ.FBUR2GztamCGNG
 rcIeHnB96957JVVr63dTGsptzvnEJHz7E.qsZZiIsdL49N67.2Scmx4HhqPwHrrneRFEw4ncctLb
 jznqvZ4lRp2mxlTIaNv7asRXEeNBE6D43TPK.fCDDXc6pBltXzIoLBMTrHocPagrUubkYtc0BQCT
 a4gbzjh2cUcI_qp9EQLEO0_hOgqarn3j9cAq6pM4BevU4r7U0W7h5IcfP1KhxZ4SJwsLz7vqqWpC
 5fPx3efeqzE6Os6x.Z.ZE81_Eq3n1E9cKUk3SA56QhjDX3Uhu74pJuhYnLGDjG75SSMEcEx010rj
 CM_GgoEP6nzQ8KDmh8VxCU1.7N6X93z0HAYS1O7yPFH8qjIaQBXgkh0bNBcJ.FmLcNw4l2t5sK8Z
 P5LaKnRmCnM3tdfp5AFAEUDogN5tROuCLL9EGkafiJqe4zqcHU0CrMRrUZIdYuQz3JgdD1tRLZMB
 t54q9cPfluVGKn_6UEwdeub5JPamldzZeNWbcv6KZnIR2yBcKtxse4lQlLyzTSEzvQSrdGBP9EcC
 ZiGJ7YGRoOaiJhP.NDcG_P1TbxcK3rPqE1PRMBbPY5r3r_v8qihaXDHVOB0GQYpFhVd4tDC_uMQI
 6b17ev3h2O4OpUqqZWnKTdAxq05rBWfGqH_Pv_PZybI8P0wvIXaFZGbnoRIsdXIrPQpRhE9s.HqE
 vdIWLx2gm.LF0FSC4Z7iZzLjOmYjX8QUgjkllOBvQe1kNJ_liQT_zEFm_BVYUq2DOdRxPNJyWJ7o
 nyQDAVd4JcLh068dTOEGviDIMSuNH7JQWPBLahO3uxSwdTrG0GTrRh_HBZFr17DtbzUR1NzpV_pL
 S4ahrHrxKREpu7Q00xocKo.HECCFrt7kY4QcfWkxRKZlOX5EX3pVM7lkai0YmxOFUBf9H8jzY6Cd
 7eeY5OrY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Aug 2019 22:42:56 +0000
Received: by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 824faaf1f4a5ffbf9b87c6192a4b2124;
          Wed, 07 Aug 2019 22:42:51 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: [PATCH v7 01/16] LSM: Single hook called in secmark refcounting
Date:   Wed,  7 Aug 2019 15:42:30 -0700
Message-Id: <20190807224245.10798-3-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190807224245.10798-1-casey@schaufler-ca.com>
References: <20190807224245.10798-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Restrict the secmark_refcount_dec and secmark_refcount_inc
interfaces to a single module. The secmark is too small to
share, and this allows the modules a way to detect if the
secmark is theirs to use.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/security/security.c b/security/security.c
index e9f579483d12..0467f194d87d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2564,13 +2564,25 @@ EXPORT_SYMBOL(security_secmark_relabel_packet);
 
 void security_secmark_refcount_inc(void)
 {
-	call_void_hook(secmark_refcount_inc);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.secmark_refcount_inc,
+			     list) {
+		hp->hook.secmark_refcount_inc();
+		break;
+	}
 }
 EXPORT_SYMBOL(security_secmark_refcount_inc);
 
 void security_secmark_refcount_dec(void)
 {
-	call_void_hook(secmark_refcount_dec);
+	struct security_hook_list *hp;
+
+	hlist_for_each_entry(hp, &security_hook_heads.secmark_refcount_dec,
+			     list) {
+		hp->hook.secmark_refcount_dec();
+		break;
+	}
 }
 EXPORT_SYMBOL(security_secmark_refcount_dec);
 
-- 
2.20.1

