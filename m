Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED22C433E9
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 16:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFB623B1C
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 16:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbhANQvB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Jan 2021 11:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbhANQvB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Jan 2021 11:51:01 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4964C061757
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 08:50:20 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q1so12438609ion.8
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 08:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ec7HKWj/SmMARxzkN7aNzxr4dpqr4YIJtfYiX15Pvwg=;
        b=SvFoE7XEah6/yZeUszX7YwFNSuqE0PnU5Pqn2XM9U4c2AlCF3atquNOZusKD3rTvo6
         DcEkfq1ILIbke9pzoRYk0OQy2kJEjRz5DbFJkB+adBhiReUkU4oz1Jy/+Cx8Ycj6kFJu
         x4l1udyN5Wx1SoSxUVtEeSzk/ycYNrPeNeZQl0trne5KuUNcUgsHr5NykkosDMkURSX5
         scgOdcj3gv7fb4ROPgCW7cPrsJGWdd4EyJJvdVbSMumIFfQql1UUfhJqOwZZPDnKXN6t
         D1RauiC1YaMwpLr7+oDvJUwFIdJ6kBYhvR0JnPnz5AvrQa9BxLVrNuSZfHHjm0AMKN5v
         7Jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ec7HKWj/SmMARxzkN7aNzxr4dpqr4YIJtfYiX15Pvwg=;
        b=eOhlm8setHjiAjBoy66tY/wUn72fN1hVXC9Upf00WotDa9zx/XCV3wCvYy1yVz17p1
         pg14VLTNdofEd9A/GRIwy/472NDzcZiBAHKoMB3ZduQpPXpgTptVWD1TbJanBMCA1RxA
         /9x47dtz99RHlJwflESN1Is2q4ywQ927dDu4Odv00sQBhyW25Qi9CcvCwQCE1RHhIW1H
         HsbPD4SLDLvEnVbmyQBsENILfLcafPuucDtfmSnMDINcxs6gSxiKz6GINXCBDDsa+lvP
         t66oKNa/5Qq6QZ2jCKTS8toMzQ8sIbOOYpy+XJfw9VDmEibl+pkGEzdW79Lknz8+q1Ha
         RnAg==
X-Gm-Message-State: AOAM531jbCYTkC5wmWpFSc6+hcZJflxArzfMd7JlzBa6/QYAeeTSMZe7
        Z+CGLXyzjal+NAOEALOxz4K9Reb6LDv5fR3Dr7U=
X-Google-Smtp-Source: ABdhPJws9+vKmdlXM57+0BRs+LSNiNhQXXUHuePP3xthIpKBgLpNtmZK84Lq2jiLjr1GGaBLd6r1XvKX9gHC7hfckn4=
X-Received: by 2002:a92:bf06:: with SMTP id z6mr7380846ilh.174.1610643020128;
 Thu, 14 Jan 2021 08:50:20 -0800 (PST)
MIME-Version: 1.0
References: <20210114155920.293559-1-plautrba@redhat.com>
In-Reply-To: <20210114155920.293559-1-plautrba@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 14 Jan 2021 10:50:09 -0600
Message-ID: <CAFftDdp3tttJqaCeN9bZw0pV_-1mng-sq0GgAKp5auFFAJyeZw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: Always close status page fd
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 14, 2021 at 10:02 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> According to mmap(2) after the mmap() call has returned, the file
> descriptor, fd, can be closed immediately without invalidating the
> mapping.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>
> Changes against v1:
> - selinux_status_fd is completely droped as it's actually unused
>
>  libselinux/src/sestatus.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> index 9ff2785d876a..12b015e088ea 100644
> --- a/libselinux/src/sestatus.c
> +++ b/libselinux/src/sestatus.c
> @@ -37,7 +37,6 @@ struct selinux_status_t
>   * Valid Pointer : opened and mapped correctly
>   */
>  static struct selinux_status_t *selinux_status = NULL;
> -static int                     selinux_status_fd;
>  static uint32_t                        last_seqno;
>  static uint32_t                        last_policyload;
>
> @@ -298,11 +297,10 @@ int selinux_status_open(int fallback)
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
> @@ -336,7 +334,6 @@ error:
>
>                 /* mark as fallback mode */
>                 selinux_status = MAP_FAILED;
> -               selinux_status_fd = avc_netlink_acquire_fd();
>                 last_seqno = (uint32_t)(-1);
>
>                 if (avc_using_threads)
> @@ -388,7 +385,5 @@ void selinux_status_close(void)
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

ack and staged. I love a negative diffstat. Thanks Petr.
https://github.com/SELinuxProject/selinux/pull/279
