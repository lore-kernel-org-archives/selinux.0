Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5NK5eKd005321
 for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2016 16:05:40 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: chrisw@sous-sol.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, dledford@redhat.com, sean.hefty@intel.com,
 hal.rosenstock@gmail.com
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-rdma@vger.kernel.org, yevgenyp@mellanox.com,
 Daniel Jurgens <danielj@mellanox.com>
Subject: [PATCH 04/12] selinux: Allocate and free infiniband security hooks
Date: Thu, 23 Jun 2016 22:52:50 +0300
Message-Id: <1466711578-64398-5-git-send-email-danielj@mellanox.com>
In-Reply-To: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Implement and attach hooks to allocate and free Infiniband QP and MAD
agent security structures.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Eli Cohen <eli@mellanox.com>
---
 include/rdma/ib_mad.h             |  1 +
 include/rdma/ib_verbs.h           |  1 +
 security/selinux/hooks.c          | 53 +++++++++++++++++++++++++++++++++++++++
 security/selinux/include/objsec.h |  5 ++++
 4 files changed, 60 insertions(+)

diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index c8a773f..a1ed025 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -537,6 +537,7 @@ struct ib_mad_agent {
 	u32			flags;
 	u8			port_num;
 	u8			rmpp_version;
+	void			*m_security;
 };
 
 /**
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3f6780b..e522acb 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1454,6 +1454,7 @@ struct ib_qp {
 	void		       *qp_context;
 	u32			qp_num;
 	enum ib_qp_type		qp_type;
+	struct ib_qp_security  *qp_sec;
 };
 
 struct ib_mr {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6a8841d..4f13ea4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -17,6 +17,7 @@
  *	Paul Moore <paul@paul-moore.com>
  *  Copyright (C) 2007 Hitachi Software Engineering Co., Ltd.
  *		       Yuichi Nakamura <ynakam@hitachisoft.jp>
+ *  Copyright (C) 2016 Mellanox Technologies
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License version 2,
@@ -83,6 +84,8 @@
 #include <linux/export.h>
 #include <linux/msg.h>
 #include <linux/shm.h>
+#include <rdma/ib_verbs.h>
+#include <rdma/ib_mad.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -6015,6 +6018,47 @@ static void selinux_unregister_ib_flush_callback(void)
 	mutex_unlock(&ib_flush_mutex);
 }
 
+static int selinux_ib_qp_alloc_security(struct ib_qp_security *qp_sec)
+{
+	struct ib_security_struct *sec;
+
+	sec = kzalloc(sizeof(*sec), GFP_ATOMIC);
+	if (!sec)
+		return -ENOMEM;
+	sec->sid = current_sid();
+
+	qp_sec->q_security = sec;
+	return 0;
+}
+
+static void selinux_ib_qp_free_security(struct ib_qp_security *qp_sec)
+{
+	struct ib_security_struct *sec = qp_sec->q_security;
+
+	qp_sec->q_security = NULL;
+	kfree(sec);
+}
+
+static int selinux_ib_mad_agent_alloc_security(struct ib_mad_agent *mad_agent)
+{
+	struct ib_security_struct *sec;
+
+	sec = kzalloc(sizeof(*sec), GFP_ATOMIC);
+	if (!sec)
+		return -ENOMEM;
+	sec->sid = current_sid();
+
+	mad_agent->m_security = sec;
+	return 0;
+}
+
+static void selinux_ib_mad_agent_free_security(struct ib_mad_agent *mad_agent)
+{
+	struct ib_security_struct *sec = mad_agent->m_security;
+
+	mad_agent->m_security = NULL;
+	kfree(sec);
+}
 #endif
 
 static struct security_hook_list selinux_hooks[] = {
@@ -6198,11 +6242,20 @@ static struct security_hook_list selinux_hooks[] = {
 	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
 	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
 	LSM_HOOK_INIT(tun_dev_open, selinux_tun_dev_open),
+
 #ifdef CONFIG_SECURITY_INFINIBAND
 	LSM_HOOK_INIT(register_ib_flush_callback,
 		      selinux_register_ib_flush_callback),
 	LSM_HOOK_INIT(unregister_ib_flush_callback,
 		      selinux_unregister_ib_flush_callback),
+	LSM_HOOK_INIT(ib_qp_alloc_security,
+		      selinux_ib_qp_alloc_security),
+	LSM_HOOK_INIT(ib_qp_free_security,
+		      selinux_ib_qp_free_security),
+	LSM_HOOK_INIT(ib_mad_agent_alloc_security,
+		      selinux_ib_mad_agent_alloc_security),
+	LSM_HOOK_INIT(ib_mad_agent_free_security,
+		      selinux_ib_mad_agent_free_security),
 #endif
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
diff --git a/security/selinux/include/objsec.h b/security/selinux/include/objsec.h
index c21e135..8e7db43 100644
--- a/security/selinux/include/objsec.h
+++ b/security/selinux/include/objsec.h
@@ -10,6 +10,7 @@
  *
  *  Copyright (C) 2001,2002 Networks Associates Technology, Inc.
  *  Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *  Copyright (C) 2016 Mellanox Technologies
  *
  *	This program is free software; you can redistribute it and/or modify
  *	it under the terms of the GNU General Public License version 2,
@@ -128,6 +129,10 @@ struct key_security_struct {
 	u32 sid;	/* SID of key */
 };
 
+struct ib_security_struct {
+	u32 sid;        /* SID of the queue pair or MAD agent */
+};
+
 extern unsigned int selinux_checkreqprot;
 
 #endif /* _SELINUX_OBJSEC_H_ */
-- 
1.8.3.1
