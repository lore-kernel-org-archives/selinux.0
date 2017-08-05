Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v75AHNsv020615
 for <selinux@tycho.nsa.gov>; Sat, 5 Aug 2017 06:17:23 -0400
Received: from localhost.localdomain (52.81.152.77.rev.sfr.net [77.152.81.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id BCD2C5646A5
 for <selinux@tycho.nsa.gov>; Sat,  5 Aug 2017 12:16:49 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  5 Aug 2017 12:16:49 +0200
Message-Id: <20170805101649.4931-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170805101649.4931-1-nicolas.iooss@m4x.org>
References: <20170805101649.4931-1-nicolas.iooss@m4x.org>
Subject: [PATCH 2/2] Travis-CI: do not test gold linkers with clang
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

clang does not know -fuse-ld=gold. It only needs -flto, which
automatically adds -plugin=LLVMgold.so to the linker command line, but
this does not work on Travis-CI because the gold linker plugin is not
installed:

    /usr/bin/ld: /usr/local/clang-3.9.0/bin/../lib/LLVMgold.so: error
    loading plugin: /usr/local/clang-3.9.0/bin/../lib/LLVMgold.so:
    cannot open shared object file: No such file or directory

Disable in the build matrix the combination of linking with special
linkers with using clang.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index 27c0013d6e9e..1b761496dd12 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -29,6 +29,13 @@ env:
     - PYVER=python3.6 RUBYLIBVER=2.2
     - PYVER=python3.6 RUBYLIBVER=2.3
 
+matrix:
+  exclude:
+    - compiler: clang
+      env: PYVER=python3.6 RUBYLIBVER=2.4 LINKER=gold
+    - compiler: clang
+      env: PYVER=python3.6 RUBYLIBVER=2.4 LINKER=bfd
+
 # Use Travis-CI Ubuntu 14.04 Trusty infrastructure, "full image" variant
 sudo: required
 dist: trusty
-- 
2.13.3
