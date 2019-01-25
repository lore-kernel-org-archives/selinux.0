Return-Path: <SRS0=5KO5=QB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799F8C282C0
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 11:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B30D218A6
	for <selinux@archiver.kernel.org>; Fri, 25 Jan 2019 11:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfAYLMN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:12:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:29203 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfAYLMM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 25 Jan 2019 06:12:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27534A24FA
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 11:12:12 +0000 (UTC)
Received: from workstation (unknown [10.43.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C9F34DE
        for <selinux@vger.kernel.org>; Fri, 25 Jan 2019 11:12:11 +0000 (UTC)
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     "selinux\@vger.kernel.org" <selinux@vger.kernel.org>
Subject: ANN: SELinux userspace 2.9-rc1 release candidate
Date:   Fri, 25 Jan 2019 12:12:09 +0100
Message-ID: <pjdmunpt2ie.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 25 Jan 2019 11:12:12 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


A 2.9-rc1 release candidate for the SELinux userspace is now 
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out 
in
release notes for packagers and users in the final release 
announcement, let us know.

Thanks to all the contributors to this release candidate!

User-visible changes:

* Spelling errors were fixed in libselinux man pages

* audit2allow supports xperms now. There are new '-x'/'--xperms' 
  options which
turn on generating of extended permisssion AV rules.

* semanage login is fixed in order not to log two audit events 
  which one of them
was correct.

* libsemanage resets umask before creating directories so that 
  file permissions
should not change after a change is committed. 

* Correct user name is used in ROLE_REMOVE audit events

* The noise produced by checkpolicy command line tool is reduced 
  now.

* A new option '-S' or '--sort' is added to checkpolicy to sort 
  the ocontexts
before writing out the binary policy.

* sepolicy and semanage accept aliases now.

* Deprecated at_console statement was removed from dbus 
  configuration.

* semanage export output includes ibpkey and ibendport now.

* audit2why can be run as non-root user now.

Packaging-relevant changes:

* Usage of DESTDIR in restorecond is consistent with other 
  directories now

Issues fixed:

* https://github.com/SELinuxProject/selinux/issues/81
* https://github.com/SELinuxProject/selinux/issues/97
* https://github.com/SELinuxProject/selinux/issues/108
* https://github.com/SELinuxProject/selinux/issues/109
* https://github.com/SELinuxProject/selinux/issues/119
* https://github.com/SELinuxProject/selinux/issues/121
* https://github.com/SELinuxProject/selinux/issues/123



A shortlog of changes since the 2.8 release is below.

Hollis Blanchard (1):
      Fix build break around __atomic_*() with GCC<4.7

James Carter (7):
      libsepol: Create policydb_sort_ocontexts()
      checkpolicy: Add option to sort ocontexts when creating a 
      binary policy
      libsepol: Rename kernel_to_common.c stack functions
      libsepol: Eliminate initial sid string definitions in 
      module_to_cil.c
      libsepol: Check that initial sid indexes are within the 
      valid range
      libsepol: Add two new Xen initial SIDs
      libsepol: mark permissive types when loading a binary policy

Jan Zarsky (3):
      python/sepolgen: print all AV rules correctly
      python/sepolgen: fix access vector initialization
      python: add xperms support to audit2allow

Laurent Bigonville (7):
      policycoreutils: Fix typo in newrole.1 manpage
      secilc: Make the clean target call the clean target of docs/
      libselinux: Fix spelling errors in manpages
      libselinux: Fix line wrapping in selabel_file.5
      libselinux: fix the whatis line for the 
      selinux_boolean_sub.3 manpage
      restorecond: Fix consistancy of DESTDIR usage
      libsemanage: Always set errno to 0 before calling getpwent()

Mr Stid (1):
      Fix snprintf truncated error

Nick Kralevich via Selinux (3):
      checkpolicy: remove extraneous policy build noise
      whitespace and spelling cleanup
      secilc: better error handling

Nicolas Iooss (70):
      libsepol: cil: silence clang analyzer false positive
      libsepol: do not leak memory if list_prepend fails
      libsepol: remove some dead assignments
      libsepol: do not call malloc with 0 byte
      libsepol: remove unused variable
      checkpolicy: destroy the class datum if it fails to 
      initialize
      libsepol: destroy the copied va_list
      python/sepolgen: fix typo in PathChoooser name
      policycoreutils/secon: fix typo in comment
      policycoreutils/secon: free scon_trans before returning
      policycoreutils/hll/pp: remove unused variable
      libsepol/tests: read_binary_policy() does not use f.handle
      libsepol/tests: fix use of unitialized variable
      libsepol/cil: use a colon instead of a semicolon to report 
      rc
      scripts: add a helper script to run clang's static analyzer
      restorecond: close the PID file if writing to it failed
      Travis-CI: use new location of refpolicy repository
      mcstrans: fix memory leaks reported by clang's static 
      analyzer
      python/semanage: fix Python syntax of catching several 
      exceptions
      libselinux: fix flake8 warnings in SWIG-generated code
      python/sepolgen: do not import twice the modules
      python/sepolgen: return NotImplemented instead of raising it
      python/sepolicy: drop unused CheckPolicyType
      python/sepolicy: use lowercase variable name
      python/sepolgen: fix refpolicy parsing of "permissive"
      python/sepolgen: silence linter warning about has_key
      python/sepolgen: remove buggy code
      python/sepolgen: use self when accessing members in 
      FilesystemUse
      python/sepolicy: fix "procotol" misspelling
      python/sepolicy: use variables which exist in the gui.py
      python/sepolicy: do not import sepolicy.generate.DAEMON 
      twice
      python/sepolicy: do not import types
      python/sepolicy: add missing % in network tab help text
      Travis-CI: run flake8 on Python code
      libsemanage: reindent pywrap-test.py with spaces
      libsemanage: make pywrap-test.py compatible with Python 3
      libselinux: add a const to suppress a build warning with 
      Python 3.7
      Travis-CI: upgrade to Ubuntu 16.04 LTS Xenial Xerus
      python: remove semicolon from end of lines
      libsemanage: use previous seuser when getting the previous 
      name
      semanage: "semanage user" does not use -s, fix documentation
      semanage: add a missing space in ibendport help
      libselinux: selinux_restorecon: fix printf format string 
      specifier for uint64_t
      gui: remove html_util.py
      python/chcat: improve the code readability
      python/chcat: fix removing categories on users with Fedora 
      default setup
      python/semanage: do not show "None" levels when using a 
      non-MLS policy
      mcstrans: convert test scripts to Python 3
      mcstrans: fix Python linter warnings on test scripts
      python/sepolgen: always indent with 4 spaces
      semanage_migrate_store: fix many Python linter warnings
      semanage_migrate_store: remove unused loading of libsepol.so
      semanage_migrate_store: switch to space indentation
      python/sepolgen: upgrade ply to release 3.11
      python/sepolgen: close /etc/selinux/sepolgen.conf after 
      parsing it
      python/audit2allow/sepolgen-ifgen: add missing \n to error 
      message
      python/audit2allow/sepolgen-ifgen: show errors on stderr
      python/audit2allow: allow using audit2why as non-root user
      python/semanage: explain why sepolicy is imported in a 
      function
      Travis-CI: download refpolicy and install headers
      python/audit2allow: make the tests useful again
      python/audit2allow: use local sepolgen-ifgen-attr-helper for 
      tests
      python/sepolgen: refpolicy installs its Makefile in 
      include/Makefile
      python: run all the tests with "make test"
      scripts/run-flake8: run on Python scripts not ending with 
      .py
      python/sepolicy: initialize mislabeled_files in __init__()
      libselinux: do not dereference symlink with statfs in 
      selinux_restorecon
      Travis-CI: upgrade PyPy to 6.0
      Travis-CI: add Ruby 2.6 to the test matrix
      scripts: introduce env_use_destdir.sh helper

Ondrej Mosnacek (3):
      restorecond: Do not ignore the -f option
      libsepol: fix endianity in ibpkey range checks
      libsepol: add missing ibendport port validity check

Petr Lautrbach (9):
      python/sepolicy: search() also for dontaudit rules
      mcstrans: Fix check in raw_color()
      python/semanage: move valid_types initialisations to class 
      constructors
      python/semanage: import sepolicy only when it's needed
      python/sepolicy: Add sepolicy.load_store_policy(store)
      python/semanage: Load a store policy and set the store 
      SELinux policy root
      python/sepolicy: Make policy files sorting more robust
      libselinux/audit2why.so: Filter out non-python related 
      symbols
      Update VERSIONs to 2.9-rc1 for release.

Stephen Smalley (5):
      README: Update the SELinux mailing list location
      libselinux: fix overly strict validation of 
      file_contexts.bin
      libsepol: ibpkeys.c: fix printf format string specifiers for 
      subnet_prefix
      libsemanage: set selinux policy root around calls to 
      selinux_boolean_sub
      setsebool: support use of -P on SELinux-disabled hosts

Tom Gundersen (1):
      dbus: remove deprecated at_console statement

Vit Mojzis (13):
      python/semanage: Stop logging loginRecords changes
      python/semanage: Fix logger class definition
      python/semanage: Replace bare except with specific one
      libsemanage: reset umask before creating directories
      libsemanage: Include user name in ROLE_REMOVE audit events
      python/sepolicy: Update to work with setools-4.2.0
      python/sepolicy: Fix "info" to search aliases as well
      python/sepolicy: Stop rejecting aliases in sepolicy commands
      python/semanage: Stop rejecting aliases in semanage commands
      python: replace aliases with corresponding type names
      python/semanage: Include MCS/MLS range when exporting local 
      customizations
      python/semanage: Start exporting "ibendport" and "ibpkey" 
      entries
      python/chcat: use check_call instead of getstatusoutput

William Roberts (3):
      Makefile: fix _FORTIFY_SOURCE redefined build error
      build: set _FORTIFY_SOURCE=2 in libselinux
      Makefile: add -Wstrict-overflow=5 to CFLAGS

Yuli Khodorkovskiy (2):
      libsemanage: improve semanage_migrate_store import failure
      mcstrans: remove unused getpeercon_raw() call

Yuri Chornoivan (1):
      Fix minor typos

liwugang (1):
      checkpolicy: check the result value of hashtable_search

