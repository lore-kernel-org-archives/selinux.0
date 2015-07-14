From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] selinux-testsuite: ipsec-load: Derive state context from
 current context.
Date: Tue, 14 Jul 2015 11:56:51 -0400
Message-Id: <1436889411-23818-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Change ipsec-load to derive the state context from the current context
rather than assuming that the caller always has a given user/role/range.
This is similar to logic elsewhere throughout the tests that only
sets the type to one of the test domains/types and otherwise inherits
the user/role/range from the caller (for a process) or a related object
(for a file).  This keeps the test independent of whether it is called
from e.g. an unconfined user shell vs a sysadm user shell or from
targeted vs mls policy.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/inet_socket/ipsec-load | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/inet_socket/ipsec-load b/tests/inet_socket/ipsec-load
index 1ce86fd..ded6efb 100755
--- a/tests/inet_socket/ipsec-load
+++ b/tests/inet_socket/ipsec-load
@@ -3,7 +3,9 @@ echo 0 > /proc/sys/net/ipv4/conf/lo/disable_xfrm
 echo 0 > /proc/sys/net/ipv4/conf/lo/disable_policy
 ip xfrm policy flush
 ip xfrm state flush
-ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x200 ctx "unconfined_u:unconfined_r:test_inet_client_t:s0-s0:c0.c1023" auth md5 0123456789012345
-ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x250 ctx "unconfined_u:unconfined_r:test_inet_bad_client_t:s0-s0:c0.c1023" auth md5 0123456789012345
+goodclientcon=`secon -u`:`secon -r`:test_inet_client_t:`secon -m`
+badclientcon=`secon -u`:`secon -r`:test_inet_bad_client_t:`secon -m`
+ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x200 ctx $goodclientcon auth md5 0123456789012345
+ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x250 ctx $badclientcon auth md5 0123456789012345
 ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
 ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
-- 
2.1.0
