Return-Path: <SRS0=o61S=RE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B29C43381
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 13:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6492084D
	for <selinux@archiver.kernel.org>; Fri,  1 Mar 2019 13:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbfCANjW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:39:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbfCANjW (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 1 Mar 2019 08:39:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1322301CE11
        for <selinux@vger.kernel.org>; Fri,  1 Mar 2019 13:39:21 +0000 (UTC)
Received: from workstation (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E94560A9A
        for <selinux@vger.kernel.org>; Fri,  1 Mar 2019 13:39:21 +0000 (UTC)
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     "selinux\@vger.kernel.org" <selinux@vger.kernel.org>
Subject: ANN: SELinux userspace 2.9-rc2 release candidate
Date:   Fri, 01 Mar 2019 14:39:19 +0100
Message-ID: <pjd8sxylnnc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 01 Mar 2019 13:39:21 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


A 2.9-rc2 release candidate for the SELinux userspace is now 
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out 
in
release notes for packagers and users in the final release 
announcement, let us know.

Thanks to all the contributors to this release candidate!

User-visible changes since 2.9-rc1:

* Added russian translations for man pages

* setfiles can once again be used on SELinux-disabled hosts to 
  label files,

* setfiles and restorecon once again correctly ignore files with 
  customizable
types,

* semanage login no longer fails if used with a group that has 
  many members,

* semanage boolean no longer fails if listing for a policy store 
  other than the
active one.

* By default, /usr/bin/python3 is used by Python scripts and for 
  building modules
with python bindings.

Packaging-relevant changes:

* By default, /usr/bin/python3 is used by Python scripts and for 
  building modules
with python bindings. It's possible to switch to Python 2 using 
the following commands:

$ pathfix.py -i/usr/bin/python `git grep -l -E 
'^#!.*/usr/bin/python'`
$ make PYTHON=/usr/bin/python ...


A shortlog of changes since the 2.9-rc1 release is below.

Aleksei Nikiforov (2):
      Add man pages translation by Olesya Gerasimenko
      Allow installing translated man pages

Dan Walsh (2):
      python/semanage: Examples are no longer in the main semanage 
      man page
      dbus: Fix name of polkit function

James Carter (1):
      libsepol: Fix RESOURCE_LEAK defects reported by coverity 
      scan

Nicolas Iooss (7):
      python: reindent lines that were over-indented
      python: use == or != when comparing a variable with a string 
      or a integer
      python/sepolicy: fix variable name
      libsepol: do not use uninitialized value for low_value
      libsepol/cil: silence static analyser's use-after-free 
      warning
      python/sepolicy: drop python shebang from the module
      python: always use python3 in the shebang of programs using 
      setools

Petr Lautrbach (15):
      restorecond: Install DBUS service file with 644 permissions
      libselinux: set an appropriate errno in booleans.c
      libselinux: Change matchpathcon usage to match with 
      matchpathcon manpage
      scripts/release: Update links to use release assets instead 
      of wiki links
      libselinux/selinux_restorecon: Skip customized files also 
      without -v
      python/semanage: Use standard argparse.error() method in 
      handlePermissive
      libselinux: Fix RESOURCE_LEAK defects reported by coverity 
      scan
      libsemanage: genhomedircon - improve handling large groups
      python/semanage: Drop python shebang from seobject.py
      python/semanage: Update semanage to use python3
      python/semanage module: Fix handling of -a/-e/-d/-r options
      Always use /usr/bin/python3 in Python scripts
      Switch to python3 by default
      README: Update Fedora python 3 dependencies
      Update VERSIONs to 2.9-rc2 for release.

Stephen Smalley (2):
      libselinux: fix selinux_restorecon() on non-SELinux hosts
      libselinux: selinux_set_mapping: fix handling of unknown 
      classes/perms

Viktor Ashirov (1):
      python/restorecon: add force option

Vit Mojzis (3):
      python/semanage/seobject: Fix listing boolean values
      checkpolicy: Update manpage
      gui: Make all polgen button labels translatable
