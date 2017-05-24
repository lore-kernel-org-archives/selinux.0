Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4OEJOKO022590
 for <selinux@tycho.nsa.gov>; Wed, 24 May 2017 10:19:24 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH v1 1/2] selinux-testsuite: Infiniband pkey tests
Date: Wed, 24 May 2017 17:18:42 +0300
Message-Id: <1495635523-84017-2-git-send-email-danielj@mellanox.com>
In-Reply-To: <1495635523-84017-1-git-send-email-danielj@mellanox.com>
References: <1495635523-84017-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

New tests for infiniband pkeys. Most users don't have Infiniband
hardware, and if they do the pkey configuration is not standardized.
There is a configuration file for enabling the test and setting
environment specific test configurations. If the tests are disabled they
will always show as passed.

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>

---
v1:
- Synchronized interface names with refpolicy changes.
- Changed pkey test to not assume the default pkey is labeled, instead
it take a list of indexes with labeled and unlabeled pkeys.  It checks
that the labeled aren't allowed, unlabeled are allowed, and it labels
the unlabeled ones to make sure they aren't allowed when labeled.
---
 README                                   |   9 ++
 policy/Makefile                          |   3 +-
 policy/test_ibpkey.te                    |  25 ++++++
 tests/Makefile                           |   4 +-
 tests/infiniband_pkey/Makefile           |   7 ++
 tests/infiniband_pkey/create_modify_qp.c | 144 +++++++++++++++++++++++++++++++
 tests/infiniband_pkey/ibpkey_test.conf   |  18 ++++
 tests/infiniband_pkey/test               |  84 ++++++++++++++++++
 8 files changed, 291 insertions(+), 3 deletions(-)
 create mode 100644 policy/test_ibpkey.te
 create mode 100644 tests/infiniband_pkey/Makefile
 create mode 100644 tests/infiniband_pkey/create_modify_qp.c
 create mode 100644 tests/infiniband_pkey/ibpkey_test.conf
 create mode 100755 tests/infiniband_pkey/test

diff --git a/README b/README
index deedae5..b64e2de 100644
--- a/README
+++ b/README
@@ -195,3 +195,12 @@ establish a base directory (based on the path of the script
 executable).  This won't always be accurate, but will work for this
 test harness/configuration.
 	$basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
+
+INFINIBAND TESTS
+----------------
+Because running Infiniband tests requires specialized hardware you must
+set up a configuration file for these tests. The tests are disabled by
+default.  See comments in the configuration file for info.
+
+Infiniband PKey test conf file:
+tests/infiniband_pkey/ibpkey_test.conf
diff --git a/policy/Makefile b/policy/Makefile
index 7bc7f95..46c9fb5 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -22,7 +22,8 @@ TARGETS = \
 	test_task_create.te test_task_getpgid.te test_task_getsched.te \
 	test_task_getsid.te test_task_setpgid.te test_task_setsched.te \
 	test_transition.te test_inet_socket.te test_unix_socket.te \
-	test_mmap.te test_overlayfs.te test_mqueue.te test_mac_admin.te
+	test_mmap.te test_overlayfs.te test_mqueue.te test_mac_admin.te \
+	test_ibpkey.te
 
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te
diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
new file mode 100644
index 0000000..b2f5057
--- /dev/null
+++ b/policy/test_ibpkey.te
@@ -0,0 +1,25 @@
+#################################
+#
+# Policy for testing Infiniband Pkey access.
+#
+
+attribute ibpkeydomain;
+
+# Domain for process.
+type test_ibpkey_access_t;
+domain_type(test_ibpkey_access_t)
+unconfined_runs_test(test_ibpkey_access_t)
+typeattribute test_ibpkey_access_t testdomain;
+typeattribute test_ibpkey_access_t ibpkeydomain;
+
+dev_rw_infiniband_dev(test_ibpkey_access_t)
+dev_rw_sysfs(test_ibpkey_access_t)
+
+# Define a pkey type for labeling pkeys during the test.
+type test_ibpkey_t;
+corenet_ib_pkey(test_ibpkey_t)
+corenet_ib_access_unlabeled_pkeys(test_ibpkey_access_t)
+
+# Allow all of these domains to be entered from the sysadm domain.
+miscfiles_domain_entry_test_files(ibpkeydomain)
+userdom_sysadm_entry_spec_domtrans_to(ibpkeydomain)
diff --git a/tests/Makefile b/tests/Makefile
index fb8a0aa..7dfe2a8 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -4,13 +4,13 @@ export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
 
 DISTRO=$(shell ./os_detect)
 
-SUBDIRS:=domain_trans entrypoint execshare exectrace execute_no_trans \
+SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	fdreceive inherit link mkdir msg open ptrace readlink relabel rename \
 	rxdir sem setattr setnice shm sigkill stat sysctl task_create \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp mmap unix_socket inet_socket \
-	overlay checkreqprot mqueue mac_admin
+	overlay checkreqprot mqueue mac_admin infiniband_pkey
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
diff --git a/tests/infiniband_pkey/Makefile b/tests/infiniband_pkey/Makefile
new file mode 100644
index 0000000..60f0d24
--- /dev/null
+++ b/tests/infiniband_pkey/Makefile
@@ -0,0 +1,7 @@
+TARGETS=create_modify_qp
+
+LDLIBS+= -libverbs
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/infiniband_pkey/create_modify_qp.c b/tests/infiniband_pkey/create_modify_qp.c
new file mode 100644
index 0000000..495ef5b
--- /dev/null
+++ b/tests/infiniband_pkey/create_modify_qp.c
@@ -0,0 +1,144 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <assert.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <infiniband/verbs.h>
+
+struct ibv_qp	   *qp;
+struct ibv_context *context;
+struct ibv_pd      *pd;
+struct ibv_cq      *cq;
+struct ibv_srq     *srq;
+
+void cleanup_ib_rsrc()
+{
+	ibv_destroy_qp(qp);
+	ibv_destroy_srq(srq);
+	ibv_destroy_cq(cq);
+	ibv_dealloc_pd(pd);
+	ibv_close_device(context);
+}
+
+int init_ib_rsrc(char* deviceName)
+{
+	int                 ndev = 0;
+	struct ibv_device  **dlist = ibv_get_device_list(&ndev);
+	struct ibv_device  *device = NULL;;
+	struct ibv_srq_init_attr srqiattr;
+	struct ibv_qp_init_attr qpiattr;
+	int i;
+
+	if (!ndev)
+	{
+		fprintf(stderr, "No IB devices found.\n");
+		exit(1);
+	}
+
+	for (i = 0; i < ndev; i++)
+		if(!strcmp(deviceName, dlist[i]->name))
+			device = dlist[i];
+
+	if (!device)
+	{
+		fprintf(stderr, "Couldn't find device %s\n", deviceName);
+		exit(1);
+	}
+	/* Open context */
+	context = ibv_open_device(device);
+	if (NULL == context)
+	{
+		fprintf(stderr, "Unable to open device.\n");
+		exit(1);
+	}
+
+	/* Allocate PD */
+	pd = ibv_alloc_pd(context);
+	if (!pd)
+	{
+		fprintf(stderr, "Unable to allocate PD.\n");
+		exit(1);
+	}
+
+	/* Create CQ */
+	cq = ibv_create_cq(context, 2048, NULL, NULL, 0);
+	if (!cq)
+	{
+		fprintf(stderr, "Unable to create cq.\n");
+		exit(1);
+	}
+
+	/* Create SRQ */
+	memset(&srqiattr, 0, sizeof(srqiattr));
+	srqiattr.attr.max_wr    = 2048;
+	srqiattr.attr.max_sge   = 4;
+	srqiattr.attr.srq_limit = 1024;
+	srq = ibv_create_srq(pd, &srqiattr);
+	if (NULL == srq)
+	{
+		fprintf(stderr, "Unable to create sreq.\n");
+		exit(1);
+	}
+
+	memset(&qpiattr, 0, sizeof(qpiattr));
+	qpiattr.send_cq = cq;
+	qpiattr.recv_cq = cq;
+	qpiattr.srq     = srq;
+	qpiattr.cap.max_send_wr = 128;
+	qpiattr.cap.max_recv_wr = 4;
+	qpiattr.cap.max_send_sge = 5;
+	qpiattr.cap.max_recv_sge = 4;
+	qpiattr.cap.max_inline_data = 512;
+	qpiattr.qp_type = IBV_QPT_RC;
+	qpiattr.sq_sig_all = 1;
+	qp = ibv_create_qp(pd, &qpiattr);
+
+	if (!qp)
+	{
+		fprintf(stderr, "Unable to create QP %d.\n", i);
+		exit(1);
+	}
+
+	return 0;
+}
+
+int init_rc_qp(uint8_t port, uint16_t pkey_index)
+{
+	struct ibv_qp_attr attr = {
+	         .qp_state        = IBV_QPS_INIT,
+	         .pkey_index      = pkey_index,
+	         .port_num        = port,
+	         .qp_access_flags = 0
+	};
+
+	return ibv_modify_qp(qp, &attr,
+			     IBV_QP_STATE |
+			     IBV_QP_PKEY_INDEX |
+			     IBV_QP_PORT |
+			     IBV_QP_ACCESS_FLAGS);
+}
+
+int main(int argc, char *argv[])
+{
+	uint16_t pkey_index;
+	uint8_t port;
+	int ret;
+
+	if (argc != 4)
+	{
+		printf("Please enter <ib device name> <port number> <pkey index>\n");
+		exit(1);
+	}
+	port = atoi(argv[2]);
+	pkey_index = atoi(argv[3]);
+
+	init_ib_rsrc(argv[1]);
+
+	ret = init_rc_qp(port, pkey_index);
+	cleanup_ib_rsrc();
+	exit(ret);
+}
diff --git a/tests/infiniband_pkey/ibpkey_test.conf b/tests/infiniband_pkey/ibpkey_test.conf
new file mode 100644
index 0000000..59f738d
--- /dev/null
+++ b/tests/infiniband_pkey/ibpkey_test.conf
@@ -0,0 +1,18 @@
+# Enable(1)/Disable these tests
+SELINUX_INFINIBAND_PKEY_TEST=0
+
+# Infiniband device to use.
+SELINUX_INFINIBAND_PKEY_TEST_DEV=mlx5_3
+
+# Physical port on the device to use.
+SELINUX_INFINIBAND_PKEY_TEST_PORT=1
+
+# CSV list of pkey table indexes containing labeled PKeys
+# These will not be allowed. 
+SELINUX_INFINIBAND_TEST_LABELED_PKEYS=
+
+# CSV list of pkey table indexes containing unlabelde PKeys
+# This will be allowed, then temporarily labeled to see that
+# they are disallowed.
+SELINUX_INFINIBAND_TEST_UNLABELED_PKEYS=0
+
diff --git a/tests/infiniband_pkey/test b/tests/infiniband_pkey/test
new file mode 100755
index 0000000..d40a1f6
--- /dev/null
+++ b/tests/infiniband_pkey/test
@@ -0,0 +1,84 @@
+#!/usr/bin/perl
+
+use Test;
+
+BEGIN { plan tests => 3}
+
+$basedir = $0; $basedir =~ s|(.*)/[^/]*|$1|;
+
+my %conf;
+$confpath = $basedir."/ibpkey_test.conf";
+open($f, $confpath) or die ("Couldn't open $confpath");
+while($r = <$f>) {
+	if ($r =~ /^\s*#/ || $r =~ /^\s*$/) { next; }
+	chomp $r;
+	($k,$v) = split(/=/, $r);
+	$conf{$k} = $v;
+}
+close($f);
+
+if ($conf{SELINUX_INFINIBAND_PKEY_TEST} eq 1) {
+	$device = $conf{SELINUX_INFINIBAND_PKEY_TEST_DEV};
+	$port = $conf{SELINUX_INFINIBAND_PKEY_TEST_PORT};
+
+	# Read GID 0, to get the subnet prefix.
+	$gid_path = "/sys/class/infiniband/".$device."/ports/".$port."/gids/0";
+	open($f, $gid_path) or die ("Couldn't open $gid_path");
+	$gid = <$f>;
+	close($f);
+	# The gid sysfs shows a fully expanded ipv6 address, just take the
+	# top half.
+	@tmp = unpack('(a20)*', $gid);
+	$subnet_prefix = $tmp[0].":";
+
+	@labeled_pkeys = split(/,/, $conf{SELINUX_INFINIBAND_TEST_LABELED_PKEYS});
+	@unlabeled_pkeys = split(/,/, $conf{SELINUX_INFINIBAND_TEST_UNLABELED_PKEYS});
+
+	foreach (@unlabeled_pkeys) {
+		$result = system "runcon -t test_ibpkey_access_t $basedir/create_modify_qp $device $port $_";
+		if($result ne 0) {
+			last;
+		}
+	}
+	if (@unlabeled_pkeys) {
+		ok($result, 0);
+	} else {
+		ok(1);
+	}
+
+	foreach (@unlabeled_pkeys) {
+		$pkey_path = "/sys/class/infiniband/".$device."/ports/".$port."/pkeys/".$_;
+		open($f, $pkey_path) or die ("Couldn't open $pkey_path");
+		$pkey_val = <$f>;
+		close($f);
+
+		system "semanage ibpkey -a -t test_ibpkey_t -x $subnet_prefix $pkey_val";
+		$result = system "runcon -t test_ibpkey_access_t $basedir/create_modify_qp $device $port $_";
+		system "semanage ibpkey -d -t test_ibpkey_t -x $subnet_prefix $pkey_val";
+		if ($result>>8 ne 13) {
+			last;
+		}
+	}
+	if (@unlabeled_pkeys) {
+		ok($result>>8, 13);
+	} else {
+		ok(1);
+	}
+
+	foreach (@labeled_pkeys) {
+		$result = system "runcon -t test_ibpkey_access_t $basedir/create_modify_qp $device $port $_";
+		if ($result>>8 ne 13) {
+			last;
+		}
+	}
+	if (@labeled_pkeys) {
+		ok($result>>8, 13);
+	} else {
+		ok(1);
+	}
+} else {
+	ok(1);
+	ok(1);
+	ok(1);
+}
+exit;
-- 
2.12.2
