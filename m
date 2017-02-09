Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v19HB3UY001615
 for <selinux@tycho.nsa.gov>; Thu, 9 Feb 2017 12:11:03 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D734CB59A2
 for <selinux@tycho.nsa.gov>; Thu,  9 Feb 2017 17:11:01 +0000 (UTC)
Subject: [PATCH] selinux-testsuite: allow netlink test domains to load
 kernel modules
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 09 Feb 2017 12:10:59 -0500
Message-ID: <148666025965.8273.14181813922260343065.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Depending on the system state, the netlink tests added in
2dbd45fd3a61 ("selinux-testsuite: add tests for new netlink socket
classes") may need to load additional kernel modules to operate
properly.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 policy/test_netlink_socket.te |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/policy/test_netlink_socket.te b/policy/test_netlink_socket.te
index b56c06c..c852c04 100644
--- a/policy/test_netlink_socket.te
+++ b/policy/test_netlink_socket.te
@@ -48,3 +48,6 @@ netlink_socket_test(netlink_crypto_socket)
 # Entry into the test domains via the test program.
 miscfiles_domain_entry_test_files(netlinksocktestdomain)
 userdom_sysadm_entry_spec_domtrans_to(netlinksocktestdomain)
+
+# Trigger kernel module auto-loading of the protocol implementations.
+kernel_request_load_module(netlinksocktestdomain)
