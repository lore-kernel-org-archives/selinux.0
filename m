Return-Path: <SRS0=ib1x=AV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6965C433E5
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 16:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADEBB206F4
	for <selinux@archiver.kernel.org>; Fri, 10 Jul 2020 16:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dmo0NV4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGJQVE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:21:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39731 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727932AbgGJQVD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Jul 2020 12:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594398061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=uq6WXReCfyLkjbDlH0qNmEIoOKTc36+CevSRAdaStEY=;
        b=Dmo0NV4u0cEf7HTjPYHFx2M+aqXYjXNK6FKtxs/+I+gIkAguDTTXVH6h6gVYNIWrfue2js
        qruMMfY88RxIkCAXij/zniOsY2IgqsadYxuavQ84q+ChZ6tXGkm4hv3GMTDlZzg2WtyPZX
        DFp5CxBjcT5AW2RDXdRDd67djc1ecx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-cmrGApmWMtKGi_h2QgfVyA-1; Fri, 10 Jul 2020 12:20:41 -0400
X-MC-Unique: cmrGApmWMtKGi_h2QgfVyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 282718027E4
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2020 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.251])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 377461A913
        for <selinux@vger.kernel.org>; Fri, 10 Jul 2020 16:20:36 +0000 (UTC)
Date:   Fri, 10 Jul 2020 18:20:34 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace release 2020-07-10 / 3.1
Message-ID: <20200710162034.GC1768200@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The 2020-07-10 / 3.1 release for the SELinux userspace is now=20
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Thanks to all the contributors to this release!

User-visible changes
--------------------

* selinux/flask.h, selinux/av_permissions.h and sepol/policydb/flask.h were=
 removed

  The flask.h and av_permissions.h header files were deprecated and
  all selinux userspace references to them were removed in
  commit 76913d8adb61b5 ("Deprecate use of flask.h and av_permissions.h.")
  back in 2014 and included in the 20150202 / 2.4 release.
  All userspace object managers should have been updated
  to use the dynamic class/perm mapping support since that time.
  Remove these headers finally to ensure that no users remain and
  that no future uses are ever introduced.

  Use string_to_security_class(3) and string_to_av_perm(3) to map the class=
 and
  permission names to their policy values, or selinux_set_mapping(3) to cre=
ate a
  mapping from class and permission index values used by the application to=
 the
  policy values.

* Removed restrictions in libsepol and checkpolicy that required all declar=
ed
  initial SIDs to be assigned a context.

* Support for new policy capability genfs_seclabel_symlinks

* New `setfiles -E` option - treat conflicting specifications as errors, su=
ch
as where two hardlinks for the same inode have different contexts.

* `restorecond_user.service` - new systemd user service which runs `restore=
cond -u`

* `setsebool -V` reports errors from commit phase

* Improved man pages

* `semanage` uses ipaddress Python module instead of IPy

* matchpathcon related interfaces are deprecated

* selinuxfs is mounted with noexec and nosuid

* the dso wrappers for internal calls were removed and it is now strongly r=
ecommended to CFLAGS with
  `-fno-semantic-interposition`

* `security_compute_user()` was deprecated

* checkpolicy treats invalid characters as an error - might break rare use =
cases (intentionally)

* New `restorecon -x` option which prevents it from crossing file system bo=
undaries.

* Handle `semanage module` in semanage bash completion

* `sepolgen-ifgen` parses a gen_tunable statement as bool

* `semanage` handles getprotobyname() failure case on Debian where /etc/pro=
tocols does not contain an entry for "ipv4"


Packaging-relevant changes
--------------------------

* Setting CFLAGS during the make process will cause the omission of many de=
faults. While the project strives
  to provide a reasonable set of default flags, custom CFLAGS could break t=
he build, or have other undesired
  changes on the build output. Thus, be very careful when setting CFLAGS. C=
FLAGS that are encouraged to be
  set when overriding are:

  - -fno-semantic-interposition for gcc or compilers that do not do this. c=
lang does this by default. clang-10 and up
    will support passing this flag, but ignore it. Previous clang versions =
fail.

* `setup.py` builds can be customized using PYTHON_SETUP_ARGS, e.g. to for
  Debian Python layout use: `make PYTHON_SETUP_ARGS=3D--install-layout=3Dde=
b ...`


Development-relevant changes
----------------------------

* Improved README which was renamed to README.md and converted to markdown.

* Added Travis CI job to run SELinux kernel testsuite on latest Fedora clou=
d image


Issues fixed
------------

* https://github.com/SELinuxProject/selinux/issues/248
* https://github.com/SELinuxProject/selinux/issues/239
* https://github.com/SELinuxProject/selinux/issues/237
* https://github.com/SELinuxProject/selinux/issues/225
* https://github.com/SELinuxProject/selinux/issues/217
* https://github.com/SELinuxProject/selinux/issues/208
* https://github.com/SELinuxProject/selinux/issues/204
* https://github.com/SELinuxProject/selinux/issues/187
* https://github.com/SELinuxProject/selinux/issues/179
* https://github.com/SELinuxProject/selinux/issues/164
* https://github.com/SELinuxProject/selinux/issues/70
* https://github.com/SELinuxProject/selinux/issues/28


A shortlog of changes since the 3.1 release
-------------------------------------------
Adam Duskett (1):
      Fix building against musl and uClibc libc libraries.

Andrej Shadura (1):
      checkpolicy: Minor tweaks to the names of the contributors to the man=
pages

Antoine Tenart (1):
      policycoreutils: setfiles: do not restrict checks against a binary po=
licy

Chris PeBenito (2):
      libselinux: Add selinux_restorecon option to treat conflicting specif=
ications as an error.
      setfiles: Add -E option to treat conflicting specifications as errors.

Christian G=F6ttsche (13):
      libsepol: add support for new polcap genfs_seclabel_symlinks
      libselinux: drop error return from is_selinux_enabled documentation
      libsepol: set correct second argument of (t1 =3D=3D t2) constraint
      checkpolicy: add missing forward declaration
      tree-wide: replace last occurrences of security_context_t
      tree-wide: use python module importlib instead of the deprecated imp
      libsemanage: clarify handle-unknown configuration setting in man page
      semodule: mention ignoredirs setting in genhomedircon man page
      libselinux: mark security_context_t typedef as deprecated
      tree-wide: introduce PYTHON_SETUP_ARGS to customize setup.py calls on=
 Debian
      sepolgen: parse gen_tunable as bool
      refparser: add missing newline after error message
      sepolgen-ifgen: refactor default policy path retrieval

Daniel Burgener (2):
      checkpolicy: Treat invalid characters as an error
      checkpolicy: Add --werror flag to checkmodule and checkpolicy to trea=
t warnings as errors.

Dominick Grift (1):
      mcstrans: start early and stop late

James Carter (14):
      libsepol/cil: Fix bug in cil_copy_avrule() in extended permission han=
dling
      libsepol/cil: Rewrite verification of map classes and classpermission=
sets
      libsepol: Create the macro ebitmap_is_empty() and use it where needed
      libsepol/cil: Check if name is a macro parameter first
      libsepol/cil: Do not check flavor when checking for duplicate paramet=
ers
      Revert "libsepol/cil: raise default attrs_expand_size to 2"
      libsepol/cil: Initialize the multiple_decls field of the cil db
      libsepol/cil: Return error when identifier declared as both type and =
attribute
      libsepol: Fix type alias handling in kernel_to_cil
      libsepol: Fix type alias handling in kernel_to_conf
      libsepol: Write CIL default MLS rules on separate lines
      libsepol: Improve writing CIL sensitivity rules
      libsepol: Improve writing CIL category rules
      libsepol: Sort portcon rules consistently

Ji Qin (1):
      libselinux: Fix NULL pointer use in selinux_restorecon_set_sehandle

Jonathan Lebon (1):
      setfiles: clarify documented path resolution behaviour

Joshua Schmidlkofer (1):
      python/semanage: check variable type of port before trying to split

Mikhail Novosyolov (1):
      libselinux: Fix Ru translation of failsafe context

Nick Kralevich (1):
      label_file.c: Fix MAC build

Nicolas Iooss (16):
      libsepol: make ebitmap_cardinality() of linear complexity
      libselinux: add missing glue code to grab errno in Python bindings
      libselinux: copy the reason why selinux_status_open() returns 1
      libselinux: make context_*_set() return -1 when an error occurs
      libselinux/utils: remove unneeded variable in Makefile
      libselinux,libsemanage: remove double blank lines
      python/semanage: check rc after getting it
      restorecond: migrate to GDbus API provided by glib-gio
      restorecond: add systemd user service
      restorecond/user: handle SIGTERM properly
      libsepol/tests: drop ncurses dependency
      README: add much useful information
      scripts/env_use_destdir: fix Fedora support
      scripts/env_use_destdir: propagate PREFIX, LIBDIR, BINDIR, etc.
      Travis-CI: upgrade to Ubuntu 18.04 and latest releases of Python and =
Ruby
      python/sepolicy: silence new flake8 warnings

Ondrej Mosnacek (16):
      libsepol: fix CIL_KEY_* build errors with -fno-common
      libsepol: remove leftovers of cil_mem_error_handler
      checkpolicy: remove unused te_assertions
      Makefile: always build with -fno-common
      libsemanage: preserve parent Makefile's flags in debug mode
      Travis-CI: test that DEBUG build works
      libsepol/cil: remove unnecessary hash tables
      libsepol: cache ebitmap cardinality value
      libsepol, newrole: remove unused hashtab functions
      libsepol: grow hashtab dynamically
      Revert "libsepol: cache ebitmap cardinality value"
      libsepol/cil: raise default attrs_expand_size to 2
      secilc: add basic test for policy optimization
      libsepol: skip unnecessary check in build_type_map()
      libsepol: optimize inner loop in build_type_map()
      libsepol: speed up policy optimization

Peter Whittaker (1):
      Add restorecon -x option to not cross FS boundaries

Petr Lautrbach (12):
      libselinux: Eliminate use of security_compute_user()
      Convert README to README.md
      python/semanage: Use ipaddress module instead of IPy
      restorecond: Rename restorecond-user.service to restorecond_user.serv=
ice
      restorecond: Use pkg-config to get locations for systemd units
      semanage/test-semanage.py: Return non-zero value when some of unittes=
t tests fail
      run-flake8: Filter out ./.git/ directory
      secilc: Fix policy optimization test
      Update VERSIONs to 3.1-rc1 for release.
      python/sepolicy: Use xml.etree.ElementTree.Element.iter()
      Update VERSIONs to 3.1-rc2 for release.
      Update VERSIONs and Python bindings version to 3.1 for release

Richard Filo (1):
      libselinux: Add missing errno setup

Stephen Smalley (9):
      libselinux: remove flask.h and av_permissions.h
      libselinux: update man pages for userspace policy enforcers
      libselinux: export flush_class_cache(), call it on policyload
      libsepol,checkpolicy: support omitting unused initial sid contexts
      libselinux: deprecate security_compute_user(), update man pages
      libsepol,checkpolicy: remove use of hardcoded security class values
      libsemanage: fsync final files before rename
      libsepol: drop broken warning on duplicate filename transitions
      libselinux: fix selinux_restorecon() statfs bug

Topi Miettinen (8):
      setsebool: report errors from commit phase
      libselinux: mount selinuxfs noexec and nosuid
      sepolicy-gui: fix columns in transitions view
      sepolicy: fix some typos and port definitions
      secilc/docs: fix use of TMPDIR
      semanage bash completion: handle semanage module
      semanage-node.8: describe netmask
      semanage: handle getprotobyname() failure case

William Roberts (37):
      dso: drop hidden_proto and hidden_def
      Makefile: add -fno-semantic-interposition
      Makefile: add linker script to minimize exports
      libselinux: drop symbols from map
      libsepol/dso: drop hidden_proto and hidden_def
      libsepol/Makefile: add -fno-semantic-interposition
      libsepol: remove wild cards in mapfile
      cil: drop remaining dso.h include
      libsemanage: drop hidden
      libsemanage/Makefile: add -fno-semantic-interposition
      libsemanage: update linker script
      libsemanage: cleanup linker map file
      cil: rm dead dso.h file
      cil: re-enable DISABLE_SYMVER define
      libsemanage: fix linker script symbol versions
      libsemanage: rm semanage_module_upgrade_info from map
      security_load_booleans: update return comment
      security_load_booleans: annotate deprecated
      selinux_booleans_path: annotate deprecated
      selinux_users_path: annotate deprecated
      rpm_execcon: annotate deprecated
      sidget: annotate deprecated
      sidput: annotate deprecated
      checkPasswdAccess: annotate deprecated
      matchpathcon_init: annotate deprecated
      matchpathcon_fini: annotate deprecated
      matchpathcon: annotate deprecated
      avc_init: annotate deprecated
      avc: create internal avc_init interface
      matchpathcon: create internal matchpathcon_fini interface
      selinux_check_passwd_access: annotate deprecated
      matchpathcon: allow use of deprecated routines
      utils: matchpathcon add deprecated warning
      Makefile: swig build allow deprecated functions
      ci: run SELinux kernel test suite
      ci: dont use hardcoded project name
      README: start a section for documenting CFLAGS

bauen1 (1):
      mcstransd: fix memory leak in new_context_str


--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl8IlUsACgkQviIJHj72
InXIeQ/+Jr5jR+YtlhGUyxh5cdqvIkw1mEHNXNS9VBxa6KVA/bF4N9UEbY44LPBD
Tiz42ePOdTfKeI16oitjGoKC8t6DR6Ezp9+jtXjwcmuSgNEDAfEMkN/yyVAVTDCX
9rub7hdrymoc5xNOohMXe5sMGdeFlOphVS8pUort/Ivcj1xHx0lEkGI1fmtI9odq
Mq/ljlMB62VWYCH3UkB2lOvruOVYOw+e6kGyVwtOrbENTP2fySiZgi2kD01LI8r7
rSocoJz6jUg1+Nu3YxWOq6T8eMiWmG87v3sl2R7nHcvSOX3Y5Peu+tQCycfsTE6K
tX9F/kx7go7YxeQlPU1K/wcgb3nkdHBA+fj0qOfj4wTzjOYPJAhihnDEOeAINgRY
9W/loa4/vO8baGGL/eQSer+6G8TiAl/wsWG3TzOKiINN41xRBARQQXgRgDTBH6/9
XVo6wno9hlOAoVa9Tpmvp9mVnfBnLriQQK20zWCEFoV5tcdQQnOC9XpfoNhHpC25
vi7RwNilz7jm8+PEHbsO+0xqNeCheCBQUzAihx3RuZtwHS7/Dmx0m67Fvu7h51SW
iFzh6q7p3C095MFC0qQzA0NWYnUWgvHHF9c5yLXsJ5ZeS/UqFmUukLekbvzzSC8c
R5hg01sOO95xCdidYD3k0zL7QpxgYrPpKXa9jBCj/bLfMQgGvA4=
=9HKo
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--

