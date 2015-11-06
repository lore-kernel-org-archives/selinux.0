From: Jan Stancek <jstancek@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, paul@paul-moore.com, jstancek@redhat.com
Subject: [selinux-testsuite PATCH 1/4] tests/inet_socket: check 'ip xfrm
 policy ctx' support
Date: Fri,  6 Nov 2015 14:07:21 +0100
Message-Id: <fbc99e6ee9a6bdbf27d6ff71d3548c20b4bbf23c.1446805443.git.jstancek@redhat.com>
In-Reply-To: <cover.1446805443.git.jstancek@redhat.com>
References: <cover.1446805443.git.jstancek@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Early RHEL6 distros like RHEL6.0 do not support "ctx" parameter,
which is causing test to fail:
  Error: argument "ctx" is wrong: unknown

Signed-off-by: Jan Stancek <jstancek@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
---
 tests/inet_socket/test | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 4deca746208c..4f6ee51cec5c 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -1,7 +1,14 @@
 #!/usr/bin/perl
-
-use Test;
-BEGIN { plan tests => 20}
+use Test::More;
+
+BEGIN {
+    # check if ip xfrm supports ctx parameter
+    if (system("ip xfrm policy help 2>&1 | grep ctx") != 0) {
+        plan skip_all => "ctx not supported in ip xfrm policy";
+    } else {
+        plan tests => 20;
+    }
+}
 
 $basedir = $0;  $basedir =~ s|(.*)/[^/]*|$1|;
 
@@ -17,7 +24,7 @@ sleep 1; # Give it a moment to initialize.
 
 # Verify that authorized client can communicate with the server.
 $result = system "runcon -t test_inet_client_t $basedir/client stream 65535";
-ok($result, 0);
+ok($result eq 0);
 
 # Verify that unauthorized client cannot communicate with the server.
 $result = system "runcon -t test_inet_bad_client_t -- $basedir/client stream 65535 2>&1";
@@ -35,7 +42,7 @@ sleep 1; # Give it a moment to initialize
 
 # Verify that authorized client can communicate with the server.
 $result = system "runcon -t test_inet_client_t $basedir/client dgram 65535";
-ok($result, 0);
+ok($result eq 0);
 
 # Verify that unauthorized client cannot communicate with the server.
 $result = system "runcon -t test_inet_bad_client_t -- $basedir/client dgram 65535 2>&1";
@@ -49,11 +56,11 @@ system "$basedir/netlabel-flush";
 
 # Verify that authorized domain can bind UDP sockets.
 $result = system "runcon -t test_inet_bind_t -- $basedir/bind dgram 65535 2>&1";
-ok($result, 0);
+ok($result eq 0);
 
 # Verify that authorized domain can bind TCP sockets.
 $result = system "runcon -t test_inet_bind_t -- $basedir/bind stream 65535 2>&1";
-ok($result, 0);
+ok($result eq 0);
 
 # Verify that domain without name_bind cannot bind UDP sockets.
 $result = system "runcon -t test_inet_no_name_bind_t -- $basedir/bind dgram 65535 2>&1";
@@ -73,7 +80,7 @@ ok($result);
 
 # Verify that authorized domain can connect to TCP socket.
 $result = system "runcon -t test_inet_connect_t -- $basedir/connect 65535 2>&1";
-ok($result, 0);
+ok($result eq 0);
 
 # Verify that domain without name_connect cannot connect to TCP socket.
 $result = system "runcon -t test_inet_no_name_connect_t -- $basedir/connect 65535 2>&1";
@@ -91,7 +98,7 @@ sleep 1; # Give it a moment to initialize.
 
 # Verify that authorized client can communicate with the server.
 $result = system "runcon -t test_inet_client_t $basedir/client stream 65535";
-ok($result, 0);
+ok($result eq 0);
 
 # Verify that unauthorized client cannot communicate with the server.
 $result = system "runcon -t test_inet_bad_client_t -- $basedir/client stream 65535 2>&1";
@@ -109,7 +116,7 @@ sleep 1; # Give it a moment to initialize
 
 # Verify that authorized client can communicate with the server.
 $result = system "runcon -t test_inet_client_t $basedir/client dgram 65535";
-ok($result, 0);
+ok($result eq 0);
 
 # Verify that unauthorized client cannot communicate with the server.
 $result = system "runcon -t test_inet_bad_client_t -- $basedir/client dgram 65535 2>&1";
@@ -133,7 +140,7 @@ sleep 1; # Give it a moment to initialize.
 
 # Verify that authorized client can communicate with the server.
 $result = system "runcon -t test_inet_client_t -- $basedir/client -n stream 65535";
-ok($result, 0);
+ok($result eq 0);
 
 # Verify that unauthorized client cannot communicate with the server.
 $result = system "runcon -t test_inet_bad_client_t -- $basedir/client -n stream 65535 2>&1";
@@ -151,7 +158,7 @@ sleep 1; # Give it a moment to initialize
 
 # Verify that authorized client can communicate with the server.
 $result = system "runcon -t test_inet_client_t $basedir/client -n dgram 65535";
-ok($result, 0);
+ok($result eq 0);
 
 # Verify that unauthorized client cannot communicate with the server.
 $result = system "runcon -t test_inet_bad_client_t -- $basedir/client -n dgram 65535 2>&1";
-- 
1.8.3.1
