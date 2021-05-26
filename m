Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE30C4708A
	for <selinux@archiver.kernel.org>; Wed, 26 May 2021 19:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B54613B5
	for <selinux@archiver.kernel.org>; Wed, 26 May 2021 19:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhEZTMe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 May 2021 15:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbhEZTMc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 May 2021 15:12:32 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CAAC061574
        for <selinux@vger.kernel.org>; Wed, 26 May 2021 12:10:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lg14so4143746ejb.9
        for <selinux@vger.kernel.org>; Wed, 26 May 2021 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMN6ChejNXJFYXToAoXG4lV7NHrdkhgPtkU3r94Vvkg=;
        b=rrEpfN2eSUWFwTnN59H3JQhAB5eFLKAJCg2tSavS1ZnxCW60lgzt33IwObabQh2Fiu
         R8otedpGlExOIZh5g2t3KeDEHthFgNq1Tw5Tl27NvK/Ol5bCJAu0NtWwcAaDGALwhO/A
         bOBmrwLBshkHZB8xUhrMI1yIP2wvejtGOyxHPdwD85dbPnHecSxw/UJV9E6KSGPlbGNn
         YFMesNoT/acoDSs5GvcbN7ez6HpdH129AZcY1OlbklrTQPR5ANzn7wdWVaXScc9ZcKDd
         d2DctUe3Woib8fuZANmiFmn3S+7eNKMuWsFxjXbOWuVZQSJC/jKuj3i0PmeX6GWLwsFj
         wxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMN6ChejNXJFYXToAoXG4lV7NHrdkhgPtkU3r94Vvkg=;
        b=MtBWzRdd0j+9zKZRlZMJdJTzIVdGllUklXQjHC6MUXNWlFSNyXWXAlN2eL3vK1LHH9
         QB4kxq2hoOO+62gdpS3xmDlib7Oqo8ZSS0WyySvS6FRGVGpAc5+vDFJwO+LWjXP+U1Bn
         Hwx9v3mV0GX/s5vaJ8FbKUckK+wMfkt7YSCqnOKdW+4ma6+9OBUKkLHhgw68aKur/+WD
         AO0wbxsvr1R+t6s2K/u+XmF8dKdwrbwtMklJUhLM4ZHeCbdEFY+df8OYKfBbv6xEtXdR
         O5RtL3tjmk7+zaFapnVf3ntvxAhr67JSlmj2D9z2iVjk+A3jIBjja0krOGTzHas8zEn0
         mRcw==
X-Gm-Message-State: AOAM530ROTe8X6De5f46Wx4XYP6Xv17I/faTTwhFF6ytqm+KRAeYceQ8
        JWpQD0xSEG40whFeh6kvZMmgQBEaz0iYPJXsVvM+
X-Google-Smtp-Source: ABdhPJw5Uo6wSn4k4zz/jz3Ayrk4WGYUWInTcmg7vYqy+K7NbwQFUmlxJqbAcL8Cf1k2FEX+enTA83rXl0PTreAKR3g=
X-Received: by 2002:a17:906:7e0f:: with SMTP id e15mr34549005ejr.398.1622056258166;
 Wed, 26 May 2021 12:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <162163367115.8379.8459012634106035341.stgit@sifl>
 <x498s41o806.fsf@segfault.boston.devel.redhat.com> <CAHC9VhQ9r7WHbq2ga+-PF0x5q29nkdNjbLouQETvxDtjE3QaQg@mail.gmail.com>
 <x49o8cxmi02.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49o8cxmi02.fsf@segfault.boston.devel.redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 May 2021 15:10:46 -0400
Message-ID: <CAHC9VhS-R-bNtoOZnENN4TJX7ztpjWBUsnLMbCfXJDpe42JdqQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add LSM access controls and auditing to io_uring
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, May 26, 2021 at 3:06 PM Jeff Moyer <jmoyer@redhat.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Wed, May 26, 2021 at 10:59 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >> Paul Moore <paul@paul-moore.com> writes:
> >>
> >> > Also, any pointers to easy-to-run io_uring tests would be helpful.  I
> >> > am particularly interested in tests which make use of the personality
> >> > option, share urings across process boundaries, and make use of the
> >> > sqpoll functionality.
> >>
> >> liburing contains a test suite:
> >>   https://git.kernel.dk/cgit/liburing/
> >>
> >> You can run it via 'make runtests'.
> >
> > Thanks Jeff, I'll take a look.  Quick question as I start sifting
> > through the tests, are there any tests in here which share a single
> > ring across process boundaries?
>
> Yes.  At the very least, this one:
>
> test/across-fork.c

Great, thanks!

-- 
paul moore
www.paul-moore.com
