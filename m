Return-Path: <SRS0=kXWH=DX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441A4C433DF
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 22:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E182222201
	for <selinux@archiver.kernel.org>; Fri, 16 Oct 2020 22:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="gDr+7mQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404942AbgJPW4l (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404897AbgJPW4j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Oct 2020 18:56:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1C3C061755
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2020 15:56:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id t25so5506285ejd.13
        for <selinux@vger.kernel.org>; Fri, 16 Oct 2020 15:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ss6mFgtEpU0AhTcZztIBRvWhwuhHN1NtCL9CmWhE50Y=;
        b=gDr+7mQGIy7C/mcWSpO1Ds7hqnk+RwsCQfOgqJ8a3GxW0m3l2QpA75nSZX+ZmFFvQK
         NSm4GgphoJzRQw5ETLubTiy6piqbzluJNrrKWLgvOsOh4FpvUH9+eB5H6EeR4XxH7g4I
         CEgaL7YNajjuY8fPCek5NW1EOrCFkZqwm8kqVXe6BxY7K9IAm4piHFzYPYFIoVudtSTj
         1zEXcDvgnpDDCyMHk2uh/n0g90jubnJtF5FnALFPYv1dsROZJ0TWifRHdXz044U9AwLw
         fQZZ/NMbDjylzVc1Vgt0LtBJsdD+1iv9WhuIjTipSmbosqnA53Mwc1ElxBPx9bNNDY0Q
         83fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ss6mFgtEpU0AhTcZztIBRvWhwuhHN1NtCL9CmWhE50Y=;
        b=HEDmb+H8RXjtkCrMWpoUZUibIDtu/KB/1K3uSen1SVnlvTjjZ1wewUNYzk8SYK80d6
         we0P3hU5Kuq+gG8fvxkjAbur6nMFXgxCHFkDi/xrF62MdW1Tu42/v5mryg4PPIiMcGbE
         DjSw0AbkaoR/l8L5gLOjOtnpGbM83cLXUysSEedcl8f1SHC1UErxhAOkwQZO7uDZju1o
         tyKanUbBNW8550nIaNSrHhH5ZSSBNRQE+h2TB3vvKz1tpdfbEMBkciHUbCe9RZ3+XpKm
         gWoASXezApYO2o2QQBkcGzA4/x4tEbSm11Dz0LexlTm5jfFurlHSr0ZNx7E0/ODZePjF
         a0fQ==
X-Gm-Message-State: AOAM5308drhPzjSb5bKLG/H7kcE7FTIxiAw8/+CdY4WbhifJylrbfi7a
        JhoX+uuolZuQlI5+MaiXhtuHapd1MtKZlmRM7z/f
X-Google-Smtp-Source: ABdhPJw7VNrFY+KfljUWJuzCoCaJpX89d/T3m9HX72+JRC4zE82LiA4Lm5KqK9MnjnqiTynfmXOzjdqrrb5E2bFYiFU=
X-Received: by 2002:a17:906:b091:: with SMTP id x17mr6048395ejy.178.1602888997914;
 Fri, 16 Oct 2020 15:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201016134835.1886478-1-dburgener@linux.microsoft.com>
 <20201016150120.GB1807231@kroah.com> <20201016153823.GA2415204@sasha-vm>
 <20201016154443.GA1818291@kroah.com> <20201016154936.GB2415204@sasha-vm> <213527b2-87ce-01bf-0699-b82fa65dc91e@linux.microsoft.com>
In-Reply-To: <213527b2-87ce-01bf-0699-b82fa65dc91e@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 16 Oct 2020 18:56:26 -0400
Message-ID: <CAHC9VhTStpufqyGzPTDHJoQ+CFf+aTFM9+N6QhdkwkmqrD1wgA@mail.gmail.com>
Subject: Re: [PATCH v5.4 v2 0/4] Update SELinuxfs out of tree and then swapover
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 16, 2020 at 12:01 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
> On 10/16/20 11:49 AM, Sasha Levin wrote:
> > On Fri, Oct 16, 2020 at 05:44:43PM +0200, Greg KH wrote:
> >> On Fri, Oct 16, 2020 at 11:38:23AM -0400, Sasha Levin wrote:
> >>> On Fri, Oct 16, 2020 at 05:01:20PM +0200, Greg KH wrote:
> >>> > On Fri, Oct 16, 2020 at 09:48:31AM -0400, Daniel Burgener wrote:
> >>> > > v2: Include all commits from original series, and include commit
> >>> ids
> >>> > >
> >>> > > This is a backport for stable of my series to fix a race
> >>> condition in
> >>> > > selinuxfs during policy load:
> >>> >
> >>> > Has this race condition always been present, or is this a regression
> >>> > that is being fixed from previously working kernels?
> >>>
> >>> So this issue has always been there, but:
> >>>
> >>> > If it's always been present, why not just use 5.9 to solve it?
> >>>
> >>> Because it was merged for 5.10 rather than 5.9, which is a few months
> >>> out, so Daniel is looking to see if we can have it in 5.8/5.4 to close
> >>> the gap.
> >>
> >> I would have to wait for 5.10-rc1 at the earliest, and get the selinux
> >> maintainers ack for this :)
> >
> > No objections; if the selinux folks feel unhappy with this it'll just
> > wait for 5.10.
> >
> Yes, that's fine from my end as well.  We can carry this series out of
> tree in the interim.  Thanks!

I tend to be pretty conservative when it comes to backporting patches
to -stable, and since this is both a) big and b) fixes a problem that
has existed since the dawn of selinuxfs (and possibly longer <g>) I
think the smart thing to do is to wait for v5.10.

-- 
paul moore
www.paul-moore.com
