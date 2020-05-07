Return-Path: <SRS0=z4nS=6V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B92CC38A2A
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 15:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E470B208D6
	for <selinux@archiver.kernel.org>; Thu,  7 May 2020 15:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0JiqJ07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEGPCF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 May 2020 11:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726356AbgEGPCF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 May 2020 11:02:05 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F5C05BD43
        for <selinux@vger.kernel.org>; Thu,  7 May 2020 08:02:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id i19so4134413ioh.12
        for <selinux@vger.kernel.org>; Thu, 07 May 2020 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KHMT5yPmbXwbWe3gry8TpTxOuV1Y3MZQg019G1f3wg=;
        b=T0JiqJ07F69sRjC+HRbeKr1bgWsRuLjk2/PFscRaY0QoQmMr58zeiOL8PsUua0Ib4O
         zim4cI1DU2pBP6T2BptaNGaR64+DXzumJm8kAkTJFpIMWqjQFjVSegVB1MC+cHrbi8FG
         1R31yojKQNyzssaa4/p6eeJonFYttVTpP0uBeK56Cwoh7OrDqqCMW4A+XaeFwhcExa44
         Bnw357nbXmzPaBLpeRWPGafp1r2t+P40iNG0RCSCkeXLsl5aLU53dzn3ussKEw7nGg6e
         VtiahQqJrzESb5o5+LL73pMhbYjXPEXmvP0skWlgFAt/CSuz0NJSBFqq4wsX+vzLyLtE
         Rqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KHMT5yPmbXwbWe3gry8TpTxOuV1Y3MZQg019G1f3wg=;
        b=HQd+eTJvmDelDU57bBOF3H76dyVydw7mCMcsdvOCdUHJbzwC8vU8spE96e6Qe6Bi1X
         K2kgD0L7XfQOVbk43/yR8ied9r30p9Mcb59WS7rgf2PK9Pnlqf8q89/JnnrsyATLsRdn
         zjbQeqZjz3XBzIfc1a6IUC9zyKmSXtA9m4FjEQ+8cNWYbOai9+qqAE/r6ar7Ew3rZDuS
         WsWqeicEcfYSytNJGC0BPM73N9w5SQnw5ooC+Q1KSpK/ofpmcN4Nq/zDcF5K9w646DdH
         vFp3zRdbSKKIBPUfhxpLJTM+iPPmuoEUmvrQW9RkAJnOcx+SyTPeKu03qpDOS6m6Grbs
         Q6Pg==
X-Gm-Message-State: AGi0PuYcAydiVAaZMOw5j2FId/k9EZAEFTsgz7j6VnMc7HKs3iBkupvA
        zyLsE88qfQ4fF6mxs+IhzP/WQHP5/4qcNWXAu/I=
X-Google-Smtp-Source: APiQypIYWBNHBVKWihxbWcDKvYhKAp0nnHee36p93iLku2Xnm2Fkr+V+ca4GxvFIAiQ4OstRfhP02qO8+pC52d9QGm0=
X-Received: by 2002:a05:6602:192:: with SMTP id m18mr3872292ioo.141.1588863724305;
 Thu, 07 May 2020 08:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200506005339.13641-1-stephen.smalley.work@gmail.com>
 <3838641.zh4Wi6GlAV@liv> <cf747e50-ca5b-429f-1af2-afaa16ee29be@debian.org>
 <1916523.qzzCliNl98@liv> <CAEjxPJ7oXd5EM_hB1tdRKZKLKZoeOh_w8UYevivMC5d1D2G1+w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7oXd5EM_hB1tdRKZKLKZoeOh_w8UYevivMC5d1D2G1+w@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 7 May 2020 10:01:52 -0500
Message-ID: <CAFftDdpygOSWOGNQnbGzGOcKrtsd+3hHsfPY9chM5L90CZGHwg@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: update to work on Debian
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
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

>
> On Thu, May 7, 2020 at 10:49 AM Russell Coker <russell@coker.com.au> wrote:
> >
> > On Thursday, 7 May 2020 6:35:11 PM AEST Laurent Bigonville wrote:
> > > If people are using preseed installations (kickstart equivalent), I
> > > think that enabling SELinux in the installer shouldn't be too difficult
> > > (installing the needed packages, modifying the files and relabeling with
> > > fixfiles). It's obviously not user friendly, but the question is what's
> > > the target here.
> >
> > If we want to do that properly then I guess we want SE Linux enabled in the
> > kernel that the installer uses and then have the policy installed early in the
> > installation so the files can have the correct labels from the start instead of
> > having a relabel process afterwards.
>
> That would be good but might be overreach for Debian since SELinux is
> not the default there.  It isn't strictly necessary; ever since we
> went to using extended attributes for file labels, you can set them on
> a non-SELinux-enabled kernel, so the installer can always set them
> even if its kernel doesn't enable SELinux.  Optimally they would be
> set by the package manager based on file_contexts; that is what rpm
> does in Fedora/RHEL.  Or you can always run setfiles after package
> installation but before rebooting into the SELinux-enabled kernel.
> You don't need to defer labeling until you have SELinux enabled.

On Thu, May 7, 2020 at 9:54 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:

I found this:
  - https://man.sr.ht/builds.sr.ht/compatibility.md

It seems to have Fedora-30,31 and rawhide.
It seems to be free as well (for now)
I would be a little leary using it, seems new, its only in alpha,
and looks like it could disappear at any moment.

The travis ubuntu to fedora VM might be heavy, but it would at least provide
us with something stable... for awhile or we look at getting some
better infrastructure support for running a CI job on.
