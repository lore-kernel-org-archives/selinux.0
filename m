Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6DB97ZW007965
 for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2017 07:09:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 02EDE2EF191
 for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2017 11:08:58 +0000 (UTC)
From: Milos Malik <mmalik@redhat.com>
To: selinux@tycho.nsa.gov
Date: Thu, 13 Jul 2017 13:08:52 +0200
Message-Id: <1499944132-6721-1-git-send-email-mmalik@redhat.com>
Subject: [PATCH] Additional tests for long-time supported netlink
 classes
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This patch contains tests for classes which are already supported for a
long time but are not tested by the selinux-testsuite yet. These tests
involve classes like: netlink_route_socket, netlink_xfrm_socket,
netlink_selinux_socket, netlink_audit_socket,
netlink_kobject_uevent_socket, netlink_connector_socket,
netlink_scsitransport_socket, netlink_fib_lookup_socket.

Signed-off-by: Milos Malik <mmalik@redhat.com>
---
 policy/test_netlink_socket.te |  8 ++++
 tests/netlink_socket/test     | 99 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/policy/test_netlink_socket.te b/policy/test_netlink_socket.te
index c852c04..aaa6e4d 100644
--- a/policy/test_netlink_socket.te
+++ b/policy/test_netlink_socket.te
@@ -40,6 +40,14 @@ netlink_socket_test(netlink_iscsi_socket)
 netlink_socket_test(netlink_netfilter_socket)
 netlink_socket_test(netlink_generic_socket)
 netlink_socket_test(netlink_crypto_socket)
+netlink_socket_test(netlink_route_socket)
+netlink_socket_test(netlink_xfrm_socket)
+netlink_socket_test(netlink_selinux_socket)
+netlink_socket_test(netlink_audit_socket)
+netlink_socket_test(netlink_kobject_uevent_socket)
+netlink_socket_test(netlink_connector_socket)
+netlink_socket_test(netlink_scsitransport_socket)
+netlink_socket_test(netlink_fib_lookup_socket)
 
 #
 # Common rules for all netlink socket class test domains.
diff --git a/tests/netlink_socket/test b/tests/netlink_socket/test
index 487edbc..cc8c2d4 100755
--- a/tests/netlink_socket/test
+++ b/tests/netlink_socket/test
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 8 }
+BEGIN { plan tests => 24 }
 
 $basedir = $0;
 $basedir =~ s|(.*)/[^/]*|$1|;
@@ -53,3 +53,100 @@ $result = system(
 "runcon -t test_no_netlink_crypto_socket_t -- $basedir/netlinkcreate crypto 2>&1"
 );
 ok($result);
+
+# Verify that test_netlink_route_socket_t can create a NETLINK_ROUTE socket.
+$result = system(
+"runcon -t test_netlink_route_socket_t -- $basedir/netlinkcreate route 2>&1"
+);
+ok( $result, 0 );
+
+# Verify that test_no_netlink_route_socket_t cannot create a NETLINK_ROUTE socket.
+$result = system(
+"runcon -t test_no_netlink_route_socket_t -- $basedir/netlinkcreate route 2>&1"
+);
+ok($result);
+
+# Verify that test_netlink_xfrm_socket_t can create a NETLINK_XFRM socket.
+$result = system(
+"runcon -t test_netlink_xfrm_socket_t -- $basedir/netlinkcreate xfrm 2>&1"
+);
+ok( $result, 0 );
+
+# Verify that test_no_netlink_xfrm_socket_t cannot create a NETLINK_XFRM socket.
+$result = system(
+"runcon -t test_no_netlink_xfrm_socket_t -- $basedir/netlinkcreate xfrm 2>&1"
+);
+ok($result);
+
+# Verify that test_netlink_selinux_socket_t can create a NETLINK_SELINUX socket.
+$result = system(
+"runcon -t test_netlink_selinux_socket_t -- $basedir/netlinkcreate selinux 2>&1"
+);
+ok( $result, 0 );
+
+# Verify that test_no_netlink_selinux_socket_t cannot create a NETLINK_SELINUX socket.
+$result = system(
+"runcon -t test_no_netlink_selinux_socket_t -- $basedir/netlinkcreate selinux 2>&1"
+);
+ok($result);
+
+# Verify that test_netlink_audit_socket_t can create a NETLINK_AUDIT socket.
+$result = system(
+"runcon -t test_netlink_audit_socket_t -- $basedir/netlinkcreate audit 2>&1"
+);
+ok( $result, 0 );
+
+# Verify that test_no_netlink_audit_socket_t cannot create a NETLINK_AUDIT socket.
+$result = system(
+"runcon -t test_no_netlink_audit_socket_t -- $basedir/netlinkcreate audit 2>&1"
+);
+ok($result);
+
+# Verify that test_netlink_kobject_uevent_socket_t can create a NETLINK_KOBJECT_UEVENT socket.
+$result = system(
+"runcon -t test_netlink_kobject_uevent_socket_t -- $basedir/netlinkcreate kobject_uevent 2>&1"
+);
+ok( $result, 0 );
+
+# Verify that test_no_netlink_kobject_uevent_socket_t cannot create a NETLINK_KOBJECT_UEVENT socket.
+$result = system(
+"runcon -t test_no_netlink_kobject_uevent_socket_t -- $basedir/netlinkcreate kobject_uevent 2>&1"
+);
+ok($result);
+
+# Verify that test_netlink_connector_socket_t can create a NETLINK_CONNECTOR socket.
+$result = system(
+"runcon -t test_netlink_connector_socket_t -- $basedir/netlinkcreate connector 2>&1"
+);
+ok( $result, 0 );
+
+# Verify that test_no_netlink_connector_socket_t cannot create a NETLINK_CONNECTOR socket.
+$result = system(
+"runcon -t test_no_netlink_connector_socket_t -- $basedir/netlinkcreate connector 2>&1"
+);
+ok($result);
+
+# Verify that test_netlink_scsitransport_socket_t can create a NETLINK_SCSITRANSPORT socket.
+$result = system(
+"runcon -t test_netlink_scsitransport_socket_t -- $basedir/netlinkcreate scsitransport 2>&1"
+);
+ok( $result, 0 );
+
+# Verify that test_no_netlink_scsitransport_socket_t cannot create a NETLINK_SCSITRANSPORT socket.
+$result = system(
+"runcon -t test_no_netlink_scsitransport_socket_t -- $basedir/netlinkcreate scsitransport 2>&1"
+);
+ok($result);
+
+# Verify that test_netlink_fib_lookup_socket_t can create a NETLINK_FIB_LOOKUP socket.
+$result = system(
+"runcon -t test_netlink_fib_lookup_socket_t -- $basedir/netlinkcreate fib_lookup 2>&1"
+);
+ok( $result, 0 );
+
+# Verify that test_no_netlink_fib_lookup_socket_t cannot create a NETLINK_FIB_LOOKUP socket.
+$result = system(
+"runcon -t test_no_netlink_fib_lookup_socket_t -- $basedir/netlinkcreate fib_lookup 2>&1"
+);
+ok($result);
+
-- 
2.4.11
