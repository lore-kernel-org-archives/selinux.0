Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8D0C433ED
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 01:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F716108D
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 01:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbhDSBow (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 18 Apr 2021 21:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhDSBov (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 18 Apr 2021 21:44:51 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBA9C06174A
        for <selinux@vger.kernel.org>; Sun, 18 Apr 2021 18:44:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v6so49094045ejo.6
        for <selinux@vger.kernel.org>; Sun, 18 Apr 2021 18:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EmfnHPGQeSDGPL7JFjmeJbMZE59fJ+9Z1YAjgBnuDTU=;
        b=PypxpN3Bh2r1VoX98XiR4SsHYfwmpMgB4yeSYQeIfaFslG8SbMilJvOB6/e+BaBXr0
         SqulZ/lTYUR1zo0ytgCyo3+WjSUEAN56ffP4y/HCesBZbe4Sni2WqRfEEkSB/8ALwgSo
         MnXkGvCI40D4ZhSssfUpmSRwjcI4ey4ywYPZY2MMC1VLDTm5cT2A+QcXQMtGP7Sjfl41
         EnAYM+6qaOx61tCao4htBQBDJ6Aq2qDNxdisPlonsMnjmOQyUrhiMVjh1OB8BZrm/lTc
         xquTgrEadcydpoTsmUYh9pumVtBgpojHDxz2TZoc+iGCcpxG1ASzk/i1MDg2IfnNJ6w/
         MZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmfnHPGQeSDGPL7JFjmeJbMZE59fJ+9Z1YAjgBnuDTU=;
        b=O9jrcWN8e9m7bjv62JWvcZhn+QFm3gDfXzqsAaaK3KLVlUy8gC6skoLXBPrtRv6ihE
         4KKdPjiMXCz3QDWGIumfRFKGad1RO3NX9oZTWF6TBoDd62judAa/S8UZSKcdcaAqTiUb
         9qjKP5S87XJs/6nT35uyvSupxkEb4+kN7x/p98yH/DUCd+Z6jsPAUZs4/FIQeawESGer
         /7+GjVa8vBa2E2IV5f+xdnoj0N8VrY/ZueEOnlMCy1ST4J1/NAtRNFBSsm+a7DG9NIzD
         eqbc7lIEZ0WNuciYT5IRovbT7DjfQGgsOxGKkKJodkvl11w1rtZ54jfTooLYZX374WYJ
         liKw==
X-Gm-Message-State: AOAM533Djtfw64uKkggSNJ95R4sYRSptEGFWoO2mTto7vl27A1qtnSXS
        LNx1kyFkFVMeQhiMYB9EUxZ4s5m9Nh3cnhYJDCkX
X-Google-Smtp-Source: ABdhPJzPSJzrm7+kKvX+EGM6HLa/kyoiY8eVzDhLWTkZ5o8HsHIu6luTSjiOMhR561cvgmi/8gDKy3PvV7QtSjPGYlM=
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr19281143ejb.542.1618796658879;
 Sun, 18 Apr 2021 18:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6P2QQvFmMrhUgFHPMPgdN81jKUxcQxK+xdpvZbV=xA1ZEZVw@mail.gmail.com>
 <CAHC9VhS1H4WnodphxS=R6iG7o2Fanw0+331wZMkPNgmLVtgPXw@mail.gmail.com> <CAO6P2QRh27DtAyA4XnsV97-e9J6SBeN5SPJuAKoVMDp7Lgiatw@mail.gmail.com>
In-Reply-To: <CAO6P2QRh27DtAyA4XnsV97-e9J6SBeN5SPJuAKoVMDp7Lgiatw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 18 Apr 2021 21:44:07 -0400
Message-ID: <CAHC9VhQTmRAey5AYx1a5cehwwauFgwDhoCy8KhEP6mTLOpTuXg@mail.gmail.com>
Subject: Re: MCS NetLabel
To:     "Paul R. Tagliamonte" <paultag@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 18, 2021 at 5:56 PM Paul R. Tagliamonte <paultag@gmail.com> wrote:
> On Sun, Apr 18, 2021 at 5:19 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Sun, Apr 18, 2021 at 4:02 PM Paul R. Tagliamonte <paultag@gmail.com> wrote:
> > > Hello SELinux folks,
> >
> > Hello fellow Paul.
>
> Ah! Paul! A true pleasure -- and thanks again for all your documentation! I
> wouldn't be nearly as far as I am without you. I hope you know how many of
> us out here are very grateful for your tireless work, Paul!

Thank you, that's very nice of you to say, but Richard Haines and the
other Notebook contributors are the ones who deserve the credit (check
the git log, not everyone adds their name to the copyright page!).
Richard was kind enough to put together The SELinux Notebook in the
first place and offer it under a public license; my role thus far has
simply been to post it to GitHub on behalf of Richard, do some minor
cleanup, tweak the HTML/PDF CSS a bit, and merge patches as they hit
the list.

The SELinux project is very fortunate to have a good sized community
with a number of contributors, and I'm very happy to say we've made
some big improvements to documentation and testing over the past few
years.

> > You didn't mention what distro and/or policy you are using (other than
> > MCS), but my guess is you are running into a situation where the
> > SELinux policy constraints are not set as expected.  I know in the
> > past the MCS labeled networking constraints were a bit lax, even
> > outright missing at one point, so that would be a good place to start.
>
> I'm running Debian sid -- which I am fully eyes-open about how stale
> and/or actively busted our policy is. I don't think too many people have
> MCS configured on their systems, so it's not going to be a huge shock
> to me when this is part of the root cause here.
>
> I have a pile of stuff I'm loading in even to get stuff to where I'm at
> now, and I think long-term I'll likely try to start agitating on ways to
> get Debian's policy a bit more up to date. That's a windmill for another
> day, though, I think. Our SELinux maintainers work very hard and
> I don't want to add work for them without being able to pitch in.

I've long wanted to start doing regular testing of the bleeding edge
kernel bits (the "kernel-secnext" testing) on Debian as well as
Fedora.  While Fedora has been an excellent "home" for SELinux
development, I think it is important that we strive to bring that same
SELinux experience to other distros too.  Debian seemed to be an
obvious next choice to me, and while the kernel-secnext testing is
only a small part of that I'm hopeful it will have a positive impact
on the effort ... when I get some time to do that of course :/

> I've uploaded netlabel-tools to Debian[1] back in October, and I've been
> playing a bit with netlabel on my home network (both to get better
> at SELinux generally an CIPSO/CALIPSO/NetLabel specifically)
> so I can effectively triage/debug issues in Debian.
>
> I know basically no one is in the same boat as me, and I'm OK with that :)

We're all in different boats, and I think that's a good thing :)

> > However, since most people are a bit lost when it comes to policy
> > constraints, let me introduce you to The SELinux Notebook:
> >
> > * https://github.com/SELinuxProject/selinux-notebook
> >
> > ... it is an *amazing* freely available resource, that I would
> > encourage you to take a look at if you haven't already.  It's source
> > material is in GitHub friendly Markdown, and you can render it into
> > HTML and PDF if you like using the provided Makefile.  The Notebook
> > has a section on policy constraints where it provides some expalantion
> > of the "mlscontrain" statement, which I believe is where your problem
> > lies:
>
> Amazing. Lovely. Thank you! I will be sure to go through this and work
> through issues as I find them. Thanks for the pointer, I hadn't found this
> yet!

If you find any problems, or have some text that you think would be a
nice addition, patches are always welcome :)

-- 
paul moore
www.paul-moore.com
