Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7EDC433EF
	for <selinux@archiver.kernel.org>; Wed, 29 Jun 2022 07:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiF2Hcc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiF2Hcc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jun 2022 03:32:32 -0400
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC0C34B8E
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 00:32:29 -0700 (PDT)
Received: from localhost.localdomain (41.169.89.92.rev.sfr.net [92.89.169.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 79E5D564784
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 09:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m4x.org; s=svoboda;
        t=1656486783; bh=ZaBvlgeJSl1ITWOxDjVoDlj+zgNOZC+Tc150KywaNzA=;
        h=From:To:Subject:Date:Message-Id;
        b=Woys/OOi/l7iWAHm3HFfyE4GHIX9oRz2zjq1EsTDcXGY+hdD7EehPKAwYE/SIcidE
         f30Et2PCzH9CgdXEKqO4Odby2DVX99pPUCYpHFgMqOijyIuv1Uhw8vs7v6tNXjvmYj
         4VMX0/e5iPSwy+LELlFWsDb22kJSrdwyxLeRADho=
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 1/1] CircleCI: do not add Debian-specific parameter when invoking setup.py
Date:   Wed, 29 Jun 2022 09:12:54 +0200
Message-Id: <20220629071254.2653210-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Wed Jun 29 09:13:09 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Runners on https://circleci.com/ use a custom version of Python without
Debian-specific patches which added option --install-layout=deb. This
leads to the following error:

    error: option --install-layout not recognized

Fix this by creating a new environment variable dedicated to detect
CircleCI platform.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
Hello,
Even though the https://github.com/SELinuxProject/selinux is not using CircleCI,
I have been using it for some years to generate a scan-build output which is
directly hosted as build artifacts. This commit is about making the CircleCI
work again.

If you are interested about the results, the "pipeline" I am using is on
https://app.circleci.com/pipelines/github/fishilico/selinux?filter=all
and it generates scan-build reports such as
https://output.circle-artifacts.com/output/job/20523141-5b39-4604-913b-78701e506f2b/artifacts/0/output-scan-build/2022-06-28-220742-7144-1/index.html

Cheers,
Nicolas

 .circleci/config.yml   | 1 +
 scripts/run-scan-build | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.circleci/config.yml b/.circleci/config.yml
index af20484b9ca5..a75d34c23959 100644
--- a/.circleci/config.yml
+++ b/.circleci/config.yml
@@ -19,6 +19,7 @@ jobs:
         name: Setup environment variables
         command: |
           echo 'export DESTDIR=$HOME/destdir' >> "$BASH_ENV"
+          echo 'export IS_CIRCLE_CI=1' >> "$BASH_ENV"
 
     # Download and install refpolicy headers for sepolgen tests
     - run:
diff --git a/scripts/run-scan-build b/scripts/run-scan-build
index fad2a887bc5b..9c3bf0877332 100755
--- a/scripts/run-scan-build
+++ b/scripts/run-scan-build
@@ -24,7 +24,7 @@ export PATH="$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR/bin:$PATH
 export PYTHONPATH="$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_python_lib(prefix='/usr'))")"
 export RUBYLIB="$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorlibdir"]'):$DESTDIR/$(${RUBY:-ruby} -e 'puts RbConfig::CONFIG["vendorarchdir"]')"
 
-if [ -f /etc/debian_version ]; then
+if [ -f /etc/debian_version ] && [ -z "${IS_CIRCLE_CI:-}" ] ; then
     export PYTHON_SETUP_ARGS='--install-layout=deb'
 fi
 
-- 
2.36.1

