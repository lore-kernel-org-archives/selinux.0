Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5NKDa70006283
 for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2016 16:13:37 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: chrisw@sous-sol.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, dledford@redhat.com, sean.hefty@intel.com,
 hal.rosenstock@gmail.com
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-rdma@vger.kernel.org, yevgenyp@mellanox.com,
 Daniel Jurgens <danielj@mellanox.com>
Subject: [PATCH 11/12] IB/core: Enforce Infiniband device SMI security
Date: Thu, 23 Jun 2016 22:52:57 +0300
Message-Id: <1466711578-64398-12-git-send-email-danielj@mellanox.com>
In-Reply-To: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

During MAD and snoop agent registration for SMI QPs check that the
calling process has permission to access the SMI.

When sending and receiving MADs check that the agent has access to the
SMI if it's on an SMI QP.  Because security policy can change it's
possible permission was allowed when creating the agent, but no longer
is.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Eli Cohen <eli@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/mad.c | 44 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 975b472..684dcac 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -345,6 +345,16 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 		goto error3;
 	}
 
+	if (qp_type == IB_QPT_SMI) {
+		ret2 = security_ib_end_port_smp(device->name,
+						port_num,
+						&mad_agent_priv->agent);
+		if (ret2) {
+			ret = ERR_PTR(ret2);
+			goto error4;
+		}
+	}
+
 	if (mad_reg_req) {
 		reg_req = kmemdup(mad_reg_req, sizeof *reg_req, GFP_KERNEL);
 		if (!reg_req) {
@@ -531,6 +541,17 @@ struct ib_mad_agent *ib_register_mad_snoop(struct ib_device *device,
 		goto error2;
 	}
 
+	if (qp_type == IB_QPT_SMI) {
+		err = security_ib_end_port_smp(device->name,
+					       port_num,
+					       &mad_snoop_priv->agent);
+
+		if (err) {
+			ret = ERR_PTR(err);
+			goto error3;
+		}
+	}
+
 	/* Now, fill in the various structures */
 	mad_snoop_priv->qp_info = &port_priv->qp_info[qpn];
 	mad_snoop_priv->agent.device = device;
@@ -1244,6 +1265,7 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 
 	/* Walk list of send WRs and post each on send list */
 	for (; send_buf; send_buf = next_send_buf) {
+		int err = 0;
 
 		mad_send_wr = container_of(send_buf,
 					   struct ib_mad_send_wr_private,
@@ -1251,6 +1273,17 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 		mad_agent_priv = mad_send_wr->mad_agent_priv;
 		pkey_index = mad_send_wr->send_wr.pkey_index;
 
+		if (mad_agent_priv->agent.qp->qp_type == IB_QPT_SMI)
+			err = security_ib_end_port_smp(
+					mad_agent_priv->agent.device->name,
+					mad_agent_priv->agent.port_num,
+					&mad_agent_priv->agent);
+
+		if (err) {
+			ret = err;
+			goto error;
+		}
+
 		ret = ib_security_ma_pkey_access(mad_agent_priv->agent.device,
 						 mad_agent_priv->agent.port_num,
 						 pkey_index,
@@ -1992,7 +2025,16 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 	struct ib_mad_send_wr_private *mad_send_wr;
 	struct ib_mad_send_wc mad_send_wc;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
+
+	if (mad_agent_priv->agent.qp->qp_type == IB_QPT_SMI)
+		ret = security_ib_end_port_smp(
+					mad_agent_priv->agent.device->name,
+					mad_agent_priv->agent.port_num,
+					&mad_agent_priv->agent);
+
+	if (ret)
+		goto security_error;
 
 	ret = ib_security_ma_pkey_access(mad_agent_priv->agent.device,
 					 mad_agent_priv->agent.port_num,
-- 
1.8.3.1
