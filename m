Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB3F52BE3C
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868761; cv=none; b=hKC2jo7JXsDBZDHWkuFoLZfxS3nbBINiGQlR9WL4vCib/5BpIigopsRiBcATs6lYwCHXkqxr0+F7C+1gMZj0ppn13PvvcgrdNGhD3LepUxCAM1wWFCk2kZFRQAxPqqMEJzNQFUPUmarNt3YotQHo3Dhc7lkzfhuaVZs0tq0/k58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868761; c=relaxed/simple;
	bh=KSqyv7PxBUXGDvzzZ2yXbRwK5PF6bqBM8MfhBKtgDGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbNMzu7PYzHvwRklfM+yFj/TldZDqfUus/BjLzVaVmfq2uQO9oxKV8maQ1ppCQVS9lo4zN1iS9DGuY3tWfTxApyhOypTsoba9RDSlgUWKdFTYsTb6q8ypkhxJWys5A//rXR5xmoF98hmHRwM/R/LzJ31wAkcnsuKwoRE2tdjEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IeWK2y6x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IeWK2y6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0dEaBB6CHzjVT3RRMpx4X1WWhXjW3vWzwxtj4FeYEo=;
	b=IeWK2y6xG6LXGeDfHWfqYlPA6NAq8pL/6tEpQOnKuBIwMgXqg2taADa+zb/PhWKpXsBOTn
	Wh0Vop5P4H80/0krdiDZ7pSC+YzG/LtS6LCPQk1XHqP1LNb19bmCr8hoyY5rAOpCquKhqz
	dRXIrC38cxEl+zlgOtl7fzCbQLjej1g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-9QfTUmNYN6WmIoJGE3pb6A-1; Thu,
 01 Oct 2026 11:32:37 -0400
X-MC-Unique: 9QfTUmNYN6WmIoJGE3pb6A-1
X-Mimecast-MFC-AGG-ID: 9QfTUmNYN6WmIoJGE3pb6A_1790868757
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07FFA183450B
	for <selinux@vger.kernel.org>; Thu,  1 Oct 2026 15:32:37 +0000 (UTC)
Received: from bgrech-thinkpadp1gen3.rmtustx.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F88E30000E4;
	Thu,  1 Oct 2026 15:32:36 +0000 (UTC)
From: Brian Grech <bgrech@redhat.com>
To: selinux@vger.kernel.org
Cc: Brian Grech <bgrech@redhat.com>
Subject: [PATCH 2/3] tests: skip io_uring when unsupported or disabled
Date: Thu,  1 Oct 2026 10:32:11 -0500
Message-ID: <20261001153212.102261-2-bgrech@redhat.com>
In-Reply-To: <20261001153212.102261-1-bgrech@redhat.com>
References: <20261001153212.102261-1-bgrech@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Gate the io_uring SUBDIRS entry on liburing.h being available at build
time. Runtime kernel support is checked in the test itself instead of
via /lib/modules/$(uname -r)/config: that file isn't reliable for
hand-built/booted kernels. Since the kernel.io_uring_disabled sysctl
only exists when CONFIG_IO_URING is set, checking it at runtime covers
both the "not built in" and the "administratively disabled" cases
without relying on the config file.

Also fix a latent bug from converting to Test::More: ok($result, 0)
treats "0" as a test label, not an expected value, so it silently
inverted the pass/fail logic for the "should succeed" cases. Use
ok($result == 0) instead.

Assisted-by: Claude Code:claude-sonnet-5
Signed-off-by: Brian Grech <bgrech@redhat.com>
---
 tests/Makefile      |  6 ++++++
 tests/io_uring/test | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/tests/Makefile b/tests/Makefile
index 084c788..d53684a 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -172,9 +172,15 @@ ifeq ($(shell [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(SELINUXFS)/
 SUBDIRS += memfd
 endif
 
+# Skip when liburing-devel (providing liburing.h) isn't installed to build
+# against. Runtime kernel support (CONFIG_IO_URING, io_uring_disabled) is
+# probed by the test itself rather than here, since kernel config files
+# aren't reliable for hand-built/booted kernels.
 ifeq ($(shell grep -q io_uring $(POLDEV)/include/support/all_perms.spt && echo true),true)
+ifeq ($(shell test -e $(INCLUDEDIR)/liburing.h && echo true),true)
 SUBDIRS += io_uring
 endif
+endif
 
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
diff --git a/tests/io_uring/test b/tests/io_uring/test
index dd97027..36e1d49 100755
--- a/tests/io_uring/test
+++ b/tests/io_uring/test
@@ -1,17 +1,38 @@
 #!/usr/bin/perl
 
-use Test;
-BEGIN { plan tests => 11 }
+use Test::More;
 
-$basedir = $0;
-$basedir =~ s|(.*)/[^/]*|$1|;
+BEGIN {
+    $basedir = $0;
+    $basedir =~ s|(.*)/[^/]*|$1|;
+
+    # kernel.io_uring_disabled only exists when the kernel has io_uring
+    # support built in, so a missing sysctl means CONFIG_IO_URING isn't
+    # set. A value of 2 means io_uring is administratively disabled even
+    # for privileged processes. Check this at runtime rather than kernel
+    # config files, which aren't reliable for hand-built/booted kernels.
+    my $io_uring_disabled = `sysctl -n kernel.io_uring_disabled 2>/dev/null`;
+    my $sysctl_rc         = $?;
+    chomp($io_uring_disabled);
+
+    if ( $sysctl_rc != 0 ) {
+        plan skip_all => "io_uring not supported by this kernel";
+    }
+    elsif ( $io_uring_disabled eq "2" ) {
+        plan skip_all =>
+          "io_uring is disabled via the kernel.io_uring_disabled sysctl";
+    }
+    else {
+        plan tests => 11;
+    }
+}
 
 # Remove any leftover test files from prior runs.
 system("rm -f $basedir/iouring.out");
 
 # Verify that test_io_uring_t passes the t1 test
 $result = system("runcon -t test_io_uring_t $basedir/iouring t1");
-ok( $result, 0 );
+ok( $result == 0 );
 
 # Verify that test_io_uring_no_override_t fails the t1 test on io_uring override_creds
 $result = system(
@@ -44,7 +65,7 @@ chomp($serange);
 $childctx = "$seuser:$serole:test_io_uring_child_t:$serange";
 $result =
   system("runcon -t test_io_uring_parent_t $basedir/iouring t1 $childctx");
-ok( $result, 0 );
+ok( $result == 0 );
 
 # Verify that test_io_uring_child_no_override_t fails the t1 test on io_uring override_creds
 $childctx = "$seuser:$serole:test_io_uring_child_no_override_t:$serange";
@@ -72,7 +93,7 @@ ok($result);
 
 # Verify that test_io_uring_sqpoll_t passes the sqpoll test
 $result = system("runcon -t test_io_uring_sqpoll_t $basedir/iouring sqpoll");
-ok( $result, 0 );
+ok( $result == 0 );
 
 # Verify that test_io_uring_no_sqpoll_t fails the sqpoll test
 $result = system(
-- 
2.55.0

