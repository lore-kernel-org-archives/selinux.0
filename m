Return-Path: <SRS0=790g=XQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URI_HEX,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7311C4360D
	for <selinux@archiver.kernel.org>; Sat, 21 Sep 2019 21:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9094220C01
	for <selinux@archiver.kernel.org>; Sat, 21 Sep 2019 21:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfIUVap (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 21 Sep 2019 17:30:45 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:33001 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfIUVap (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 21 Sep 2019 17:30:45 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id C2E2E564872
        for <selinux@vger.kernel.org>; Sat, 21 Sep 2019 23:30:41 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] CircleCI: run scan-build and publish its results automatically
Date:   Sat, 21 Sep 2019 23:30:37 +0200
Message-Id: <20190921213037.1121263-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Sep 21 23:30:42 2019 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

CircleCI is a continuous integration system like Travis CI, which
provides different features. Contrary to Travis CI, it is quite harder
to build the project with several build configurations (so it is not a
replacement), but it provides short-term storage for files produced by a
build job in what is called "artifacts".

Use this feature in order to store the results of clang's static
analyzer (scan-build) after every pushed commit. This way makes it
possible to quickly compare the result of the analyzer after applying
some patches that were sent for review to the mailing list, as it no
longer requires running the analyzer several times on the development
machine.

An output example is available at
https://352-118970575-gh.circle-artifacts.com/0/output-scan-build/2019-09-21-164945-6152-1/index.html
These web pages were created by the job described at
https://circleci.com/gh/fishilico/selinux/352

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .circleci/config.yml | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 .circleci/config.yml

diff --git a/.circleci/config.yml b/.circleci/config.yml
new file mode 100644
index 000000000000..5d3177da9956
--- /dev/null
+++ b/.circleci/config.yml
@@ -0,0 +1,40 @@
+# Configuration file for https://circleci.com/
+
+version: 2
+
+jobs:
+  build:
+    docker:
+      # Use a Python image from https://hub.docker.com/r/circleci/python/tags/
+      - image: circleci/python:3.6
+
+    steps:
+    - checkout
+
+    # Install dependencies
+    - run: sudo apt-get update -qq
+    - run: sudo apt-get install -qq bison clang clang-tools flex gawk gettext libaudit-dev libcap-dev libcap-ng-dev libcunit1-dev libdbus-glib-1-dev libpcre3-dev python3-dev python-dev ruby-dev swig xmlto
+
+    - run:
+        name: Setup environment variables
+        command: |
+          echo 'export DESTDIR=$HOME/destdir' >> "$BASH_ENV"
+
+    # Download and install refpolicy headers for sepolgen tests
+    - run:
+        name: Download refpolicy Makefile
+        command: |
+          curl --location --retry 10 -o refpolicy.tar.bz2 https://github.com/SELinuxProject/refpolicy/releases/download/RELEASE_2_20180701/refpolicy-2.20180701.tar.bz2
+          tar -xvjf refpolicy.tar.bz2
+          sed -e "s,^PREFIX :=.*,PREFIX := $DESTDIR/usr," -i refpolicy/support/Makefile.devel
+          sudo make -C refpolicy install-headers
+          sudo mkdir -p /etc/selinux
+          echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
+          echo 'SELINUX_DEVEL_PATH = /usr/share/selinux/refpolicy' | sudo tee /etc/selinux/sepolgen.conf
+          sed -e "s,\"\(/usr/bin/[cs]\),\"$DESTDIR\1," -i python/sepolgen/src/sepolgen/module.py
+
+    # Run clang's scan-build and store the result as artifacts
+    - run: ./scripts/run-scan-build
+    - store_artifacts:
+        path: scripts/output-scan-build
+        destination: output-scan-build
-- 
2.22.0

