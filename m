From: David Herrmann <dh.herrmann@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
 teg@jklm.no, Stephen Smalley <sds@tycho.nsa.gov>,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 Eric Paris <eparis@parisplace.org>, serge@hallyn.com,
 Casey Schaufler <casey@schaufler-ca.com>, davem@davemloft.net,
 netdev@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>
Date: Fri,  4 May 2018 16:28:20 +0200
Message-Id: <20180504142822.15233-3-dh.herrmann@gmail.com>
In-Reply-To: <20180504142822.15233-1-dh.herrmann@gmail.com>
References: <20180504142822.15233-1-dh.herrmann@gmail.com>
Subject: [PATCH v2 2/4] net: hook socketpair() into LSM
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use the newly created LSM-hook for socketpair(). The default hook
return-value is 0, so behavior stays the same unless LSMs start using
this hook.

Acked-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Tom Gundersen <teg@jklm.no>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
---
 net/socket.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index f10f1d947c78..667a7b397134 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1420,6 +1420,13 @@ int __sys_socketpair(int family, int type, int protocol, int __user *usockvec)
 		goto out;
 	}
 
+	err = security_socket_socketpair(sock1, sock2);
+	if (unlikely(err)) {
+		sock_release(sock2);
+		sock_release(sock1);
+		goto out;
+	}
+
 	err = sock1->ops->socketpair(sock1, sock2);
 	if (unlikely(err < 0)) {
 		sock_release(sock2);
-- 
2.17.0
