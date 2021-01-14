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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0CDC433E0
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 14:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCA152222D
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 14:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbhANObR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Jan 2021 09:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbhANObR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Jan 2021 09:31:17 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA39C061574
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 06:30:36 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y19so11543575iov.2
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 06:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hEo0mpkUgCR813m7VM7qg6MjGublCSWV6TuVJng6a7Q=;
        b=mZxM0apI9ZthHHZ3tvmSDUSluSGikqZkCrmgC7fx+DkGZSHSuHkWykX2xbIl243MtK
         y9AuUAxcOuWDMB11k+MTyDjbOSTH+A4uMaToPzP/Hc/vzcONOHpwjv5dD1HNnTpkHmIj
         ufzDIxRlhpqrFNALEN2KAr8SDCZqBo85HSSaZJn9Fyrtd8I+zmNznw+2hhlBfkGAOzfW
         vMVHmH0Q/bjCsWKaxFTdBRUGfnKWKWD9YjCtA6Sp34SwGWLlVfFQc3s8x0C/uXlzEAW3
         i7TmhW01c/IoiWQOVHwh2VFcO7hGqIfMsNp/x74zUuwCwbatPURzH9qIBfN2DX7NXbT+
         mF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hEo0mpkUgCR813m7VM7qg6MjGublCSWV6TuVJng6a7Q=;
        b=OtgACmSVb2HQgaRZ+vDsR8fLj0rXWGYLTlVBohqzw+o0TSpnokLiQi9Kza/Hxh5LAY
         MRwJXXrSv+vWc/HA4Wk6f7RShHiT97VmCBEvlGcqdWZjDR5tgrA4qF5O3uN61Ek+uNsO
         UGNrrWFM42qNG344HL6ekJ2DS1IU28HB/sdSCx/vV2knzjFrrvlURs9gTuU7xmDFpBY5
         Ea8c/pYbriFZupokvXeQWQ5EU6clokvmEdyd5+Z9VYRn8yc/TdELHrBE27lGBw4xqo+d
         HyQWyJiewB4yAeU5KQp7xwauLgrccZ6vfC41dkkGG2LWCCjFKGyiw2vKhgA+cEP5qlDU
         wvOQ==
X-Gm-Message-State: AOAM530pk+OH/1jDER9AdAYOZU31zVZhD21tV+2F2B45MityoTBnzUz7
        IVXWw+avcs0jD6wT3kMctjBDSDxGlndtY/c/auc=
X-Google-Smtp-Source: ABdhPJx/au453rNdwgmPJbKw7G3hJOmOGkJ3e2qLjxpRjwtIZHOiWEXkYhH7NZmsKAphZzQ0VFBBKOUqaI1OTFZBgxE=
X-Received: by 2002:a6b:d007:: with SMTP id x7mr5422793ioa.88.1610634636315;
 Thu, 14 Jan 2021 06:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20210114133910.282686-1-plautrba@redhat.com>
In-Reply-To: <20210114133910.282686-1-plautrba@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 14 Jan 2021 08:30:25 -0600
Message-ID: <CAFftDdoUFfoztETJmr2TpLOS-mndbmuvbwHLFjfzhArOT=4FEw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Always close status page fd
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 14, 2021 at 7:42 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> According to mmap(2) after the mmap() call has returned, the file
> descriptor, fd, can be closed immediately without invalidating the
> mapping.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libselinux/src/sestatus.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> index 9ff2785d876a..6a243b7bcdfb 100644
> --- a/libselinux/src/sestatus.c
> +++ b/libselinux/src/sestatus.c
> @@ -298,11 +298,10 @@ int selinux_status_open(int fallback)
>                 goto error;
>
>         selinux_status = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
> +       close(fd);
>         if (selinux_status == MAP_FAILED) {
> -               close(fd);
>                 goto error;
>         }
> -       selinux_status_fd = fd;
>         last_seqno = (uint32_t)(-1);
>
>         /* sequence must not be changed during references */
> @@ -379,6 +378,7 @@ void selinux_status_close(void)
>                 avc_netlink_release_fd();
>                 avc_netlink_close();
>                 selinux_status = NULL;
> +               close(selinux_status_fd);
>                 return;
>         }
>
> @@ -388,7 +388,5 @@ void selinux_status_close(void)
>                 munmap(selinux_status, pagesize);
>         selinux_status = NULL;
>
> -       close(selinux_status_fd);
> -       selinux_status_fd = -1;
>         last_seqno = (uint32_t)(-1);
>  }
> --
> 2.30.0
>

Nack, the fd in the mmap of the status page and the selinux_status_fd
(avc mount) are different fd's.
The selinux_status_fd is for the AVC netlink socket fallback. If you
drop those hunks I'd take the patch.
