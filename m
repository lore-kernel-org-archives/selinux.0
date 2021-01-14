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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B945C433E0
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 14:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB9223A58
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 14:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbhANOrD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Jan 2021 09:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbhANOrC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Jan 2021 09:47:02 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45793C061574
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 06:46:22 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id u26so11619533iof.3
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 06:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlJB7GkrRJgN7A1mIpndcwY3/HgJ22sHTCYbp+ftbPU=;
        b=T4rfxsr2PQtv/4YGpKtpVYldJxeaXhRc9snkQJt8KO7IAQXbHjfS0OiHs6hZuyaDVf
         ynlsgZVCdgksJbXw6LcxSZRF2Bo7Fz//NESFZoFzqZz72Jyd4gkDP3Mzslbkeca5KfB/
         xoUrovImElsSsHuXg5VQR4P4LxJ2Frer1V9uw+oP8KmpefNia/bPMNJhDi4Hw7Wlm/i1
         jGToBAf/UEXmriWNfjvJx8LDdv3TqifTsPhD2BegFN9bGRB1einkGSAW9bV3j2ZFehG3
         5EWmvuMuGu1jDEW6GOarwS9FLB/yNi6BRKtRXiSQTr+Myy5VXy4qWxgh/8uloS6eUMt0
         GsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlJB7GkrRJgN7A1mIpndcwY3/HgJ22sHTCYbp+ftbPU=;
        b=I5xhRJe8jmyclgvinAmZ4Dj+Di4oQuHDV0X6x2GXy7AP5V1p7NnnVmRrNPCZOOeRbW
         zy5D3S6M5xcbN/Wmzliyh1uxAhbYbfSrFNQgeot7/CQ6HZHaf8OrlyrOJ7dFJT538+94
         QSlYJp4vYaVXLzPWB8izyiT6f5GIetIb6jtXy/SQANyXiRydFv/KSMtsD2KZEkd4SN23
         y2s6GRQ+3zp04tAK4W4HSDYOzgpF8YD8vItFiQBIeuQaVGmMMjEIytfuiHD3w6kh3bv8
         9zSXhsQRl36ZFsuIpU+edR8vFCLXb/ZZ/rKbBtsNs0ZEmeudPlsaQ/pZ58pYZMNnqjcs
         Hy4g==
X-Gm-Message-State: AOAM532ftp3nXsvpXVI2/kXWdGFnMuv2iSAqjU+KNj8gxYa3qDY2ywQS
        UKcpuWmkQKt9lCD3aCN+6ud7oxENYZtvWZXqw0E=
X-Google-Smtp-Source: ABdhPJyYtlF19dum1a5qAnZmUisj+tHR7f4+VIqd5QsTgXs2EeJ/aobVZgQj+I8xGjYB+fW+bFcgc0es8XrRWuTUnD0=
X-Received: by 2002:a92:bf06:: with SMTP id z6mr6890021ilh.174.1610635581580;
 Thu, 14 Jan 2021 06:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20210114133910.282686-1-plautrba@redhat.com> <CAFftDdoUFfoztETJmr2TpLOS-mndbmuvbwHLFjfzhArOT=4FEw@mail.gmail.com>
 <CAFftDdpOgCsSbsBGMeGbOKqbPFskiTFPAu=Q4viynr04i6dwhw@mail.gmail.com>
In-Reply-To: <CAFftDdpOgCsSbsBGMeGbOKqbPFskiTFPAu=Q4viynr04i6dwhw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 14 Jan 2021 08:46:10 -0600
Message-ID: <CAFftDdrFaByLGOQLb+-L3P7Pg37e46sc3WfZUzCfhCGOjQ4abA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Always close status page fd
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 14, 2021 at 8:33 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Jan 14, 2021 at 8:30 AM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > On Thu, Jan 14, 2021 at 7:42 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > >
> > > According to mmap(2) after the mmap() call has returned, the file
> > > descriptor, fd, can be closed immediately without invalidating the
> > > mapping.
> > >
> > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > > ---
> > >  libselinux/src/sestatus.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> > > index 9ff2785d876a..6a243b7bcdfb 100644
> > > --- a/libselinux/src/sestatus.c
> > > +++ b/libselinux/src/sestatus.c
> > > @@ -298,11 +298,10 @@ int selinux_status_open(int fallback)
> > >                 goto error;
> > >
> > >         selinux_status = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
> > > +       close(fd);
> > >         if (selinux_status == MAP_FAILED) {
> > > -               close(fd);
> > >                 goto error;
> > >         }
> > > -       selinux_status_fd = fd;
> > >         last_seqno = (uint32_t)(-1);
> > >
> > >         /* sequence must not be changed during references */
> > > @@ -379,6 +378,7 @@ void selinux_status_close(void)
> > >                 avc_netlink_release_fd();
> > >                 avc_netlink_close();
> > >                 selinux_status = NULL;
> > > +               close(selinux_status_fd);
> > >                 return;
> > >         }
> > >
> > > @@ -388,7 +388,5 @@ void selinux_status_close(void)
> > >                 munmap(selinux_status, pagesize);
> > >         selinux_status = NULL;
> > >
> > > -       close(selinux_status_fd);
> > > -       selinux_status_fd = -1;
> > >         last_seqno = (uint32_t)(-1);
> > >  }
> > > --
> > > 2.30.0
> > >
> >
> > Nack, the fd in the mmap of the status page and the selinux_status_fd
> > (avc mount) are different fd's.
> > The selinux_status_fd is for the AVC netlink socket fallback. If you
> > drop those hunks I'd take the patch.
>
> Sorry I misread that, I missed the assignment from fd to that variable...
>
> Ack, this should fix that umount issue hopefully I didn't test that though.

As an aside though, I did notice a bug in the existing code:

A failure in:
selinux_status_fd = avc_netlink_acquire_fd();

Will cause the code to still return success to the caller of
selinux_status_open().

And cause the close to return EBADF which is silently ignored and
doesn't matter.
