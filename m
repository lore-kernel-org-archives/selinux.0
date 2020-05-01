Return-Path: <SRS0=RO9B=6P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3958C47253
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 09:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF4BE2173E
	for <selinux@archiver.kernel.org>; Fri,  1 May 2020 09:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgEAJ01 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 May 2020 05:26:27 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47361 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgEAJ00 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 1 May 2020 05:26:26 -0400
Received: from localhost.localdomain (85-168-38-217.rev.numericable.fr [85.168.38.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 6BFD75649C6
        for <selinux@vger.kernel.org>; Fri,  1 May 2020 11:26:24 +0200 (CEST)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH] README: add much useful information
Date:   Fri,  1 May 2020 11:26:15 +0200
Message-Id: <20200501092615.1143868-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Fri May  1 11:26:24 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

* Add SELinux logo
* Add a link to Travis-CI
* Add a link to lore.kernel.org archive
* Document that SELinux is packaged in several distributions, providing
  links to policycoreutils package (this package requires libsemanage,
  libselinux, libsepol, etc. so if it is packaged, most sub-projects
  have to also be)
* Make Fedora install command readable on GitHub without scrolling
  horizontally and update it
* Split installed packaged between the dependencies for the "main"
  libraries and programs, and the bindings

  - The install command line has been tested using a container from
    image fedora:31

* Document Debian dependencies

  - The install command line has been tested using a container from
    image debian:10

* Document running `make test` with `./scripts/env_use_destdir`
* Introduce "macOS" section for instructions specific to macOS.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---

The rendered README is currently available on my GitHub repo:
https://github.com/fishilico/selinux/blob/wip/README.md

 README.md | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index 974280f9d14f..f3257ef52d21 100644
--- a/README.md
+++ b/README.md
@@ -1,22 +1,107 @@
 SELinux Userspace
 =================
 
+![SELinux logo](https://github.com/SELinuxProject.png)
+[![Build Status](https://travis-ci.org/SELinuxProject/selinux.svg?branch=master)](https://travis-ci.org/SELinuxProject/selinux)
+
 Please submit all bug reports and patches to <selinux@vger.kernel.org>.
 
 Subscribe by sending "subscribe selinux" in the body of an email
 to <majordomo@vger.kernel.org>.
 
+Archive of this mailing list is available on https://lore.kernel.org/selinux/.
+
+
 Installation
 ------------
 
-Build dependencies on Fedora:
+SELinux libraries and tools are packaged in several Linux distributions:
+
+* Alpine Linux (https://pkgs.alpinelinux.org/package/edge/testing/x86/policycoreutils)
+* Arch Linux User Repository (https://aur.archlinux.org/packages/policycoreutils/)
+* Buildroot (https://git.buildroot.net/buildroot/tree/package/policycoreutils)
+* Debian and Ubuntu (https://packages.debian.org/sid/policycoreutils)
+* Gentoo (https://packages.gentoo.org/packages/sys-apps/policycoreutils)
+* RHEL and Fedora (https://src.fedoraproject.org/rpms/policycoreutils)
+* Yocto Project (http://git.yoctoproject.org/cgit/cgit.cgi/meta-selinux/tree/recipes-security/selinux)
+* and many more (https://repology.org/project/policycoreutils/versions)
+
+
+Building and testing
+--------------------
 
-    yum install audit-libs-devel bison bzip2-devel dbus-devel dbus-glib-devel flex flex-devel flex-static glib2-devel libcap-devel libcap-ng-devel pam-devel pcre-devel python3-devel python3-setools swig xmlto redhat-rpm-config
+Build dependencies on Fedora:
 
+```sh
+# For C libraries and programs
+dnf install \
+    audit-libs-devel \
+    bison \
+    bzip2-devel \
+    CUnit-devel \
+    diffutils \
+    flex \
+    gcc \
+    gettext \
+    glib2-devel \
+    make \
+    libcap-devel \
+    libcap-ng-devel \
+    pam-devel \
+    pcre-devel \
+    xmlto
+
+# For Python and Ruby bindings
+dnf install \
+    python3-devel \
+    ruby-devel \
+    swig
+```
+
+Build dependencies on Debian:
+
+```sh
+# For C libraries and programs
+apt-get install --no-install-recommends --no-install-suggests \
+    bison \
+    flex \
+    gawk \
+    gcc \
+    gettext \
+    make \
+    libaudit-dev \
+    libbz2-dev \
+    libcap-dev \
+    libcap-ng-dev \
+    libcunit1-dev \
+    libglib2.0-dev \
+    libpcre3-dev \
+    pkgconf \
+    python3 \
+    python3-distutils \
+    systemd \
+    xmlto
+
+# For Python and Ruby bindings
+apt-get install --no-install-recommends --no-install-suggests \
+    python3-dev \
+    ruby-dev \
+    swig
+```
 
 To build and install everything under a private directory, run:
 
-    make DESTDIR=~/obj install install-pywrap
+    make clean distclean
+
+    make DESTDIR=~/obj install install-rubywrap install-pywrap
+
+To run tests with the built libraries and programs, several paths (relative to `$DESTDIR`) need to be added to variables `$LD_LIBRARY_PATH`, `$PATH` and `$PYTHONPATH`.
+This can be done using [./scripts/env_use_destdir](./scripts/env_use_destdir):
+
+    DESTDIR=~/obj ./scripts/env_use_destdir make test
+
+Some tests require the reference policy to be installed (for example in `python/sepolgen`).
+In order to run these ones, instructions similar to the ones in section `install` of [./.travis.yml](./.travis.yml) can be executed.
 
 To install as the default system libraries and binaries
 (overwriting any previously installed ones - dangerous!),
@@ -32,6 +117,10 @@ This may render your system unusable if the upstream SELinux userspace
 lacks library functions or other dependencies relied upon by your
 distribution.  If it breaks, you get to keep both pieces.
 
+
+macOS
+-----
+
 To install libsepol on macOS (mainly for policy analysis):
 
     cd libsepol; make PREFIX=/usr/local install
-- 
2.26.2

