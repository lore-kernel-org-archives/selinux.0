Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v75AGtCH020377
 for <selinux@tycho.nsa.gov>; Sat, 5 Aug 2017 06:16:55 -0400
Received: from localhost.localdomain (52.81.152.77.rev.sfr.net [77.152.81.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 77B665646A4
 for <selinux@tycho.nsa.gov>; Sat,  5 Aug 2017 12:16:47 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat,  5 Aug 2017 12:16:48 +0200
Message-Id: <20170805101649.4931-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/2] Travis-CI: use sugulite environment
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Travis-CI provides several environments for Ubuntu 14.04 Trusty. It
chooses the one that best matches the needs defined in .travis.yml
depending on a complex algorithm.

In order to test several C compilers, Python versions and Ruby versions,
we need the full image, which is named "sugulite".

For future reference, there are some notes about using the full image
on https://github.com/travis-ci/packer-templates/pull/454 and
https://github.com/travis-ci/docs-travis-ci-com/issues/1267#issuecomment-316016312
and https://blog.travis-ci.com/2017-06-21-trusty-updates-2017-Q2-launch

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 481ea7dae8bb..27c0013d6e9e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -29,9 +29,10 @@ env:
     - PYVER=python3.6 RUBYLIBVER=2.2
     - PYVER=python3.6 RUBYLIBVER=2.3
 
-# Use Travis-CI Ubuntu 14.04 Trusty infrastructure
+# Use Travis-CI Ubuntu 14.04 Trusty infrastructure, "full image" variant
 sudo: required
 dist: trusty
+group: sugilite
 
 # Install SELinux userspace utilities dependencies
 addons:
-- 
2.13.3
