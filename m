Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AF0C433FE
	for <selinux@archiver.kernel.org>; Tue,  2 Nov 2021 00:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CEA61077
	for <selinux@archiver.kernel.org>; Tue,  2 Nov 2021 00:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhKBAre (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Nov 2021 20:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhKBArd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Nov 2021 20:47:33 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25983C061766
        for <selinux@vger.kernel.org>; Mon,  1 Nov 2021 17:44:59 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 205so32053403ljf.9
        for <selinux@vger.kernel.org>; Mon, 01 Nov 2021 17:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wp3R+DkLsT+T3YFoaJRIQIAYG7GAntJAXplDMUWd84=;
        b=QtBmRWZR83NCW2csJHPlbE12FMx+9r1wlUflS7a1ivTNjOWkmht93vyMN+4cUmk7xz
         fI++ujKaX5Xmgic2PeRnf55VSeBcdPabRbOfUKwhlS8puywYcn5QxRXi0dM7BDOc4MG1
         S4lO208Qp7TtLEtNczYjepazrKZhJCYWvruSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wp3R+DkLsT+T3YFoaJRIQIAYG7GAntJAXplDMUWd84=;
        b=yrYjO6/EErD0praAvEZcdykj6lm7xx0beX7T9q5jFGT10CDTuW3gT7Ujte/7loSMej
         6PhyqWq6o6E04RwmLVXBiki6oHdVPzcaAQiH36pRYFoQ6b4N5l7jTL1NogNoGvsuushX
         QMxB5tC53EFFQMkwhG9ARRgyRL2aORCLLK9zZivTZOTntjL7l3id+9vBDHpAWgyjHs6L
         7esmjJN5wtF7Nk9eE4eswSOJbF8uMWLkvrXQ/YyOAZaAhcuWJl6i6dIWkHkRX4cs1h4i
         LzzPEuld0AiQomLzCGXMPDkHyh3wM5HZa1vwfV73q8nLKPfUHjF3UxuBYtb9/Ioh3Iqg
         Rmxw==
X-Gm-Message-State: AOAM533ddS+WJEIxtWML/gRT/WJ2T+K9cjYXWc7HxKf/4qxGqcVstar0
        zqqlpHpXxBI6K6AgsJGQUiraUrFpRoGDYrLS
X-Google-Smtp-Source: ABdhPJyZRGB6MC68LBoj2bvRsZoR9NnzNqwhraDtu88GjaUgiKHO3M4TEPlp8Zv2CeHULfe2I5P5uA==
X-Received: by 2002:a2e:9849:: with SMTP id e9mr34808522ljj.503.1635813896369;
        Mon, 01 Nov 2021 17:44:56 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id c24sm1540819lfc.155.2021.11.01.17.44.55
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 17:44:55 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id d23so30752879ljj.10
        for <selinux@vger.kernel.org>; Mon, 01 Nov 2021 17:44:55 -0700 (PDT)
X-Received: by 2002:a05:651c:17a6:: with SMTP id bn38mr34106005ljb.56.1635813895143;
 Mon, 01 Nov 2021 17:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
In-Reply-To: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 17:44:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
Message-ID: <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.16
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 1, 2021 at 4:59 PM Paul Moore <paul@paul-moore.com> wrote:
>
> - Add LSM/SELinux/Smack controls and auditing for io-uring.

I started doing the merge resolution, and then I noted that there is
no sign that this has been discussed with the io_uring developers at
all.

Maybe there have been extensive discussions. I wouldn't know. There's
no acks, no links, no nothing in the commit messages.

So I ended up deciding not to pull at all after all.

You really can't just decide "let's add random audit hooks to this"
without talking to the maintainers.

And if you _did_ talk to maintainers, and got the go-ahead, why is
there absolutely zero sign of that in the commits?

              Linus
