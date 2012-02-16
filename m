From: Eric Paris <eparis@redhat.com>
Subject: [PATCH] selinux: include flow.h where used rather than get it
	indirectly
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, pmoore@redhat.com
Date: Thu, 16 Feb 2012 15:08:13 -0500
Message-ID: <20120216200813.30665.73074.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We use flow_cache_genid in the selinux xfrm files.  This is declared in
net/flow.h  However we do not include that file directly anywhere.  We have
always just gotten it through a long chain of indirect .h file includes.

on x86_64:

  CC      security/selinux/ss/services.o
In file included from
/next/linux-next-20120216/security/selinux/ss/services.c:69:0:
/next/linux-next-20120216/security/selinux/include/xfrm.h: In function 'selinux_xfrm_notify_policyload':
/next/linux-next-20120216/security/selinux/include/xfrm.h:51:14: error: 'flow_cache_genid' undeclared (first use in this function)
/next/linux-next-20120216/security/selinux/include/xfrm.h:51:14: note: each undeclared identifier is reported only once for each function it appears in
make[3]: *** [security/selinux/ss/services.o] Error 1

Reported-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Eric Paris <eparis@redhat.com>
---

 net/xfrm/xfrm_policy.c          |    1 +
 security/selinux/include/xfrm.h |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 7661576..596f125 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -26,6 +26,7 @@
 #include <linux/cache.h>
 #include <linux/audit.h>
 #include <net/dst.h>
+#include <net/flow.h>
 #include <net/xfrm.h>
 #include <net/ip.h>
 #ifdef CONFIG_XFRM_STATISTICS
diff --git a/security/selinux/include/xfrm.h b/security/selinux/include/xfrm.h
index b43813c..c220f31 100644
--- a/security/selinux/include/xfrm.h
+++ b/security/selinux/include/xfrm.h
@@ -7,6 +7,8 @@
 #ifndef _SELINUX_XFRM_H_
 #define _SELINUX_XFRM_H_
 
+#include <net/flow.h>
+
 int selinux_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 			      struct xfrm_user_sec_ctx *sec_ctx);
 int selinux_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
