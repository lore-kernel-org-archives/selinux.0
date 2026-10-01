Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52343F08C
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869022; cv=none; b=dwlRpcmd934NPPriCkY646Npar9641l7FwcRlc2e/3+Ju+45UthbQaa48MfHK6TBHHHCut8tSa+HISbxy+vkz+OGu3n1GmZBVWZKa/DHU124ueVMumj1knt/JgUincciTfo4sJfr7lZ+bd67wHMwi/6sfGf44unLa+t3bPX1zTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869022; c=relaxed/simple;
	bh=MRoCKsq8106nbbbV9tgn0QAmhHeA04AdeKdt9jMpA8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nny6JSCiYItRzCnMKoCzCTYL3BnVGIk6YT+kW3Zb7WZL0VYhvjg23QERBZ28jpPS3hkR/BG5ierkvWevShmTxF5/ZB83h9/kDRVfwrudy4XqKKyVFvugEeMZnvJ8rAnpJqkFXwd+fb3no537q2Ke3B1huOWeNnxlkWD9ojFiX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKGEKHYY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKGEKHYY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790869019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0IO01WsBTcAo+R4nH1NypUz6FH0fMmeFQLycxMPThs=;
	b=TKGEKHYYe0gvfnO7AsmXwXkuwProenZesj51Wm5TE9SL2f5+VuF5hSUUFBDhQT0pjiUwv/
	gDYEmo7iJwA4C/b0zE8E+GJuD9OHEOowvQnXIVn6WLBNO8scMXTmuDEATXvFdGfIN4ORya
	xTgQrPlHpgFe6am3sVlZp+wrRJGh4Fg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-SAxDfRtQMza3L3JKadIndw-1; Thu,
 01 Oct 2026 11:36:54 -0400
X-MC-Unique: SAxDfRtQMza3L3JKadIndw-1
X-Mimecast-MFC-AGG-ID: SAxDfRtQMza3L3JKadIndw_1790869013
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CA0A18301D1;
	Thu,  1 Oct 2026 15:36:53 +0000 (UTC)
Received: from bgrech-thinkpadp1gen3.rmtustx.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71F6E41B;
	Thu,  1 Oct 2026 15:36:52 +0000 (UTC)
From: Brian Grech <bgrech@redhat.com>
To: selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com
Cc: jonderka@redhat.com,
	Brian Grech <bgrech@redhat.com>
Subject: [PATCH] tests: make IPv6 subtests optional on IPv4-only systems
Date: Thu,  1 Oct 2026 10:36:50 -0500
Message-ID: <20261001153650.105863-1-bgrech@redhat.com>
In-Reply-To: <20260710082514.452700-1-jonderka@redhat.com>
References: <20260710082514.452700-1-jonderka@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Skip or adapt IPv6-dependent subtests when the running system does not
have usable IPv6 on loopback.

- Add tests/has_ipv6 helper that checks /proc/net/if_inet6 and the
  net.ipv6.conf.all/lo.disable_ipv6 sysctls.
- Wrap IPv6-only cases in inet_socket, extended_socket_class, and sctp
  Perl tests behind $test_ipv6 / ipv6_enabled() checks and reduce test
  counts accordingly.
- Make inet_socket/server.c fall back to AF_INET when IPv6 is absent.
- Split IPv6 firewall/load script rules into nftables-ipv6.load and only
  invoke ip6tables/nftables IPv6 setup from load scripts when has_ipv6
  succeeds.
- Add ipv6_enabled() to sctp_common for C helpers and SCTP bindx paths.
- Select the socket address family from has_ipv6 before entering
  confined test domains, instead of probing IPv6 from inside them: the
  probe can itself be denied by SELinux policy in a confined domain,
  which silently selected IPv4 while the test runner kept executing
  IPv6-only cases, and could otherwise misreport IPv6 as unavailable.

Signed-off-by: Jan Onderka <jonderka@redhat.com>

Co-developed-by: Jan Onderka <jonderka@redhat.com>
Signed-off-by: Brian Grech <bgrech@redhat.com>
---
 tests/extended_socket_class/test      |  61 +++++++-----
 tests/has_ipv6                        |  23 +++++
 tests/inet_socket/ipsec-load          |   4 +
 tests/inet_socket/iptables-flush      |   9 +-
 tests/inet_socket/iptables-load       |   5 +
 tests/inet_socket/nftables-flush      |   1 -
 tests/inet_socket/nftables-ipv6-flush |   1 +
 tests/inet_socket/nftables-ipv6.load  |  35 +++++++
 tests/inet_socket/nftables-load       |  35 +------
 tests/inet_socket/server.c            |  12 ++-
 tests/inet_socket/test                |  51 +++++++---
 tests/sctp/fb-deny-label-flush        |   5 +
 tests/sctp/fb-deny-label-load         |   7 ++
 tests/sctp/fb-label-flush             |   5 +
 tests/sctp/fb-label-load              |   7 ++
 tests/sctp/iptables-flush             |   5 +
 tests/sctp/iptables-load              |   9 ++
 tests/sctp/nftables-flush             |   1 -
 tests/sctp/nftables-ipv6-flush        |   1 +
 tests/sctp/nftables-ipv6.load         |  33 +++++++
 tests/sctp/nftables-load              |  33 +------
 tests/sctp/sctp_bindx.c               |  33 +++++--
 tests/sctp/test                       | 136 ++++++++++++++++++--------
 tmt/tests.fmf                         |   2 -
 24 files changed, 355 insertions(+), 159 deletions(-)
 create mode 100755 tests/has_ipv6
 create mode 100644 tests/inet_socket/nftables-ipv6-flush
 create mode 100644 tests/inet_socket/nftables-ipv6.load
 create mode 100644 tests/sctp/nftables-ipv6-flush
 create mode 100644 tests/sctp/nftables-ipv6.load

diff --git a/tests/extended_socket_class/test b/tests/extended_socket_class/test
index 1e6299f..16457bc 100755
--- a/tests/extended_socket_class/test
+++ b/tests/extended_socket_class/test
@@ -26,6 +26,17 @@ BEGIN {
         $test_smc = 1;
     }
 
+    # Determine if IPv6 is enabled on loopback.
+    my $testdir = $0;
+    $testdir =~ s|(.*)/[^/]*|$1|;
+    $test_ipv6 = system("$testdir/../has_ipv6") == 0 ? 1 : 0;
+    if ( !$test_ipv6 ) {
+        $test_count -= 2;
+        if ($test_sctp) {
+            $test_count -= 4;
+        }
+    }
+
     plan tests => $test_count;
 }
 
@@ -46,17 +57,20 @@ $result = system(
 );
 ok($result);
 
-# Verify that test_icmp_socket_t can create an ICMPv6 socket.
-$result = system(
+if ($test_ipv6) {
+
+    # Verify that test_icmp_socket_t can create an ICMPv6 socket.
+    $result = system(
 "runcon -t test_icmp_socket_t -- $basedir/sockcreate inet6 dgram icmpv6 2>&1"
-);
-ok( $result, 0 );
+    );
+    ok( $result, 0 );
 
-# Verify that test_no_icmp_socket_t cannot create an ICMPv6 socket.
-$result = system(
+    # Verify that test_no_icmp_socket_t cannot create an ICMPv6 socket.
+    $result = system(
 "runcon -t test_no_icmp_socket_t -- $basedir/sockcreate inet6 dgram icmpv6 2>&1"
-);
-ok($result);
+    );
+    ok($result);
+}
 
 # Restore to the kernel defaults - no one allowed to create ICMP sockets.
 system("echo 1 0 > /proc/sys/net/ipv4/ping_group_range");
@@ -87,29 +101,32 @@ if ($test_sctp) {
     );
     ok($result);
 
-    # Verify that test_sctp_socket_t can create an IPv6 stream SCTP socket.
-    $result = system(
+    if ($test_ipv6) {
+
+        # Verify that test_sctp_socket_t can create an IPv6 stream SCTP socket.
+        $result = system(
 "runcon -t test_sctp_socket_t -- $basedir/sockcreate inet6 stream sctp 2>&1"
-    );
-    ok( $result, 0 );
+        );
+        ok( $result, 0 );
 
    # Verify that test_no_sctp_socket_t cannot create an IPv6 stream SCTP socket.
-    $result = system(
+        $result = system(
 "runcon -t test_no_sctp_socket_t -- $basedir/sockcreate inet6 stream sctp 2>&1"
-    );
-    ok($result);
+        );
+        ok($result);
 
-    # Verify that test_sctp_socket_t can create an IPv6 seqpacket SCTP socket.
-    $result = system(
+      # Verify that test_sctp_socket_t can create an IPv6 seqpacket SCTP socket.
+        $result = system(
 "runcon -t test_sctp_socket_t -- $basedir/sockcreate inet6 seqpacket sctp 2>&1"
-    );
-    ok( $result, 0 );
+        );
+        ok( $result, 0 );
 
 # Verify that test_no_sctp_socket_t cannot create an IPv6 seqpacket SCTP socket.
-    $result = system(
+        $result = system(
 "runcon -t test_no_sctp_socket_t -- $basedir/sockcreate inet6 seqpacket sctp 2>&1"
-    );
-    ok($result);
+        );
+        ok($result);
+    }
 }
 
 if ($test_bluetooth) {
diff --git a/tests/has_ipv6 b/tests/has_ipv6
new file mode 100755
index 0000000..1c8061f
--- /dev/null
+++ b/tests/has_ipv6
@@ -0,0 +1,23 @@
+#!/bin/sh
+#
+# Return 0 if IPv6 is enabled and usable on loopback, 1 otherwise.
+#
+# IPv6 may be absent (ipv6.disable=1 on the kernel command line), disabled
+# globally (net.ipv6.conf.all.disable_ipv6=1), or disabled on loopback
+# (net.ipv6.conf.lo.disable_ipv6=1).  Following the LTP tst_net.sh approach,
+# check /proc/net/if_inet6 and the disable_ipv6 sysctls rather than module
+# parameters that may be blocked by SELinux policy.
+
+[ -f /proc/net/if_inet6 ] || exit 1
+
+disabled=$(sysctl -n net.ipv6.conf.all.disable_ipv6 2>/dev/null) || exit 1
+[ "$disabled" = 1 ] && exit 1
+
+disabled=$(sysctl -n net.ipv6.conf.lo.disable_ipv6 2>/dev/null) || exit 1
+[ "$disabled" = 1 ] && exit 1
+
+# An existing proc file does not guarantee that ::1 is configured on lo.
+awk '$1 == "00000000000000000000000000000001" && $6 == "lo" {
+    found = 1
+}
+END { exit !found }' /proc/net/if_inet6
diff --git a/tests/inet_socket/ipsec-load b/tests/inet_socket/ipsec-load
index 21e2dfe..e286de3 100644
--- a/tests/inet_socket/ipsec-load
+++ b/tests/inet_socket/ipsec-load
@@ -10,8 +10,12 @@ ip xfrm state add src 127.0.0.1 dst 127.0.0.1 proto ah spi 0x250 ctx $badclientc
 ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
 ip xfrm policy add src 127.0.0.1 dst 127.0.0.1 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
 
+SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
+HAS_IPV6="$SCRIPT_DIR/../has_ipv6"
+if "$HAS_IPV6"; then
 # IPv6 loopback
 ip xfrm state add src ::1 dst ::1 proto ah spi 0x200 ctx $goodclientcon auth sha1 0123456789012345
 ip xfrm state add src ::1 dst ::1 proto ah spi 0x250 ctx $badclientcon auth sha1 0123456789012345
 ip xfrm policy add src ::1 dst ::1 proto tcp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
 ip xfrm policy add src ::1 dst ::1 proto udp dir out ctx "system_u:object_r:test_spd_t:s0" tmpl proto ah mode transport level required
+fi
diff --git a/tests/inet_socket/iptables-flush b/tests/inet_socket/iptables-flush
index c168d89..198bb85 100644
--- a/tests/inet_socket/iptables-flush
+++ b/tests/inet_socket/iptables-flush
@@ -1,6 +1,11 @@
 #!/bin/sh
+SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
+HAS_IPV6="$SCRIPT_DIR/../has_ipv6"
+
 # Flush the security table.
 iptables -t security -F
-iptables -t security -X NEWCONN
+iptables -t security -X NEWCONN 2>/dev/null
+if "$HAS_IPV6"; then
 ip6tables -t security -F
-ip6tables -t security -X NEWCONN
+ip6tables -t security -X NEWCONN 2>/dev/null
+fi
diff --git a/tests/inet_socket/iptables-load b/tests/inet_socket/iptables-load
index 5be94f4..d097ed7 100644
--- a/tests/inet_socket/iptables-load
+++ b/tests/inet_socket/iptables-load
@@ -8,6 +8,9 @@
 # - Specified the interface since the tests are only performed over loopback.
 # - Set the port number and context to the values used by the test script and policy.
 
+SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
+HAS_IPV6="$SCRIPT_DIR/../has_ipv6"
+
 # Flush the security table.
 iptables -t security -F
 
@@ -28,6 +31,7 @@ iptables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECMA
 iptables -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
 iptables -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
 
+if "$HAS_IPV6"; then
 ##### IPv6 entries
 ip6tables -t security -F
 
@@ -47,3 +51,4 @@ ip6tables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECM
 # Label UDP packets similarly.
 ip6tables -t security -A INPUT -i lo -p udp --dport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
 ip6tables -t security -A OUTPUT -o lo -p udp --sport 65535 -j SECMARK --selctx system_u:object_r:test_server_packet_t:s0
+fi
diff --git a/tests/inet_socket/nftables-flush b/tests/inet_socket/nftables-flush
index 7d62b8d..d0fee0c 100644
--- a/tests/inet_socket/nftables-flush
+++ b/tests/inet_socket/nftables-flush
@@ -1,2 +1 @@
 delete table ip security
-delete table ip6 security
diff --git a/tests/inet_socket/nftables-ipv6-flush b/tests/inet_socket/nftables-ipv6-flush
new file mode 100644
index 0000000..0c9b69a
--- /dev/null
+++ b/tests/inet_socket/nftables-ipv6-flush
@@ -0,0 +1 @@
+delete table ip6 security
diff --git a/tests/inet_socket/nftables-ipv6.load b/tests/inet_socket/nftables-ipv6.load
new file mode 100644
index 0000000..6116343
--- /dev/null
+++ b/tests/inet_socket/nftables-ipv6.load
@@ -0,0 +1,35 @@
+# IPv6 secmark rules for inet_socket tests (loaded only when IPv6 is enabled).
+
+add table ip6 security
+
+table ip6 security {
+
+	secmark inet_server {
+		"system_u:object_r:test_server_packet_t:s0"
+	}
+
+	map secmapping_in_out {
+		type inet_service : secmark
+		elements = { 65535 : "inet_server" }
+	}
+
+	chain input {
+		type filter hook input priority 0;
+
+		ct state new meta secmark set tcp dport map @secmapping_in_out
+		ct state new meta secmark set udp dport map @secmapping_in_out
+		ct state new ct secmark set meta secmark
+
+		ct state established,related meta secmark set ct secmark
+	}
+
+	chain output {
+		type filter hook output priority 0;
+
+		ct state new meta secmark set tcp dport map @secmapping_in_out
+		ct state established meta secmark set udp dport map @secmapping_in_out
+		ct state new ct secmark set meta secmark
+
+		ct state established,related meta secmark set ct secmark
+	}
+}
diff --git a/tests/inet_socket/nftables-load b/tests/inet_socket/nftables-load
index 11ec382..14d6efe 100644
--- a/tests/inet_socket/nftables-load
+++ b/tests/inet_socket/nftables-load
@@ -1,7 +1,8 @@
 # Based on NFT project example. Requires kernel >= 4.20 and nft >= 0.9.3
+#
+# IPv6 rules are in nftables-ipv6.load and loaded only when IPv6 is enabled.
 
 add table ip security
-add table ip6 security
 
 table ip security {
 
@@ -40,35 +41,3 @@ table ip security {
 		ct state established,related meta secmark set ct secmark
 	}
 }
-
-table ip6 security {
-
-	secmark inet_server {
-		"system_u:object_r:test_server_packet_t:s0"
-	}
-
-	map secmapping_in_out {
-		type inet_service : secmark
-		elements = { 65535 : "inet_server" }
-	}
-
-	chain input {
-		type filter hook input priority 0;
-
-		ct state new meta secmark set tcp dport map @secmapping_in_out
-		ct state new meta secmark set udp dport map @secmapping_in_out
-		ct state new ct secmark set meta secmark
-
-		ct state established,related meta secmark set ct secmark
-	}
-
-	chain output {
-		type filter hook output priority 0;
-
-		ct state new meta secmark set tcp dport map @secmapping_in_out
-		ct state established meta secmark set udp dport map @secmapping_in_out
-		ct state new ct secmark set meta secmark
-
-		ct state established,related meta secmark set ct secmark
-	}
-}
diff --git a/tests/inet_socket/server.c b/tests/inet_socket/server.c
index 63b6849..e235f8d 100644
--- a/tests/inet_socket/server.c
+++ b/tests/inet_socket/server.c
@@ -25,8 +25,9 @@
 void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-f file] [-n] protocol port\n"
+		"usage:  %s [-4] [-f file] [-n] protocol port\n"
 		"\nWhere:\n\t"
+		"-4        Listen on IPv4 addresses only.\n\t"
 		"-f        Write a line to the file when listening starts.\n\t"
 		"-n        No peer context will be available therefore send\n\t"
 		"          \"nopeer\" message to client, otherwise the peer context\n\t"
@@ -43,11 +44,14 @@ int main(int argc, char **argv)
 	struct sockaddr_storage sin;
 	struct addrinfo hints, *res;
 	char byte;
-	bool nopeer = false;
+	bool nopeer = false, ipv4 = false;
 	char *flag_file = NULL;
 
-	while ((opt = getopt(argc, argv, "f:n")) != -1) {
+	while ((opt = getopt(argc, argv, "4f:n")) != -1) {
 		switch (opt) {
+		case '4':
+			ipv4 = true;
+			break;
 		case 'f':
 			flag_file = optarg;
 			break;
@@ -64,7 +68,7 @@ int main(int argc, char **argv)
 
 	memset(&hints, 0, sizeof(struct addrinfo));
 	hints.ai_flags = AI_PASSIVE;
-	hints.ai_family = AF_INET6;
+	hints.ai_family = ipv4 ? AF_INET : AF_INET6;
 
 	if (!strcmp(argv[optind], "tcp")) {
 		hints.ai_socktype = SOCK_STREAM;
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 9f846bd..3a1c992 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -63,6 +63,25 @@ BEGIN {
         $test_nft = 1;
     }
 
+    # Determine if IPv6 is enabled on loopback.
+    $test_ipv6 = system("$basedir/../has_ipv6") == 0 ? 1 : 0;
+
+    if ( !$test_ipv6 ) {
+        if ($test_ipsec) {
+            $test_count -= 2;
+        }
+        if ($test_calipso) {
+            $test_count -= $is_stream ? 3 : 2;
+            $test_calipso = 0;
+        }
+        if ($test_iptables) {
+            $test_count -= 2;
+        }
+        if ($test_nft) {
+            $test_count -= 2;
+        }
+    }
+
     plan tests => $test_count;
 }
 
@@ -70,6 +89,8 @@ sub server_start {
     my ( $runcon_args, $args ) = @_;
     my $pid;
 
+    $args = "-4 $args" unless $test_ipv6;
+
     system("mkfifo $basedir/flag");
 
     if ( ( $pid = fork() ) == 0 ) {
@@ -340,7 +361,7 @@ if ($test_ipsec) {
 "runcon -t test_inet_bad_client_t -- $basedir/client $proto 127.0.0.1 65535 2>&1";
     ok( $result >> 8 eq $fail_value2 );
 
-    if ($is_stream) {
+    if ( $is_stream && $test_ipv6 ) {
 
         # Verify that authorized client can communicate with the server.
         $result =
@@ -349,15 +370,18 @@ if ($test_ipsec) {
         ok( $result eq 0 );
     }
 
-    # Verify that unauthorized client cannot communicate with the server.
-    $result = system
+    if ($test_ipv6) {
+
+        # Verify that unauthorized client cannot communicate with the server.
+        $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client $proto ::1 65535 2>&1";
-    ok( $result >> 8 eq $fail_value2 );
+        ok( $result >> 8 eq $fail_value2 );
+    }
 
     # Kill the server.
     server_end($pid);
 
-    if ( not $is_stream ) {
+    if ( !$is_stream && $test_ipv6 ) {
 
    # Start the server for IPSEC test using IPv6 but do not request peer context.
         $pid = server_start( "-t test_inet_server_t", "-n $proto 65535" );
@@ -393,15 +417,18 @@ sub test_tables {
 "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer $proto 127.0.0.1 65535 2>&1";
     ok( $result >> 8 eq $fail_value2 );
 
-    # Verify that authorized client can communicate with the server.
-    $result = system
+    if ($test_ipv6) {
+
+        # Verify that authorized client can communicate with the server.
+        $result = system
 "runcon -t test_inet_client_t -- $basedir/client -e nopeer $proto ::1 65535";
-    ok( $result eq 0 );
+        ok( $result eq 0 );
 
-    # Verify that unauthorized client cannot communicate with the server.
-    $result = system
+        # Verify that unauthorized client cannot communicate with the server.
+        $result = system
 "runcon -t test_inet_bad_client_t -- $basedir/client -e nopeer $proto ::1 65535 2>&1";
-    ok( $result >> 8 eq $fail_value2 );
+        ok( $result >> 8 eq $fail_value2 );
+    }
 
     # Kill the server.
     server_end($pid);
@@ -417,7 +444,9 @@ if ($test_iptables) {
 if ($test_nft) {
     print "Testing nftables (IPv4/IPv6).\n";
     system "nft -f $basedir/nftables-load";
+    system "nft -f $basedir/nftables-ipv6.load" if $test_ipv6;
     test_tables();
+    system "nft -f $basedir/nftables-ipv6-flush" if $test_ipv6;
     system "nft -f $basedir/nftables-flush";
 }
 
diff --git a/tests/sctp/fb-deny-label-flush b/tests/sctp/fb-deny-label-flush
index 059e0b7..41e76e6 100644
--- a/tests/sctp/fb-deny-label-flush
+++ b/tests/sctp/fb-deny-label-flush
@@ -1,6 +1,11 @@
 #!/bin/sh
 
+SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
+HAS_IPV6="$SCRIPT_DIR/../has_ipv6"
+
 netlabelctl map del default
 netlabelctl map add default protocol:unlbl
 netlabelctl unlbl del interface:lo address:127.0.0.0/8 label:system_u:object_r:netlabel_sctp_peer_t:s0
+if "$HAS_IPV6"; then
 netlabelctl unlbl del interface:lo address:::1/128 label:system_u:object_r:deny_assoc_sctp_peer_t:s0
+fi
diff --git a/tests/sctp/fb-deny-label-load b/tests/sctp/fb-deny-label-load
index 7c0bd87..647399b 100644
--- a/tests/sctp/fb-deny-label-load
+++ b/tests/sctp/fb-deny-label-load
@@ -1,7 +1,14 @@
 #!/bin/sh
 
+SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
+HAS_IPV6="$SCRIPT_DIR/../has_ipv6"
+
 netlabelctl map del default
 netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+if "$HAS_IPV6"; then
 netlabelctl map add default address:::/0 protocol:unlbl
+fi
 netlabelctl unlbl add interface:lo address:127.0.0.0/8 label:system_u:object_r:netlabel_sctp_peer_t:s0
+if "$HAS_IPV6"; then
 netlabelctl unlbl add interface:lo address:::1/128 label:system_u:object_r:deny_assoc_sctp_peer_t:s0
+fi
diff --git a/tests/sctp/fb-label-flush b/tests/sctp/fb-label-flush
index 13573a8..c1ceeb5 100644
--- a/tests/sctp/fb-label-flush
+++ b/tests/sctp/fb-label-flush
@@ -1,6 +1,11 @@
 #!/bin/sh
 
+SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
+HAS_IPV6="$SCRIPT_DIR/../has_ipv6"
+
 netlabelctl map del default
 netlabelctl map add default protocol:unlbl
 netlabelctl unlbl del interface:lo address:127.0.0.0/8 label:system_u:object_r:netlabel_sctp_peer_t:s0
+if "$HAS_IPV6"; then
 netlabelctl unlbl del interface:lo address:::1/128 label:system_u:object_r:netlabel_sctp_peer_t:s0
+fi
diff --git a/tests/sctp/fb-label-load b/tests/sctp/fb-label-load
index a501515..065ec34 100644
--- a/tests/sctp/fb-label-load
+++ b/tests/sctp/fb-label-load
@@ -1,8 +1,15 @@
 #!/bin/sh
 
+SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
+HAS_IPV6="$SCRIPT_DIR/../has_ipv6"
+
 netlabelctl map del default
 netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+if "$HAS_IPV6"; then
 netlabelctl map add default address:::/0 protocol:unlbl
+fi
 netlabelctl unlbl add interface:lo address:127.0.0.0/8 label:system_u:object_r:netlabel_sctp_peer_t:s0
+if "$HAS_IPV6"; then
 netlabelctl unlbl add interface:lo address:::1/128 label:system_u:object_r:netlabel_sctp_peer_t:s0
+fi
 #netlabelctl -p unlbl list
diff --git a/tests/sctp/iptables-flush b/tests/sctp/iptables-flush
index e74271a..112ae79 100644
--- a/tests/sctp/iptables-flush
+++ b/tests/sctp/iptables-flush
@@ -1,4 +1,9 @@
 #!/bin/sh
 # Flush the security table after IPv4 and IPv6 tests.
+SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
+HAS_IPV6="$SCRIPT_DIR/../has_ipv6"
+
 iptables -t security -F
+if "$HAS_IPV6"; then
 ip6tables -t security -F
+fi
diff --git a/tests/sctp/iptables-load b/tests/sctp/iptables-load
index 9dac576..1a91e19 100644
--- a/tests/sctp/iptables-load
+++ b/tests/sctp/iptables-load
@@ -1,9 +1,14 @@
 #!/bin/sh
 ############################ SECMARK IPTABLE ENTRIES ########################
 #
+SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
+HAS_IPV6="$SCRIPT_DIR/../has_ipv6"
+
 # Flush the security table first:
 iptables -t security -F
+if "$HAS_IPV6"; then
 ip6tables -t security -F
+fi
 
 #-------------- INPUT IP Stream --------------------#
 # These rules will replace the above context if sctp ports 1024:1035 are found in the packets:
@@ -11,9 +16,11 @@ iptables -t security -A INPUT -i lo -p sctp -m multiport --port 1024:1035 -j SEC
 
 iptables -t security -A INPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --save
 
+if "$HAS_IPV6"; then
 ip6tables -t security -A INPUT -i lo -p sctp -m multiport --port 1024:1035 -j SECMARK --selctx system_u:object_r:test_sctp_server_packet_t:s0
 
 ip6tables -t security -A INPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --save
+fi
 
 #-------------- OUTPUT IP Stream --------------------#
 # These rules will replace the above context if sctp ports 1024:1035 are found in the packets:
@@ -21,7 +28,9 @@ iptables -t security -A OUTPUT -o lo -p sctp -m multiport --port 1024:1035 -j SE
 
 iptables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --save
 
+if "$HAS_IPV6"; then
 ip6tables -t security -A OUTPUT -o lo -p sctp -m multiport --port 1024:1035 -j SECMARK --selctx system_u:object_r:test_sctp_server_packet_t:s0
 
 ip6tables -t security -A OUTPUT -m state --state ESTABLISHED,RELATED -j CONNSECMARK --save
+fi
 
diff --git a/tests/sctp/nftables-flush b/tests/sctp/nftables-flush
index 7d62b8d..d0fee0c 100644
--- a/tests/sctp/nftables-flush
+++ b/tests/sctp/nftables-flush
@@ -1,2 +1 @@
 delete table ip security
-delete table ip6 security
diff --git a/tests/sctp/nftables-ipv6-flush b/tests/sctp/nftables-ipv6-flush
new file mode 100644
index 0000000..0c9b69a
--- /dev/null
+++ b/tests/sctp/nftables-ipv6-flush
@@ -0,0 +1 @@
+delete table ip6 security
diff --git a/tests/sctp/nftables-ipv6.load b/tests/sctp/nftables-ipv6.load
new file mode 100644
index 0000000..1268140
--- /dev/null
+++ b/tests/sctp/nftables-ipv6.load
@@ -0,0 +1,33 @@
+# IPv6 secmark rules for SCTP tests (loaded only when IPv6 is enabled).
+
+add table ip6 security
+
+table ip6 security {
+
+	secmark sctp_server {
+		"system_u:object_r:test_sctp_server_packet_t:s0"
+	}
+
+	map secmapping_in_out {
+		type inet_service : secmark
+		elements = { 1035 : "sctp_server" }
+	}
+
+	chain input {
+		type filter hook input priority 0;
+
+		ct state new meta secmark set sctp dport map @secmapping_in_out
+		ct state new ct secmark set meta secmark
+
+		ct state established,related meta secmark set ct secmark
+	}
+
+	chain output {
+		type filter hook output priority 0;
+
+		ct state new meta secmark set sctp dport map @secmapping_in_out
+		ct state new ct secmark set meta secmark
+
+		ct state established,related meta secmark set ct secmark
+	}
+}
diff --git a/tests/sctp/nftables-load b/tests/sctp/nftables-load
index 2cac3bb..56803b6 100644
--- a/tests/sctp/nftables-load
+++ b/tests/sctp/nftables-load
@@ -1,7 +1,8 @@
 # Based on NFT project example. Requires kernel >= 4.20 and nft >= 0.9.3
+#
+# IPv6 rules are in nftables-ipv6.load and loaded only when IPv6 is enabled.
 
 add table ip security
-add table ip6 security
 
 table ip security {
 
@@ -36,33 +37,3 @@ table ip security {
 		ct state established,related meta secmark set ct secmark
 	}
 }
-
-table ip6 security {
-
-	secmark sctp_server {
-		"system_u:object_r:test_sctp_server_packet_t:s0"
-	}
-
-	map secmapping_in_out {
-		type inet_service : secmark
-		elements = { 1035 : "sctp_server" }
-	}
-
-	chain input {
-		type filter hook input priority 0;
-
-		ct state new meta secmark set sctp dport map @secmapping_in_out
-		ct state new ct secmark set meta secmark
-
-		ct state established,related meta secmark set ct secmark
-	}
-
-	chain output {
-		type filter hook output priority 0;
-
-		ct state new meta secmark set sctp dport map @secmapping_in_out
-		ct state new ct secmark set meta secmark
-
-		ct state established,related meta secmark set ct secmark
-	}
-}
diff --git a/tests/sctp/sctp_bindx.c b/tests/sctp/sctp_bindx.c
index 74bf985..a37a458 100644
--- a/tests/sctp/sctp_bindx.c
+++ b/tests/sctp/sctp_bindx.c
@@ -3,8 +3,9 @@
 static void usage(char *progname)
 {
 	fprintf(stderr,
-		"usage:  %s [-r] [-v] stream|seq port\n"
+		"usage:  %s [-4] [-r] [-v] stream|seq port\n"
 		"\nWhere:\n\t"
+		"-4      Use two IPv4 loopback addresses.\n\t"
 		"-r      After two bindx ADDs, remove one with bindx REM.\n\t"
 		"-v      Print context information.\n\t"
 		"        The default is to add IPv4 and IPv6 loopback addrs.\n\t"
@@ -17,15 +18,19 @@ static void usage(char *progname)
 int main(int argc, char **argv)
 {
 	int opt, type, sock, result;
-	struct sockaddr_in ipv4;
+	struct sockaddr_in ipv4, ipv4_extra;
+	struct sockaddr *extra_addr;
 	struct sockaddr_in6 ipv6;
 	unsigned short port;
-	bool rem = false;
+	bool rem = false, ipv4_only = false;
 	bool verbose = false;
 	char *context;
 
-	while ((opt = getopt(argc, argv, "rv")) != -1) {
+	while ((opt = getopt(argc, argv, "4rv")) != -1) {
 		switch (opt) {
+		case '4':
+			ipv4_only = true;
+			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -58,7 +63,7 @@ int main(int argc, char **argv)
 		free(context);
 	}
 
-	sock = socket(PF_INET6, type, IPPROTO_SCTP);
+	sock = socket(ipv4_only ? PF_INET : PF_INET6, type, IPPROTO_SCTP);
 	if (sock < 0) {
 		perror("socket");
 		exit(1);
@@ -88,19 +93,27 @@ int main(int argc, char **argv)
 	ipv6.sin6_port = htons(port);
 	ipv6.sin6_addr = in6addr_loopback;
 
-	result = sctp_bindx(sock, (struct sockaddr *)&ipv6, 1,
+	if (ipv4_only) {
+		ipv4_extra = ipv4;
+		ipv4_extra.sin_addr.s_addr = htonl(0x7f000002);
+		extra_addr = (struct sockaddr *)&ipv4_extra;
+	} else {
+		extra_addr = (struct sockaddr *)&ipv6;
+	}
+
+	result = sctp_bindx(sock, extra_addr, 1,
 			    SCTP_BINDX_ADD_ADDR);
 	if (result < 0) {
-		perror("sctp_bindx ADD - ipv6");
+		perror("sctp_bindx ADD - second address");
 		close(sock);
 		exit(3);
 	}
 
 	if (verbose)
-		printf("sctp_bindx ADD - ipv6\n");
+		printf("sctp_bindx ADD - %s\n", ipv4_only ? "127.0.0.2" : "::1");
 
 	if (rem) {
-		result = sctp_bindx(sock, (struct sockaddr *)&ipv6, 1,
+		result = sctp_bindx(sock, extra_addr, 1,
 				    SCTP_BINDX_REM_ADDR);
 		if (result < 0) {
 			perror("sctp_bindx - REM");
@@ -108,7 +121,7 @@ int main(int argc, char **argv)
 			exit(4);
 		}
 		if (verbose)
-			printf("sctp_bindx REM - ipv6\n");
+			printf("sctp_bindx REM - %s\n", ipv4_only ? "127.0.0.2" : "::1");
 	}
 
 	close(sock);
diff --git a/tests/sctp/test b/tests/sctp/test
index 5626ab8..21b636e 100755
--- a/tests/sctp/test
+++ b/tests/sctp/test
@@ -104,6 +104,27 @@ BEGIN {
             $test_count += 8;
             $test_nft = 1;
         }
+
+        # Determine if IPv6 is enabled on loopback.
+        $test_ipv6 = system("$basedir/../has_ipv6") == 0 ? 1 : 0;
+
+        if ( !$test_ipv6 ) {
+            $test_count -= 12;
+
+            if ($test_calipso) {
+                $test_count -= 13;
+                if ($test_clpeeloff) {
+                    $test_count -= 6;
+                }
+                $test_calipso = 0;
+            }
+            if ($test_iptables) {
+                $test_count -= 4;
+            }
+            if ($test_nft) {
+                $test_count -= 4;
+            }
+        }
     }
 
     plan tests => $test_count;
@@ -113,6 +134,13 @@ sub server_start {
     my ( $runcon_args, $prog, $args ) = @_;
     my $pid;
 
+    # Select the family before entering the confined server domain.
+    if ( !$test_ipv6
+        && ( $prog eq "sctp_server" || $prog eq "sctp_peeloff_server" ) )
+    {
+        $args = "-4 $args";
+    }
+
     system("mkfifo $basedir/flag");
 
     if ( ( $pid = fork() ) == 0 ) {
@@ -164,16 +192,19 @@ $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -n -e nopeer seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
-# Verify that authorized client can communicate with the server SEQ->STREAM.
-$result = system
-  "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 1035";
-ok( $result eq 0 );
+if ($test_ipv6) {
+
+    # Verify that authorized client can communicate with the server SEQ->STREAM.
+    $result = system
+"runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 1035";
+    ok( $result eq 0 );
 
 # Verify that the client cannot communicate with server when using port < 1024 STREAM->STREAM.
 # deny sctp_socket { name_connect }
-$result = system
+    $result = system
 "runcon -t test_sctp_client_t -- $basedir/sctp_client $v -e nopeer stream ::1 1023 2>&1";
-ok( $result >> 8 eq 8 );
+    ok( $result >> 8 eq 8 );
+}
 
 # Kill the stream server.
 server_end($pid);
@@ -194,15 +225,17 @@ $result = system
 "runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
-$result =
-  system
-  "runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v seq ::1 1035";
-ok( $result eq 0 );
+if ($test_ipv6) {
+    $result =
+      system
+      "runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v seq ::1 1035";
+    ok( $result eq 0 );
 
-$result =
-  system
+    $result =
+      system
 "runcon -t test_sctp_deny_connectx_t $basedir/sctp_connectx $v seq ::1 1035 2>&1";
-ok( $result >> 8 eq 7 );
+    ok( $result >> 8 eq 7 );
+}
 
 #
 ########################### SCTP_SENDMSG_CONNECT #############################
@@ -215,28 +248,33 @@ $result =
 "runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v -n seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
-$result =
-  system
+if ($test_ipv6) {
+    $result =
+      system
 "runcon -t test_sctp_deny_connectx_t $basedir/sctp_connectx $v -n seq ::1 1035 2>&1";
-ok( $result >> 8 eq 8 );
+    ok( $result >> 8 eq 8 );
+}
 
 #
 ################################ BINDX #######################################
 #
 # net/sctp/socket.c sctp_setsockopt_bindx() SCTP_SOCKOPT_BINDX_ADD
 print "# Testing bindx.\n";
+$bindx_family = $test_ipv6 ? "" : "-4";
 
 $result =
-  system "runcon -t test_sctp_bindx_t $basedir/sctp_bindx $v -r stream 1035";
+  system
+"runcon -t test_sctp_bindx_t $basedir/sctp_bindx $bindx_family $v -r stream 1035";
 ok( $result eq 0 );
 
 $result =
-  system "runcon -t test_sctp_bindx_t $basedir/sctp_bindx $v -r seq 1035";
+  system
+"runcon -t test_sctp_bindx_t $basedir/sctp_bindx $bindx_family $v -r seq 1035";
 ok( $result eq 0 );
 
 $result =
   system
-  "runcon -t test_sctp_deny_bindx_t $basedir/sctp_bindx $v -r seq 1035 2>&1";
+"runcon -t test_sctp_deny_bindx_t $basedir/sctp_bindx $bindx_family $v -r seq 1035 2>&1";
 ok( $result >> 8 eq 2 );
 
 #
@@ -351,30 +389,33 @@ server_end($pid);
 # Start seq server.
 $pid = server_start( "-t test_sctp_server_t", "sctp_server", "$v seq 1035" );
 
-# Verify that authorized client can communicate with the server SEQ->SEQ.
-$result = system
+if ($test_ipv6) {
+
+    # Verify that authorized client can communicate with the server SEQ->SEQ.
+    $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035";
-ok( $result eq 0 );
+    ok( $result eq 0 );
 
-# Verify that authorized client can communicate with the server STREAM->SEQ.
-$result = system
+    # Verify that authorized client can communicate with the server STREAM->SEQ.
+    $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e system_u:object_r:netlabel_sctp_peer_t:s0 stream ::1 1035";
-ok( $result eq 0 );
+    ok( $result eq 0 );
 
 # Verify that a client using connect(2) without peer { recv } permission cannot communicate with the server SEQ->SEQ.
-$result = system
+    $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
-ok( $result >> 8 eq 6 );
+    ok( $result >> 8 eq 6 );
 
 # Verify that a client using sctp_connectx(3) without peer { recv } permission cannot communicate with the server SEQ->SEQ.
-$result = system
+    $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -x -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
-ok( $result >> 8 eq 6 );
+    ok( $result >> 8 eq 6 );
 
 # Verify that a client not using any connect without peer { recv } permission cannot communicate with the server SEQ->SEQ.
-$result = system
+    $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -n -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
-ok( $result >> 8 eq 13 );
+    ok( $result >> 8 eq 13 );
+}
 
 # Kill the seq server.
 server_end($pid);
@@ -396,10 +437,13 @@ $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e system_u:object_r:netlabel_sctp_peer_t:s0 stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
+if ($test_ipv6) {
+
 # Verify that the server is denied this association as the client will timeout on connect.
-$result = system
+    $result = system
 "runcon -t test_sctp_client_t -- $basedir/sctp_client $v -e system_u:object_r:deny_assoc_sctp_peer_t:s0 stream ::1 1035 2>&1";
-ok( $result >> 8 eq 6 );
+    ok( $result >> 8 eq 6 );
+}
 
 # Kill the seq server.
 server_end($pid);
@@ -1141,15 +1185,18 @@ sub test_tables {
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream 127.0.0.1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
+    if ($test_ipv6) {
+
  # Verify that authorized client can communicate with the server STREAM->STREAM.
-    $result = system
+        $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream ::1 1035";
-    ok( $result eq 0 );
+        ok( $result eq 0 );
 
 # Verify that a client without packet { recv } permission cannot communicate with the server STREAM->STREAM.
-    $result = system
+        $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream ::1 1035 2>&1";
-    ok( $result >> 8 eq 6 );
+        ok( $result >> 8 eq 6 );
+    }
 
     # Kill the stream server.
     server_end($pid);
@@ -1168,15 +1215,18 @@ sub test_tables {
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq 127.0.0.1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
-    # Verify that authorized client can communicate with the server SEQ->SEQ.
-    $result = system
+    if ($test_ipv6) {
+
+       # Verify that authorized client can communicate with the server SEQ->SEQ.
+        $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 1035";
-    ok( $result eq 0 );
+        ok( $result eq 0 );
 
 # Verify that a client without packet { recv } permission cannot communicate with the server SEQ->SEQ.
-    $result = system
+        $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq ::1 1035 2>&1";
-    ok( $result >> 8 eq 6 );
+        ok( $result >> 8 eq 6 );
+    }
 
     # Kill the seq server.
     server_end($pid);
@@ -1192,7 +1242,9 @@ if ($test_iptables) {
 if ($test_nft) {
     print "# Testing nftables (IPv4/IPv6).\n";
     system "nft -f $basedir/nftables-load";
+    system "nft -f $basedir/nftables-ipv6.load" if $test_ipv6;
     test_tables();
+    system "nft -f $basedir/nftables-ipv6-flush" if $test_ipv6;
     system "nft -f $basedir/nftables-flush";
 }
 
diff --git a/tmt/tests.fmf b/tmt/tests.fmf
index 08bd129..c9be59d 100644
--- a/tmt/tests.fmf
+++ b/tmt/tests.fmf
@@ -121,8 +121,6 @@
     - xfsprogs-devel
     - libuuid-devel
     - e2fsprogs
-    - f2fs-tools
-    - jfsutils
     - dosfstools
     - btrfs-progs
     - rdma-core-devel
-- 
2.55.0

