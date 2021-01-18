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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1C4C433E0
	for <selinux@archiver.kernel.org>; Mon, 18 Jan 2021 13:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17FB822252
	for <selinux@archiver.kernel.org>; Mon, 18 Jan 2021 13:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392204AbhARNit (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Jan 2021 08:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404596AbhARNiq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Jan 2021 08:38:46 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AD0C0613CF
        for <selinux@vger.kernel.org>; Mon, 18 Jan 2021 05:37:57 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id n2so15609288iom.7
        for <selinux@vger.kernel.org>; Mon, 18 Jan 2021 05:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=491toC7ENyw61nPmVjVq0c7QaB2uROGCHP8a3aCSQSI=;
        b=oP8Oq4Uzm9XYHQKPxyvmPpktGp8RPAsKzGWv9YBijs7PcHW3Fm5kr5hJHnXGUGuVgJ
         U5FfLQbsDsNv46Hhe2kbMusv/ZtumPcIUZPWxmiXYCV7SetAyyNWhVl9+PZspZvT/NPr
         upp0A5NeGuLVxx6SFg5hP06cSZSddZtpqjaNceOOfrrnmAlULnHVDJUKSBIgU04awWiS
         FELLmFgZlDNr2VrzIKn3bSPqtlnO9t3H+De6XUjS0wb99lhesJIy6VkvjBbVTl6mLBTA
         HF+DBaHeCW+4y4lIFqBH2G2OfCydnyQ4+HW8y9jJ7DdCy7B4LNT8LJllAVg8IT/jNdQX
         Z6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=491toC7ENyw61nPmVjVq0c7QaB2uROGCHP8a3aCSQSI=;
        b=EFezzbpiD8dhW3OzjPlbEN28X/RM0+Mpcej4o48+WAGiJuTV8YHMc9Engw/airX5Oi
         ZkNWcNHeS6lB4ylfRWYP7F7feKTH9/LoDlIH2t8pE8jC2rjHa5kHsqeTXIAyV54bPhrr
         am7kKxO1H0Y75AvFwwUzuBXcS1Y4E/wZlyDYkm5PXSF1SdifOhpvA7WVaO5kyXF/bWUM
         AFHcpgCvBsx/AxDUJHJBbqR/ZtNFHGZEuQa2G72Wh4rbq0WJAMzB6NTLuQlDkpCl9SfC
         OJ2KHDrJ54EYiST3tm2U8LPR8IH+6ELdudAZD13d9cZ24R6K5W75HyeL+I2I/U2OKTmV
         RtnQ==
X-Gm-Message-State: AOAM530W15D63A/k6KLsR8oSP7Zbx3kdcib+jfNOaVnABD3zAQmdnWh4
        McdXmogj42szFFDth+nAht3T/5CARgBtTtP30K+telf1RSA=
X-Google-Smtp-Source: ABdhPJwREG6gzYG+n3XnMrIx7gqgg6HEfCmxP25Mb735iiOR96oCoobisGZTJoB2hq+1fWhAVaV24XgRUpErWIN3TbQ=
X-Received: by 2002:a6b:7217:: with SMTP id n23mr17075204ioc.143.1610977076736;
 Mon, 18 Jan 2021 05:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20210114155920.293559-1-plautrba@redhat.com> <CAFftDdp3tttJqaCeN9bZw0pV_-1mng-sq0GgAKp5auFFAJyeZw@mail.gmail.com>
In-Reply-To: <CAFftDdp3tttJqaCeN9bZw0pV_-1mng-sq0GgAKp5auFFAJyeZw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 18 Jan 2021 07:37:45 -0600
Message-ID: <CAFftDdqp-h39JYOfzyDN7gXKHdgAjDdRLsFOdt2Afz9yq6oyGg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: Always close status page fd
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 14, 2021 at 10:50 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Thu, Jan 14, 2021 at 10:02 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > According to mmap(2) after the mmap() call has returned, the file
> > descriptor, fd, can be closed immediately without invalidating the
> > mapping.
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > ---
> >
> > Changes against v1:
> > - selinux_status_fd is completely droped as it's actually unused
> >
> >  libselinux/src/sestatus.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> > index 9ff2785d876a..12b015e088ea 100644
> > --- a/libselinux/src/sestatus.c
> > +++ b/libselinux/src/sestatus.c
> > @@ -37,7 +37,6 @@ struct selinux_status_t
> >   * Valid Pointer : opened and mapped correctly
> >   */
> >  static struct selinux_status_t *selinux_status = NULL;
> > -static int                     selinux_status_fd;
> >  static uint32_t                        last_seqno;
> >  static uint32_t                        last_policyload;
> >
> > @@ -298,11 +297,10 @@ int selinux_status_open(int fallback)
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
> > @@ -336,7 +334,6 @@ error:
> >
> >                 /* mark as fallback mode */
> >                 selinux_status = MAP_FAILED;
> > -               selinux_status_fd = avc_netlink_acquire_fd();
> >                 last_seqno = (uint32_t)(-1);
> >
> >                 if (avc_using_threads)
> > @@ -388,7 +385,5 @@ void selinux_status_close(void)
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
> ack and staged. I love a negative diffstat. Thanks Petr.
> https://github.com/SELinuxProject/selinux/pull/279

merged
