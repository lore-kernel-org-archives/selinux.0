Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A0C433F5
	for <selinux@archiver.kernel.org>; Wed,  4 May 2022 18:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377335AbiEDSwc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 May 2022 14:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377355AbiEDSwa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 May 2022 14:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71DF415FC8
        for <selinux@vger.kernel.org>; Wed,  4 May 2022 11:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651690132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OsPPmwqjTj2ObYlu51dLweVoYvqdv0QYqdclmtJUXbc=;
        b=JC71qS8A5hTnxMevXswdD4NHeI4CSTqYNlkKpzUVNuVZkzM0pHULzPkzJ5OKzmX5Somf0a
        iGqsZjGVOII9G7PgPA4rz5HM3R518IqVHa/jTqyfSRWEaZ91Pq/7xx/17+1u9Jfmr28+V8
        nGYxxRIN+bgRzxqhjyWJ9a2eAaUImYk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-voL_XHd0MfKKM3k9NCZAXA-1; Wed, 04 May 2022 14:48:51 -0400
X-MC-Unique: voL_XHd0MfKKM3k9NCZAXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF97F805F71
        for <selinux@vger.kernel.org>; Wed,  4 May 2022 18:48:50 +0000 (UTC)
Received: from localhost (unknown [10.40.195.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4914B200C0EB
        for <selinux@vger.kernel.org>; Wed,  4 May 2022 18:48:43 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: ANN: SELinux userspace 3.4-rc3 release candidate
Date:   Wed, 04 May 2022 20:48:41 +0200
Message-ID: <878rrh877a.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

A 3.4-rc3 release candidate for the SELinux userspace is now
available at:

https://github.com/SELinuxProject/selinux/wiki/Releases

Tarballs are signed with
https://people.redhat.com/plautrba/plautrba@redhat.com.asc

Please give it a test and let us know if there are any issues.

If there are specific changes that you think should be called out
in release notes for packagers and users in the final release
announcement, let us know.

Thanks to all the contributors to this release candidate!

Changes since 3.4-rc2
---------------------
* A new setfiles option [-C] for distinguishing file tree walk errors

* Added missing sandbox translations

Shortlog of changes since the 3.4-rc2 release
---------------------------------------------
Christian G=C3=B6ttsche (1):
      checkpolicy: mention class name on invalid permission

Laszlo Ersek (5):
      setfiles: fix up inconsistent indentation
      setfiles: remove useless assignment and comment (after RHBZ#1926386)
      setfiles: remove useless "iamrestorecon" checks in option parsing
      selinux_restorecon: introduce SELINUX_RESTORECON_COUNT_ERRORS
      setfiles: introduce the -C option for distinguishing file tree walk e=
rrors

Petr Lautrbach (2):
      Update missing sandbox translations
      Update VERSIONs to 3.4-rc3 for release.

