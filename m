Return-Path: <SRS0=P2Fj=RD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BC9C43381
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EAE206DD
	for <selinux@archiver.kernel.org>; Thu, 28 Feb 2019 22:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QoOvw978"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730918AbfB1Wof (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:44:35 -0500
Received: from sonic301-10.consmr.mail.bf2.yahoo.com ([74.6.129.49]:46635 "EHLO
        sonic301-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730110AbfB1Wof (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 28 Feb 2019 17:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551393874; bh=Aom2uBgZ2TgbnkpBYLBmQEguXBd2kkH61KqQlvE1qx8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=QoOvw978cxNT+hXmheB1R8kCa/AtxIvjyEhc23rrd8M6s4ODMi/Hs8kBHBCzHH/jnwn6kdIaPmiwhZxNpEngO4rCOIkxWoB0AKdLQV+kGayY4vfeU3GTWKEphcC7qrMcu7vuFs/z6FGIuTtim/AaSVVjCMlGu6d9x2gDZqcLdgaAhA35QlhDwxTR31myp2cALbYpBwYmA+lw0ZPN3lZQNtsMlXnmsAwD/VmGOnuTC2fmNswIIE+CwGCtuLeFwhPo97f1ZQLx6Z1F+qR/Gx6p0DDggI9OUgCesfZ0RYYll1Y3pbjQq23PaRcfFs+cF60MW4nP93yFwKNDJ9U43zH07w==
X-YMail-OSG: .tbyCMkVM1l5zH_GU0QAOAob4._wCWjQUriDnvQf.gKOPY_SxNrMHS.ZroHACRf
 _oi7v3TCOKjOXqXzU_z6YMalk5AY6hNbnVfCWr82wIZW0.dkbIYzJ0Vt7lvwoCfyjP4_yhQap0w0
 EXbZ3mCPXKLk6_.dd5KqSHXbh0._ExkePje8X5BM7FlQtJoWpVVhXEU4CeGCco9R2B4vilsN5Ml.
 2944s0IFD.nz1.Shr.LMacF.LCXYXYQRwzHxTpkE3f6WYrloICavZs7bT76LR1THhdrZvw9gVHLR
 Uv.wYIy4jlb6VXrq_bPIvQzDIQLbLs9d26spLciVMwj5q6_720QaBbLhjB6oTHrVd8Brw.FCqoaR
 eN0TEzBSy3k2nhU6C.VadpK9Y8g2mRufxz__swgvZFdBO0dKAGulbW8CSdg67Z9Y2nADTSjA2xQ1
 .arREMekw4yaNXpK7okK3ZLAT3QnzJdALLilwjJQ.kHwMZLFsXN3eHOBwpgpaDS2rgLoJXyiAoCQ
 wlYGCgvt.ykD2Us7IdcBDr6K8L0VJeSMzyUs9NrIQN3kNXyy8a8RpwPdZZzSqgnmGUfoHgUA8wL9
 HnfJ3J82Vs47BrW9Cy7W6GRPXp1KQP5IKjNw7XNbtCVqmwYBx6ZBBGMsizBXA677Hkd9RTg0arvB
 cUtwJvy7KxBbedfppLv7MjS21cRolUC1xYkKZMiuUW3msIIcv65A31MnsS0WxpjpJelgMwbL9inK
 GPwKZ5lgUac_RS5_PGy2qEuZ8vsn6zSnYFdsfchJIbwGPTYs4mGJlqCLF.WdtjBqgA5iHP66Rwo9
 .EqYzU4rGK8vKljHZnOLQQNag.dyB2z7n8v.p2DanwZgUf9s3YwYqPYgMHleTg.jHPhTtc6_PhDJ
 aDDJ2EwZhMz1SDEu3ZgjNVMF6._lufdPUjYKSy8AXRHkoTNwP9bnjXYbP0wAgLCnjzok7vF3ijsA
 6GKQiJuWQZ6RSDCHODBVZR7MxFTj63lmFNhUSV0P_wYwVQkn4xiHJfexK0ppoIo1acaxAptcwoXP
 s86R1PW.5vGom0sEvLm1i8LAda7BGAbUxazfJicDItm7hCw63jacO8i0QFEL2fft8u_Md47q.v96
 .5td.XlDraikotXy7SImAbH4TixWT6x7H48kRQbDXtiNPGSmXICZ.tcBC
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Thu, 28 Feb 2019 22:44:34 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO localhost.localdomain) ([67.169.65.224])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 41bc5dec9e4ecaa87e9a199cc17828e6;
          Thu, 28 Feb 2019 22:44:31 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: [PATCH 90/97] Netlabel: Return the labeling type on socket
Date:   Thu, 28 Feb 2019 14:43:49 -0800
Message-Id: <20190228224356.2608-21-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190228224356.2608-1-casey@schaufler-ca.com>
References: <20190228224356.2608-1-casey@schaufler-ca.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Change netlbl_skbuff_setattr() to return the labeling
type of the domain. This allows the labeling types to
be compared when two LSMs want to determine how a socket
should be used.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 net/netlabel/netlabel_kapi.c | 7 ++++++-
 security/selinux/netlabel.c  | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 2bd765290550..1d362a38dd05 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -1278,7 +1278,8 @@ void netlbl_req_delattr(struct request_sock *req)
  *
  * Description:
  * Attach the correct label to the given packet using the security attributes
- * specified in @secattr.  Returns zero on success, negative values on failure.
+ * specified in @secattr.  Returns the NLTYPE on success, negative values on
+ * failure.
  *
  */
 int netlbl_skbuff_setattr(struct sk_buff *skb,
@@ -1315,6 +1316,8 @@ int netlbl_skbuff_setattr(struct sk_buff *skb,
 		default:
 			ret_val = -ENOENT;
 		}
+		if (ret_val == 0)
+			ret_val = entry->type;
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
@@ -1338,6 +1341,8 @@ int netlbl_skbuff_setattr(struct sk_buff *skb,
 		default:
 			ret_val = -ENOENT;
 		}
+		if (ret_val == 0)
+			ret_val = entry->type;
 		break;
 #endif /* IPv6 */
 	default:
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index ca47c99f964a..b6eede4406bd 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -266,6 +266,8 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
 	}
 
 	rc = netlbl_skbuff_setattr(skb, family, secattr);
+	if (rc > 0)
+		rc = 0;
 
 skbuff_setsid_return:
 	if (secattr == &secattr_storage)
-- 
2.17.0

