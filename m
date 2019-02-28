Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1440AC10F09
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4903206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="d2T4fRgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbfB1Wol (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:41 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:44364 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731275AbfB1Wol (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393879; bh=oscz6Vi68MsyXM6MI+oD21a/mpleHcjgHRDeaBmng10=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=d2T4fRgiP8iqjNQWRKHk8e7PfBCI/BgXSPH0/meQqZjI0akUDFFCWAXX3XdEVh/fippArV9tuWWAFSt245iA3Y/udCawaKWRCeobEO5bL/8lqsV3NUuqKofFb1lPhZ2K+u1NdNLlqtLIu/BuZgLjX5OrRHLECyFujAoDQ1V9VEIbZtSErSP1yP2XMXGhHeoDezWVAGZ+E0O83+9Ie/GBxMO5X3EUF2FM4c8lqGdpj5B6ogUvSdFf/9vLTYptaS7XN2VtZioAaiq6At2PatB38ikPqmnx83TfLb/DR2EcvWv11kvYKa3l6/Wr9IfvBy5EcnPgAb0PiLIHAtXpmXzgXQ==
X-YMail-OSG: bHKYKvAVM1nqT3Z53bdPCQWzoFChJ11sbbcJS.zlYO5wsZK8SkbREayE3urUkKN
 7QvYGMblkSrPyy_So2f5ndMeWE4Y7eU2f0oUGy7DrfXMGfFt4pQQOLzsw_S6Z7ZpMMM.lTYoJVus
 VhJdqv2Egtq2DxefYzdGRbf8fpW1hSOL3DuslrLUmuLM0EoL9e8iLUDE4TY52.xa2ASjfI7XeWvJ
 uvps6WDVVBAQB8TA6pRiTr8YT5Ub5YtOE75GyoVhTEwVmAcovJgq7c3zWqNCoc8cMAVkP8STvKZk
 GlytdJRUWFQF8AIRmTn3mC6iHxWWW2_l_PbyxUtvf7VvBxm_uWpAQbXV3D0Hk6XAkwAWP1Df3m1m
 E00NotMuwndHDutlktLqzA.EGP2SeV4GC.ALeh4ZumazCuR5vqudVP6tyCPr2vrGiPtHAQHvDjKx
 h4LzlxRVYDS27UIxbzX43A9N4e7nAnOquCZGWQbV.QNORvg0QtGFzTLDY630YQsO5Ob0NSgKOQ01
 .scZXKnBINLbiP9RZ5HM3cOCOdFiCaNCwj1UYk..8e_HFHNyD9wleTSa5pKON74fJzDGJUdQVGNc
 sPiXrZz2fuUWSIvRXcrW9hOcmxpB.tq93JfrolqcvoKUjoCRE.Mh0K20surJAWEjFJvC7Kyq.bIx
 H.CP_obU8dmBYMhU.JiszQQiUaRjtuySITeD2lsjyWJgESepfMVQu88gyqg5KqDzAyU9xPsNucdf
 tMM04LNhIK4qXhnhytDWZTM4bhyuPeAkPjvGw7IC_HsD9_VRDAZaBKN9OGeN4HCeutllQWyWN34V
 oqy0J.YrksBpxPG3968Bj8aKlVKkGRU_q7orqa_YqnRSYmYDJazdfCjZor40fEqFVaF8L90GpvwY
 vFIhYx8IkaDL3rndkfoqqpQQPiVW9yeFl2IsHnMm5OhS7..Slb5MoKcNCQPS2vC1Ap_FsUdrgd3V
 QXWBH9wLIqGWMiMrwZqg1zYiyrtnfOIW86ItOffUsIU2EUJqp3KHwn8DMX53Y9RL7YF76lAuNGpN
 Ov1h_DRR5Asjv0cjXMztDMzBdv4icM.p7S.1kjSoKx.gyYAk707WOQ9WaaYNkZmMTIF1VpZJDsOo
 qxT1ssqcpN0MjYOTMsi4SAPfcYw46KrrlyeFGIl7TGp.Xs9ZG6uaZAHU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:39 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41bc5dec9e4ecaa87e9a199cc17828e6;
          Thu, 28 Feb 2019 22:44:38 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 95/97] LSM: Avoid network conflicts in SELinux and Smack
Date:   Thu, 28 Feb 2019 14:43:54 -0800
Message-Id: <20190228224356.2608-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add calls to security_reconcile_netlbl() in SELinux and
Smack to ensure that only packets that are acceptable to
all active security modules get sent.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/selinux/hooks.c         | 3 +++
 security/smack/smack_netfilter.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 84bfcf7ca08b..4a8996b7b477 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5400,6 +5400,9 @@ static unsigned int selinux_ip_output(struct sk_buff *skb,
 		sid = SECINITSID_KERNEL;
 	if (selinux_netlbl_skbuff_setsid(skb, family, sid) != 0)
 		return NF_DROP;
+	/* verify that this IP option works with other security modules */
+	if (sk && security_reconcile_netlbl(sk))
+		return NF_DROP;
 
 	return NF_ACCEPT;
 }
diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
index 7d202dde75b6..55cc38ae07f5 100644
--- a/security/smack/smack_netfilter.c
+++ b/security/smack/smack_netfilter.c
@@ -89,6 +89,8 @@ static unsigned int smack_ipv4_output(void *priv,
 			return NF_DROP;
 		ssp->smk_set = rc;
 	}
+	if (security_reconcile_netlbl(sk))
+		return NF_DROP;
 
 	return NF_ACCEPT;
 }
-- 
2.17.0

