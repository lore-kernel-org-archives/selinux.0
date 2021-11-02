Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84A0C433F5
	for <selinux@archiver.kernel.org>; Tue,  2 Nov 2021 04:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14DE608FB
	for <selinux@archiver.kernel.org>; Tue,  2 Nov 2021 04:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhKBEZr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Nov 2021 00:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhKBEZq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Nov 2021 00:25:46 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45986C061764
        for <selinux@vger.kernel.org>; Mon,  1 Nov 2021 21:23:12 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id e2so32706479ljg.13
        for <selinux@vger.kernel.org>; Mon, 01 Nov 2021 21:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hOI6QRrV5zRFm8op/6Gd1rEX3NwOtN92NhH17jVxu8Q=;
        b=h2hpRrDEtL2p/0jKnOT1ONm13DydLtzTwK16ZAknZGkNhW/tlObp6XIQd0rp6I341A
         udIAa9pOsmlDUrXTMYgQUcl7ZnA8e0LTW5Af4pzSEIriRhrOdTUbOSj46aJLK2hVIQJz
         gI+p6bpFk2SL46CZy+5Qhjmn1YVMC8AVmA9+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hOI6QRrV5zRFm8op/6Gd1rEX3NwOtN92NhH17jVxu8Q=;
        b=3NODMkCBSGbH3wnea2hnL1SuHkbw4fdgKq+GOb+ChzrVDJgtfwiHBAhnhMgvFEH0VM
         7k6LmXUw6DIHQ1MTSd78HNj2pIaZLQpnvkGuN/A+WRZQDFRi0AqvKkeUEstw1y0mUTNb
         x+PJb/CheAUMT3/c8b8yeeVAkLRSv7Ycj7yG3xdME3mPxSB57wdMDVeNXSbr//yLITFs
         VkOwb9M7O/UuNMtO5TKp8TQgjlpZiZMQou6VJQagx2UDXwS51QHYcMVs3EleRvnmuQN7
         1lfr8DJ/jM7J7X2fqTDyQr0NJj/EzenHMBplTlrA8Mrtd7W6QxvXslwCUubVu7C0G37U
         xtrw==
X-Gm-Message-State: AOAM533wi8AmM7rR3T/pAgjAFrYzwfDkTw1Id+9Rf7rbFrWicJWpjTUp
        sK4q/LpEOw3+KIWoju89k9Ol//hvkaS8yiw1
X-Google-Smtp-Source: ABdhPJzijJaEGlPOy8AYZHa0s0vXlg7lm1Lk5TwiLXxzIVqixVz4ZlvsQS2W855IScWqtbKT8Hkw/w==
X-Received: by 2002:a2e:bd09:: with SMTP id n9mr34157900ljq.40.1635826990321;
        Mon, 01 Nov 2021 21:23:10 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o7sm9122ljj.136.2021.11.01.21.23.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 21:23:10 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id bu18so23189089lfb.0
        for <selinux@vger.kernel.org>; Mon, 01 Nov 2021 21:23:09 -0700 (PDT)
X-Received: by 2002:a05:6512:10c3:: with SMTP id k3mr32858764lfg.150.1635826989429;
 Mon, 01 Nov 2021 21:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRJ=fHzMHM6tt8JqkZa4bf0h72CAytSX9YrEs14Oaj8SA@mail.gmail.com>
 <CAHk-=wj2LqbZ3xSLKfnR42y7ZEgqw8K42-mE+nsHwsoFiNNpKw@mail.gmail.com>
 <CAHC9VhS3LfGvuVyXW5ePTQNtQ0KeQ7vz3wLinoZrbGVjU6GuoQ@mail.gmail.com> <CAHk-=whvZRaJSXirjcWKn75H-2H1tc54cru8p-vXE_2UyuvGNQ@mail.gmail.com>
In-Reply-To: <CAHk-=whvZRaJSXirjcWKn75H-2H1tc54cru8p-vXE_2UyuvGNQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 21:22:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0fNVO9tfEmWTcW7i+HoN4K4PejZ44sQYCEfL1S3UPWA@mail.gmail.com>
Message-ID: <CAHk-=wj0fNVO9tfEmWTcW7i+HoN4K4PejZ44sQYCEfL1S3UPWA@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for v5.16
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 1, 2021 at 8:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This follow-up was sufficient. In fact, the original should have been
> sufficient for me.

... and as you saw from the pr-tracker-bot, it's all merged now.

Sorry for missing that part of your original pull request.

            Linus
