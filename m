Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6AFC433F5
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E9E61052
	for <selinux@archiver.kernel.org>; Fri,  5 Nov 2021 19:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhKETWK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 5 Nov 2021 15:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbhKETWK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 5 Nov 2021 15:22:10 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE18C061714
        for <selinux@vger.kernel.org>; Fri,  5 Nov 2021 12:19:30 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id d12so12637112oij.5
        for <selinux@vger.kernel.org>; Fri, 05 Nov 2021 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grYAQLBawdnZp6xWKp9GPRTus1leIKiehWEebIPK5gE=;
        b=GAIE9oKmc82gwZHLR7RbSPvZeV03fhNnHYPFGe4JjAKYn9kzBRUVsqs2Bpdzwus0d1
         xhXJXePdx/0ZqbqSFxiMtP8qtNJ3kzwocsUtWTCXOSCnQQ/3YHTqjazHiVLPefg3j88h
         hmpcl6N2cW2Kvd3+I2kt25qBmjeS2M0ls/VflEU90jydZIiGF1NvParQC40MHOaKGC1U
         5lra7Qw9QoThHlNxGGx1aPIDcUioN6zHSuRmgwq1OBT5TQApQq8Ud1OaF2gyJvteu6gA
         PUtJDxmx8Hx7nXcsSTvavnIO+cO3Gku9IhkUvB1qYQgLXKyMCxMRnboVUh/OCTEoKhsd
         V+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grYAQLBawdnZp6xWKp9GPRTus1leIKiehWEebIPK5gE=;
        b=euIRqtThwBaIb5772i0Tup/u0dkZiXrPea/YewmJEp9PdM/aSWjO1eG/0FM+cRKeDJ
         9g8pXrtjAUJ7XH1ryLQz/MoZLRhRDtUpftmx26hgSnYAhcmva/G+ibxmw4AZhf8hkwRE
         C+QpCuPMHojoBzpeoNtKn120Xaapvr7112do3NXxni/XTFM9UtV4IL+BSC3ve3aL1991
         WLExAZbUBvMC4GAJ3SevYMGTDCmMMkaBis9Dwm+ADrxM5klPs/n/VdZzjUQm5eQP/hgn
         KV4BDyjtA/q1DfLm8KpHE5UZnbTFzuh5EWZoPiERa0HCANasaAMkjkrawlrTsmrxvO2R
         Aj8A==
X-Gm-Message-State: AOAM5304XPnHTXW7gWa5L+T5KvLLec3vlOR2YYdmxa5+dCGw9jeEROyz
        PdaQ6UZ4noLCAdCxJbUegGoPBQzPS+gQD5PvmATyb5W7
X-Google-Smtp-Source: ABdhPJw/RuHW4VWq8BYeAk/iPezpLZOqDW6Ly8F/KSOrUWPPKKCa+gD0CS3gIAcm/P0CG6+TeIvkHCtDuiibYwnR/Dk=
X-Received: by 2002:a05:6808:140f:: with SMTP id w15mr23409372oiv.16.1636139970095;
 Fri, 05 Nov 2021 12:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <7d775f7f-1377-edde-8474-ba2126256852@linux.microsoft.com>
In-Reply-To: <7d775f7f-1377-edde-8474-ba2126256852@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 5 Nov 2021 15:19:19 -0400
Message-ID: <CAP+JOzQ8V2r8Dzh7xoWYwq3nhwW7KciMoB5EoTiuvjEwJHGQwQ@mail.gmail.com>
Subject: Re: [RFC] Cascade: a high level SELinux policy language
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        Chris PeBenito <pebenito@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 4, 2021 at 2:14 PM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> We have been working over the past few months on a new high level
> language for specifying SELinux policy, in line with the original intent
> of CIL, to enable the creation of high level languages that compile into
> CIL.
>

If you ever feel like CIL doesn't quite do what you need or that it
doesn't work as expected, please let me know.

> Our objective is to create a language that enables the efficient
> creation of useful abstractions by policy experts while enabling those
> abstractions to be easily usable by non-experts who may contribute to
> portions of the policy.
>
> The design is heavily influenced by Object Oriented principles, with a
> goal of enabling the efficient creation of type hierarchies and
> eliminating boilerplate through the use of inheritance.  The use of
> "virtual" types, (which compile into attributes) allows both attribute
> like behavior, and also the creation of inherited member functions,
> allowing for interfaces as in refpolicy without the redundant
> boilerplate.  Another key feature is "resource association" which makes
> explicit the connections between domains and associated types such as
> tmp files.  This feature allows for common patterns (such as setting up
> a tmp file with a domain transition rule and manage access) to be done
> automatically behind the scenes, minimizing the chance of mistakes and
> allowing policy developers to focus more on security decisions.
>

I realize that many of my questions below will be answered with
"future work", so don't feel like you need to explain in great detail
if that is the case.

How different is the inheritance in Cascade as compared to CIL.
Obviously, in CIL it is not required, where in Cascade it is a very
important part. There is also the use of "this" in Cascade.

It seems like Cascade is resolving all of its inheritance before
writing out the CIL. My guess is that inheritance is such a core part
of Cascade that using CIL's inheritance would make no sense. Is that
true? Or did you just not like the way CIL does it?

I was surprised that casc only take a single file. Do you expect the
policies to be simple enough to do in one file?

Since there is only one file, I guess there is no concept of modules
for Cascade? And this means there is no need for something like an
optional block because all of the policy would be compiled at once?

It looks like classes, mls statements, and sids are all automatically
created in CIL. Is there a way to specify these things in Cascade or,
since these things are almost always the same, are these low-level
details something Cascade is not worried about.

What about roles and users. I see the keywords, but how are they going to work?

Thanks for letting us know about this work. It looks interesting.
Jim



> The core language functionality is written as a library, which will
> hopefully enable the easy creation of associated tooling and plugins
> that build on top of that library.  It is our hope that this
> architecture will assist an expansion of available tooling to aid policy
> developers in their work.
>
> This is still a very early prototype and so some functionality may be
> missing or incomplete, but we wanted to make what we have so far
> available for community feedback and discussion as we continue development.
>
> You can find the code and associated documentation at
> https://github.com/dburgener/cascade
>
> I hope this is something that people will find useful and welcome
> feedback and contributions as we aim towards the goal of enabling
> smoother policy development.
>
> -Daniel
