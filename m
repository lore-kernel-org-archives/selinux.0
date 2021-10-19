Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04914C433F5
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 16:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB6860F9F
	for <selinux@archiver.kernel.org>; Tue, 19 Oct 2021 16:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhJSQeU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Oct 2021 12:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJSQeT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Oct 2021 12:34:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E54DC06161C
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 09:32:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ec8so15271474edb.6
        for <selinux@vger.kernel.org>; Tue, 19 Oct 2021 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xUa4jDp8wEq2+KyjYLUoyDAf9haNG/CAH7QLO3lCFg=;
        b=Rk3hPiN1Cgn4j+zmGpM0dENIhRnzhwt3kwrJw0dXrtwRIVtz33CBjd1xw9nFoz4Y54
         orSrK+/3veW61o8sx5I9LiM2oX+VL9+WV8tNCkfSFeACCFxjFpO8cuGdJWAtcl/R/iyd
         JSllRqHrbTYt0SodjJZCokHVxZoY+roP3verKxSMGZha5nDo8UundCHVvMKz1yLlLX+A
         Yv2x2RPOb7INYdlisfjqVAAnylzMCH1JejmnWqjvrI9KZfd5Z+AdFC3UQVR1xC3YrEtN
         +oo8OMgQVykkiHbVa0UEw91IZP1jygwfZXxmIv3yzPWsmS4pbb1XvJ2GC/68Aw6XihBt
         Rcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xUa4jDp8wEq2+KyjYLUoyDAf9haNG/CAH7QLO3lCFg=;
        b=PBsHRSrdoeoGxbsKBvpFC34ULRli5IBvnQHJyOX2bFdFsvemUNz1u+WtaAz5Bj4Nfs
         f63SWtj9gPmXnVbLFofHkDsnccZVt3Y5HLN/Ew6JEpZdV6ObHF1acl5bVnXvhUbEZl0W
         yWpLkuUyNh43fCscyPfpQ9GQzecqhducKWtR8WZmg3QTcoqnUsFeXUnlURg9qFCZgIg3
         vQA7l5C68g9e7CfSv5UrYBPvQ8sof0zW66s2HjY8qfCp1IWlo3N2SQ68GrADbqUEGfqT
         6znGvaI22QnvIeEMtfV+ddaiVryCsBr6QNm/z1wAavty5B0yi7wpWUfaZwbEwt3naXLG
         NQZA==
X-Gm-Message-State: AOAM5323F05CCEnubOFqDW74g0Uux1GeXxgtzcQd48vynYkAgziA9uyn
        RAgcZThmbN46uIRFJCFpEurFAqL3lBiNWeoJ957N
X-Google-Smtp-Source: ABdhPJx2DygXOAUIL+ZmjqAeaXSLbDoYpIDmg/VlX8my35/hQmEKkmgE44G+Jhusz2tWvG+Y9ihUjD2QYXGPH0taDhY=
X-Received: by 2002:a05:6402:22d6:: with SMTP id dm22mr55776304edb.209.1634660962615;
 Tue, 19 Oct 2021 09:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuY3BJ9osvhwg0-YG=L+etgCBfCq0koC9BEkvK8-GR3ew@mail.gmail.com>
 <20211019131049.GE28644@breakpoint.cc>
In-Reply-To: <20211019131049.GE28644@breakpoint.cc>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Oct 2021 12:29:11 -0400
Message-ID: <CAHC9VhTobH9ExRt5fLx+S9ibRipeA4pj8yFhjDKb0Buq6naD5A@mail.gmail.com>
Subject: Re: [next] BUG: kernel NULL pointer dereference, address:: selinux_ip_postroute_compat
To:     Florian Westphal <fw@strlen.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        selinux@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Eric Paris <eparis@parisplace.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 19, 2021 at 9:10 AM Florian Westphal <fw@strlen.de> wrote:
>
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > Following kernel crash noticed on linux next 20211019 tag.
> > on x86, i386 and other architectures.
>
> Paul, this might be caused by
> 1d1e1ded13568be81a0e19d228e310a48997bec8
> ("selinux: make better use of the nf_hook_state passed to the NF
>  hooks"), in particular this hunk here:
>
> -       if (sk == NULL)
> +       if (state->sk == NULL)
>                 return NF_ACCEPT;
> +       sk = skb_to_full_sk(skb);
>         sksec = sk->sk_security;
>
> state->sk might not be related to skb->sk.
> I suspect that this should instead be:
>
> +       sk = skb_to_full_sk(skb);
>         if (sk == NULL)
>
> See 7026b1ddb6b8d4e6ee33dc2bd06c0ca8746fa7ab for the origin of this
> additional socket pointer.

Sure, I'll patch that up now.

-- 
paul moore
www.paul-moore.com
