Return-Path: <SRS0=MvMz=PN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E716C43444
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 19:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D79222FF
	for <selinux@archiver.kernel.org>; Sat,  5 Jan 2019 19:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAETiL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:38:11 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:35695 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfAETiL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 5 Jan 2019 14:38:11 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A13E05647FC
        for <selinux@vger.kernel.org>; Sat,  5 Jan 2019 20:38:09 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/5] Travis-CI: download refpolicy and install headers
Date:   Sat,  5 Jan 2019 20:37:55 +0100
Message-Id: <20190105193759.3333-2-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190105193759.3333-1-nicolas.iooss@m4x.org>
References: <20190105193759.3333-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Jan  5 20:38:09 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is needed in order to run sepolgen-ifgen in audit2allow testsuite.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 .travis.yml | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 00d0c54a68d7..08a29b2f5adc 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -64,14 +64,16 @@ addons:
     - xmlto
 
 install:
-  # Download refpolicy Makefile for sepolgen tests
-  - sudo mkdir -p /usr/share/selinux/default
-  - sudo curl --retry 10 -o /usr/share/selinux/default/Makefile 'https://raw.githubusercontent.com/SELinuxProject/refpolicy/RELEASE_2_20180114/support/Makefile.devel'
-  - sudo sed "s,^PREFIX :=.*,PREFIX := $TRAVIS_BUILD_DIR/installdir/usr," -i /usr/share/selinux/default/Makefile
-  - sudo mkdir -p /usr/share/selinux/refpolicy/include
-  - sudo curl --retry 10 -o /usr/share/selinux/refpolicy/include/build.conf 'https://raw.githubusercontent.com/SELinuxProject/refpolicy/RELEASE_2_20180114/build.conf'
+  # Download and install refpolicy headers for sepolgen tests
+  - curl --location --retry 10 -o "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2" https://github.com/SELinuxProject/refpolicy/releases/download/RELEASE_2_20180701/refpolicy-2.20180701.tar.bz2
+  - tar -C "$TRAVIS_BUILD_DIR" -xvjf "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2"
+  # Make refpolicy Makefile use the new toolchain when building modules
+  - sed -e "s,^PREFIX :=.*,PREFIX := \$(DESTDIR)/usr," -i "$TRAVIS_BUILD_DIR/refpolicy/support/Makefile.devel"
+  - sudo make -C "$TRAVIS_BUILD_DIR/refpolicy" install-headers
+  - sudo rm -rf "$TRAVIS_BUILD_DIR/refpolicy.tar.bz2" "$TRAVIS_BUILD_DIR/refpolicy"
   - sudo mkdir -p /etc/selinux
   - echo 'SELINUXTYPE=refpolicy' | sudo tee /etc/selinux/config
+  - echo 'SELINUX_DEVEL_PATH = /usr/share/selinux/refpolicy' | sudo tee /etc/selinux/sepolgen.conf
 
   # Make sepolgen tests work without really installing anything in the real root (doing this would conflict with Ubuntu packages)
   - sed -e "s,\"\(/usr/bin/[cs]\),\"$TRAVIS_BUILD_DIR/installdir\1," -i python/sepolgen/src/sepolgen/module.py
-- 
2.20.1

