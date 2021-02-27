Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0446FC433E0
	for <selinux@archiver.kernel.org>; Sat, 27 Feb 2021 20:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF3FB64DBA
	for <selinux@archiver.kernel.org>; Sat, 27 Feb 2021 20:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhB0Un5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 27 Feb 2021 15:43:57 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:45230 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbhB0Unz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 27 Feb 2021 15:43:55 -0500
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3BA27561210
        for <selinux@vger.kernel.org>; Sat, 27 Feb 2021 21:43:11 +0100 (CET)
Received: by mail-il1-f177.google.com with SMTP id e7so11211124ile.7
        for <selinux@vger.kernel.org>; Sat, 27 Feb 2021 12:43:11 -0800 (PST)
X-Gm-Message-State: AOAM530G8KndM+eEi3znYe8VUoRJc/vHyHNsDXbhYmp+xqdMn2+kt+Wu
        bPI2nypoMt2ZYlpDShVgqoX3h6HvDOVk+X99grc=
X-Google-Smtp-Source: ABdhPJyZdtpDgsbKbW6iKpc3VWmUESMrLGMqO73B5fSQOTdO2gkIHwy98UP5Hxa1w1CtqsYdZYpkn+gMzGwUw+FrGWA=
X-Received: by 2002:a6b:b509:: with SMTP id e9mr114154iof.132.1614458234173;
 Sat, 27 Feb 2021 12:37:14 -0800 (PST)
MIME-Version: 1.0
References: <87mtvt1c40.fsf@redhat.com> <CAP+JOzRaTYQy35v-eZgNkvrce5B0kPW2DCCdzTBEh+VnuYXUyA@mail.gmail.com>
In-Reply-To: <CAP+JOzRaTYQy35v-eZgNkvrce5B0kPW2DCCdzTBEh+VnuYXUyA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 27 Feb 2021 21:36:55 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==kALQW82jz+T5dVohsTFt315m9-X_JDwwEY6Tb6tTpJQ@mail.gmail.com>
Message-ID: <CAJfZ7==kALQW82jz+T5dVohsTFt315m9-X_JDwwEY6Tb6tTpJQ@mail.gmail.com>
Subject: Re: Rename 'master' branch to 'main'
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Feb 27 21:43:11 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Feb 24, 2021 at 9:29 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Feb 24, 2021 at 2:49 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > Hello,
> >
> > would there be any objection if 'master' was renamed to 'main' after 3.2
> > release?
> >
> >
>
> I have no objection.
> Jim

Me neither, I do not have any objection.

Nicolas

