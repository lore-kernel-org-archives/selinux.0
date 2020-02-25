Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444C3C35E0E
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 21:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD3C20675
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 21:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQuToyQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgBYVGM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:06:12 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:45124 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgBYVGM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 16:06:12 -0500
Received: by mail-io1-f67.google.com with SMTP id w9so824013iob.12
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 13:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zKteOkIuul1j8vU0ryHqLFikrmECj7NkGgox7Xp8qa8=;
        b=FQuToyQSgg1d57WlGizyfdR3e//XoUmnrbahZXJvhEzvjZdFQ4YcrLUeX/DIcRw3lt
         n+h5QZP4i9iK4XlKO5TkEoaZtESoeglt6TnblNPQAfSYyza/4XNUVzKmdoe6AolCNhnO
         2CX5NdbLnItgcO5KjYcf0EbjsvE0n0j4esKON76CSrfKYJ2oZpyZo9EFxSpDNTp9d0Ql
         EcslSBs9MRj1UjIXgB8sIx5/NGf+lqsug6u/uRXgYodli5XVXB5QNPWffkWsOz2JEBti
         Y0G5hfrTsSewghf4OCA7r6MZAN4Nd41kpF6uswvtHe9Z39AQfYxhhFUUyNWqlhTWFmPu
         WSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKteOkIuul1j8vU0ryHqLFikrmECj7NkGgox7Xp8qa8=;
        b=BqWGvackV9jpCHUdgPc3eCIXn4bgjt2DYuRv8qS0uHNXIP5YMjSuJUXz8tk9h3pJpR
         fq3lcHGIaSVitiOW1Ac96QWytsoJkmfXjtQ57hXTaj5pCeCQPunh/399F3WX9gMbSWAO
         EwQp+fx3YkHgX9v5Pf1Qtd9DugzTuRFyRQoOF27G4l2L/6owuobyfCMSYEfJB0wxJrM4
         GLa1ZjQ6+hIBqaPstIaKp8XHz06SfulcZZ5SupX1qWammRVz28qklAYmCTlNvWOOJ+pi
         S7Gj+KIDpjKqH5oLJOTRfmksPf0bP0ZLwB9BcmM2LMCPTLqFH8Rr5FEPWSh5ybiU5R7L
         kr1A==
X-Gm-Message-State: APjAAAUmm91r+yEWCHMyWzIlRZxc4UxGeMKP15OgXNVec761BnrbhfRR
        NhY9XvXbcq5NRezcNB5h61ljSmGXdjiiqDhCXKo=
X-Google-Smtp-Source: APXvYqw0QqXKOVLXd3vrg0bW8fbNYFImNkjpuCIWwt1nj1TanwiqnL72JqlkzrTx17rerE+mMV/UTwAIAf/Kx36BsSk=
X-Received: by 2002:a05:6638:198:: with SMTP id a24mr557241jaq.27.1582664771545;
 Tue, 25 Feb 2020 13:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com> <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
In-Reply-To: <CAEjxPJ42+p_Ppo6SqJCu-em2HXv1hyaY6ziCb0TrqTMBLg_Gag@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 25 Feb 2020 15:06:01 -0600
Message-ID: <CAFftDdpG-t4Zo9Ro8xJyxkd6zQ8FoyaTqfQrvG8kcbtP94Xf1Q@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 25, 2020 at 2:49 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Feb 25, 2020 at 3:03 PM <bill.c.roberts@gmail.com> wrote:
> > The annoying part is internal users of the routines. We could always make
> > a v2 version of the function for internal callers, and leave the old
> > interfaces intact to work around the warnings, or just pragma them out.
> > This series pragma's them out.
> >
> > diagnostic push has been supported since GCC v4.6. Earlier versions will
> > warn on this, and the sideffect is that the diagnostic ignored pragma
> > will be valid for the rest of the file. Clang has similair support thats
> > been around *at least* since clang 6.0.
>
> My inclination (and others are free to disagree) would be to rename
> the deprecated functions for internal users (and mark them hidden),
> and add stubs for the old interfaces that call the hidden functions to
> avoid the need for this pragma.

I'm actually leaning that way myself after thinking about it more.

> Also, FWIW, there is a push to remove
> the hidden_def/hidden_proto stuff for LTO, see
> https://github.com/SELinuxProject/selinux/issues/204, although I don't
> yet know how that will turn out for libselinux.

Good to know.
