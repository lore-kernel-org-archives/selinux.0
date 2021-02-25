Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4EAC433DB
	for <selinux@archiver.kernel.org>; Thu, 25 Feb 2021 23:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78FB64F06
	for <selinux@archiver.kernel.org>; Thu, 25 Feb 2021 23:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhBYX2X (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 25 Feb 2021 18:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhBYX2V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 25 Feb 2021 18:28:21 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3FFC06174A
        for <selinux@vger.kernel.org>; Thu, 25 Feb 2021 15:27:40 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id mm21so11407595ejb.12
        for <selinux@vger.kernel.org>; Thu, 25 Feb 2021 15:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLcmTEjAiF5yFpxf27atOmC91/iDittSsNlvHgP+FGw=;
        b=WAV1PV1KABzooKU+nDNO9oCfpMmd7hnjojZfiA9jbcjxpJ5euqn3q1lz1J+VxZGzvs
         TOWw/xoVDYENrYzytLq03NBIbhDH57Jm9hAL/UFdbc/fYldOcIaMgkZOe9xhjoset08E
         KPFE5YyrjUcy6dFzxw5a1oPyprnC6RPg8cFd2bumvS+D39E3rrrMfyed598M4dsvw1YI
         0a7Jx66J1XZaiuR2n+n28/7/EjbwBQ92ir4SXmRFyHOegjQ7NNJfK9sCFpm+mg/rg2JF
         Og6zjWvOrK8ICMQLekXr9xk7mbkW3fjljVVxq8ZhPbr/gMziu1Ohp84sTiPzt0XDsxpl
         P3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLcmTEjAiF5yFpxf27atOmC91/iDittSsNlvHgP+FGw=;
        b=S2wuo3D8r21WWfvWoHFW9LvQaonqo8PHRftPtUnDnJKLKhKO1GfXlrOqu9pIR/4lG7
         7lqaMR+r8Zlnt/2cFjvpnSTM0HLQawiRD15/+XQkdBDZJeDcUOoX4qPhXnAL2yriVv3Z
         kX/VdqUxdtIY1ocWlOrtLmVIqa6eb1vuSFkbB3IHq+glAv7exizAE8KHycpw5nhm4eAB
         FvNp99ZkMz8bUBB70Esv6teMmiDLemLDQU14a6JS8HQgTmW0WNFdyG8eJ0LrGl78Y3yb
         Hmdf4p8193kPzbru9cuebrRSgh77C9ClROWc7TRBTwa/ePLxEdwlOWnGXtD74Nb9eFGq
         VrVA==
X-Gm-Message-State: AOAM533iFb4unlXYdTMieKtsmfOzvkGlYRTl73fS1QE18l5rbx+57+kh
        Tpd4PW3DR/jaLFUfzjWMdctRdAqZAaka6sv3BScT
X-Google-Smtp-Source: ABdhPJyWVS/hrD+V4AvttM+SSjvEy52dNqah1ffuwMS87KYsNyJ8cUUVc1mTEFfK+8tWKRBoVMuAEFf/vCbdv+CpJ2Y=
X-Received: by 2002:a17:906:2e91:: with SMTP id o17mr43073eji.488.1614295659553;
 Thu, 25 Feb 2021 15:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20210223214346.GB6000@sequoia> <20210223215054.GC6000@sequoia>
 <20210223223652.GD6000@sequoia> <CAFqZXNvfux46_f8gnvVvRYMKoes24nwm2n3sPbMjrB8vKTW00g@mail.gmail.com>
 <20210224143651.GE6000@sequoia> <CAFqZXNsNtAD56H0K-oOMkm=M_M6g=zuSvprDAWVk_phwQGk_TQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsNtAD56H0K-oOMkm=M_M6g=zuSvprDAWVk_phwQGk_TQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 25 Feb 2021 18:27:28 -0500
Message-ID: <CAHC9VhRTBrBU+PgWWyymeS+wvLKX5LRw8BZFZpS56eo2uMJedg@mail.gmail.com>
Subject: Re: [BUG] Race between policy reload sidtab conversion and live conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 25, 2021 at 11:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Unless someone objects, I'll start working on a patch to switch back
> to read-write lock for now. If all goes well, I'll send it sometime
> next week.

Sorry, I was looking at other things and just got to this ... I'm not
overly excited about switching back to the read-write lock so quickly,
I'd rather we spend some additional time looking into resolving issues
with the current RCU code.

-- 
paul moore
www.paul-moore.com
