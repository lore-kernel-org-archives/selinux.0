Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1F3C433EF
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 19:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84F07610FD
	for <selinux@archiver.kernel.org>; Fri, 24 Sep 2021 19:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346462AbhIXTMd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 15:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346404AbhIXTMc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Sep 2021 15:12:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D27FC061571
        for <selinux@vger.kernel.org>; Fri, 24 Sep 2021 12:10:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dj4so39950510edb.5
        for <selinux@vger.kernel.org>; Fri, 24 Sep 2021 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=snUDhOuSj3eKOiR11ubTWh6qf8t64LbYv6iha3GxxsE=;
        b=YwTgKT7fuLEq8EbheSlYCofubOzhsqXSu9fBs5U2rZpeTxVNEnIDEPCovfm4b1/8xM
         SbKjdikcuNbdrYaq2jA6y29kV4dg2a28KeyBUt+1IKxfJcMlpNfRTEvAUnI8ZVaaMmkR
         TMaHEwexBTIRlxpfeDFQeYq3pUN2B0Jk1b3NNP2XdKzrELMUgvWHpkRjH1iTrBblwJXc
         0dWdsUXlXxgalkMMlG/HQZTVpxmw/54lHNJi42WdwyBWg7re1IiME0rnaJjp4ZmNei9s
         kqzaClzyxEo0IbFOxaEHIDQY1RtBX0Kscr7AZGC7eG3XPgQuoj5QAT0iLX+Q1M/3IZR3
         9PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snUDhOuSj3eKOiR11ubTWh6qf8t64LbYv6iha3GxxsE=;
        b=UXK3M5Z01zaCSPPkhraoJwBDOnZvwVm6UzPqL8DGSnTozXfP/n/m55fo7F7J7+q7qf
         uhptYJ6QCHP+BrRty8RwIfltfzCLbEtvWJ0bztNJU8OvpMtp4NqyuwZI26gExNfbtx9I
         H/oal/liTokUHC4k0GvgNjEvajDYs90oqwaV+dmXE7iVBnf8G1//SFxr/Zy7jIodcOCC
         zbcVBUksdfEwvDzHvVE84WhxudRZUPGiVKPxIOQa1PqH6ebhtKNi+MqJUKXrlunj4xOz
         ZwC+SyIpNa1p3PR2hIvFYJW1vHLx5PcEcpWsLvBIMRjVFKQo9J8LGek9xvqvWHjwu6Ux
         1c5w==
X-Gm-Message-State: AOAM531jyMNdRNRwUFL9971SAg4ZTNKBARFcTDrU80wUmRhpGULxRjUY
        lhhg+EHBM4bT755HySB7SXNcUaSdIeIu0owQf2jc
X-Google-Smtp-Source: ABdhPJxEY0vbvM4DVW68xu80mz/KUKRbouFqyHSkVgUS/5+UwB9NDN/JGMOYSr6MwTKht7zZxo2VUmhLK7x4WuiYOnM=
X-Received: by 2002:a17:906:f15:: with SMTP id z21mr12987609eji.177.1632510657758;
 Fri, 24 Sep 2021 12:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <163243191040.178880.4295195865966623164.stgit@olly>
 <CAEjxPJ5pxox=oE0TxmEFA-PkFGPDbAjtK_nqM3y-xaT0e3or0w@mail.gmail.com>
 <CAHC9VhTAY0povyGpv3QhiE9n4WDmnSYTi9Cq8ZnVO_AkH8M6EA@mail.gmail.com>
 <CAEjxPJ7wkCyPZb7h3C_U3zVmJtiVtm4FAi5K+6U7kS63g0Vm-w@mail.gmail.com> <CAFqZXNvM_RkaubR6pbAQVUyWjTgc-PTN5NZzOAk3sQ2q199hBg@mail.gmail.com>
In-Reply-To: <CAFqZXNvM_RkaubR6pbAQVUyWjTgc-PTN5NZzOAk3sQ2q199hBg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 24 Sep 2021 15:10:46 -0400
Message-ID: <CAHC9VhQDK_FQxSzw2WsNtKDSiXezkhRZjp7t0psuJTdYRGA+Gw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: use SECINITSID_KERNEL as the subj/obj in the
 lockdown hook
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 24, 2021 at 12:38 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> I would vote for just removing it rather than basically duplicating
> the Lockdown LSM functionality.

/me records the vote

> (Well... I *tried* to make this thing work, but it really feels like
> too much hassle to reasonably tweak all the existing callers to
> fulfill the SELinux expectations to be worth it. I admit I'll be kind
> of relieved to see the lockdown class go - it brought me nothing but
> pain :) It would be a nice feature if done right, but that would have
> to be a new patch that somehow deals with all the intricacies...
> Either someone finds enough motivation to do it, or it just shouldn't
> be there, IMHO.)

I'm really only willing to entertain one of two options here: 1) stick
to a lockdown-esque, always kernel_t hook or 2) remove the SELinux
hook implementation.  Anyone who sends me a patch doing something else
is likely going to see it NACK'd as soon as I check my email.  Maybe
I'll soften my stance on this in a year or two, but I *really* don't
like having email exchanges with Linus like what I had this week.

-- 
paul moore
www.paul-moore.com
