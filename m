Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0SJm46x030538
 for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2014 14:48:04 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s0SJm17S012079
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2014 14:48:01 -0500
Subject: [PATCH] selinux: add SOCK_DIAG_BY_FAMILY to the list of netlink
 message types
To: selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Tue, 28 Jan 2014 14:48:00 -0500
Message-ID: <20140128194800.7886.29754.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The SELinux AF_NETLINK/NETLINK_SOCK_DIAG socket class was missing the
SOCK_DIAG_BY_FAMILY definition which caused SELINUX_ERR messages when
the ss tool was run.

 # ss
 Netid  State  Recv-Q Send-Q  Local Address:Port   Peer Address:Port
 u_str  ESTAB  0      0                  * 14189             * 14190
 u_str  ESTAB  0      0                  * 14145             * 14144
 u_str  ESTAB  0      0                  * 14151             * 14150
 {...}
 # ausearch -m SELINUX_ERR
 ----
 time->Thu Jan 23 11:11:16 2014
 type=SYSCALL msg=audit(1390493476.445:374):
  arch=c000003e syscall=44 success=yes exit=40
  a0=3 a1=7fff03aa11f0 a2=28 a3=0 items=0 ppid=1852 pid=1895
  auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
  tty=pts0 ses=1 comm="ss" exe="/usr/sbin/ss"
  subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
 type=SELINUX_ERR msg=audit(1390493476.445:374):
  SELinux:  unrecognized netlink message type=20 for sclass=32

Signed-off-by: Paul Moore <pmoore@redhat.com>
---
 security/selinux/nlmsgtab.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 332ac8a..2df7b90 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -17,6 +17,7 @@
 #include <linux/inet_diag.h>
 #include <linux/xfrm.h>
 #include <linux/audit.h>
+#include <linux/sock_diag.h>
 
 #include "flask.h"
 #include "av_permissions.h"
@@ -78,6 +79,7 @@ static struct nlmsg_perm nlmsg_tcpdiag_perms[] =
 {
 	{ TCPDIAG_GETSOCK,	NETLINK_TCPDIAG_SOCKET__NLMSG_READ },
 	{ DCCPDIAG_GETSOCK,	NETLINK_TCPDIAG_SOCKET__NLMSG_READ },
+	{ SOCK_DIAG_BY_FAMILY,	NETLINK_TCPDIAG_SOCKET__NLMSG_READ },
 };
 
 static struct nlmsg_perm nlmsg_xfrm_perms[] =
