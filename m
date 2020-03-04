Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DCFC3F2CD
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D892073D
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 14:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTbRKnyv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgCDOVf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:21:35 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43036 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgCDOVe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Mar 2020 09:21:34 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so2204092oif.10
        for <selinux@vger.kernel.org>; Wed, 04 Mar 2020 06:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YYg4mhdZl1FgVuWgS7GM+Dq4tGhQfZ3BJf9daAQwEBM=;
        b=UTbRKnyvPSSYbstoLwbYK8/24WteYJvAFNAWwHm7v42F0lkXJ3LD/9w6nExeY9hSP5
         x1pyrrqdANvOnecro1977CfwTvWtM+dsQyVKgSVxSAR/VbBi0BYyXCK11Vg59dRa527l
         KwIhUNAQmQNEm94iHCs7CLLh9WushXD/S22nkv5X9nBAobLMj7Wle2gmJRDZszspUuzs
         sBxOfkvyhrwXl9CwX1ZGtHhHYRoUWRPoYbQRgHF+XwCOvCrcz76PO7cw6EjorFNbBQGK
         5GQFZkcaEr1P6y/sFgkTQrCeWh6h0lSVCBw3JU1UuiPtGxealexGV3AD9APMwNj5d7BY
         yinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YYg4mhdZl1FgVuWgS7GM+Dq4tGhQfZ3BJf9daAQwEBM=;
        b=OAT0DQCIBW+rL5y7F34EemRfCF3OSuxUKRCZQ3FkK4ectKCBFnAbBmM+1gHU3M5LpC
         JO71WLxxbHk9YV9pVOKdpR5tcr01dYw2vdCHhEkJDKzEd8YAeT8AwxQBTa3zLN33OHiq
         JdbUBXUq2WCjpJwwbvrF50Id6hMq21S3o37bwZuNw6K/qscdhmsYL9tyGpSLeWgx0i/w
         kVuNSWRhZS9jWztnjOVKes/E50VOUKsQTS9H5PXSMH+uVZyR0rbKdEXvFuHqGxXm/hBW
         rd7UVzI4ryAwSInaCtAlB2djL4nIEPiMoweOuM9F6n7QrIXaygQXj+LfhriOrMfqCei9
         bIpw==
X-Gm-Message-State: ANhLgQ0VL0UiYdiT6aPV7ZycdmoPPbHNzssrQjUP2u2sIbq+wLrXFIA6
        ldywe7hvzN9EJ5XYtoJLQ1N0jVsPsIewlz0DNmAj8Jwq
X-Google-Smtp-Source: ADFU+vsZDvA1s/KTDuR6pghUhgEOaOM++mgXrR0fLQEteCF7k4nCGZ6oV2kIaylAx3Rvz09T2BsWQuEeK8TEddbOTMU=
X-Received: by 2002:a05:6808:48c:: with SMTP id z12mr1829433oid.92.1583331691074;
 Wed, 04 Mar 2020 06:21:31 -0800 (PST)
MIME-Version: 1.0
References: <20200304072940.GA1026144@brutus.lan> <20200304074251.GA1032355@brutus.lan>
In-Reply-To: <20200304074251.GA1032355@brutus.lan>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 4 Mar 2020 09:22:42 -0500
Message-ID: <CAEjxPJ4o114iFykhm-m7knLx2qfFoO_pnZt66im+Yk6pSbLBmg@mail.gmail.com>
Subject: Re: strange pam selinux issue
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 2:44 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> On Wed, Mar 04, 2020 at 08:29:40AM +0100, Dominick Grift wrote:
> > The easiest way to explain this is as follows.
> >
> > Consider this scenario:
> >
> > # seinfo -xuwheel.id
> >
> > Users: 1
> >    user wheel.id roles wheel.role level s0 range s0;
> >
> > # selinuxconlist wheel.id sys.id:sys.role:sys.isid:s0
> > wheel.id:wheel.role:user.systemd.subj:s0
> >
> > Now consider this scenario:
> >
> > # echo '(userrole wheel.id sys.role)' > hack.cil && semodule -i hack.cil
> >
> > # seinfo -xuwheel.id
> >
> > Users: 1
> >    user wheel.id roles { wheel.role sys.role } level s0 range s0;
> >
> > Here is the issue:
> >
> > # selinuxconlist wheel.id sys.id:sys.role:sys.isid:s0
> > wheel.id:sys.role:sys.isid:s0
>
> For completeness:
>
> # cat /etc/selinux/dssp3-mcs/contexts/users/wheel.id
> sys.role:login.subj:s0 wheel.role:user.subj:s0
> sys.role:ssh.daemon.subj:s0 wheel.role:user.ssh.subj:s0
> sys.role:sys.isid:s0 wheel.role:user.systemd.subj:s0

Are you using libselinux with or without the commit to stop using
security_compute_user()?
If still using security_compute_user(), what does compute_user
sys.id:sys.role:sys.isid:s0 wheel.id display?
If you don't have compute_user (it is in libselinux/utils but not sure
Fedora packages it), you can also just
strace -s 4096 -o trace.txt selinuxconlist wheel.id sys.id:sys.role:sys.isid:s0
and see what it read back from /sys/fs/selinux/user.
