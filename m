Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7476CC433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 21:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4346E206F1
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 21:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo8iBjGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgENVAz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 17:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727858AbgENVAy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 17:00:54 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDE4C061A0C
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 14:00:54 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e8so237012ilm.7
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYE3L+djqsh5n1vUKNHwm/rrbcWTA1Y889A90Q/X5gc=;
        b=Qo8iBjGLKcPCttqztWor5E3hRbpmB0UGzyHHxiizwv4YpP2nwHTv/rAtB4X4JBXqNO
         g+AIuI9msBPhOFc8BJu3OHCKBsE/epYeroFodAthqIIOuBgjvQ/RSAuk+A2MhqyZtqlm
         1moOOdm3SFtMxjtZc6hNFr7Nbp1i/YWH0AMkRY5uHHh1BnKxqixk9CNAzZ+k5fqyqzw4
         wff9yMSgazdD5sgfrlII7znvcFH4ihh3XKydW/tuG2msbwUvQAgP/GZLFQQ8qsUgtOfO
         6c31zh4S22FmN5MRajOqzjrLA5CYDFZ4INYVx8Gyrnn4bjam/MUXYu3pLwVtn3H4eAL/
         VfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYE3L+djqsh5n1vUKNHwm/rrbcWTA1Y889A90Q/X5gc=;
        b=kZZs7tgVJfi9RDvHMPdy/czUcPijohvrfTgMJkrCsJIwmG96ThRxC/pUxT922aYul4
         GowBCytnFbY0QAj4UEtJrjRZXArSODbjrmznfEinfdZAsnYGsd/CRaPDkcguXhlOZ/GB
         ooJrDrsYd2zalc0VLDACToGc6NZ9YACTij2CFBNSjozYMRGFjIuqKGd7R6CWWzvxrQqH
         YRQWfsKeOTnWGzDH2o+H1zZ8CCHrlqJbstkdPkPCWbQKZrOQaTQDM/gaUCyX2BJOlwHY
         l6/WQ84cAWKUHuOQRFX39ZYE6c3lHIU5YwO7WuZdDx2R3VjiS1HlML0APpHlVKrkVJhK
         KnaA==
X-Gm-Message-State: AOAM533C74T5KoB/9gtup8aoFIdG3xh6WB7j4qOyxP9FoF6wqSFEcSd7
        eAulOC99o48ra1hFPZauVoRw3uUnqYGDp2nJ4XVW1HP3/hQ=
X-Google-Smtp-Source: ABdhPJz6XGYrsW6fdreoC6jxvdekdj0ynojBQdI3mf5DuZUoUjOuA8OnU18XYVvWC3QTmFpwToWXPRCE2z9gm00DKKA=
X-Received: by 2002:a92:58d6:: with SMTP id z83mr61992ilf.129.1589490053687;
 Thu, 14 May 2020 14:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <3581425.j52oWYpJar@liv> <20200407085922.GA438349@workstation>
 <20200422065053.GA167999@workstation> <CAHC9VhQUmY=ue3zWdTnE1Ehi90Lj3077sLbu+jyaWoAVKuKyeQ@mail.gmail.com>
 <CAFftDdo1hqbacU2TD6zQp_t_KJq-KS5pWBMr89c4HA3=aUdUbQ@mail.gmail.com> <20200423150039.GC204116@workstation>
In-Reply-To: <20200423150039.GC204116@workstation>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Thu, 14 May 2020 16:00:42 -0500
Message-ID: <CAFftDdq_g_rUy=KFh_gOEXoVxkCgz9qWzR17d4Mt1qVChoVLjg@mail.gmail.com>
Subject: Fedora VM On Travis for Testing
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        Jason Zaman <jason@perfinion.com>,
        Steve Lawrence <slawrence@tresys.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        James Carter <jwcart2@tycho.nsa.gov>,
        Joshua Brindle <brindle@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Lautrbach <plautrba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I just wanted to lay out a demo of a Fedora 32 cloud VM image booting
on Travis with execution happening in the Fedora VM.
The Fedora VM contains the selinux source code for that particular
travis build, so it has the PR patches, etc.
The VM has networking.

The build logs for the Travis run are here:
  - https://travis-ci.org/github/williamcroberts/selinux/builds/687185489

Which comes from my git tree here:
  - https://github.com/williamcroberts/selinux/tree/kvm-fedora-testing

Note that it's super messy, I need to go through and cleanup both the
patch and the git
history. I also should verify the downloaded image is signed for the VM.
Also note that I may rebase/squash my git branch at any time.

Petr started a release document here:
  - https://github.com/bachradsusi/SELinuxProject-selinux/blob/RELEASE/RELEASE_PROCESS.md

I'd like to gather feedback, and perhaps more comments on:
1. Is this CI approach worth continuing?
2. Comments on the CI scripts (I have no idea what I am doing, common issue)
3. Comments, patches, suggestions on what tests to run in this CI environment.
4. More information in in the RELEASE_PROCESS.md file. I made some
comments there
    as well on ideas.

My goal here is that a release can occur if CI is passing without
worry, and that
we automate manual steps as much as possible. This way, if we get hit by a bus
releases can occur without much effort.

Thanks,
Bill
