Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21381C4332F
	for <selinux@archiver.kernel.org>; Fri, 23 Dec 2022 00:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiLWA0x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Dec 2022 19:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbiLWA0u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Dec 2022 19:26:50 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51CC15F3B
        for <selinux@vger.kernel.org>; Thu, 22 Dec 2022 16:26:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id l10so3508709plb.8
        for <selinux@vger.kernel.org>; Thu, 22 Dec 2022 16:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=perfinion-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcp1ETya7AKGGkY1qlx0HeiQ1TYvhpGSsrnos2G9gRQ=;
        b=ssAKC39yWHxRhZLaA2NLaeIGxLGCMhPDrqvkHJTYROrV5Ftp86BVHyQID9k6ywoxwv
         9Kjo+guF6OZOID9NuQ2rMwBRm9J7NvcGbPGLOhca6bw0WXH64nF2QWXPLve99c1jpYAb
         sywYpTsFXABakXFxCal8OlM2NLNngLpmmu1pXUKn82gldtYNAXbS47+gf5Xb71UhRSOI
         dpq2uhCVX5jZsXDS3CQd9vxjFKE+x/sKUyAPONyceZEP4DpnXu4yS4PKLva/T1epG/LN
         JGnUnta+uJPKr+l39SNajzWBWyLQORPi1Z4fr3zLV6R9rW6brdiFH2z+yQSMq2Rms1I8
         XodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcp1ETya7AKGGkY1qlx0HeiQ1TYvhpGSsrnos2G9gRQ=;
        b=aAgxYN+pXZIEH/NYKo71G6dJMhXb++rMQRm+30a0nd2O/geO+KKy7oOSzK1Fk9kqeq
         maoof0fCyezloYAh1OwttUODxmROF1UgMBeWH0HzDKoBS8NyGbCpwdmii/1fHy77eZLY
         8afU+kdQlSg10DjiIy1sI41/b9SdfAL7TF5nbwbxdVDwNADh6KRkemhA2yOG9rg+cdZe
         Q/oS5HddVXyDyQxsrk/OAo1UsZglBkFAkEAfEeKIPk3MuJhgm1Dx42AuomRiubIB7CI/
         H0BifbdEwz4VuciYDKlGX2GPWgDQlkwW3vrM7n///Gj2TcoLLZzNmGhD/Eq5uOIKD45z
         8rmg==
X-Gm-Message-State: AFqh2kpSgHt4EvuoZ9d41RUJ5EB0pOOkXzQ8qfhBkwpGIiqjgYSFFdM8
        G+gB6RKFD+N+zX4Ig9HN7QtCRoJZNGN7Fkm1L2A=
X-Google-Smtp-Source: AMrXdXu70zfT7wd9NODJHw4G6gbNsUywujKIM933cEDze7qV7goH2CLKuM1sguwrgxW+ElmdZJtgRw==
X-Received: by 2002:a17:902:ce85:b0:18f:a0de:6ad0 with SMTP id f5-20020a170902ce8500b0018fa0de6ad0mr9599914plg.55.1671755206643;
        Thu, 22 Dec 2022 16:26:46 -0800 (PST)
Received: from localhost (99-123-3-233.lightspeed.sntcca.sbcglobal.net. [99.123.3.233])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902d48a00b00186da904da0sm1076703plg.154.2022.12.22.16.26.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 16:26:45 -0800 (PST)
Date:   Thu, 22 Dec 2022 16:26:44 -0800
From:   Jason Zaman <jason@perfinion.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.5-rc1 release
Message-ID: <Y6T1xJm1nUeInWPL@anduin.perfinion.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nKu0ZxG7ZnlLMg++"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--nKu0ZxG7ZnlLMg++
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

The 3.5-rc1 release for the SELinux userspace is now available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

I signed all tarballs using my gpg key, see .asc files.
You can download the public key from
https://github.com/perfinion.gpg

Thanks to all the contributors, reviewers, testers and reporters!

With Kind Regards,
Jason Zaman

User-visible changes
--------------------

* Maintainer GPG fingerprints added to /SECURITY.md

* Remove dependency on the deprecated Python module distutils and install v=
ia pip

* semodule option --rebuild-if-modules-changed was renamed to --refresh

* Translation updated and better handling for unsupported languages

* fixfiles: Unmount temporary bind mounts on SIGINT

* sepolicy: Several python and GTK updates

* libsepol: Stricter policy validation

* A lot of static code analyse issues, fuzzer issues and compiler warnings =
fixed

* Bug fixes

Development-relevant changes
----------------------------

* ci: Run on Fedora36 instead of F34


Shortlog of the changes since 3.4 release
-----------------------------------------

Christian G=F6ttsche (52):
      libselinux: declare return value of context_str(3) const
      semodule: avoid toctou on output module
      libselinux: simplify policy path logic to avoid uninitialized read
      libselinux: add header guard for internal header
      libselinux: introduce strlcpy
      libselinux: check for truncations
      libselinux: add man page redirections
      libselinux: enclose macro definition in parenthesis
      libselinux: name parameters in context.h
      libselinux: declare parameter of security_load_policy(3) const
      python/audit2allow: close file stream on error
      libsepol: fix validation of user declarations in modules
      checkpolicy: error out if required permission would exceed limit
      libselinux: restorecon: avoid printing NULL pointer
      libsepol: avoid potential NULL dereference on optional parameter
      libsepol/utils: improve wording
      libsepol: do not modify policy during write
      libselinux: set errno to EBADF on O_PATH emulation ENOENT failure
      libsepol: break circular include
      libsepol: include necessary headers in headers
      libsepol: enclose macro parameters and replacement lists in parenthes=
es
      libsepol/tests: add ebitmap tests
      libsepol: add ebitmap_init_range
      libsepol/cil: use ebitmap_init_range
      libsepol: optimize ebitmap_not
      libsepol: optimize ebitmap_and
      libsepol: optimize ebitmap_xor
      libsepol: skip superfluous memset calls in ebitmap operations
      libsepol: rename validate_policydb to policydb_validate
      libsepol: support const avtab_t pointer in avtab_map()
      libsepol: operate on const pointers during validation
      libsepol: rename parameter name
      libsepol: more strict validation
      libsepol: refactor ebitmap conversion in link.c
      libselinux: avoid newline in avc message
      checkpolicy: use strict function prototype for definitions
      restorecond: use strict function prototype for definition
      ci: bump versions in GitHub Actions
      scripts/ci: use F36 image instead of F34
      scripts: ignore Flake8 tag E275
      Ignore egg-info directories and clean them
      libselinux: support objname in compute_create
      libsepol/cil: restore error on context rule conflicts
      libselinux: simplify string copying
      checkpolicy: simplify string copying
      libsepol: simplify string copying
      libselinux: drop set but not used internal variable
      libsepol/tests: use more strict compiler options
      libsepol/tests: add tests for neverallow assertions
      libselinux: make use of strndup
      libselinux: bail out on path truncations
      libselinux: filter arguments with path separators

Dominick Grift (1):
      secilc/doc: classmap is also allowed in permissionx

Elijah Conners (1):
      python: remove IOError in certain cases

James Carter (8):
      docs: Add GPG fingerprints
      python: Do not query the local database if the fcontext is non-local
      libselinux: Remove dependency on the Python module distutils
      libsemanage: Remove dependency on the Python module distutils
      python: Remove dependency on the Python module distutils
      scripts: Remove dependency on the Python module distutils
      README.md: Remove mention of python3-distutils dependency
      Revert "Use `pip install` instead of `setup.py install`"

Jason Zaman (3):
      libselinux: Ignore installed when installing python bindings to DESTD=
IR
      python: Ignore installed when installing to DESTDIR
      Update VERSIONs to 3.5-rc1 for release.

Jie Lu (3):
      libselinux: fix memory leaks on the audit2why module init
      libselinux: fix some memory issues in db_init
      libselinux:add check for malloc

Juraj Marcin (2):
      libsepol: fix missing double quotes in typetransition CIL rule
      checkpolicy: avoid passing NULL pointer to memset()

Matt Sheets (1):
      libsemanage: Allow user to set SYSCONFDIR

Nicolas Iooss (3):
      libselinux: do not return the cached prev_current value when using ge=
tpidcon()
      libsepol: initialize s in constraint_expr_eval_reason
      CircleCI: do not add Debian-specific parameter when invoking setup.py

Ondrej Mosnacek (2):
      libsemanage: always write kernel policy when check_ext_changes is spe=
cified
      semodule: rename --rebuild-if-modules-changed to --refresh

Paul Moore (3):
      docs: add Paul Moore's GPG fingerprint
      docs: provide a top level LICENSE file
      docs: update the README.md with a basic SELinux description

Petr Lautrbach (16):
      Revert "libselinux: restorecon: pin file to avoid TOCTOU issues"
      libsepol: Drop unused assignment
      gui: Fix export file chooser dialog
      sandbox: Do not try to remove tmpdir twice if uid =3D=3D 0
      sandbox: Use temporary directory for XDG_RUNTIME_DIR
      python: Fix typo in audit2allow.1 example
      python/sepolicy: Fix sepolicy manpage -w ...
      python/sepolicy: Use distro module to get os version
      python/sepolicy: Simplify generation of man pages
      fixfiles: Unmount temporary bind mounts on SIGINT
      Fix E275 missing whitespace after keyword
      Use `pip install` instead of `setup.py install`
      sepolicy: Switch main selection menu to GtkPopover
      python: Fix detection of sepolicy.glade location
      sepolicy: Call os.makedirs() with exist_ok=3DTrue
      Use `pip install` instead of `setup.py install`

Thi=E9baud Weksteen (1):
      libselinux: ignore invalid class name lookup

Vit Mojzis (7):
      python: Split "semanage import" into two transactions
      gettext: handle unsupported languages properly
      Update translations
      python: Harden tools against "rogue" modules
      libselinux: Ignore missing directories when -i is used
      checkpolicy: Improve error message for type bounds
      libsemanage: Use more conscious language

bauen1 (2):
      secilc/docs: fix syntax highlighting
      secilc/docs: disable pandoc default css for html docs



--nKu0ZxG7ZnlLMg++
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEE4WLerRzN0RPwSz1JK77Zyxpo71UFAmOk9cNfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEUx
NjJERUFEMUNDREQxMTNGMDRCM0Q0OTJCQkVEOUNCMUE2OEVGNTUACgkQK77Zyxpo
71Vy7hAAsqECPgNCUVkyjRKbsLasvsyqBDYkjZ95E9Sj+ONPGZ0npgaDkspF5UsW
BNxnUjavfx4TN999GKbgo2Hnv1v+PbLyi9BLqKJEpOnon5FkaqN58p8lXJhd3xh6
NDpKfW8okdfRyIWs2pTrJY4VesYhqGH3aFbFNqa5Md2IQSQzh1oYZ4IGjhxILSCp
DfE9qRcGH638i45l5k+tnwQTk6YIZ3wY7JaFNRZs+4UlsUKefnZtbXRlzdjxfmfP
T2VOY4zwCEwi/S9RlfpsqiCncC4x0MVpIw2+VGc6TyOrN38SIDr4UBklXzSa6jnG
v7KRD/GOVEEK+Grdv6XBREl9U1O0UMz1EVtDj8XKDge90XkAvSV+ci0O2fu0Qqoq
n7w6++KKKFmo/6zIwd8OKMqK7AifxI4gSliO1yQ/Znymk2DXh/hGiRELqS84+cM8
Dmv91gIcsZhc11nwAl8KkgQrmOQmEbEBuYn93B7u1UQXpNzhk5wg9TVpvNoQPjGk
QxnYhhmueb0O2tY2atRPtEeBfGBGBhidscSXjpwjQq3aP54ubpJMrdKPR5a77We6
KoKlptwNeAFxQ/9T/PpUsdk+BU/6fAvAnxUyY9oESI14sIub49hkjYJI7z2f7AYq
MHaHHYQhaibhjviT1XGYRclhT7E4Ye31uiVZ8sl9cym3aqAQHks=
=nc6b
-----END PGP SIGNATURE-----

--nKu0ZxG7ZnlLMg++--
