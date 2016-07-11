Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6BBxfIQ028963
 for <selinux@tycho.nsa.gov>; Mon, 11 Jul 2016 07:59:45 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D83CA77348
 for <selinux@tycho.nsa.gov>; Mon, 11 Jul 2016 11:59:33 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: Add missing return to sepol_node_query()
Date: Mon, 11 Jul 2016 13:59:27 +0200
Message-Id: <1468238367-31812-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

Due to the missing return in sepol_node_query(), the function always
set *response to NULL whenever a protocol was SEPOL_PROTO_IP6

Fixes:
sudo semanage node -a -M ::1 -p ipv6 -t node_t ::1
sudo semanage node -m -M ::1 -p ipv6 -t node_t ::1
[1]    12968 segmentation fault (core dumped)  semanage node -m -M ::1 -p ipv6 -t node_t ::1

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsepol/src/nodes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/src/nodes.c b/libsepol/src/nodes.c
index 50cf21d..820346d 100644
--- a/libsepol/src/nodes.c
+++ b/libsepol/src/nodes.c
@@ -273,6 +273,7 @@ int sepol_node_query(sepol_handle_t * handle,
 							   c, SEPOL_PROTO_IP6,
 							   response) < 0)
 						goto err;
+					return STATUS_SUCCESS;
 				}
 			}
 			break;
-- 
1.8.3.1
