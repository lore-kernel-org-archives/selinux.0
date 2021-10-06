Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BB2C433EF
	for <selinux@archiver.kernel.org>; Wed,  6 Oct 2021 12:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B209610A8
	for <selinux@archiver.kernel.org>; Wed,  6 Oct 2021 12:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhJFMK3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Oct 2021 08:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238117AbhJFMK1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Oct 2021 08:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633522115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TUpTprsKu7QzeJ1kD956qwBdoawUmc8AQvhc6zUQoUU=;
        b=hTUQwk+tW53NML6LNLAfYG2N77yxyrNRqh4EuI9UQTIGu0Yb7cqev2NWcOe6GdSnQsJq8u
        JHUpG1nSYJYCnAwe1SLJXmqEQHULxW6k+dLzCcN5qoygHFjaSu3npRiKrqW9E52QvUqbAi
        Xx+D/PO4hb/TaxWGKFxmU9eVuITu8RI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-IQ6xFw_WMlaFCN7VkED71g-1; Wed, 06 Oct 2021 08:08:34 -0400
X-MC-Unique: IQ6xFw_WMlaFCN7VkED71g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97C3C824FB1
        for <selinux@vger.kernel.org>; Wed,  6 Oct 2021 12:08:33 +0000 (UTC)
Received: from localhost (unknown [10.40.192.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A6869AA20
        for <selinux@vger.kernel.org>; Wed,  6 Oct 2021 12:08:32 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Subject: ANN: SELinux userspace 3.3-rc3 release candidate
Date:   Wed, 06 Oct 2021 14:08:32 +0200
Message-ID: <87k0iqz77j.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

A 3.3-rc3 release candidate for the SELinux userspace is now
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out
in release notes for packagers and users in the final release
announcement, let us know.

Thanks to all the contributors to this release candidate!

If there's no big change, I'd like to announce 3.3 release next
Wednesday.


Changes since 3.3-rc2
----------------------------------

* Updated checkpolicy documentation
* checkpolicy prints the reason why opening a source policy file failed
* Bug fixes

Shortlog of changes since the 3.3-rc1 release
-----------------------------------------------
Christian G=C3=B6ttsche (10):
      Correct some typos
      libsepol: ebitmap: mark nodes of const ebitmaps const
      libsepol: use correct cast
      libsepol: resolve GCC warning about null-dereference
      libsepol/cil: silence clang void-pointer-to-enum-cast warning
      checkpolicy: policy_define: cleanup declarations
      checkpolicy: print reason of fopen failure
      checkpolicy: update documentation
      checkpolicy: drop incorrect cast
      checkpolicy: delay down-cast to avoid align warning

James Carter (2):
      libsepol/cil: Limit the amount of reporting for bounds failures
      libsepol/cil: Do not skip macros when resolving until later passes

Nicolas Iooss (2):
      README: update continuous integration badges
      GitHub Actions: do not use macOS latest runner for now

Petr Lautrbach (2):
      libselinux/semodule: Improve extracting message
      Update VERSIONs to 3.3-rc3 for release.

