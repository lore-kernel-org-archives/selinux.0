Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FE3C10F00
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A635E218AE
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D7FEnvUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfB1Wok (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:40 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:36213 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730965AbfB1Wok (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393879; bh=myo0K4BZ46tU+RPsERMaTfIKTHsxeAeIOvh0XfDHLWk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=D7FEnvUWVC9mY20inJ1N7jXfcBDsOiybO5ZjZx9rOIHAgVGLdg14w8LqK9u0g8XVWLp1zXKFmBrInlNilLVM9ke/FGgHyPparov5LDlCzKufsJdtU3/Ixs9vwx3Dn5167xeofA8aq6PdKIFGDbkV2P1mYxZXZ+Y/i1BD3LvulMVkWuc/pdE5Vzg1doAZoj52lpLyvhAigdnCca1PdLamd1g96Tz8L0/UIGriIQl1WT17bx0GhT288JxFzxAyT9EyC96bbl60Tue8DMCadOLhndKW96jRg531wVNjb5CRNQb2rumHkDcERRk6MasBfwWL/9Tfpn8ZknP9yaF7R7cdWQ==
X-YMail-OSG: YwYcPBEVM1ldV8IBb1R5NnXlqKCeEWvTUlwbr3CxaY6UmDbHi5EudfbW7QAM._v
 rsqAqF7nZ_ooxGFgKFuS.mDxhlFEfUJNE3Exphg8MiK.U.fPD9kwcIJX_M7osXuNj7_Ze9Q0OXpu
 zd9jumm9eNEz4Mhn.SwVLTQ9SRnsXp.pWL5aaXwY2xeQ4oOkDIvtiKJIPAAxAVdoiphvlTRnCnjL
 2rSaUpX6vwdOBBT2lCxMnn0TIxEo8UN.4_zt0Nlr7aqgbzkcA_aZ1218doxp_7QYsrfTlD_uRooM
 zIJ6KmX5a2XRQwJEcNzjB3At0lYYkI5NBv1bBpCoqza0Lol8.5Mfc6wl4T_LYkJ1sbfQC.Rhk6o7
 NrYCE2.RRdpbLmRyLgWO1qSJMBphOhEbZ250orHhCaGpCjSUrqIxWOK56O8OM_k2PvLitU15p7I7
 QML.Xp8loBIgw_1jaU1JO1h2p2QznW_TbsubjJ2_q.hl4Y1ntqXCGt7ocaE3o60mAUSsKLi5lNsF
 FHNIfZ2JakJ3fNACX4dYVIPhrxfrRmg3aFWBNEUaCu3jhaa92lxBgfNAv0mHTDo1r.hdsVK4p0bd
 wQ..BteLq3hDBFSoOzwQpGHYDBuPqGRvi5RG27EYE8K3EGwkc4mHJcgDHXNiwwAtEc0fC2xDMLjm
 ERhKhaSlhbMEcuAzr5m8mlJgJ2cFZ9kTZOWVl.iE2XX1M2wKSvONfM7kT_YMntTXjgiGxkpowS0U
 NDWETzLcSRnOvJUUc4n3LL5Ij._3JOqJuOBfjF.okSe6ZGLDqL341s0vtR7nyP2T61Gj2u85VR31
 semX4p7MBPhXFQmntEJrAH96TYc4s0tdXDQxQlzlyUgpCVl0JbQW6tRBYvf1mWHE5AaSMaXxGhDX
 W477DKUgtMR2LmYu0jiNg9znecKiF.t8JQik87wY0Q1QStN8m2wrzDKdxA6q7WMKSrW9Szsk4qFp
 lg.QPVPsiAwrgjX.nfRjyt7yFAixu_8kxUxtQ0LTK15fOAr296yUA.mhG0bw6i5oUlqWvks7u8X9
 l60.rWpp88UJoWv8xdCR1.43LRfcOpbJmxfacPvZMtsV8ew0h4D7BXhYiSMutiy1JgTynMMKF7pl
 h2oLdhsgww8ouCprNX2eJ1.gvEvWQniyBtVQx_tca9XUjH9pNO.fioKT5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41bc5dec9e4ecaa87e9a199cc17828e6;
          Thu, 28 Feb 2019 22:44:35 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 93/97] Smack: Use the NLTYPE on output
Date:   Thu, 28 Feb 2019 14:43:52 -0800
Message-Id: <20190228224356.2608-24-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Use the saved NLTYPE to determine if the packet needs to
be labeled in the output path.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/smack/smack_netfilter.c | 42 +++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index ea45b173f8ca..7d202dde75b6 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -26,10 +26,19 @@ static bool smack_checked_secmark;
 
 void smack_secmark_refcount_inc(void)
 {
-        smack_use_secmark = true;
+	smack_use_secmark = true;
 	pr_info("Smack: Using network secmarks.\n");
 }
 
+static void smack_own_secmark(void)
+{
+	if (!smack_checked_secmark) {
+		security_secmark_refcount_inc();
+		security_secmark_refcount_dec();
+		smack_checked_secmark = true;
+	}
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 
 static unsigned int smack_ipv6_output(void *priv,
@@ -40,11 +49,7 @@ static unsigned int smack_ipv6_output(void *priv,
 	struct socket_smack *ssp;
 	struct smack_known *skp;
 
-	if (!smack_checked_secmark) {
-		security_secmark_refcount_inc();
-		security_secmark_refcount_dec();
-		smack_checked_secmark = true;
-	}
+	smack_own_secmark();
 
 	if (smack_use_secmark && sk && smack_sock(sk)) {
 		ssp = smack_sock(sk);
@@ -63,17 +68,26 @@ static unsigned int smack_ipv4_output(void *priv,
 	struct sock *sk = skb_to_full_sk(skb);
 	struct socket_smack *ssp;
 	struct smack_known *skp;
+	int rc = 0;
 
-	if (!smack_checked_secmark) {
-		security_secmark_refcount_inc();
-		security_secmark_refcount_dec();
-		smack_checked_secmark = true;
-	}
+	smack_own_secmark();
 
-	if (smack_use_secmark && sk && smack_sock(sk)) {
-		ssp = smack_sock(sk);
-		skp = ssp->smk_out;
+	if (sk == NULL)
+		return NF_ACCEPT;
+
+	ssp = smack_sock(sk);
+	if (ssp == NULL)
+		return NF_ACCEPT;
+
+	skp = ssp->smk_out;
+	if (smack_use_secmark)
 		skb->secmark = skp->smk_secid;
+
+	if (ssp->smk_set == NETLBL_NLTYPE_ADDRSELECT) {
+		rc = netlbl_skbuff_setattr(skb, PF_INET, &skp->smk_netlabel);
+		if (rc < 0)
+			return NF_DROP;
+		ssp->smk_set = rc;
 	}
 
 	return NF_ACCEPT;
-- 
2.17.0

