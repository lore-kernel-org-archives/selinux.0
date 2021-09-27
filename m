Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E24C433EF
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 08:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBB460F94
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 08:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhI0Ihq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Sep 2021 04:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233403AbhI0Ihp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Sep 2021 04:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632731767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDyTmS/MY5ciWf1QpkxWUNMKXUYhtNFfr+n6QkYQvgE=;
        b=TBcVTUQ1LMDDpBnI3XM0kvBJKL4pEC2D0cf/frFM72hSVRtwYny/S4o6P6wTk93QbcdSmE
        fbm0siqUVKZ8fZ8axnQQ4R3MRsAXrNGOU0zkDbQVh/sqd09tAoCEeTEgi3ilEe5UbhYb89
        f46dL5/UUu8qncYfExcPOvnZsjcWHs8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-anJ1Em6HNdexsDyxghuoMg-1; Mon, 27 Sep 2021 04:36:03 -0400
X-MC-Unique: anJ1Em6HNdexsDyxghuoMg-1
Received: by mail-yb1-f198.google.com with SMTP id o1-20020a056902110100b005b69483a0b4so1745448ybu.0
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 01:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=pDyTmS/MY5ciWf1QpkxWUNMKXUYhtNFfr+n6QkYQvgE=;
        b=VD8jRIoJ+DVoEoiTwXG0C3fmoXYHgot6vCKqKBi0l0eWYne/Rmydp22opBr/kz9/xk
         adlElEBKyyo+mQBqNoslsfehe9z3TgkfTySwXZdVqG+J8R67mdm3hwqUJH+s7kiTJLX4
         ZPqHhqCVVKHoBldEIQmfOQDi+f34QF/DVvxZVTAUsH652bQvV4vYjiHOFkV8UlccCElB
         fJ072WDIo2vA0Nb7Z1mnMhVXC3HjMaRDje982uwa6LHAPFrtKkEBm/8qO2jSjfHoPbuu
         yOuMRsnurGA4v619VvqjutXulqkbhSWERUPawXp0qob/lQPKFsJD/MGPG1xVcj/8n+Bd
         Ueog==
X-Gm-Message-State: AOAM532AekM9mLkxokTrbfFUKKa2alrdTwmUFTrd2Z/qi44tGydhxwUU
        wA8zn1QwkJTl/g4UwjsCd4TuwiqsW3s/GEIFm0CkvJeGJ5togk0fZEIosewQaZpiwYA6LzAe5nk
        ZzLx5HNK655cNDJzobrDmZhYaUg0WcsXNrQ==
X-Received: by 2002:a05:6902:1148:: with SMTP id p8mr27984165ybu.513.1632731763023;
        Mon, 27 Sep 2021 01:36:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjMBi0XpFum9ahWoQP84DaopYfrHi6LwburdACzjeRJ0WKKjlpIZohJVFXA1oFiNtDxWB9VkBHqS1mQZbEgm0=
X-Received: by 2002:a05:6902:1148:: with SMTP id p8mr27984146ybu.513.1632731762797;
 Mon, 27 Sep 2021 01:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210923101618.599881-1-omosnace@redhat.com>
In-Reply-To: <20210923101618.599881-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 27 Sep 2021 10:35:51 +0200
Message-ID: <CAFqZXNvEYwvikQeYv3E99KzMueXmS0Ywm1HekHtEvhO06Rtzwg@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/perf_event: don't assume CPU#0 is online
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 23, 2021 at 12:16 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The perf_event test currently uses hard-coded 0 as the CPU index.
> Howver, if CPU#0 happens to be offline, the test then fails because
> perf_event_open(2) returns -ENODEV.
>
> To fix this, try to find the index of the first online CPU and use that
> instead of the hard-coded value.
>
> Verified to work well on a machine with the first 8 CPU cores offline.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  tests/perf_event/perf_event.c | 23 ++++++++++++++---------
>  tests/perf_event/test         | 32 +++++++++++++++++++++++---------
>  2 files changed, 37 insertions(+), 18 deletions(-)

Now applied [1], along with a small workaround for module metadata
issue on F33 [2].

[1] https://github.com/SELinuxProject/selinux-testsuite/commit/7d737e1605f62ccce5ff36e8d1643afd66fc9abf
[2] https://github.com/SELinuxProject/selinux-testsuite/commit/29c42c865a9f43a15ae72ebd19642c3d88a7d5ce

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

