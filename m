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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F303CC4332B
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 15:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CB823A69
	for <selinux@archiver.kernel.org>; Thu, 14 Jan 2021 15:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbhANPMA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbhANPL7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 Jan 2021 10:11:59 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4741DC061575
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 07:11:19 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id o6so11720167iob.10
        for <selinux@vger.kernel.org>; Thu, 14 Jan 2021 07:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4DwVRZVQp0WOa+eTtUtMAOtR+WSfmvJYvyPJlPDQ8zM=;
        b=LCDLJltDRLJ9PD/nZXTrrzYwLjtn7LVB5BTZpXnEj2+EtEgdvCAmposJD0A1OgQgQl
         zYE4235rdYpKcAF9ELWEgf6Mai5DxiyNbU8mVIyf3Y4K2cdNUkFMEZC10s2KMYGjc3KM
         RM/sV8IgR+eOGirRZCF3w0Mzcu4M/H4VgIIbMhb0eALr8btqYXaxB6M9Y4zZdFlbu2yg
         3TZKFeAg1FwbYCEdzVSMvXDnGfv2a+6Sg7xtsNSlVjfg0PTwyAlaftluqhRNlGuVFX77
         demVYJOXJrD2t6VfqMdiKPzMJttItI0zt+4Bbs4EZYXS08Ur6WD0c9kdkCcVsK15F1o6
         lOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4DwVRZVQp0WOa+eTtUtMAOtR+WSfmvJYvyPJlPDQ8zM=;
        b=kIZX99i6dWpAVPN8YBvTYBFhho+sHz4O7GpJbz3zO0uVeBR74rrTna7oJfh2f/55ZR
         YcQfFtPAMiso9G37xMy5IMGCKAU4OnAndVZgbVkUoHJ+DjKP86LEv+Ki6MVGzemJLr5F
         K7FCrnsCbGD3eU9gLbk2JyOCjZW2ee3ZoWkoX47Bdjz2EDeUBTPcpsU8667q1ylGV94d
         XeQZtSnqE6JohyVuRmFCviPeDCMMqrcjlLC81rLMvIe+5Tdgj2aFqmv3eNqN8yxVBtV+
         0mR0Ypx+ss+h53KIe6t0TbQptZMA6xFt/G26PK2MJWAb7gBGUT2GSQuHoLaPiFO1tI2e
         2bxg==
X-Gm-Message-State: AOAM532fU8O4OLxVTQKN/KZfXOUhIJgZ+syPtkTsB/PuUeIRvuqHk1u2
        LjNtJfOGSi5nZ5LJ43P36qd2V5JwcC/DIf8oZUw=
X-Google-Smtp-Source: ABdhPJy2w7mSP+1+lF/O4whLq/MyrqRrVH7Pf8nNiJjOX2JPR0q+2U4T1yNlc0RpHATiZImuX8aCAo57zJOpY+ax+Ww=
X-Received: by 2002:a92:b510:: with SMTP id f16mr6975468ile.22.1610637078592;
 Thu, 14 Jan 2021 07:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20210114133910.282686-1-plautrba@redhat.com> <CAFftDdoUFfoztETJmr2TpLOS-mndbmuvbwHLFjfzhArOT=4FEw@mail.gmail.com>
 <87a6tba7rx.fsf@redhat.com>
In-Reply-To: <87a6tba7rx.fsf@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 14 Jan 2021 09:11:07 -0600
Message-ID: <CAFftDdp_bgjUg45YLJB4Di+Ne3QHnk2SaP0EQwvf7ywQKeR27g@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Always close status page fd
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 14, 2021 at 8:54 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> William Roberts <bill.c.roberts@gmail.com> writes:
>
> > On Thu, Jan 14, 2021 at 7:42 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >>
> >> According to mmap(2) after the mmap() call has returned, the file
> >> descriptor, fd, can be closed immediately without invalidating the
> >> mapping.
> >>
> >> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> >> ---
> >>  libselinux/src/sestatus.c | 6 ++----
> >>  1 file changed, 2 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> >> index 9ff2785d876a..6a243b7bcdfb 100644
> >> --- a/libselinux/src/sestatus.c
> >> +++ b/libselinux/src/sestatus.c
> >> @@ -298,11 +298,10 @@ int selinux_status_open(int fallback)
> >>                 goto error;
> >>
> >>         selinux_status = mmap(NULL, pagesize, PROT_READ, MAP_SHARED, fd, 0);
> >> +       close(fd);
> >>         if (selinux_status == MAP_FAILED) {
> >> -               close(fd);
> >>                 goto error;
> >>         }
> >> -       selinux_status_fd = fd;
> >>         last_seqno = (uint32_t)(-1);
> >>
> >>         /* sequence must not be changed during references */
> >> @@ -379,6 +378,7 @@ void selinux_status_close(void)
> >>                 avc_netlink_release_fd();
> >>                 avc_netlink_close();
> >>                 selinux_status = NULL;
> >> +               close(selinux_status_fd);
> >>                 return;
> >>         }
>
> I'll drop this one. It's already closed by avc_netlink_close()

We can actually get rid of selinux_status_fd all together. The call to
avc_netlink_acquire_fd() just returns it's static cache of the fd acquired
in avc_netlink_open(). So we can just pair the avc_netlink_open with
it's avc_netlink_code().

>
> >
> >> @@ -388,7 +388,5 @@ void selinux_status_close(void)
> >>                 munmap(selinux_status, pagesize);
> >>         selinux_status = NULL;
> >>
> >> -       close(selinux_status_fd);
> >> -       selinux_status_fd = -1;
> >>         last_seqno = (uint32_t)(-1);
>
> I believe this is correct. selinux_stats_fd is not assigned when mmap()
> doesn't return MAP_FAILED
>
> >>  }
> >> --
> >> 2.30.0
> >>
> >
> > Nack, the fd in the mmap of the status page and the selinux_status_fd
> > (avc mount) are different fd's.
> > The selinux_status_fd is for the AVC netlink socket fallback. If you
> > drop those hunks I'd take the patch.
>
