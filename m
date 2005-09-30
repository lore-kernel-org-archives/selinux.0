Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8UNldNs003958
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 19:47:39 -0400 (EDT)
Received: from mail22.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8UNfdbY003273
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 23:41:39 GMT
Received: from megaweapon.nightmoose.net (HELO excalibur.intercode) ([66.92.66.197])
          (envelope-sender <jmorris@namei.org>)
          by mail22.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <selinux@tycho.nsa.gov>; 30 Sep 2005 23:41:49 -0000
Date: Fri, 30 Sep 2005 19:41:48 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] SELinux - fix SCTP socket bug and general IP protocol handling
 (fwd)
Message-ID: <Pine.LNX.4.63.0509301941040.4468@excalibur.intercode>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

FYI, this patch is now in Linus' tree.

---------- Forwarded message ----------
Date: Fri, 30 Sep 2005 14:24:34 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Linus Torvalds <torvalds@osdl.org>, David S. Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] SELinux - fix SCTP socket bug and general IP protocol handling

The following patch updates the way SELinux classifies and handles IP 
based protocols.

Currently, IP sockets are classified by SELinux as being either TCP, UDP 
or 'Raw', the latter being a default for IP socket that is not TCP or UDP.

The classification code is out of date and uses only the socket type 
parameter to socket(2) to determine the class of IP socket.  So, any 
socket created with SOCK_STREAM will be classified by SELinux as TCP, and 
SOCK_DGRAM as UDP.  Also, other socket types such as SOCK_SEQPACKET and 
SOCK_DCCP are currently ignored by SELinux, which classifies them as 
generic sockets, which means they don't even get basic IP level checking.

This patch changes the SELinux IP socket classification logic, so that 
only an IPPROTO_IP protocol value passed to socket(2) classify the socket 
as TCP or UDP.  The patch also drops the check for SOCK_RAW and converts 
it into a default, so that socket types like SOCK_DCCP and SOCK_SEQPACKET 
are classified as SECCLASS_RAWIP_SOCKET (instead of generic sockets).

Note that protocol-specific support for SCTP, DCCP etc. is not addressed 
here, we're just getting these protocols checked at the IP layer.  

This fixes a reported problem where SCTP sockets were being recognized as 
generic SELinux sockets yet still being passed in one case to an IP level 
check, which then fails for generic sockets.

It will also fix bugs where any SOCK_STREAM socket is classified as TCP or 
any SOCK_DGRAM socket is classified as UDP.

This patch also unifies the way IP sockets classes are determined in
selinux_socket_bind(), so we use the already calculated value instead of
trying to recalculate it.

Please apply.

Signed-off-by: James Morris <jmorris@namei.org>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

---

 security/selinux/hooks.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff -X dontdiff -purN linux-2.6.14-rc2.s1/security/selinux/hooks.c linux-2.6.14-rc2.t/security/selinux/hooks.c
--- linux-2.6.14-rc2.s1/security/selinux/hooks.c	2005-09-24 10:08:25.000000000 -0400
+++ linux-2.6.14-rc2.t/security/selinux/hooks.c	2005-09-30 02:24:44.000000000 -0400
@@ -630,6 +630,16 @@ static inline u16 inode_mode_to_security
 	return SECCLASS_FILE;
 }
 
+static inline int default_protocol_stream(int protocol)
+{
+	return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP);
+}
+
+static inline int default_protocol_dgram(int protocol)
+{
+	return (protocol == IPPROTO_IP || protocol == IPPROTO_UDP);
+}
+
 static inline u16 socket_type_to_security_class(int family, int type, int protocol)
 {
 	switch (family) {
@@ -646,10 +656,16 @@ static inline u16 socket_type_to_securit
 	case PF_INET6:
 		switch (type) {
 		case SOCK_STREAM:
-			return SECCLASS_TCP_SOCKET;
+			if (default_protocol_stream(protocol))
+				return SECCLASS_TCP_SOCKET;
+			else
+				return SECCLASS_RAWIP_SOCKET;
 		case SOCK_DGRAM:
-			return SECCLASS_UDP_SOCKET;
-		case SOCK_RAW:
+			if (default_protocol_dgram(protocol))
+				return SECCLASS_UDP_SOCKET;
+			else
+				return SECCLASS_RAWIP_SOCKET;
+		default:
 			return SECCLASS_RAWIP_SOCKET;
 		}
 		break;
@@ -2970,6 +2986,8 @@ static int selinux_socket_bind(struct so
 
 	/*
 	 * If PF_INET or PF_INET6, check name_bind permission for the port.
+	 * Multiple address binding for SCTP is not supported yet: we just
+	 * check the first address now.
 	 */
 	family = sock->sk->sk_family;
 	if (family == PF_INET || family == PF_INET6) {
@@ -3014,12 +3032,12 @@ static int selinux_socket_bind(struct so
 				goto out;
 		}
 		
-		switch(sk->sk_protocol) {
-		case IPPROTO_TCP:
+		switch(isec->sclass) {
+		case SECCLASS_TCP_SOCKET:
 			node_perm = TCP_SOCKET__NODE_BIND;
 			break;
 			
-		case IPPROTO_UDP:
+		case SECCLASS_UDP_SOCKET:
 			node_perm = UDP_SOCKET__NODE_BIND;
 			break;
 			



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
