Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AF9C33CB6
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 21:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8334520748
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 21:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="w+Qy4tZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgAPV5w (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:57:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33654 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388152AbgAPV5w (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 16:57:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so24336937lji.0
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 13:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sn6M+YuAI/UkM2OnYPWKAnTqmmc4hWrVlWfmNjsri9g=;
        b=w+Qy4tZLTPXRnR6pR/XABOHDxixlga84Ri2SWd4uMUcvViM/GQuv7jLM1Lt2pY8wWB
         X+XRVy8dJE3WQ1Hjw/x0j4P4X4Jf194tyW1ydyyvzLmT8Yvy1Xt89nE+Sb+m+baSbc7P
         BJs6RXmFohQ5ICC/mvfwW8Zhs6n/i/ENd5xc01v0ROjdBpe/7ms4C9Vx8zFOQezVDihP
         VX38VZSwrUvWmw5FfjoWBHumdqe13JNmIQ2g9Str2xlI1blU4F0Fq8SteNqHnWwVgtf7
         OnQIURAh4cIazUqiHHBBSu+GmX49EJJHMUKM2NPhhwBQEeG/A976fif7+ZHqHVw/KtYM
         gPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sn6M+YuAI/UkM2OnYPWKAnTqmmc4hWrVlWfmNjsri9g=;
        b=kAgdi2RVvnr9r8dn73ECs1vQgtDUdZ6R3bQd3PI+XteOOoefXsl5gmhe+nvYi81k1e
         29UZMEkoO4JjeY4rZaZV8UDZ0uxeUD7uSeqn8f/ljyHsGbklvf+PpU9STwHV/Fy3vrxZ
         0+wzABQSJE4bKgN4oC+csooikbcyCYOGTBujL1Rcbx8TaEYtriiD/VHjuKz8ex0jCSUh
         UNNzwXB/O5vSVP94cUSljzo1C6f3pSh1piJX5wC7Sj4V28MHCn3gQznzp8OzZsObe3Fk
         bwmNC5F4RcembPcxo7pq6VB1xJrFXQjfdlCn52wilv+B0XzSC3YkA4dioQk9x62O+JBH
         QK5Q==
X-Gm-Message-State: APjAAAXoC5xOnI0NAb/L6IuZ0pfVC6VfQqqhzAk16xC4xyAF5Ng3gB0R
        4Qi+BAlgvv8CMMJ26vaW8ORSQJBJlDFw8yLOXC2n
X-Google-Smtp-Source: APXvYqwc8lSuKxyzqVf6MtAE7ds4Xt4IZwmUSUxrGgJ86Qpgd2+w7C73HVZy419UIXAHSjfKhEiahfuPEejKmbZx/GY=
X-Received: by 2002:a2e:5357:: with SMTP id t23mr3686682ljd.227.1579211869744;
 Thu, 16 Jan 2020 13:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20200116120439.303034-1-omosnace@redhat.com> <20200116120439.303034-2-omosnace@redhat.com>
 <e2af6353-25a0-30ea-8d81-30ec0d67e7d2@tycho.nsa.gov> <CAFqZXNuNP8=Q_oeqwU6B=tO-F6FNCJt+-5FaAki0kcx4o+p+xA@mail.gmail.com>
In-Reply-To: <CAFqZXNuNP8=Q_oeqwU6B=tO-F6FNCJt+-5FaAki0kcx4o+p+xA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jan 2020 16:57:39 -0500
Message-ID: <CAHC9VhR8ii39jkVGfJJBxDu1R-Bb9WCS6NNhWawXnKrX8mpJGA@mail.gmail.com>
Subject: Re: [PATCH 1/6] selinux: do not allocate ancillary buffer on first load
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 16, 2020 at 11:18 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Jan 16, 2020 at 5:02 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 1/16/20 7:04 AM, Ondrej Mosnacek wrote:
> > > In security_load_policy(), we can defer allocating the newpolicydb
> > > ancillary array to after checking state->initialized, thereby avoiding
> > > the pointless allocation when loading policy the first time.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > What are these relative to, because they don't apply for me on
> > selinux/next?  In particular they conflict with your 'treat atomic flags
> > more carefully' patch.
>
> Ah, I forgot to pull latest selinux/next before posting... They should
> apply cleanly on top of d41415eb5eda ("Documentation,selinux: fix
> references to old selinuxfs mount point"), but they auto-merged
> cleanly when git-rebased on top of current selinux/next.
>
> Paul, should I repost the patches or is it OK for you to apply on top
> of d41415eb5eda and rebase?

I went ahead and applied 1/6 into selinux/next, but I want to look at
patch 2/6 a bit closer before applying.

-- 
paul moore
www.paul-moore.com
