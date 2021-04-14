Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B83AC433B4
	for <selinux@archiver.kernel.org>; Wed, 14 Apr 2021 19:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A4A610FC
	for <selinux@archiver.kernel.org>; Wed, 14 Apr 2021 19:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353126AbhDNTTL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Apr 2021 15:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbhDNTTJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Apr 2021 15:19:09 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14B3C061574
        for <selinux@vger.kernel.org>; Wed, 14 Apr 2021 12:18:46 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id k25so21743703oic.4
        for <selinux@vger.kernel.org>; Wed, 14 Apr 2021 12:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIJfNBD0BVbMuNQNEwnDEDrvwO7pOazFHcCnSXJOTMY=;
        b=el9U83kytBg7F0qWNlnB9kN/4QhE1NTkV9pJxH3CjPx50Cr3Q4lZQSPSw/f7LIhUYJ
         PJVTN9xl4wfeUkFtWHSXy7LB+0QN5DGFUZSJffE3/zdoaV+zt1lKXbkeChEK5yKqc3uA
         AXkCp6amRWyAkQaBLKcbShbSiWO3JdwPKgwUiMSfZzmtnMLA//KUOVU5AlUpUk/gZ0JT
         zKZ7L6ebKK63T3LJag3rMwjw1G67+H2p8+5g0XwiGIayN8MJFiDWDFj2cKrbssv87/xO
         bMyQzlbnRMwLrwt+MsDm/Tl5BlAJG9L/nEa5b+sPSkwydZi7jmXW+2M5wIUI4EMEfqDf
         70Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIJfNBD0BVbMuNQNEwnDEDrvwO7pOazFHcCnSXJOTMY=;
        b=tSps0/BEHRwecQsXB8xe+O6KJHp0rTMzR2EKuISV4Ve4XPg9g1GRcVa74Wssk7EZcj
         a3r+zkMoM8rSrBVfq/0tledqE0Gerr2lz30CZ2bhc9Mj7WHbQwAha1fSP1/D6ITtYf8s
         NVgGXhMcAdC+V2N+464BG9p210WAVk7fg60cAbYeWvJRmbCTZVg8ybzTtW0GtnGvUoxj
         5ehMCmv9WvUyZPVg40nrbaLSW5qO8ckLzXBfOSQvITmO6sZxYu6/FklFogIbId4aGE3h
         +V5JxCteROzyydPErf9GORircXOSxKNLf2v92xqykYpy4iE97Ebg6r/NnbOIZXLFaphd
         P9Fw==
X-Gm-Message-State: AOAM532zbv6NoIE7x5nX+Un/mWCcSyxoSPpt3KqDFgCieKg/8xLtgkqC
        Fd9tQI7lQH0599p07Q7Zw8wWk+yqldC/RFZmpKM=
X-Google-Smtp-Source: ABdhPJwc87SJCK6kEWSMq9haCP1E7tFguaFa2RTcmn/dBsrYcCggJJTeUJR4DxWuMOz/zz4SYdwqNT6ZJcN+ISjWEgQ=
X-Received: by 2002:a05:6808:1482:: with SMTP id e2mr3543984oiw.138.1618427926421;
 Wed, 14 Apr 2021 12:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210414141027.3494107-1-yochiang@google.com>
In-Reply-To: <20210414141027.3494107-1-yochiang@google.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 14 Apr 2021 15:18:35 -0400
Message-ID: <CAP+JOzSCEfgouyWfjkZjPwrEZM0SSKqGH2QJdirp8zkHPyXBfg@mail.gmail.com>
Subject: Re: [PATCH] secilc.c: Don't fail if input file is empty
To:     Yi-Yo Chiang <yochiang@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 14, 2021 at 12:32 PM Yi-Yo Chiang <yochiang@google.com> wrote:
>
> fread(3) returns zero if |size| is zero. This confuses secilc, and
> causes it to fail with a "Failure reading file" error, even though there
> is no error.
>
> Add a shortcut that closes and skips an input file if file size is zero.
>
> Signed-off-by: Yi-Yo Chiang <yochiang@google.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  secilc/secilc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/secilc/secilc.c b/secilc/secilc.c
> index 186c5a73..9c78e425 100644
> --- a/secilc/secilc.c
> +++ b/secilc/secilc.c
> @@ -268,6 +268,12 @@ int main(int argc, char *argv[])
>                 }
>                 file_size = filedata.st_size;
>
> +               if (!file_size) {
> +                       fclose(file);
> +                       file = NULL;
> +                       continue;
> +               }
> +
>                 buffer = malloc(file_size);
>                 rc = fread(buffer, file_size, 1, file);
>                 if (rc != 1) {
> --
> 2.31.1.295.g9ea45b61b8-goog
>
