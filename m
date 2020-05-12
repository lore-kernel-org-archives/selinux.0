Return-Path: <SRS0=HCsx=62=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CA5CA90AF
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E942920731
	for <selinux@archiver.kernel.org>; Tue, 12 May 2020 19:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgELTdC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 May 2020 15:33:02 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:55851 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELTdC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 May 2020 15:33:02 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 3B632565CAE
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 21:33:00 +0200 (CEST)
Received: by mail-oi1-f174.google.com with SMTP id 19so19277535oiy.8
        for <selinux@vger.kernel.org>; Tue, 12 May 2020 12:33:00 -0700 (PDT)
X-Gm-Message-State: AGi0PuZTxbqTAw0bxB+7Z5cMeAHE7YopDDw6ZDkXKySx75jC3/AfcqD5
        QQUS1+vo8N8sp0Z29KXE1FRatwIVu1YnADc+0uw=
X-Google-Smtp-Source: APiQypIw7An8QkwRm0ERxy0j+iTYKtkk6KQoSq5LOFdrYfohc+ASfaKj3tl/Cs1tQ3TFhZ+pzgtzcfveNEoerdmABxM=
X-Received: by 2002:a05:6808:3d5:: with SMTP id o21mr25724063oie.40.1589311979237;
 Tue, 12 May 2020 12:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200511120332.26029-1-plautrba@redhat.com>
In-Reply-To: <20200511120332.26029-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 12 May 2020 21:32:48 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==W7_7Z5WpZFwHFVj4T3KpHUMsk2eyKx9z7zuBjzE95LQ@mail.gmail.com>
Message-ID: <CAJfZ7==W7_7Z5WpZFwHFVj4T3KpHUMsk2eyKx9z7zuBjzE95LQ@mail.gmail.com>
Subject: Re: [PATCH] run-flake8: Filter out ./.git/ directory
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue May 12 21:33:00 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 11, 2020 at 2:03 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> When a branch has '.py' suffix git creates a file with the same suffix and this
> file is found by the `find . -name '*.py'` command. Such files from './git' need
> to be filtered out.
>
> Fixes:
>
>     $ PATH="$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8
>     Analyzing 189 Python scripts
>     ./.git/logs/refs/heads/semanage-test.py:1:42: E999 SyntaxError: invalid syntax
>     ./.git/refs/heads/semanage-test.py:1:4: E999 SyntaxError: invalid syntax
>     The command "PATH="$VIRTUAL_ENV/bin:$PATH" ./scripts/run-flake8" exited with 1.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas

> ---
>  scripts/run-flake8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/run-flake8 b/scripts/run-flake8
> index 24b1202fde99..67cccfe99e5f 100755
> --- a/scripts/run-flake8
> +++ b/scripts/run-flake8
> @@ -7,7 +7,7 @@ if [ $# -eq 0 ] ; then
>
>      # Run on both files ending with .py and Python files without extension
>      # shellcheck disable=SC2046
> -    set -- $( (find . -name '*.py' ; grep --exclude-dir=.git -l -e '^#!\s*/usr/bin/python' -e '^#!/usr/bin/env python' -r .) | sort -u )
> +    set -- $( (find . -name '*.py' ; grep -l -e '^#!\s*/usr/bin/python' -e '^#!/usr/bin/env python' -r .) | grep -v '^\./\.git/' | sort -u )
>      echo "Analyzing $# Python scripts"
>  fi
>
> --
> 2.26.2
>

