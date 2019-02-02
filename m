Return-Path: <SRS0=QHdN=QJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15996C282D7
	for <selinux@archiver.kernel.org>; Sat,  2 Feb 2019 09:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEB121479
	for <selinux@archiver.kernel.org>; Sat,  2 Feb 2019 09:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549098598;
	bh=oynVyArdZfzpSvfoRsuewKavtO88peHIleeJoPc/MhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ydy1564KG8nnLXcztNEAyjJZm3cPnGJm+s+1KObXG1Nl1BGEz0X4PheDMP8nWKpOD
	 4VFIRgUY/xt+kX4uWJuMJYX6nw3bCjkdsRKW8YNj+R4JoCKqVzz3l3fbvt1WJPsPIB
	 AuQnCsZxma8SQx/0F+h5Q31PVtlrQ9mRKPmmfDqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfBBJJ6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:09:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfBBJJ6 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 2 Feb 2019 04:09:58 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B3632146E;
        Sat,  2 Feb 2019 09:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549098597;
        bh=oynVyArdZfzpSvfoRsuewKavtO88peHIleeJoPc/MhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jxM1HjY1WESBcazFWentOqxNAbTOR15fxXWROR1IlnR9xhHq4M7n2rK+2B0Ftws/R
         6jSjAqirsC/xlz4ubaXU2CUK4CCU44l7cJivPQRyWY91j0+Z+xH9/f29YaXIFdY46E
         kAw/VfxRgPq1DRLtRn6c8T8IlGUtRlTxD015C6BM=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, selinux@vger.kernel.org,
        paul@paul-moore.com, ddutile@redhat.com
Subject: [PATCH rdma-rc v1 1/4] IB/core: Unregister notifier before freeing MAD security
Date:   Sat,  2 Feb 2019 11:09:42 +0200
Message-Id: <20190202090945.4106-2-leon@kernel.org>
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

If the notifier runs after the security context is freed an access of
freed memory can occur.

Fixes: 47a2b338fe63 ("IB/core: Enforce security on management datagrams")
Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/security.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 1efadbccf394..402449d4a888 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -727,9 +727,10 @@ void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent)
 	if (!rdma_protocol_ib(agent->device, agent->port_num))
 		return;

-	security_ib_free_security(agent->security);
 	if (agent->lsm_nb_reg)
 		unregister_lsm_notifier(&agent->lsm_nb);
+
+	security_ib_free_security(agent->security);
 }

 int ib_mad_enforce_security(struct ib_mad_agent_private *map, u16 pkey_index)
--
2.19.1

