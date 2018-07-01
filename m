From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jian-Hong Pan <starnight@g.ncu.edu.tw>, Jiri Pirko <jiri@resnulli.us>,
 Marcel Holtmann <marcel@holtmann.org>,
 "David S . Miller" <davem@davemloft.net>,
 Matthias Brugger <mbrugger@suse.com>, Janus Piwek <jpiwek@arroweurope.com>,
 =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>,
 Dollar Chen <dollar.chen@wtmec.com>, Ken Yu <ken.yu@rakwireless.com>,
 =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov
Date: Sun,  1 Jul 2018 13:07:50 +0200
Message-Id: <20180701110804.32415-2-afaerber@suse.de>
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [RFC net-next 01/15] net: Reserve protocol numbers for LoRa
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

LoRa is a long-range, low-power wireless network technology by Semtech.
It serves as base for LoRaWAN as well as multiple proprietary protocols.

AF_LORA
PF_LORA
ARPHRD_LORA
ETH_P_LORA

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 include/linux/socket.h              | 4 +++-
 include/uapi/linux/if_arp.h         | 1 +
 include/uapi/linux/if_ether.h       | 1 +
 security/selinux/hooks.c            | 4 +++-
 security/selinux/include/classmap.h | 4 +++-
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index 7ed4713d5337..aa1e288b1659 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -208,8 +208,9 @@ struct ucred {
 				 * reuses AF_INET address family
 				 */
 #define AF_XDP		44	/* XDP sockets			*/
+#define AF_LORA		45	/* LoRa sockets			*/
 
-#define AF_MAX		45	/* For now.. */
+#define AF_MAX		46	/* For now.. */
 
 /* Protocol families, same as address families. */
 #define PF_UNSPEC	AF_UNSPEC
@@ -259,6 +260,7 @@ struct ucred {
 #define PF_QIPCRTR	AF_QIPCRTR
 #define PF_SMC		AF_SMC
 #define PF_XDP		AF_XDP
+#define PF_LORA		AF_LORA
 #define PF_MAX		AF_MAX
 
 /* Maximum queue length specifiable by listen.  */
diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index 4605527ca41b..1ed7cb3f2129 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -98,6 +98,7 @@
 #define ARPHRD_NETLINK	824		/* Netlink header		*/
 #define ARPHRD_6LOWPAN	825		/* IPv6 over LoWPAN             */
 #define ARPHRD_VSOCKMON	826		/* Vsock monitor header		*/
+#define ARPHRD_LORA	827		/* LoRa				*/
 
 #define ARPHRD_VOID	  0xFFFF	/* Void type, nothing is known */
 #define ARPHRD_NONE	  0xFFFE	/* zero header length */
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 3a45b4ad71a3..45644dcf5b39 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -147,6 +147,7 @@
 #define ETH_P_MAP	0x00F9		/* Qualcomm multiplexing and
 					 * aggregation protocol
 					 */
+#define ETH_P_LORA	0x00FA		/* LoRa				*/
 
 /*
  *	This is an Ethernet frame header.
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 10a5d2ce3870..b62bb0389d70 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1473,7 +1473,9 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 			return SECCLASS_SMC_SOCKET;
 		case PF_XDP:
 			return SECCLASS_XDP_SOCKET;
-#if PF_MAX > 45
+		case PF_LORA:
+			return SECCLASS_LORA_SOCKET;
+#if PF_MAX > 46
 #error New address family defined, please update this function.
 #endif
 		}
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index bd5fe0d3204a..060d4bf8385e 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -242,9 +242,11 @@ struct security_class_mapping secclass_map[] = {
 	  {"map_create", "map_read", "map_write", "prog_load", "prog_run"} },
 	{ "xdp_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
+	{ "lora_socket",
+	  { COMMON_SOCK_PERMS, NULL } },
 	{ NULL }
   };
 
-#if PF_MAX > 45
+#if PF_MAX > 46
 #error New address family defined, please update secclass_map.
 #endif
-- 
2.16.4
