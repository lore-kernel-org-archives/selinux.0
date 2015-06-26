From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite:  Add a ToDo list.
Date: Fri, 26 Jun 2015 09:44:25 -0400
Message-Id: <1435326265-28007-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Create a ToDo list for the selinux-testsuite identifying known
gaps in the current tests.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 ToDo | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 ToDo

diff --git a/ToDo b/ToDo
new file mode 100644
index 0000000..8b656c5
--- /dev/null
+++ b/ToDo
@@ -0,0 +1,21 @@
+unix_socket, inet_socket: test individual failure (denial) of common socket permissions (create, bind, ...).
+unix_socket, inet_socket: test setsockcreatecon.
+unix_socket: generalize tests to cover file namespace as well as abstract.
+inet_socket: generalize tests to cover INET6 as well as INET.
+inet_socket: test individual failure of netif ingress/egress.
+inet_socket: test individual failure of node recvfrom/sendto.
+inet_socket: test packet forward_in/forward_out (requires peer labeling + secmark configuration).
+inet_socket: test labeling of new connection sockets, esp. MLS attributes.
+Add tests for tun_socket permission checks.
+Add tests for netlink sockets, including nlmsg_read/write/... permissions.
+ioctl: Test new ioctl whitelisting feature.
+Generalize or duplicate nnp tests for nosuid mount case.
+Add tests for mount and umount, including permission checks and context-related mount options.
+Add tests for mmap/mprotect for execmem, execstack, execheap, execmod, mmap_zero.
+Add tests for CAP_MAC_ADMIN/mac_admin and its effect on setting/getting security contexts unknown to the currently loaded policy.
+Add tests for new file labeling: type_transition, setfscreatecon, context mounts.
+Add tests for inheritance across domain-changing exec: noatsecure, siginh, rlimitinh.
+Add tests for kernel keyring labeling and permission checks, including setkeycreatecon.
+Add test for system permission checks: ipc_info, syslog_read, syslog_mod, syslog_console, module_request.
+Add tests for quotactl for filesystem quotamod, quotaget permissions and file quotaon checks.
+Add optional tests for binder permission checks, if kernel supports it.
-- 
2.1.0
