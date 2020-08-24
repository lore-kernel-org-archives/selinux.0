Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B02C433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032E0206B5
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XjS9K968"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgHXNZk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgHXNZj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:25:39 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E845C061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:25:39 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ba10so8025976edb.3
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTOWW6JncnibctwT53dKRLwS/NS8ZdF84sFxZqhk1R4=;
        b=XjS9K9686C8JrRj6HZFAkLZmggHinPNe9Lk5juw8Fiidal8RMlhanxpM1H3TchGLaa
         oIEbmpjID67OjS5NbBl7cl3jYVR94OofPvq3UbMP0RgYwYzeYDlrr2KOi7uj+RhdEUqH
         l//xlmEgVnrkNTT5Y1tGVylkL0wEFtLafbB2NtJF/y5vgmbRgx2NSQDxja1RQe0P1HyR
         vtKY+gJfQIdziLjafRl+6eSbnLwemgslr0Y149Hj1oZe+l4vlykuHIN7KgaYCuOfuK6b
         NNESOMk3tnSTuRxDaUCe7WC4fnSoYWrv8op1A/dnoeXa1EGghwy4cA6geBKShuTU4//o
         nFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTOWW6JncnibctwT53dKRLwS/NS8ZdF84sFxZqhk1R4=;
        b=PP5skuWAicOWQV+xbUzem5ZwdNtvV36EOekHinKgHlL6a4sE/rhjeqy1uz4PIRb3Ag
         dxEBZgcdWqNjriltNSTF/fyTl1yZkOU3sGXdlqXfhHmJJu5jV/8GaPJ5lJGfjO/4uMTX
         ym0S7WS8FIW9zVYEgrjZ60hDa9iCGwPp1t+/6/Ggh2LNTsbTYGs85AncKVHOFR/For6R
         XQY5iHx4Y6hfoqjuBAg2eUnKZow/xs37iMl2XwF8AKFWLof3SY0emeF3HOUPy/bQ5/io
         +2nR3IdqmqWjRga32ktJOqccBMahGXlUUp857TaB0aerO12L4uDNu0ykFa3DitW8UrO7
         iXHQ==
X-Gm-Message-State: AOAM5309/8knS7Z0Rg0Onn0ZXZ9Smgbfa3TTz0rX09sORqThbZjXHDVZ
        0L6ze1Lay+3nvsDEods9mDKdIdJjF/iKH7gg0e/l
X-Google-Smtp-Source: ABdhPJzh9hm6tBdDRner1srvF9xZaPeA9gBXSm9ZinWX/7U7gycvxVWH+aB4gzhWkyHqITTVHARjWzkYdQAqdATJXns=
X-Received: by 2002:a05:6402:3070:: with SMTP id bs16mr5260792edb.269.1598275538093;
 Mon, 24 Aug 2020 06:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200809162108.193636-1-richard_c_haines@btinternet.com>
In-Reply-To: <20200809162108.193636-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Aug 2020 09:25:27 -0400
Message-ID: <CAHC9VhQntv93nnDD17u2oQ2CRd9MEhR3LVDOnv5DzYShS=VJSQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-notebook: policy_config_files.md convert to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Aug 9, 2020 at 12:21 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Add a TOC to aid navigation and convert HTML tables to markdown
> unordered lists.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/policy_config_files.md | 477 ++++++++++++++++++-------------------
>  1 file changed, 233 insertions(+), 244 deletions(-)

Also merged, thanks Richard.

-- 
paul moore
www.paul-moore.com
