Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B4CC5DF60
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 13:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01352075C
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 13:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfKGNjg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:39:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52635 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbfKGNjg (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 7 Nov 2019 08:39:36 -0500
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C1E4C057F31
        for <selinux@vger.kernel.org>; Thu,  7 Nov 2019 13:39:36 +0000 (UTC)
Received: by mail-oi1-f197.google.com with SMTP id t185so2063130oif.13
        for <selinux@vger.kernel.org>; Thu, 07 Nov 2019 05:39:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkGDFjTO3jBR5DpuiwiTDWHg3p09M1bKrjva9VA9NpU=;
        b=GbLm5rtvvg0mkcrnuQcBwX1DzqRswzLdRbtBegb0RPVfSLyQhWm4+hiFdnxIwAYCuO
         l5dyhsbMMdAAYCNdd6Z2zaW/M3SmulxB0qS/k7UHrJ55fT2E8SEJ/tJnHjYba8nWssVh
         lcdAAE7lLJNZzMWEj8joiyG/rhp//DuxNAYv2y8i0as99QW8yaDw1dZOf9uQVr10Y3cd
         1TWYn3L0KsmJd1q0qipVzRijV//tcGkMMK7sfxkBC+eG60NE2eusv2VuN1al0MxMLhTa
         /ZB6mAJvMla4boCI7FgYfZD89Vxvi2mRqWyUPClNHv4hc4+PgQVFr9rBQF+Hpu3FHogM
         kkcQ==
X-Gm-Message-State: APjAAAX01HjdNmXb8GbvpdQS0mLr7f+Wp80f+jd6VpCNtQHSTOjV4Duu
        CNp7rELLacGhkkCqD7UeOIWy37XH+xLWXXrx6b4ExvLJz57YHXbwLBiJkYodwhUTQVrGI4JUhhA
        LOkqRrboXH1sPcv4CkmesFc+QDZ6lvlTDzA==
X-Received: by 2002:a05:6808:8d8:: with SMTP id k24mr2608965oij.26.1573133975403;
        Thu, 07 Nov 2019 05:39:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqy0BnQ5rARVfHjyCvW58etyYjLRqntVA1nBn74xccIrpzS51YVfX7rwxR9cbeb1lZeciORafU5UdR7Tle3bN2s=
X-Received: by 2002:a05:6808:8d8:: with SMTP id k24mr2608936oij.26.1573133975043;
 Thu, 07 Nov 2019 05:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20191031191520.2849-1-sds@tycho.nsa.gov> <CAHC9VhTeZ_PS2UUqZ=6tGtGegsi2yFV7hFm701gjG0fGvt8sag@mail.gmail.com>
In-Reply-To: <CAHC9VhTeZ_PS2UUqZ=6tGtGegsi2yFV7hFm701gjG0fGvt8sag@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 7 Nov 2019 14:39:23 +0100
Message-ID: <CAFqZXNvY3fJMwoAueP_sq8KoX6x5_CER=RxTXcxA2xGF_q6Cng@mail.gmail.com>
Subject: Re: [PATCH v3] selinux-testsuite: add tests for fsnotify
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Lukas Vrabec <lvrabec@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 5, 2019 at 4:02 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Oct 31, 2019 at 3:15 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > From: Aaron Goidel <acgoide@tycho.nsa.gov>
> >
> > Added a suite to test permissions for setting inotify and fanotify watches
> > on filesystem objects. Tests watch, watch_with_perm, and watch_reads
> > permissions.
> >
> > Signed-off-by: Aaron Goidel <acgoide@tycho.nsa.gov>
> > [sds@tycho.nsa.gov: fix whitespace, check-syntax -f, policy cleanup]
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  policy/Makefile              |   4 ++
> >  policy/test_notify.te        |  94 +++++++++++++++++++++++++
> >  tests/Makefile               |   4 ++
> >  tests/notify/Makefile        |   5 ++
> >  tests/notify/test            | 133 +++++++++++++++++++++++++++++++++++
> >  tests/notify/test_fanotify.c | 109 ++++++++++++++++++++++++++++
> >  tests/notify/test_inotify.c  |  43 +++++++++++
> >  7 files changed, 392 insertions(+)
> >  create mode 100644 policy/test_notify.te
> >  create mode 100644 tests/notify/Makefile
> >  create mode 100755 tests/notify/test
> >  create mode 100644 tests/notify/test_fanotify.c
> >  create mode 100644 tests/notify/test_inotify.c
>
> Merged, thanks Aaron and Stephen.
>
> Lukas, do you know when you expect to merge the necessary policy
> support into Fedora?

This is currently blocked on me making some changes to [1], sorry... I
hope I'll find some time to get to it in the upcoming days...

[1] https://github.com/fedora-selinux/selinux-policy/pull/288

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
