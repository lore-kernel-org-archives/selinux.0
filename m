Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1967C48BDF
	for <selinux@archiver.kernel.org>; Thu, 10 Jun 2021 23:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F16613E1
	for <selinux@archiver.kernel.org>; Thu, 10 Jun 2021 23:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFJXPg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Jun 2021 19:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFJXPg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Jun 2021 19:15:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9EFC061574
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 16:13:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ce15so1636168ejb.4
        for <selinux@vger.kernel.org>; Thu, 10 Jun 2021 16:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wq1V57QRB2EJu3YuApsOJs72DhMcHf+KyQ+W+Og+aM=;
        b=RdIdZp8EfKJJiOGA0GslcDOPC9NQyzGy3J39OA5B0L6PZpiMfFMvwGJ7f3NzwFz9KB
         jx1hVB23XDQlb0hXs+ep3ippJ9XyaTi40CnBC2fYK4h7EVNrYRyCg4tbpFuBsOij5zXj
         e9T+8ctzpf01+7GieaJc46VIjN5GbJURNjz48JzqDZvXnsS17zllFe3MnjLloOgi3tbX
         hshZgmOICeWGf/tEtHy9nBOcRWAuijJdqrtpwVoHVuRwskoDb4F4w8E6ka03ya9OsOx1
         ariGEp9k84lJIzuDmsotLta0DFwOCqbK6yx2GAMt1qFmASz4xuW+ysXtD9HXegMHuugr
         BS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wq1V57QRB2EJu3YuApsOJs72DhMcHf+KyQ+W+Og+aM=;
        b=mLESyOaLwfqkZQi5rGIeemesGQ74OCpJgnqW6E5BwdXaYPEFKBL7Xetcn1hEqHY05U
         c/KFL6xog497WIVJW2eQkMUIIFeQqM/rCi8jAUS8N2bxazGkNrBbRrkLDwGBjNQSnWu+
         PsasKT6CqZR+/IdpGfCAVMwutxq3KFbVfQg27/9yQp5zBD6DQyqRzTwehkDAVqgdz3Wn
         8KZkGGshysCXjBH+JSLFbNQ6wen7YQwBb/Uc+Ezc7QJlm3Mw1arJK+spAR1zG1C7v1w7
         Ovs9iinVD/XeGUQRlA9tEwPhrXonE12KBezKm4jo9EFOu7eT/1YbwtRJcxleIxSCktkk
         ZGpA==
X-Gm-Message-State: AOAM533Go/TCN2H5MAOYOVzbVG73NvKjFwmYWNkM86KDHfnXm54s9ql7
        pRkAkr27ax3pMMvcM8INTrrb0thoUU4dT1AcwDIiE/z5XQ==
X-Google-Smtp-Source: ABdhPJxG9+awrPvceSUEO3hN4rw0KjRho7Ah3g+sCSWUO29p/qTSBZiG5b4Vs6VCIUwR6GUuLfDgsj6Wx0aR/6yiVcI=
X-Received: by 2002:a17:906:2c54:: with SMTP id f20mr749072ejh.91.1623366806917;
 Thu, 10 Jun 2021 16:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210609163717.2719253-1-minchan@kernel.org> <20210610160650.d2112a9db8130224c597bfaf@linux-foundation.org>
In-Reply-To: <20210610160650.d2112a9db8130224c597bfaf@linux-foundation.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jun 2021 19:13:16 -0400
Message-ID: <CAHC9VhTYeOmJqoyEniXLGMv3cJGBW4_BLc3LhDLBDhQCKtfp7Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: use __GFP_NOWARN with GFP_NOWAIT
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 10, 2021 at 7:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed,  9 Jun 2021 09:37:17 -0700 Minchan Kim <minchan@kernel.org> wrote:
>
> > In the field, we have seen lots of allocation failure from the call path below.
> >
> > ...
> >
> > Based on [1], selinux is tolerate for failure of memory allocation.
> > Then, use __GFP_NOWARN together.
> >
>
> Thanks.  I trust that the selinux developers will process this patch.

That's the plan; this is in my review queue for this evening.

-- 
paul moore
www.paul-moore.com
