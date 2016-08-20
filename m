Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7KGILEa012208
 for <selinux@tycho.nsa.gov>; Sat, 20 Aug 2016 12:18:23 -0400
Message-ID: <1471709886.22998.1.camel@trentalancia.net>
Subject: [PATCH] Differentiate between Unix Stream Socket and Sequential
 Packet Socket
From: Guido Trentalancia <guido@trentalancia.net>
To: selinux@tycho.nsa.gov
Date: Sat, 20 Aug 2016 18:18:06 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Modify the SELinux kernel code so that it is able to differentiate between
a unix_stream_socket and a sequential_packet_socket.

A companion patch has been created for the Reference Policy and it will be
posted to its mailing list.

Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
---
 security/selinux/hooks.c            |    3 ++-
 security/selinux/include/classmap.h |    2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

--- linux-4.7.1-orig/security/selinux/include/classmap.h	2016-08-18 17:39:50.639133429 +0200
+++ linux-4.7.1/security/selinux/include/classmap.h	2016-08-18 17:52:25.921420278 +0200
@@ -86,6 +86,8 @@ struct security_class_mapping secclass_m
 	  { "ingress", "egress", NULL } },
 	{ "netlink_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "sequential_packet_socket",
+	  { COMMON_SOCK_PERMS, "connectto", NULL } },
 	{ "packet_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "key_socket",
--- linux-4.7.1-orig/security/selinux/hooks.c	2016-08-18 21:47:32.204199470 +0200
+++ linux-4.7.1/security/selinux/hooks.c	2016-08-18 22:52:53.099296513 +0200
@@ -1246,8 +1246,9 @@ static inline u16 socket_type_to_securit
 	switch (family) {
 	case PF_UNIX:
 		switch (type) {
-		case SOCK_STREAM:
 		case SOCK_SEQPACKET:
+			return SECCLASS_SEQUENTIAL_PACKET_SOCKET;
+		case SOCK_STREAM:
 			return SECCLASS_UNIX_STREAM_SOCKET;
 		case SOCK_DGRAM:
 			return SECCLASS_UNIX_DGRAM_SOCKET;
