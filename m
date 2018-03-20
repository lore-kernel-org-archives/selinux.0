Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2KHox4A015598
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 13:50:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 405L7k5tN3zrMHc
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 17:50:42 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 405L7k2pk5zrMHR
 for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2018 17:50:42 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Date: Tue, 20 Mar 2018 17:49:30 +0000
Message-Id: <20180320174930.3207-1-richard_c_haines@btinternet.com>
Subject: [PATCH] setools: Add sctp portcon support
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Allow setools to interpret SCTP portcon policy statements

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libqpol/policy_define.c         | 2 ++
 setools/policyrep/netcontext.py | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/libqpol/policy_define.c b/libqpol/policy_define.c
index dcc69fc..bffe451 100644
--- a/libqpol/policy_define.c
+++ b/libqpol/policy_define.c
@@ -4933,6 +4933,8 @@ int define_port_context(unsigned int low, unsigned int high)
 		protocol = IPPROTO_UDP;
 	} else if ((strcmp(id, "dccp") == 0) || (strcmp(id, "DCCP") == 0)) {
 		protocol = IPPROTO_DCCP;
+	} else if ((strcmp(id, "sctp") == 0) || (strcmp(id, "SCTP") == 0)) {
+		protocol = IPPROTO_SCTP;
 	} else {
 		yyerror2("unrecognized protocol %s", id);
 		goto bad;
diff --git a/setools/policyrep/netcontext.py b/setools/policyrep/netcontext.py
index c7076d2..1793677 100644
--- a/setools/policyrep/netcontext.py
+++ b/setools/policyrep/netcontext.py
@@ -17,7 +17,7 @@
 # License along with SETools.  If not, see
 # <http://www.gnu.org/licenses/>.
 #
-from socket import AF_INET, AF_INET6, IPPROTO_TCP, IPPROTO_UDP, getprotobyname
+from socket import AF_INET, AF_INET6, IPPROTO_TCP, IPPROTO_UDP, IPPROTO_SCTP, getprotobyname
 from collections import namedtuple
 from ipaddress import ip_address, ip_network
 
@@ -196,6 +196,7 @@ class PortconProtocol(int, PolicyEnum):
     tcp = IPPROTO_TCP
     udp = IPPROTO_UDP
     dccp = IPPROTO_DCCP
+    sctp = IPPROTO_SCTP
 
 
 class Portcon(NetContext):
-- 
2.14.3
