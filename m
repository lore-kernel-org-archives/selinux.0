Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB80BC25B07
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 01:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbiHHBiL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 7 Aug 2022 21:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242466AbiHHBgq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 7 Aug 2022 21:36:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B7E008;
        Sun,  7 Aug 2022 18:33:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 798AF60DB9;
        Mon,  8 Aug 2022 01:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2429C433D6;
        Mon,  8 Aug 2022 01:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659922414;
        bh=D3RJWswlgttNeCNoxN0JrftIQMlO2blD6GKPcxf8Rqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ya9e9eCrflc1u6syTyVPZ0+4w9eQQztKPhy1TFrKCzlx0L81aFJ626+J1U9xZKiWW
         b95Or1CUJITNORV54TGkR5qi0gY51t6IL9zEMw5lmFycmux+vmjmjk9+y9ea+rgawS
         CGmJOjYcxKnBARV9epj+jVDMyJpNkr1dt5xOpCtAQO82j6CPdtOEWhMstvvg6v8dCV
         cFUfyGmfsB9/Kp6uJmFs8Q+IW8tTczQa3eqhVlJkGkjF/QgDc2ALFM46KWMWEYwpEa
         7gf8ZmvhTkDl7ujkDHBMIlXnguxx9Q0QVHI+YCzSn9luxnNck/Bt2daVsJtFgX9wVB
         RJTuj9Z0E0SXA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiu Jianfeng <xiujianfeng@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        cgzones@googlemail.com, omosnace@redhat.com,
        michalorzel.eng@gmail.com, selinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 53/58] selinux: fix memleak in security_read_state_kernel()
Date:   Sun,  7 Aug 2022 21:31:11 -0400
Message-Id: <20220808013118.313965-53-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808013118.313965-1-sashal@kernel.org>
References: <20220808013118.313965-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Xiu Jianfeng <xiujianfeng@huawei.com>

[ Upstream commit 73de1befcc53a7c68b0c5e76b9b5ac41c517760f ]

In this function, it directly returns the result of __security_read_policy
without freeing the allocated memory in *data, cause memory leak issue,
so free the memory if __security_read_policy failed.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
[PM: subject line tweak]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/ss/services.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 69b2734311a6..fe5fcf571c56 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -4048,6 +4048,7 @@ int security_read_policy(struct selinux_state *state,
 int security_read_state_kernel(struct selinux_state *state,
 			       void **data, size_t *len)
 {
+	int err;
 	struct selinux_policy *policy;
 
 	policy = rcu_dereference_protected(
@@ -4060,5 +4061,11 @@ int security_read_state_kernel(struct selinux_state *state,
 	if (!*data)
 		return -ENOMEM;
 
-	return __security_read_policy(policy, *data, len);
+	err = __security_read_policy(policy, *data, len);
+	if (err) {
+		vfree(*data);
+		*data = NULL;
+		*len = 0;
+	}
+	return err;
 }
-- 
2.35.1

