Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47273C4338F
	for <selinux@archiver.kernel.org>; Mon, 23 Aug 2021 14:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D4C4613B1
	for <selinux@archiver.kernel.org>; Mon, 23 Aug 2021 14:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhHWObz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 23 Aug 2021 10:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhHWOby (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 23 Aug 2021 10:31:54 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B697CC06175F
        for <selinux@vger.kernel.org>; Mon, 23 Aug 2021 07:31:08 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so36779404otf.6
        for <selinux@vger.kernel.org>; Mon, 23 Aug 2021 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VTkUZMi1onEy7NznST49F9aJesHO8GSL5MewpW7fyVA=;
        b=XyKS2yOUTp7wZ79b4a0utb+fbv+TfRV/eF6u5mAveLL7hynqf0m5KclTy/IcybRlOf
         XbpGwRf3bcspBUKQ2vaYtJ/6V0cunxjY7Xcw/SMabenSGd6MniqSmOc3bDfnR+zeFxTh
         rpw8Ah60S2Dqs5UwR1792Gb7vlbAku3lDYojsk0BtMuokKsVci6gGwqPqYYcagN6Ztn/
         3Kbwr1EBtCVlfUDpmDhFTLJyv4jp8Q1OXfJjiLWftJgdow1saHw0XPUXoDDP8DBiM6Bl
         QRihEErUgwerlVyL6ypRtsDg/vCMvK3Zr7Lwam6IxsbCcgItp0RfTMf3yj29Uyy4gtqR
         j7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VTkUZMi1onEy7NznST49F9aJesHO8GSL5MewpW7fyVA=;
        b=KiHf65PBJgYjV/g5gJfQ69xdCd98TlWk/DnOuz1u8aLQxsqI9fp3Z/vY2E8GzmtMZh
         cPT/3G5OaZ5us+8dHwe+2my/cd3axzdnL0+jbxddIRNiCXHLF1rrHKIVxVpRY8QVasYq
         N3QfF8A6t+HifFQRVKPoMdksc6Bsy1H79wO1x8D2pwBeG/i47BAOx5iAwgiqeC6WcuU4
         Q/8jw7mtM6BsTPch/7S3i/Z6PeYFknTMMA7YFqPD/7CXu1O4tCkLpy75aZvBCnJN0TVN
         9DGhn0I3zp8Jgh9UmkS5Wd+aS0EwJ7I4ViJiy5JT52U5hbpbJbxz6ZkUHdEtWdOYKU19
         JDfw==
X-Gm-Message-State: AOAM533hM1cOx335JRapsixGLXJ5zY9EEZ0cR/mOW+RvPAqjgfdzd1ND
        pv7Y7VLwrGSwHzWlgf6AFFNeZ5oKcd6qtIR2xZ0=
X-Google-Smtp-Source: ABdhPJyiLY/P+69QUNKkmJzYEX5XW3eGBw7H/TbSSPhNbWS8ahISIEftVF+g/MPJtWJrY1UJ/gm44va8Q4ZkfnUc6Ng=
X-Received: by 2002:aca:1815:: with SMTP id h21mr11980614oih.128.1629729068129;
 Mon, 23 Aug 2021 07:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210816165459.1741490-1-zhangkelvin@google.com> <CAP+JOzQ0y=vSvgeRzAfUU4dY=5dGrCudBmV08tfGzu29+HDiyA@mail.gmail.com>
In-Reply-To: <CAP+JOzQ0y=vSvgeRzAfUU4dY=5dGrCudBmV08tfGzu29+HDiyA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 23 Aug 2021 10:30:57 -0400
Message-ID: <CAP+JOzRDefrV8=-cksQbWA8-zy93u7hrTe5==bAqCeKrejtp+Q@mail.gmail.com>
Subject: Re: [PATCH] Improve error message for label file validation
To:     Kelvin Zhang <zhangkelvin@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Kelvin Zhang <zhangxp1998@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 19, 2021 at 3:22 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Aug 16, 2021 at 12:55 PM Kelvin Zhang <zhangkelvin@google.com> wrote:
> >
> > From: Kelvin Zhang <zhangxp1998@gmail.com>
> >
> > Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
>
> This is not what I normally work on, but it looks fine to me.
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/label_file.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 56f499fa..2e28d047 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -188,6 +188,9 @@ static int load_mmap(FILE *fp, size_t len, struct selabel_handle *rec,
> >
> >                 str_buf[entry_len] = '\0';
> >                 if ((strcmp(str_buf, reg_version) != 0)) {
> > +                       COMPAT_LOG(SELINUX_ERROR,
> > +                               "Regex version mismatch, expected: %s actual: %s\n",
> > +                               reg_version, str_buf);
> >                         free(str_buf);
> >                         return -1;
> >                 }
> > --
> > 2.33.0.rc1.237.g0d66db33f3-goog
> >
