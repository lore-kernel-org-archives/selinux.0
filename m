Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDB1C43381
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 21:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C8E64DDD
	for <selinux@archiver.kernel.org>; Mon,  1 Feb 2021 21:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhBAV4U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Feb 2021 16:56:20 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:44112 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhBAV4P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Feb 2021 16:56:15 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8220E564C47
        for <selinux@vger.kernel.org>; Mon,  1 Feb 2021 22:55:30 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id h14so17902792otr.4
        for <selinux@vger.kernel.org>; Mon, 01 Feb 2021 13:55:30 -0800 (PST)
X-Gm-Message-State: AOAM530S6hM2eSEXgMN5/rY9Jv9M9C9sW0DY0ClgEoM+G0MHBhyoXC1x
        iiTfF0680kd5HxihkzK1CtMFtyxMdlSFFeAl8Yo=
X-Google-Smtp-Source: ABdhPJwbunMLMFYTrO5okap3lX7YJbB41uedd9FOezp17+6MSYVoEVcsMatqQ6GoxZUmo9ym4zRMPcxi9c8IjBut5Jw=
X-Received: by 2002:a9d:6c9a:: with SMTP id c26mr12936332otr.96.1612216529402;
 Mon, 01 Feb 2021 13:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20210201143206.389547-1-plautrba@redhat.com>
In-Reply-To: <20210201143206.389547-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 1 Feb 2021 22:55:18 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==LVUDB7pF2vjr-tRks3svUt-kyy8-N-rVHYjur3HSZNQ@mail.gmail.com>
Message-ID: <CAJfZ7==LVUDB7pF2vjr-tRks3svUt-kyy8-N-rVHYjur3HSZNQ@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/setfiles: Drop unused nerr variable
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Feb  1 22:55:31 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 1, 2021 at 3:32 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Suggested-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks!
Nicolas
> ---
>  policycoreutils/setfiles/setfiles.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
> index 92616571ef2a..f018d161aa9e 100644
> --- a/policycoreutils/setfiles/setfiles.c
> +++ b/policycoreutils/setfiles/setfiles.c
> @@ -19,7 +19,6 @@ static int warn_no_match;
>  static int null_terminated;
>  static int request_digest;
>  static struct restore_opts r_opts;
> -static int nerr;
>
>  #define STAT_BLOCK_SIZE 1
>
> @@ -161,7 +160,6 @@ int main(int argc, char **argv)
>         warn_no_match = 0;
>         request_digest = 0;
>         policyfile = NULL;
> -       nerr = 0;
>
>         r_opts.abort_on_error = 0;
>         r_opts.progname = strdup(argv[0]);
> @@ -427,9 +425,6 @@ int main(int argc, char **argv)
>         r_opts.selabel_opt_digest = (request_digest ? (char *)1 : NULL);
>         r_opts.selabel_opt_path = altpath;
>
> -       if (nerr)
> -               exit(-1);
> -
>         restore_init(&r_opts);
>
>         if (use_input_file) {
> --
> 2.30.0
>

