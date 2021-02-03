Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5080DC433DB
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 10:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0A364F5C
	for <selinux@archiver.kernel.org>; Wed,  3 Feb 2021 10:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhBCK7u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Feb 2021 05:59:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233575AbhBCK7u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Feb 2021 05:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612349904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BRWTqVUS5iq0ps3rjOny9u7V83h8WBUso3Ji1ZcZQF8=;
        b=A/8j0W6XJCbQESJHqhJossUWxhccXcyd1RbdYe905uojEvEXSiNFUUk1wbHLX38Or84TNi
        WMldje4wPRkdxeHVoK+OxCKnnjSwtUN4gJtk6E0X1hOppBzI17rqyPKG50yxg8/SIJWwQN
        0MJkRBAJbohupTZA+35F+HQgyoQpuNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-t_IjATRFNMWhcDkEkLjAuA-1; Wed, 03 Feb 2021 05:58:21 -0500
X-MC-Unique: t_IjATRFNMWhcDkEkLjAuA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E3F3801AB2
        for <selinux@vger.kernel.org>; Wed,  3 Feb 2021 10:58:20 +0000 (UTC)
Received: from localhost (unknown [10.40.195.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C21F27771D
        for <selinux@vger.kernel.org>; Wed,  3 Feb 2021 10:58:19 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.2-rc2 release candidate
Date:   Wed, 03 Feb 2021 11:58:18 +0100
Message-ID: <87lfc5mn91.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

A 3.2-rc2 release candidate for the SELinux userspace is now=20
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out=20
in release notes for packagers and users in the final release
announcement, let us know.=20

Thanks to all the contributors to this release candidate!

User-visible changes since 3.2-rc1
----------------------------------

* Improved usability of `getseuser`

* Fixed several issues in cil code found by OSS-FUZZ

* `setfiles` doesn't abort on labeling errors

* libsemanage tries to sync data to prevent empty files in SELinux module s=
tore

Development-relevant changes since 3.2-rc1
------------------------------------------

* `scripts/release` was improved to be more robust and release a source rep=
ository
=20
Packaging-relevant changes since 3.2-rc1
----------------------------------------

* Source repository snapshot selinux-3.2-rc2.tar.gz is available on the rel=
ease page

Shortlog of changes since the 3.2-rc1 release
-----------------------------------------------
Christian G=C3=B6ttsche (2):
      libselinux: accept const fromcon in get_context API
      libselinux: update getseuser

James Carter (3):
      libsepol/cil: Update symtab nprim field when adding or removing datums
      libsepol/cil: Fix heap-use-after-free in __class_reset_perm_values()
      libsepol/cil: Fix heap-use-after-free when using optional blockinherit

Nicolas Iooss (4):
      GitHub Actions: run SELinux testsuite in Fedora virtual machine
      libsepol/cil: fix memory leak when a constraint expression is too deep
      libsepol/cil: unlink blockinherit->block link when destroying a block
      scripts/release: make the script more robust, and release a source re=
pository snapshot

Petr Lautrbach (5):
      setfiles: Do not abort on labeling error
      setfiles: drop ABORT_ON_ERRORS and related code
      libsemanage: sync filesystem with sandbox
      policycoreutils/setfiles: Drop unused nerr variable
      Update VERSIONs to 3.2-rc2 for release.

Vit Mojzis (1):
      python/sepolgen: allow any policy statement in if(n)def

