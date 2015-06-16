From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [RFC][PATCH] net/tipc: initialize security state for new connection
 socket
Date: Tue, 16 Jun 2015 15:15:50 -0400
Message-Id: <1434482150-25603-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Calling connect() with an AF_TIPC socket would trigger a series
of error messages from SELinux along the lines of:
SELinux: Invalid class 0
type=AVC msg=audit(1434126658.487:34500): avc:  denied  { <unprintable> }
  for pid=292 comm="kworker/u16:5" scontext=system_u:system_r:kernel_t:s0
  tcontext=system_u:object_r:unlabeled_t:s0 tclass=<unprintable>
  permissive=0

This was due to a failure to initialize the security state of the new
connection sock by the tipc code, leaving it with junk in the security
class field and an unlabeled secid.  Add a call to security_sk_clone()
to inherit the security state from the parent socket.

Reported-by: Tim Shearer <tim.shearer@overturenetworks.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---

This is an RFC before sending this to netdev and the tipc maintainers.
Under separate cover, I also submitted two patches for selinux that
should avoid having a sclass of 0 for any sockets (so we will at least
get printable output and can even work around such denials by allowing
access to unlabeled_t:socket) and that will BUG_ON if we ever encounter
a 0 class value again, but this change is still needed to properly label
the new connection sock with something other than unlabeled.   I am
not entirely comfortable with the fact that we might need to sprinkle
these security_sk_clone() calls throughout the various network
protocol implementations; I think this is a consequence of switching
from using the socket inode security structure to using the sock security
structure in the generic socket layer hooks; we could ensure that the
socket inode security structure was initialized in selinux_socket_accept()
but cannot do the same for the sock, which is allocated by the network
protocol implementation, without hooking the network protocol implementations.
I see no better option, but am open to suggestions.

 net/tipc/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 46b6ed5..77cfe3a 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2008,6 +2008,8 @@ static int tipc_accept(struct socket *sock, struct socket *new_sock, int flags)
 	if (res)
 		goto exit;
 
+	security_sk_clone(sock->sk, new_sock->sk);
+
 	new_sk = new_sock->sk;
 	new_tsock = tipc_sk(new_sk);
 	msg = buf_msg(buf);
-- 
2.1.0
