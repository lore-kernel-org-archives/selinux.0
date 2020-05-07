Return-Path: <SRS0=z4nS=6V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA253C38A2A
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 15:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A52C420838
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 15:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLapMilw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgEGPMm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbgEGPMl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 May 2020 11:12:41 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C87C05BD43
        for <selinux@vger.kernel.org>; Thu,  7 May 2020 08:12:40 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z17so4741684oto.4
        for <selinux@vger.kernel.org>; Thu, 07 May 2020 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVz+GNuOWc0nQMlz+8cwbitvtecQVsQyx1XhBKAM2SU=;
        b=XLapMilw/P9vfwNlHbDM+Vli2puXejbHwVXNvGvd0cRQiBdQ8uX+e+1LX/PLjDqCPK
         FS9n0oViueNr/SrHrKWWYTl1znvR/su8y+QPOYlJ+9Fo4NRZ8SXbTqwgoGfypk2JQPG/
         SZGWDDl4J8Ze4MVwagFPhAWHmjaLryR3MJux1VNgxqV6DZqjJZqQZx48nHMQVAenG5h3
         77gWfEQyaCzpufoatxfy3m4kR4yKjv5+elsggr6xhxpSkaeNo78XDV3YmgdnW+bap2zN
         TSsieuzXZwMuzDZZydIf9nX90mOHJ/o5fF68o3GLZTYKcqCzJJgGNmcALh3uceEHMOQv
         h3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVz+GNuOWc0nQMlz+8cwbitvtecQVsQyx1XhBKAM2SU=;
        b=tSQ66LhxtxGWmYniamkK74ExeHX06bxhMa3XsfbOJ2gXkOdWSRGqMLij50jtYmM3DB
         FpQpiCphvVbdWWPTx00/uKIyejN9XX/bmr2c2RLH87ZFAc4FZPcpofRyn/CtDE/e8nPp
         nKyfVF8NjZX5/+o1oJhkKI45qVx6Jn0NI1PfwUP0rGvTnf+6D8OW9RbP4aj9A7/gg3N/
         n/vte9ncyD8yplXJOljxH/cMuSYPhbJcHY7320w45Dclv6Yk6ogThuQLp+41ARgLPjZ2
         bH3LN4NJxNvrAnWlWqurDgTjSB3mA6YgsslUWjDyuFi1wrAIZaRjKCla+YsyCFpp618Y
         LI1w==
X-Gm-Message-State: AGi0PuZrX43Xc5e4ivY7KXiJwHHiCIdO4fuq3qmQ/qEwgaOXEUgUiL/k
        QO2sS6NvIIfe+ccbcyT8MvWrO8a86ttkl6EcAQiq5xM2
X-Google-Smtp-Source: APiQypLNWMfmM5iguCiJ+Y/eui5bCFlR/el2QVE/LEzEkQhe5o7pOV1tbXiB/tY/Cu4yX7sYEu6Hj1DvQTN39t6rO94=
X-Received: by 2002:a9d:2aa9:: with SMTP id e38mr11228314otb.162.1588864359024;
 Thu, 07 May 2020 08:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
 <1916523.qzzCliNl98@liv> <CAEjxPJ7oXd5EM_hB1tdRKZKLKZoeOh_w8UYevivMC5d1D2G1+w@mail.gmail.com>
 <CAFftDdpygOSWOGNQnbGzGOcKrtsd+3hHsfPY9chM5L90CZGHwg@mail.gmail.com>
In-Reply-To: <CAFftDdpygOSWOGNQnbGzGOcKrtsd+3hHsfPY9chM5L90CZGHwg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 7 May 2020 11:12:27 -0400
Message-ID: <CAEjxPJ44XXQibMfT00xU0F2ySTR_1+QjPNU35R6zLqgyakQAQA@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 7, 2020 at 11:02 AM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> >
> > On Thu, May 7, 2020 at 10:49 AM Russell Coker <russell@coker.com.au> wrote:
> > >
> > > On Thursday, 7 May 2020 6:35:11 PM AEST Laurent Bigonville wrote:
> > > > If people are using preseed installations (kickstart equivalent), I
> > > > think that enabling SELinux in the installer shouldn't be too difficult
> > > > (installing the needed packages, modifying the files and relabeling with
> > > > fixfiles). It's obviously not user friendly, but the question is what's
> > > > the target here.
> > >
> > > If we want to do that properly then I guess we want SE Linux enabled in the
> > > kernel that the installer uses and then have the policy installed early in the
> > > installation so the files can have the correct labels from the start instead of
> > > having a relabel process afterwards.
> >
> > That would be good but might be overreach for Debian since SELinux is
> > not the default there.  It isn't strictly necessary; ever since we
> > went to using extended attributes for file labels, you can set them on
> > a non-SELinux-enabled kernel, so the installer can always set them
> > even if its kernel doesn't enable SELinux.  Optimally they would be
> > set by the package manager based on file_contexts; that is what rpm
> > does in Fedora/RHEL.  Or you can always run setfiles after package
> > installation but before rebooting into the SELinux-enabled kernel.
> > You don't need to defer labeling until you have SELinux enabled.
>
> On Thu, May 7, 2020 at 9:54 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
>
> I found this:
>   - https://man.sr.ht/builds.sr.ht/compatibility.md
>
> It seems to have Fedora-30,31 and rawhide.
> It seems to be free as well (for now)
> I would be a little leary using it, seems new, its only in alpha,
> and looks like it could disappear at any moment.
>
> The travis ubuntu to fedora VM might be heavy, but it would at least provide
> us with something stable... for awhile or we look at getting some
> better infrastructure support for running a CI job on.

Fedora's own CI infrastructure seems like a better bet for the near
term wrt testing on Fedora; Petr appears to be already exploring using
it. My goal here though is to improve the level of support outside of
just Fedora and its derivatives.
