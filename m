Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5BEGAfR022878
 for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2018 10:16:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC42D80401D3
 for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2018 14:10:39 +0000 (UTC)
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 11 Jun 2018 10:10:39 -0400
Message-ID: <152872623920.12446.17278104134217743733.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] selinux-testsuite: fix the inet_socket tests on
 older policy releases
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Ensure that we apply MCS constraints to the test_inet_server_t domain,
this was causing test failures on RHEL-6.x based systems.

Thanks to Stephen Smalley and Lukas Vrabec for some off-list discussion
related to this problem and its solution.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 policy/test_inet_socket.te |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index c25900b..428d28e 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -33,6 +33,16 @@ corenet_udp_bind_all_nodes(test_inet_server_t)
 corenet_inout_generic_if(test_inet_server_t)
 corenet_inout_generic_node(test_inet_server_t)
 
+# We need to ensure that the test domain is MCS constrained.
+## newer systems, e.g. Fedora and RHEL >= 7.x
+ifdef(`mcs_constrained', `
+	mcs_constrained(test_inet_server_t)
+')
+## older systems, e.g. RHEL == 6.x
+ifdef(`mcs_untrusted_proc', `
+	mcs_untrusted_proc(test_inet_server_t)
+')
+
 # Domain for client process.
 type test_inet_client_t;
 domain_type(test_inet_client_t)
