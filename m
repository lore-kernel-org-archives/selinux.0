Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5UEa86t010975
 for <selinux@tycho.nsa.gov>; Fri, 30 Jun 2017 10:36:08 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: paul@paul-moore.com, dan.carpenter@oracle.com, dledford@redhat.com
Cc: selinux@tycho.nsa.gov, linux-rdma@vger.kernel.org, yevgenyp@mellanox.com,
 Daniel Jurgens <danielj@mellanox.com>
Subject: [PATCH] IB/core: Fix uninitialized variable use in
 check_qp_port_pkey_settings
Date: Fri, 30 Jun 2017 17:35:35 +0300
Message-Id: <1498833335-937-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Check the return value from get_pkey_and_subnet_prefix to prevent using
uninitialized variables.

Fixes: d291f1a65232 ("IB/core: Enforce PKey security on QPs")
Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/core/security.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/security.c b/drivers/infiniband/core/security.c
index 3e8c389..70ad19c 100644
--- a/drivers/infiniband/core/security.c
+++ b/drivers/infiniband/core/security.c
@@ -120,21 +120,25 @@ static int check_qp_port_pkey_settings(struct ib_ports_pkeys *pps,
 		return 0;
 
 	if (pps->main.state != IB_PORT_PKEY_NOT_VALID) {
-		get_pkey_and_subnet_prefix(&pps->main,
-					   &pkey,
-					   &subnet_prefix);
+		ret = get_pkey_and_subnet_prefix(&pps->main,
+						 &pkey,
+						 &subnet_prefix);
+		if (ret)
+			return ret;
 
 		ret = enforce_qp_pkey_security(pkey,
 					       subnet_prefix,
 					       sec);
+		if (ret)
+			return ret;
 	}
-	if (ret)
-		return ret;
 
 	if (pps->alt.state != IB_PORT_PKEY_NOT_VALID) {
-		get_pkey_and_subnet_prefix(&pps->alt,
-					   &pkey,
-					   &subnet_prefix);
+		ret = get_pkey_and_subnet_prefix(&pps->alt,
+						 &pkey,
+						 &subnet_prefix);
+		if (ret)
+			return ret;
 
 		ret = enforce_qp_pkey_security(pkey,
 					       subnet_prefix,
-- 
1.8.3.1
