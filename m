Return-Path: <SRS0=VF96=T5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2904DC28CC0
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 16:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0740023CBC
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 16:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfE2QDo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 May 2019 12:03:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfE2QDo (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 29 May 2019 12:03:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 653CD30BB379
        for <selinux@vger.kernel.org>; Wed, 29 May 2019 16:03:44 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-164.brq.redhat.com [10.40.204.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 799A52D22B;
        Wed, 29 May 2019 16:03:43 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] Add CONTRIBUTING
Date:   Wed, 29 May 2019 18:03:37 +0200
Message-Id: <20190529160337.4672-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 29 May 2019 16:03:44 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Based on https://github.com/SELinuxProject/selinux/wiki/Contributing

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 CONTRIBUTING | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 CONTRIBUTING

diff --git a/CONTRIBUTING b/CONTRIBUTING
new file mode 100644
index 00000000..784d2023
--- /dev/null
+++ b/CONTRIBUTING
@@ -0,0 +1,60 @@
+# Contributing to SELinux
+
+Contributing to the SELinux userspace project is a similar process to
+other open source projects. Bug reports, new features to the existing
+code, additional tools, or updated documentation are all welcome.
+
+You can find a list of open issues where you might contribute to the SELinux kernel code at
+https://github.com/SELinuxProject/selinux-kernel/issues or to the SELinux userspace code at
+https://github.com/SELinuxProject/selinux/issues.
+
+See the selinuxproject.org http://selinuxproject.org/page/User_Resources page for more
+information on mailing lists, documentation, and other resources.
+
+## Reporting Bugs
+
+All bugs and patches should be submitted to the SELinux mailing
+list at selinux@vger.kernel.org - https://lore.kernel.org/selinux .
+
+When reporting bugs please include versions of SELinux related libraries and
+tools (libsepol, libselinux, libsemanage, checkpolicy). If you are
+using a custom policy please include it as well.
+
+## Compiling
+
+There are a number of dependencies required to build the userspace
+tools/libraries. On a Fedora system you can install them with yum:
+
+    # yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python3-devel python3-setools swig xmlto redhat-rpm-config
+
+
+The tools and libraries can be built and installed under a private directory from the top level with make, e.g.
+
+    $ make DESTDIR=~/obj install install-pywrap
+
+## Contributing Code
+
+After obtaining the code of the repository (see below), create a patch
+against the repository, and post that patch to the SELinux mailing
+list at selinux@vger.kernel.org - https://lore.kernel.org/selinux .
+When preparing patches, please follow these guidelines:
+
+-   Patches should apply with -p1
+-   Must apply against HEAD of the master branch
+-   Separate large patches into logical patches
+-   Patch descriptions must end with your "Signed-off-by" line.
+    This means your code meets the Developer's certificate of origin -
+    https://developercertificate.org/.
+
+When adding new, large features or tools it is best to discuss the
+design on the mailing list prior to submitting the patch.
+
+## Development Repository
+
+Git is a modern source code management system. For more information
+about Git please see the Git website.
+
+To get an anonymous checkout of the SELinux userland repository you can
+run:
+
+    $ git clone <https://github.com/SELinuxProject/selinux
-- 
2.22.0.rc1

