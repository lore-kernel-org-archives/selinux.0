Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE523C433EF
	for <selinux@archiver.kernel.org>; Wed, 20 Oct 2021 12:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3BB260FD8
	for <selinux@archiver.kernel.org>; Wed, 20 Oct 2021 12:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhJTMZS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229941AbhJTMZR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Oct 2021 08:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634732583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=HVDUU0dx1+XUYeOsuMMUVf9jhaMSOAoFNPeyh9doTQc=;
        b=fv9FIh4rSuXxjsv+OUppJeCLfUMdGzCzeik6mpAhJV+JncUo2yYzAHMv0n4Y1mVB69mKqZ
        Mb2B1e1MlekAwK3k6HwmScMx54i/vuJlM12fQnCpOaEIRJllZbdaPX1P8iccYr0hlzeTG6
        /7b6Uk9f8THjhP1l6BDJteomog0ihSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-rzbDBnR1OFSUaOkNSU0P0g-1; Wed, 20 Oct 2021 08:23:01 -0400
X-MC-Unique: rzbDBnR1OFSUaOkNSU0P0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C74AF100CCC0
        for <selinux@vger.kernel.org>; Wed, 20 Oct 2021 12:23:00 +0000 (UTC)
Received: from localhost (unknown [10.40.192.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61B4A10429D2
        for <selinux@vger.kernel.org>; Wed, 20 Oct 2021 12:23:00 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Release 3.3 or not?
Date:   Wed, 20 Oct 2021 14:22:59 +0200
Message-ID: <87a6j3khr0.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

2 weeks ago I wrote that I would like to release 3.3 if there's no big
change. But in the mean time some patchsets landed on mailing list, see
bellow. My question is: do we want to wait until they are merged or it's
ok to postpone them to 3.4 development? Please let me know.

* https://patchwork.kernel.org/project/selinux/list/?series=561273&state=*
libsepol: add fuzzer for reading binary policies
    
it was reviewed by Jim who requested some changes.

* https://patchwork.kernel.org/project/selinux/list/?series=566429
libsepol: do not pass NULL to memcpy

v2 with requested changes, waits for review


* https://patchwork.kernel.org/project/selinux/patch/20211015123100.15785-1-cgzones@googlemail.com/
libselinux: use dummy variable to silence glibc 2.34 warnings

reviewed by Nicolas, work in progress I guess


* https://patchwork.kernel.org/project/selinux/list/?series=566423&state=*
Parallel setfiles/restorecon 

3rd version of the patchset, waits for review



Petr

