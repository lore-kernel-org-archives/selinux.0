Return-Path: <SRS0=QHdN=QJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343B5C282D7
	for <selinux@archiver.kernel.org>; Sat,  2 Feb 2019 09:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F184C21479
	for <selinux@archiver.kernel.org>; Sat,  2 Feb 2019 09:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549098614;
	bh=nspb0r4Ib0aoz0I02UQACFsIEZB8d61cn2lpj58O9Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mW80ZtI/htPRFUbD2w3o7PQVwt3hr7GNJx9xn7/SvLFbEFsFY1dUiOOACeZskx9vk
	 8cKS2Sa/m+umavUq2PaR/f3/TqhquPJVpRlwHgXP2VL7oBPU5pl61euFfGAPkhDzLa
	 cymASWs9s8bHkFYcod7aJ35kkyChr0/SLeVbz8SI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfBBJKN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:10:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfBBJKN (ORCPT <rfc822;selinux@vger.kernel.org>);
        Sat, 2 Feb 2019 04:10:13 -0500
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E3652146E;
        Sat,  2 Feb 2019 09:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549098611;
        bh=nspb0r4Ib0aoz0I02UQACFsIEZB8d61cn2lpj58O9Ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHt8+uvhmYlU/DDM4zpncMmo9v/Skz3EHIO9BdpPJN2VWvF3iVKxN7b3kiHYjo91G
         37gjcJuRVNDqXQWKxBcrwh8DET6YWNv0CtWwYcUdr8FFzg95lFnWVAV0CLQaWJifa3
         BYwDRcj2UzUSkihJuzKtS/t6n2s6pqGgZIZzjC38=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, selinux@vger.kernel.org,
        paul@paul-moore.com, ddutile@redhat.com
Subject: [PATCH rdma-rc v1 4/4] IB/core: Don't register each MAD agent for LSM notifier
Date:   Sat,  2 Feb 2019 11:09:45 +0200
Message-Id: <20190202090945.4106-5-leon@kernel.org>
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

When creating many MAD agents in a short period of time, receive packet
processing can be delayed long enough to cause timeouts while new agents
are being added to the atomic notifier chain with IRQs disabled.
Notifier chain registration and unregstration is an O(n) operation. With
large numbers of MAD agents being created and destroyed simultaneously
the CPUs spend too much time with interrupts disabled.

Instead of each MAD agent registering for it's own LSM notification,
maintain a list of agents internally and register once, this
registration already existed for handling the PKeys. This list is write
mostly, so a normal spin lock is used vs a read/write lock. All MAD agents
must be checked, so a single list is used instead of breaking them down
per device.

Notifier calls are done under rcu_read_lock, so there isn't a risk of
similar packet timeouts while checking the MAD agents security settings
when notified.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
CC: selinux@vger.kernel.org
CC: paul@paul-moore.com
CC: ddutile@redhat.com
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/core_priv.h |  5 +++
 drivers/infiniband/core/device.c    |  1 +
 drivers/infiniband/core/security.c  | 50 ++++++++++++++++-------------
 include/rdma/ib_mad.h               |  3 +-
 4 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index 616734313f0c..6fd3d3d06d18 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -199,6 +199,7 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 				enum ib_qp_type qp_type);
 void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent);
 int ib_mad_enforce_security(struct ib_mad_agent_private *map, u16 pkey_index);
+void ib_mad_agent_security_change(void);
 #else
 static inline void ib_security_destroy_port_pkey_list(struct ib_device *device)
 {
@@ -264,6 +265,10 @@ static inline int ib_mad_enforce_security(struct ib_mad_agent_private *map,
 {
 	return 0;
 }
+
+static inline void ib_mad_agent_security_change(void)
+{
+}
 #endif

 struct ib_device *ib_device_get_by_index(u32 ifindex);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 238ec42778ef..8c1d8ffb09e2 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -455,6 +455,7 @@ static int ib_security_change(struct notifier_block *nb, unsigned long event,
 		return NOTIFY_DONE;

 	schedule_work(&ib_policy_change_work);
+	ib_mad_agent_security_change();

 	return NOTIFY_OK;
 }
diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 7662e9347238..a70d2ba312ed 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -39,6 +39,10 @@
 #include "core_priv.h"
 #include "mad_priv.h"

+static LIST_HEAD(mad_agent_list);
+/* Lock to protect mad_agent_list */
+static DEFINE_SPINLOCK(mad_agent_list_lock);
+
 static struct pkey_index_qp_list *get_pkey_idx_qp_list(struct ib_port_pkey *pp)
 {
 	struct pkey_index_qp_list *pkey = NULL;
@@ -676,19 +680,18 @@ static int ib_security_pkey_access(struct ib_device *dev,
 	return security_ib_pkey_access(sec, subnet_prefix, pkey);
 }

-static int ib_mad_agent_security_change(struct notifier_block *nb,
-					unsigned long event,
-					void *data)
+void ib_mad_agent_security_change(void)
 {
-	struct ib_mad_agent *ag = container_of(nb, struct ib_mad_agent, lsm_nb);
-
-	if (event != LSM_POLICY_CHANGE)
-		return NOTIFY_DONE;
-
-	ag->smp_allowed = !security_ib_endport_manage_subnet(
-		ag->security, dev_name(&ag->device->dev), ag->port_num);
-
-	return NOTIFY_OK;
+	struct ib_mad_agent *ag;
+
+	spin_lock(&mad_agent_list_lock);
+	list_for_each_entry(ag,
+			    &mad_agent_list,
+			    mad_agent_sec_list)
+		WRITE_ONCE(ag->smp_allowed,
+			   !security_ib_endport_manage_subnet(ag->security,
+				dev_name(&ag->device->dev), ag->port_num));
+	spin_unlock(&mad_agent_list_lock);
 }

 int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
@@ -699,6 +702,8 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 	if (!rdma_protocol_ib(agent->device, agent->port_num))
 		return 0;

+	INIT_LIST_HEAD(&agent->mad_agent_sec_list);
+
 	ret = security_ib_alloc_security(&agent->security);
 	if (ret)
 		return ret;
@@ -706,22 +711,20 @@ int ib_mad_agent_security_setup(struct ib_mad_agent *agent,
 	if (qp_type != IB_QPT_SMI)
 		return 0;

+	spin_lock(&mad_agent_list_lock);
 	ret = security_ib_endport_manage_subnet(agent->security,
 						dev_name(&agent->device->dev),
 						agent->port_num);
 	if (ret)
 		goto free_security;

-	agent->lsm_nb.notifier_call = ib_mad_agent_security_change;
-	ret = register_lsm_notifier(&agent->lsm_nb);
-	if (ret)
-		goto free_security;
-
-	agent->smp_allowed = true;
-	agent->lsm_nb_reg = true;
+	WRITE_ONCE(agent->smp_allowed, true);
+	list_add(&agent->mad_agent_sec_list, &mad_agent_list);
+	spin_unlock(&mad_agent_list_lock);
 	return 0;

 free_security:
+	spin_unlock(&mad_agent_list_lock);
 	security_ib_free_security(agent->security);
 	return ret;
 }
@@ -731,8 +734,11 @@ void ib_mad_agent_security_cleanup(struct ib_mad_agent *agent)
 	if (!rdma_protocol_ib(agent->device, agent->port_num))
 		return;

-	if (agent->lsm_nb_reg)
-		unregister_lsm_notifier(&agent->lsm_nb);
+	if (agent->qp->qp_type == IB_QPT_SMI) {
+		spin_lock(&mad_agent_list_lock);
+		list_del(&agent->mad_agent_sec_list);
+		spin_unlock(&mad_agent_list_lock);
+	}

 	security_ib_free_security(agent->security);
 }
@@ -743,7 +749,7 @@ int ib_mad_enforce_security(struct ib_mad_agent_private *map, u16 pkey_index)
 		return 0;

 	if (map->agent.qp->qp_type == IB_QPT_SMI) {
-		if (!map->agent.smp_allowed)
+		if (!READ_ONCE(map->agent.smp_allowed))
 			return -EACCES;
 		return 0;
 	}
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index 1c0b914f199d..79ba8219e7dc 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -617,11 +617,10 @@ struct ib_mad_agent {
 	u32			hi_tid;
 	u32			flags;
 	void			*security;
-	struct notifier_block   lsm_nb;
+	struct list_head	mad_agent_sec_list;
 	u8			port_num;
 	u8			rmpp_version;
 	bool			smp_allowed;
-	bool			lsm_nb_reg;
 };

 /**
--
2.19.1

