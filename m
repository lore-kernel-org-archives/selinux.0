Return-Path: <SRS0=M2Pn=QY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B67C43381
	for <selinux@archiver.kernel.org>; Sun, 17 Feb 2019 21:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C5421855
	for <selinux@archiver.kernel.org>; Sun, 17 Feb 2019 21:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfBQVhN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 Feb 2019 16:37:13 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:54671 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfBQVhN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 Feb 2019 16:37:13 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 21EF5564714
        for <selinux@vger.kernel.org>; Sun, 17 Feb 2019 22:37:10 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/2] python/sepolicy: drop python shebang from the module
Date:   Sun, 17 Feb 2019 22:36:49 +0100
Message-Id: <20190217213650.25974-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 17 22:37:10 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The files in sepolicy's module directory are not supposed to used as
executable files. The shebang line is therefore not needed.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 python/sepolicy/sepolicy/__init__.py    | 2 --
 python/sepolicy/sepolicy/booleans.py    | 1 -
 python/sepolicy/sepolicy/communicate.py | 1 -
 python/sepolicy/sepolicy/generate.py    | 2 --
 python/sepolicy/sepolicy/gui.py         | 2 --
 python/sepolicy/sepolicy/interface.py   | 2 --
 python/sepolicy/sepolicy/manpage.py     | 1 -
 python/sepolicy/sepolicy/network.py     | 1 -
 python/sepolicy/sepolicy/transition.py  | 1 -
 9 files changed, 13 deletions(-)

diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
index 6f7294726be4..6aed31bddf1e 100644
--- a/python/sepolicy/sepolicy/__init__.py
+++ b/python/sepolicy/sepolicy/__init__.py
@@ -1,5 +1,3 @@
-#!/usr/bin/python
-
 # Author: Dan Walsh <dwalsh@redhat.com>
 # Author: Ryan Hallisey <rhallise@redhat.com>
 # Author: Jason Zaman <perfinion@gentoo.org>
diff --git a/python/sepolicy/sepolicy/booleans.py b/python/sepolicy/sepolicy/booleans.py
index cf5f1ffc6469..ad07ab045d3e 100644
--- a/python/sepolicy/sepolicy/booleans.py
+++ b/python/sepolicy/sepolicy/booleans.py
@@ -1,4 +1,3 @@
-#! /usr/bin/python -Es
 # Copyright (C) 2012 Red Hat
 # see file 'COPYING' for use and warranty information
 #
diff --git a/python/sepolicy/sepolicy/communicate.py b/python/sepolicy/sepolicy/communicate.py
index 299316e0bf27..374002204f84 100755
--- a/python/sepolicy/sepolicy/communicate.py
+++ b/python/sepolicy/sepolicy/communicate.py
@@ -1,4 +1,3 @@
-#! /usr/bin/python -Es
 # Copyright (C) 2012 Red Hat
 # see file 'COPYING' for use and warranty information
 #
diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index 5a2195b8033f..019e7836c597 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -1,5 +1,3 @@
-#!/usr/bin/python -Es
-#
 # Copyright (C) 2007-2012 Red Hat
 # see file 'COPYING' for use and warranty information
 #
diff --git a/python/sepolicy/sepolicy/gui.py b/python/sepolicy/sepolicy/gui.py
index d4bf3b48e629..00fd7a11dab8 100644
--- a/python/sepolicy/sepolicy/gui.py
+++ b/python/sepolicy/sepolicy/gui.py
@@ -1,5 +1,3 @@
-#!/usr/bin/python -Es
-#
 # Copyright (C) 2013 Red Hat
 # see file 'COPYING' for use and warranty information
 #
diff --git a/python/sepolicy/sepolicy/interface.py b/python/sepolicy/sepolicy/interface.py
index 27c37bb8e1f8..583091ae18aa 100644
--- a/python/sepolicy/sepolicy/interface.py
+++ b/python/sepolicy/sepolicy/interface.py
@@ -1,5 +1,3 @@
-#!/usr/bin/python -Es
-#
 # Copyright (C) 2012 Red Hat
 # see file 'COPYING' for use and warranty information
 #
diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
index af18b6ffc12f..1d367962365a 100755
--- a/python/sepolicy/sepolicy/manpage.py
+++ b/python/sepolicy/sepolicy/manpage.py
@@ -1,4 +1,3 @@
-#! /usr/bin/python -Es
 # Copyright (C) 2012-2013 Red Hat
 # AUTHOR: Dan Walsh <dwalsh@redhat.com>
 # AUTHOR: Miroslav Grepl <mgrepl@redhat.com>
diff --git a/python/sepolicy/sepolicy/network.py b/python/sepolicy/sepolicy/network.py
index 115f6b8778d5..34267d929b0d 100755
--- a/python/sepolicy/sepolicy/network.py
+++ b/python/sepolicy/sepolicy/network.py
@@ -1,4 +1,3 @@
-#! /usr/bin/python -Es
 # Copyright (C) 2012 Red Hat
 # see file 'COPYING' for use and warranty information
 #
diff --git a/python/sepolicy/sepolicy/transition.py b/python/sepolicy/sepolicy/transition.py
index 7dea80597dc1..6414a765d0fa 100755
--- a/python/sepolicy/sepolicy/transition.py
+++ b/python/sepolicy/sepolicy/transition.py
@@ -1,4 +1,3 @@
-#! /usr/bin/python -Es
 # Copyright (C) 2011 Red Hat
 # see file 'COPYING' for use and warranty information
 #
-- 
2.20.1

