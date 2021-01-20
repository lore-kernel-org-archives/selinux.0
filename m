Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD1C433DB
	for <selinux@archiver.kernel.org>; Wed, 20 Jan 2021 12:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693102333C
	for <selinux@archiver.kernel.org>; Wed, 20 Jan 2021 12:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbhATMyP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jan 2021 07:54:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28079 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731441AbhATMXQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jan 2021 07:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611145273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QOFPJdnFEcEb0Y33e7OJ5kUxhtmgm6CHXdErXqsvebY=;
        b=Xlgg6sHuwSt22KMOtnzNlhmtIp+YkMsVjMOME6OMB2i0Z58ZUCSPWOuQPPW/KZKEmN5fvp
        JjuIq9w8jEWyJzdpR0lajs1l+gjV53rdAvFcC+tXU7gAL9uS07+C2lHLiPcIqDbFN2KnbC
        hLmMkgDL+koNI8CCzCtSK+GX0jqUT2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-mjK46VNIPX2AAWUo_KLNpQ-1; Wed, 20 Jan 2021 07:21:09 -0500
X-MC-Unique: mjK46VNIPX2AAWUo_KLNpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56ADD19611A9
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 12:21:08 +0000 (UTC)
Received: from localhost (unknown [10.40.195.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB35C27C3F
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 12:21:07 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.2-rc1 release candidate
Date:   Wed, 20 Jan 2021 13:21:06 +0100
Message-ID: <87a6t36bpp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

A 3.2-rc1 release candidate for the SELinux userspace is now=20
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out=20
in release notes for packagers and users in the final release
announcement, let us know.=20

Thanks to all the contributors to this release candidate!

User-visible changes
--------------------

* libsepol implemented a new, more space-efficient form of storing filename
  transitions in the binary policy and reduced the size of the binary policy
=20=20
* libselinux: Use mmap()'ed kernel status page instead of netlink by defaul=
t.
  See "KERNEL STATUS PAGE" section in avc_init(3) for more details.
  Note: if you need to `umount /sys/fs/selinux` you need to use lazy umount=
 -
  `umount -l /sys/fs/selinux` as the kernel status page /sys/fs/selinux/sta=
tus
  stays mapped by processes like systemd, dbus, sshd.
=20=20
* Tools using sepolgen, e.g. audit2allow, print extended permissions in
  hexadecimal
=20=20
* sepolgen sorts extended rules like normal ones

* New log callback levels for enforcing and policy load notices -
  SELINUX_POLICYLOAD, SELINUX_SETENFORCE=20

* Changed userspace AVC setenforce and policy load messages to audit format.

* matchpathcon converted to selabel_lookup() - no more matchpathcon is
  deprecated warning
=20=20
* libsepol and libsemanage dropped old and deprecated symbols and functions
  libsepol version was bumped to libsepol.so.2
  libsemanage version was bumped to libsemanage.so.2
=20=20
* Release version for the whole project is same as for subcomponents, e.g.
  instead of 20210118 it's 3.2-rc1

* Improved man pages=20

* Bug fixes


Development-relevant changes
----------------------------

* License the CI scripts with a permissive, OSI approved license, such as M=
IT

* Several CI improvements

* Added configuration to build and run tests in GitHub Actions

* CI contains configuration for a Vagrant virtual machine - instructions on=
 how
  to use it are documented at the beginning of Vagrantfile.
=20=20
=20
Packaging-relevant changes
--------------------------

* Both libsepol and libsemanage bumped their soname versions. Especially
libsemanage is linked to shadow-utils and direct update might cause problem=
s to
buildroots. Also SETools needs to be rebuilt against libsepol.so.2


Issues fixed
------------

* https://github.com/SELinuxProject/selinux/issues/245
* https://github.com/SELinuxProject/selinux/issues/270


Shortlog of changes since the 3.1 release
-----------------------------------------------

Bernhard M. Wiedemann (1):
      python/sepolicy: allow to override manpage date

Bj=C3=B6rn Bidar (2):
      libselinux: Add build option to disable X11 backend
      libselinux: LABEL_BACKEND_ANDROID add option to enable

Chris PeBenito (5):
      libselinux: Remove trailing slash on selabel_file lookups.
      libselinux: Add new log callback levels for enforcing and policy load=
 notices.
      libselinux: Fix selabel_lookup() for the root dir.
      libselinux: Add additional log callback details in man page for audit=
ing.
      libselinux: Change userspace AVC setenforce and policy load messages =
to audit format.

Christian G=C3=B6ttsche (5):
      sepolgen: print extended permissions in hexadecimal
      sepolgen: sort extended rules like normal ones
      libselinux: use full argument specifiers for security_check_context i=
n man page
      libselinux: safely access shared memory in selinux_status_updated()
      libselinux: initialize last_policyload in selinux_status_open()

Dominick Grift (4):
      secilc/docs: document expandtypeattribute
      newrole: support cross-compilation with PAM and audit
      cil_access_vector_rules: allowx, auditallowx and dontauditx fixes
      cil_network_labeling_statements: fixes nodecon examples

Evgeny Vereshchagin (1):
      libsepol/cil: always destroy the lexer state

Hu Keping (3):
      Introduce VERSION file for selinux
      Use X.Y instead of date for release tag
      Simplify the tarball generating scripts

Jakub Hrozek (1):
      libsemanage: Free contents of modkey in semanage_direct_remove

James Carter (10):
      libsepol/cil: Validate constraint expressions before adding to binary=
 policy
      libsepol/cil: Validate conditional expressions before adding to binar=
y policy
      libsepol/cil: Fix neverallow checking involving classmaps
      libsepol/cil: Give error for more than one true or false block
      libsepol/cil: cil_tree_walk() helpers should use CIL_TREE_SKIP_*
      libsepol/cil: Get rid of unnecessary check in cil_gen_node()
      libsepol/cil: Remove unused field from struct cil_args_resolve
      libsepol/cil: Remove unnecessary assignment in cil_resolve_name_keep_=
aliases()
      libsepol/cil: Use the macro NODE() whenever possible
      libsepol/cil: Use the macro FLAVOR() whenever possible

Laurent Bigonville (1):
      restorecond: Set X-GNOME-HiddenUnderSystemd=3Dtrue in restorecond.des=
ktop file

Mike Palmiotto (1):
      libselinux: use kernel status page by default

Nicolas Iooss (18):
      libselinux: convert matchpathcon to selabel_lookup()
      libsepol/cil: fix signed overflow caused by using (1 << 31) - 1
      libsepol: drop confusing BUG_ON macro
      libsepol: silence potential NULL pointer dereference warning
      libsepol: free memory when realloc() fails
      Add configuration to build and run tests in GitHub Actions
      scripts/ci: add configuration for a Vagrant virtual machine
      GitHub Actions: upgrade to Python 3.9
      GitHub Actions: drop Ruby 2.4 from matrix
      libsepol/cil: remove useless print statement
      libsepol/cil: fix NULL pointer dereference when using an unused alias
      libsepol/cil: do not add a stack variable to a list
      libsepol/cil: propagate failure of cil_fill_list()
      libsepol/cil: constify some strings
      libsepol/cil: fix out-of-bound read in cil_print_recursive_blockinher=
it
      libsepol/cil: destroy perm_datums when __cil_resolve_perms fails
      libsepol/cil: fix NULL pointer dereference when parsing an improper i=
nteger
      libsepol: destroy filename_trans list properly

Ondrej Mosnacek (9):
      libsepol,checkpolicy: optimize storage of filename transitions
      libsepol: implement POLICYDB_VERSION_COMP_FTRANS
      ci: use parallel build
      ci: bump Fedora image version to 33
      selinux(8): mark up SELINUX values
      selinux(8): explain that runtime disable is deprecated
      selinux_config(5): add a note that runtime disable is deprecated
      ci: add new dependencies needed by selinux-testsuite
      travis: run only selinux-testsuite

Petr Lautrbach (9):
      libsepol: Get rid of the old and duplicated symbols
      libsepol: Drop deprecated functions
      libsepol: Bump libsepol.so version
      libsemanage: Remove legacy and duplicate symbols
      libsemanage: Drop deprecated functions
      libsemanage: Bump libsemanage.so version
      Revert "libsemanage/genhomedircon: check usepasswd"
      libselinux: Always close status page fd
      Update VERSIONs and Python bindings version to 3.2-rc1 for release

Stephen Smalley (1):
      libselinux: fix build order

Vit Mojzis (3):
      libsemanage/genhomedircon: check usepasswd
      python/semanage: empty stdout before exiting on BrokenPipeError
      python/semanage: Sort imports in alphabetical order

W. Michael Petullo (1):
      python/audit2allow: add #include <limits.h> to sepolgen-ifgen-attr-he=
lper.c

William Roberts (2):
      scripts/ci: license as MIT
      ci: fix stall on git log -1

bauen1 (2):
      Update the cil docs to match the current behaviour.
      fixfiles: correctly restore context of mountpoints

