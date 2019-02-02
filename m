Return-Path: <SRS0=QHdN=QJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA53C282D7
	for <selinux@archiver.kernel.org>; Sat,  2 Feb 2019 09:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69D821479
	for <selinux@archiver.kernel.org>; Sat,  2 Feb 2019 09:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549098604;
	bh=SXwIq/1PTbrkvhRQ16mKFxpBJeyvjoUQ4ASPIpKKGFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UqaD/aMMMqrgwmpWRCsAqdIF13VNpyCdHYJyyVrPpWXPvyA9XhF31hUzBQ1y50smT
	 oyCnxLWy3veQEfp8wsIQTkzu2QfjRkf3PsrLFwiqfmAE05LI1P0EJjIhJEw3/Gbwb/
	 8kJPa1zdh6mhtzIFNKjbLxkQB3Z5nyf5Eu/dhU88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfBBJKD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfBBJKD (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 2 Feb 2019 04:10:03 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 798D52146E;
        Sat,  2 Feb 2019 09:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549098602;
        bh=SXwIq/1PTbrkvhRQ16mKFxpBJeyvjoUQ4ASPIpKKGFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/8ijDtJceag9LDZso1LN9k6ZYdoHR1Q0igVpcayI0NbWIrEW8eXM/pdPEMELDeJY
         slPrJhvmP5ZzA+TLlYkbRC9dGwMi0y7HqvcUgLYGPJ2UTH+7yMfJkzl3ZuZti244gd
         z9Ub2+Ua84zsaxUCJc/F6t6bORyJ3RQHBLdxdK54=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, selinux@vger.kernel.org,
        paul@paul-moore.com, ddutile@redhat.com
Subject: [PATCH rdma-rc v1 2/4] IB/core: Fix potential memory leak while creating MAD agents
Date:   Sat,  2 Feb 2019 11:09:43 +0200
Message-Id: <20190202090945.4106-3-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202090945.4106-1-leon@kernel.org>
References: <20190202090945.4106-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Daniel Jurgens <danielj@mellanox.com>

If the MAD agents isn't allowed to manage the subnet, or fails to
register for the LSM notifier, the security context is leaked. Free the
context in these cases.

Fixes: 47a2b338fe63 ("IB/core: Enforce security on management datagrams")
Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Reported-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/security.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 402449d4a888..7662e9347238 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -710,16 +710,20 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 						dev_name(&agent->device->dev),
 						agent->port_num);
 	if (ret)
-		return ret;
+		goto free_security;

 	agent->lsm_nb.notifier_call = ib_mad_agent_security_change;
 	ret = register_lsm_notifier(&agent->lsm_nb);
 	if (ret)
-		return ret;
+		goto free_security;

 	agent->smp_allowed = true;
 	agent->lsm_nb_reg = true;
 	return 0;
+
+free_security:
+	security_ib_free_security(agent->security);
+	return ret;
 }

 void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent)
--
2.19.1

