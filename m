Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5UFG5iG027624
 for <selinux@tycho.nsa.gov>; Fri, 30 Jun 2017 11:16:05 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: paul@paul-moore.com, dan.carpenter@oracle.com, dledford@redhat.com
Cc: selinux@tycho.nsa.gov, linux-rdma@vger.kernel.org, yevgenyp@mellanox.com,
 Daniel Jurgens <danielj@mellanox.com>
Subject: [PATCH] IB/core: Fix static analysis warning in ib_policy_change_task
Date: Fri, 30 Jun 2017 18:15:56 +0300
Message-Id: <1498835756-7610-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

ib_get_cached_subnet_prefix can technically fail, but the only way it
could is not possible based on the loop conditions. Check the return
value before using the variable sp to resolve a static analysis warning.

Fixes: 8f408ab64be6 ("selinux lsm IB/core: Implement LSM notification
system")
Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/core/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 631eaa9..dabd9f9 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -376,7 +376,8 @@ static void ib_policy_change_task(struct work_struct *work)
 			WARN_ONCE(ret,
 				  "ib_get_cached_subnet_prefix err: %d, this should never happen here\n",
 				  ret);
-			ib_security_cache_change(dev, i, sp);
+			if (ret)
+				ib_security_cache_change(dev, i, sp);
 		}
 	}
 	up_read(&lists_rwsem);
-- 
1.8.3.1
