From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite: add labeled ipsec tests
Date: Thu, 25 Jun 2015 11:03:24 -0400
Message-Id: <1435244604-554-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add tests for labeled IPSEC.  These are identical to the tests
for NetLabel, i.e. they exercise labeled networking over loopback,
including testing of SO_PEERSEC, SCM_SECURITY, and peer recv permission.

One issue with these tests is that even after flushing the ipsec
SAD and SPD entries, the kernel continues to perform the peer checks
which can cause denials for e.g. NFS once the test policy is unloaded.
This suggests some problem with the selinux xfrm ref counting or perhaps
delayed freeing of the entries.  To compensate, we allow peer permissions
for the existing connect tests so that they do not fail if we run the
testsuite a second time without an intervening reboot.

Another issue is that unlike the NetLabel case, we do not get an ICMP
error back upon the peer recv denial so the client has to wait for
a connection timeout, although it does ultimately fail and therefore
the test does pass.  To avoid hanging for a while on this test, we
explicitly set the timeout value for the connect() call.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 README                            |  7 +++---
 policy/test_inet_socket.te        | 29 ++++++++++++++++++++++
 tests/inet_socket/client.c        | 10 ++++++++
 tests/inet_socket/ipsec-flush     |  5 ++++
 tests/inet_socket/ipsec-load      |  4 +++
 tests/inet_socket/ipsec_manual_SA | 51 +++++++++++++++++++++++++++++++++++++++
 tests/inet_socket/test            | 44 ++++++++++++++++++++++++++++++++-
 7 files changed, 146 insertions(+), 4 deletions(-)
 create mode 100755 tests/inet_socket/ipsec-flush
 create mode 100755 tests/inet_socket/ipsec-load
 create mode 100644 tests/inet_socket/ipsec_manual_SA

diff --git a/README b/README
index bbca997..6d54fcc 100644
--- a/README
+++ b/README
@@ -18,6 +18,7 @@ CONFIG_NET=y
 CONFIG_INET=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
+CONFIG_SECURITY_NETWORK_XFRM=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_NETLABEL=y
 
@@ -33,7 +34,6 @@ CONFIG_JFFS2_FS_SECURITY=y
 
 The following config options are not required by the tests but
 are typical settings for SELinux kernel configuration:
-CONFIG_SECURITY_NETWORK_XFRM=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1
 CONFIG_SECURITY_SELINUX_DISABLE=y
@@ -70,8 +70,9 @@ rely upon the SELinux extensions being integrated into the coreutils
 package, with support for the chcon and runcon commands as well as the
 SELinux options to existing utilities such as ls and mkdir.
 
-The inet_socket test depends on netlabel_tools being installed in
-order to load NetLabel configuration.
+The inet_socket tests depend on netlabel_tools being installed in
+order to load NetLabel configuration, and on ipsec-tools being installed
+in order to load labeled IPSEC configuration.
 
 In addition to the libselinux shared library, the libselinux headers
 are required in order to build certain testcases.  These can be found in 
diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index f652925..25b4f34 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -55,6 +55,10 @@ corenet_tcp_connect_generic_port(test_inet_bad_client_t)
 corenet_inout_generic_if(test_inet_bad_client_t)
 corenet_inout_generic_node(test_inet_bad_client_t)
 
+#
+# Policy for testing bind(2) and connect(2) checks.
+#
+
 # Domain for a process allowed to bind(2).
 type test_inet_bind_t;
 domain_type(test_inet_bind_t)
@@ -101,6 +105,8 @@ allow test_inet_connect_t self:udp_socket create_socket_perms;
 corenet_tcp_connect_generic_port(test_inet_connect_t)
 corenet_tcp_bind_generic_port(test_inet_connect_t)
 corenet_tcp_bind_all_nodes(test_inet_connect_t)
+corenet_inout_generic_if(test_inet_connect_t)
+corenet_inout_generic_node(test_inet_connect_t)
 
 # Domain for a process not allowed name_connect permission.
 type test_inet_no_name_connect_t;
@@ -112,6 +118,29 @@ allow test_inet_no_name_connect_t self:tcp_socket create_stream_socket_perms;
 allow test_inet_no_name_connect_t self:udp_socket create_socket_perms;
 corenet_tcp_bind_generic_port(test_inet_no_name_connect_t)
 corenet_tcp_bind_all_nodes(test_inet_no_name_connect_t)
+corenet_inout_generic_if(test_inet_no_name_connect_t)
+corenet_inout_generic_node(test_inet_no_name_connect_t)
+
+#
+# Labeled IPSEC-specific policy.
+#
+
+# For ipsec-load/ipsec-flush.
+gen_require(`
+	type unconfined_t;
+')
+type test_spd_t;
+allow unconfined_t inetsocketdomain:association setcontext;
+allow unconfined_t test_spd_t:association setcontext;
+
+# Each of the test client domains must match against the SPD entry
+# in order to use labeled IPSEC.
+allow test_inet_client_t test_spd_t:association polmatch;
+allow test_inet_bad_client_t test_spd_t:association polmatch;
+
+#
+# Common rules for all inet socket test domains.
+#
 
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(inetsocketdomain)
diff --git a/tests/inet_socket/client.c b/tests/inet_socket/client.c
index 3e3d150..bb721c5 100644
--- a/tests/inet_socket/client.c
+++ b/tests/inet_socket/client.c
@@ -1,4 +1,5 @@
 #include <sys/types.h>
+#include <sys/time.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
@@ -32,6 +33,7 @@ main(int argc, char **argv)
 	int type;
 	char *mycon;
 	unsigned short port;
+	struct timeval tm;
 
 	if (argc != 3)
 		usage(argv[0]);
@@ -53,6 +55,14 @@ main(int argc, char **argv)
 		exit(1);
 	}
 
+	tm.tv_sec = 5;
+	tm.tv_usec = 0;
+	result = setsockopt(sock, SOL_SOCKET, SO_SNDTIMEO, &tm, sizeof tm);
+	if (result < 0) {
+		perror("setsockopt: SO_SNDTIMEO");
+		exit(1);
+	}
+
 	bzero(&sin, sizeof(struct sockaddr_in));
 	sin.sin_family = AF_INET;
 	sin.sin_port = htons(port);
diff --git a/tests/inet_socket/ipsec-flush b/tests/inet_socket/ipsec-flush
new file mode 100755
index 0000000..31467c6
--- /dev/null
+++ b/tests/inet_socket/ipsec-flush
@@ -0,0 +1,5 @@
+#!/bin/sh
+echo 1 > /proc/sys/net/ipv4/conf/lo/disable_xfrm
+echo 1 > /proc/sys/net/ipv4/conf/lo/disable_policy
+setkey -FP
+setkey -F
diff --git a/tests/inet_socket/ipsec-load b/tests/inet_socket/ipsec-load
new file mode 100755
index 0000000..deb8cbd
--- /dev/null
+++ b/tests/inet_socket/ipsec-load
@@ -0,0 +1,4 @@
+#!/bin/sh
+echo 0 > /proc/sys/net/ipv4/conf/lo/disable_xfrm
+echo 0 > /proc/sys/net/ipv4/conf/lo/disable_policy
+setkey -f $1
diff --git a/tests/inet_socket/ipsec_manual_SA b/tests/inet_socket/ipsec_manual_SA
new file mode 100644
index 0000000..81b7d23
--- /dev/null
+++ b/tests/inet_socket/ipsec_manual_SA
@@ -0,0 +1,51 @@
+# setkey -f configuration file entries for MANUAL SA configuration
+#
+# Based on the file:
+#     notebook-source/basic-selinux-policy/CIL/message-filter/ipsec_manual_SA
+# taken from The SELinux Notebook 4th Edition source code tarball,
+# by Richard Haines.
+#
+# Modifications:
+# - Replaced security contexts with the ones used by the tests.
+# - Dropped the ESP entries; just use AH for testing purposes.
+# - Only define a single spd context and entry (no need for separate ones
+#   unless you truly want a different policy).
+# - Define a spd entry for udp traffic for testing SCM_SECURITY.
+
+#
+# Flush the SAD and SPD
+flush;
+spdflush;
+
+#
+########## Security Association Database entries #################
+#
+# Important notes:
+# 1) The security context (-ctx) entries MUST match
+#    the actual running context of the process or it will fail to
+#    match (therefore racoon is the best configuration option as
+#    these are automatically exchanged).
+# 2) If the manual configuration is used in a live environment,
+#    then DO NOT use these encryption keys, generate your own.
+#
+# Authentication Header info
+# AH SAs using 128 bit long keys
+add 127.0.0.1 127.0.0.1 ah 0x200
+-ctx 1 1 "unconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023"
+-A hmac-md5 0xc0291ff014dccdd03874d9e8e4cdf3e6;
+
+add 127.0.0.1 127.0.0.1 ah 0x250
+-ctx 1 1 "unconfined_u:unconfined_r:test_inet_bad_client_t:s0-s0:c0.c1023"
+-A hmac-md5 0xc0291ff014dccdd03874d9e8e4cdf3e6;
+
+#
+########### Security Policy Database entries ##########################
+#
+
+spdadd 127.0.0.1 127.0.0.1 tcp
+-ctx 1 1 "system_u:object_r:test_spd_t:s0"
+-P out ipsec ah/transport//require;
+
+spdadd 127.0.0.1 127.0.0.1 udp
+-ctx 1 1 "system_u:object_r:test_spd_t:s0"
+-P out ipsec ah/transport//require;
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 8d1f3c8..f5f71a1 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -1,7 +1,7 @@
 #!/usr/bin/perl
 
 use Test;
-BEGIN { plan tests => 12}
+BEGIN { plan tests => 16}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
@@ -79,4 +79,46 @@ ok($result, 0);
 $result = system "runcon -t test_inet_no_name_connect_t -- $basedir/connect 65535 2>&1";
 ok($result);
 
+# Load IPSEC configuration.
+system "$basedir/ipsec-load $basedir/ipsec_manual_SA";
+
+# Start the stream server.
+if (($pid = fork()) == 0) {
+    exec "runcon -t test_inet_server_t $basedir/server stream 65535";
+}
+
+sleep 1; # Give it a moment to initialize.
+
+# Verify that authorized client can communicate with the server.
+$result = system "runcon -t test_inet_client_t $basedir/client stream 65535";
+ok($result, 0);
+
+# Verify that unauthorized client cannot communicate with the server.
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client stream 65535 2>&1";
+ok($result);
+
+# Kill the server.
+kill TERM, $pid;
+
+# Start the dgram server.
+if (($pid = fork()) == 0) {
+    exec "runcon -t test_inet_server_t $basedir/server dgram 65535";
+}
+
+sleep 1; # Give it a moment to initialize
+
+# Verify that authorized client can communicate with the server.
+$result = system "runcon -t test_inet_client_t $basedir/client dgram 65535";
+ok($result, 0);
+
+# Verify that unauthorized client cannot communicate with the server.
+$result = system "runcon -t test_inet_bad_client_t -- $basedir/client dgram 65535 2>&1";
+ok($result);
+
+# Kill the server.
+kill TERM, $pid;
+
+# Flush IPSEC configuration.
+system "$basedir/ipsec-flush";
+
 exit;
-- 
2.1.0
