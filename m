Return-Path: <SRS0=Dm73=EB=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BA6C4363A
	for <selinux@archiver.kernel.org>; Mon, 26 Oct 2020 13:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EAED2463C
	for <selinux@archiver.kernel.org>; Mon, 26 Oct 2020 13:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1qInh0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780708AbgJZNyI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 26 Oct 2020 09:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1780702AbgJZNyG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 26 Oct 2020 09:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603720445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=WsdcKIJ2v6/xgKMlBikbCXew26Bt/Wq30k0hnJIhMxU=;
        b=N1qInh0oO373PGHPX96hj69NRx2M2HY+nbUYThXh3sZgm3QanK3u/kmgVHQ37MtRM72kOT
        FHaqkHXyHagvvuf/ISzzYb9xk7kkZ9Ed9veE8BcRIzaTGe6nYIL8IuKdZa2lJsfnLcyS+0
        wFSz/+woeAcqQzgPy7xhccgn0NMkaVA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-Fe1qZGOgOf2riFnaO7Tqeg-1; Mon, 26 Oct 2020 09:54:02 -0400
X-MC-Unique: Fe1qZGOgOf2riFnaO7Tqeg-1
Received: by mail-lj1-f197.google.com with SMTP id g15so5008959ljj.12
        for <selinux@vger.kernel.org>; Mon, 26 Oct 2020 06:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WsdcKIJ2v6/xgKMlBikbCXew26Bt/Wq30k0hnJIhMxU=;
        b=UVnHbB4zZFvs56/woOZffK6k9U3FEiewJ3Su60qDARI+qOkkwwivTCehGCAQoQTgt2
         9/cyTrUHcIu52iWlHMzsg4FSYt8ndnuG0rju8A6Qm6/bce+LJbb8ZvESi3rdzZw0egpb
         2PRItoFHd3qr+cP7lRdBcoG++rhsoehyFQb7NRIz9jzMGbgD2N1e1dKyQQ9S8LiMoEoe
         eFYMmmr3jjmazjiwEKJqzVrwIIoV5M9OoyW5+32EHd/8n/H4dGobVXJxGkGa5AFJ8KJK
         dUqiqHqwlAk2SEFif7OtlOPvIYH7MiLZp802yoKx5YEnjVoxLISsQMBpqMSY0vFgHGeG
         yGoA==
X-Gm-Message-State: AOAM530+WRJvrhLEx5g3zCT4OwlGvJVWWWcDLseNMgiNORWS439f+kFQ
        M74qdnxW9ST4TgPdEEit4hLcaLPj7148QUz261lQCrvnW1ZB1pbtoWQDNDwqlSyjl4UrscQQMzV
        O9KIxz87BpUte3TK/WR/8Rmt3UWaMoyXQZw==
X-Received: by 2002:a05:651c:234:: with SMTP id z20mr6324385ljn.337.1603720440212;
        Mon, 26 Oct 2020 06:54:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaU0vekO4YOHo+XiKC5UnDmD64hlZZa4hm4rJwaVq+jZtl85v7FIscNaq1n7tl5qs3kOW+T3hMx8Wrn0sICHY=
X-Received: by 2002:a05:651c:234:: with SMTP id z20mr6324377ljn.337.1603720439986;
 Mon, 26 Oct 2020 06:53:59 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 26 Oct 2020 14:53:49 +0100
Message-ID: <CAFqZXNtWg4+PrjizBcaa9hwQHdq1qQN4RzeqFS_y_8R9KZfMSA@mail.gmail.com>
Subject: [Travis/GitHub] Migrating SELinuxProject projects to travis-ci.com
 (vs. travis-ci.org)
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello everyone (mainly the maintainers of projects on GH, but to avoid
a huge cc list, I'm sending this to the ML),

As you may or may not know, Travis is migrating open-source projects
to their main site [1][2] (to .com from .org, where they have been
until now). AFAIK, the functionality stays pretty much the same, they
just want to have open-source and private projects under the same
infrastructure to unify things.

Recently, they started migrating runners away from the .org site [3],
resulting in new builds being queued for a very long time. [4]

I tried to migrate some of my forks (selinux-testsuite and selinux) to
the new site and it went smoothly. The only downside seems to be that
the build history is not migrated immediately (but it did show up
after a while). The queue times were indeed resolved after the
migration.

So, I'd like to propose to start migrating the projects under
SELinuxProject that use the Travis CI (selinux, refpolicy,
selinux-testsuite, setools) now, so that we are not affected by the
lack of workers.

If there are no objections until next week, I'll migrate the
selinux-testsuite, for a start. The other projects I'll leave for the
other maintainers, unless they choose to mandate me to do so :)

[1] https://docs.travis-ci.com/user/migrate/open-source-repository-migration
[2] https://travis-ci.community/t/org-to-com-migration-deadline/10260
[3] https://travis-ci.community/t/builds-hang-in-queued-state/10250/6
[4] https://www.traviscistatus.com/

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

