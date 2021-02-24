Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3442CC433E6
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 16:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2AC64E85
	for <selinux@archiver.kernel.org>; Wed, 24 Feb 2021 16:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbhBXQMP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:12:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235372AbhBXP4W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Feb 2021 10:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614182074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SxO3R0jKA/O+QBBZuSBx1pemK318klVrQyV7YEscO0E=;
        b=TqYfYspYFx5DSgaUucm+jsgmTd3FIHBtwS2jAgpm2nO1KUKmig90RizA8GUEntwKjG9+Gy
        6UxgfUnjjho9j77xL9m26e026v14rg1BPFycO6Bj7C9NdN4Fq3jNxcUVxuML+vt1g24WMf
        Uw7AJUr6/Fu61Q/GR9IJciBX1XsPCNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-d07GrSk1N1-ol1aNhJupoQ-1; Wed, 24 Feb 2021 10:54:28 -0500
X-MC-Unique: d07GrSk1N1-ol1aNhJupoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AC9090CAE2
        for <selinux@vger.kernel.org>; Wed, 24 Feb 2021 15:45:56 +0000 (UTC)
Received: from localhost (unknown [10.40.193.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7F9E60267
        for <selinux@vger.kernel.org>; Wed, 24 Feb 2021 15:45:55 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.2-rc3 release candidate
Date:   Wed, 24 Feb 2021 16:45:54 +0100
Message-ID: <87v9ah1nbh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

A 3.2-rc3 release candidate for the SELinux userspace is now=20
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out=20
in release notes for packagers and users in the final release
announcement, let us know.=20

Thanks to all the contributors to this release candidate!

User-visible changes since 3.2-rc2
----------------------------------

* Improved secilc documentation - fenced code blocks, syntax highlighting, =
custom
  color theme, ...

* Better error reporting in getconlist

* Improved selinux(8,5) and fixiles(8) man pages

* Bug fixes

Packaging-relevant changes since 3.2-rc2
----------------------------------------

* sestatus is installed as /usr/bin/sestatus by default. Original /usr/sbin=
/sestatus is
  a relative symlink to the /usr/bin/sestatus.


Shortlog of changes since the 3.2-rc2 release
-----------------------------------------------
Christian G=C3=B6ttsche (3):
      libselinux/getconlist: report failures
      policycoreutils/fixfiles.8: add missing file systems and merge check =
and verify
      libsepol/cil: handle SID without assigned context when writing policy=
.conf

Dominick Grift (1):
      secilc: fixes cil_role_statements.md example

James Carter (4):
      libsepol/cil: Fix integer overflow in the handling of hll line marks
      libsepol/cil: Destroy disabled optional blocks after pass is complete
      libsepol: Create function ebitmap_highest_set_bit()
      libsepol: Validate policydb values when reading binary policy

Nicolas Iooss (7):
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

Petr Lautrbach (3):
      libselinux: fix segfault in add_xattr_entry()
      policycoreutils: Resolve path in restorecon_xattr
      Update VERSIONs to 3.2-rc3 for release.

Vit Mojzis (2):
      selinux(8,5): Describe fcontext regular expressions
      gui: fix "file type" selection in fcontextPage

bauen1 (4):
      secilc/docs: use fenced code blocks for cil examples
      secilc/docs: add syntax highlighting for secil
      secilc/docs: add custom color theme
      policycoreutils: sestatus belongs to bin not sbin

