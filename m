Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D59FC433DF
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 12:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED3A20787
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 12:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M4vA89BK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgERMww (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 08:52:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44460 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726709AbgERMww (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 08:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589806369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=rDrmn5c6Nk6merfFZrNp7Uks0OVdcvOdjZd6qtDjed8=;
        b=M4vA89BKXYgsQ0UiOr80GQNnYVj34GkzvXudM4VNWM3mBuWKghNHNYed6L053A0G76QCo2
        6zIjvRpRtgxtQEy71matcTkkZIj/tHxUawxq8kNs3+iDaytZTos2datmaNkbHqlIR4K6Ru
        MEK/Di2DInw/XR95wEpo8Rf+TAsuiSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-8rLBwNP_N7qn0D7cgBjidA-1; Mon, 18 May 2020 08:52:42 -0400
X-MC-Unique: 8rLBwNP_N7qn0D7cgBjidA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3C68107B7D1
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 12:52:41 +0000 (UTC)
Received: from workstation (unknown [10.40.193.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 038A460C05
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 12:52:40 +0000 (UTC)
Date:   Mon, 18 May 2020 14:52:37 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.1-rc1 release candidate
Message-ID: <20200518125237.GD309708@workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

A 3.1-rc1 release candidate for the SELinux userspace is now=20
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out=20
in release notes for packagers and users in the final release
announcement, let us know.=20

Thanks to all the contributors to this release candidate!


User-visible changes:

* selinux/flask.h and selinux/av_permissions.h were removed

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

* Support for new polcap genfs_seclabel_symlinks

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

* Improved README which was renamed to README.md and converted to markdown.

* `setup.py` builds can be customized using PYTHON_SETUP_ARGS, e.g. to for
  Debian Python layout use: `make PYTHON_SETUP_ARGS=3D--install-layout=3Dde=
b ...`


Issues fixed:

* https://github.com/SELinuxProject/selinux/issues/239
* https://github.com/SELinuxProject/selinux/issues/237
* https://github.com/SELinuxProject/selinux/issues/225
* https://github.com/SELinuxProject/selinux/issues/217
* https://github.com/SELinuxProject/selinux/issues/204
* https://github.com/SELinuxProject/selinux/issues/187
* https://github.com/SELinuxProject/selinux/issues/179
* https://github.com/SELinuxProject/selinux/issues/164
* https://github.com/SELinuxProject/selinux/issues/70
* https://github.com/SELinuxProject/selinux/issues/28

A shortlog of changes since the 3.0 release:

Adam Duskett (1):
      Fix building against musl and uClibc libc libraries.

Chris PeBenito (2):
      libselinux: Add selinux_restorecon option to treat conflicting specif=
ications as an error.
      setfiles: Add -E option to treat conflicting specifications as errors.

Christian G=F6ttsche (10):
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

Daniel Burgener (2):
      checkpolicy: Treat invalid characters as an error
      checkpolicy: Add --werror flag to checkmodule and checkpolicy to trea=
t warnings as errors.

Dominick Grift (1):
      mcstrans: start early and stop late

James Carter (6):
      libsepol/cil: Fix bug in cil_copy_avrule() in extended permission han=
dling
      libsepol/cil: Rewrite verification of map classes and classpermission=
sets
      libsepol: Create the macro ebitmap_is_empty() and use it where needed
      libsepol/cil: Check if name is a macro parameter first
      libsepol/cil: Do not check flavor when checking for duplicate paramet=
ers
      Revert "libsepol/cil: raise default attrs_expand_size to 2"

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

Petr Lautrbach (9):
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

Richard Filo (1):
      libselinux: Add missing errno setup

Stephen Smalley (8):
      libselinux: remove flask.h and av_permissions.h
      libselinux: update man pages for userspace policy enforcers
      libselinux: export flush_class_cache(), call it on policyload
      libsepol,checkpolicy: support omitting unused initial sid contexts
      libselinux: deprecate security_compute_user(), update man pages
      libsepol,checkpolicy: remove use of hardcoded security class values
      libsemanage: fsync final files before rename
      libsepol: drop broken warning on duplicate filename transitions

Topi Miettinen (4):
      setsebool: report errors from commit phase
      libselinux: mount selinuxfs noexec and nosuid
      sepolicy-gui: fix columns in transitions view
      sepolicy: fix some typos and port definitions

William Roberts (34):
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

bauen1 (1):
      mcstransd: fix memory leak in new_context_str



--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7ChQ4ACgkQviIJHj72
InUWeg/+In3a85YMksBwMBGo5XOJVr+m5qIX8/79tb7GSJ2rxruuTF3Qt1B460Xy
WSvDahAOjP1pwBMywTFdWUFTcrUIrj4DWD7ADT+84dj6z8PkwkqIgytVDm0/FQYJ
MNGKLgHOL+djtgaRiOMmgIcUQGzhJlAH2QMVqEevjNwSE0+y666J2CsFwSmX0Etb
eziFNzR+j44L8tEaUUHmsXbvNjm3fBaU2NlHKJq4uYhDFRWNt81TuaBCQsw2LZyV
60oiBQSk+9AougwSOcT9uP8ZVukVHu0NfZf9gWD3nBuQnJB8E1NF5LuN8ZiH5v9p
lJFhU0rAs13NGD71IhdpKlv/pMTPuFvFih06QG38WNBc0+UvWh2k08g2/WpZav7L
izaxmq6oyNZ33UcLM+TSlKFhDKyiZEJLR2p7X3AG/Ws+xf2EdJroaqf4XYMLsGjO
XZxEHc6VgZmrXkrPe5STyR4nKqR6dHnfw2Pj5rni3QffuYXCt9vSGeff3cRpzKjV
VaSn01N/igRzENhEqIfGnzQ/0AsLh4Tzu5hXKGNLTKLf/Y6aU4242FF0TtY3Rk/X
W9HdWrk/r3+ONf4o4lQ018n7E362J3mytNBh5M8ETMRfYAVJBOucR4hY6b+GwUpc
xzzPqeAY0C5qpsxrKIkyLcQzgs/S1qQ4EvZxyKOkBVVD6jM+8YQ=
=eJBi
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--

