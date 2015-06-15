From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux: initialize sock security class to default value
Date: Mon, 15 Jun 2015 13:24:50 -0400
Message-Id: <1434389090-1197-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Initialize the security class of sock security structures
to the generic socket class.  This is similar to what is
already done in inode_alloc_security for files.  Generally
the sclass field will later by set by socket_post_create
or sk_clone or sock_graft, but for protocol implementations
that fail to call any of these for newly accepted sockets,
we want some sane default that will yield a legitimate
avc denied message with non-garbage values for class and
permission.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 312537d..90e6cdc 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4507,6 +4507,7 @@ static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority
 
 	sksec->peer_sid = SECINITSID_UNLABELED;
 	sksec->sid = SECINITSID_UNLABELED;
+	sksec->sclass = SECCLASS_SOCKET;
 	selinux_netlbl_sk_security_reset(sksec);
 	sk->sk_security = sksec;
 
-- 
2.1.0
