Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u59D0Gfp002903
 for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2016 09:00:17 -0400
Subject: [PATCH] iucv: properly clone LSM attributes to newly created child
 sockets
From: Paul Moore <pmoore@redhat.com>
To: linux-s390@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov
Date: Thu, 09 Jun 2016 08:59:53 -0400
Message-ID: <146547719343.9258.4899338680484754606.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Much like we had to do for AF_BLUETOOTH and AF_ALG, make sure we
properly clone the parent socket's LSM attributes to newly created
child sockets.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 net/iucv/af_iucv.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index fc3598a..a0d1e36 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -22,6 +22,7 @@
 #include <linux/skbuff.h>
 #include <linux/init.h>
 #include <linux/poll.h>
+#include <linux/security.h>
 #include <net/sock.h>
 #include <asm/ebcdic.h>
 #include <asm/cpcmd.h>
@@ -530,8 +531,10 @@ static void iucv_sock_close(struct sock *sk)
 
 static void iucv_sock_init(struct sock *sk, struct sock *parent)
 {
-	if (parent)
+	if (parent) {
 		sk->sk_type = parent->sk_type;
+		security_sk_clone(parent, sk);
+	}
 }
 
 static struct sock *iucv_sock_alloc(struct socket *sock, int proto, gfp_t prio, int kern)
