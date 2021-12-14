Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F16C433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Dec 2021 14:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhLNOid (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Dec 2021 09:38:33 -0500
Received: from xmbgsz7.mail.foxmail.com ([61.241.55.176]:54367 "EHLO
        xmbgsz7.mail.foxmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhLNOic (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Dec 2021 09:38:32 -0500
X-Greylist: delayed 14415 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Dec 2021 09:38:32 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639492707;
        bh=55kVr0dlRkSZXsR+36o/Om7tpdn03/ssVT7jqMxOOgw=;
        h=From:To:Cc:Subject:Date;
        b=uY+cE53BOtYQnUZAFOTFZNtwGMoXk3SeCwF6Mn5W3MqNog3DYh0jpZcvKdGuvgp0J
         vQSqYL4+YL/eYSgYguJ+RBTIU1EYkTID3bQTR5V+eOaA5pxWpsc/GhT8nVc1YGurU5
         h9VKxusoryKVtAUNBykANL+MCfvTbI1Vk/HfLyQM=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza23.qq.com (NewEsmtp) with SMTP
        id 8B4AEE74; Tue, 14 Dec 2021 17:34:52 +0800
X-QQ-mid: xmsmtpt1639474492tf5grh2gf
Message-ID: <tencent_D6BF2948237359EE0A47338567B88512D106@qq.com>
X-QQ-XMAILINFO: OTiXS/gPSsXglOJF3mLFeOzLbS3UUL5y3JXRYQ8mK9XYqNnQMxmCJi7lYLHhgM
         bC/HxlsRN/59QASw2gt8sV6rtJlhVw3nWwHFGGkzI7kqge5NwX2xZyljQYveCSqknjSYlcUznOG0
         NGoEy7sSXHK8iBgDUS1ykQxzuiIZkICTMiGXrdlc+bRXjgO9OF2f1ZSbOoe/DyG85zk0lrdAuXtv
         LeVV5N3m8uVRASTKhVEmfRlCZa+NLWyvi9/tYMZ0Ne+q38HYy4SG7BMj7CPyD3igxrby0aLr3GO/
         sS+dt8ETSKSlYNcrKYsOnW/KcT5TcyjvfEYLDJsV78Aevbmx8/Cg3TQG8//ixe9dA9tHmwrJjaSu
         kcLaGDsLlNVaVRK6OP5duB8D0M7ro7vx8XcXwPgT8plbpKTfqEKATFTGq2+LleokB1LC5BZpoVVu
         PYyXMIMRl9QU73oxLcxEbSOP1mJ85Fm9PY2YPA2uRAgAUi23AMEx19PyeuHTEVgzwjBs56WLNPPo
         YJWfXKfbmMp4Fv8SSy+/tgPLZRXXNRv6ef9BHyQuyETZhf7z5P6XMsdlEwfH9w7eUl2Nm9vrVlFA
         vW1zJlaSfur5U96bLEQZtG67rrGlqPx0QRnQ15/t4+Z7ocNKR8H4KPIQLqT2qwdilIh7iAhUGnwk
         mxyP/lqP+7Xkj7TRLBA0xON8sBbqEybVl8dAuWOCYTWVBtQ4d/mpEE4qep5qWmygspKzuMFW2hDX
         deo1UHPteQEV0nUEo6AmoQ1eWRGXJ5CfKGo/s284z27QNkM1Ht+9M8KyYCI72DWSPYyn25pjBO1I
         7tBYd+CjdQXv6fwx2+WnhNgZ4+rVsFfx7LZLdm4VcxlFJsELtkQ/hCqTIWFhgFg1/CHQ8w8ic/OO
         Ze++wBXvwLSizpLhmb6+HlbHnwcFST1gqaTyA3NCK0i4i2a2c5ZYP2aNfeKDDC9w==
From:   xkernel.wang@foxmail.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] selinux: fix a wrong check condition of strcmp()
Date:   Tue, 14 Dec 2021 17:34:43 +0800
X-OQ-MSGID: <20211214093443.2415-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

strcmp() will return 0 when two strings(s1, s2 for example) are equal.
And if a negative number means s1 < s2. Here seems should use == 0 as
the condition. Otherwise, the value of genfs->fstype can not be
guaranteed.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 security/selinux/ss/services.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 759d878..c9f6c3a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2883,7 +2883,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
 
 	for (genfs = policydb->genfs; genfs; genfs = genfs->next) {
 		cmp = strcmp(fstype, genfs->fstype);
-		if (cmp <= 0)
+		if (cmp == 0)
 			break;
 	}
 
-- 
