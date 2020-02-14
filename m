Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0C8C3B1A6
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 17:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC612168B
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581701597;
	bh=Du1mF7eeMg+m+or7MrRy+2BjnUnht8x6SX8IIkgj73U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=al3DGm8FUyyWzj/9Uf8EDIGgrA1oiNPGQ9o8/r5wtsQVMfcBCoI70RMLtIszcS00i
	 STH8j/cdGDYP3H/Rp5ZQaWX22dhcC5Fx+PfqW/TD6aIdiiqlYqD2obwvnFp1ON9oZI
	 crTG2acdufil/u6KSC3SQUvjVTddpismN5u8MRaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390443AbgBNQGb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:06:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390441AbgBNQGb (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 14 Feb 2020 11:06:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF0B724670;
        Fri, 14 Feb 2020 16:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696390;
        bh=Du1mF7eeMg+m+or7MrRy+2BjnUnht8x6SX8IIkgj73U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=au5AqRuv6kj1a07T3B0GFHJlPp2w5vSak/ig7CTmr4wFq78EHTurj6t8iU27WCCfE
         l40XHQlfZkaf9O8MkYmdFmIbopgR+ioVxik26Qoq6FA0Y8b6vqlTl0cFUtYZ97H6aF
         EOTPOYm54BXFWCexwAsC+cR0ZYA2GQXfXLdbBs0w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaihind Yadav <jaihindyadav@codeaurora.org>,
        Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>, selinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 216/459] selinux: ensure we cleanup the internal AVC counters on error in avc_update()
Date:   Fri, 14 Feb 2020 10:57:46 -0500
Message-Id: <20200214160149.11681-216-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Jaihind Yadav <jaihindyadav@codeaurora.org>

[ Upstream commit 030b995ad9ece9fa2d218af4429c1c78c2342096 ]

In AVC update we don't call avc_node_kill() when avc_xperms_populate()
fails, resulting in the avc->avc_cache.active_nodes counter having a
false value.  In last patch this changes was missed , so correcting it.

Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
Signed-off-by: Jaihind Yadav <jaihindyadav@codeaurora.org>
Signed-off-by: Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>
[PM: merge fuzz, minor description cleanup]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/selinux/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 6646300f7ccb2..d18cb32a242ae 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -891,7 +891,7 @@ static int avc_update_node(struct selinux_avc *avc,
 	if (orig->ae.xp_node) {
 		rc = avc_xperms_populate(node, orig->ae.xp_node);
 		if (rc) {
-			kmem_cache_free(avc_node_cachep, node);
+			avc_node_kill(avc, node);
 			goto out_unlock;
 		}
 	}
-- 
2.20.1

