Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED607397E85
	for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671926; cv=none; b=Nf+SK1hUVvtV4Ej2IAD6cjrFfmwXcYmX6RnPS+CuPZsrLy7KpR63dH2uyb+s8vJYyIJarx4LoA9duIN9Zd5yLA7Z4vsNYlkZPq44Y71S4UYWws8hQBzkAysYX1jfEHancZsK3dHDZIt1Yl76wz4ob44zPrA7fMUjUtXgPUCGTRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671926; c=relaxed/simple;
	bh=8nryjJ91c3MJhHfGMteTyhyHvZEszSn2x8iEeGjHKBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R1KZ/MrhMBDg6U2I4/W3CEiYkP9hpYqlWADmvftRKa9wuvmdZotR0lQSXyLUWhFjZbAxLEjVPUc6/hZ1jf/VyC4+5hnuYV8HM9n0r1VZ5UMlWkE2Pi20XPWMqH0wwHEAWRTwN5ACW2WCwzW9HiYtwn2wvBGLT2yBTO8txZYh024=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCNPQmAx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9QO4uld; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCNPQmAx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9QO4uld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783671922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1sIKfz1G+VCtsXt/avnWKgnhp3lIOGqYKJ+0rCp1+ng=;
	b=MCNPQmAxMBX6UyV0XvyGx48smu/nCF1Xmf9+JmmBU7aidtkOQriQ0hF6cgGc8OHb4N29LT
	mwu/06YuSWeNVWK/RaIE1PYG5QN8ttEgtEpJ7PCLqUyZNwQdQeW8PXqaYVEps3n7deCogX
	1+gmR6tvu7akZZ+vCZbUFlLvKw2vcnU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-2PbVZR0xMmCWqna4gzxhJA-1; Fri, 10 Jul 2026 04:25:20 -0400
X-MC-Unique: 2PbVZR0xMmCWqna4gzxhJA-1
X-Mimecast-MFC-AGG-ID: 2PbVZR0xMmCWqna4gzxhJA_1783671919
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-475e540a0ffso344918f8f.3
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2026 01:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783671919; x=1784276719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1sIKfz1G+VCtsXt/avnWKgnhp3lIOGqYKJ+0rCp1+ng=;
        b=U9QO4uld5pu4rZJDp2QTWx2iO2rkdnJ8bCfzqW9AGUN8B/b5LAn1/JZaTKKxKS1i1r
         Ehxxi7H5aRx1S4IXiwIkJA1QGqce1k7EG6wqPr71dnpv3GvJnNlwxCadLdtIfPV9y2+U
         qKz8xt6LtkylU3VbaJ/C7WiKgTxJhKC1vD177kV1m0uHg/T1KQ7vMPeX6/r0m2qPL6Ka
         x7kfVAjU4L+42ootUtKQexesnS0eXP3qmPbI9lF+2qJGp45fuQrUFlZ1hfa26qb8vOM9
         gKPjYAY5br/TCL4XLjFJoFgEY7w8P0OU1AyerApbrsserq/vFgP2AbkVBc46MK+icmD7
         aFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783671919; x=1784276719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1sIKfz1G+VCtsXt/avnWKgnhp3lIOGqYKJ+0rCp1+ng=;
        b=Lc2kMvzQxFPpKm0nwYEYIJ6ZDezueJlFRk0eSISeGvkVszwk2YWljL5vUWBH9xAeqr
         5t3CMblcvusyM+fmugiVKchaXCJmtH3AF2Px1tZ8PqmIPEKZ79qtrAN8VvJm0kPM22NP
         sGrJZ1UAh0GVcTuUmZcnYLjXJnsieGunlI4TJMxqtU/rf/bcP/AHK3BBRL2taZ4E0qQX
         TtU+8y3l2kw3CVY5vLP7xGccNkeIMXcBTrX65EDRjRFN2NNM+kWd4/DStvO8wEUdc5ms
         BaHIAbEfhXZ4RGC+ORu4GYdLQTkRjG/FknXRmJ3gBvRfpUZjH3oc6k3dFp+XnR8Y2oNe
         gBVg==
X-Gm-Message-State: AOJu0Yzbu0/dJioBl5yyi3M2TNIM9fXc2o02VvqhC+KnamvvpAqcz1qA
	V0hEax+/vdyw7+pLeNaKV+Cfu6Ed0Cx/knWXOph6rMuhVrdOeYotOw2X1wKtSo8B0v30DG1Y18h
	4pLC0DDQ83Astb3ZSpPu4H4XnQf9nnH63hmy0vGcIPx51TUORA7bvDdcrOXNmft6TA5X4cyPqWZ
	fcl22vWmGhsQtMTej0q7ktrENZHh6bx3kafq4H4l8zKpY=
X-Gm-Gg: AfdE7ck2RdGYCaSlhEn0y57Jzy0d7nRb7yfBJwG4eVhdVIzZJ44RJPyb10HaNiZhw+l
	ZV6HO5FQjEUbGnshtORxG/bVDbSqTSwK70z39FFWVhUoqwBFkqzAzGoAbJg+B6Ymlvja2wZsJ33
	8BFnD59LsKmTK8Rzl0AL4J/DPDF/HYJhX2bljsk1bXbllYircP4RLdME/od06stZQ78lnsgbj4z
	vgncv2d4t9B+/D7AB5cFuY536TkeFnYwX5d1mbpUNF2jE2oMR9UFJi9IlNWL7OeFUWLpfE66ib2
	IFjpu574d+CFThmUhRZrke50bRzpCfwDS2Q56mez/2wogzhTKwkxfdIeJQ0T2a9Gw6cT9EPRMOh
	vw7S73+UfOhV1k3sMR1zEkg9I/Qg8tNIxsukvOXJpDyH/kk0PVE/2Y+hCj+ZSUjPI8h0=
X-Received: by 2002:a5d:5848:0:b0:478:1a24:912d with SMTP id ffacd0b85a97d-47df07a2e71mr12028378f8f.57.1783671918791;
        Fri, 10 Jul 2026 01:25:18 -0700 (PDT)
X-Received: by 2002:a5d:5848:0:b0:478:1a24:912d with SMTP id ffacd0b85a97d-47df07a2e71mr12028239f8f.57.1783671917150;
        Fri, 10 Jul 2026 01:25:17 -0700 (PDT)
Received: from jonderka-thinkpadp16vgen1.rmtcz.csb (90-177-145-101.rck.o2.cz. [90.177.145.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm58280765f8f.27.2026.07.10.01.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 01:25:16 -0700 (PDT)
From: Jan Onderka <jonderka@redhat.com>
To: selinux@vger.kernel.org
Cc: jonderka@redhat.com
Subject: [PATCH] tests: make IPv6 subtests optional on IPv4-only systems
Date: Fri, 10 Jul 2026 10:25:14 +0200
Message-ID: <20260710082514.452700-1-jonderka@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip or adapt IPv6-dependent subtests when the running system does not
have usable IPv6 on loopback.

Problem
-------
Several subtests assume IPv6 is available: they bind or connect to ::1,
load ip6tables/nftables IPv6 rules, or create AF_INET6/SCTP IPv6 sockets.
On IPv4-only systems (for example RHIVOS kernels built without usable
IPv6, or hosts with net.ipv6.conf.*.disable_ipv6=1), these subtests
hang or fail in ways that block the entire make test run.

Change
------
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

Justification
-------------
IPv6 is optional in many deployment targets. The testsuite should detect
runtime IPv6 usability and skip only the affected subtests instead of
assuming ::1 and ip6tables always work. This mirrors how other optional
features are handled in the tree and keeps the fix self-contained in
selinux-testsuite.

Testing
-------
Verified on RHIVOS (no /proc/net/if_inet6):

  - inet_socket/tcp and inet_socket/udp complete successfully
  - extended_socket_class IPv6 cases are skipped
  - make test progresses past former IPv6 hang points

Verified on a host with IPv6 enabled:

  - IPv6 subtests still run and pass

Signed-off-by: Jan Onderka <jonderka@redhat.com>
---
 tests/extended_socket_class/test      | 17 ++++++++++
 tests/has_ipv6                        | 19 +++++++++++
 tests/inet_socket/ipsec-load          |  4 +++
 tests/inet_socket/iptables-flush      |  9 +++--
 tests/inet_socket/iptables-load       |  5 +++
 tests/inet_socket/nftables-flush      |  1 -
 tests/inet_socket/nftables-ipv6-flush |  1 +
 tests/inet_socket/nftables-ipv6.load  | 35 +++++++++++++++++++
 tests/inet_socket/nftables-load       | 35 ++-----------------
 tests/inet_socket/server.c            | 19 ++++++++++-
 tests/inet_socket/test                | 49 +++++++++++++++++++++------
 tests/sctp/fb-deny-label-flush        |  5 +++
 tests/sctp/fb-deny-label-load         |  7 ++++
 tests/sctp/fb-label-flush             |  5 +++
 tests/sctp/fb-label-load              |  7 ++++
 tests/sctp/iptables-flush             |  5 +++
 tests/sctp/iptables-load              |  9 +++++
 tests/sctp/nftables-flush             |  1 -
 tests/sctp/nftables-ipv6-flush        |  1 +
 tests/sctp/nftables-ipv6.load         | 33 ++++++++++++++++++
 tests/sctp/nftables-load              | 33 ++----------------
 tests/sctp/sctp_bindx.c               | 46 +++++++++++++++++--------
 tests/sctp/sctp_common.c              | 15 ++++++++
 tests/sctp/sctp_common.h              |  2 ++
 tests/sctp/sctp_peeloff_server.c      |  2 +-
 tests/sctp/sctp_server.c              |  2 +-
 tests/sctp/test                       | 42 +++++++++++++++++++++++
 27 files changed, 312 insertions(+), 97 deletions(-)
 create mode 100755 tests/has_ipv6
 create mode 100644 tests/inet_socket/nftables-ipv6-flush
 create mode 100644 tests/inet_socket/nftables-ipv6.load
 create mode 100644 tests/sctp/nftables-ipv6-flush
 create mode 100644 tests/sctp/nftables-ipv6.load

diff --git a/tests/extended_socket_class/test b/tests/extended_socket_class/test
index 1e6299f..9a6ea16 100755
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
 
@@ -46,6 +57,8 @@ $result = system(
 );
 ok($result);
 
+if ($test_ipv6) {
+
 # Verify that test_icmp_socket_t can create an ICMPv6 socket.
 $result = system(
 "runcon -t test_icmp_socket_t -- $basedir/sockcreate inet6 dgram icmpv6 2>&1"
@@ -57,6 +70,7 @@ $result = system(
 "runcon -t test_no_icmp_socket_t -- $basedir/sockcreate inet6 dgram icmpv6 2>&1"
 );
 ok($result);
+}
 
 # Restore to the kernel defaults - no one allowed to create ICMP sockets.
 system("echo 1 0 > /proc/sys/net/ipv4/ping_group_range");
@@ -87,6 +101,8 @@ if ($test_sctp) {
     );
     ok($result);
 
+    if ($test_ipv6) {
+
     # Verify that test_sctp_socket_t can create an IPv6 stream SCTP socket.
     $result = system(
 "runcon -t test_sctp_socket_t -- $basedir/sockcreate inet6 stream sctp 2>&1"
@@ -110,6 +126,7 @@ if ($test_sctp) {
 "runcon -t test_no_sctp_socket_t -- $basedir/sockcreate inet6 seqpacket sctp 2>&1"
     );
     ok($result);
+    }
 }
 
 if ($test_bluetooth) {
diff --git a/tests/has_ipv6 b/tests/has_ipv6
new file mode 100755
index 0000000..21f12e7
--- /dev/null
+++ b/tests/has_ipv6
@@ -0,0 +1,19 @@
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
+exit 0
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
index 63b6849..c4e4432 100644
--- a/tests/inet_socket/server.c
+++ b/tests/inet_socket/server.c
@@ -10,6 +10,8 @@
 #include <stdio.h>
 #include <stdbool.h>
 
+#include <unistd.h>
+
 #ifndef SO_PEERSEC
 #define SO_PEERSEC 31
 #endif
@@ -36,6 +38,21 @@ void usage(char *progname)
 	exit(1);
 }
 
+static bool ipv6_enabled(void)
+{
+	int fd;
+
+	if (access("/proc/net/if_inet6", F_OK) != 0)
+		return false;
+
+	fd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return false;
+
+	close(fd);
+	return true;
+}
+
 int main(int argc, char **argv)
 {
 	int sock, result, opt, sockprotocol, on = 1;
@@ -64,7 +81,7 @@ int main(int argc, char **argv)
 
 	memset(&hints, 0, sizeof(struct addrinfo));
 	hints.ai_flags = AI_PASSIVE;
-	hints.ai_family = AF_INET6;
+	hints.ai_family = ipv6_enabled() ? AF_INET6 : AF_INET;
 
 	if (!strcmp(argv[optind], "tcp")) {
 		hints.ai_socktype = SOCK_STREAM;
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 4cc3852..01acf8a 100755
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
 
@@ -329,7 +348,7 @@ if ($test_ipsec) {
 "runcon -t test_inet_bad_client_t -- $basedir/client $proto 127.0.0.1 65535 2>&1";
     ok( $result >> 8 eq $fail_value2 );
 
-    if ($is_stream) {
+    if ($is_stream && $test_ipv6) {
 
         # Verify that authorized client can communicate with the server.
         $result =
@@ -338,15 +357,18 @@ if ($test_ipsec) {
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
+    if ( not $is_stream && $test_ipv6 ) {
 
    # Start the server for IPSEC test using IPv6 but do not request peer context.
         $pid = server_start( "-t test_inet_server_t", "-n $proto 65535" );
@@ -382,15 +404,18 @@ sub test_tables {
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
@@ -406,7 +431,9 @@ if ($test_iptables) {
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
index 74bf985..2240404 100644
--- a/tests/sctp/sctp_bindx.c
+++ b/tests/sctp/sctp_bindx.c
@@ -1,4 +1,5 @@
 #include "sctp_common.h"
+#include <errno.h>
 
 static void usage(char *progname)
 {
@@ -22,6 +23,7 @@ int main(int argc, char **argv)
 	unsigned short port;
 	bool rem = false;
 	bool verbose = false;
+	bool ipv6_bound = false;
 	char *context;
 
 	while ((opt = getopt(argc, argv, "rv")) != -1) {
@@ -58,7 +60,7 @@ int main(int argc, char **argv)
 		free(context);
 	}
 
-	sock = socket(PF_INET6, type, IPPROTO_SCTP);
+	sock = socket(ipv6_enabled() ? PF_INET6 : PF_INET, type, IPPROTO_SCTP);
 	if (sock < 0) {
 		perror("socket");
 		exit(1);
@@ -88,27 +90,41 @@ int main(int argc, char **argv)
 	ipv6.sin6_port = htons(port);
 	ipv6.sin6_addr = in6addr_loopback;
 
+	if (ipv6_enabled()) {
 	result = sctp_bindx(sock, (struct sockaddr *)&ipv6, 1,
 			    SCTP_BINDX_ADD_ADDR);
 	if (result < 0) {
-		perror("sctp_bindx ADD - ipv6");
-		close(sock);
-		exit(3);
+		if (verbose)
+			printf("sctp_bindx ADD - ipv6 not available\n");
+	} else {
+		ipv6_bound = true;
+		if (verbose)
+			printf("sctp_bindx ADD - ipv6\n");
+	}
 	}
-
-	if (verbose)
-		printf("sctp_bindx ADD - ipv6\n");
 
 	if (rem) {
-		result = sctp_bindx(sock, (struct sockaddr *)&ipv6, 1,
-				    SCTP_BINDX_REM_ADDR);
-		if (result < 0) {
-			perror("sctp_bindx - REM");
-			close(sock);
-			exit(4);
+		if (ipv6_bound) {
+			result = sctp_bindx(sock, (struct sockaddr *)&ipv6, 1,
+					    SCTP_BINDX_REM_ADDR);
+			if (result < 0) {
+				perror("sctp_bindx - REM");
+				close(sock);
+				exit(4);
+			}
+			if (verbose)
+				printf("sctp_bindx REM - ipv6\n");
+		} else {
+			result = sctp_bindx(sock, (struct sockaddr *)&ipv4, 1,
+					    SCTP_BINDX_REM_ADDR);
+			if (result < 0) {
+				perror("sctp_bindx - REM");
+				close(sock);
+				exit(4);
+			}
+			if (verbose)
+				printf("sctp_bindx REM - ipv4\n");
 		}
-		if (verbose)
-			printf("sctp_bindx REM - ipv6\n");
 	}
 
 	close(sock);
diff --git a/tests/sctp/sctp_common.c b/tests/sctp/sctp_common.c
index d10225c..3adce02 100644
--- a/tests/sctp/sctp_common.c
+++ b/tests/sctp/sctp_common.c
@@ -344,3 +344,18 @@ int handle_event(void *buf, char *cmp_addr, sctp_assoc_t *assoc_id,
 
 	return EVENT_OK;
 }
+
+bool ipv6_enabled(void)
+{
+	int fd;
+
+	if (access("/proc/net/if_inet6", F_OK) != 0)
+		return false;
+
+	fd = socket(AF_INET6, SOCK_DGRAM, 0);
+	if (fd < 0)
+		return false;
+
+	close(fd);
+	return true;
+}
diff --git a/tests/sctp/sctp_common.h b/tests/sctp/sctp_common.h
index 3a2545a..9f21d3e 100644
--- a/tests/sctp/sctp_common.h
+++ b/tests/sctp/sctp_common.h
@@ -36,3 +36,5 @@ void print_ip_option(int fd, bool ipv4, char *text);
 int set_subscr_events(int fd, int data_io, int assoc, int addr, int shutd);
 int handle_event(void *buf, char *cmp_addr, sctp_assoc_t *assoc_id,
 		 bool verbose, char *text);
+
+bool ipv6_enabled(void);
diff --git a/tests/sctp/sctp_peeloff_server.c b/tests/sctp/sctp_peeloff_server.c
index 3e48df7..e7b33c5 100644
--- a/tests/sctp/sctp_peeloff_server.c
+++ b/tests/sctp/sctp_peeloff_server.c
@@ -59,7 +59,7 @@ int main(int argc, char **argv)
 	if (ipv4)
 		hints.ai_family = AF_INET;
 	else
-		hints.ai_family = AF_INET6;
+		hints.ai_family = ipv6_enabled() ? AF_INET6 : AF_INET;
 
 	/* sctp_peeloff(3) must be from 1 to Many style socket */
 	hints.ai_socktype = SOCK_SEQPACKET;
diff --git a/tests/sctp/sctp_server.c b/tests/sctp/sctp_server.c
index a7832eb..6edadcf 100644
--- a/tests/sctp/sctp_server.c
+++ b/tests/sctp/sctp_server.c
@@ -74,7 +74,7 @@ int main(int argc, char **argv)
 	if (ipv4)
 		hints.ai_family = AF_INET;
 	else
-		hints.ai_family = AF_INET6;
+		hints.ai_family = ipv6_enabled() ? AF_INET6 : AF_INET;
 
 	if (!strcmp(argv[optind], "stream"))
 		hints.ai_socktype = SOCK_STREAM;
diff --git a/tests/sctp/test b/tests/sctp/test
index 5626ab8..1e547a3 100755
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
@@ -164,6 +185,8 @@ $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -n -e nopeer seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
+if ($test_ipv6) {
+
 # Verify that authorized client can communicate with the server SEQ->STREAM.
 $result = system
   "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 1035";
@@ -174,6 +197,7 @@ ok( $result eq 0 );
 $result = system
 "runcon -t test_sctp_client_t -- $basedir/sctp_client $v -e nopeer stream ::1 1023 2>&1";
 ok( $result >> 8 eq 8 );
+}
 
 # Kill the stream server.
 server_end($pid);
@@ -194,6 +218,7 @@ $result = system
 "runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
+if ($test_ipv6) {
 $result =
   system
   "runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v seq ::1 1035";
@@ -203,6 +228,7 @@ $result =
   system
 "runcon -t test_sctp_deny_connectx_t $basedir/sctp_connectx $v seq ::1 1035 2>&1";
 ok( $result >> 8 eq 7 );
+}
 
 #
 ########################### SCTP_SENDMSG_CONNECT #############################
@@ -215,10 +241,12 @@ $result =
 "runcon -t test_sctp_connectx_t $basedir/sctp_connectx $v -n seq 127.0.0.1 1035";
 ok( $result eq 0 );
 
+if ($test_ipv6) {
 $result =
   system
 "runcon -t test_sctp_deny_connectx_t $basedir/sctp_connectx $v -n seq ::1 1035 2>&1";
 ok( $result >> 8 eq 8 );
+}
 
 #
 ################################ BINDX #######################################
@@ -351,6 +379,8 @@ server_end($pid);
 # Start seq server.
 $pid = server_start( "-t test_sctp_server_t", "sctp_server", "$v seq 1035" );
 
+if ($test_ipv6) {
+
 # Verify that authorized client can communicate with the server SEQ->SEQ.
 $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035";
@@ -375,6 +405,7 @@ ok( $result >> 8 eq 6 );
 $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -n -e system_u:object_r:netlabel_sctp_peer_t:s0 seq ::1 1035 2>&1";
 ok( $result >> 8 eq 13 );
+}
 
 # Kill the seq server.
 server_end($pid);
@@ -396,10 +427,13 @@ $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e system_u:object_r:netlabel_sctp_peer_t:s0 stream 127.0.0.1 1035";
 ok( $result eq 0 );
 
+if ($test_ipv6) {
+
 # Verify that the server is denied this association as the client will timeout on connect.
 $result = system
 "runcon -t test_sctp_client_t -- $basedir/sctp_client $v -e system_u:object_r:deny_assoc_sctp_peer_t:s0 stream ::1 1035 2>&1";
 ok( $result >> 8 eq 6 );
+}
 
 # Kill the seq server.
 server_end($pid);
@@ -1141,6 +1175,8 @@ sub test_tables {
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream 127.0.0.1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
+    if ($test_ipv6) {
+
  # Verify that authorized client can communicate with the server STREAM->STREAM.
     $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer stream ::1 1035";
@@ -1150,6 +1186,7 @@ sub test_tables {
     $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer stream ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
+    }
 
     # Kill the stream server.
     server_end($pid);
@@ -1168,6 +1205,8 @@ sub test_tables {
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq 127.0.0.1 1035 2>&1";
     ok( $result >> 8 eq 6 );
 
+    if ($test_ipv6) {
+
     # Verify that authorized client can communicate with the server SEQ->SEQ.
     $result = system
 "runcon -t test_sctp_client_t $basedir/sctp_client $v -e nopeer seq ::1 1035";
@@ -1177,6 +1216,7 @@ sub test_tables {
     $result = system
 "runcon -t test_sctp_deny_peer_client_t -- $basedir/sctp_client $v -e nopeer seq ::1 1035 2>&1";
     ok( $result >> 8 eq 6 );
+    }
 
     # Kill the seq server.
     server_end($pid);
@@ -1192,7 +1232,9 @@ if ($test_iptables) {
 if ($test_nft) {
     print "# Testing nftables (IPv4/IPv6).\n";
     system "nft -f $basedir/nftables-load";
+    system "nft -f $basedir/nftables-ipv6.load" if $test_ipv6;
     test_tables();
+    system "nft -f $basedir/nftables-ipv6-flush" if $test_ipv6;
     system "nft -f $basedir/nftables-flush";
 }
 
-- 
2.55.0

