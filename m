Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QDR6vZ029588
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 09:27:06 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH] SELinux: selinux/xfrm.h needs net/flow.h
To: james.l.morris@oracle.com
Cc: akpm@linux-foundation.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Mar 2012 14:26:55 +0100
Message-ID: <20120326132655.24476.66795.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

selinux/xfrm.h needs to #include net/flow.h or else suffer:

In file included from security/selinux/ss/services.c:69:0:
security/selinux/include/xfrm.h: In function 'selinux_xfrm_notify_policyload':
security/selinux/include/xfrm.h:53:14: error: 'flow_cache_genid' undeclared (first use in this function)
security/selinux/include/xfrm.h:53:14: note: each undeclared identifier is reported only once for each function it appears in

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/selinux/include/xfrm.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

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
