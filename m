Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A25FC4167B
	for <selinux@archiver.kernel.org>; Wed,  8 Nov 2023 16:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjKHQ6D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Nov 2023 11:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHQ6C (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Nov 2023 11:58:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79541719
        for <selinux@vger.kernel.org>; Wed,  8 Nov 2023 08:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699462634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5uQuvXg5U6G/ebaTjutrbFErzAjjR7TeB9Oi7xAfyYA=;
        b=Lw8hwzvorijkdsXekvEmzypRKlVV/FHzyvtRvDnXjiSNPFBpsRCgtnwXCOcnc16YTvXZhF
        cK8a0PiGAyUibVa6LR1Fmwx41eemNP7VoxbiIB6zTrZgU9G9grdRXAwFzjE9ewCTuijO0E
        TLhOvWOCekCEB/JQmclSSkp5G2ymuTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-H5Jo59tKMZaNjZS9GrpHLw-1; Wed, 08 Nov 2023 11:57:13 -0500
X-MC-Unique: H5Jo59tKMZaNjZS9GrpHLw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DDF0185A788
        for <selinux@vger.kernel.org>; Wed,  8 Nov 2023 16:57:13 +0000 (UTC)
Received: from localhost (unknown [10.45.224.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E035492BE8
        for <selinux@vger.kernel.org>; Wed,  8 Nov 2023 16:57:12 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.6-rc1 release 
Date:   Wed, 08 Nov 2023 17:57:12 +0100
Message-ID: <87edh0uqs7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello!

The 3.6-rc1 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Thanks to all the contributors, reviewers, testers and reporters!

If you miss something important not mentioned bellow, please let me know.

User-visible changes
--------------------

* Add not self support for neverallow rules

* dispol: Add the ability to show booleans, classes, roles, types and type =
attributes of policies

* Improve man pages

* libselinux: performance optimization for duplicate detection

* dismod: add options: --actions ACTIONS, --help

* dispol: add options: --actions ACTIONS, --help

* checkpolicy: Add the command line argument -N, --disable-neverallow

* Introduce getpolicyload - a helper binary to print the number of policy r=
eloads on the running system

* man pages: Remove the Russian translations

* Add notself and other support to CIL

* Add support for deny rules

* Translations updated from
  https://translate.fedoraproject.org/projects/selinux/

* Bug fixes


Shortlog of the changes since 3.5 release
-----------------------------------------
Bruno Victal (1):
      secilc: Use versioned DocBook public identifier.

Cathy Hu (1):
      sepolicy/manpage.py: make output deterministic

Christian G=C3=B6ttsche (74):
      libsepol: Add not self support for neverallow rules
      checkpolicy: add not-self neverallow support
      libsepol/tests: add tests for not self neverallow rules
      libsepol/tests: add tests for minus self neverallow rules
      libsepol: rename struct member
      checkpolicy: update cond_expr_t struct member name
      libsepol/tests: rename bool indentifiers
      checkpolicy: rename bool identifiers
      libsepol: rename bool identifiers
      libsemanage/tests: rename bool identifiers
      libsemanage: fix memory leak in semanage_user_roles
      checkpolicy/dispol: add output functions
      libselinux: set CFLAGS for pip installation
      checkpolicy: drop unused token CLONE
      checkpolicy: reject condition with bool and tunable in expression
      checkpolicy: only set declared permission bits for wildcards
      libsepol: dump non-mls validatetrans rules as such
      libsepol: validate some object contexts
      libsepol: validate old style range trans classes
      libsepol: validate: check low category is not bigger than high
      libsepol: validate: reject XEN policy with xperm rules
      libsepol: expand: skip invalid cat
      libsepol: drop message for uncommon error cases
      libsepol: drop duplicate newline in sepol_log_err() calls
      libsepol: replace sepol_log_err() by ERR()
      libsepol: replace log_err() by ERR()
      checkpolicy: add option to skip checking neverallow rules
      checkpolicy/dismod: misc improvements
      libsepol: free initial sid names
      libsepol: check for overflow in put_entry()
      libsepol/fuzz: more strict fuzzing of binary policies
      setsebool: improve bash-completion script
      setsebool: drop unnecessary linking against libsepol
      semodule_expand: update
      semodule_link: update
      semodule_package: update
      semodule_unpackage: update
      libselinux/utils: introduce getpolicyload
      libsepol: validate: use fixed sized integers
      hashtab: update
      libsepol: expand: use identical type to avoid implicit conversion
      libsepol: expand: check for memory allocation failure
      libsepol: ebitmap: avoid branches for iteration
      libsemanage/tests: use strict prototypes
      libsepol: update CIL generation for trivial not-self rules
      libselinux/utils: update selabel_partial_match
      libselinux: misc label cleanup
      libselinux: drop obsolete optimization flag
      libselinux: drop unnecessary warning overrides
      setfiles: do not issue AUDIT_FS_RELABEL on dry run
      libselinux: constify selabel_cmp(3) parameters
      libselinux: simplify zeroing allocation
      libselinux/utils: use type safe union assignment
      libselinux: avoid regex serialization truncations
      libselinux: parameter simplifications
      libselinux/utils: use correct type for backend argument
      libselinux: update string_to_mode()
      libselinux: fix logic for building android backend
      libselinux: avoid unused function
      libselinux: check for stream rewind failures
      libselinux: simplify internal selabel_validate prototype
      libselinux/utils: drop include of internal header file
      libselinux: free elements on read_spec_entries() failure
      libselinux: set errno on label lookup failure
      libsepol: reject avtab entries with invalid specifier
      libsepol: avtab: check read counts for saturation
      checkpolicy: add round-trip tests
      libselinux/utils: update getdefaultcon
      libselinux: cast to unsigned char for character handling function
      libselinux: introduce reallocarray(3)
      libsepol: validate default type of transition is not an attribute
      libsepol: validate constraint depth
      libsepol: more strict validation
      libsepol: reject unsupported policy capabilities

Dominick Grift (1):
      secilc/docs: fixes filecon example

Huaxin Lu (3):
      libselinux: add check for calloc in check_booleans
      restorecond: add check for strdup in strings_list_add
      secilc: add check for malloc in secilc

Huizhao Wang (1):
      restorecond: compatible with the use of EUID

James Carter (41):
      Revert "libsepol/cil: add support for prefix/suffix filename transtio=
ns to CIL"
      Revert "checkpolicy,libsepol: add prefix/suffix support to module pol=
icy"
      Revert "checkpolicy,libsepol: add prefix/suffix support to kernel pol=
icy"
      Revert "libsepol: implement new module binary format of avrule"
      Revert "libsepol: implement new kernel binary format for avtab"
      Revert "checkpolicy,libsepol: move filename transition rules to avrul=
e"
      Revert "checkpolicy,libsepol: move filename transitions to avtab"
      Revert "checkpolicy,libsepol: move transition to separate structure i=
n avtab"
      libsepol/cil: Fix class permission verification in CIL
      python: Use isinstance() instead of type()
      checkpolicy: Remove the Russian translations
      gui: Remove the Russian translations
      libselinux: Remove the Russian translations
      libselinux: Remove the Russian translations
      libsemanage: Remove the Russian translations
      libsepol: Remove the Russian translations
      mcstrans: Remove the Russian translations
      policycoreutils: Remove the Russian translations
      python: Remove the Russian translations
      python: Remove the Russian translations
      restorecond: Remove the Russian translations
      sandbox: Remove the Russian translations
      semodule-utils: Remove the Russian translations
      Do not automatically install Russian translations
      libsepol: Changes to ebitmap.h to fix compiler warnings
      libsepol/cil: Do not call ebitmap_init twice for an ebitmap
      libsepol/cil: Add notself and other support to CIL
      libsepol: Use ERR() instead of log_err()
      secilc/docs: Add notself and other keywords to CIL documentation
      secilc/test: Add notself and other tests
      libsepol/cil: Parse and add deny rule to AST, but do not process
      libsepol/cil: Add cil_list_is_empty macro
      libsepol/cil: Add cil_tree_node_remove function
      libsepol/cil: Process deny rules
      libsepol/cil: Add cil_write_post_ast function
      libsepol: Export the cil_write_post_ast function
      secilc/secil2tree: Add option to write CIL AST after post processing
      secilc/test: Add deny rule tests
      secilc/docs: Add deny rule to CIL documentation
      checkpolicy: Remove support for role dominance rules
      libsepol: Fix the version number for the latest exported function

Jeffery To (1):
      python/sepolicy: Fix get_os_version except clause

Juraj Marcin (8):
      checkpolicy,libsepol: move transition to separate structure in avtab
      checkpolicy,libsepol: move filename transitions to avtab
      checkpolicy,libsepol: move filename transition rules to avrule
      libsepol: implement new kernel binary format for avtab
      libsepol: implement new module binary format of avrule
      checkpolicy,libsepol: add prefix/suffix support to kernel policy
      checkpolicy,libsepol: add prefix/suffix support to module policy
      libsepol/cil: add support for prefix/suffix filename transtions to CIL

Masatake YAMATO (10):
      dismod: add --help option
      dismod: delete an unnecessary empty line
      dismod: handle EOF in user interaction
      dismod: add --actions option for non-interactive use
      dispol: add --help option
      dispol: delete an unnecessary empty line
      dispol: handle EOF in user interaction
      dispol: add --actions option for non-interactive use
      dismod: print the policy version only in interactive mode
      dismod, dispol: reduce the messages in batch mode

Ondrej Mosnacek (4):
      libsemanage: include more parameters in the module checksum
      scripts/ci: install rdma-core-devel for selinux-testsuite
      libsepol: stop translating deprecated intial SIDs to strings
      libsepol: add support for the new "init" initial SID

Petr Lautrbach (6):
      python: improve format strings for proper localization
      python: Drop hard formating from localized strings
      semanage: Drop unnecessary import from seobject
      python: update python.pot
      Update translations
      Update VERSIONs to 3.6-rc1 for release.

Stephen Smalley (2):
      libselinux,policycoreutils,python,semodule-utils: de-brand SELinux
      checkpolicy,libselinux,libsepol,policycoreutils,semodule-utils: updat=
e my email

Topi Miettinen (1):
      sepolicy: clarify manual page of sepolicy interface

Vit Mojzis (11):
      python/chcat: Improve man pages
      python/audit2allow: Add missing options to man page
      python/semanage: Improve man pages
      python/audit2allow: Remove unused "debug" option
      policycoreutils: Add examples to man pages
      python/sepolicy: Improve man pages
      sandbox: Add examples to man pages
      checkpolicy: Add examples to man pages
      libselinux: Add examples to man pages
      python/sepolicy: Fix template for confined user policy modules
      python/sepolicy: Add/remove user even when SELinux is disabled

wanghuizhao (3):
      libselinux: migrating hashtab from policycoreutils
      libselinux: adapting hashtab to libselinux
      libselinux: performance optimization for duplicate detection

