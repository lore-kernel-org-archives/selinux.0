Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4710C54EE9
	for <selinux@archiver.kernel.org>; Thu, 22 Sep 2022 18:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiIVSEX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Sep 2022 14:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiIVSDy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Sep 2022 14:03:54 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F4DE106534
        for <selinux@vger.kernel.org>; Thu, 22 Sep 2022 11:03:04 -0700 (PDT)
Received: from Matt-Work.localdomain (ip98-168-40-103.ph.ph.cox.net [98.168.40.103])
        by linux.microsoft.com (Postfix) with ESMTPSA id EAF6020B929C;
        Thu, 22 Sep 2022 11:03:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EAF6020B929C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1663869784;
        bh=afB5xaWg/8APtG7KzewYnoWIFq7BumZS0wVMsLXxZmM=;
        h=From:To:Cc:Subject:Date:From;
        b=bwVJ6g4gDzKJJLJ0D+z5F8oVd91Kp0BzbdeKsRr0FrYQRuKmTwYt9F6oa25synOD9
         XJEnDLckOnVqiQ959jGtf8/Rp7rblkgGVkPmKWo5J66bcfbn+vnPC6RSrqAjy4v0kX
         cHVFASM124FqGJVrG1g66gIjiQTY7gUncyIJ05uY=
From:   Matt Sheets <masheets@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     dburgener@linux.microsoft.com
Subject: [PATCH] libsemanage: Allow user to set SYSCONFDIR
Date:   Thu, 22 Sep 2022 11:02:55 -0700
Message-Id: <20220922180255.2923-1-masheets@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This change will allow a user to set the location of their
sysconfdir, defaulted to /etc, if they are installing into
nonstandard locations.

Signed-off-by: Matt Sheets <masheets@linux.microsoft.com>
---
 libsemanage/src/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/Makefile b/libsemanage/src/Makefile
index 71c2a1d2..01df0181 100644
--- a/libsemanage/src/Makefile
+++ b/libsemanage/src/Makefile
@@ -11,6 +11,7 @@ PKG_CONFIG ?= pkg-config
 PREFIX ?= /usr
 LIBDIR ?= $(PREFIX)/lib
 INCLUDEDIR ?= $(PREFIX)/include
+SYSCONFDIR ?= /etc
 PYINC ?= $(shell $(PKG_CONFIG) --cflags $(PYPREFIX))
 PYLIBS ?= $(shell $(PKG_CONFIG) --libs $(PYPREFIX))
 PYTHONLIBDIR ?= $(shell $(PYTHON) -c "from distutils.sysconfig import *; print(get_python_lib(plat_specific=1, prefix='$(PREFIX)'))")
@@ -19,7 +20,7 @@ RUBYINC ?= $(shell $(RUBY) -e 'puts "-I" + RbConfig::CONFIG["rubyarchhdrdir"] +
 RUBYLIBS ?= $(shell $(RUBY) -e 'puts "-L" + RbConfig::CONFIG["libdir"] + " -L" + RbConfig::CONFIG["archlibdir"] + " " + RbConfig::CONFIG["LIBRUBYARG_SHARED"]')
 RUBYINSTALL ?= $(shell $(RUBY) -e 'puts RbConfig::CONFIG["vendorarchdir"]')
 
-DEFAULT_SEMANAGE_CONF_LOCATION=/etc/selinux/semanage.conf
+DEFAULT_SEMANAGE_CONF_LOCATION=$(SYSCONFDIR)/selinux/semanage.conf
 
 ifeq ($(DEBUG),1)
 	export CFLAGS ?= -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
-- 
2.25.1

