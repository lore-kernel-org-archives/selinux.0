From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Date: Mon, 30 Oct 2017 10:08:24 -0400
Message-Id: <20171030140824.12753-1-sds@tycho.nsa.gov>
Subject: [PATCH] selinux-testsuite: inet_socket: test xfrm state selectors
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Augment the inet_socket ipsec-load configuration and test script
to test xfrm state selectors.  This isn't really testing SELinux
functionality per se but is rather illustrating the lack of xfrm
selector matching in the xdst pcpu cache.

I don't know if we truly want this in the selinux-testsuite; I used
it to confirm that we are not getting proper xfrm state selector
matching with the current xdst pcpu cache code and to test a possible fix.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/inet_socket/ipsec-load |  7 +++++--
 tests/inet_socket/test       | 23 ++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/tests/inet_socket/ipsec-load b/tests/inet_socket/ipsec-load
index 21e2dfe..ca377b5 100755
--- a/tests/inet_socket/ipsec-load
+++ b/tests/inet_socket/ipsec-load
@@ -5,8 +5,11 @@ ip xfrm policy flush
 ip xfrm state flush
 goodclientcon=`secon -u --pid $$`:`secon -r --pid $$`:test_inet_client_t:`secon -m --pid $$`
 badclientcon=`secon -u --pid $$`:`secon -r --pid $$`:test_inet_bad_client_t:`secon -m --pid $$`
-ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x200 ctx $goodclientcon auth sha1 0123456789012345
-ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x250 ctx $badclientcon auth sha1 0123456789012345
+ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x200 ctx $goodclientcon auth sha1 0123456789012345 sel proto tcp dport 65535
+ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x400 ctx $goodclientcon auth sha1 0123456789012345 sel proto tcp dport 65534
+ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x250 ctx $badclientcon auth sha1 0123456789012345 sel proto tcp dport 65535
+ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x300 ctx $goodclientcon auth sha1 0123456789012345 sel proto udp dport 65535
+ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x350 ctx $badclientcon auth sha1 0123456789012345 sel proto udp dport 65535
 ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
 ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
 
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 0bda2a4..88a3696 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -7,7 +7,7 @@ BEGIN {
         plan skip_all => "ctx not supported in ip xfrm policy";
     }
     else {
-        plan tests => 33;
+        plan tests => 36;
     }
 }
 
@@ -159,6 +159,10 @@ if ( ( $pid = fork() ) == 0 ) {
     exec "runcon -t test_inet_server_t $basedir/server stream 65535";
 }
 
+if ( ( $pid2 = fork() ) == 0 ) {
+    exec "runcon -t test_inet_server_t $basedir/server stream 65534";
+}
+
 sleep 1;    # Give it a moment to initialize.
 
 # Verify that authorized client can communicate with the server.
@@ -166,6 +170,22 @@ $result =
   system "runcon -t test_inet_client_t $basedir/client stream 127.0.0.1 65535";
 ok( $result eq 0 );
 
+# Verify that authorized client can communicate with the server.
+$result =
+  system "runcon -t test_inet_client_t $basedir/client stream 127.0.0.1 65534";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server.
+$result =
+  system "runcon -t test_inet_client_t $basedir/client stream 127.0.0.1 65535";
+ok( $result eq 0 );
+
+# Verify that authorized client can communicate with the server.
+$result =
+  system "runcon -t test_inet_client_t $basedir/client stream 127.0.0.1 65534";
+ok( $result eq 0 );
+
+
 # Verify that unauthorized client cannot communicate with the server.
 $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client stream 127.0.0.1 65535 2>&1";
@@ -183,6 +203,7 @@ ok( $result >> 8 eq 5 );
 
 # Kill the server.
 kill TERM, $pid;
+kill TERM, $pid2;
 
 # Start the dgram server.
 if ( ( $pid = fork() ) == 0 ) {
-- 
2.9.5
