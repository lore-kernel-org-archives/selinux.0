Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EC4C433F5
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 18:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6B86109E
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 18:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhJLSHg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Oct 2021 14:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhJLSHV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Oct 2021 14:07:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC8BC061746
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 11:05:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d3so2785969edp.3
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9T/UI2gtPr8wiHuk0G+PXQKddjuF7Z7R6RmIFY4HoF4=;
        b=ifwwl9AyWp6MsgC2Nlaurwcz+1TFD05xGv0RB5J2o8KN6WZz2RPI/1NFkoyJz3h0WA
         o9ilf5HRMVMuNBZP2nzPV2fFlvGFXwsuzv7GfiQ146F5LGhyN6hSp2niVvjJtRbqXrcS
         BdrDOeddGHhFg5BNcDRwxyT++C2rv9BstU4yBIz5CNrDk9v8dLm2Oyx41MxwYcyeDQgI
         c1b/dwRhePYEW6QW6F4uR4oFblSMXqUpVk8OKaFFTCiINCupNRi5uQ3csA/vnhHb2YIn
         Pkp6O5QaRNcjpODgA3gV/5CRpEpxiPfpovEfM00cOG74wXWGA9E1aOELRlwGKPNEXDWS
         dQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9T/UI2gtPr8wiHuk0G+PXQKddjuF7Z7R6RmIFY4HoF4=;
        b=3VnGCgzMD0QhKl5UAJNQLNb+WST4buRk8Xxw9VUrS91btjOQDT72WoKvsRUmglyg1M
         GZpN8VC60I38Qu2oKGMkKiTYHxG38VepzfixdRi0CMnJYiatC7pJARTgdOPrI3pP9rSQ
         5OhGzuEJHzjAcgAfBD6QtPdEEp4i7j+y8Y/Bf2H5jlAJi2tJOpDT9a+zKUWSi8DHRgG/
         6iShJyDlPCHR515AIWt4qdtk4T2PWlhCy0lxD48Zy7C7tj1wgP7Y82++0S1yqcugYTj6
         eIu6gimSVgmPbYlNvQgP/2iePJ70qRZhPSASvLDxJFrk4IRqeXlnuWO50ySORltFv1OH
         vNWA==
X-Gm-Message-State: AOAM5305i3dukGul9FRdDsEE+9jLCg4wza6SIsJOir3QByRwlc7McLRx
        zQT6yyCuJ7n1PDAoeHpdL3ZcMkkmKE+BgbG4yJ0sbljCtA==
X-Google-Smtp-Source: ABdhPJxezaUtUvhYscS8NQVa87ugEkLAM3SCFyxHl4Py2jqGjIfjtpQwiLwQCBcqlJHFUeXikrcUiSYuUzu52BAbVgI=
X-Received: by 2002:a50:e1cd:: with SMTP id m13mr1745319edl.93.1634061900274;
 Tue, 12 Oct 2021 11:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <163399358463.185926.1386262780774440656.stgit@olly>
 <CAHC9VhQA+RMAGmzBpr6UEAi6EAp5bZ7jWKFSCWpJWZvJuW8Q5g@mail.gmail.com>
 <CAEjxPJ4gmU_ppLPZ5yNfN-pQ4u979dTo+wjnUV4iEA5PaOXWVw@mail.gmail.com> <CAHC9VhS06QJ5yr3LrCTBh_-uxPDTsrvYUaJ1d3GRTkkiCNxoJw@mail.gmail.com>
In-Reply-To: <CAHC9VhS06QJ5yr3LrCTBh_-uxPDTsrvYUaJ1d3GRTkkiCNxoJw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Oct 2021 14:04:49 -0400
Message-ID: <CAHC9VhQFkRDjpn7F=gjwDC7gdjWAmEFJ018Atjbsc7X3E37iAw@mail.gmail.com>
Subject: Re: [PATCH] selinux: make better use of the nf_hook_state passed to
 the NF hooks
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 12, 2021 at 1:57 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Oct 12, 2021 at 1:52 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 11:02 AM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Mon, Oct 11, 2021 at 7:06 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > This patch builds on a previous SELinux/netfilter patch by Florian
> > > > Westphal and makes better use of the nf_hook_state variable passed
> > > > into the SELinux/netfilter hooks as well as a number of other small
> > > > cleanups in the related code.
> > > >
> > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > ---
> > > >  security/selinux/hooks.c |   53 +++++++++++++++++++++-------------------------
> > > >  1 file changed, 24 insertions(+), 29 deletions(-)
> > >
> > > FYI, I just merged this into selinux/next.
> >
> > Don't know if it was this one or the previous one yet but
> > selinux-testsuite locks up my box hard during selinux-testsuite on
> > inet_socket test.
> > Completely unresponsive, no output.
>
> That's fun.  I could have sworn this ran through my automated test,
> but let me double check ...

Well that's embarrassing ... yes, something is wrong with this patch,
I'll pop it off selinux/next now and repost when I've had a chance to
revisit this.

-- 
paul moore
www.paul-moore.com
