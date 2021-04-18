Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6163AC433B4
	for <selinux@archiver.kernel.org>; Sun, 18 Apr 2021 21:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC90610C8
	for <selinux@archiver.kernel.org>; Sun, 18 Apr 2021 21:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhDRVTh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 18 Apr 2021 17:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhDRVTh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 18 Apr 2021 17:19:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DC7C06174A
        for <selinux@vger.kernel.org>; Sun, 18 Apr 2021 14:19:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s15so38330636edd.4
        for <selinux@vger.kernel.org>; Sun, 18 Apr 2021 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9pZW/H6Ggjqx+tkn+sl2Ga8RV2dyit7XTuIV40uw6E0=;
        b=nBr3Kj1tG4EC7vv1uJQDil+9CEqhFkjjedPB366vF5+ri9u6b9OMaLZZwCMuqvveqs
         64rOZiGpzqw5mq0x6yfsdHYSD8geXsRo5EWErrVfiKSs9JSII11X9g2cnHmIoiM0DmHp
         5j007LxEOB/5eY2tJWuCCtEthvInXA3bfez5bhDD2sKFSkitG1SGrK00hSGakuKZLgv6
         p3EMSY6WBMZxps0dRPcUxGoc4l/OzuMABm0xGsrIv8TiS2Bi+m7Gm+qWthzt7aSfx4dU
         V2yNjG+vMtIya2evNkZ/7XgMmdxbkKAiuQyxbPiFGFxOi36ofEdtVNCSi16yRZrbwM3U
         YgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9pZW/H6Ggjqx+tkn+sl2Ga8RV2dyit7XTuIV40uw6E0=;
        b=Hx2GwPIjW72b+kx0tAM+2FG+xzF9hLuv5J+W5f7XAFyJyt1+FvCIiNG+Dg4zEzkk2Y
         YS4RbbfSZRJV2Nxf0c6zehr735qafAfVBBPPw+nUUy5QH3Dl4A2RWiwDvmCHJBcLyISw
         97u1umxZJv12m44lBfJZ5m/m/aAKuFPEtUTSLtxdPr2IikMwG5njA7nsLo7F97gZNasr
         l8zW9b9z4AzryvZ26aJ6HZHNQeRwwHjqam+PD3EGpNsL4AtyFDl6PV4W6PcUxV95eUMk
         lz+Fa73n+J02HA6989SNOEE+XaPbxHEHdKjrHUFb62qG8G+1Yc4mrhQ/38nXmjGdhHSQ
         PpLQ==
X-Gm-Message-State: AOAM532KyGg3AX1HXYXk+lWN7V+MWiHN7jPktR4tCVUsrHbWBKn6matY
        OU2/t5hRgrKke2B16veyROg/YJKqKI1WQvyNDiGB
X-Google-Smtp-Source: ABdhPJw+UbOgKidfYwIleV55XFzcH78JJTRdhgjvKcSbMhYrAq8pdH2mfb/g/r0ZCNHWSW1nWwSQunvpoy+/etElY8k=
X-Received: by 2002:a05:6402:199:: with SMTP id r25mr13895180edv.128.1618780745746;
 Sun, 18 Apr 2021 14:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAO6P2QQvFmMrhUgFHPMPgdN81jKUxcQxK+xdpvZbV=xA1ZEZVw@mail.gmail.com>
In-Reply-To: <CAO6P2QQvFmMrhUgFHPMPgdN81jKUxcQxK+xdpvZbV=xA1ZEZVw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 18 Apr 2021 17:18:54 -0400
Message-ID: <CAHC9VhS1H4WnodphxS=R6iG7o2Fanw0+331wZMkPNgmLVtgPXw@mail.gmail.com>
Subject: Re: MCS NetLabel
To:     "Paul R. Tagliamonte" <paultag@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Apr 18, 2021 at 4:02 PM Paul R. Tagliamonte <paultag@gmail.com> wrote:
> Hello SELinux folks,

Hello fellow Paul.

> I'm running a test system using MCS and just starting to get to the
> point where I'm interested in enabling NetLabel + CIPSO to pass along
> context on a LAN. As a first step, I was able to get it working off
> `localhost` before adding in CIPSO or other boxen.
>
> I'm able to run in enforcing mode (amazing!) and get the peer context
> (even more amazing!) -- which I can use to calculate the effective
> "connection context" for logical filtering on common categories.
> That's really great!

I'll admit to being a bit biased, but yeah, it is pretty cool ;)

However, there are a few words of caution I should share.  First, you
will want to make sure that you protect your IPv4 header if you are
sending CIPSO traffic across an untrusted network.  Second, you need
to make sure that any of your network hops/middle-boxes don't strip
IPv4 options; if they do, you'll lose your CIPSO labels.  The good
news is that in both cases encapsulating your network traffic in a VPN
or some other form of protected tunnel should solve both problems.  If
you use IPv6, CALIPSO has similar concerns, although due to the nature
of CALIPSO and IPv6 the middle-box problem shouldn't really be an
issue.

There is also labeled IPsec, but it is SELinux only and if you don't
carefully synchronize your policies across nodes you can get into some
odd/dangerous situations.  People really like labeled IPsec because
you can transmit the full SELinux label over the wire and not just the
MLS/MCS information, but it's a bad design IMHO; you're better off
with CIPSO/CALIPS+IPsec if you can get by with just the MLS/MCS
information.

> I'm a bit confused with some of the enforcement on this, though. When
> I run my server (with a user and binary at the level of `s0:c1`),
> connecting to localhost via a user at `s0` results in a connection
> getting established.
>
> While I understand this isn't the same as MLS / sensitivity level, I'm
> a bit surprised that it didn't refuse to connect to the privileged
> resource. Certainly I can't cat a file from a user at `s0` that's at
> `s0:c1`, or likely (I haven't tried, but it stands to reason) a UNIX
> Socket with `c1` -- so the TCP connection going through was a bit
> surprising. I can see in the peer context that the user is at `s0`
> (without `c1`), so it'd be possible to filter this software-side, but
> it'd also be a bit more of a mental relief if only processes with the
> `c1` category could connect.
>
> Is there any documentation on how to set that particular type of enforcement?

You didn't mention what distro and/or policy you are using (other than
MCS), but my guess is you are running into a situation where the
SELinux policy constraints are not set as expected.  I know in the
past the MCS labeled networking constraints were a bit lax, even
outright missing at one point, so that would be a good place to start.

However, since most people are a bit lost when it comes to policy
constraints, let me introduce you to The SELinux Notebook:

* https://github.com/SELinuxProject/selinux-notebook

... it is an *amazing* freely available resource, that I would
encourage you to take a look at if you haven't already.  It's source
material is in GitHub friendly Markdown, and you can render it into
HTML and PDF if you like using the provided Makefile.  The Notebook
has a section on policy constraints where it provides some expalantion
of the "mlscontrain" statement, which I believe is where your problem
lies:

* https://github.com/SELinuxProject/selinux-notebook/blob/main/src/constraint_statements.md
* https://github.com/SELinuxProject/selinux-notebook/blob/main/src/constraint_statements.md#mlsconstrain

... from there it is a matter of inspecting your policy to see what it
specifies for the MLS/MCS network controls - good luck!

-- 
paul moore
www.paul-moore.com
