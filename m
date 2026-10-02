Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC630649C
	for <selinux@vger.kernel.org>; Fri,  2 Oct 2026 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955986; cv=none; b=s0s01F2wWrWaawjGqwwErEgtbt4KfcMQwp56tZVM5ssKaRZ+/XIysfMWNiSE6iLgkeHVKvPA+dEQ9P5nvPj6iisR8Mgn4j38MWXp2WZSWbpXnn/N3aOd0v7SHB5si1ArNJhAdB9mKbBfiK40O7Ali7KIWhVG8kOr2+rW9jYJXuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955986; c=relaxed/simple;
	bh=L0nOc+1j3OAemph2lE5m5mn3nU0eEe+BZFM0iYsDkLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSqsM2+JTdtYh0yNNSHeJELUQPBtkVk9462+5j0IiZfwwM/ZvNdGh6emOu38itl5EKy0dysEINnv//IsHWlZ80iHrriaaZQgiGoPmGCdxzfRW1Gw1cAy9JZ64wFFJqE4C4+JynUUyZ+txGrVzcDynz0+rz2d6v7oR6X2QfQmTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J70S4k8w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J70S4k8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790955984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+06mnZ2RDElOSk8hZ7OLXEATFYOe+JTobMF91yUHyhY=;
	b=J70S4k8wMO6kd/WjvFHatPuQpJOJdmsjZj/YQnl3h/Ti5s57yAIOKL7k/DY82toyBl3P0I
	J11oLw74TVmfFyQsftBzQgHk/N9cBbJzI5o18Y54AsjHIVfNHmco60dYG8JkBg1OaENOvR
	RosnDkIPkuCkj2Dwo8vFQUT0Lv/CSoE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-0rtPXp0HMNic3PGf5GEnyQ-1; Fri,
 02 Oct 2026 11:46:20 -0400
X-MC-Unique: 0rtPXp0HMNic3PGf5GEnyQ-1
X-Mimecast-MFC-AGG-ID: 0rtPXp0HMNic3PGf5GEnyQ_1790955979
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9B018195BDD6;
	Fri,  2 Oct 2026 15:46:19 +0000 (UTC)
Received: from bgrech-thinkpadp1gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE14119560AB;
	Fri,  2 Oct 2026 15:46:18 +0000 (UTC)
From: Brian Grech <bgrech@redhat.com>
To: selinux@vger.kernel.org,
	stephen.smalley.work@gmail.com
Cc: Brian Grech <bgrech@redhat.com>
Subject: [PATCH v2] tests: skip io_uring when unsupported or disabled
Date: Fri,  2 Oct 2026 10:46:16 -0500
Message-ID: <20261002154617.751470-1-bgrech@redhat.com>
In-Reply-To: <20261001153212.102261-2-bgrech@redhat.com>
References: <20261001153212.102261-2-bgrech@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Gate io_uring on liburing.h at build time (documented dependency,
same pattern as key_socket/keyutils.h).

At runtime, probe unconfined via a new iouring "probe" mode
(io_uring_queue_init()/exit()) rather than kernel config files or the
io_uring_disabled sysctl alone: that sysctl (v6.6+) postdates the
io_uring permission being tested (v5.16), so its absence does not mean
unsupported. Use it only for the "== 2" admin-disabled case.

Converting to Test::More also requires ok($result, 0) -> ok($result ==
0): the two-arg form silently inverts the "should succeed" checks
under Test::More.

Assisted-by: Claude Code:claude-sonnet-5
Signed-off-by: Brian Grech <bgrech@redhat.com>
---
 tests/Makefile           |  6 ++++++
 tests/io_uring/iouring.c | 20 +++++++++++++++++++-
 tests/io_uring/test      | 38 +++++++++++++++++++++++++++++++-------
 3 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/tests/Makefile b/tests/Makefile
index 1118089..4c8e82b 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -176,9 +176,15 @@ ifeq ($(shell [ -d /sys/fs/selinux/class/memfd_file ] && grep -q 1 $(SELINUXFS)/
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
diff --git a/tests/io_uring/iouring.c b/tests/io_uring/iouring.c
index 36b014f..59ffbce 100644
--- a/tests/io_uring/iouring.c
+++ b/tests/io_uring/iouring.c
@@ -479,6 +479,7 @@ int main(int argc, char *argv[])
 	struct rlimit rlim;
 
 	enum { TST_UNKNOWN,
+	       TST_PROBE,
 	       TST_SQPOLL,
 	       TST_T1_PARENT, TST_T1_CHILD
 	     } tst_method;
@@ -486,7 +487,9 @@ int main(int argc, char *argv[])
 	/* parse the command line and do some sanity checks */
 	tst_method = TST_UNKNOWN;
 	if (argc >= 2) {
-		if (!strcmp(argv[1], "sqpoll"))
+		if (!strcmp(argv[1], "probe"))
+			tst_method = TST_PROBE;
+		else if (!strcmp(argv[1], "sqpoll"))
 			tst_method = TST_SQPOLL;
 		else if (!strcmp(argv[1], "t1") ||
 			 !strcmp(argv[1], "t1_parent"))
@@ -499,6 +502,21 @@ int main(int argc, char *argv[])
 		exit(EINVAL);
 	}
 
+	/*
+	 * Minimal probe: just check whether the kernel supports io_uring at
+	 * all, without any of the SELinux-specific setup below. Meant to be
+	 * run unconfined so a failure here means io_uring isn't available,
+	 * not that it was denied by policy. Exits 0 if supported, 1 if not.
+	 */
+	if (tst_method == TST_PROBE) {
+		struct io_uring probe_ring;
+
+		if (io_uring_queue_init(URING_ENTRIES, &probe_ring, 0) < 0)
+			exit(1);
+		io_uring_queue_exit(&probe_ring);
+		exit(0);
+	}
+
 	progname = strdup(argv[0]);
 	progdir = dirname(progname);
 
diff --git a/tests/io_uring/test b/tests/io_uring/test
index dd97027..fb6528e 100755
--- a/tests/io_uring/test
+++ b/tests/io_uring/test
@@ -1,17 +1,41 @@
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
+    # Probe unconfined so a failure here means io_uring isn't built into
+    # the kernel at all, not that it was denied by policy.
+    my $io_uring_supported =
+      system("$basedir/iouring probe >/dev/null 2>&1") == 0 ? 1 : 0;
+
+    # kernel.io_uring_disabled was only added in v6.6, well after the
+    # io_uring support being tested here (v5.16), so its absence does not
+    # mean io_uring is unsupported - only a value of 2 means io_uring is
+    # administratively disabled, even for privileged processes.
+    chomp( my $io_uring_disabled =
+          `sysctl -n kernel.io_uring_disabled 2>/dev/null` );
+
+    if ( !$io_uring_supported ) {
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
@@ -44,7 +68,7 @@ chomp($serange);
 $childctx = "$seuser:$serole:test_io_uring_child_t:$serange";
 $result =
   system("runcon -t test_io_uring_parent_t $basedir/iouring t1 $childctx");
-ok( $result, 0 );
+ok( $result == 0 );
 
 # Verify that test_io_uring_child_no_override_t fails the t1 test on io_uring override_creds
 $childctx = "$seuser:$serole:test_io_uring_child_no_override_t:$serange";
@@ -72,7 +96,7 @@ ok($result);
 
 # Verify that test_io_uring_sqpoll_t passes the sqpoll test
 $result = system("runcon -t test_io_uring_sqpoll_t $basedir/iouring sqpoll");
-ok( $result, 0 );
+ok( $result == 0 );
 
 # Verify that test_io_uring_no_sqpoll_t fails the sqpoll test
 $result = system(
-- 
2.55.0

