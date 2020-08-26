Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3EAC433DF
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31BB2075E
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttr3PaIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgHZMvl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbgHZMvi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 08:51:38 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F1CC061574;
        Wed, 26 Aug 2020 05:51:38 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id x6so408663ooe.8;
        Wed, 26 Aug 2020 05:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diZBGnPjcaRpzNNj2xUjW6fq8RTGqEBgIiCRFd1AUvI=;
        b=ttr3PaIsjT/RjpWXQtLVmsui9TXBbtizCopYLMyvJTdW7EZMRA2PpoSrAsjerIXr/z
         YaNlHvT8BWC263/aLRGBR3zCvP7tqHR8H97Y3oe6Ofc5jEF9EkcrrjTm0hu4W2xqYrqT
         eYCCCdlkwUXwMGp1Qj/k13eA4A7+ac7kZ0kEmM+fydpqWPkoPivDeaT0U3yKTPjnwo2a
         qAkJVV+/5B86W4OCfcC6zQshjourutOlO/Xo9/WX0AYAZvFHz5k4TXJu0ZRUEHJNGtG3
         UiOEOgk9gXrki77lUns3qG5O8lvJmRPVuZILLFGmiNWwJIz4qyGQRjFthGhdezTsis5G
         4fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diZBGnPjcaRpzNNj2xUjW6fq8RTGqEBgIiCRFd1AUvI=;
        b=XX6ux3HJ/oGWCB1YbhHzayR8J1VMZa8IvXS4kLDo7E0siLRjM1SJjISjiJGxvGEPTe
         BeHjamuKpl3VekqrQlSZuiDyjjR2biF4giuNx5CnEQ2u5oYLbkOehZUqCLH9qRjPdy+f
         YoaUs5VjzaGdYYfZALx/Q9S5tgKK7DAnNKeZam9OX7ENhRgNk5T7TXvxQTE202L+k5HT
         WXGQlqWWw5GtKsfRQyg/ozv52YbJbvvXFFITsktyK0ne9T4kZ9tm1cOphUaR4qnWI9vy
         L60gHKiKLF5zCxgDU2/BX5XpSs5pSoJuoBjBxTnxYmYaZlRywIfFZ1GSlU6bq5Duzck8
         c0ew==
X-Gm-Message-State: AOAM530gN747LKJevhr0DCZ38pApMlixXWoe5loAny7ptS3YUT44OsFG
        abjQCCqm1Rbl0N8CpwnsswHBs5U1iykmOl8L19zfEV6E
X-Google-Smtp-Source: ABdhPJzmjHEiAqqyB6P0v1hZaqEVA0oSJ76tcW7W9vc9a0ZBpSV8NZ1U0o+lj1suA/o+LdgT1knTCjGmuXzY0Q80Igc=
X-Received: by 2002:a4a:b80b:: with SMTP id g11mr10543780oop.13.1598446297471;
 Wed, 26 Aug 2020 05:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200822010018.19453-1-nramas@linux.microsoft.com>
 <CAEjxPJ5Kok-TBfS=XQ+NUC5tuaZRkyLBOawG4UDky51_bsMnGw@mail.gmail.com>
 <418618c4-a0c6-6b28-6718-2726a29b83c5@linux.microsoft.com>
 <CAEjxPJ6-8WnZRJnADsn=RVakzJiESjEjK-f8nSkscpT7dnricQ@mail.gmail.com>
 <CAFqZXNvVQ5U6Ea3gT32Z0hfWbu7GPR-mTF2z6-JZZJT57Heuuw@mail.gmail.com>
 <f041e8ee-3955-9551-b72d-d4d7fa6e636d@linux.microsoft.com>
 <CAHC9VhQP7_rV+Oi6weLjVhrx2d8iu9UJ8zeE=ZcqnBMqngrJ4Q@mail.gmail.com> <07854807-c495-b7e5-fc44-26d78ff14f1b@linux.microsoft.com>
In-Reply-To: <07854807-c495-b7e5-fc44-26d78ff14f1b@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 08:51:26 -0400
Message-ID: <CAEjxPJ4TkEEKG+pXwUjyysov1s1mFk4jbGGVyC7ghmpfd3TJ4w@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 4:49 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 8/24/20 3:18 PM, Paul Moore wrote:
>
> Hi Paul,
>
> >>>>> Is Ondrej's re-try approach I need to use to workaround policy reload issue?
> >>>>
> >>>> No, I think perhaps we should move the mutex to selinux_state instead
> >>>> of selinux_fs_info.  selinux_fs_info has a pointer to selinux_state so
> >>>> it can then use it indirectly.  Note that your patches are going to
> >>>> conflict with other ongoing work in the selinux next branch that is
> >>>> refactoring policy load and converting the policy rwlock to RCU.
> >>>
> >>> Yeah, and I'm experimenting with a patch on top of Stephen's RCU work
> >>> that would allow you to do this in a straightforward way without even
> >>> messing with the fsi->mutex. My patch may or may not be eventually
> >>> committed, but either way I'd recommend holding off on this for a
> >>> while until the dust settles around the RCU conversion.
> >>
> >> I can make the SELinux\IMA changes in "selinux next branch" taking
> >> dependencies on Stephen's patches + relevant IMA patches.
> >
> > I know it can be frustrating to hear what I'm about to say, but the
> > best option is probably just to wait a little to let things settle in
> > the SELinux -next branch.  There is a lot of stuff going on right now
> > with patches flooding in (at least "flooding" from a SELinux kernel
> > development perspective) and we/I've haven't gotten through all of
> > them yet.
> >
>
> Could you please let me know when the current set of changes in SELinux
> next branch would be completed and be ready to take new changes?
>
> I mean, roughly - would it be a month from now or you expect that to
> take longer?

I can't speak for Paul but I would expect it to be sooner rather than
later. Ondrej has some follow ups on top of my policy rcu conversion
but then it should be good to go.
