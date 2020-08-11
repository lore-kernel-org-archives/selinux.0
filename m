Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44660C433DF
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 22:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E152078B
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 22:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXSI2SO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgHKWBj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgHKWBj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 18:01:39 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDFEC06174A
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 15:01:38 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so425272iow.11
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 15:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8qbUQ/MSTKUCgQVPB7w2nvPM7MxKy+XBpISgmV5pj3Q=;
        b=OXSI2SO5+4nVTbtHPnn1E/ZqgyycrH10zjNTnz3PMoTHyCWPtjnff7Zg/CkN2GpxF2
         srxfhCwuQjrKROn4vkk/mRYnHomHR5Nb85yqPPE8n0HVFJ+Fxa3Hd9z7ra1zePpMta6I
         OizFXgpMzSezH5A2JJX8N4Xl4I+0ABJG0TxFX+GQ8QjLmBjEglX6Pn4gihqFA3ApuEft
         TeZYhyDsp5BvCwZCLswDTbwV3Zgt9Oy2vC/oK9Q9H/z+8ydA2pqGVCXJltQ9IgP78kMJ
         AlT93VuS4f/lHib1oP6M9aYUG7i3eGUZ5nn79I81vk87vyBnG2j5q6KTcvTgimnGRKfT
         x12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8qbUQ/MSTKUCgQVPB7w2nvPM7MxKy+XBpISgmV5pj3Q=;
        b=F3BBFzRcvtJC9nOezSp8b1bDtD0kFgb1l1dmFiFUlDMygu9KfhO5vxP+QEgGqqpTPH
         Y2+5/eddk6n4UfrIRBa2BIjP061zo8VDcXji8wm1RpXxvlQzyvk0JUN7t2qeY8+Bo7Tc
         EKF28cGEaLd7h/83KXtonE1xpVsYuResDv/q/LV+z9v8ww/zdQNciwsGq8Y3E7FN23y+
         XGV53Aq1JHUvOcFsBRkhCvBve0d7w51FM5W5JFzFw8pJHQuXnOyvTMMZtXZfiq0cRk2y
         R66syhBJ+i48ZbIKU0Gn6ywueYj5PMqZdGWEYwIeSHYPWlAOpLM5sYu2/TfgXwxJA1lg
         /3aQ==
X-Gm-Message-State: AOAM533PYtwlm85JdU+jb9oB+R5p10rQcHCRSCgRU/LIB+1ZPaBAi52m
        C7kZG5/oT84zppBJj46TD1YsD4B0/KJlhVGtn2g=
X-Google-Smtp-Source: ABdhPJwSlUcRmT75oGSFqGD9DRUopllIOAJq1qS6eQxJFwBWuwv/6WNaAoNL8jdffWRqrWGkbO9hX5TPZ74/gN6/kS0=
X-Received: by 2002:a6b:e70d:: with SMTP id b13mr24787549ioh.141.1597183297671;
 Tue, 11 Aug 2020 15:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200811191035.13948-1-william.c.roberts@intel.com>
 <CAEjxPJ6sLaiVrh59AYonbDNi2jsY6YTGd5ygYx=QBGaTC7rdSg@mail.gmail.com> <CAFftDdqoA_k6jtpFbmaSBpONtEarUfF6DdrG-m47EbQSqwYx_w@mail.gmail.com>
In-Reply-To: <CAFftDdqoA_k6jtpFbmaSBpONtEarUfF6DdrG-m47EbQSqwYx_w@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 11 Aug 2020 17:01:26 -0500
Message-ID: <CAFftDdoQ=0gVhmxbnMZV=j0WdsFTT94e0ciDEs933RrgX5EVrw@mail.gmail.com>
Subject: Re: [PATCH] ci: fix stall on git log -1
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

merged:
https://github.com/SELinuxProject/selinux/pull/259

On Tue, Aug 11, 2020 at 2:51 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> On Tue, Aug 11, 2020 at 2:16 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Aug 11, 2020 at 3:11 PM <bill.c.roberts@gmail.com> wrote:
> > >
> > > From: William Roberts <william.c.roberts@intel.com>
> > >
> > > git log -1 may use a pager to output long messages, and when the pager
> > > is invoked, leads to stalls on the ci system waiting for user input.
> > > Use --oneline to print the short part of the commit message and
> > > the digest. This information is for debug/informational purposes only,
> > > so truncating the output is sufficient.
> > >
> > > Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> > > Signed-off-by: William Roberts <william.c.roberts@intel.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Staged:
> https://github.com/SELinuxProject/selinux/pull/259
