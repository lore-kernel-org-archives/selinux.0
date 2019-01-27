Return-Path: <SRS0=ptWe=QD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D76EC282C0
	for <selinux@archiver.kernel.org>; Sun, 27 Jan 2019 08:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6526C2184B
	for <selinux@archiver.kernel.org>; Sun, 27 Jan 2019 08:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548576629;
	bh=qtfx4QUZTaM7h6k41kP4lOu2Oxq1nh1WNeCU8fZC2QE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=I7gb6KsoIvd68G2h0PlNHOQhVUeuCzLhWXkVnNYHuGv5Qp8B9XxumetyPeho/XTA1
	 0j/NSEEpNhWuA5FHqtUmhI17ErzhbORi6Tgc3+bBGw3jxxFFTvJ3yBefLr1XoB3QDt
	 wv4a7ThLArkfkYk4/rtZzZ92wViMmOun9xjzTnYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfA0IK3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 27 Jan 2019 03:10:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:50224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfA0IK2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sun, 27 Jan 2019 03:10:28 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46EB3217D7;
        Sun, 27 Jan 2019 08:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548576627;
        bh=qtfx4QUZTaM7h6k41kP4lOu2Oxq1nh1WNeCU8fZC2QE=;
        h=From:To:Cc:Subject:Date:From;
        b=nqlvMTLlY8xEmova20mr3UdutiHsP42R4E6TGw5F6n1Vwhf6pRn1+HauQtjzfEp6E
         FuOrPhdk3/kjuXx9YUpSG/8jtkVjr6ULS71JI6iEIAMhGU49ncaU7DpssWHEGaLf2L
         aVGSsfrrC2C/gL1vzKLyOV/oMn2/RsMJJlTAA96A=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Daniel Jurgens <danielj@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        selinux@vger.kernel.org, paul@paul-moore.com, ddutile@redhat.com,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] IB/core: Don't register MAD agents for LSM notifications
Date:   Sun, 27 Jan 2019 10:10:23 +0200
Message-Id: <20190127081023.21124-1-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Daniel Jurgens <danielj@mellanox.com>

When creating many MAD agents in a short period of time receive packet
processing can be delayed long enough to cause timeouts while new agents
are being added to the atomic notifier chain with IRQs disabled.
Notifier chain registration and unregstration is an O(n) operation. With
large numbers of MAD agents being created and destroyed simultaneously
the CPUs spend too much time with interrupts disabled.

After this change previously granted access for MAD agents will not be
revoked if there is a relevant security policy change. This behavior is
already the case for most things controlled by a security policy.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/security.c | 34 ++++--------------------------
 include/rdma/ib_mad.h              |  3 ---
 2 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 1efadbccf394..73598acb518a 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -676,21 +676,6 @@ static int ib_security_pkey_access(struct ib_device *dev,
 	return security_ib_pkey_access(sec, subnet_prefix, pkey);
 }

-static int ib_mad_agent_security_change(struct notifier_block *nb,
-					unsigned long event,
-					void *data)
-{
-	struct ib_mad_agent *ag = container_of(nb, struct ib_mad_agent, lsm_nb);
-
-	if (event != LSM_POLICY_CHANGE)
-		return NOTIFY_DONE;
-
-	ag->smp_allowed = !security_ib_endport_manage_subnet(
-		ag->security, dev_name(&ag->device->dev), ag->port_num);
-
-	return NOTIFY_OK;
-}
-
 int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 				enum ib_qp_type qp_type)
 {
@@ -710,16 +695,9 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 						dev_name(&agent->device->dev),
 						agent->port_num);
 	if (ret)
-		return ret;
+		security_ib_free_security(agent->security);

-	agent->lsm_nb.notifier_call = ib_mad_agent_security_change;
-	ret = register_lsm_notifier(&agent->lsm_nb);
-	if (ret)
-		return ret;
-
-	agent->smp_allowed = true;
-	agent->lsm_nb_reg = true;
-	return 0;
+	return ret;
 }

 void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent)
@@ -728,8 +706,6 @@ void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent)
 		return;

 	security_ib_free_security(agent->security);
-	if (agent->lsm_nb_reg)
-		unregister_lsm_notifier(&agent->lsm_nb);
 }

 int ib_mad_enforce_security(struct ib_mad_agent_private *map, u16 pkey_index)
@@ -737,11 +713,9 @@ int ib_mad_enforce_security(struct ib_mad_agent_private *map, u16 pkey_index)
 	if (!rdma_protocol_ib(map->agent.device, map->agent.port_num))
 		return 0;

-	if (map->agent.qp->qp_type == IB_QPT_SMI) {
-		if (!map->agent.smp_allowed)
-			return -EACCES;
+	/* SMI agent enforcement is done during agent creation */
+	if (map->agent.qp->qp_type == IB_QPT_SMI)
 		return 0;
-	}

 	return ib_security_pkey_access(map->agent.device,
 				       map->agent.port_num,
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index fdef558e3a2d..12543e09c3ed 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -619,9 +619,6 @@ struct ib_mad_agent {
 	u8			port_num;
 	u8			rmpp_version;
 	void			*security;
-	bool			smp_allowed;
-	bool			lsm_nb_reg;
-	struct notifier_block   lsm_nb;
 };

 /**
--
2.19.1

