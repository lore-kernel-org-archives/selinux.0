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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B6AC4332E
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 14:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3070123435
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 14:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbhANOe1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Jan 2021 09:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbhANOe0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Jan 2021 09:34:26 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BFFC061574
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 06:33:46 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id d9so11512465iob.6
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 06:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSM2rGV8qnCMD36WyMGhNcgXZRdkcegZlAs8F9mEKjw=;
        b=f/uqkKsXgjh4LfRfIBVPZLlR8dUjv7iVWY6xsIZo5525ol4c1JT7FgrvGYnhDK0X5x
         jkKLMEVCVZ1VXMf4if5SFT/e1uxk+wt6m45mciJ1DgCFnQ77fOISZjQn5nlEwz0nJQiC
         7nSBS7RLwp4xh82+YsiV2bj5YlSbCNZqOERXA8HiGZcmPc6mZhpcjtdAnad7KjVK++a9
         QyJkOtmkPhi8KmMRvZ5xG7nofTa2Kxf5z8hSTJllP8oDR4QsohUuZ9wvMEGBdHb5r5iP
         DZqk4cso6bAByKhyhRuHs3oyrV91E7BrBsHev+QoJiLCRrQ5eZM/8hgpb7x7VGJX/nBZ
         lRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSM2rGV8qnCMD36WyMGhNcgXZRdkcegZlAs8F9mEKjw=;
        b=KyFJd5EOH9ef/xFaMtiIVZlIPRQxz1LzpUItPTKXKs/F6MPARkP6XDW7s2ofDuboQh
         S48RQRlPvD4PzU4Fmt2nSgudUfOcxI7hrhGvTLVGFluPyFdJEzHpDy6IAPI7fQM4UvLp
         ZlIuvI5JpHqAPMuRydv29BuBTRSyxDUrh2SmTiQs7yixgkIUCzXqXkPjQyZWnw0Y8xe9
         xvQDYp/j2JuBYA6eK1+OzTKyeuUi0IGnUe50VeWnYAVMkVjISUKO/guHrZF7HJujhr5/
         /PgAnPQGzHBJ/NbK4Kqc5ldKXbX+Cy5gsbUHqQxbNh/Pis02K4u/hY4EC+VkewSmzgLH
         gjOg==
X-Gm-Message-State: AOAM533fFTuaPaD0nIzDV15JWapGYUVnA/bHWiEWT65Nk8y4fDW02lXP
        R993ErcO61k6vrxDx1OwZzhxmsUtH28o/fH3Xro=
X-Google-Smtp-Source: ABdhPJw+LwIy6vmCzYd1MrOrYxUb2/RzSTzHuxEEF4nNr8aFB4xRBBh5WkbKF9OAoJ9o3mak6erCkXfaFe9hIHP7OPc=
X-Received: by 2002:a92:3002:: with SMTP id x2mr6810821ile.163.1610634825711;
 Thu, 14 Jan 2021 06:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20210114133910.282686-1-plautrba@redhat.com> <CAFftDdoUFfoztETJmr2TpLOS-mndbmuvbwHLFjfzhArOT=4FEw@mail.gmail.com>
In-Reply-To: <CAFftDdoUFfoztETJmr2TpLOS-mndbmuvbwHLFjfzhArOT=4FEw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 14 Jan 2021 08:33:35 -0600
Message-ID: <CAFftDdpOgCsSbsBGMeGbOKqbPFskiTFPAu=Q4viynr04i6dwhw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Always close status page fd
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 14, 2021 at 8:30 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Jan 14, 2021 at 7:42 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > According to mmap(2) after the mmap() call has returned, the file
> > descriptor, fd, can be closed immediately without invalidating the
> > mapping.
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > ---
> >  libselinux/src/sestatus.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> > index 9ff2785d876a..6a243b7bcdfb 100644
> > --- a/libselinux/src/sestatus.c
> > +++ b/libselinux/src/sestatus.c
> > @@ -298,11 +298,10 @@ int selinux_status_open(int fallback)
> >                 goto error;
> >
> >         selinux_status = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
> > +       close(fd);
> >         if (selinux_status == MAP_FAILED) {
> > -               close(fd);
> >                 goto error;
> >         }
> > -       selinux_status_fd = fd;
> >         last_seqno = (uint32_t)(-1);
> >
> >         /* sequence must not be changed during references */
> > @@ -379,6 +378,7 @@ void selinux_status_close(void)
> >                 avc_netlink_release_fd();
> >                 avc_netlink_close();
> >                 selinux_status = NULL;
> > +               close(selinux_status_fd);
> >                 return;
> >         }
> >
> > @@ -388,7 +388,5 @@ void selinux_status_close(void)
> >                 munmap(selinux_status, pagesize);
> >         selinux_status = NULL;
> >
> > -       close(selinux_status_fd);
> > -       selinux_status_fd = -1;
> >         last_seqno = (uint32_t)(-1);
> >  }
> > --
> > 2.30.0
> >
>
> Nack, the fd in the mmap of the status page and the selinux_status_fd
> (avc mount) are different fd's.
> The selinux_status_fd is for the AVC netlink socket fallback. If you
> drop those hunks I'd take the patch.

Sorry I misread that, I missed the assignment from fd to that variable...

Ack, this should fix that umount issue hopefully I didn't test that though.
