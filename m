Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAFDC433DB
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 21:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E779364D99
	for <selinux@archiver.kernel.org>; Tue, 16 Feb 2021 21:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhBPVcE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 Feb 2021 16:32:04 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:58708 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhBPVcE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 Feb 2021 16:32:04 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id CECA9564C57
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 22:31:20 +0100 (CET)
Received: by mail-ot1-f47.google.com with SMTP id b8so5650780oti.7
        for <selinux@vger.kernel.org>; Tue, 16 Feb 2021 13:31:20 -0800 (PST)
X-Gm-Message-State: AOAM530n7Y6yJayAA7Gr8V4zDV0CQo7gYqRfy+3wd18rR6QaS6qICi/a
        W9NaRIppSc7fjaHTq4gWikS4pSK4PZa0uxe2NuI=
X-Google-Smtp-Source: ABdhPJy4vSO0d1CkkjejUM0hOZpLttcpGb2d/DONpXcJ6YAVLhxn/74qDxszSQEedJDhcGPKPRtvIlcBfe7/0sqKSAw=
X-Received: by 2002:a05:6830:115:: with SMTP id i21mr15803976otp.96.1613511079840;
 Tue, 16 Feb 2021 13:31:19 -0800 (PST)
MIME-Version: 1.0
References: <65111b4f-23b9-6758-9cd6-d2f8429916fb@gmail.com>
In-Reply-To: <65111b4f-23b9-6758-9cd6-d2f8429916fb@gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 16 Feb 2021 22:31:09 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=keAs69Az0O8jkdfkAPvAYjQ=pqzV=t+ktLQ2KqU3Y6jQ@mail.gmail.com>
Message-ID: <CAJfZ7=keAs69Az0O8jkdfkAPvAYjQ=pqzV=t+ktLQ2KqU3Y6jQ@mail.gmail.com>
Subject: Re: [PATCH] policycoretuils: sestatus belongs to bin not sbin
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Feb 16 22:31:21 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Feb 13, 2021 at 9:44 PM bauen1 <j2468h@googlemail.com> wrote:
>
> It is quite useful even to non-privileged users and doesn't require any
> privileges to work, except for maybe -v.
>
> Signed-off-by: Jonathan Hettwer <j2468h@gmail.com>

I agree with the reasoning, but changing the location of an existing
tool has the potential to break software which depends on the precise
location of sestatus (like
https://github.com/openstack/cookbook-openstack-dashboard/blob/86127240974041b456086b5fff6f8f525c9cf555/spec/spec_helper.rb#L82
and https://github.com/rapid7/metasploit-framework/blob/4a380771d3a18011af153e47e1d08a4a83feb452/lib/msf/core/post/linux/kernel.rb#L276
and https://github.com/RedHatInsights/insights-core/blob/6fd58aeab11232a62ea97ba576220abca808c660/insights/specs/default.py#L815
and ...).

On the other hand, if you have a clear use-case of non-privileged
users refusing to add /usr/sbin to their $PATH but willing to use
sestatus, and that supporting this use-case seems more important than
not breaking programs which rely on sestatus being in /usr/sbin, this
patch will be acceptable. Do you know of such a use-case?

(By the way, there is a misspelling in the patch subject: you wrote
"policycoretuils" instead of "policycoreutils")

Thanks,
Nicolas

> ---
>
>  Only tested by running `make DESTDIR="$PWD" install` and checking that
>  sestatus ends up at /usr/bin/sestatus
>
>  policycoreutils/sestatus/Makefile | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
> index 8c4f45f8..ac113814 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -1,7 +1,7 @@
>  # Installation directories.
>  LINGUAS ?= ru
>  PREFIX ?= /usr
> -SBINDIR ?= $(PREFIX)/sbin
> +BINDIR ?= $(PREFIX)/bin
>  MANDIR = $(PREFIX)/share/man
>  ETCDIR ?= /etc
>
> @@ -16,8 +16,8 @@ sestatus: sestatus.o
>  install: all
>         [ -d $(DESTDIR)$(MANDIR)/man8 ] || mkdir -p $(DESTDIR)$(MANDIR)/man8
>         [ -d $(DESTDIR)$(MANDIR)/man5 ] || mkdir -p $(DESTDIR)$(MANDIR)/man5
> -       -mkdir -p $(DESTDIR)$(SBINDIR)
> -       install -m 755 sestatus $(DESTDIR)$(SBINDIR)
> +       -mkdir -p $(DESTDIR)$(BINDIR)
> +       install -m 755 sestatus $(DESTDIR)$(BINDIR)
>         install -m 644 sestatus.8 $(DESTDIR)$(MANDIR)/man8
>         install -m 644 sestatus.conf.5 $(DESTDIR)$(MANDIR)/man5
>         for lang in $(LINGUAS) ; do \
> --
> 2.30.0
>

