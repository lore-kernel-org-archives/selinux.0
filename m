From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, guido@trentalancia.net,
 richard_c_haines@btinternet.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: handle ICMPv6 consistently with ICMP
Date: Thu,  8 Dec 2016 16:43:56 -0500
Message-Id: <1481233436-18410-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

commit 79c8b348f215 ("selinux: support distinctions among all network
address families") mapped datagram ICMP sockets to the new icmp_socket
security class, but left ICMPv6 sockets unchanged.  This change fixes
that oversight to handle both kinds of sockets consistently.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8a90a0b..b508a5a 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1295,7 +1295,8 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 		case SOCK_DGRAM:
 			if (default_protocol_dgram(protocol))
 				return SECCLASS_UDP_SOCKET;
-			else if (extsockclass && protocol == IPPROTO_ICMP)
+			else if (extsockclass && (protocol == IPPROTO_ICMP ||
+						  protocol == IPPROTO_ICMPV6))
 				return SECCLASS_ICMP_SOCKET;
 			else
 				return SECCLASS_RAWIP_SOCKET;
-- 
2.7.4
