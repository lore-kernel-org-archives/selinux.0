Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE03C63777
	for <selinux@archiver.kernel.org>; Wed, 25 Nov 2020 04:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16320206CA
	for <selinux@archiver.kernel.org>; Wed, 25 Nov 2020 04:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iCGbkB62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgKYEdj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Nov 2020 23:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgKYEdj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Nov 2020 23:33:39 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7316C0613D4
        for <selinux@vger.kernel.org>; Tue, 24 Nov 2020 20:33:38 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id d18so1117996edt.7
        for <selinux@vger.kernel.org>; Tue, 24 Nov 2020 20:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dO5I8El0Vc8nwpAQix4fNsW3d6joKtUwmgssAfQYSo=;
        b=iCGbkB62nsmiauD4HyMG+F/+S5JVt6SJ0HoeXHFyIswwhlQRiFT2r1AmUF8hGJGKXC
         ARAcwMlgs7TPar2He+Ce56a4f8LT/z/0lETuFtF7m6mPHzM66pgstmtrmZslLfwVkm4o
         TVi4Qc3UjxKwfFoV5TXvrqqzq+pc6AOWffEZKw0MI5gd5HN/hFQh31gJbxUZmK+FZmY8
         Wx4a/Ch31lEINiheJ7Hqq8UWSzAtIju/h7yvbs2S2Wj4fRlkTbxgLAXoMULk5sZIomyK
         DBDGlCNDvS7L0rC4chFI8zD+H2sOk4UQghKz8yJ50Pdy65YR46P+Srxny4YU1YhEv7EJ
         ySdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dO5I8El0Vc8nwpAQix4fNsW3d6joKtUwmgssAfQYSo=;
        b=CGgLQvsEc1cwW7QH4pybs4Ob4gXW2gtm0kEy/AsBH5kd5pr63s2dfsnl7RDsZxmVLj
         uq2jZ681wAVA3L6xZHoQoK30hrvhxSb8ZR3oP///HidvEAXbCC7jNC7u1kh61clMCi71
         Jc7HD5+mI5X7s5/S5a2E/yc9iskVyCI4ADJdFMJAgHsvIiebWb7sDPQtVnKps0cmM0Gy
         SX3ArbiZPuHkGRhKju1qi1M6fHswIz8Qg0x345NSV5DcK7O85Fmu35M22bDZxgL1rLly
         H9F5Kd3EgD7rql3MpCzg+7PXsbE/Fm2WsrbbAooGAl+T6YVVnCjDh6B2KHwRtz31x+pT
         eGDg==
X-Gm-Message-State: AOAM533vDemzAS9oHOuVg1SfY4J1qvkGc5Y85ItETD0FrP/+K/NKsqbn
        vWti0ljIrQMgUwozzPzqDFQAT4qz4NTkcod6NlgxhbH7XqJqJpI=
X-Google-Smtp-Source: ABdhPJyzBsrexvL3weL+QNv6ZWOp0BX+8YK+rUZfJj8QKErOqk3GPOYiO5tPhst7GrlI3yK2JBnBte3VC5qL4yiJXu0=
X-Received: by 2002:a05:6402:10ce:: with SMTP id p14mr1745336edu.12.1606278817473;
 Tue, 24 Nov 2020 20:33:37 -0800 (PST)
MIME-Version: 1.0
References: <20201120113807.11605-1-richard_c_haines@btinternet.com>
 <CAHC9VhTzkCiaRXXO9ZwPNyG59c-uJx=jW5qYPqwfv9jeVPxcGQ@mail.gmail.com> <71112670492a57f244225d200c121f25e267fa44.camel@btinternet.com>
In-Reply-To: <71112670492a57f244225d200c121f25e267fa44.camel@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Nov 2020 23:33:26 -0500
Message-ID: <CAHC9VhRoHbRNWTW-y9xrUcrgMH1YDPR9V5RgC6q_sc34m0As+g@mail.gmail.com>
Subject: Re: [PATCH] mls_mcs.md: Convert section to markdown
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 24, 2020 at 7:26 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Mon, 2020-11-23 at 18:06 -0500, Paul Moore wrote:
> > On Fri, Nov 20, 2020 at 6:38 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > >
> > > Add a TOC to aid navigation and converted to markdown.
> > >
> > > Reworked a table that required rewording some text.
> > >
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > > ---
> > > RFC Change: Updated MLS/MCS text to reflect [1] comments.
> > >
> > > All Notebook sections should now be in markdown.
> > >
> > > [1]
> > > https://lore.kernel.org/selinux/80e38828-1473-5bc5-1b23-067cd242125a@gmail.com/
> > >
> > >  src/mls_mcs.md | 411 ++++++++++++++++++++++++---------------------
> > > ----
> > >  1 file changed, 204 insertions(+), 207 deletions(-)
> >
> > Merged, thanks Richard.
> >
> > There are a few other small outstanding patches that I'm going to
> > look
> > at now, but what does everyone think: time for a new GH release of
> > the
> > notebook?
> >
>
> Seems reasonable now all in markdown. I did notice a couple of HTML
> <br's in title.md and the notebook-examples README.md files. Not sure
> if worth removing ??.

Let me take a look at those, perhaps I can clean those up without too
much problem ...

-- 
paul moore
www.paul-moore.com
