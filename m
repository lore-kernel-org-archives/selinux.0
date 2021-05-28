Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A28C2B9F7
	for <selinux@archiver.kernel.org>; Fri, 28 May 2021 15:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48F0613B6
	for <selinux@archiver.kernel.org>; Fri, 28 May 2021 15:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhE1Pzx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 May 2021 11:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhE1Pzx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 May 2021 11:55:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B31C061760
        for <selinux@vger.kernel.org>; Fri, 28 May 2021 08:54:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s6so5351306edu.10
        for <selinux@vger.kernel.org>; Fri, 28 May 2021 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgRoFUGRATJe+d8KSXVyiLV5UyX1useCAnQIlrvAaWU=;
        b=TSht/y42/eGQLtb/KSdYcn4N3XmFXll94R1oB2MfApoaXw3sgup1BUAL8bFPptnNp1
         506mPb4KCAqcczfb4gyAYgHNbaFiTowloszPrFxC10pukgPD9TsBVa1ogMg/pt0GcUMT
         WS0rwDK/OKjyGJUeQmgD11ufp+b/bI1/z0GcQU13gWh9uzyNsvXCG+qHGb2bZeatOIPE
         ESqeyBp+Xs1/VOuIpz971XND8D3kjYaNUE8SN/xBOZEhe3+tztdp74dPdfm6fqekcduV
         fAtRYr9pMMX5CugO/b50XxX14rF5UEoo4Q8vcER/Ejhlf+EakgTyk3tbIJ2vJk0fS3cN
         DSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgRoFUGRATJe+d8KSXVyiLV5UyX1useCAnQIlrvAaWU=;
        b=EYeIl8Ou11fDmIVJ7Zoa0iN+mJb/h3wLePm+KJzbhp0HldzLhhPfzzvss3cbqX8vqs
         MjOtYmauS86Fm01JgvDNRkG5k4y5Akh4QVcbgGmUVmeBKrDmwTnwDmuZSKQViuHnSIim
         Q40b0YplINnTVPe8uOaUv2enWqsCg94/9tzTReo2r3qYKumQk4U0w+UV0BxKAJfU8+1o
         efJtWtTxs6OA6J/T+i5x4NjBScKFErzJ9C0fCnQQBSgNNnuytVubDPm7yexa36Ai933Q
         lnHAj9Q9sI1THLxgiuuNPQEnsvq+LbcmwlNRwvOO3MmINOTDgD9qS155K+7b9B7kjZhf
         +7xg==
X-Gm-Message-State: AOAM533kmR8yWrztdwrXMavTy1jfHEt+KRwxXTdVp8HdUmcH+kJRdIgi
        2r/CyVoGyPYhPK2+xmCDmt9KZgW+Yf+APYaxCs8l
X-Google-Smtp-Source: ABdhPJx9lDU4bz4ZRNuGWCmsj3KypbE5i42MpDU5uXKqoLBw/jwmLUnQhhD+lDAtTdyo/XHVCMcM3JWSpnl4Jqa5QKg=
X-Received: by 2002:a05:6402:35d4:: with SMTP id z20mr10534196edc.164.1622217256341;
 Fri, 28 May 2021 08:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210517092006.803332-1-omosnace@redhat.com> <CAHC9VhTasra0tU=bKwVqAwLRYaC+hYakirRz0Mn5jbVMuDkwrA@mail.gmail.com>
 <01135120-8bf7-df2e-cff0-1d73f1f841c3@iogearbox.net> <4fee8c12-194f-3f85-e28b-f7f24ab03c91@iogearbox.net>
 <CAFqZXNsKf5wSGmspEVEDrm4Ywar-F4kJWbBPBE+_hd1CGQ3jhg@mail.gmail.com> <17eaebd3-6389-8c80-38ed-dada9d087266@iogearbox.net>
In-Reply-To: <17eaebd3-6389-8c80-38ed-dada9d087266@iogearbox.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 May 2021 11:54:05 -0400
Message-ID: <CAHC9VhTuurjpkgq=cS5ZNwpxuuOq4E3eE2RuD+JaCQz6X0fk6g@mail.gmail.com>
Subject: Re: [PATCH v2] lockdown,selinux: avoid bogus SELinux lockdown
 permission checks
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, network dev <netdev@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jiri Olsa <jolsa@redhat.com>, andrii.nakryiko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 28, 2021 at 10:43 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 5/28/21 3:42 PM, Ondrej Mosnacek wrote:
> > (I'm off work today and plan to reply also to Paul's comments next
> > week, but for now let me at least share a couple quick thoughts on
> > Daniel's patch.)

Oooh, I sense some disagreement brewing :)

> > On Fri, May 28, 2021 at 11:56 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >> On 5/28/21 9:09 AM, Daniel Borkmann wrote:
> >>> On 5/28/21 3:37 AM, Paul Moore wrote:
> >>>> On Mon, May 17, 2021 at 5:22 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:

...

> >> Ondrej / Paul / Jiri: at least for the BPF tracing case specifically (I haven't looked
> >> at the rest but it's also kind of independent), the attached fix should address both
> >> reported issues, please take a look & test.
> >
> > Thanks, I like this solution, although there are a few gotchas:
> >
> > 1. This patch creates a slight "regression" in that if someone flips
> > the Lockdown LSM into lockdown mode on runtime, existing (already
> > loaded) BPF programs will still be able to call the
> > confidentiality-breaching helpers, while before the lockdown would
> > apply also to them. Personally, I don't think it's a big deal (and I
> > bet there are other existing cases where some handle kept from before
> > lockdown could leak data), but I wanted to mention it in case someone
> > thinks the opposite.
>
> Yes, right, though this is nothing new either in the sense that there are
> plenty of other cases with security_locked_down() that operate this way
> e.g. take the open_kcore() for /proc/kcore access or the module_sig_check()
> for mod signatures just to pick some random ones, same approach where the
> enforcement is happen at open/load time.

Another, yes, this is not really a good thing to do.  Also, just
because there are other places that don't really do The Right Thing
doesn't mean that it is okay to also not do The Right Thing here.
It's basically the two-wrongs-don't-make-a-right issue applied to
kernel code.

-- 
paul moore
www.paul-moore.com
