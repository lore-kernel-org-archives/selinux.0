Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E5CECAAA3
	for <selinux@archiver.kernel.org>; Fri, 26 Aug 2022 08:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbiHZIaJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Aug 2022 04:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343621AbiHZIaG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Aug 2022 04:30:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710A4E0B4
        for <selinux@vger.kernel.org>; Fri, 26 Aug 2022 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661502596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NTiauhHiWozeuXzY3rmpRHotdhK+Bs1KPcCb7/2RVpM=;
        b=QOSqblG61wr2miel9fG7g3V/9LZ6Iahl91G4XTAFkfvnGRehxA7QbaQzbEliINKl3S//Ob
        MF6/kv+7+r5zYfMa/1mSsHQs9V1LWQXoK1p+xLJ0IfDH9Lkt2g88Q041zFbDMtEevRqAAW
        R2SIJieTaAFJ0w0qRT9bk6ywmaYB5TM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-367-hc_e4un5Oo-CHcyL6-cbzw-1; Fri, 26 Aug 2022 04:29:54 -0400
X-MC-Unique: hc_e4un5Oo-CHcyL6-cbzw-1
Received: by mail-wm1-f69.google.com with SMTP id q16-20020a1cf310000000b003a626026ed1so197723wmq.4
        for <selinux@vger.kernel.org>; Fri, 26 Aug 2022 01:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NTiauhHiWozeuXzY3rmpRHotdhK+Bs1KPcCb7/2RVpM=;
        b=DrnIXS96vMVi9l3kspongeqAjZnDynxouQfZbDteoM6YmnfOS19nXvjoB/B1Q/FsJc
         nurpopLOYV5FCDIr7dg3Qw1S8RVALNg/F6qi7k8O+uibprUfyyFVw9fs+GG+YaPCxJKw
         4KrDCaKmzIyhDkdEOMFjeW9q9gzLdVRrmR37+uu57JXBAaT72IVkce6Z2SHWHIxKouPY
         +6V72l1K7PqafDWGaFaSWz9YPOko/hL1qdCQTbaaEqAfuTQ0D5BIW9QKMd9dS7Zju2NU
         AuszQ1bp3hFxI2LqFSoFww0XP+8RSRNoULXgXoIUD9U9Zak7bIUj/4dUC56IWulIb4Zp
         hXkQ==
X-Gm-Message-State: ACgBeo0g40ipQOXn8XtjX3UUg0fbjHokdq7vvvV7oBrywjzcGtcmT/ZG
        cuPT7ioA2FGzmSld8HQ6Mphk/VMzik4ECp3LBrQmPD8tRF1G+TWRe+IrMmDXL05cBKbyJbwH3YF
        bP0A+I68OdarJCiGIckiN2ISj3f/uKiVgkD1bcPuZ0krHCOZ4kqR6xJJfBqqt4zygRmjAGQ==
X-Received: by 2002:a5d:64ca:0:b0:225:48a0:d9cb with SMTP id f10-20020a5d64ca000000b0022548a0d9cbmr4415249wri.399.1661502590428;
        Fri, 26 Aug 2022 01:29:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7HUVxQmXpWYNVgfePXa0/zn5a0CodqCOWKV+0Zg6YlMBcCo4L8uSToOM0PYZj7Bq7nu0E9rw==
X-Received: by 2002:a5d:64ca:0:b0:225:48a0:d9cb with SMTP id f10-20020a5d64ca000000b0022548a0d9cbmr4415235wri.399.1661502590012;
        Fri, 26 Aug 2022 01:29:50 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d620a000000b0021d221daccfsm1280274wru.78.2022.08.26.01.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:29:49 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>
Subject: [PATCH testsuite] tests: remove more stray flag/temporary files with 'make clean'
Date:   Fri, 26 Aug 2022 10:29:48 +0200
Message-Id: <20220826082948.30747-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Building upon a similar cleanup being done in the binder test, remove
any temporary files that may have been left behind by a failed or
interrupted test run as part of 'make clean'.

For now, skip doing this for the filesystem/fs_filesystem tests, as
those can leave behind directories with mounts, which are harder to
clean up reliably.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 tests/bounds/Makefile            | 2 +-
 tests/bpf/Makefile               | 2 +-
 tests/capable_file/Makefile      | 2 +-
 tests/entrypoint/Makefile        | 1 +
 tests/execute_no_trans/Makefile  | 1 +
 tests/fdreceive/Makefile         | 2 +-
 tests/fdreceive/test             | 4 +++-
 tests/file/Makefile              | 2 +-
 tests/inet_socket/Makefile       | 2 +-
 tests/inherit/Makefile           | 2 +-
 tests/ioctl/Makefile             | 2 +-
 tests/link/Makefile              | 1 +
 tests/mac_admin/Makefile         | 1 +
 tests/mkdir/Makefile             | 1 +
 tests/mmap/Makefile              | 2 +-
 tests/nnp_nosuid/Makefile        | 2 +-
 tests/notify/Makefile            | 2 +-
 tests/open/Makefile              | 2 +-
 tests/ptrace/Makefile            | 2 +-
 tests/readlink/Makefile          | 1 +
 tests/relabel/Makefile           | 1 +
 tests/rename/Makefile            | 1 +
 tests/rxdir/Makefile             | 1 +
 tests/sctp/Makefile              | 2 +-
 tests/setattr/Makefile           | 1 +
 tests/sigkill/Makefile           | 2 +-
 tests/stat/Makefile              | 1 +
 tests/task_getpgid/Makefile      | 2 +-
 tests/task_getscheduler/Makefile | 2 +-
 tests/task_getsid/Makefile       | 2 +-
 tests/task_setnice/Makefile      | 1 +
 tests/task_setscheduler/Makefile | 2 +-
 tests/unix_socket/Makefile       | 2 +-
 tests/vsock_socket/Makefile      | 2 +-
 34 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/tests/bounds/Makefile b/tests/bounds/Makefile
index 0e671ac..cd65b68 100644
--- a/tests/bounds/Makefile
+++ b/tests/bounds/Makefile
@@ -4,4 +4,4 @@ LDLIBS += -lselinux -lpthread
 
 all: $(TARGETS)
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) bounds_file*
diff --git a/tests/bpf/Makefile b/tests/bpf/Makefile
index 6fb230d..1ae8ce9 100644
--- a/tests/bpf/Makefile
+++ b/tests/bpf/Makefile
@@ -11,7 +11,7 @@ all: $(TARGETS)
 	@set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i all ; done
 
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) test_sock flag *_flag
 	@set -e; for i in $(BPF_ENABLED); do $(MAKE) -C $$i clean ; done
 
 $(TARGETS): $(DEPS)
diff --git a/tests/capable_file/Makefile b/tests/capable_file/Makefile
index 42a18c8..794cade 100644
--- a/tests/capable_file/Makefile
+++ b/tests/capable_file/Makefile
@@ -1,5 +1,5 @@
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 all: $(TARGETS)
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) temp_file temp_file2
 
diff --git a/tests/entrypoint/Makefile b/tests/entrypoint/Makefile
index e7c006f..c99e0db 100644
--- a/tests/entrypoint/Makefile
+++ b/tests/entrypoint/Makefile
@@ -1,2 +1,3 @@
 all:
 clean:
+	rm -f true
diff --git a/tests/execute_no_trans/Makefile b/tests/execute_no_trans/Makefile
index e7c006f..c99e0db 100644
--- a/tests/execute_no_trans/Makefile
+++ b/tests/execute_no_trans/Makefile
@@ -1,2 +1,3 @@
 all:
 clean:
+	rm -f true
diff --git a/tests/fdreceive/Makefile b/tests/fdreceive/Makefile
index 895f91c..d9f8927 100644
--- a/tests/fdreceive/Makefile
+++ b/tests/fdreceive/Makefile
@@ -8,6 +8,6 @@ endif
 all: $(TARGETS)
 
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) test_file test_file2 test_sock flag
 
 client: $(DEPS)
diff --git a/tests/fdreceive/test b/tests/fdreceive/test
index 51cf132..1eaf0f7 100755
--- a/tests/fdreceive/test
+++ b/tests/fdreceive/test
@@ -7,7 +7,9 @@ $basedir = $0;
 $basedir =~ s|(.*)/[^/]*|$1|;
 
 # Remove any leftover test file from prior failed runs.
-system("rm -rf $basedir/test_file $basedir/test_file2 $basedir/test_sock");
+system(
+"rm -rf $basedir/test_file $basedir/test_file2 $basedir/test_sock $basedir/flag"
+);
 
 # Create and label the test files.
 system("touch $basedir/test_file $basedir/test_file2");
diff --git a/tests/file/Makefile b/tests/file/Makefile
index a9ff509..8619b32 100644
--- a/tests/file/Makefile
+++ b/tests/file/Makefile
@@ -3,4 +3,4 @@ LDLIBS += -lselinux
 test_sigiotask: LDLIBS += -lutil
 all: $(TARGETS)
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) temp_file temp_file2 temp_file3
diff --git a/tests/inet_socket/Makefile b/tests/inet_socket/Makefile
index 5bfd561..2dbfe7b 100644
--- a/tests/inet_socket/Makefile
+++ b/tests/inet_socket/Makefile
@@ -4,4 +4,4 @@ LDLIBS+= -lselinux
 
 all: $(TARGETS)
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) flag
diff --git a/tests/inherit/Makefile b/tests/inherit/Makefile
index f7f4133..7c12ab3 100644
--- a/tests/inherit/Makefile
+++ b/tests/inherit/Makefile
@@ -4,4 +4,4 @@ LDLIBS += -lselinux
 
 all: $(TARGETS)
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) test_file
diff --git a/tests/ioctl/Makefile b/tests/ioctl/Makefile
index 8dce555..53e4ec3 100644
--- a/tests/ioctl/Makefile
+++ b/tests/ioctl/Makefile
@@ -1,4 +1,4 @@
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 all: $(TARGETS)
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) temp_file
diff --git a/tests/link/Makefile b/tests/link/Makefile
index e7c006f..85456cf 100644
--- a/tests/link/Makefile
+++ b/tests/link/Makefile
@@ -1,2 +1,3 @@
 all:
 clean:
+	rm -rf test_dir
diff --git a/tests/mac_admin/Makefile b/tests/mac_admin/Makefile
index e7c006f..8fe1321 100644
--- a/tests/mac_admin/Makefile
+++ b/tests/mac_admin/Makefile
@@ -1,2 +1,3 @@
 all:
 clean:
+	rm -rf test_dir test_file
diff --git a/tests/mkdir/Makefile b/tests/mkdir/Makefile
index e7c006f..85456cf 100644
--- a/tests/mkdir/Makefile
+++ b/tests/mkdir/Makefile
@@ -1,2 +1,3 @@
 all:
 clean:
+	rm -rf test_dir
diff --git a/tests/mmap/Makefile b/tests/mmap/Makefile
index e330f3e..917a754 100644
--- a/tests/mmap/Makefile
+++ b/tests/mmap/Makefile
@@ -5,4 +5,4 @@ LDLIBS += -lpthread
 all: $(TARGETS)
 
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) temp_file
diff --git a/tests/nnp_nosuid/Makefile b/tests/nnp_nosuid/Makefile
index 4e8e400..434f3c0 100644
--- a/tests/nnp_nosuid/Makefile
+++ b/tests/nnp_nosuid/Makefile
@@ -4,4 +4,4 @@ LDLIBS += -lselinux
 
 all: $(TARGETS)
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) true
diff --git a/tests/notify/Makefile b/tests/notify/Makefile
index d237338..0c2564c 100644
--- a/tests/notify/Makefile
+++ b/tests/notify/Makefile
@@ -2,4 +2,4 @@ TARGETS=test_inotify test_fanotify
 
 all: $(TARGETS)
 clean:
-	rm -f $(TARGETS)
+	rm -rf $(TARGETS) watch_me watch_dir
diff --git a/tests/open/Makefile b/tests/open/Makefile
index 7c3c9c4..dc56899 100644
--- a/tests/open/Makefile
+++ b/tests/open/Makefile
@@ -2,4 +2,4 @@ TARGETS=append2write fopen
 
 all: $(TARGETS)
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) test_file
diff --git a/tests/ptrace/Makefile b/tests/ptrace/Makefile
index a1a4e35..8872c6c 100644
--- a/tests/ptrace/Makefile
+++ b/tests/ptrace/Makefile
@@ -1,3 +1,3 @@
 all: ptrace
 clean:
-	rm -f ptrace
+	rm -f ptrace flag
diff --git a/tests/readlink/Makefile b/tests/readlink/Makefile
index e7c006f..b6b8848 100644
--- a/tests/readlink/Makefile
+++ b/tests/readlink/Makefile
@@ -1,2 +1,3 @@
 all:
 clean:
+	rm -f test_file test_symlink
diff --git a/tests/relabel/Makefile b/tests/relabel/Makefile
index e7c006f..88c9ac5 100644
--- a/tests/relabel/Makefile
+++ b/tests/relabel/Makefile
@@ -1,2 +1,3 @@
 all:
 clean:
+	rm -f test_file
diff --git a/tests/rename/Makefile b/tests/rename/Makefile
index e7c006f..adc84df 100644
--- a/tests/rename/Makefile
+++ b/tests/rename/Makefile
@@ -1,2 +1,3 @@
 all:
 clean:
+	rm -rf src_dir dst_dir
diff --git a/tests/rxdir/Makefile b/tests/rxdir/Makefile
index e7c006f..85456cf 100644
--- a/tests/rxdir/Makefile
+++ b/tests/rxdir/Makefile
@@ -1,2 +1,3 @@
 all:
 clean:
+	rm -rf test_dir
diff --git a/tests/sctp/Makefile b/tests/sctp/Makefile
index 5e03650..c77b919 100644
--- a/tests/sctp/Makefile
+++ b/tests/sctp/Makefile
@@ -10,6 +10,6 @@ LDLIBS += -lselinux -lsctp
 all: $(TARGETS)
 
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) flag
 
 $(TARGETS): $(DEPS)
diff --git a/tests/setattr/Makefile b/tests/setattr/Makefile
index e7c006f..88c9ac5 100644
--- a/tests/setattr/Makefile
+++ b/tests/setattr/Makefile
@@ -1,2 +1,3 @@
 all:
 clean:
+	rm -f test_file
diff --git a/tests/sigkill/Makefile b/tests/sigkill/Makefile
index 1aa01ef..a055b24 100644
--- a/tests/sigkill/Makefile
+++ b/tests/sigkill/Makefile
@@ -1,3 +1,3 @@
 all: server
 clean:
-	rm -f server
+	rm -f server flag
diff --git a/tests/stat/Makefile b/tests/stat/Makefile
index e7c006f..88c9ac5 100644
--- a/tests/stat/Makefile
+++ b/tests/stat/Makefile
@@ -1,2 +1,3 @@
 all:
 clean:
+	rm -f test_file
diff --git a/tests/task_getpgid/Makefile b/tests/task_getpgid/Makefile
index 20e1e63..79501b4 100644
--- a/tests/task_getpgid/Makefile
+++ b/tests/task_getpgid/Makefile
@@ -1,3 +1,3 @@
 all: source
 clean:
-	rm -f source
+	rm -f source flag
diff --git a/tests/task_getscheduler/Makefile b/tests/task_getscheduler/Makefile
index 20e1e63..79501b4 100644
--- a/tests/task_getscheduler/Makefile
+++ b/tests/task_getscheduler/Makefile
@@ -1,3 +1,3 @@
 all: source
 clean:
-	rm -f source
+	rm -f source flag
diff --git a/tests/task_getsid/Makefile b/tests/task_getsid/Makefile
index 20e1e63..79501b4 100644
--- a/tests/task_getsid/Makefile
+++ b/tests/task_getsid/Makefile
@@ -1,3 +1,3 @@
 all: source
 clean:
-	rm -f source
+	rm -f source flag
diff --git a/tests/task_setnice/Makefile b/tests/task_setnice/Makefile
index e7c006f..e6a3be0 100644
--- a/tests/task_setnice/Makefile
+++ b/tests/task_setnice/Makefile
@@ -1,2 +1,3 @@
 all:
 clean:
+	rm -f flag
diff --git a/tests/task_setscheduler/Makefile b/tests/task_setscheduler/Makefile
index 20e1e63..79501b4 100644
--- a/tests/task_setscheduler/Makefile
+++ b/tests/task_setscheduler/Makefile
@@ -1,3 +1,3 @@
 all: source
 clean:
-	rm -f source
+	rm -f source flag
diff --git a/tests/unix_socket/Makefile b/tests/unix_socket/Makefile
index 51ba2c6..f8db20b 100644
--- a/tests/unix_socket/Makefile
+++ b/tests/unix_socket/Makefile
@@ -4,4 +4,4 @@ LDLIBS+= -lselinux
 
 all: $(TARGETS)
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) flag test_client_sock test_server_sock
diff --git a/tests/vsock_socket/Makefile b/tests/vsock_socket/Makefile
index 5266096..7802552 100644
--- a/tests/vsock_socket/Makefile
+++ b/tests/vsock_socket/Makefile
@@ -4,4 +4,4 @@ LDLIBS+= -lselinux
 
 all: $(TARGETS)
 clean:
-	rm -f $(TARGETS)
+	rm -f $(TARGETS) flag
-- 
2.37.2

