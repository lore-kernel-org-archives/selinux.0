Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5NJv5dF003270
 for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2016 15:57:07 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: chrisw@sous-sol.org, paul@paul-moore.com, sds@tycho.nsa.gov,
 eparis@parisplace.org, dledford@redhat.com, sean.hefty@intel.com,
 hal.rosenstock@gmail.com
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 linux-rdma@vger.kernel.org, yevgenyp@mellanox.com,
 Daniel Jurgens <danielj@mellanox.com>
Subject: [PATCH 03/12] selinux: Implement Infiniband flush callback
Date: Thu, 23 Jun 2016 22:52:49 +0300
Message-Id: <1466711578-64398-4-git-send-email-danielj@mellanox.com>
In-Reply-To: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
References: <1466711578-64398-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Because access for infiniband is enforced in the setup phase of a
connection there must be a way to notify ib_core if the policy or
enforcement setting have changed.

Added register and unregister_ib_flush_callback hooks so infiniband can
setup notification of policy and enforment changes.  In the AVC reset
callback function call the ib_flush callback if it's registered. Also
renamed the callback function, the previous name was 'net' specific.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Eli Cohen <eli@mellanox.com>
---
 security/selinux/hooks.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a86d537..6a8841d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -94,6 +94,9 @@
 #include "audit.h"
 #include "avc_ss.h"
 
+static void (*ib_flush_callback)(void);
+static DEFINE_MUTEX(ib_flush_mutex);
+
 /* SECMARK reference count */
 static atomic_t selinux_secmark_refcount = ATOMIC_INIT(0);
 
@@ -159,13 +162,17 @@ static int selinux_peerlbl_enabled(void)
 	return (selinux_policycap_alwaysnetwork || netlbl_enabled() || selinux_xfrm_enabled());
 }
 
-static int selinux_netcache_avc_callback(u32 event)
+static int selinux_cache_avc_callback(u32 event)
 {
 	if (event == AVC_CALLBACK_RESET) {
 		sel_netif_flush();
 		sel_netnode_flush();
 		sel_netport_flush();
 		synchronize_net();
+		mutex_lock(&ib_flush_mutex);
+		if (ib_flush_callback)
+			ib_flush_callback();
+		mutex_unlock(&ib_flush_mutex);
 	}
 	return 0;
 }
@@ -5993,6 +6000,23 @@ static int selinux_key_getsecurity(struct key *key, char **_buffer)
 
 #endif
 
+#ifdef CONFIG_SECURITY_INFINIBAND
+static void selinux_register_ib_flush_callback(void (*callback)(void))
+{
+	mutex_lock(&ib_flush_mutex);
+	ib_flush_callback = callback;
+	mutex_unlock(&ib_flush_mutex);
+}
+
+static void selinux_unregister_ib_flush_callback(void)
+{
+	mutex_lock(&ib_flush_mutex);
+	ib_flush_callback = NULL;
+	mutex_unlock(&ib_flush_mutex);
+}
+
+#endif
+
 static struct security_hook_list selinux_hooks[] = {
 	LSM_HOOK_INIT(binder_set_context_mgr, selinux_binder_set_context_mgr),
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
@@ -6174,6 +6198,12 @@ static struct security_hook_list selinux_hooks[] = {
 	LSM_HOOK_INIT(tun_dev_attach_queue, selinux_tun_dev_attach_queue),
 	LSM_HOOK_INIT(tun_dev_attach, selinux_tun_dev_attach),
 	LSM_HOOK_INIT(tun_dev_open, selinux_tun_dev_open),
+#ifdef CONFIG_SECURITY_INFINIBAND
+	LSM_HOOK_INIT(register_ib_flush_callback,
+		      selinux_register_ib_flush_callback),
+	LSM_HOOK_INIT(unregister_ib_flush_callback,
+		      selinux_unregister_ib_flush_callback),
+#endif
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 	LSM_HOOK_INIT(xfrm_policy_alloc_security, selinux_xfrm_policy_alloc),
@@ -6233,9 +6263,11 @@ static __init int selinux_init(void)
 					    0, SLAB_PANIC, NULL);
 	avc_init();
 
+	ib_flush_callback = NULL;
+
 	security_add_hooks(selinux_hooks, ARRAY_SIZE(selinux_hooks));
 
-	if (avc_add_callback(selinux_netcache_avc_callback, AVC_CALLBACK_RESET))
+	if (avc_add_callback(selinux_cache_avc_callback, AVC_CALLBACK_RESET))
 		panic("SELinux: Unable to register AVC netcache callback\n");
 
 	if (selinux_enforcing)
-- 
1.8.3.1
