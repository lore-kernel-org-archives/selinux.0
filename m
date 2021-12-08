Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A27C433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 20:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhLHUXy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLHUXy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 15:23:54 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02A3C061746
        for <selinux@vger.kernel.org>; Wed,  8 Dec 2021 12:20:21 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x6so12403294edr.5
        for <selinux@vger.kernel.org>; Wed, 08 Dec 2021 12:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DC2So0tBLVOasQ2mSwN4jS/+mBtOgtbKD89KLwIzmdc=;
        b=wapDv8BfEI4D7ZY6/MGGOYOb8myIk3noRahusmIuLSCnRfE3Ym4fvfWDq75GD+jNLh
         4xHTQ3yDoMwyMhNSxL3ip9kg3yQ9AzWWIRpw58ucWAsaTwCHbDg0Z+wkZWBC6iCxLRwG
         2Z3adv+iWPUPbO8iUFb/i1p3wVohaq/noz8hlSTehysvXGx1lvrEyxXagdsaKhiSKzJa
         kIouHpz2b6jGmRjJg6oXYwLrYr1qF3HZDwBu4KXtX227A9E1ddQYFD6r75WaSmAim5zs
         b81bE6QndPCvxeyVfLZGyZw/Bx3EuJnweRcw9orwbD5UFCYBP4S3AYiKiTvCO96UWZh3
         qLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DC2So0tBLVOasQ2mSwN4jS/+mBtOgtbKD89KLwIzmdc=;
        b=u0U5asoAUM3L+CCrR1XKUtjkwe+PwHbJubUrzXfcNFlTJix1I9ufQByVlecP5aPYWE
         C+KpREOZUkrfeoGkh5u0GOxQpo9hCBuTVEknDar2g3whNQLm9xElt7dbWzz+265UznpC
         Vzicj+wIg2BX+EZurP0T3P/u9ijTZvvPm4npeeR8gp0IH8rF1w0q2Y0aT6XTH5YSBEpf
         zEDKW27GjJelvuw4mbHJZR0yxoKebSRTOi7qHSByBhttGXLAlxyfCr32jn/xs99a6te6
         8/+mVxIfKY77tAE02Sfah3FyE8fU4Osjr8BoTtYqdEbXPAxzx3cX4qxNhl55VxqWltTW
         L3sA==
X-Gm-Message-State: AOAM532hqP6wcmbHmqwJdie+6NZ29qA+qpQfyAjFeh/MhWcIZQTYkQWI
        k419wy4pJ6Hp/Vyxc6W3dpgHKah4/BnbcKAP29ru
X-Google-Smtp-Source: ABdhPJwpGwb5qyLx/Xt3QDb6FXK+0xmFvbLXj/4J9/j6wq3tBYOnq9+kVjWw8Du1Qi67Kf88F4wkgRvS7InRshdSquo=
X-Received: by 2002:a17:907:868f:: with SMTP id qa15mr10071115ejc.187.1638994820115;
 Wed, 08 Dec 2021 12:20:20 -0800 (PST)
MIME-Version: 1.0
References: <20211116105335.21864-1-toiwoton@gmail.com>
In-Reply-To: <20211116105335.21864-1-toiwoton@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Dec 2021 15:20:09 -0500
Message-ID: <CAHC9VhQXDdnvE=Cc_4FBJMapmcAj_kNA134mE83Yw31rDvwJcQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux-notebook: New chapter: Hardening SELinux
To:     Topi Miettinen <toiwoton@gmail.com>, dburgener@linux.microsoft.com,
        dominick.grift@defensec.nl
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 16, 2021 at 5:53 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Describe some easy and more difficult methods to harden SELinux
> policies.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>
> ---
> v3:
>  - Updated with comments from Daniel Burgener and Dominick Grift
>
> v2: https://lore.kernel.org/selinux/20211113095547.19406-1-toiwoton@gmail.com/
>  - Updated with comments from Daniel Burgener
>  - Fixed issues with PDF generation
>
> v1: https://lore.kernel.org/selinux/20211112125605.28915-1-toiwoton@gmail.com/
> ---
>  src/hardening.md                 | 205 +++++++++++++++++++++++++++++++
>  src/implementing_seaware_apps.md |   2 +-
>  src/reference_policy.md          |   2 +-
>  src/section_list.txt             |   1 +
>  src/toc.md                       |   1 +
>  5 files changed, 209 insertions(+), 2 deletions(-)
>  create mode 100644 src/hardening.md

Thanks Topi!

Daniel and Dominick, what do you think of this latest version?  Would
one, or both of you like to tag it with a Reviewed-by?

--
paul moore
www.paul-moore.com
