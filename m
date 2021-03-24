Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB351C433E0
	for <selinux@archiver.kernel.org>; Wed, 24 Mar 2021 11:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AED03619E0
	for <selinux@archiver.kernel.org>; Wed, 24 Mar 2021 11:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhCXLEt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 07:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230500AbhCXLEh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 24 Mar 2021 07:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616583876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XsMmbUz1hkfzPR1TvrC0ldSm2aYuqBgNcDXEvvI7JOg=;
        b=hwRxHycj++Jua0b+wSA/uYJEH2NaPh/sPJsbNwzwJkOMF7zlqpBu3hWNziid9oIrZgkCKb
        lYoAB87KnuSlPH1NaNG0vVjF7DmxO+oQ3QkB0YiQSg5/u5EoQ5aN3AZYgeDqPszMrKvnTU
        Xk3mdyE409xOY5nUr+4ieea3G3bYisM=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-MV5uO4cOPG6EXiwcVvijmw-1; Wed, 24 Mar 2021 07:04:35 -0400
X-MC-Unique: MV5uO4cOPG6EXiwcVvijmw-1
Received: by mail-yb1-f199.google.com with SMTP id v6so1839855ybk.9
        for <selinux@vger.kernel.org>; Wed, 24 Mar 2021 04:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XsMmbUz1hkfzPR1TvrC0ldSm2aYuqBgNcDXEvvI7JOg=;
        b=GjFYKmqTq79y2FUMr4/h+3x+RZ966e3Pg+CScmSOOHW7BATYTnVx9MPMhU/ohGq5x0
         HwUeBlWCYPbFDhM5M40GUXJV6PLHIdEABw6QZ6Pu6gK1AgbJR2noLrSirT/BbqFe9eKc
         li6xPbyGkx1L7uSk+I55fzOpeewgC0++CacN8WtIvnpdF3Q/sVggMvYjAb9mbTFYVGHp
         4l0BsITTM67H5z2lIwY83eOTXvamNcWPmyASU8XX0wIlghyLxoup4bA2WEL8UA0lhfFF
         1VlzXzZDQ+GDgzrpXr7qISjplCwV16uQM3uwkn9zgaR4Z74aXpDGWjq2rhhJ+VdrEpAY
         xR2Q==
X-Gm-Message-State: AOAM530bQ+dO+46g7IMbPCJzPe52piVpTp6aeo4hWOootE0gkMgAhWDr
        1eUVdcRb2gZdI7egVNHSGD8Z3SybqptisgdUG7y2guVAf1FDkmaEHNoWYfduG3PWFmVeIWYl9nq
        mC3UezQJGsmijo8s+7ozfFBmHBUSV2AFKtw==
X-Received: by 2002:a5b:d43:: with SMTP id f3mr3886565ybr.81.1616583874310;
        Wed, 24 Mar 2021 04:04:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxNmzpRMN3Y27Q81NX9C6E09PUDWrjb4yEh5LB4In+UpQPeR1/hdQMZyFzokmEMOh4JVWL+KXexet+3rKhhaHY=
X-Received: by 2002:a5b:d43:: with SMTP id f3mr3886547ybr.81.1616583874121;
 Wed, 24 Mar 2021 04:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210323170830.182553-1-omosnace@redhat.com> <cd8c8721-0194-e2d3-b7a5-2f00834b5f60@sony.com>
In-Reply-To: <cd8c8721-0194-e2d3-b7a5-2f00834b5f60@sony.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 24 Mar 2021 12:04:23 +0100
Message-ID: <CAFqZXNvvDypzgzzbsBp9zQ1wOV=P9XmEPidmH_-8Zn2hGp-A5Q@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 0/6] Parallel setfiles/restorecon
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 24, 2021 at 10:59 AM peter enderborg
<peter.enderborg@sony.com> wrote:
> On 3/23/21 6:08 PM, Ondrej Mosnacek wrote:
> > This series adds basic support for parallel relabeling to the libselinux
> > API and the setfiles/restorecon CLI tools. It turns out that doing the
> > relabeling in parallel can significantly reduce the time even with a
> > relatively simple approach.
> Nice! Have you any figures? Is it valid for both solid state and mechanical storage?

They are in the last patch :) The VM setup I measured that on probably
had the storage backed up by an SSD (or something with similar
characteristics). I haven't tried it on an HDD yet.

> > The first patch is a small cleanup that was found along the way and can
> > be applied independently. Patches 2-4 are small incremental changes that
> > make the internal selinux_restorecon functions more thread-safe (I kept
> > them separate for ease of of review, but maybe they should be rather
> > folded into the netx patch...). Patch 5 then completes the parallel
> > relabeling implementation at libselinux level and adds a new function
> > to the API that allows to make use of it. Finally, patch 6 adds parallel
> > relabeling support to he setfiles/restorecon tools.
> >
> > The relevant man pages are also updated to reflect the new
> > functionality.
> >
> > The patch descriptions contain more details, namely the last patch has
> > also some benchmark numbers.
> >
> > Please test and review. I'm still not fully confident I got everything
> > right (esp. regarding error handling), but I wanted to put this forward
> > as an RFC to get some early feedback.
> >
> > Ondrej Mosnacek (6):
> >   selinux_restorecon: simplify fl_head allocation by using calloc()
> >   selinux_restorecon: protect file_spec list with a mutex
> >   selinux_restorecon: introduce selinux_log_sync()
> >   selinux_restorecon: add a global mutex to synchronize progress output
> >   selinux_restorecon: introduce selinux_restorecon_parallel(3)
> >   setfiles/restorecon: support parallel relabeling
> >
> >  libselinux/include/selinux/restorecon.h       |  14 +
> >  libselinux/man/man3/selinux_restorecon.3      |  29 +
> >  .../man/man3/selinux_restorecon_parallel.3    |   1 +
> >  libselinux/src/libselinux.map                 |   5 +
> >  libselinux/src/selinux_internal.h             |  14 +
> >  libselinux/src/selinux_restorecon.c           | 498 ++++++++++++------
> >  policycoreutils/setfiles/Makefile             |   2 +-
> >  policycoreutils/setfiles/restore.c            |   7 +-
> >  policycoreutils/setfiles/restore.h            |   2 +-
> >  policycoreutils/setfiles/restorecon.8         |   9 +
> >  policycoreutils/setfiles/setfiles.8           |   9 +
> >  policycoreutils/setfiles/setfiles.c           |  28 +-
> >  12 files changed, 436 insertions(+), 182 deletions(-)
> >  create mode 100644 libselinux/man/man3/selinux_restorecon_parallel.3
> >
>


--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

