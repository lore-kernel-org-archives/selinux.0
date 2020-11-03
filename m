Return-Path: <SRS0=PQdl=EJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC270C2D0A3
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 11:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D73208B6
	for <selinux@archiver.kernel.org>; Tue,  3 Nov 2020 11:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=btinternet.com header.i=@btinternet.com header.b="Aik9rD89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKCLB4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Nov 2020 06:01:56 -0500
Received: from mailomta1-re.btinternet.com ([213.120.69.94]:52797 "EHLO
        re-prd-fep-044.btinternet.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727742AbgKCLBz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Nov 2020 06:01:55 -0500
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20201103110145.HJFI29010.re-prd-fep-044.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>;
          Tue, 3 Nov 2020 11:01:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=btmx201904; t=1604401305; 
        bh=br/mumTVz4PLvr4YLRBY1pN5jFQH1GsAGR4f/xdmUoo=;
        h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version;
        b=Aik9rD89sJZ2OXf/fB30WtzU5B7rYpr8JoUPDrdPzfZg/1aGw+bg/dqgNEvVqEJ/aFas87NyByWjW2pvgCw13EjCXw3gsnW1Bc79Leef2b53QNnbrcexS9lGMoPaDR4uLQjyG0Ij2z8Ol8pwDeWmpjwzGlH6QNbV+rgqJAbq8Sd7LsyZA2l21RWZsUEdM9vCJxn+P4/gf6UlHNmmtbzeV52ewnxFPdfxiNDJWJA/kA9fILDoaI5djg+bLu4iL4vnUGULNsI8ZBJRB9D7HAdsRP5+BQWFU6pRU9R3q8OSgM2JE+yivzz/4OxLHjQDZ09irI8oewRLeN04iZTQWKXwdw==
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9C50618916944
X-Originating-IP: [86.148.106.153]
X-OWM-Source-IP: 86.148.106.153 (GB)
X-OWM-Env-Sender: richard_c_haines@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddtfedgvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftihgthhgrrhguucfjrghinhgvshcuoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeeutddtleelheeugefgiefhiedtheeukeffveeitdffgeffieeugeeljeegvefgieenucfkphepkeeirddugeekrddutdeirdduheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegkedruddtiedrudehfedpmhgrihhlfhhrohhmpeeorhhitghhrghruggptggphhgrihhnvghssegsthhinhhtvghrnhgvthdrtghomheqpdhrtghpthhtohepoehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmqecuqfftvefrvfeprhhftgekvddvnehrihgthhgrrhgupggtpghhrghinhgvshessghtihhnthgvrhhnvghtrdgtohhmpdhrtghpthhtohepoehsvghlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-SNCR-hdrdom: btinternet.com
Received: from localhost.localdomain (86.148.106.153) by re-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as richard_c_haines@btinternet.com)
        id 5ED9C50618916944; Tue, 3 Nov 2020 11:01:45 +0000
From:   Richard Haines <richard_c_haines@btinternet.com>
To:     selinux@vger.kernel.org
Cc:     Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH V2 1/1] selinux-testsuite: Add btrfs support for filesystem tests
Date:   Tue,  3 Nov 2020 11:01:21 +0000
Message-Id: <20201103110121.53919-2-richard_c_haines@btinternet.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103110121.53919-1-richard_c_haines@btinternet.com>
References: <20201103110121.53919-1-richard_c_haines@btinternet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This allows btrfs filesystems to be created to support the
filesystem mount(2) type calls and the fs_filesystem fsmount(2)
type calls.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 README.md                      |  3 +++
 defconfig                      |  4 ++++
 tests/Makefile                 |  2 +-
 tests/filesystem/Filesystem.pm | 10 +++++++++-
 tests/filesystem/btrfs         |  1 +
 tests/filesystem/test          |  6 ++++++
 tests/fs_filesystem/btrfs      |  1 +
 tests/fs_filesystem/test       |  6 ++++++
 travis-ci/run-testsuite.sh     |  1 +
 9 files changed, 32 insertions(+), 2 deletions(-)
 create mode 120000 tests/filesystem/btrfs
 create mode 120000 tests/fs_filesystem/btrfs

diff --git a/README.md b/README.md
index 4a22389..6134270 100644
--- a/README.md
+++ b/README.md
@@ -61,6 +61,7 @@ similar dependencies):
 * e2fsprogs _(used by the ext4 filesystem tests)_
 * jfsutils _(used by the jfs filesystem tests)_
 * dosfstools _(used by the vfat filesystem tests)_
+* btrfs-progs _(used by the btrfs filesystem tests)_
 * nftables _(used by inet_socket and sctp tests if ver >= 9.3 for secmark testing )_
 
 On a modern Fedora system you can install these dependencies with the
@@ -87,6 +88,7 @@ following command (NOTE: On Fedora 32 and below you need to remove
 		e2fsprogs \
 		jfsutils \
 		dosfstools \
+		btrfs-progs \
 		nftables \
 		kernel-devel-$(uname -r) \
 		kernel-modules-$(uname -r)
@@ -134,6 +136,7 @@ command:
 		e2fsprogs \
 		jfsutils \
 		dosfstools \
+		btrfs-progs \
 		nftables
 
 On Debian, you need to build and install netlabel_tools manually since
diff --git a/defconfig b/defconfig
index 46eb673..5a8fb1a 100644
--- a/defconfig
+++ b/defconfig
@@ -117,3 +117,7 @@ CONFIG_VFAT_FS=m
 # They are not required for SELinux operation itself.
 CONFIG_WATCH_QUEUE=y
 CONFIG_KEY_NOTIFICATIONS=y
+
+# Test BTRFS filesystem.
+# This is not required for SELinux operation itself.
+CONFIG_BTRFS_FS=y
diff --git a/tests/Makefile b/tests/Makefile
index b441031..3920380 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -4,7 +4,7 @@ SBINDIR ?= $(PREFIX)/sbin
 POLDEV ?= $(PREFIX)/share/selinux/devel
 INCLUDEDIR ?= $(PREFIX)/include
 SELINUXFS ?= /sys/fs/selinux
-FILESYSTEMS ?= ext4 xfs jfs vfat
+FILESYSTEMS ?= ext4 xfs jfs vfat btrfs
 
 export CFLAGS+=-g -O0 -Wall -D_GNU_SOURCE
 
diff --git a/tests/filesystem/Filesystem.pm b/tests/filesystem/Filesystem.pm
index c14e760..55e3d75 100644
--- a/tests/filesystem/Filesystem.pm
+++ b/tests/filesystem/Filesystem.pm
@@ -122,10 +122,18 @@ sub attach_dev {
 
 sub make_fs {
     my ( $mk_type, $mk_dev, $mk_dir ) = @_;
+
+    # BTRFS requires a larger minimum size that takes >2x longer to generate
+    if ( $mk_type eq "btrfs" ) {
+        $count = "28000";
+    }
+    else {
+        $count = "4096";
+    }
     print "Create $mk_dir/fstest with dd\n";
     $result =
       system(
-        "dd if=/dev/zero of=$mk_dir/fstest bs=4096 count=4096 2>/dev/null");
+        "dd if=/dev/zero of=$mk_dir/fstest bs=4096 count=$count 2>/dev/null");
     if ( $result != 0 ) {
         print "dd failed to create $mk_dir/fstest\n";
     }
diff --git a/tests/filesystem/btrfs b/tests/filesystem/btrfs
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/filesystem/btrfs
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/filesystem/test b/tests/filesystem/test
index c94deda..dcd4704 100755
--- a/tests/filesystem/test
+++ b/tests/filesystem/test
@@ -78,6 +78,12 @@ BEGIN {
         $test_count   = 55;
         $quota_checks = 0;
     }
+
+    # BTRFS uses internal quotas requiring no security hooks
+    elsif ( $fs_type eq "btrfs" ) {
+        $test_count   = 55;
+        $quota_checks = 0;
+    }
     else {
         $test_count = 69;
     }
diff --git a/tests/fs_filesystem/btrfs b/tests/fs_filesystem/btrfs
new file mode 120000
index 0000000..945c9b4
--- /dev/null
+++ b/tests/fs_filesystem/btrfs
@@ -0,0 +1 @@
+.
\ No newline at end of file
diff --git a/tests/fs_filesystem/test b/tests/fs_filesystem/test
index e706e42..59f7ea3 100755
--- a/tests/fs_filesystem/test
+++ b/tests/fs_filesystem/test
@@ -81,6 +81,12 @@ BEGIN {
         $test_count   = 54;
         $quota_checks = 0;
     }
+
+    # BTRFS uses internal quotas requiring no security hooks
+    elsif ( $fs_type eq "btrfs" ) {
+        $test_count   = 54;
+        $quota_checks = 0;
+    }
     else {
         $test_count = 68;
     }
diff --git a/travis-ci/run-testsuite.sh b/travis-ci/run-testsuite.sh
index bd9073c..ed3813f 100755
--- a/travis-ci/run-testsuite.sh
+++ b/travis-ci/run-testsuite.sh
@@ -41,6 +41,7 @@ dnf install -y \
     e2fsprogs \
     jfsutils \
     dosfstools \
+    btrfs-progs \
     kernel-devel-"$(uname -r)" \
     kernel-modules-"$(uname -r)"
 
-- 
2.28.0

