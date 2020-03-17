Return-Path: <SRS0=xXH+=5C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE73AC1975A
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 22:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F48120714
	for <selinux@archiver.kernel.org>; Tue, 17 Mar 2020 22:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="SVw3XPNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQWxN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:53:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34849 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgCQWxN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Mar 2020 18:53:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id a20so28684737edj.2
        for <selinux@vger.kernel.org>; Tue, 17 Mar 2020 15:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=H2AI051rLZAHAFnm2zrh9zVZ1G4fGE+/AeEYX9+wv+E=;
        b=SVw3XPNvBysRZuqRMQwnXnZoJihkTdIEXLekhG2VGxOx1p7a674KjGKt+JuYoSqBEG
         LdGDThESyMyZ4SCN7UWMi5NvkZLfR0dxQmp3UlIcyjpXxXIkEp3aciLGek3xAVu9cuAP
         sV3OVDKh5UwfNw/COzFcr4NwMLzZFAKu/0OV/zLM1eLGs3OSAxYXPjpsxql1HI6NS5kO
         wnlp2/9Tja82YETKYSwTgeIU5u6gUCdAM/OAxTGA29Khg8A2clHh5so4oaCm9ut5D0QQ
         Ssb9rlaV5uUcMgYMVpYOICmltm2MaqmqjwC1C5dawkUS0xBvuDwxhPZGztdj746tKMG/
         GXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=H2AI051rLZAHAFnm2zrh9zVZ1G4fGE+/AeEYX9+wv+E=;
        b=hgvTDbAGB8mMoLHC7soMAqn9OJ80+3ygOO22KfeO2lXlxkPWR4u+76ROFYtqKf1jpp
         mCD5eLrMzgaV6LYl+2gMCT9b+h4OSjZ0c4BLvZyEihOb6ncayI01Ygi3Gyvtj7EUdswC
         MVe0YBJuZuWXSxGKSP4dMOgzRUrOVqjFxIP0tD+/SQ5rK20682vERcIagUuqGpRV8lJG
         jgsgHOKkM+FqLJb+4Uo1NcrXwN9cC9Kru1Bf1nsOAhjDZ/TxoE9DYiWcuk8SvTsNibUL
         0Gba4Gb5AKqttl5N8CmkFgFRV16E1yN1mGwcrgWuYbzTGjO9AY66521rgBWqkGIbtgdZ
         BERw==
X-Gm-Message-State: ANhLgQ1CLaFgCHg+Fmxo+RiQz4fh5FkUCRAbJ7HcWHHWNimHg00N/J9E
        dztjMRSRQwgv2xmqUnNZNTX/U5bmJkb1dLrO2+H1Y8I=
X-Google-Smtp-Source: ADFU+vtPay+qB+R3Hvch37dTE+5rewBMIpIMXcNW/3urIKs5hbI+IW9Yo87KYtCs3qD5j2rwxHO2Ib2ZIZBFoRet6xM=
X-Received: by 2002:a05:6402:13cc:: with SMTP id a12mr1113788edx.128.1584485588949;
 Tue, 17 Mar 2020 15:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200317221237.vrkru2kdc63zq3vi@chatter.i7.local> <CAHC9VhTF8MH7UodKLGmAmMNzUeh-68W92pivnBgJfGhWV5F7HQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTF8MH7UodKLGmAmMNzUeh-68W92pivnBgJfGhWV5F7HQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 Mar 2020 18:52:57 -0400
Message-ID: <CAHC9VhTrqszEHq8UywBYRPbeysiLYJav_UcRE4v+CM+JGq_m7A@mail.gmail.com>
Subject: Re: Looking for help testing patch attestation
To:     selinux@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

[NOTE: fixed with the proper linux-audit address]

On Tue, Mar 17, 2020 at 6:51 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Mar 17, 2020 at 6:12 PM Konstantin Ryabitsev
> <konstantin@linuxfoundation.org> wrote:
> > Hello, all:
> >
> > I'm reaching out to you because you're a security-oriented mailing list
> > and would likely be among the folks most interested in end-to-end
> > cryptographic patch attestation features -- or, at least, you're likely
> > to be least indifferent about it. :)
> >
> > In brief:
> >
> > - the mechanism I propose uses an external mailing list for attestation
> >   data, so list subscribers will see no changes to the mailing list
> >   traffic at all (no proliferation of pgp signatures, extra junky
> >   messages, etc)
> > - attestation can be submitted after the fact for patches/series that
> >   were already sent to the list, so a maintainer can ask for attestation
> >   to be provided post-fact before they apply the series to their git
> >   tree
> > - a single attestation document is generated per series (or, in fact,
> >   any collection of patches)
> >
> > For technical details of the proposed scheme, please see the following
> > LWN article:
> > https://lwn.net/Articles/813646/
> >
> > The proposal is still experimental and requires more real-life testing
> > before I feel comfortable inviting wider participation. This is why I am
> > approaching individual lists that are likely to show interest in this
> > idea.
> >
> > If you are interested in participating, all you need to do is to install
> > the "b4" tool and start submitting and checking patch attestation.
> > Please see the following post for details:
> >
> > https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation
> >
> > With any feedback, please email the tools@linux.kernel.org list in order
> > to minimize off-topic conversations on this list.
>
> Hi Konstantin,
>
> You might want to extend this test to the LSM list as well.  I'm
> refraining from CC'ing them on this email because I don't want to
> spoil your beta test rollout, but I think it would be a good thing to
> do.
>
> Speaking as the person who merges patches for both the SELinux and
> audit kernel subsystems, I look at every patch I merge; I don't
> blindly merge patches (even from certain "trusted" individuals).
> Simply put, I've always considered that to be part of the job.  While
> the patch attestation could provide some assurance about who created
> the patch (assuming a reasonable web-of-trust), and that it hadn't
> been tampered with, I feel it is more important to review correctness
> than it is to guarantee provenance.  If you ever develop a tool which
> can help with the correctness part, I'll gladly jump to the front of
> the line to test that one! ;)
>
> Having said that, I'm happy to see work going into tools like this,
> and at some point I'll look into adding it into my workflow for an
> extra level of safety (although I'm on the fence about making it
> mandatory for submissions).  Sorry to disappoint, but I'm probably not
> the best test monkey right now.
>
> --
> paul moore
> www.paul-moore.com



-- 
paul moore
www.paul-moore.com
