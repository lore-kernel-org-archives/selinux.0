Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31B2C433EF
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 15:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D685761168
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 15:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhIVPbX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Sep 2021 11:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236395AbhIVPbT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Sep 2021 11:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632324589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wlcjkcuhd+6Wy9UyjgI4l6bhrc17w3g7VQYcoi3fSIc=;
        b=EDd3zheptNtWTCcfKvQJeSvZlDXiI6YpESLaCl9W8fb8RjbG+HY/GQIG3h+iIViVqE1HtZ
        YyN8uIrUm5w4gs7wHrLCCHsb4RuAPI2vRaivw6ijyjOwuTFhRK1jVqxdxb0Ppj4Phc1p7u
        6TcE/KgUSnU6R0sa0rDdzGFNcBiXtA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-Sl8o9tcEMhe2l0VfCO5l6A-1; Wed, 22 Sep 2021 11:29:47 -0400
X-MC-Unique: Sl8o9tcEMhe2l0VfCO5l6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACA5C802B9E
        for <selinux@vger.kernel.org>; Wed, 22 Sep 2021 15:29:46 +0000 (UTC)
Received: from localhost (unknown [10.40.194.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A7DA5C3DF
        for <selinux@vger.kernel.org>; Wed, 22 Sep 2021 15:29:46 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.3-rc2 release candidate
Date:   Wed, 22 Sep 2021 17:29:45 +0200
Message-ID: <8735pwvdau.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

A 3.3-rc2 release candidate for the SELinux userspace is now
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out
in release notes for packagers and users in the final release
announcement, let us know.

Thanks to all the contributors to this release candidate!

Changes since 3.3-rc1
----------------------------------

* Improved code quality and bug fixes

Shortlog of changes since the 3.3-rc1 release
-----------------------------------------------
Christian G=C3=B6ttsche (14):
      libsepol: avoid implicit conversions
      libsepol: free memory after policy validation
      checkpolicy: enclose macro argument in parentheses
      checkpolicy: misc checkmodule tweaks
      checkpolicy: misc checkpolicy tweaks
      checkpolicy: mark read-only parameters in module compiler const
      checkpolicy: mark file local functions in policy_define static
      checkpolicy: add missing function declarations
      checkpolicy: resolve dismod memory leaks
      checkpolicy: avoid implicit conversion
      checkpolicy: error out on parsing too big integers
      checkpolicy: print warning on source line overflow
      checkpolicy: free extended permission memory
      libselinux/utils: drop requirement to combine compiling and linking

James Carter (3):
      libsepol/cil: Free duplicate datums in original calling function
      libsepol/cil: Do not use original type and typeattribute datums
      libsepol/cil: Handle operations in a class mapping when verifying

Petr Lautrbach (2):
      libsepol/cil: Fix detected RESOURCE_LEAK (CWE-772)
      Update VERSIONs to 3.3-rc2 for release.

Topi Miettinen (1):
      libsepol: fix typo

