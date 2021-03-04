Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC7BC433E6
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 16:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A2A64F53
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 16:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhCDQiM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 11:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231703AbhCDQiG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 11:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614875800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cs9mGHeTH8K2EdpOd1Dhg3fovo8WNgZtSjJWotFgk7k=;
        b=ShHHXdo78zm2CwHRV5PCrtRf5UGIRD9VGiZP/SwW84APwYfS9UbPAlG7WC08RerI225hLU
        TBifi4UZv78/CCaAZnDsK79brEin5H4QulcR1/EMHHN5ebHEVA5eqvPUcTvjvYlDJ9NADo
        hPRp5V46N6tCKDmzMIm3zZRCoasze7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-Cdac5ZETPQOO27TxBwl-CQ-1; Thu, 04 Mar 2021 11:36:37 -0500
X-MC-Unique: Cdac5ZETPQOO27TxBwl-CQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63E7157
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 16:36:36 +0000 (UTC)
Received: from localhost (unknown [10.40.196.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4CF35DA2D
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 16:36:35 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace release 3.2
Date:   Thu, 04 Mar 2021 17:36:34 +0100
Message-ID: <87v9a698q5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello!

The 3.2 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Thanks to all the contributors to this release!

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

* Improved usability of `getseuser`

* Fixed several issues in cil code found by OSS-FUZZ

* `setfiles` doesn't abort on labeling errors

* libsemanage tries to sync data to prevent empty files in SELinux module s=
tore

* Improved secilc documentation - fenced code blocks, syntax highlighting, =
custom
  color theme, ...

* Better error reporting in getconlist


* libsepol implemented a new, more space-efficient form of storing filename
  transitions in the binary policy and reduced the size of the binary policy

* libselinux: Use mmap()'ed kernel status page instead of netlink by defaul=
t.
  See "KERNEL STATUS PAGE" section in avc_init(3) for more details.
  Note: if you need to `umount /sys/fs/selinux` you need to use lazy umount=
 -
  `umount -l /sys/fs/selinux` as the kernel status page /sys/fs/selinux/sta=
tus
  stays mapped by processes like systemd, dbus, sshd.

* Tools using sepolgen, e.g. audit2allow, print extended permissions in
  hexadecimal

* sepolgen sorts extended rules like normal ones

* New log callback levels for enforcing and policy load notices -
  SELINUX_POLICYLOAD, SELINUX_SETENFORCE

* Changed userspace AVC setenforce and policy load messages to audit format.

* matchpathcon converted to selabel_lookup() - no more matchpathcon is
  deprecated warning

* libsepol and libsemanage dropped old and deprecated symbols and functions
  libsepol version was bumped to libsepol.so.2
  libsemanage version was bumped to libsemanage.so.2

* Release version for the whole project is same as for subcomponents, e.g.
  instead of 20210304 it's 3.2

* Improved man pages

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
* `scripts/release` was improved to be more robust and release a source rep=
ository

Packaging-relevant changes
--------------------------

* Both libsepol and libsemanage bumped their soname versions. Especially
libsemanage is linked to shadow-utils and direct update might cause problem=
s to
buildroots. Also SETools needs to be rebuilt against libsepol.so.2

* Source repository snapshot selinux-3.2-rc2.tar.gz is available on the rel=
ease page

* sestatus is installed as /usr/bin/sestatus by default. Original /usr/sbin=
/sestatus is
  a relative symlink to the /usr/bin/sestatus.

Issues fixed
------------

* https://github.com/SELinuxProject/selinux/issues/245
* https://github.com/SELinuxProject/selinux/issues/270


Shortlog of changes since the 3.1 release
-----------------------------------------
Antoine Tenart (1):
      policycoreutils: setfiles: do not restrict checks against a binary po=
licy

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

Christian G=C3=B6ttsche (10):
      sepolgen: print extended permissions in hexadecimal
      sepolgen: sort extended rules like normal ones
      libselinux: use full argument specifiers for security_check_context i=
n man page
      libselinux: safely access shared memory in selinux_status_updated()
      libselinux: initialize last_policyload in selinux_status_open()
      libselinux: accept const fromcon in get_context API
      libselinux: update getseuser
      libselinux/getconlist: report failures
      policycoreutils/fixfiles.8: add missing file systems and merge check =
and verify
      libsepol/cil: handle SID without assigned context when writing policy=
.conf

Dominick Grift (5):
      secilc/docs: document expandtypeattribute
      newrole: support cross-compilation with PAM and audit
      cil_access_vector_rules: allowx, auditallowx and dontauditx fixes
      cil_network_labeling_statements: fixes nodecon examples
      secilc: fixes cil_role_statements.md example

Evgeny Vereshchagin (1):
      libsepol/cil: always destroy the lexer state

Hu Keping (3):
      Introduce VERSION file for selinux
      Use X.Y instead of date for release tag
      Simplify the tarball generating scripts

Jakub Hrozek (1):
      libsemanage: Free contents of modkey in semanage_direct_remove

James Carter (17):
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
      libsepol/cil: Update symtab nprim field when adding or removing datums
      libsepol/cil: Fix heap-use-after-free in __class_reset_perm_values()
      libsepol/cil: Fix heap-use-after-free when using optional blockinherit
      libsepol/cil: Fix integer overflow in the handling of hll line marks
      libsepol/cil: Destroy disabled optional blocks after pass is complete
      libsepol: Create function ebitmap_highest_set_bit()
      libsepol: Validate policydb values when reading binary policy

Laurent Bigonville (1):
      restorecond: Set X-GNOME-HiddenUnderSystemd=3Dtrue in restorecond.des=
ktop file

Mike Palmiotto (1):
      libselinux: use kernel status page by default

Nicolas Iooss (31):
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
      GitHub Actions: run SELinux testsuite in Fedora virtual machine
      libsepol/cil: fix memory leak when a constraint expression is too deep
      libsepol/cil: unlink blockinherit->block link when destroying a block
      scripts/release: make the script more robust, and release a source re=
pository snapshot
      libsepol: remove unused files
      libsepol: uniformize prototypes of sepol_mls_contains and sepol_mls_c=
heck
      libsepol: include header files in source files when matching declarat=
ions
      libsepol/cil: fix NULL pointer dereference with empty macro argument
      libsepol/cil: be more robust when encountering <src_info>
      libsepol/cil: introduce intermediate cast to silence -Wvoid-pointer-t=
o-enum-cast
      libselinux: rename gettid() to something which never conflicts with t=
he libc
      libsepol: invalidate the pointer to the policydb if policydb_init fai=
ls
      restorecond: invalidate local_lock_fd properly when closing it

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

Petr Lautrbach (20):
      Update VERSIONs and Python bindings version to 3.1 for release
      libsepol: Get rid of the old and duplicated symbols
      libsepol: Drop deprecated functions
      libsepol: Bump libsepol.so version
      libsemanage: Remove legacy and duplicate symbols
      libsemanage: Drop deprecated functions
      libsemanage: Bump libsemanage.so version
      Revert "libsemanage/genhomedircon: check usepasswd"
      libselinux: Always close status page fd
      Update VERSIONs and Python bindings version to 3.2-rc1 for release
      setfiles: Do not abort on labeling error
      setfiles: drop ABORT_ON_ERRORS and related code
      libsemanage: sync filesystem with sandbox
      policycoreutils/setfiles: Drop unused nerr variable
      Update VERSIONs to 3.2-rc2 for release.
      libselinux: fix segfault in add_xattr_entry()
      policycoreutils: Resolve path in restorecon_xattr
      Update VERSIONs to 3.2-rc3 for release.
      sepolicy: Do not try to load policy on import
      Update VERSIONs to 3.2 for release.

Stephen Smalley (1):
      libselinux: fix build order

Vit Mojzis (6):
      libsemanage/genhomedircon: check usepasswd
      python/semanage: empty stdout before exiting on BrokenPipeError
      python/semanage: Sort imports in alphabetical order
      python/sepolgen: allow any policy statement in if(n)def
      selinux(8,5): Describe fcontext regular expressions
      gui: fix "file type" selection in fcontextPage

W. Michael Petullo (1):
      python/audit2allow: add #include <limits.h> to sepolgen-ifgen-attr-he=
lper.c

William Roberts (2):
      scripts/ci: license as MIT
      ci: fix stall on git log -1

bauen1 (6):
      Update the cil docs to match the current behaviour.
      fixfiles: correctly restore context of mountpoints
      secilc/docs: use fenced code blocks for cil examples
      secilc/docs: add syntax highlighting for secil
      secilc/docs: add custom color theme
      policycoreutils: sestatus belongs to bin not sbin

lutianxiong (1):
      libsepol/cil: fix NULL pointer dereference in cil_fill_ipaddr



