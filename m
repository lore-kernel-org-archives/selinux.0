Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1165C4338F
	for <selinux@archiver.kernel.org>; Fri,  6 Aug 2021 13:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BACD60F43
	for <selinux@archiver.kernel.org>; Fri,  6 Aug 2021 13:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbhHFNTB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Aug 2021 09:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241700AbhHFNTB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Aug 2021 09:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628255925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=7jPmbjHSwToin7tXHJC+TjiUAhgBvuhMkkrK/FKk7c8=;
        b=FZjYkjVUBjcGYb/ECFfAAieRF+DdeZkyEVE+UNl/z+XbT2pajEJDMLjVLOTWTUTbCmPyu0
        mEPNn9ECsJuOXdfHm5rAlz4GcpLR9BCdrU6CBd2g/uQrJaI/z+GBmBYBekNUY58Fpnepk5
        u0T/xpeQAU8obJzEKkYhvwN68q1FuqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-zrPjYrbGOFu821Tw6td6mQ-1; Fri, 06 Aug 2021 09:18:43 -0400
X-MC-Unique: zrPjYrbGOFu821Tw6td6mQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1B131023F41
        for <selinux@vger.kernel.org>; Fri,  6 Aug 2021 13:18:42 +0000 (UTC)
Received: from localhost (unknown [10.40.192.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D01B100164C
        for <selinux@vger.kernel.org>; Fri,  6 Aug 2021 13:18:42 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: lets think about 3.3 release
Date:   Fri, 06 Aug 2021 15:18:41 +0200
Message-ID: <87fsvmu2xa.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

I's about 184 commits and 5 months since the last release so I think
it's time to slowly stop the development and start with 3.3 release
candidates.

According to patchwork, there are few patches in queue which need to be
reviewed, or which were reviewed and some change for requested:

* https://patchwork.kernel.org/patch/11436955/ New [RFC] libsepol,secilc,policycoreutils: add unprivileged sandboxing capability
* https://patchwork.kernel.org/patch/11668455/ New selinux: make use of variables when defining libdir and includedir

old, without any activity for a long time

* https://patchwork.kernel.org/patch/12291637/ New [v2] checkpolicy: fix the leak memory when uses xperms

changes requested

* https://patchwork.kernel.org/patch/12372487/ New [v2] libselinux: add lock callbacks
* https://patchwork.kernel.org/patch/12377593/ New libselinux/utils: drop requirement to combine compiling and linking

no response yet

* https://patchwork.kernel.org/patch/12420657/ New [userspace]  libsepol/cil: remove obsolete comment

acked, ready to be merged

* https://patchwork.kernel.org/patch/12422971/ New mcstrans: Improve mlstrans-test output

no response yet


if I missed something please tell me.


There's one issue opened on the mailing list

https://lore.kernel.org/selinux/874kc57220.fsf@defensec.nl/T/#t -
libsepol regressions

If you agree and there's no obejction I can start with preparation and
plan to release 3.3-rc1 on Wed Aug 18 2021


Petr

