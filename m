From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite: enable running new tests on RHEL6/7
Date: Tue, 14 Jul 2015 11:13:32 -0400
Message-Id: <1436886812-19468-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

RHEL 6 and 7 do not include ipsec-tools, so rewrite the ipsec
tests to use ip xfrm for loading the test configuration rather than
setkey.

RHEL 6 unlabelednet policy module only includes rules for the domains
in the RHEL 6 policy, not a rule written on the domain attribute, so
we have to explicitly allow unlabeled send/recv for the test
domains in order for the tests to succeed there.

RHEL 6 uses its own SUBDIRS definition to exclude the nnp test, so
add the mmap, unix_socket, and inet_socket tests to its list.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 README                            |  3 ++-
 policy/test_inet_socket.te        |  4 +++
 tests/Makefile                    |  4 +--
 tests/inet_socket/ipsec-flush     |  4 +--
 tests/inet_socket/ipsec-load      |  7 +++++-
 tests/inet_socket/ipsec_manual_SA | 51 ---------------------------------------
 tests/inet_socket/test            |  2 +-
 7 files changed, 17 insertions(+), 58 deletions(-)
 delete mode 100644 tests/inet_socket/ipsec_manual_SA

diff --git a/README b/README
index 7de74c0..44d0788 100644
--- a/README
+++ b/README
@@ -51,9 +51,10 @@ The testsuite has the following userspace dependencies on Fedora
 or RHEL beyond a minimal install:
 perl-Test-Harness # test harness used by the testsuite
 selinux-policy-devel # to build the test policy
+gcc # to build the test programs
 libselinux-devel # to build some of the test programs
+net-tools # for ifconfig, used by capable_net/test
 netlabel_tools # to load NetLabel configuration during inet_socket tests
-ipsec-tools # to load IPSEC configuration during inet_socket tests
 iptables # to load iptables SECMARK rules during inet_socket tests
 
 The testsuite requires a pre-existing base policy configuration of
diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index 9a35c99..9a476b3 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -151,6 +151,10 @@ allow test_inet_client_t test_server_packet_t:packet { send recv };
 # Common rules for all inet socket test domains.
 #
 
+# Send/recv unlabeled packets.
+kernel_sendrecv_unlabeled_packets(inetsocketdomain)
+kernel_recvfrom_unlabeled_peer(inetsocketdomain)
+
 # Allow all of these domains to be entered from the sysadm domain.
 miscfiles_domain_entry_test_files(inetsocketdomain)
 userdom_sysadm_entry_spec_domtrans_to(inetsocketdomain)
diff --git a/tests/Makefile b/tests/Makefile
index 90b1cc1..7a9b39c 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -5,7 +5,7 @@ DISTRO=$(shell ./os_detect)
 
 SUBDIRS_COMMON:=domain_trans entrypoint execshare exectrace execute_no_trans fdreceive inherit link mkdir msg open ptrace readlink relabel rename rxdir sem setattr setnice shm sigkill stat sysctl task_create task_setnice task_setscheduler task_getscheduler task_getsid task_getpgid task_setpgid wait file ioctl capable_file capable_net capable_sys
 
-SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp inet_socket unix_socket mmap
+SUBDIRS:= $(SUBDIRS_COMMON) dyntrans dyntrace bounds nnp mmap unix_socket inet_socket
 
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(SUBDIRS_COMMON)
@@ -16,7 +16,7 @@ ifeq ($(DISTRO),RHEL5)
 endif
 
 ifeq ($(DISTRO),RHEL6)
-    SUBDIRS:=$(SUBDIRS_COMMON) dyntrace dyntrans bounds
+    SUBDIRS:=$(SUBDIRS_COMMON) dyntrace dyntrans bounds mmap unix_socket inet_socket
 endif
 
 .PHONY: all test clean
diff --git a/tests/inet_socket/ipsec-flush b/tests/inet_socket/ipsec-flush
index 31467c6..ed3b5f7 100755
--- a/tests/inet_socket/ipsec-flush
+++ b/tests/inet_socket/ipsec-flush
@@ -1,5 +1,5 @@
 #!/bin/sh
 echo 1 > /proc/sys/net/ipv4/conf/lo/disable_xfrm
 echo 1 > /proc/sys/net/ipv4/conf/lo/disable_policy
-setkey -FP
-setkey -F
+ip xfrm policy flush
+ip xfrm state flush
diff --git a/tests/inet_socket/ipsec-load b/tests/inet_socket/ipsec-load
index deb8cbd..1ce86fd 100755
--- a/tests/inet_socket/ipsec-load
+++ b/tests/inet_socket/ipsec-load
@@ -1,4 +1,9 @@
 #!/bin/sh
 echo 0 > /proc/sys/net/ipv4/conf/lo/disable_xfrm
 echo 0 > /proc/sys/net/ipv4/conf/lo/disable_policy
-setkey -f $1
+ip xfrm policy flush
+ip xfrm state flush
+ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x200 ctx "unconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023" auth md5 0123456789012345
+ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x250 ctx "unconfined_u:unconfined_r:test_inet_bad_client_t:s0-s0:c0.c1023" auth md5 0123456789012345
+ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
+ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
diff --git a/tests/inet_socket/ipsec_manual_SA b/tests/inet_socket/ipsec_manual_SA
deleted file mode 100644
index 81b7d23..0000000
--- a/tests/inet_socket/ipsec_manual_SA
+++ /dev/null
@@ -1,51 +0,0 @@
-# setkey -f configuration file entries for MANUAL SA configuration
-#
-# Based on the file:
-#     notebook-source/basic-selinux-policy/CIL/message-filter/ipsec_manual_SA
-# taken from The SELinux Notebook 4th Edition source code tarball,
-# by Richard Haines.
-#
-# Modifications:
-# - Replaced security contexts with the ones used by the tests.
-# - Dropped the ESP entries; just use AH for testing purposes.
-# - Only define a single spd context and entry (no need for separate ones
-#   unless you truly want a different policy).
-# - Define a spd entry for udp traffic for testing SCM_SECURITY.
-
-#
-# Flush the SAD and SPD
-flush;
-spdflush;
-
-#
-########## Security Association Database entries #################
-#
-# Important notes:
-# 1) The security context (-ctx) entries MUST match
-#    the actual running context of the process or it will fail to
-#    match (therefore racoon is the best configuration option as
-#    these are automatically exchanged).
-# 2) If the manual configuration is used in a live environment,
-#    then DO NOT use these encryption keys, generate your own.
-#
-# Authentication Header info
-# AH SAs using 128 bit long keys
-add 127.0.0.1 127.0.0.1 ah 0x200
--ctx 1 1 "unconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023"
--A hmac-md5 0xc0291ff014dccdd03874d9e8e4cdf3e6;
-
-add 127.0.0.1 127.0.0.1 ah 0x250
--ctx 1 1 "unconfined_u:unconfined_r:test_inet_bad_client_t:s0-s0:c0.c1023"
--A hmac-md5 0xc0291ff014dccdd03874d9e8e4cdf3e6;
-
-#
-########### Security Policy Database entries ##########################
-#
-
-spdadd 127.0.0.1 127.0.0.1 tcp
--ctx 1 1 "system_u:object_r:test_spd_t:s0"
--P out ipsec ah/transport//require;
-
-spdadd 127.0.0.1 127.0.0.1 udp
--ctx 1 1 "system_u:object_r:test_spd_t:s0"
--P out ipsec ah/transport//require;
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 4652a97..4deca74 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -80,7 +80,7 @@ $result = system "runcon -t test_inet_no_name_connect_t -- $basedir/connect 6553
 ok($result);
 
 # Load IPSEC configuration.
-system "$basedir/ipsec-load $basedir/ipsec_manual_SA";
+system "$basedir/ipsec-load";
 
 # Start the stream server.
 if (($pid = fork()) == 0) {
-- 
2.1.0
