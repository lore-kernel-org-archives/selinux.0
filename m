Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C093FC433E1
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 01:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D0D2078D
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 01:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XxgsNqxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHTBVn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTBVm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 21:21:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F44C061757
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 18:21:41 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a26so695213ejc.2
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 18:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clSRpeeAhBeOa1Z/EGoW+BCJ0W1c3rpm/3iMv3CQBEg=;
        b=XxgsNqxMJXLMCQt0hvVtovYPMv5lUeVtNbekV18RPRgTSr0lhWryi6qkLfR94gGEFA
         PztV185NnjB+IYrEZe/xikgYrOfWzJcB4lRxCVUsGayaD7bm8YHeNDsf/DamWw8BVs2k
         +C5RLMsYP77t9xELeLr7BZ8TE9RPDTxUtbOCnIfrcwrBw8y3WSH+0ZHY3lxyoFNYInmd
         TDJMfUOKVrH8E2/fkwXZ0LCI2QSnPDsF872t5RLF6bYhssrqv69dNmVY8+Eghelm3/l9
         teR8GTfWk0l6Uls7pTmAylPqw9UetBvz7mVqC+Lfnnr+ldA5FBptPQ9RJUdzYhBT78hX
         yNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clSRpeeAhBeOa1Z/EGoW+BCJ0W1c3rpm/3iMv3CQBEg=;
        b=e5XhkSDeFlzgZShWiCDPfoPesRM0PC8207BoIu/zY+EqH8G+KnWyxNiw+0p4ijo0xl
         u5Djz0IIrieWGCDPBPBT+4MpAHN+emc6yLlHY21zct1Jz3KCW7GqBrLnvtwXbcLrM6GW
         8txg2qvoRh9PXvktgSDpZ0XPYdJpFni/5xGRy/nBR+BM6thx7b3Mi/52ESwviCprMIhy
         vk5DoL2TMwXPJZJ6KtbUK88u0YFS6b3mxkZkjmqyeAM470eySu7/JlyAY0jn2iDoNKIT
         6B+EOwD4CChr38praM+B1FXbYH5I1YcO0guPKQdQqT0dvQGcOTW8MIwRm2F3Ov3T1jzP
         1mgQ==
X-Gm-Message-State: AOAM532/47MOFwqBENWpZAhkWQkxTxI2JPf338MpYmtN1iPVNchet4/p
        vsByEmEGYnII7Oh9tBgy3TdW1ZHZBJjjN5VI0o2D
X-Google-Smtp-Source: ABdhPJy5YCNpJnv1Y/CpvGqmyFX6PcYJ+U9KLCqrkT4JqKRby0aWCLgHjSuUt8brRGEdtFouaOnueCCnkewqCmUMGeo=
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr998580ejb.91.1597886500276;
 Wed, 19 Aug 2020 18:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvdAUWHw7SUF6Da1bgDJ2Q=59nJLovrxz8Ke74DSFnG1g@mail.gmail.com>
 <543834b1-9e7e-187d-4f98-e8484362105b@gmail.com> <CAHp75Vf_3cb51UPXqiPspo4pa5AhU7xTvwAk6Z2+FtzNfmogDA@mail.gmail.com>
 <fdffd8f2-ea67-4bfd-f75b-9ffd56dfbbde@gmail.com> <20200820083111.46e81b4c@canb.auug.org.au>
In-Reply-To: <20200820083111.46e81b4c@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 19 Aug 2020 21:21:29 -0400
Message-ID: <CAHC9VhTR7b_p3rdiQ8q07OMoY3fXgU4kH=bH5URVgVS6kH5r5g@mail.gmail.com>
Subject: Re: Linux-next: Kernel panic - not syncing: Fatal exception in
 interrupt - RIP: 0010:security_port_sid
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        X86 ML <x86@kernel.org>, selinux@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, rgb@redhat.com,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        YueHaibing <yuehaibing@huawei.com>, jeffv@google.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 6:31 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> On Wed, 19 Aug 2020 11:12:44 -0400 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> >
> > Fix can be found at:https://patchwork.kernel.org/patch/11724203/
> > <https://patchwork.kernel.org/patch/11724203/>
>
> Thanks.
>
> I will add that to the selinux tree merge in linux-next until it turns
> up in the tree.

FYI, I just merged that patch into the selinux/next tree.

  commit 37ea433c66070fcef09c6d118492c36299eb72ba
  Author: Stephen Smalley <stephen.smalley.work@gmail.com>
  Date:   Wed Aug 19 09:45:41 2020 -0400

   selinux: avoid dereferencing the policy prior to initialization

   Certain SELinux security server functions (e.g. security_port_sid,
   called during bind) were not explicitly testing to see if SELinux
   has been initialized (i.e. initial policy loaded) and handling
   the no-policy-loaded case.  In the past this happened to work
   because the policydb was statically allocated and could always
   be accessed, but with the recent encapsulation of policy state
   and conversion to dynamic allocation, we can no longer access
   the policy state prior to initialization.  Add a test of
   !selinux_initialized(state) to all of the exported functions that
   were missing them and handle appropriately.

   Fixes: 461698026ffa ("selinux: encapsulate policy state, refactor ...")
   Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
   Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
   Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
   Signed-off-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
