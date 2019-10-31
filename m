Return-Path: <SRS0=943q=YY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F38CA9EC3
	for <selinux@archiver.kernel.org>; Thu, 31 Oct 2019 09:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE142083E
	for <selinux@archiver.kernel.org>; Thu, 31 Oct 2019 09:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6pOOXeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfJaJni (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:43:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20290 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726960AbfJaJni (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 31 Oct 2019 05:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572515016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7Ti2lHQ4qKHAoeXd645TCwWLPHu3Qx1dtidS6Sn9vIg=;
        b=W6pOOXePYVQGhGInG1tgFX60NRF6QTAuV3zbly8D6zh1iicQVDbdzK0rye/UvlvKmUjeeR
        6SUEns0xxR8ZZxNgSezi3Pk7fv9RzLe+6z7TePOZDaxSQr/DPW3Nm7lhTg/VRik1RSmxLo
        BDedZHrQh+xoENckGS40Y1HCwlgbO9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-UdvICDsWOwW-EP0SP0YQCg-1; Thu, 31 Oct 2019 05:43:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED6071800D56
        for <selinux@vger.kernel.org>; Thu, 31 Oct 2019 09:43:32 +0000 (UTC)
Received: from localhost (ovpn-204-65.brq.redhat.com [10.40.204.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DEAA1001B23
        for <selinux@vger.kernel.org>; Thu, 31 Oct 2019 09:43:32 +0000 (UTC)
User-agent: mu4e 1.2.0; emacs 26.2
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Subject: ANN: SELinux userspace 3.0-rc1 release candidate
Date:   Thu, 31 Oct 2019 10:43:30 +0100
Message-ID: <pjd1rut9rnh.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: UdvICDsWOwW-EP0SP0YQCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

A 3.0-rc1 release candidate for the SELinux userspace is now=20
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out=20
in release notes for packagers and users in the final release
announcement, let us know.=20

Thanks to all the contributors to this release candidate!

User-visible changes:

* Optional support for kernel policy optimization (enable with
optimize-policy=3Dtrue in /etc/selinux/semanage.conf for modular policy or =
-O
option to checkpolicy/secilc for monolithic policy); this is optional becau=
se it
provides relatively small savings with non-trivial policy compile-time over=
head
for some policies e.g. Android.

* New digest scheme for setfiles/restorecon -D; instead of a single hash of=
 the
entire file contexts configuration stored in a security.restorecon_last xat=
tr on
only the top-level directory, use a hash of all partial matches from file
contexts stored in a security.sehash xattr on each directory,

* Support for default_range glblub in source policy (.te/policy.conf and CI=
L)
and kernel policy version 32,

* New libselinux APIs for querying validatetrans rules,

* Unknown permissions are now handled as errors in CIL,

* security_av_string() no longer returns immediately upon encountering an
unknown permission and will log all known permissions,

* checkmodule -c support for specifying module policy version,

* mcstransd reverted to original color range matching based on dominance,

* Support for 'dccp' and 'sctp' protocols in semanage port command,

* 'checkpolicy -o -' writes policy to standard output,

* 'semodule -v' sets also cil's log level

Issues fixed:

* https://github.com/SELinuxProject/selinux/issues/61
* https://github.com/SELinuxProject/selinux/issues/137
* https://github.com/SELinuxProject/selinux/issues/138
* https://github.com/SELinuxProject/selinux/issues/167
* https://github.com/SELinuxProject/selinux/issues/169
* https://github.com/SELinuxProject/selinux/issues/176

A shortlog of changes since the 2.9 release:

Aleksei Nikiforov (1):
      Update man pages translation by Olesya Gerasimenko

Gary Tierney (2):
      checkmodule: add support for specifying module policy version
      dismod: print policy version of loaded modules

James Carter (4):
      checkpolicy: add flag to enable policy optimization
      libsepol: Make an unknown permission an error in CIL
      libsepol: Remove cil_mem_error_handler() function pointer
      libsepol: Further improve binary policy optimization

Jan Zarsky (11):
      libsemanage: add helper functions to tests
      libsemanage: test semanage_handle_* functions
      libsemanage: test semanage_bool_* functions
      libsemanage: test semanage_fcontext functions
      libsemanage: test semanage_iface_* functions
      libsemanage: test semanage_ibendport_* functions
      libsemanage: test semanage_node_* functions
      libsemanage: test semanage_port_* functions
      libsemanage: test semanage_user_* functions
      libsemanage: test semanage_context_* functions
      libsemanage: test semanage_msg_default_handler

Jason Zaman (1):
      policycoreutils: semodule: Enable CIL logging

Jokke H=C3=A4m=C3=A4l=C3=A4inen (2):
      libsepol: Check strdup() failures
      libsepol: Replace constant with sizeof()

Joshua Brindle (2):
      Add security_validatetrans support
      Add default_range glblub support

Laurent Bigonville (4):
      restorecond: Do not link against libpcre
      Add documentation key in systemd .service files
      mcstrans: Move setrans.conf manpage to section 5
      mcstrans: Add reference to setools.conf man page in the daemon one

Masatake YAMATO (3):
      checkpolicy: remove a redundant if-condition
      checkpolicy: update the description for -o option in the man page
      checkpolicy: allow to write policy to stdout

Mike Palmiotto (2):
      libsepol/cil: fix mlsconstrain segfault
      libselinux: fix string conversion of unknown perms

Nicolas Iooss (23):
      restorecond: use /run instead of /var/run
      libsepol: include module.c internal header in module_to_cil.c
      libsepol: initialize a local variable once
      libselinux: ensure that digest_len is not zero
      libsemanage: include internal header to use the hidden function proto=
types
      libsepol: do not dereference a failed allocated pointer
      semodule-utils: fix comparison with argc
      libsepol: do not dereference scope if it can be NULL
      libsepol: reset *p to NULL if sepol_module_package_create fails
      libsepol/cil: do not dereference perm_value_to_cil when it has not be=
en allocated
      python/chcat: remove unnecessary assignment
      python/sepolicy: remove unnecessary pass statement
      libsepol/tests: do not dereference a NULL pointer
      Add configuration file for lgtm.com
      Fix many misspellings
      libselinux: ensure strlen() is not called on NULL
      libselinux: do not add rc to pos twice
      CircleCI: run scan-build and publish its results automatically
      libsepol, libsemanage: add a macro to silence static analyzer warning=
s in tests
      libsemanage/tests: return when str is NULL
      libsemanage/tests: check that string pointers are not NULL before com=
paring them
      libselinux: mark all exported function "extern"
      libsemanage: mark all exported function "extern"

Ondrej Mosnacek (6):
      libsepol: add ebitmap_for_each_set_bit macro
      run_init: fix build when crypt() is not in unistd.h
      libsepol: add a function to optimize kernel policy
      libsemanage: optionally optimize policy on rebuild
      secilc: add flag to enable policy optimization
      sepolicy: generate man pages in parallel

Petr Lautrbach (12):
      gui: Install polgengui.py to /usr/bin/selinux-polgengui
      gui: Install .desktop files to /usr/share/applications by default
      semanage/semanage-boolean.8: Fix a minor typo
      Add CONTRIBUTING.md
      libselinux: Use Python distutils to install SELinux python bindings
      policycoreutils/fixfiles: Fix [-B] [-F] onboot
      policycoreutils/fixfiles: Force full relabel when SELinux is disabled
      gui: Fix remove module in system-config-selinux
      python/semanage: Do not use default s0 range in "semanage login -a"
      Switch last 2 files using /usr/bin/env to /usr/bin/python3
      libsepol: Use LIBSEPOL_3.0 and fix sepol_policydb_optimize symbol map=
ping
      Update VERSIONs to 3.0-rc1 for release.

Richard Haines (6):
      libsepol/cil: Allow validatetrans rules to be resolved
      libselinux: Fix security_get_boolean_names build error
      libselinux: Save digest of all partial matches for directory
      setfiles: Update utilities for the new digest scheme
      selinux: Remove legacy local boolean and user code
      selinux: Update manpages after removing legacy boolean and user code

Stephen Smalley (1):
      python/sepolicy: call segenxml.py with python3

Unto Sten (9):
      Global replace exit(0) with more readable exit(EXIT_SUCCESS)
      Unify code style to preserve my sanity
      another style fix
      Check strdup() failure
      Trivial style improvements
      Trivial style fixes
      Remove unneeded int
      Remove redundant if-clause
      More accurate error messages

Vit Mojzis (8):
      Revert "mcstransd select correct colour range."
      Fix mcstrans secolor examples
      policycoreutils/fixfiles: Fix "verify" option
      python/semanage: Improve handling of "permissive" statements
      python/semanage: fix moduleRecords.customized()
      libsemanage: Add support for DCCP and SCTP protocols
      python/semanage: Add support for DCCP and SCTP protocols
      python/semanage: Document DCCP and SCTP support

xunchang (2):
      Restorecon: factor out a lookup helper for context matches
      libselinux: Ignore the stem when looking up all matches in file conte=
xt

Petr

