Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6FFC3B1B2
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 18:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8725C222C2
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 18:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703716;
	bh=Du1mF7eeMg+m+or7MrRy+2BjnUnht8x6SX8IIkgj73U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TjfMI7hxn6j4juls4gQghbzDkEftGDYe3jiQcYiF0ADgiNFu0U3Dn6RcS7+6hW+bH
	 BbBXgbti8RiRDOigln/dUeSt1knBBS8aWCVXjeZpN8HaVAEayE2Kmhia0HIwuRtkSG
	 JfQd2pZvwHQZZvH7MxNS+kt4rocLFdaGYUoLyoxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbgBNPyT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:54:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731470AbgBNPyT (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 14 Feb 2020 10:54:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 444392467E;
        Fri, 14 Feb 2020 15:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695658;
        bh=Du1mF7eeMg+m+or7MrRy+2BjnUnht8x6SX8IIkgj73U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yx5mfxAax/gSmLAP3RfC3tp5S59jk4g4umCXV2HX7GJWH0ySJw5RoXPWoxgBJVfY7
         Lz1ZnL214SL+aKnQ4BFbM23oWSU1xpbHOFGer7N3i8S8B5BdwjA7RVMEh6q8Cp4wdY
         0YarT2TIMoIaXraJ43nNh+CNPolvPSJRiHWqdcyY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaihind Yadav <jaihindyadav@codeaurora.org>,
        Ravi Kumar Siddojigari <rsiddoji@codeaurora.org>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <sashal@kernel.org>, selinux@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 249/542] selinux: ensure we cleanup the internal AVC counters on error in avc_update()
Date:   Fri, 14 Feb 2020 10:44:01 -0500
Message-Id: <20200214154854.6746-249-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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

