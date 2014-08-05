Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s75KMWgt018892
 for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2014 16:22:32 -0400
Subject: [PATCH] selinux: remove unused variabled in the netport, netnode,
 and netif caches
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 05 Aug 2014 16:22:33 -0400
Message-ID: <20140805202233.23695.56312.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: fengguang.wu@intel.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch removes the unused return code variable in the netport,
netnode, and netif initialization functions.

Reported-by: fengguang.wu@intel.com
Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/netif.c   |    4 ++--
 security/selinux/netnode.c |    3 +--
 security/selinux/netport.c |    3 +--
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 3c3de4c..50ce177 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -272,7 +272,7 @@ static struct notifier_block sel_netif_netdev_notifier = {
 
 static __init int sel_netif_init(void)
 {
-	int i, err;
+	int i;
 
 	if (!selinux_enabled)
 		return 0;
@@ -282,7 +282,7 @@ static __init int sel_netif_init(void)
 
 	register_netdevice_notifier(&sel_netif_netdev_notifier);
 
-	return err;
+	return 0;
 }
 
 __initcall(sel_netif_init);
diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
index ddf3152..da923f8 100644
--- a/security/selinux/netnode.c
+++ b/security/selinux/netnode.c
@@ -303,7 +303,6 @@ void sel_netnode_flush(void)
 static __init int sel_netnode_init(void)
 {
 	int iter;
-	int ret;
 
 	if (!selinux_enabled)
 		return 0;
@@ -313,7 +312,7 @@ static __init int sel_netnode_init(void)
 		sel_netnode_hash[iter].size = 0;
 	}
 
-	return ret;
+	return 0;
 }
 
 __initcall(sel_netnode_init);
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 73ac678..3311cc3 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -237,7 +237,6 @@ void sel_netport_flush(void)
 static __init int sel_netport_init(void)
 {
 	int iter;
-	int ret;
 
 	if (!selinux_enabled)
 		return 0;
@@ -247,7 +246,7 @@ static __init int sel_netport_init(void)
 		sel_netport_hash[iter].size = 0;
 	}
 
-	return ret;
+	return 0;
 }
 
 __initcall(sel_netport_init);
