Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C895C4332F
	for <selinux@archiver.kernel.org>; Tue,  2 Nov 2021 12:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E789460FC2
	for <selinux@archiver.kernel.org>; Tue,  2 Nov 2021 12:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhKBNBZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhKBNBY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Nov 2021 09:01:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A088C061764
        for <selinux@vger.kernel.org>; Tue,  2 Nov 2021 05:58:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w15so75786679edc.9
        for <selinux@vger.kernel.org>; Tue, 02 Nov 2021 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oS5P08rKOHmHVOqFsv1wlAiyj1NrRmUfampI9oL2V64=;
        b=n5PHQAW9dm9kSkiLYV9daCoVja0+TvWv0SvPUz8RC2NAWnAS31ToFveGA1/UPb7uYB
         f2DFw4kpYFhgjAav2FZdaU4krkdZ7po9IsPMKSRj4oEE7vb5V/lMQlEBKVfIZlCwUM6y
         W9aK0lSYkAOZmx8r4UpzYRovgJbgvMlb7iUfZ+YUBflrQE4/62VAeOfpv26y5Xn0Gm3J
         q3zC3SpxcC96EDC1+fvOA9T2Wf5EiD6cs6axCkiyJICxLsJq6xHYZRb0RShO3obZkJMU
         aEtStNkbcZgbr2ZF4OuZBneJBBa0HWbEyaYhLCSyNlaANsI6r0GVcXsUG8TWX1fH649s
         W1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oS5P08rKOHmHVOqFsv1wlAiyj1NrRmUfampI9oL2V64=;
        b=B/hcRjxn/hvxpFuIMBdIHkqlPpiXYmZDUOIrWpOxq2A5pmnGlNAxJMkAJCotn3qXvW
         mvffPHVFutrteEBSPUN7qf0tRCuw/vc5HGbd5RX0jNbMDbDErw6iR0coND/6AJWnERRN
         eO172JVkhpDXBeTBDrLKttkZdyssqPiOLU3TO4XaENDay9g7N86E+vRlkf8W1GwVcvmv
         B+H/XgtZbh0orapkN3gKZqUC+dM10Jgdb3udi5nIawofdfgb///jim3mJxSHQzxaZvAK
         hC7SfupwZqAlpvAm1KntlKzK2JH/RXxDZahfg7OVnMwD0DIEcnK1UJ88uIPkQrkvlPRE
         olxg==
X-Gm-Message-State: AOAM530WvMMHer1ZKjy32GHDQ4GYKXh4AiUvfqVcjZXV418bwqKSSqNt
        f+HeMEK3y75Nu8RhiA+uSzEjb/0uKxuk/3aVGSYm
X-Google-Smtp-Source: ABdhPJydRuxERCqDLUerKHEo8hrEbU94yrYYszodlvCbnReZNWzPvF4WrAzB6P1x8AOkiMpqhUts8Pw23pMvedkoZ/M=
X-Received: by 2002:a17:907:2d12:: with SMTP id gs18mr25449694ejc.126.1635857926118;
 Tue, 02 Nov 2021 05:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
 <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
 <CAHC9VhS3LfGvuVyXW5ePTQNtQ0KeQ7vz3wLinoZrbGVjU6GuoQ@mail.gmail.com>
 <CAHk-=whvZRaJSXirjcWKn75H-2H1tc54cru8p-vXE_2UyuvGNQ@mail.gmail.com> <CAHk-=wj0fNVO9tfEmWTcW7i+HoN4K4PejZ44sQYCEfL1S3UPWA@mail.gmail.com>
In-Reply-To: <CAHk-=wj0fNVO9tfEmWTcW7i+HoN4K4PejZ44sQYCEfL1S3UPWA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Nov 2021 08:58:35 -0400
Message-ID: <CAHC9VhTZW-thM3rhMArYNQYD1PjLWh3Y3XBQ_XGv86TqkN3GVg@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 2, 2021 at 12:23 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Nov 1, 2021 at 8:55 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > This follow-up was sufficient. In fact, the original should have been
> > sufficient for me.
>
> ... and as you saw from the pr-tracker-bot, it's all merged now.
>
> Sorry for missing that part of your original pull request.

The important part is that it is now in your tree, thanks.

-- 
paul moore
www.paul-moore.com
