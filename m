Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u38AKtoB031955
 for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2016 06:20:55 -0400
From: Paolo Abeni <pabeni@redhat.com>
To: linux-security-module@vger.kernel.org
Cc: James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Kees Cook <keescook@chromium.org>, Paul Moore <pmoore@redhat.com>,
 Casey Schaufler <casey@schaufler-ca.com>, linux-kernel@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: [PATCH net-next] security: drop the unused hook skb_owned_by
Date: Fri,  8 Apr 2016 12:20:30 +0200
Message-Id: <25cbac8df32da8527bac7187f606e6351862702d.1460110723.git.pabeni@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The skb_owned_by hook was added with the commit ca10b9e9a8ca
("selinux: add a skb_owned_by() hook") and later removed
when said commit was reverted.

Later on, when switching to list of hooks, a field named
'skb_owned_by' was included into the security_hook_head struct,
but without any users nor caller.

This commit removes the said left-over field.

Fixes: b1d9e6b0646d ("LSM: Switch to lists of hooks")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/lsm_hooks.h | 1 -
 security/security.c       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index cdee11c..ae25378 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1804,7 +1804,6 @@ struct security_hook_heads {
 	struct list_head tun_dev_attach_queue;
 	struct list_head tun_dev_attach;
 	struct list_head tun_dev_open;
-	struct list_head skb_owned_by;
 #endif	/* CONFIG_SECURITY_NETWORK */
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 	struct list_head xfrm_policy_alloc_security;
diff --git a/security/security.c b/security/security.c
index 3644b03..554c3fb 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1848,7 +1848,6 @@ struct security_hook_heads security_hook_heads = {
 	.tun_dev_attach =
 		LIST_HEAD_INIT(security_hook_heads.tun_dev_attach),
 	.tun_dev_open =	LIST_HEAD_INIT(security_hook_heads.tun_dev_open),
-	.skb_owned_by =	LIST_HEAD_INIT(security_hook_heads.skb_owned_by),
 #endif	/* CONFIG_SECURITY_NETWORK */
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 	.xfrm_policy_alloc_security =
-- 
1.8.3.1
