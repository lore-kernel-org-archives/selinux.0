Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25497C433EF
	for <selinux@archiver.kernel.org>; Wed, 27 Oct 2021 11:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A7160ED4
	for <selinux@archiver.kernel.org>; Wed, 27 Oct 2021 11:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbhJ0Lpw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Oct 2021 07:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235172AbhJ0Lpv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Oct 2021 07:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635335004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6X93su+z4EwrRkhV52FvFbsK5ZAwm9NtZ/uZ55fiRmU=;
        b=c/FyI9yGpah6Np3sr1tRvkaJv3gC1OZ/0NPiJLeXNPY9JzqmgX1jxW0gB6KyAPwpZ+uTRG
        Mk1OFq+p0bQgysWUspmgkwZD7gGtwiLLMgZrwEt+EuImO6z184XqCXjcagAxxVQiEFsqUY
        rf7mI+gTTQ1Xt4nC9qK+9ql+u80RQ6c=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-W-L04i32OtOP3-tF3LmSDQ-1; Wed, 27 Oct 2021 07:43:23 -0400
X-MC-Unique: W-L04i32OtOP3-tF3LmSDQ-1
Received: by mail-yb1-f199.google.com with SMTP id m81-20020a252654000000b005c135d4efdeso3338435ybm.22
        for <selinux@vger.kernel.org>; Wed, 27 Oct 2021 04:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6X93su+z4EwrRkhV52FvFbsK5ZAwm9NtZ/uZ55fiRmU=;
        b=5yTatvTkyHotFXUPGdBMKDtxcbCPAFq8qxtjziDShCvYX4d34M+48hpVNtY7a08rxh
         xS4wBl1bQPXjjtzk43GLHjuy5KZnUQknrrZeNpsn/tBO1j8+JQddXx3z8ziKDiWfq+Sg
         dmU1sANojc74CjI1aVOZbUjjwoY+W0wYDdaguujSnP61s2QatTCL45MjVN8AYVQEOLNu
         ce5ZD9j4MbK53ep1bJqbSWrezStAsugTLkpsYsTBYzqIuHEG28CNaWmVHvi3y4lx6dK9
         6Pe4fr0E2NdP/HlxyjLR5eAeqPWJQbABzXf32m7aKyWaamMBL2/fJ2p9Ir1IVc6aw4y3
         pYVA==
X-Gm-Message-State: AOAM531HfBdERZjjeXJDAhPc9OAwKt78mqmpUIs8xWW1e88wbDju80T/
        oa88b987bXl1B4+ME16hODUdaZvyKOxUhHq5csrA7zunS3EV2lqFqOhaNDyOYbV7Drp8v0Hshj6
        NqysvxBp9iSEA6wDsm2Gr0SMLhS2YPbHEKw==
X-Received: by 2002:a25:7102:: with SMTP id m2mr5805153ybc.25.1635335002547;
        Wed, 27 Oct 2021 04:43:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIdjx15LSDysoOyMdKeWl3pCCoVQ/VBPWnx+o6meOOxOupRvIFx9ab/NXVkrBGhbgGiqogczycHAjDA/9BjkE=
X-Received: by 2002:a25:7102:: with SMTP id m2mr5805129ybc.25.1635335002241;
 Wed, 27 Oct 2021 04:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211025141907.189316-1-omosnace@redhat.com>
In-Reply-To: <20211025141907.189316-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 Oct 2021 13:43:11 +0200
Message-ID: <CAFqZXNsQ98DrOB_1tHD_LkL83CpYDTYbD1uKHp-NuGHa_P9mVg@mail.gmail.com>
Subject: Re: [PATCH testsuite v2] tests: make kernel iptables support optional
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 25, 2021 at 4:19 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The legacy iptables API is being deprecated in favor of netfilter and
> some distributions are starting to disable it in their kernels (e.g.
> Fedora ELN, RHEL 10+). To allow getting a clean run of the testsuite on
> such kernels, detect the availability of the ip_tables kernel module and
> skip the iptables tests if it's not available (either as a loadable
> module or built in).
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v2: do the same also in tests/sctp, not just tests/inet_socket
>
>  tests/inet_socket/test | 21 ++++++++++++++++-----
>  tests/sctp/test        | 21 ++++++++++++++++-----
>  2 files changed, 32 insertions(+), 10 deletions(-)

Merged:
https://github.com/SELinuxProject/selinux-testsuite/commit/b2d0f3c5f946e58e3e6f8f1fff81d8435b005f92

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

