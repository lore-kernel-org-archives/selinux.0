Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518A5C56202
	for <selinux@archiver.kernel.org>; Wed, 25 Nov 2020 12:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E715E206E5
	for <selinux@archiver.kernel.org>; Wed, 25 Nov 2020 12:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHoJLxyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgKYMyH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 25 Nov 2020 07:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKYMyH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 25 Nov 2020 07:54:07 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDD2C0613D4
        for <selinux@vger.kernel.org>; Wed, 25 Nov 2020 04:54:07 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id x11so1661726plo.19
        for <selinux@vger.kernel.org>; Wed, 25 Nov 2020 04:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=UJ+A3u0hzyWvVjk6F3yEukUoQRTt3q+EV4jpctnxizY=;
        b=BHoJLxygmEzdOtcFgoKcgQ+0IQwSkVtmnuc5Xlpk/lPw9UmjrqjH29q7YzM8+WTbdm
         GbKUiken3Xdnv5smblmPrsmV6o1BF83M8Pp/4aRyfYKtHNs9Bagw5yU+LejVwDtOfc1A
         +IMqLNl6LlXP6QKmlZsPlhTyQnlND7nTiN/JXc/T6meV/bY4lDu8Euq6F2HAV/tyMvaI
         yzTz6jKIm4ISobRTtDv4YptJKXFOw1/ImcAwEuXHCUFOw3P2+6fPslxmfYCwXiMe4T8q
         TjvqU4RaPSRKBXLAvJVyoJdqtpyZPjsdpLiSvpFfus2LdDPhzEiQYMr3aeFHmPUZq7gS
         ZU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=UJ+A3u0hzyWvVjk6F3yEukUoQRTt3q+EV4jpctnxizY=;
        b=cAo17f7DD+Wy7wfQhYBA269OMszp4TVn0oiZxUdOaxWHajwhM2jrENpBuo+/Y2i66/
         4HGLD66Og89P57J4XiJ1md9tEFJJ9WLARRBT4Hj8fN6riMjERXDOGWIgY4yoGHKA45aF
         a7M9oaNByjoZXtI73D/RbMWT8PA4hr25dU4GH+XRzkBTfXw2kh/6qyHRpf8+7vLaYRpS
         BRFVNe6tUCK1qinsPTj7WNvvaCFUJpQaqVNqdP0HQ8Up56rXYxdUok/A8pD7rrhW4Yau
         q/7zhsgZlZZ2gzvF/cj3QqYIEmYsIWwKSeLuVngs2UvWCiXTyHWyeAbV7jjBEf13iGrN
         RDPQ==
X-Gm-Message-State: AOAM532CPSTc2DT6SeKgNuNZzJQrJUW3wtOFqD0624lEBx8hItkWWc2B
        os7IFxtgfk7m7pYhiC0SN7OXbxFNdMw6BkjiYw==
X-Google-Smtp-Source: ABdhPJwufsHb8in+dLz0LjOlS+WT6wRCqdOIn/RDEUzTOjD9UUqmAmCg7SrIkdMKM59GereyALT4pqX8VVoV9XgLLA==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:90a:66c7:: with SMTP id
 z7mr4075610pjl.175.1606308846562; Wed, 25 Nov 2020 04:54:06 -0800 (PST)
Date:   Wed, 25 Nov 2020 04:54:02 -0800
Message-Id: <20201125125402.211692-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v1 1/1] selinux-testsuite: Add userfaultfd test
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, kaleshsingh@google.com, calin@google.com,
        surenb@google.com, jeffv@google.com, kernel-team@android.com,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Confirm SELinux policies are enforced on userfaultfd operations
via secure anon-inode interface.

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 policy/Makefile                 |  2 +-
 policy/userfaultfd.cil          | 17 ++++++++++++
 tests/Makefile                  |  2 +-
 tests/userfaultfd/Makefile      |  3 ++
 tests/userfaultfd/test          | 15 ++++++++++
 tests/userfaultfd/userfaultfd.c | 49 +++++++++++++++++++++++++++++++++
 6 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 policy/userfaultfd.cil
 create mode 100644 tests/userfaultfd/Makefile
 create mode 100755 tests/userfaultfd/test
 create mode 100644 tests/userfaultfd/userfaultfd.c

diff --git a/policy/Makefile b/policy/Makefile
index 6c49091..02e7568 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -36,7 +36,7 @@ SUPPORTS_CIL = n
 endif
 
 ifeq ($(SUPPORTS_CIL),y)
-CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil
+CIL_TARGETS = test_mlsconstrain.cil test_overlay_defaultrange.cil userfaultfd.cil
 ifeq ($(shell [ $(MAX_KERNEL_POLICY) -ge 32 ] && echo true),true)
 ifeq ($(shell [ $(POL_VERS) -ge 32 ] && echo true),true)
 # If other MLS tests get written this can be moved outside of the glblub test
diff --git a/policy/userfaultfd.cil b/policy/userfaultfd.cil
new file mode 100644
index 0000000..0743fff
--- /dev/null
+++ b/policy/userfaultfd.cil
@@ -0,0 +1,17 @@
+(class anon_inode ())
+(classcommon anon_inode file)
+(classorder (unordered anon_inode))
+(type uffd_t)
+; Label the UFFD with uffd_t; this can be specialized per domain
+(typetransition unconfined_t unconfined_t anon_inode "[userfaultfd]"    uffd_t)
+(allow unconfined_t uffd_t (anon_inode (create)))
+; Permit read() and ioctl() on the UFFD;
+; Comment out if you want to test read or basic ioctl enforcement.
+(allow unconfined_t uffd_t (anon_inode (read)))
+(allow unconfined_t uffd_t (anon_inode (ioctl)))
+; Uncomment one of the allowx lines below to test ioctl whitelisting.
+; Currently the first one is uncommented; comment that out if trying another.
+; None
+;(allowx unconfined_t uffd_t (ioctl anon_inode ((0x00))))
+; UFFDIO_API
+(allowx unconfined_t uffd_t (ioctl anon_inode ((0xaa3f))))
diff --git a/tests/Makefile b/tests/Makefile
index 4c00b5f..3871570 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -27,7 +27,7 @@ SUBDIRS:= domain_trans entrypoint execshare exectrace execute_no_trans \
 	task_setnice task_setscheduler task_getscheduler task_getsid \
 	task_getpgid task_setpgid file ioctl capable_file capable_net \
 	capable_sys dyntrans dyntrace bounds nnp_nosuid mmap unix_socket \
-	inet_socket overlay checkreqprot mqueue mac_admin atsecure
+	inet_socket overlay checkreqprot mqueue mac_admin atsecure userfaultfd
 
 ifeq ($(shell grep -q cap_userns $(POLDEV)/include/support/all_perms.spt && echo true),true)
 ifneq ($(shell ./kvercmp $$(uname -r) 4.7),-1)
diff --git a/tests/userfaultfd/Makefile b/tests/userfaultfd/Makefile
new file mode 100644
index 0000000..66d02a1
--- /dev/null
+++ b/tests/userfaultfd/Makefile
@@ -0,0 +1,3 @@
+all: userfaultfd
+clean:
+	rm -f userfaultfd
diff --git a/tests/userfaultfd/test b/tests/userfaultfd/test
new file mode 100755
index 0000000..dd42aa8
--- /dev/null
+++ b/tests/userfaultfd/test
@@ -0,0 +1,15 @@
+#!/usr/bin/perl
+
+use Test;
+
+BEGIN {
+    plan tests => 1;
+}
+
+$basedir = $0;
+$basedir =~ s|(.*)/[^/]*|$1|;
+
+$result = system("$basedir/userfaultfd");
+ok( $result, 0 );
+
+exit;
diff --git a/tests/userfaultfd/userfaultfd.c b/tests/userfaultfd/userfaultfd.c
new file mode 100644
index 0000000..9baebd9
--- /dev/null
+++ b/tests/userfaultfd/userfaultfd.c
@@ -0,0 +1,49 @@
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include <sys/types.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+
+#include <linux/userfaultfd.h>
+
+void print_api(const struct uffdio_api *api)
+{
+	printf("api: %llu\n", api->api);
+	printf("features: %llu\n", api->features);
+	printf("ioctls: %llu\n", api->ioctls);
+
+	printf("\n");
+}
+
+int main (void)
+{
+	long uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0) {
+		perror("syscall(userfaultfd)");
+		return -1;
+	}
+
+	struct uffdio_api api = {0};
+	api.api = UFFD_API;
+	if (ioctl(uffd, UFFDIO_API, &api) < 0) {
+		perror("UFFDIO_API");
+		return -1;
+	}
+
+	print_api(&api);
+
+	struct uffd_msg msg = {0};
+	ssize_t count = read(uffd, &msg, sizeof(msg));
+	if (count < 0) {
+		// Expected to fail as no memory range registered.
+		return 0;
+	} else if (count == 0) {
+		printf("read EOF\n\n");
+	}
+
+	printf("read uffd\n\n");
+
+	return 0;
+}
-- 
2.28.0

