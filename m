Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E5BC433B4
	for <selinux@archiver.kernel.org>; Sun, 18 Apr 2021 21:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2339060E0B
	for <selinux@archiver.kernel.org>; Sun, 18 Apr 2021 21:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhDRV5K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 18 Apr 2021 17:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhDRV5J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 18 Apr 2021 17:57:09 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5C0C06174A
        for <selinux@vger.kernel.org>; Sun, 18 Apr 2021 14:56:41 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id k25so33669597oic.4
        for <selinux@vger.kernel.org>; Sun, 18 Apr 2021 14:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8zjS9ln/xXvVDQXfxhuA1Ul8roaCd1iHi3Pi+AQQ1gs=;
        b=pMvJk3S0ormP1CNaMxfkNTcjmf95k7hciRYAWsPvl3LboPR8W0VvNGV8hpAWNFXoFs
         lkk/CgcJwNExcSdSUP7UXPhcLil8C+0G2Or+Pg4qoPNn2mdcSWATR6LO5rQ0IXYybPj/
         sar64D0qlsVXGL1bwmXxS8Wz2fyzRzf1O6sQHRyncRslKqLjk0bORLfE4QsaF+OQTelk
         dFrjCwit9uKvXpNMaaWZ+3EO6uuvsHJ4KcY/Phl6dH5Ew36wYN4SpAoJBPTdOcMS5Vyq
         8rycMx9G1l1I9ZwarI7sDRshLTdCAX7ijrtXwDyTioPwappnkizcA2yRznpQWv89859m
         XaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8zjS9ln/xXvVDQXfxhuA1Ul8roaCd1iHi3Pi+AQQ1gs=;
        b=IjZPLOmRqnUgl3uYGVlY4E94i8KAbEhX7TYxmbgXbcciPp4j+8TCmXpNaZNdP8d4M6
         DN23e2WTK13Xq6J6SFujil/GYsM8OK+NcaXNRAgIWRtFwUNX6WUp1MPvGWaZZ+gwb4qR
         MDkhCg30zj+eeJFR3CNWRWjWgsN5RX5h1uEt9lE1KyeeXXfnq2lnIP+XMXzFEr9R6J1L
         b9et5EdX+BFfVy+C+UChxNh5ReP2g3CU245/gBOTMYXwWmDthgn5pcdxVEQvNR69G9c8
         u77Ij4J8fT1k5jcoWLX4S4CCo/2hixPSaV1rjQe+aqjVHwk3ZtiKclOiXBU9sLPJTrnw
         AcTQ==
X-Gm-Message-State: AOAM532oCa128yLXKoapThI1SdQQoc7aGfi59vbmAZbZgUgduWZmDtn7
        u0i7Zp8bTqdcuUPLXvY8WvKowcky+upAaGnoKYVGlnQ+2PnJAQ==
X-Google-Smtp-Source: ABdhPJyiF4UKWIDMau+AuEdjDovaIwS3doYp2vMuSxBalPANwf+nbdE0fJgoJHuArEV9xCY0pZn9aTVT2VnB/U4fy8U=
X-Received: by 2002:aca:aa04:: with SMTP id t4mr3034222oie.60.1618783000606;
 Sun, 18 Apr 2021 14:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6P2QQvFmMrhUgFHPMPgdN81jKUxcQxK+xdpvZbV=xA1ZEZVw@mail.gmail.com>
 <CAHC9VhS1H4WnodphxS=R6iG7o2Fanw0+331wZMkPNgmLVtgPXw@mail.gmail.com>
In-Reply-To: <CAHC9VhS1H4WnodphxS=R6iG7o2Fanw0+331wZMkPNgmLVtgPXw@mail.gmail.com>
From:   "Paul R. Tagliamonte" <paultag@gmail.com>
Date:   Sun, 18 Apr 2021 17:56:28 -0400
Message-ID: <CAO6P2QRh27DtAyA4XnsV97-e9J6SBeN5SPJuAKoVMDp7Lgiatw@mail.gmail.com>
Subject: Re: MCS NetLabel
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

[ Resending -- my email was HTML and got rejected. Sorry for two
emails, Paul :) ]

On Sun, Apr 18, 2021 at 5:19 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Sun, Apr 18, 2021 at 4:02 PM Paul R. Tagliamonte <paultag@gmail.com> wrote:
> > Hello SELinux folks,
>
> Hello fellow Paul.

Ah! Paul! A true pleasure -- and thanks again for all your documentation! I
wouldn't be nearly as far as I am without you. I hope you know how many of
us out here are very grateful for your tireless work, Paul!

> I'll admit to being a bit biased, but yeah, it is pretty cool ;)
>
> However, there are a few words of caution I should share.  First, you
> will want to make sure that you protect your IPv4 header if you are
> sending CIPSO traffic across an untrusted network.  Second, you need
> to make sure that any of your network hops/middle-boxes don't strip
> IPv4 options; if they do, you'll lose your CIPSO labels.  The good
> news is that in both cases encapsulating your network traffic in a VPN
> or some other form of protected tunnel should solve both problems.  If
> you use IPv6, CALIPSO has similar concerns, although due to the nature
> of CALIPSO and IPv6 the middle-box problem shouldn't really be an
> issue.

Understood on all counts, thank you very much!

> There is also labeled IPsec, but it is SELinux only and if you don't
> carefully synchronize your policies across nodes you can get into some
> odd/dangerous situations.  People really like labeled IPsec because
> you can transmit the full SELinux label over the wire and not just the
> MLS/MCS information, but it's a bad design IMHO; you're better off
> with CIPSO/CALIPS+IPsec if you can get by with just the MLS/MCS
> information.

Got it. That's super helpful, thanks.

> You didn't mention what distro and/or policy you are using (other than
> MCS), but my guess is you are running into a situation where the
> SELinux policy constraints are not set as expected.  I know in the
> past the MCS labeled networking constraints were a bit lax, even
> outright missing at one point, so that would be a good place to start.

I'm running Debian sid -- which I am fully eyes-open about how stale
and/or actively busted our policy is. I don't think too many people have
MCS configured on their systems, so it's not going to be a huge shock
to me when this is part of the root cause here.

I have a pile of stuff I'm loading in even to get stuff to where I'm at
now, and I think long-term I'll likely try to start agitating on ways to
get Debian's policy a bit more up to date. That's a windmill for another
day, though, I think. Our SELinux maintainers work very hard and
I don't want to add work for them without being able to pitch in.

I've uploaded netlabel-tools to Debian[1] back in October, and I've been
playing a bit with netlabel on my home network (both to get better
at SELinux generally an CIPSO/CALIPSO/NetLabel specifically)
so I can effectively triage/debug issues in Debian.

I know basically no one is in the same boat as me, and I'm OK with that :)

> However, since most people are a bit lost when it comes to policy
> constraints, let me introduce you to The SELinux Notebook:
>
> * https://github.com/SELinuxProject/selinux-notebook
>
> ... it is an *amazing* freely available resource, that I would
> encourage you to take a look at if you haven't already.  It's source
> material is in GitHub friendly Markdown, and you can render it into
> HTML and PDF if you like using the provided Makefile.  The Notebook
> has a section on policy constraints where it provides some expalantion
> of the "mlscontrain" statement, which I believe is where your problem
> lies:

Amazing. Lovely. Thank you! I will be sure to go through this and work
through issues as I find them. Thanks for the pointer, I hadn't found this
yet!

> * https://github.com/SELinuxProject/selinux-notebook/blob/main/src/constraint_statements.md
> * https://github.com/SELinuxProject/selinux-notebook/blob/main/src/constraint_statements.md#mlsconstrain
>
> ... from there it is a matter of inspecting your policy to see what it
> specifies for the MLS/MCS network controls - good luck!

Perfect. Thanks, Paul!
   [Mirror Universe] Paul

> --
> paul moore
> www.paul-moore.com

[1]: https://tracker.debian.org/pkg/netlabel-tools

--
:wq
