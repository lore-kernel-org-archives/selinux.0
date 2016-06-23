Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5NJxxsM003689
 for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2016 15:59:59 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: chrisw@sous-sol.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, dledford@redhat.com, sean.hefty@intel.com,
 hal.rosenstock@gmail.com
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-rdma@vger.kernel.org, yevgenyp@mellanox.com,
 Daniel Jurgens <danielj@mellanox.com>
Subject: [PATCH 12/12] IB/core: Implement the Infiniband flush callback
Date: Thu, 23 Jun 2016 22:52:58 +0300
Message-Id: <1466711578-64398-13-git-send-email-danielj@mellanox.com>
In-Reply-To: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Register the callback at init and unregister it at cleanup.

When called walk the device list and call ib_security_cache_change for
each port on each device.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Eli Cohen <eli@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/device.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 63deb5c..5060a7f 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -335,6 +335,29 @@ static int setup_port_pkey_list(struct ib_device *device)
 	return 0;
 }
 
+static void ib_security_flush(void)
+{
+	struct ib_device *dev;
+
+	down_read(&lists_rwsem);
+	list_for_each_entry(dev, &device_list, core_list) {
+		int i;
+
+		for (i = rdma_start_port(dev); i <= rdma_end_port(dev); i++) {
+			u64 sp;
+			int ret = ib_get_cached_subnet_prefix(dev,
+							      i,
+							      &sp);
+
+			WARN_ONCE(ret,
+				  "ib_get_cached_subnet_prefix err: %d, this should never happen here\n",
+				  ret);
+			ib_security_cache_change(dev, i, sp);
+		}
+	}
+	up_read(&lists_rwsem);
+}
+
 /**
  * ib_register_device - Register an IB device with IB core
  * @device:Device to register
@@ -1062,6 +1085,8 @@ static int __init ib_core_init(void)
 		goto err_sa;
 	}
 
+	security_register_ib_flush_callback(&ib_security_flush);
+
 	ib_cache_setup();
 
 	return 0;
@@ -1085,6 +1110,7 @@ err:
 
 static void __exit ib_core_cleanup(void)
 {
+	security_unregister_ib_flush_callback();
 	ib_cache_cleanup();
 	ib_remove_ibnl_clients();
 	ib_sa_cleanup();
-- 
1.8.3.1
