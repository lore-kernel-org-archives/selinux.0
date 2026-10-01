Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337D52BE29
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868759; cv=none; b=WyZblLjgX4PmTFebEdP0T5e3ITGyr6dgh3hsBBbT+y/4vekfxXImav20O/jPDg21P2HSsisCSbd4pt0zqp/d3rznB0u3ELtS89VIUoP0cFpGWidN6J2ih82yZCmkdtE/4qwn0vUqDSenIW9MUcyWXW23NrUICv0/u8HCO53MlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868759; c=relaxed/simple;
	bh=pEJGqpPbr5y5x6/AowPysq1O8niPtZjRTPm3fcktO7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cyng/9hVejujPLPhXoUHxbI/g9pzmfPD1hv+V+fwTao5DcuVeyzKykBOpFC4vxfl6y0dWzF7RD1C+z3gG3MUf9qnkBt6NzfrhdQHkk330MukwJnLas5Aw3nPS5eZDLVGy2ddNZPdM6dhH5x3ppNlszqXamP84ihzgWARu+R+sSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaRU5Zo/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaRU5Zo/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=277U0IY/Be9yGMpHeJ+TQOpvahYPw1Qw50bCdCkyGhg=;
	b=OaRU5Zo/38JPM6t/Ys8biN94IyJ7xGAeiGWEfNBKxQJfv19iSLlI5Y8J4/EBnPqjKPMMJS
	zvY+BTnSveM8kQkmJHdABxla1+SuHBiGUDdGtvejUYhwtZG1g1wnn4taJXYarZmwhwGFCq
	pbPXz9SpvAMze2E8yOvvQtVovpJDZew=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-c3hcMmwIO4SG4_QX5oZGAw-1; Thu,
 01 Oct 2026 11:32:35 -0400
X-MC-Unique: c3hcMmwIO4SG4_QX5oZGAw-1
X-Mimecast-MFC-AGG-ID: c3hcMmwIO4SG4_QX5oZGAw_1790868754
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6009D195394E
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 15:32:34 +0000 (UTC)
Received: from bgrech-thinkpadp1gen3.rmtustx.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA14E30000E4;
	Thu,  1 Oct 2026 15:32:33 +0000 (UTC)
From: Brian Grech <bgrech@redhat.com>
To: selinux@vger.kernel.org
Cc: Brian Grech <bgrech@redhat.com>
Subject: [PATCH 1/3] tests/netlink_socket: skip iscsi subtest when NETLINK_ISCSI is unsupported
Date: Thu,  1 Oct 2026 10:32:10 -0500
Message-ID: <20261001153212.102261-1-bgrech@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

test_netlink_iscsi_socket_t's ability to create a NETLINK_ISCSI socket
depends on kernel support for the iSCSI netlink transport. On systems
built without it, socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ISCSI) fails
regardless of SELinux confinement, so the create/deny pair of subtests
fail without exercising any access control.

Probe support unconfined before running the confined cases, and skip
just those two subtests when unavailable, leaving the rest of the
netlink_socket tests (netfilter, generic, crypto) unaffected.

Assisted-by: Claude Code:claude-sonnet-5
Signed-off-by: Brian Grech <bgrech@redhat.com>
---
 tests/netlink_socket/test | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/tests/netlink_socket/test b/tests/netlink_socket/test
index 487edbc..745569d 100755
--- a/tests/netlink_socket/test
+++ b/tests/netlink_socket/test
@@ -1,28 +1,40 @@
 #!/usr/bin/perl
 
-use Test;
-BEGIN { plan tests => 8 }
+use Test::More;
 
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
 
-# Verify that test_netlink_iscsi_socket_t can create a NETLINK_ISCSI socket.
-$result = system(
-    "runcon -t test_netlink_iscsi_socket_t -- $basedir/netlinkcreate iscsi 2>&1"
-);
-ok( $result, 0 );
+    # Determine if the kernel supports NETLINK_ISCSI. Probe unconfined so a
+    # failure here means the protocol isn't available, not an SELinux denial.
+    $test_iscsi =
+      system("$basedir/netlinkcreate iscsi 2>/dev/null") == 0 ? 1 : 0;
+
+    plan tests => 8;
+}
+
+SKIP: {
+    skip( "NETLINK_ISCSI not supported by this kernel", 2 ) unless $test_iscsi;
+
+    # Verify that test_netlink_iscsi_socket_t can create a NETLINK_ISCSI socket.
+    $result = system(
+"runcon -t test_netlink_iscsi_socket_t -- $basedir/netlinkcreate iscsi 2>&1"
+    );
+    ok( $result == 0 );
 
 # Verify that test_no_netlink_iscsi_socket_t cannot create a NETLINK_ISCSI socket.
-$result = system(
+    $result = system(
 "runcon -t test_no_netlink_iscsi_socket_t -- $basedir/netlinkcreate iscsi 2>&1"
-);
-ok($result);
+    );
+    ok($result);
+}
 
 # Verify that test_netlink_netfilter_socket_t can create a NETLINK_NETFILTER socket.
 $result = system(
 "runcon -t test_netlink_netfilter_socket_t -- $basedir/netlinkcreate netfilter 2>&1"
 );
-ok( $result, 0 );
+ok( $result == 0 );
 
 # Verify that test_no_netlink_netfilter_socket_t cannot create a NETLINK_NETFILTER socket.
 $result = system(
@@ -34,7 +46,7 @@ ok($result);
 $result = system(
 "runcon -t test_netlink_generic_socket_t -- $basedir/netlinkcreate generic 2>&1"
 );
-ok( $result, 0 );
+ok( $result == 0 );
 
 # Verify that test_no_netlink_generic_socket_t cannot create a NETLINK_GENERIC socket.
 $result = system(
@@ -46,7 +58,7 @@ ok($result);
 $result = system(
 "runcon -t test_netlink_crypto_socket_t -- $basedir/netlinkcreate crypto 2>&1"
 );
-ok( $result, 0 );
+ok( $result == 0 );
 
 # Verify that test_no_netlink_crypto_socket_t cannot create a NETLINK_CRYPTO socket.
 $result = system(
-- 
2.55.0

