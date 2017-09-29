From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 29 Sep 2017 13:23:14 -0400
Message-Id: <20170929172314.16443-2-sds@tycho.nsa.gov>
In-Reply-To: <20170929172314.16443-1-sds@tycho.nsa.gov>
References: <20170929172314.16443-1-sds@tycho.nsa.gov>
Subject: [PATCH 2/2 v2] selinux-testsuite: Move kernel config to a defconfig
 fragment
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Move the required kernel configuration options to run the testsuite
from the README to a separate defconfig file, and update the README to
refer to it and provide instructions on how to merge this file with a
base config.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 README    | 80 ++++++++++++++++-----------------------------------------------
 defconfig | 53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 60 deletions(-)
 create mode 100644 defconfig

diff --git a/README b/README
index 8ae9dbd..e832f49 100644
--- a/README
+++ b/README
@@ -9,70 +9,30 @@ PREREQUISITES
 
 Kernel Configuration
 --------------------
-Your kernel should have been built with the following options to
-test SELinux:
-
-# Minimal dependencies.
-CONFIG_AUDIT=y
-CONFIG_NET=y
-CONFIG_INET=y
-CONFIG_IPV6=y
-CONFIG_SECURITY=y
-CONFIG_SECURITY_NETWORK=y
-CONFIG_SECURITY_SELINUX=y
-
-# For testing of labeled IPSEC, NetLabel, and SECMARK functionality.
-# Not strictly required for basic SELinux operation.
-CONFIG_SECURITY_NETWORK_XFRM=y
-CONFIG_NETLABEL=y
-CONFIG_IP_NF_SECURITY=m
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_AH=m
-CONFIG_INET6_XFRM_MODE_TRANSPORT=m
-CONFIG_INET6_AH=m
-CONFIG_CRYPTO_SHA1=m # used for testing, could be updated if desired
-CONFIG_NETWORK_SECMARK=y
-CONFIG_NF_CONNTRACK_SECMARK=y
-CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
-CONFIG_NETFILTER_XT_TARGET_SECMARK=m
-
-# Filesystem security labeling support.
-# Only need to enable the ones for the filesystems on which you are testing.
-# reiserfs is not supported.
-CONFIG_EXT2_FS_SECURITY=y
-CONFIG_EXT3_FS_SECURITY=y
-CONFIG_EXT4_FS_SECURITY=y
-CONFIG_JFS_SECURITY=y
-CONFIG_XFS_SECURITY=y
-CONFIG_JFFS2_FS_SECURITY=y
-
-# Network protocol implementations.
-# These are enabled to test the extended socket classes in
-# tests/extended_socket_class; they are not required
-# for SELinux operation itself.
-CONFIG_IP_SCTP=m
-CONFIG_BT=m
-CONFIG_CRYPTO_USER_API=m
-
-# Netlink protocol implementations.
-# These are enabled to test the netlink socket controls in
-# tests/netlink_socket; they are not required for SELinux operation itself.
-CONFIG_SCSI_ISCSI_ATTRS=m
-CONFIG_NETFILTER_NETLINK=m
-CONFIG_CRYPTO_USER=m
-
-# Overlay fs.
-# This is enabled to test overlayfs SELinux integration.
-# It is not required for SELinux operation itself.
-CONFIG_OVERLAY_FS=m
+Your kernel should have been built with the configuration options
+specified by the defconfig file in this directory to run this testsuite.
+You can merge the provided defconfig file with your existing .config
+file (or one generated via e.g. make localmodconfig or other commands)
+using the kernel ./scripts/kconfig/merge_config.sh script as follows:
+
+cd linux
+# Assumes that you have already created a .config file with your base config.
+# If you don't have one, generate one using make localmodconfig or other
+# suitable command.
+./scripts/kconfig/merge_config.sh .config /path/to/selinux-testsuite/defconfig
+
+Some of the config options may not be set in the final config because
+they are unnecessary based on your base config, e.g. you only need the
+CONFIG_*_FS_SECURITY option to be enabled for the particular
+filesystem type being used for the testing.
 
 Do not set CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX; it is an
 option for legacy distributions (Fedora 3 and 4).
 
-Otherwise, you should not enable any other security modules in your
-kernel configuration unless you use the security= option to select a
-module at boot time.  Only one primary security module may be active
-at a time.
+You should not enable any other security modules in your kernel
+configuration unless you use the security= option to select a module
+at boot time.  Only one primary security module may be active at a
+time.
 
 Userland and Base Policy
 ------------------------
diff --git a/defconfig b/defconfig
new file mode 100644
index 0000000..7dce8bc
--- /dev/null
+++ b/defconfig
@@ -0,0 +1,53 @@
+# Minimal dependencies.
+CONFIG_AUDIT=y
+CONFIG_NET=y
+CONFIG_INET=y
+CONFIG_IPV6=y
+CONFIG_SECURITY=y
+CONFIG_SECURITY_NETWORK=y
+CONFIG_SECURITY_SELINUX=y
+
+# For testing of labeled IPSEC, NetLabel, and SECMARK functionality.
+# Not strictly required for basic SELinux operation.
+CONFIG_SECURITY_NETWORK_XFRM=y
+CONFIG_NETLABEL=y
+CONFIG_IP_NF_SECURITY=m
+CONFIG_INET_XFRM_MODE_TRANSPORT=m
+CONFIG_INET_AH=m
+CONFIG_INET6_XFRM_MODE_TRANSPORT=m
+CONFIG_INET6_AH=m
+CONFIG_CRYPTO_SHA1=m # used for testing, could be updated if desired
+CONFIG_NETWORK_SECMARK=y
+CONFIG_NF_CONNTRACK_SECMARK=y
+CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
+CONFIG_NETFILTER_XT_TARGET_SECMARK=m
+
+# Filesystem security labeling support.
+# Only need to enable the ones for the filesystems on which you are testing.
+# reiserfs is not supported.
+CONFIG_EXT2_FS_SECURITY=y
+CONFIG_EXT3_FS_SECURITY=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_JFS_SECURITY=y
+CONFIG_XFS_SECURITY=y
+CONFIG_JFFS2_FS_SECURITY=y
+
+# Network protocol implementations.
+# These are enabled to test the extended socket classes in
+# tests/extended_socket_class; they are not required
+# for SELinux operation itself.
+CONFIG_IP_SCTP=m
+CONFIG_BT=m
+CONFIG_CRYPTO_USER_API=m
+
+# Netlink protocol implementations.
+# These are enabled to test the netlink socket controls in
+# tests/netlink_socket; they are not required for SELinux operation itself.
+CONFIG_SCSI_ISCSI_ATTRS=m
+CONFIG_NETFILTER_NETLINK=m
+CONFIG_CRYPTO_USER=m
+
+# Overlay fs.
+# This is enabled to test overlayfs SELinux integration.
+# It is not required for SELinux operation itself.
+CONFIG_OVERLAY_FS=m
-- 
2.9.5
