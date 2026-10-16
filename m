Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7B64CEE4F
	for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792163423; cv=none; b=ZkmyZqlNowlsRmvpFPFzcRkpIw7ZBDC+BMe1IdJui3nRhas0xPfwmJLL1QGNymq+S1YKHzW7D5RMhtgD54CCtIrQxPIH/yLseKiLAf3Km6GVkYb2lO2tmi9jw3VNHayEZz23GUK7CiHgBFGGdiQk7YfoidW/w6D9VPHDRlqCtFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792163423; c=relaxed/simple;
	bh=cRqu1TkRiR9liWwLaKr26cWHgbIEITMmLmWnAD4eEbU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eohnlggvBq9o+2hJ0dK8Qm4f+Ephlef+j3ph1gaPrpwh+1S66Z2xYbIFiMVgw2sE/ScrnkbESTo54paspDa7/C45eGKFicknQOikOTfGD4C9GzoZY0mEMwm1+0DdwUe/oqQNg0QjLoNx3AbFKT0R/tGAmfK1Z34hbA1h/PDil7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pL0NqgWU; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL0NqgWU"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so6960021eec.1
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2026 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792163421; x=1792768221; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oiXmEIsrp+h51CqyT3pTr+Wk/QvJ2YcIfbKMh+qwHWo=;
        b=pL0NqgWUl9pR5qwFz/MUpmEwk50MHju0PLiODbenamIg/VzDccMj0VfeFpkZrcg6p/
         tIDmmBzt3yUHkK/ClIjDJA1FnvDpmxqvERWk+oNqc69iBYJq4OwokIhrdmZ5ZVKyp3Z6
         E/4C4D2jZ19QOO/nupJsaKzDW41FQbNsej4v3Bc9sl5ESeso5NA27MOtkDDVJaWREdne
         F/WEYH+h+puJnNax+OmowYo/pN9kFUMeAswjD8EHaSofF4PLTg0id75NVsssqmSZOYGU
         l9IQIJ+F6cHFJHI9zzm9q1thvumu6vSytLsG+3nLWOOVhS5CLE51zUJR3zm10djTAjZX
         heOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792163421; x=1792768221;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oiXmEIsrp+h51CqyT3pTr+Wk/QvJ2YcIfbKMh+qwHWo=;
        b=njyNbGNsCQL3jZ9nT1i5MkMK5KhIa/uK2J18wlb64BITtHgFj7dUs56TAFkgiy2m16
         tt2P/2GgGOH7rndTZpx3ZT4nxakxv/amLBF+g74jjFqd9Cxs9szPgMGNjwn2J8qeY8o6
         R3nD2YLZn6TLZ8KryImnYS6q+Qb773IkqXbQpmeCxw8N+S8zxvuDut1OTZMH1dPor5HD
         8dKMIVW5E18m1+65l9eA/ciEYDO6K4WqpImFKc6V3u+VSJobhnymkXbjC/NQgjliAlXV
         Sm9PVeTY76tR0ZaoWEMaUVyYLWme4y63cvOTCUu0uVNIpm2kxRjKdbY7pot+RT1eIfNb
         RA5A==
X-Gm-Message-State: AFq9FYIb04O49QoDhWcTgpM0YOjqqLKcrxzgm10b5BAxP3c4n94Enab6
	wrAVqGNPWx445l9R/TldHei3og+cOro8b83iZOYYdcWLxbc5V0x6iNsEOfuX3Whj7cM=
X-Gm-Gg: AYBFou22FtrGRVIoCyHyUSDrxIxs7WWyvcicilP6zAkqeuUciQtKi7Z25bi5Ck9l3fn
	uzYBxgJDzNsIkOytqtJaeJprZitPnNxic7Lo3smUgyvr6eWpkLb6C1+l6OddVDtjUxSyKrQ7ziN
	7euvXL7Bqa//jZe5xo8HuD0smxrI97JhFTS2Io69Mf9no94ys96btiNPmQE0AvvGbAGzWUnKG+G
	/z/X0yXNw7kMj8cCVdQm6j0NFWYjrV1bYzjwLZ6JchKLo6naegkuMHtEHDcj8hk2o/hHdTCNZiZ
	w/FUME6pJiBf5gk4omRVqLDswDb8ipiP+fmExGmcAO9HrI57NDP59xwThMFJHeE7w8J3WWl8j71
	1qZahAeTEIPpKsqwVU7HzBeu8x7vSiT9QzTRu50SkgCbWVdJQvkhUqpTo4NB02eA3OkVZP25Lh/
	t2I7EL+x2RwvKu8epI8Ldl4MrmYJ8cSZBqUMPMHPLKo19BsIVdp62yDf9Z/1ay6y5JRHSGWW9ER
	6yupAGZQjotzxEd754/GxmnjTVY6xsazbtk0bsiJ2uH7P0C+WLhPpkKJNG4ep9tzlwcWOJblqNI
	zZna9Olcs4y4Txf9TTf5G/R6MhjOLZT+O2LVaHO7ohjnjYbzjmUCplLQ
X-Received: by 2002:a05:693c:810b:b0:35c:6366:1d52 with SMTP id 5a478bee46e88-361a1e4e992mr105325eec.21.1792163419976;
        Fri, 16 Oct 2026 08:10:19 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b100:ece0:b5:bb23:a54:ce61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a02b8sm7963416eec.17.2026.10.16.08.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:10:19 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnacek@gmail.com>
Subject: [PATCH testsuite] tests/inet_socket: test CALIPSO over the IPv6
 forwarding path
Date: Fri, 16 Oct 2026 12:10:16 -0300
Message-ID: <179216341681.27711.14564271122957760636@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The existing CALIPSO tests only run over loopback, so the code that
rewrites the IPv6 header of forwarded packets (calipso_skbuff_delattr()
and calipso_skbuff_setattr(), called from selinux_ip_forward()) is not
covered.

Add two subtests that build a client -- router -- server topology out
of network namespaces and send traffic through the router:

- the client labels its packets with CALIPSO and the router, mapped to
  unlabeled, removes the option;
- the client sends unlabeled packets and the router adds a CALIPSO
  option.

The first one catches the payload_len bug fixed by "calipso: update
payload_len when removing the CALIPSO option": without the fix the
server drops the forwarded packet as truncated (Ip6InTruncatedPkts).

Commands inside the namespaces use nsenter(1) as "ip netns exec" and
"ip -n" remount /sys, which is denied when running as sysadm_t.  The
policy now allows unlabeled_t traffic on the generic interface and
node, needed for the unlabeled packets the router forwards.

Tested on Fedora 44 (aarch64), as unconfined_t and sysadm_t:
- 6.19.10-300.fc44: the new removal subtest fails (udp, tcp, mptcp),
  the new addition subtest passes;
- 7.3-rc6 with the fix: all inet_socket and sctp tests pass.

Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
Also posted as https://github.com/SELinuxProject/selinux-testsuite/pull/106
(now closed in favour of this posting).

Until "calipso: update payload_len when removing the CALIPSO option"
reaches the kernel used by the CI, the removal subtest is expected to
fail there; I can gate it on a kernel version once the fix is merged,
if preferred.

 policy/test_inet_socket.te             |  8 ++++
 tests/inet_socket/calipso-fwd-add-load | 10 +++++
 tests/inet_socket/calipso-fwd-cleanup  |  6 +++
 tests/inet_socket/calipso-fwd-del-load |  9 ++++
 tests/inet_socket/calipso-fwd-flush    |  7 +++
 tests/inet_socket/calipso-fwd-setup    | 50 +++++++++++++++++++++
 tests/inet_socket/test                 | 60 +++++++++++++++++++++++++-
 7 files changed, 148 insertions(+), 2 deletions(-)
 create mode 100644 tests/inet_socket/calipso-fwd-add-load
 create mode 100644 tests/inet_socket/calipso-fwd-cleanup
 create mode 100644 tests/inet_socket/calipso-fwd-del-load
 create mode 100644 tests/inet_socket/calipso-fwd-flush
 create mode 100644 tests/inet_socket/calipso-fwd-setup

diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
index 47969fc..2c30885 100644
--- a/policy/test_inet_socket.te
+++ b/policy/test_inet_socket.te
@@ -12,6 +12,14 @@ gen_require(`
 corenet_inout_generic_if(netlabel_peer_t)
 corenet_inout_generic_node(netlabel_peer_t)
 
+# Allow unlabeled traffic to be forwarded, as done by the CALIPSO
+# forwarding tests.
+gen_require(`
+	type unlabeled_t;
+')
+corenet_inout_generic_if(unlabeled_t)
+corenet_inout_generic_node(unlabeled_t)
+
 # Do not break NFS when we load NetLabel configuration.
 gen_require(`
 	type kernel_t;
diff --git a/tests/inet_socket/calipso-fwd-add-load b/tests/inet_socket/calipso-fwd-add-load
new file mode 100644
index 0000000..1a6e4fb
--- /dev/null
+++ b/tests/inet_socket/calipso-fwd-add-load
@@ -0,0 +1,10 @@
+#!/bin/sh
+# The client sends unlabeled packets; the router labels unlabeled packets
+# forwarded to the server with CALIPSO.
+netlabelctl calipso add pass doi:16
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl map add domain:unlabeled_t address:fd00:2::2 protocol:calipso,16
+netlabelctl map add domain:unlabeled_t address:::/0 protocol:unlbl
+netlabelctl map add domain:unlabeled_t address:0.0.0.0/0 protocol:unlbl
diff --git a/tests/inet_socket/calipso-fwd-cleanup b/tests/inet_socket/calipso-fwd-cleanup
new file mode 100644
index 0000000..f06e461
--- /dev/null
+++ b/tests/inet_socket/calipso-fwd-cleanup
@@ -0,0 +1,6 @@
+#!/bin/sh
+# Remove the namespaces created by calipso-fwd-setup (and their veths).
+for ns in selinux-ns-c selinux-ns-r selinux-ns-s; do
+	ip netns del $ns 2>/dev/null
+done
+true
diff --git a/tests/inet_socket/calipso-fwd-del-load b/tests/inet_socket/calipso-fwd-del-load
new file mode 100644
index 0000000..1efecb9
--- /dev/null
+++ b/tests/inet_socket/calipso-fwd-del-load
@@ -0,0 +1,9 @@
+#!/bin/sh
+# Label packets sent by the client domain with CALIPSO; everything else,
+# including the router forwarding them, is unlabeled.  The router therefore
+# removes the CALIPSO option from the forwarded packets.
+netlabelctl calipso add pass doi:16
+netlabelctl map del default
+netlabelctl map add default address:0.0.0.0/0 protocol:unlbl
+netlabelctl map add default address:::/0 protocol:unlbl
+netlabelctl map add domain:test_inet_client_t address:fd00:2::2 protocol:calipso,16
diff --git a/tests/inet_socket/calipso-fwd-flush b/tests/inet_socket/calipso-fwd-flush
new file mode 100644
index 0000000..d83c9aa
--- /dev/null
+++ b/tests/inet_socket/calipso-fwd-flush
@@ -0,0 +1,7 @@
+#!/bin/sh
+# Reset NetLabel configuration to unlabeled after the CALIPSO forwarding tests.
+netlabelctl map del domain:test_inet_client_t 2>/dev/null
+netlabelctl map del domain:unlabeled_t 2>/dev/null
+netlabelctl map del default
+netlabelctl calipso del doi:16
+netlabelctl map add default protocol:unlbl
diff --git a/tests/inet_socket/calipso-fwd-setup b/tests/inet_socket/calipso-fwd-setup
new file mode 100644
index 0000000..2bbf119
--- /dev/null
+++ b/tests/inet_socket/calipso-fwd-setup
@@ -0,0 +1,50 @@
+#!/bin/sh
+# Build a client -- router -- server topology out of network namespaces so
+# that CALIPSO labeled packets go through the IPv6 forwarding path:
+#
+#   selinux-ns-c (fd00:1::2) -- selinux-ns-r (forwarding) -- selinux-ns-s (fd00:2::2)
+#
+# Commands run inside a namespace use nsenter(1) rather than "ip netns exec"
+# or "ip -n" as these remount /sys, which is not allowed for every domain.
+
+in_ns() {
+	ns=$1
+	shift
+	nsenter --net=/run/netns/"$ns" "$@"
+}
+
+ip netns add selinux-ns-c
+ip netns add selinux-ns-r
+ip netns add selinux-ns-s
+ip link add selinux-cr type veth peer name selinux-rc
+ip link add selinux-rs type veth peer name selinux-sr
+ip link set selinux-cr netns selinux-ns-c
+ip link set selinux-rc netns selinux-ns-r
+ip link set selinux-rs netns selinux-ns-r
+ip link set selinux-sr netns selinux-ns-s
+for ns in selinux-ns-c selinux-ns-r selinux-ns-s; do
+	in_ns $ns ip link set lo up
+done
+in_ns selinux-ns-c ip -6 addr add fd00:1::2/64 dev selinux-cr nodad
+in_ns selinux-ns-r ip -6 addr add fd00:1::1/64 dev selinux-rc nodad
+in_ns selinux-ns-r ip -6 addr add fd00:2::1/64 dev selinux-rs nodad
+in_ns selinux-ns-s ip -6 addr add fd00:2::2/64 dev selinux-sr nodad
+in_ns selinux-ns-c ip link set selinux-cr up
+in_ns selinux-ns-r ip link set selinux-rc up
+in_ns selinux-ns-r ip link set selinux-rs up
+in_ns selinux-ns-s ip link set selinux-sr up
+in_ns selinux-ns-c ip -6 route add default via fd00:1::1
+in_ns selinux-ns-s ip -6 route add default via fd00:2::1
+in_ns selinux-ns-r sysctl -q -w net.ipv6.conf.all.forwarding=1
+
+# Wait for the links to come up, packets sent before that are dropped.
+for _ in 1 2 3 4 5 6 7 8 9 10; do
+	down=0
+	for link in selinux-ns-c:selinux-cr selinux-ns-r:selinux-rc \
+	    selinux-ns-r:selinux-rs selinux-ns-s:selinux-sr; do
+		in_ns "${link%%:*}" ip link show dev "${link#*:}" | \
+			grep -q "state UP" || down=1
+	done
+	[ $down = 0 ] && break
+	sleep 1
+done
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 1b62842..6be917f 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -51,6 +51,14 @@ BEGIN {
         $test_calipso = 1;
     }
 
+    # Determine if CALIPSO can be tested over the IPv6 forwarding path,
+    # which needs network namespaces.
+    $test_calipso_fwd = 0;
+    if ( $test_calipso and system("ip netns list >/dev/null 2>&1") eq 0 ) {
+        $test_count += 2;
+        $test_calipso_fwd = 1;
+    }
+
     # Determine if kernel has legacy iptables support
     $test_iptables = 0;
 
@@ -80,6 +88,10 @@ BEGIN {
             $test_count -= $is_stream ? 3 : 2;
             $test_calipso = 0;
         }
+        if ($test_calipso_fwd) {
+            $test_count -= 2;
+            $test_calipso_fwd = 0;
+        }
         if ($test_iptables) {
             $test_count -= 2;
         }
@@ -92,15 +104,17 @@ BEGIN {
 }
 
 sub server_start {
-    my ( $runcon_args, $args ) = @_;
+    my ( $runcon_args, $args, $netns ) = @_;
     my $pid;
+    my $cmd = "runcon $runcon_args $basedir/server -f $basedir/flag";
 
     $args = "-4 $args" unless $test_ipv6;
+    $cmd  = "nsenter --net=/run/netns/$netns $cmd" if defined $netns;
 
     system("mkfifo $basedir/flag");
 
     if ( ( $pid = fork() ) == 0 ) {
-        exec "runcon $runcon_args $basedir/server -f $basedir/flag $args";
+        exec "$cmd $args";
     }
 
     # Wait for it to initialize.
@@ -503,6 +517,48 @@ if ($test_calipso) {
     system "/bin/sh $basedir/calipso-flush";
 }
 
+if ($test_calipso_fwd) {
+    system "/bin/sh $basedir/calipso-fwd-setup";
+
+    # The router removes the CALIPSO option from forwarded packets.
+    system "/bin/sh $basedir/calipso-fwd-del-load";
+
+    $pid = server_start(
+        "-t test_inet_server_t -l s0:c0.c10",
+        "-n $proto 65535",
+        "selinux-ns-s"
+    );
+
+    # Verify that the client can communicate with the server through
+    # the router.
+    $result = system
+"nsenter --net=/run/netns/selinux-ns-c runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client -e nopeer $proto fd00:2::2 65535";
+    ok( $result eq 0 );
+
+    server_end($pid);
+    system "/bin/sh $basedir/calipso-fwd-flush";
+
+    # The router adds a CALIPSO option to forwarded packets.
+    system "/bin/sh $basedir/calipso-fwd-add-load";
+
+    $pid = server_start(
+        "-t test_inet_server_t -l s0:c0.c10",
+        "-n $proto 65535",
+        "selinux-ns-s"
+    );
+
+    # Verify that the client can communicate with the server through
+    # the router.
+    $result = system
+"nsenter --net=/run/netns/selinux-ns-c runcon -t test_inet_client_t -l s0:c0.c10 $basedir/client -e nopeer $proto fd00:2::2 65535";
+    ok( $result eq 0 );
+
+    server_end($pid);
+    system "/bin/sh $basedir/calipso-fwd-flush";
+
+    system "/bin/sh $basedir/calipso-fwd-cleanup";
+}
+
 if ( $proto eq "mptcp" and $mptcp_enabled ne "1" ) {
 
     # Reset net.mptcp.enabled if it was 0 before test
