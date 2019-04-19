Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B2C10F14
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBA521736
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 00:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pKQMvVfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfDSAst (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Apr 2019 20:48:49 -0400
Received: from sonic317-33.consmr.mail.bf2.yahoo.com ([74.6.129.88]:44176 "EHLO
        sonic317-33.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbfDSAst (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Apr 2019 20:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555634928; bh=MLDeC9Ht4LZU4r6lmDzLBrgMarlsX79yWQkujVoSPSc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=pKQMvVfx+nT/yL3wU5sG+NwDCuY0BoTdi1gGRGokqqCpNE2234XFWTMxEuJB9r8SorCBH5rEaFiyK1YViDaYC9+FTYgNROWaA4V0lJb6X/SooeDlNk4mwvyQegBSDstxysXXSlxGCBDJMAyutA+z+HTg4+6R52RILX9A9JHwdiARHoxmSZ2eSpb/q+5S3ZdZj+N2FjfFi5MyHeUPTYhvM2wJ+CE4Akn8rxPD5sWrS+B1QFUFrbeFVFf3LnEIyaAdKoNCQh+i2Umkaj/Sl43J1stue7X9bqxZUSyndFwNGW7pD9wi4q4ZlNgTNXH+YAozuJ4oPq34tML7ozJCjlTwJw==
X-YMail-OSG: NJULh9AVM1lTgNcsu.lN00iqL08Ef2iB8rmCUvbMhkQSSvuZrp9us9RsslvSnt9
 Fvuvra1mPSQARLfHaSOyQcSfiqLL8A0AO1SUifAm6jBrHyR8DNGAnZNC4RxRPQqTV2YLyvMH.sI6
 duooi4jC0Vk6lb7LsKaNmRK79rQBBk1aNxpLyxO3ccYU.4Yo_DqNnLPpwIukpdPsrX7a5x65MrnJ
 HbHOR78njJUg_1kKHsIJqNABGzDi7pHFAntKQ3af_6mnA4djVVQ7Q5uyPSAEqaryr1F47EUCthU_
 0Fb7QmUKnSaeWUIDODtPWnF2XsnXQsW.lWrUthPUTGmSTCjRvMBmQjQOJhnI06OwX96gzP8fwGgA
 Mz8nhNaNr4.hUridKqewMHEo7NF_S_vx52D9NrMMo5.Cksh0JSoDw9gakvkyn9yx738hdOVUIkD0
 LmfRRrNjwOhhGtdpiYrUpR_bScZSZGpb8m6ykT.f2M.NaHc.A1I37_sZNenxJNcH3.GLmNZZZvCT
 _kIa0OSKi7OdJ_ByBIS13jRBnv.9KL393pmXNtoVSpwmhVz_9aTu6_1wr0iKgOBGsQIQVa7_aKQA
 k4cs1fem6A4S8UI0hz67dcTG6wsETE8TrH_r05vcE1KpBC6su996UjyjIsd036DJSsGXuM_rYSSo
 E6ywTKkZsTBRC8KDRCZRdfT8VDMruuXPAiIgNCjLwKiWRPL6IjGf3AdAlX5W39F99rfqg2.4MoQR
 nT2mlsD18qIJz5hm7LSMGGUs9B_PyOrkSG7ahPm6N6D1y_kmOdvrrYaM_Ioa6MP5Ygctd6f6Wi60
 KRrEDBVQY9.gPq_1cp9N96eJVw6XeRzOK23I3MY8YkfIGDHWK9ebn.1FsV.C3T2lTsmAM6Q7JiNa
 BmYYRcUh68zMsQ2gvoAt9V0IB6tMa_0c6frtsXHeu4slSiEf71UwBBHzqREI4mwi_AqKokderocu
 TLCem8pgiEaDZiQ9.r7yQf41tDFamOz2cF4Q9uG_Ht2iuo8o7he8mTX8IDeqiKNmgBFIioUHKhH_
 w49vSLJr0asjOpBqzuTCgENLA.m._cuMc6B0ApsvLFeeTWVcrVV9sKQUHxTWnGCQoSg1IxWDWGN7
 baBIJQZkEZlxn4Kuqu0B6dPuUpHEDHrNoJIv9DVALCq._UAkRHZLx7vs94jgHZFqYMBglKcg4Nkw
 52TEbbIMl1sN.9c436pGyZnlt
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Apr 2019 00:48:48 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp415.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 33cedab91c06b09a1d8646eb41267569;
          Fri, 19 Apr 2019 00:48:45 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com
Subject: [PATCH 64/90] netfilter: Remove unnecessary NULL check in lsm_context
Date:   Thu, 18 Apr 2019 17:45:51 -0700
Message-Id: <20190419004617.64627-65-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190419004617.64627-1-casey@schaufler-ca.com>
References: <20190419004617.64627-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There is a redundant NULL check when releasing a security context.
Remove it.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netfilter/nfnetlink_queue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 7a095b9d0a10..83bb44d70582 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -638,8 +638,7 @@ nfqnl_build_packet_message(struct net *net, struct nfqnl_instance *queue,
 	kfree_skb(skb);
 	net_err_ratelimited("nf_queue: error creating packet message\n");
 nlmsg_failure:
-	if (lc.context)
-		security_release_secctx(&lc);
+	security_release_secctx(&lc);
 	return NULL;
 }
 
-- 
2.19.1

