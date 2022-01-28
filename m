Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAAAC433EF
	for <selinux@archiver.kernel.org>; Fri, 28 Jan 2022 01:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiA1BdO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 20:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiA1BdN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 20:33:13 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585ECC061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 17:33:13 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ka4so10536664ejc.11
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 17:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wsZdLbIW/wSzN5SU1Y3nKG1dD1P3LZwkgPIjEA0rqbA=;
        b=z4/psKfdEQun9iiJwaLqpcqkM5wbIEgd6Z/JfiIg8F9v6zMSGL/cy+sppTPyPLWXrZ
         G3brOdoiRDTjB3Q6qwPygLudI/HfAHrb3cYFyEWvYKg1t/wAbmKa1NJeDPe3a0fzwF88
         2L7gmRKKdxj0lerHpcWhz8oPsTuSw323H5srF/DR1OXj9nTVGJ0oNB02sM9aQ3OnOAZC
         2Ow1k24UEkv0ueaJqt69L5Y+uDN4/f6KaSRyP+r6NoXyt2n1DnkdtzClC/nb+uyMQSJx
         UNfnMgI7lJ1YxOzHcGg2kRONEfrzkL38TFlDZNRGB5lund9snzCD/S5w5VNomXDQY4fW
         5UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wsZdLbIW/wSzN5SU1Y3nKG1dD1P3LZwkgPIjEA0rqbA=;
        b=3lvUXpE6S8G55n505crwzwLriP1mOGOQLm2aWVWSbcL/hmnQVt58/JCpKBG1CgdJb7
         bxOrJZTEksRQaw7FJd3lVpSufEbqz/uZ8cLl5Au5ps+gt/82B8q1nXW16TqMukc/85Nb
         YY+RN3bZCwQufyMH7nC3fQvvyOuLEp2Bny+7774+IYRRdEg2QjfQ26hJs2K/4qxa5CEn
         mwuXmwDQXaHl/djfNwag74+MSQ1XLHyin7fH5x4YN9B+k7s4DZUCovIUqpxJ8WR3ognX
         pXVpFXmoQVAth0ezlMGua97To5beeV5L5oMpB3qDU/ovvNwr3Xu6HS2pWn6kG7Dzaefj
         R8lA==
X-Gm-Message-State: AOAM5303L3qBlLzbTFIoU3H8Mvpz8fxpv5e70iwhwWrUcd//79vl8idz
        +bOoO+hIfHTU4sblZpA+9i0oT8jB0i7zy/uuPL0yJzd3KQ==
X-Google-Smtp-Source: ABdhPJzQnpRrInzlXwKx944v3t7oK+afMgo48ACeIpRhpqmma4yngFl00fIe1O2HC2OVRwX46hXBeyJAfWrxRknPBpg=
X-Received: by 2002:a17:906:1e06:: with SMTP id g6mr4953642ejj.517.1643333591076;
 Thu, 27 Jan 2022 17:33:11 -0800 (PST)
MIME-Version: 1.0
References: <164330770248.138929.14950299877825278226.stgit@olly>
In-Reply-To: <164330770248.138929.14950299877825278226.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Jan 2022 20:33:00 -0500
Message-ID: <CAHC9VhSAd8ctu0nbQ7xiK7WfHOmbf5v2MJbKkHkUoBX4NJUWsQ@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: fix a type cast problem in cred_init_security()
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 27, 2022 at 1:21 PM Paul Moore <paul@paul-moore.com> wrote:
>
> In the process of removing an explicit type cast to preserve a cred
> const qualifier in cred_init_security() we ran into a problem where
> the task_struct::real_cred field is defined with the "__rcu"
> attribute but the selinux_cred() function parameter is not, leading
> to a sparse warning:
>
>   security/selinux/hooks.c:216:36: sparse: sparse:
>     incorrect type in argument 1 (different address spaces)
>     @@     expected struct cred const *cred
>     @@     got struct cred const [noderef] __rcu *real_cred
>
> As we don't want to add the "__rcu" attribute to the selinux_cred()
> parameter, we're going to add an explicit cast back to
> cred_init_security().
>
> Fixes: b084e189b01a ("selinux: simplify cred_init_security")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged.

-- 
paul-moore.com
