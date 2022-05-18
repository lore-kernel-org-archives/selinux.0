Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B89CC433EF
	for <selinux@archiver.kernel.org>; Wed, 18 May 2022 18:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiERSX3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 May 2022 14:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiERSX1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 May 2022 14:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9537214674F
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652898204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OhJquO+Pe+2KDVIfOUhEsm2XOuGyegJfINfLHzruADk=;
        b=G9IuU7tcMJGE8L5j07hysT8Iq2RwRiV+Q64XFSWGQ9kox83iW4uUlhrf6DXqTGW8PWn55F
        DiUpRi6PGjo+OCRPty6jmp1qIW0i33zdDZXTvKH1oiMgXS6exQqJTY/sdq5+nDKTbmzzys
        Toz4g6vOyamWIcd4GEGWBvooIlsdMEY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-ffc0-eeyP1ODoF6ZtiOWXw-1; Wed, 18 May 2022 14:23:22 -0400
X-MC-Unique: ffc0-eeyP1ODoF6ZtiOWXw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E01F80B91C
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 18:23:22 +0000 (UTC)
Received: from localhost (unknown [10.40.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8B49C08087
        for <selinux@vger.kernel.org>; Wed, 18 May 2022 18:23:21 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.4 release
Date:   Wed, 18 May 2022 20:23:20 +0200
Message-ID: <874k1mpunb.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello!

The 3.3 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://people.redhat.com/plautrba/plautrba@redhat.com.asc

Thanks to all the contributors, reviewers, testers and reporters!

User-visible changes
--------------------

* A new selinux_restorecon_parallel(3) function that allows to run relabeli=
ng over multiple threads

* setfiles/restorecon/fixfiles support parallel relabeling via [ -T <N> ] t=
hreads option

* A new semodule options [ -m | --checksum ] to get SHA256 hashes of modules

* mcstrans ported to PCRE2

* libsepol/cil supports IPv4/IPv6 address embedding

* Add a new semodule option [ --rebuild-if-modules-changed ] to optionally =
rebuild policy when modules
  are changed externally

* A lot of static code analyse issues, fuzzer issues and compiler warnings =
fixed

* Translations split into sub-packages and updated from
  https://translate.fedoraproject.org/projects/selinux/

* New policy utilities in libsepol - sepol_check_access,
  sepol_compute_av, sepol_compute_member, sepol_compute_relabel,
  sepol_validate_transition

* A new setfiles option [-C] for distinguishing file tree walk errors

* Improved code quality and bug fixes


Development-relevant changes
----------------------------

* ci: run the tests under ASan/UBsan on GHActions

(Long) shortlog of changes since the 3.3 release
------------------------------------------------
Christian G=C3=B6ttsche (115):
      libsepol: do not pass NULL to memcpy
      libsemanage: do not sort empty records
      libsemanage/tests: free memory
      libselinux: use valid address to silence glibc 2.34 warnings
      libsepol: avoid passing NULL pointer to memcpy
      checkpolicy: use correct unsigned format specifiers
      libsepol: use string literals as format strings
      policycoreutils: use string literal as format strings
      Enable extra global compiler warnings
      checkpolicy: ignore possible string truncation
      policycoreutils: mark local functions static
      sandbox: mark local functions static
      python: mark local functions static
      mcstrans: avoid missing prototypes
      libsemanage: mark local functions static
      libsemanage: include paired header for prototypes
      libsemanage: add extern prototype for legacy function
      mcstrans: port to new PCRE2 from end-of-life PCRE
      libselinux: use PCRE2 by default
      Replace PCRE with PCRE2 build dependencies
      libsepol/cil: support IPv4/IPv6 address embedding
      checkpolicy: warn on bogus IP address or netmask in nodecon statement
      cifuzz: enable report-unreproducible-crashes
      cifuzz: use the default runtime of 600 seconds
      libsepol/fuzz: silence secilc-fuzzer
      libsepol: add libfuzz based fuzzer for reading binary policies
      libsepol/fuzz: limit element sizes for fuzzing
      libsepol: use logging framework in conditional.c
      libsepol: use logging framework in ebitmap.c
      libsepol: use mallocarray wrapper to avoid overflows
      libsepol: use reallocarray wrapper to avoid overflows
      libsepol: add checks for read sizes
      libsepol: enforce avtab item limit
      libsepol: clean memory on conditional insertion failure
      libsepol: reject abnormal huge sid ids
      libsepol: reject invalid filetrans source type
      libsepol: zero member before potential dereference
      libsepol: use size_t for indexes in strs helpers
      libsepol: do not underflow on short format arguments
      libsepol: do not crash on class gaps
      libsepol: do not crash on user gaps
      libsepol: use correct size for initial string list
      libsepol: do not create a string list with initial size zero
      libsepol: split validation of datum array gaps and entries
      libsepol: validate MLS levels
      libsepol: validate expanded user range and level
      libsepol: validate permission count of classes
      libsepol: resolve log message mismatch
      libsepol: validate avtab and avrule types
      libsepol: validate constraint expression operators and attributes
      libsepol: validate type of avtab type rules
      libsepol: validate ocontexts
      libsepol: validate genfs contexts
      libsepol: validate permissive types
      libsepol: validate policy properties
      libsepol: validate categories
      libsepol: validate fsuse types
      libsepol: validate class default targets
      libsepol/cil: bail out on snprintf failure
      libsepol: check for valid sensitivity before lookup
      libsepol: check for saturated class name length
      libsepol: return failure on saturated class name length
      libsepol: drop trailing newlines in log messages
      libsepol: handle type gaps
      libsepol: invert only valid range of role bitmap
      policycoreutils: handle argument counter of zero
      libsepol: do not add gaps to string list
      libsepol: use correct error type to please UBSAN
      libsepol: more strict constraint validation
      libsepol: validate several flags
      checkpolicy: allow wildcard permissions in constraints
      python/sepolgen: accept square brackets in FILENAME token
      libsepol: NULL pointer offset fix
      newrole: add Makefile target to test build options
      newrole: silence compiler warnings
      newrole: check for crypt(3) failure
      newrole: ensure password memory erasure
      libsepol: reject xperm av rules in conditional statements
      libsepol: validate boolean datum arrays
      libsepol/cil: silence GCC 12 array-bounds false positive
      libsepol: add missing oom checks
      libsepol: mark immutable mls and context parameter const
      libsepol: mark immutable common helper parameter const
      libsepol/cil: declare file local functions static
      libsepol/cil: drop unused function cil_tree_error
      libsepol/cil: post process pirqcon rules
      libsepol: add sepol_av_perm_to_string
      libsepol: introduce sepol_const_security_context_t typedef
      libsepol: export functions for policy analysis
      libsepol: add policy utilities
      libselinux/utils: check for valid contexts to improve error causes
      policycoreutils: drop usage of egrep in fixfiles
      libsepol/cil: declare file local function pointer static
      libsepol: check correct pointer for oom
      libsepol: drop unnecessary const discarding casts
      libselinux: limit has buffer size
      libsemanage: avoid double fclose
      Correct misc typos
      libsepol/tests: adjust IPv6 netmasks
      libsepol/cil: comment out unused function __cil_verify_rule
      libsemanage: ignore missing prototypes in swig generated code
      Enable missing prototypes
      libselinux: correct parameter type in selabel_open(3)
      libselinux: free memory on selabel_open(3) failure
      libselinux: correctly hash specfiles larger than 4G
      checkpolicy: mention class name on invalid permission
      libselinux: emulate O_PATH support in fgetfilecon/fsetfilecon
      libselinux: restorecon: misc tweaks
      libselinux: restorecon: forward error if not ENOENT
      libselinux: restorecon: pin file to avoid TOCTOU issues
      libselinux: free memory in error branch
      libselinux: preserve errno in selinux_log()
      libselinux/utils: print errno on failure
      libselinux: update man page of setfilecon(3) family about context par=
ameter
      ci: declare git repository a safe directory

Cutright Jacob (1):
      Modified Russian and English man pages to fix typo; REQUIREUSERS -> R=
EQUIRESEUSERS

Evgeny Vereshchagin (1):
      ci: run the tests under ASan/UBsan on GHActions

James Carter (43):
      libsepol: Add support for file types in writing out policy.conf
      libsepol/cil: Refactor filecon file type handling
      libsepol/cil: Allow optional file type in genfscon rules
      secilc/docs: Document the optional file type for genfscon rules
      libsepol: Write out genfscon file type when writing out CIL policy
      libsepol/cil: Do not copy blockabstracts when inheriting a block
      libsepol/cil: Mark as abstract all sub-blocks of an abstract block
      libsepol/cil: Do not resolve names to declarations in abstract blocks
      libsepol/cil: Ensure that the class in a classcommon is a kernel class
      libsepol: Return an error if check_assertion() returns an error.
      libsepol: Change label in check_assertion_avtab_match()
      libsepol: Remove uneeded error messages in assertion checking
      libsepol: Check for error from check_assertion_extended_permissions()
      libsepol: Use consistent return checking style
      libsepol: Move check of target types to before check for self
      libsepol: Create function check_assertion_self_match() and use it
      libsepol: Use (rc < 0) instead of (rc) when calling ebitmap functions
      libsepol: Remove unnessesary check for matching class
      libsepol: Move assigning outer loop index out of inner loop
      libsepol: Make use of previously created ebitmap when checking self
      libsepol: Refactor match_any_class_permissions() to be clearer
      libsepol: Make return value clearer when reporting neverallowx errors
      libsepol: The src and tgt must be the same if neverallow uses self
      libsepol: Set args avtab pointer when reporting assertion violations
      libsepol: Fix two problems with neverallowxperm reporting
      libsepol/cil: Add cil_get_log_level() function
      libsepol/cil: Provide more control over reporting bounds failures
      libsepol/cil: Limit the neverallow violations reported
      libsepol/cil: Limit the amount of reporting for context rule conflicts
      libsepol: Do a more thorough validation of constraints
      libsepol/cil: Don't add constraint if there are no permissions
      libsepol: Don't write out constraint if it has no permissions
      libsepol/cil: Write a message when a log message is truncated
      libsepol: Use calloc when initializing bool_val_to_struct array
      libsepol: Validate conditional expressions
      Add a file describing the security vulnerability handling process
      libsepol: Replace calls to mallocarray() with calls to calloc()
      setfiles.8: -q is deprecated and has no effect
      libsepol/tests Include policydb.h header for policydb_t declaration
      libsepol/tests: Include paired headers for prototypes
      libsepol/tests: Declare file local functions as static
      libsemanage/tests: Declare file local functions as static
      libsemanage/tests: Remove unused functions

Laszlo Ersek (5):
      setfiles: fix up inconsistent indentation
      setfiles: remove useless assignment and comment (after RHBZ#1926386)
      setfiles: remove useless "iamrestorecon" checks in option parsing
      selinux_restorecon: introduce SELINUX_RESTORECON_COUNT_ERRORS
      setfiles: introduce the -C option for distinguishing file tree walk e=
rrors

Markus Linnala (1):
      Use IANA-managed domain example.com in examples

Ondrej Mosnacek (16):
      label_file: fix a data race
      selinux_restorecon: simplify fl_head allocation by using calloc()
      selinux_restorecon: protect file_spec list with a mutex
      libselinux: make selinux_log() thread-safe
      libselinux: make is_context_customizable() thread-safe
      selinux_restorecon: add a global mutex to synchronize progress output
      selinux_restorecon: introduce selinux_restorecon_parallel(3)
      setfiles/restorecon: support parallel relabeling
      libsemanage: add missing include to boolean_record.c
      semodule,libsemanage: move module hashing into libsemanage
      libsemanage: move compressed file handling into a separate object
      libsemanage: clean up semanage_direct_commit() a bit
      libsemanage: optionally rebuild policy when modules are changed exter=
nally
      semodule: add command-line option to detect module changes
      libsepol/cil: add support for self keyword in type transitions
      libsepol,checkpolicy: add support for self keyword in type transitions

Petr Lautrbach (18):
      semodule: add -m | --checksum option
      semodule: Fix lang_ext column index
      semodule: Don't forget to munmap() data
      libselinux: Fix selinux_restorecon_parallel symbol version
      semanage-fcontext.8: Drop extra )s after FILE_SPEC
      policycoreutils/fixfiles: Use parallel relabeling
      libselinux: Close leaked FILEs
      libsemanage: Fall back to semanage_copy_dir when rename() fails
      Split po/ translation files into the relevant sub-directories
      Update translations from translate.fedoraproject.org
      libsemanage: Fix USE_AFTER_FREE (CWE-672) in semanage_direct_get_modu=
le_info()
      semodule_package: Close leaking fd
      mcstrans: Fir RESOURCE_LEAK and USE_AFTER_FREE coverity scan defects
      Update VERSIONs to 3.4-rc1 for release.
      Update VERSIONs to 3.4-rc2 for release.
      Update missing sandbox translations
      Update VERSIONs to 3.4-rc3 for release.
      Update VERSIONs to 3.4 for release.

Richard Haines (2):
      libsepol: Add 'ioctl_skip_cloexec' policy capability
      libsepol: Shorten the policy capability enum names

Thi=C3=A9baud Weksteen (2):
      libsepol: Populate and use policy name
      libsepol: fix reallocarray imports

Topi Miettinen (1):
      secilc: kernel policy language is infix

Vit Mojzis (4):
      policycoreutils: Improve error message when selabel_open fails
      libselinux: Strip spaces before values in config
      libsemanage: allow spaces in user/group names
      gettext: set _ on module level instead of builtins namespace

