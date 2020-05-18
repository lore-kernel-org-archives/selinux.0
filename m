Return-Path: <SRS0=hs+S=7A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859CCC433E0
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 13:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570FB206D4
	for <selinux@archiver.kernel.org>; Mon, 18 May 2020 13:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fOZVC6uF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgERNJN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 May 2020 09:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNJM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 May 2020 09:09:12 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D825C061A0C
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 06:09:12 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k19so8371715edv.9
        for <selinux@vger.kernel.org>; Mon, 18 May 2020 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lphL2BQSQAoRGC6J+HzoTXl3MILp5E85y8KNecnDAHM=;
        b=fOZVC6uFzYy/rRkxnmFWUEhfoIqp8dVjTxWqjXfTq8PYht57FMtazF1sbqzRyprZE0
         otRvlDdDWKhB3iznFlBCtARq9Ux5zMiqztPKGZ+n2E0QRo22ykIqdRHhHFx8MEBM5AHF
         GHchRj24NDrV/LvLMOcdguQCqv3jjg3/XvUxN1vkASUVzpXHL1GhGS8Be0on6I06RaR8
         ZZyfzRxjzrYetVGsuPErhL0dc+mTOs1fuCAkOlRNO8oZHUbQC9nDZFbUeR480RqhsxWf
         FjIXIeVR3W6N6rMchiKgpL52yuRCOZxE1q295btbRUOpYFqnZNgUvZYwTIUi0jOPxjZi
         dkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lphL2BQSQAoRGC6J+HzoTXl3MILp5E85y8KNecnDAHM=;
        b=lcMSWarv6Unu80gJtEaMVR3uOAVxpRdDtXqMZo4UKZovEoR4kjlLPrD9MNNewfPU2l
         ZleaZKtQnotUKTwDvnorlw22E3s9RAQ87Yh5x4MEBYKEdbPZrvxXQ2povBb7nvzo7BS0
         EEQIt3nJMkhnS7k8cm+ZDcXj1xgmpAxK7JPneX7NtsSY7TFlPxYhgpGYl2GKCUago8x2
         2k5s4W1yOi55f3hlp3aFRFAHzNpO0giF/bukYV4BPFLGqA9cN5M1dxNdHHM3u6WA/kW5
         GuJvfwq5sPURO8gS/rsQy7TGYp2eaiARVDUdEROizFeOaH0FBRZ+pIH4W/9AqvUr87+z
         5Bow==
X-Gm-Message-State: AOAM530KXLNmZApBVNdr7yNqy0mVJm4Y76j2k30rMI0VsT37qBQvBZqV
        BrjlVjTYAh2fuYpfU0oFGBmsqOCo8LzZQmLPBCHmP6cp
X-Google-Smtp-Source: ABdhPJzEStwenVinrzX/NNfGDtCdexFtFmyF363FcW5qiT/EK1AVso36pcMw2JW0+OhfB2GdnC85+jwJ3vCsIEv0Zoc=
X-Received: by 2002:a05:6402:1586:: with SMTP id c6mr13606106edv.54.1589807350849;
 Mon, 18 May 2020 06:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200518125237.GD309708@workstation>
In-Reply-To: <20200518125237.GD309708@workstation>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 18 May 2020 15:08:59 +0200
Message-ID: <CAJ2a_DcPeregejXw_9Lvgzc8-vOf3bk9SDAQ=Xy4cbanKccEdA@mail.gmail.com>
Subject: Re: ANN: SELinux userspace 3.1-rc1 release candidate
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Am Mo., 18. Mai 2020 um 14:52 Uhr schrieb Petr Lautrbach <plautrba@redhat.c=
om>:
>
> Hello,
>
> A 3.1-rc1 release candidate for the SELinux userspace is now
> available at:
>
> https://github.com/SELinuxProject/selinux/wiki/Releases
>
> Please give it a test and let us know if there are any issues.
>
> If there are specific changes that you think should be called out
> in release notes for packagers and users in the final release
> announcement, let us know.
>

I think some further changes can be mentioned:

* the dso wrappers for internal calls were removed (and as a result I
think it is now strongly recommend to compile with
`-fno-semantic-interposition`?)

* `security_compute_user()` was deprecated (usage of
/sys/fs/selinux/user { security:compute_user } might be revisited)

* commit 42b13ba15a1ef5764eea8b84196fa5a1aea2e094 ("checkpolicy: Treat
invalid characters as an error ") might break (but intentional) rare
use cases


>
> Thanks to all the contributors to this release candidate!
>
>
> User-visible changes:
>
> * selinux/flask.h and selinux/av_permissions.h were removed
>
>   The flask.h and av_permissions.h header files were deprecated and
>   all selinux userspace references to them were removed in
>   commit 76913d8adb61b5 ("Deprecate use of flask.h and av_permissions.h."=
)
>   back in 2014 and included in the 20150202 / 2.4 release.
>   All userspace object managers should have been updated
>   to use the dynamic class/perm mapping support since that time.
>   Remove these headers finally to ensure that no users remain and
>   that no future uses are ever introduced.
>
>   Use string_to_security_class(3) and string_to_av_perm(3) to map the cla=
ss and
>   permission names to their policy values, or selinux_set_mapping(3) to c=
reate a
>   mapping from class and permission index values used by the application =
to the
>   policy values.
>
> * Support for new polcap genfs_seclabel_symlinks
>
> * New `setfiles -E` option - treat conflicting specifications as errors, =
such
> as where two hardlinks for the same inode have different contexts.
>
> * `restorecond_user.service` - new systemd user service which runs `resto=
recond -u`
>
> * `setsebool -V` reports errors from commit phase
>
> * Improved man pages
>
> * `semanage` uses ipaddress Python module instead of IPy
>
> * matchpathcon related interfaces are deprecated
>
> * selinuxfs is mounted with noexec and nosuid
>
> * Improved README which was renamed to README.md and converted to markdow=
n.
>
> * `setup.py` builds can be customized using PYTHON_SETUP_ARGS, e.g. to fo=
r
>   Debian Python layout use: `make PYTHON_SETUP_ARGS=3D--install-layout=3D=
deb ...`
>
>
> Issues fixed:
>
> * https://github.com/SELinuxProject/selinux/issues/239
> * https://github.com/SELinuxProject/selinux/issues/237
> * https://github.com/SELinuxProject/selinux/issues/225
> * https://github.com/SELinuxProject/selinux/issues/217
> * https://github.com/SELinuxProject/selinux/issues/204
> * https://github.com/SELinuxProject/selinux/issues/187
> * https://github.com/SELinuxProject/selinux/issues/179
> * https://github.com/SELinuxProject/selinux/issues/164
> * https://github.com/SELinuxProject/selinux/issues/70
> * https://github.com/SELinuxProject/selinux/issues/28
>
> A shortlog of changes since the 3.0 release:
>
> Adam Duskett (1):
>       Fix building against musl and uClibc libc libraries.
>
> Chris PeBenito (2):
>       libselinux: Add selinux_restorecon option to treat conflicting spec=
ifications as an error.
>       setfiles: Add -E option to treat conflicting specifications as erro=
rs.
>
> Christian G=C3=B6ttsche (10):
>       libsepol: add support for new polcap genfs_seclabel_symlinks
>       libselinux: drop error return from is_selinux_enabled documentation
>       libsepol: set correct second argument of (t1 =3D=3D t2) constraint
>       checkpolicy: add missing forward declaration
>       tree-wide: replace last occurrences of security_context_t
>       tree-wide: use python module importlib instead of the deprecated im=
p
>       libsemanage: clarify handle-unknown configuration setting in man pa=
ge
>       semodule: mention ignoredirs setting in genhomedircon man page
>       libselinux: mark security_context_t typedef as deprecated
>       tree-wide: introduce PYTHON_SETUP_ARGS to customize setup.py calls =
on Debian
>
> Daniel Burgener (2):
>       checkpolicy: Treat invalid characters as an error
>       checkpolicy: Add --werror flag to checkmodule and checkpolicy to tr=
eat warnings as errors.
>
> Dominick Grift (1):
>       mcstrans: start early and stop late
>
> James Carter (6):
>       libsepol/cil: Fix bug in cil_copy_avrule() in extended permission h=
andling
>       libsepol/cil: Rewrite verification of map classes and classpermissi=
onsets
>       libsepol: Create the macro ebitmap_is_empty() and use it where need=
ed
>       libsepol/cil: Check if name is a macro parameter first
>       libsepol/cil: Do not check flavor when checking for duplicate param=
eters
>       Revert "libsepol/cil: raise default attrs_expand_size to 2"
>
> Joshua Schmidlkofer (1):
>       python/semanage: check variable type of port before trying to split
>
> Mikhail Novosyolov (1):
>       libselinux: Fix Ru translation of failsafe context
>
> Nick Kralevich (1):
>       label_file.c: Fix MAC build
>
> Nicolas Iooss (16):
>       libsepol: make ebitmap_cardinality() of linear complexity
>       libselinux: add missing glue code to grab errno in Python bindings
>       libselinux: copy the reason why selinux_status_open() returns 1
>       libselinux: make context_*_set() return -1 when an error occurs
>       libselinux/utils: remove unneeded variable in Makefile
>       libselinux,libsemanage: remove double blank lines
>       python/semanage: check rc after getting it
>       restorecond: migrate to GDbus API provided by glib-gio
>       restorecond: add systemd user service
>       restorecond/user: handle SIGTERM properly
>       libsepol/tests: drop ncurses dependency
>       README: add much useful information
>       scripts/env_use_destdir: fix Fedora support
>       scripts/env_use_destdir: propagate PREFIX, LIBDIR, BINDIR, etc.
>       Travis-CI: upgrade to Ubuntu 18.04 and latest releases of Python an=
d Ruby
>       python/sepolicy: silence new flake8 warnings
>
> Ondrej Mosnacek (16):
>       libsepol: fix CIL_KEY_* build errors with -fno-common
>       libsepol: remove leftovers of cil_mem_error_handler
>       checkpolicy: remove unused te_assertions
>       Makefile: always build with -fno-common
>       libsemanage: preserve parent Makefile's flags in debug mode
>       Travis-CI: test that DEBUG build works
>       libsepol/cil: remove unnecessary hash tables
>       libsepol: cache ebitmap cardinality value
>       libsepol, newrole: remove unused hashtab functions
>       libsepol: grow hashtab dynamically
>       Revert "libsepol: cache ebitmap cardinality value"
>       libsepol/cil: raise default attrs_expand_size to 2
>       secilc: add basic test for policy optimization
>       libsepol: skip unnecessary check in build_type_map()
>       libsepol: optimize inner loop in build_type_map()
>       libsepol: speed up policy optimization
>
> Petr Lautrbach (9):
>       libselinux: Eliminate use of security_compute_user()
>       Convert README to README.md
>       python/semanage: Use ipaddress module instead of IPy
>       restorecond: Rename restorecond-user.service to restorecond_user.se=
rvice
>       restorecond: Use pkg-config to get locations for systemd units
>       semanage/test-semanage.py: Return non-zero value when some of unitt=
est tests fail
>       run-flake8: Filter out ./.git/ directory
>       secilc: Fix policy optimization test
>       Update VERSIONs to 3.1-rc1 for release.
>
> Richard Filo (1):
>       libselinux: Add missing errno setup
>
> Stephen Smalley (8):
>       libselinux: remove flask.h and av_permissions.h
>       libselinux: update man pages for userspace policy enforcers
>       libselinux: export flush_class_cache(), call it on policyload
>       libsepol,checkpolicy: support omitting unused initial sid contexts
>       libselinux: deprecate security_compute_user(), update man pages
>       libsepol,checkpolicy: remove use of hardcoded security class values
>       libsemanage: fsync final files before rename
>       libsepol: drop broken warning on duplicate filename transitions
>
> Topi Miettinen (4):
>       setsebool: report errors from commit phase
>       libselinux: mount selinuxfs noexec and nosuid
>       sepolicy-gui: fix columns in transitions view
>       sepolicy: fix some typos and port definitions
>
> William Roberts (34):
>       dso: drop hidden_proto and hidden_def
>       Makefile: add -fno-semantic-interposition
>       Makefile: add linker script to minimize exports
>       libselinux: drop symbols from map
>       libsepol/dso: drop hidden_proto and hidden_def
>       libsepol/Makefile: add -fno-semantic-interposition
>       libsepol: remove wild cards in mapfile
>       cil: drop remaining dso.h include
>       libsemanage: drop hidden
>       libsemanage/Makefile: add -fno-semantic-interposition
>       libsemanage: update linker script
>       libsemanage: cleanup linker map file
>       cil: rm dead dso.h file
>       cil: re-enable DISABLE_SYMVER define
>       libsemanage: fix linker script symbol versions
>       libsemanage: rm semanage_module_upgrade_info from map
>       security_load_booleans: update return comment
>       security_load_booleans: annotate deprecated
>       selinux_booleans_path: annotate deprecated
>       selinux_users_path: annotate deprecated
>       rpm_execcon: annotate deprecated
>       sidget: annotate deprecated
>       sidput: annotate deprecated
>       checkPasswdAccess: annotate deprecated
>       matchpathcon_init: annotate deprecated
>       matchpathcon_fini: annotate deprecated
>       matchpathcon: annotate deprecated
>       avc_init: annotate deprecated
>       avc: create internal avc_init interface
>       matchpathcon: create internal matchpathcon_fini interface
>       selinux_check_passwd_access: annotate deprecated
>       matchpathcon: allow use of deprecated routines
>       utils: matchpathcon add deprecated warning
>       Makefile: swig build allow deprecated functions
>
> bauen1 (1):
>       mcstransd: fix memory leak in new_context_str
>
>
>
> --
> ()  ascii ribbon campaign - against html e-mail
> /\  www.asciiribbon.org   - against proprietary attachments
