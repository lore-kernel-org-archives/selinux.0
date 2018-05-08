From: Alexey Kodanev <alexey.kodanev@oracle.com>
To: selinux@tycho.nsa.gov
Cc: Richard Haines <richard_c_haines@btinternet.com>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 linux-security-module@vger.kernel.org, netdev <netdev@vger.kernel.org>,
 Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  8 May 2018 17:05:03 +0300
Message-Id: <1525788303-23244-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [PATCH] selinux: add AF_UNSPEC and INADDR_ANY checks to
 selinux_socket_bind()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit d452930fd3b9 ("selinux: Add SCTP support") breaks compatibility
with the old programs that can pass sockaddr_in with AF_UNSPEC and
INADDR_ANY to bind(). As a result, bind() returns EAFNOSUPPORT error.
It was found with LTP/asapi_01 test.

Similar to commit 29c486df6a20 ("net: ipv4: relax AF_INET check in
bind()"), which relaxed AF_INET check for compatibility, add AF_UNSPEC
case to AF_INET and make sure that the address is INADDR_ANY.

Also, in the end of selinux_socket_bind(), instead of adding AF_UNSPEC
to 'address->sa_family == AF_INET', verify AF_INET6 first.

Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 security/selinux/hooks.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4cafe6a..649a3be 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4602,10 +4602,16 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		 * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
 		 */
 		switch (address->sa_family) {
+		case AF_UNSPEC:
 		case AF_INET:
 			if (addrlen < sizeof(struct sockaddr_in))
 				return -EINVAL;
 			addr4 = (struct sockaddr_in *)address;
+
+			if (address->sa_family == AF_UNSPEC &&
+			    addr4->sin_addr.s_addr != htonl(INADDR_ANY))
+				return -EAFNOSUPPORT;
+
 			snum = ntohs(addr4->sin_port);
 			addrp = (char *)&addr4->sin_addr.s_addr;
 			break;
@@ -4681,10 +4687,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 		ad.u.net->sport = htons(snum);
 		ad.u.net->family = family;
 
-		if (address->sa_family == AF_INET)
-			ad.u.net->v4info.saddr = addr4->sin_addr.s_addr;
-		else
+		if (address->sa_family == AF_INET6)
 			ad.u.net->v6info.saddr = addr6->sin6_addr;
+		else
+			ad.u.net->v4info.saddr = addr4->sin_addr.s_addr;
 
 		err = avc_has_perm(&selinux_state,
 				   sksec->sid, sid,
-- 
1.8.3.1
