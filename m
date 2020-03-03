Return-Path: <SRS0=zB1t=4U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B835C3F2C6
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 08:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1F820842
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 08:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0Un3jag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgCCIwm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:52:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31557 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725840AbgCCIwm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Mar 2020 03:52:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583225560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=axPOVdLJ9+wQHBB3tzzlBJWytVDi8CS2/NLbqQT6bZ0=;
        b=H0Un3jag9lm2ISVio+xTUuFrFIHnh9x+c/HqXdekhXRbCD4kmL+MXLcoqzbVNeFrGgbbKo
        asmiegkLFqvZOk42NvWkTWO+HDOaeqwXSEMtoblMRJgNEMHvtdkqiiHkbWWuw7+gPq2FHQ
        6E654T5+8UPD/XIFz9jHv5bgQAm1jVw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-M1Cwu3o2Og-WFo8rENqfyQ-1; Tue, 03 Mar 2020 03:52:37 -0500
X-MC-Unique: M1Cwu3o2Og-WFo8rENqfyQ-1
Received: by mail-wm1-f69.google.com with SMTP id b23so793441wmj.3
        for <selinux@vger.kernel.org>; Tue, 03 Mar 2020 00:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=axPOVdLJ9+wQHBB3tzzlBJWytVDi8CS2/NLbqQT6bZ0=;
        b=HgkvadJ4GryhB3DzMjAn3VfMazlbblobce4E/JxWy4VxZF65ld0jzBzG5+t1KLh59W
         SpDKGnX8yc0LF7aeFvXWKWmh0aiJ5t8e8UxUA2uyr+5Ch83Eh/aTTbt2Z+3syrQykc8T
         Ooa+BU7+FZhTE7yvGLxvc0BXdObypmOQlpq5ypNJTgaxWVPwFNp1crkXa+zn74pYQpDZ
         VPba0Yxu5i4E7WE1UBjiHHL/P8DTPb9nmrbBoHwxXprWEPPjcDT3U57bCKoLOcS9Q9WC
         fj5DEeagL9WHLYaDbnsIUDcAIA7lA5mF/JIvHAeKu3GpvzF6rthmVnVC3RBK/0pOIH+h
         12Ug==
X-Gm-Message-State: ANhLgQ18wBlcd5Bx6xLPpZ2Hvi1I61z7XtkOus/lmiEcwHOl5Cja9XOJ
        hbyWSQChSudATig4eWaG2lP7/w73OltpV6ouEk9Y6fE2Bsj4G1h/v2Boz3ekoIpAWwgfwjEnLNP
        xKbC+xBYUQepiZE1FEQ==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr4286265wrs.223.1583225555989;
        Tue, 03 Mar 2020 00:52:35 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtykGSKURCrBOcvyiTlg9dohdFeDws3jTtay/9BQ69OE80ekr8/mnFpMZl44bP/L8R6OZ7CIQ==
X-Received: by 2002:adf:fe4f:: with SMTP id m15mr4286241wrs.223.1583225555648;
        Tue, 03 Mar 2020 00:52:35 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f6sm2696608wmh.29.2020.03.03.00.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 00:52:34 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Joshua Brindle <joshua.brindle@crunchydata.com>
Subject: [PATCH testsuite] tests: add test for default_range glblub support
Date:   Tue,  3 Mar 2020 09:52:33 +0100
Message-Id: <20200303085233.137371-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Adds a basic test for the "glblub" default_range mode introduced in
kernel commit [1] and userspace commit [2]. The test vectors are taken
from the original commit messages.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42345b68c2e3e2b6549fc34b937ff44240dfc3b6
[2] https://github.com/SELinuxProject/selinux/commit/9ba35fe8c280b7c91ec65b138d9f13e44ededaa9

Cc: Joshua Brindle <joshua.brindle@crunchydata.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policy/Makefile               | 10 ++++++--
 policy/test_glblub.cil        | 35 ++++++++++++++++++++++++++++
 tests/Makefile                | 16 +++++++++++--
 tests/glblub/.gitignore       |  1 +
 tests/glblub/Makefile         |  7 ++++++
 tests/glblub/compute_create.c | 22 ++++++++++++++++++
 tests/glblub/test             | 44 +++++++++++++++++++++++++++++++++++
 7 files changed, 131 insertions(+), 4 deletions(-)
 create mode 100644 policy/test_glblub.cil
 create mode 100644 tests/glblub/.gitignore
 create mode 100644 tests/glblub/Makefile
 create mode 100644 tests/glblub/compute_create.c
 create mode 100755 tests/glblub/test

diff --git a/policy/Makefile b/policy/Makefile
index cf8d431..0dac911 100644
--- a/policy/Makefile
+++ b/policy/Makefile
@@ -29,6 +29,8 @@ TARGETS = \
 	test_mmap.te test_overlayfs.te test_mqueue.te \
 	test_ibpkey.te test_atsecure.te test_cgroupfs.te
 
+CIL_MODS=
+
 ifeq ($(shell [ $(POL_VERS) -ge 24 ] && echo true),true)
 TARGETS += test_bounds.te test_nnp_nosuid.te
 endif
@@ -124,6 +126,10 @@ endif
 endif
 endif
 
+ifeq ($(shell test $(POL_VERS) -ge 32 && test $(MAX_KERNEL_POLICY) -ge 32 && echo true),true)
+CIL_MODS += test_glblub.cil
+endif
+
 ifeq (x$(DISTRO),$(filter x$(DISTRO),xRHEL4 xRHEL5 xRHEL6))
 TARGETS:=$(filter-out test_overlayfs.te test_mqueue.te test_ibpkey.te, $(TARGETS))
 endif
@@ -151,12 +157,12 @@ build: $(TARGETS)
 load: expand_check all
 	# General policy load
 	@-/usr/sbin/setsebool allow_domain_fd_use=0
-	$(SEMODULE) -i test_policy/test_policy.pp
+	$(SEMODULE) -i test_policy/test_policy.pp $(addprefix -i ,$(CIL_MODS))
 
 unload:
 	# General policy unload
 	@-/usr/sbin/setsebool allow_domain_fd_use=1
-	$(SEMODULE) -r test_policy
+	$(SEMODULE) -r test_policy $(addprefix -r ,$(basename $(CIL_MODS)))
 
 clean:
 	rm -rf test_policy tmp
diff --git a/policy/test_glblub.cil b/policy/test_glblub.cil
new file mode 100644
index 0000000..606a61c
--- /dev/null
+++ b/policy/test_glblub.cil
@@ -0,0 +1,35 @@
+;;; Policy stub for testing default_range glblub (forces 16 MLS levels)
+
+(sensitivity s1)
+(sensitivity s2)
+(sensitivity s3)
+(sensitivity s4)
+(sensitivity s5)
+(sensitivity s6)
+(sensitivity s7)
+(sensitivity s8)
+(sensitivity s9)
+(sensitivity s10)
+(sensitivity s11)
+(sensitivity s12)
+(sensitivity s13)
+(sensitivity s14)
+(sensitivity s15)
+(sensitivityorder (s0 s1 s2 s3 s4 s5 s6 s7 s8 s9 s10 s11 s12 s13 s14 s15))
+(sensitivitycategory s1  (range c0 c1023))
+(sensitivitycategory s2  (range c0 c1023))
+(sensitivitycategory s3  (range c0 c1023))
+(sensitivitycategory s4  (range c0 c1023))
+(sensitivitycategory s5  (range c0 c1023))
+(sensitivitycategory s6  (range c0 c1023))
+(sensitivitycategory s7  (range c0 c1023))
+(sensitivitycategory s8  (range c0 c1023))
+(sensitivitycategory s9  (range c0 c1023))
+(sensitivitycategory s10 (range c0 c1023))
+(sensitivitycategory s11 (range c0 c1023))
+(sensitivitycategory s12 (range c0 c1023))
+(sensitivitycategory s13 (range c0 c1023))
+(sensitivitycategory s14 (range c0 c1023))
+(sensitivitycategory s15 (range c0 c1023))
+(userrange system_u ((s0) (s15 (range c0 c1023))))
+(defaultrange db_table glblub)
diff --git a/tests/Makefile b/tests/Makefile
index 46a1641..134c240 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -1,6 +1,14 @@
-INCLUDEDIR ?= /usr/include
-POLDEV ?= /usr/share/selinux/devel
+PREFIX ?= /usr
+BINDIR ?= $(PREFIX)/bin
+INCLUDEDIR ?= $(PREFIX)/include
+POLDEV ?= $(PREFIX)/share/selinux/devel
 SELINUXFS ?= /sys/fs/selinux
+CHECKPOLICY = $(BINDIR)/checkpolicy
+CHECKMODULE = $(BINDIR)/checkmodule
+
+POL_VERS := $(shell $(CHECKPOLICY) -V |cut -f 1 -d ' ')
+MOD_POL_VERS := $(shell $(CHECKMODULE) -V |cut -f 2 -d '-')
+MAX_KERNEL_POLICY := $(shell cat $(SELINUXFS)/policyvers)
 
 export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
 
@@ -104,6 +112,10 @@ SUBDIRS += fs_filesystem
 endif
 endif
 
+ifeq ($(shell test $(POL_VERS) -ge 32 && test $(MAX_KERNEL_POLICY) -ge 32 && echo true),true)
+SUBDIRS += glblub
+endif
+
 ifeq ($(DISTRO),RHEL4)
     SUBDIRS:=$(filter-out bounds dyntrace dyntrans inet_socket mmap nnp_nosuid overlay unix_socket, $(SUBDIRS))
 endif
diff --git a/tests/glblub/.gitignore b/tests/glblub/.gitignore
new file mode 100644
index 0000000..922a20a
--- /dev/null
+++ b/tests/glblub/.gitignore
@@ -0,0 +1 @@
+compute_create
diff --git a/tests/glblub/Makefile b/tests/glblub/Makefile
new file mode 100644
index 0000000..2d6f3fa
--- /dev/null
+++ b/tests/glblub/Makefile
@@ -0,0 +1,7 @@
+TARGETS=compute_create
+
+LDLIBS += -lselinux
+
+all: $(TARGETS)
+clean:
+	rm -f $(TARGETS)
diff --git a/tests/glblub/compute_create.c b/tests/glblub/compute_create.c
new file mode 100644
index 0000000..01f6e75
--- /dev/null
+++ b/tests/glblub/compute_create.c
@@ -0,0 +1,22 @@
+#include <selinux/selinux.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+int main(int argc, char **argv)
+{
+	const char *scon = argv[1];
+	const char *tcon = argv[2];
+	const char *tclass = argv[3];
+	char *res = NULL;
+
+	security_class_t cls = string_to_security_class(tclass);
+
+	int rc = security_compute_create(scon, tcon, cls, &res);
+
+	if (rc)
+		return 1;
+
+	printf("%s\n", res);
+	free(res);
+	return 0;
+}
diff --git a/tests/glblub/test b/tests/glblub/test
new file mode 100755
index 0000000..a9160b6
--- /dev/null
+++ b/tests/glblub/test
@@ -0,0 +1,44 @@
+#!/usr/bin/perl
+
+# Basic test for default_range glblub option
+
+use Test;
+BEGIN { plan tests => 8 }
+
+$basedir = $0;
+$basedir =~ s|(.*)/[^/]*|$1|;
+
+sub run_check {
+    my ( $src, $tgt, $res ) = @_;
+
+    my $context_base = "system_u:object_r:unlabeled_t";
+
+    my $result =
+      `$basedir/compute_create $context_base:$src $context_base:$tgt db_table`;
+
+    ok( $result eq "$context_base:$res\n" );
+}
+
+sub run_check_fail {
+    my ( $src, $tgt, $res ) = @_;
+
+    my $context_base = "system_u:object_r:unlabeled_t";
+
+    ok(
+        system(
+"$basedir/compute_create $context_base:$src $context_base:$tgt db_table"
+        )
+    );
+}
+
+run_check( "s0:c1,c2,c5-s0:c1.c20", "s0:c0.c20-s0:c0.c36",
+    "s0:c1,c2,c5-s0:c1.c20" );
+
+run_check( "s0-s1:c0.c12",  "s0",             "s0" );
+run_check( "s0-s1:c0.c12",  "s0-s1:c0.c1023", "s0-s1:c0.c12" );
+run_check( "s0-s4:c0.c512", "s1-s1:c0.c1023", "s1-s1:c0.c512" );
+run_check( "s0-s15:c0,c2",  "s4-s6:c0.c128",  "s4-s6:c0,c2" );
+run_check( "s0-s4",         "s2-s6",          "s2-s4" );
+
+run_check_fail( "s0-s4", "s5-s8" );
+run_check_fail( "s5-s8", "s0-s4" );
-- 
2.24.1

