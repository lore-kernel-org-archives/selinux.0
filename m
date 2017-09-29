From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 29 Sep 2017 13:23:13 -0400
Message-Id: <20170929172314.16443-1-sds@tycho.nsa.gov>
Subject: [PATCH 1/2 v2] selinux-testsuite: README: Update kernel config
 requirements
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Add several config options that are required by the inet_socket,
netlink_socket, and overlay tests.  Note that these are not required
for basic SELinux operation itself but merely to test the corresponding
functionality.

Discovered these undocumented dependencies upon running selinux-testsuite
after running make localmodconfig and then re-adding the already documented
config options to my config; these three tests had failures due to
the missing config options.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 fixes the config option required for testing NETLINK_ISCSI sockets.

 README | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/README b/README
index de50eb4..8ae9dbd 100644
--- a/README
+++ b/README
@@ -19,11 +19,18 @@ CONFIG_INET=y
 CONFIG_IPV6=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
-CONFIG_SECURITY_NETWORK_XFRM=y
 CONFIG_SECURITY_SELINUX=y
+
+# For testing of labeled IPSEC, NetLabel, and SECMARK functionality.
+# Not strictly required for basic SELinux operation.
+CONFIG_SECURITY_NETWORK_XFRM=y
 CONFIG_NETLABEL=y
 CONFIG_IP_NF_SECURITY=m
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
+CONFIG_INET_AH=m
+CONFIG_INET6_XFRM_MODE_TRANSPORT=m
+CONFIG_INET6_AH=m
+CONFIG_CRYPTO_SHA1=m # used for testing, could be updated if desired
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NF_CONNTRACK_SECMARK=y
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
@@ -47,6 +54,18 @@ CONFIG_IP_SCTP=m
 CONFIG_BT=m
 CONFIG_CRYPTO_USER_API=m
 
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
+
 Do not set CONFIG_SECURITY_SELINUX_POLICYDB_VERSION_MAX; it is an
 option for legacy distributions (Fedora 3 and 4).
 
-- 
2.9.5
