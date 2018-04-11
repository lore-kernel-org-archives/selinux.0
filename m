Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3BEwbtY010470
 for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2018 10:58:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 70D79401CC41
 for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2018 14:55:57 +0000 (UTC)
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 11 Apr 2018 10:55:57 -0400
Message-ID: <152345855704.8952.10742889065011630053.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] selinux-testsuite: add some additional comments to
 the IB configuration files
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

The biosdevname and systemd/udev predictable network interface name efforts
have changed how network interfaces appear using the ip/ifconfig tools.  Add
some additional guidance to the Infiniband configuration files to help make
the device/port information easier to determine.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 tests/infiniband_endport/ibendport_test.conf |   16 ++++++++++------
 tests/infiniband_pkey/ibpkey_test.conf       |   18 ++++++++++++------
 2 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/tests/infiniband_endport/ibendport_test.conf b/tests/infiniband_endport/ibendport_test.conf
index 601b290..6ed9756 100644
--- a/tests/infiniband_endport/ibendport_test.conf
+++ b/tests/infiniband_endport/ibendport_test.conf
@@ -1,12 +1,16 @@
-# Enable(1)/Disable these tests.
+# InfiniBand endport test configuration file
+
+# The InfiniBand devices can be determined by inspecting the
+# /sys/class/infiniband directory and the ports for a given device can be
+# found by inspecting the /sys/class/infiniband/<device>/ports directory.
+
+# Enable(1)/Disable(0) these tests.
 SELINUX_INFINIBAND_ENDPORT_TEST=0
 
 # Device/port pair that should allow access.
-# The test uses semanage to allow, because
-# ibendports are all unlabeled by default
-# the reference policy. This allows using
-# the same device and port for both the pass
-# and fail testing as well.
+# The test uses semanage to allow, because ibendports are all unlabeled by
+# default the reference policy. This allows using the same device and port for
+# both the pass and fail testing as well.
 SELINUX_INFINIBAND_ENDPORT_TEST_ALLOWED=mlx5_3 1
 
 # Device/port pairs that should deny access.
diff --git a/tests/infiniband_pkey/ibpkey_test.conf b/tests/infiniband_pkey/ibpkey_test.conf
index 59f738d..cfc2893 100644
--- a/tests/infiniband_pkey/ibpkey_test.conf
+++ b/tests/infiniband_pkey/ibpkey_test.conf
@@ -1,18 +1,24 @@
-# Enable(1)/Disable these tests
+# InfiniBand PKey test configuration file
+
+# The InfiniBand devices can be determined by inspecting the
+# /sys/class/infiniband directory and the ports for a given device can be
+# found by inspecting the /sys/class/infiniband/<device>/ports directory.
+
+# Enable(1)/Disable(0) these tests
 SELINUX_INFINIBAND_PKEY_TEST=0
 
-# Infiniband device to use.
+# InfiniBand device to use.
 SELINUX_INFINIBAND_PKEY_TEST_DEV=mlx5_3
 
 # Physical port on the device to use.
 SELINUX_INFINIBAND_PKEY_TEST_PORT=1
 
-# CSV list of pkey table indexes containing labeled PKeys
+# CSV list of pkey table indexes containing labeled PKeys.
 # These will not be allowed. 
 SELINUX_INFINIBAND_TEST_LABELED_PKEYS=
 
-# CSV list of pkey table indexes containing unlabelde PKeys
-# This will be allowed, then temporarily labeled to see that
-# they are disallowed.
+# CSV list of pkey table indexes containing unlabeled PKeys.
+# This will be allowed, then temporarily labeled to see that they are
+# disallowed.
 SELINUX_INFINIBAND_TEST_UNLABELED_PKEYS=0
 
