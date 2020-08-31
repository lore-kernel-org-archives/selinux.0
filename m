Return-Path: <SRS0=sjmt=CJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C09DC433E6
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 14:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA3120719
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 14:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMqXPtpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHaOOJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHaOOI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Aug 2020 10:14:08 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE913C061573
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 07:14:07 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id 4so73411ooh.11
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2cLP7APgM0SA0TSn4ATybvrajMjlKvQP2RMt8oDfsg=;
        b=AMqXPtpiDMGhsVYQYZ7ntn2fcWF/clm+Tv8Ik53ynGy0uFvLvZBFjbkNo1gXTXUagp
         O8u65B46l8O4PkSAi4F4neqKFaXtCe9eqKVrGay753k/zwjCCvjdgogNYi4DlKAcql+J
         YD6Etp9gJHJ2kSRDVf1bypC5+l0hXXgfMH5NJLdk2z7YFyVkK6s/75ujNwytnvmdW7eL
         SOHFbWf5JqokUH0nm17SYlykqrtgPs1cMHTE5PsM6O8VOG1wAkVMepEPCIWj/XioV9TV
         OygiWd+2EV/whGvzokOY3EPIHIIR4uUh0jmlf1xkB7jFibnZmD440lqVPt4x4FzawNkJ
         04iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2cLP7APgM0SA0TSn4ATybvrajMjlKvQP2RMt8oDfsg=;
        b=Yv67OOkHmJR0/zJCFr2CidoWa+37ZKKo/aRYSjzAI25Bp/5/PzRfAzTgW4kc87EkR6
         f/u4naLT8CUFtZD01Io45cf8Jvqxnfjy0caBVFSxRmD2UjMiHPEWuUOIKneE7zP1u7ZJ
         MMnp7f7RH5KLncsRvzS9x9cdfpV6HKGxMEgAR+3AnmyktUmCATwADVHwCefnBWnZv5ug
         Rh0dD2fidts3/bNbUkd/AoobIq3v0Sb4rnQ42r+cC5wZrxOlMrFV8GZ4KVzut7Z6M6lU
         6jlQKATlYyINaZFabTBjeFK0sGmlV+uhGTZ7tauwTm75GmLMVESsLGwUANccCVV789fY
         XDfQ==
X-Gm-Message-State: AOAM533xk4m8habNG9hJMmiRdjc59E9H1kipXtKuKob2jNE7BlPOFq+a
        KJKbvJ4dfZgpcuitXsM7sFnNuiDnABt0yYzQgHmpANYkp5g=
X-Google-Smtp-Source: ABdhPJyB5xIK3ACgjrneLmjp9XpTtioqnFp1E92QOA/+J3jckhVMEqXrUhpxNcg/GzkuKsQ1sRQHfToJUoXwOh1a+2I=
X-Received: by 2002:a4a:dc44:: with SMTP id q4mr890008oov.71.1598883247403;
 Mon, 31 Aug 2020 07:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200827083017.1956255-1-omosnace@redhat.com>
In-Reply-To: <20200827083017.1956255-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 31 Aug 2020 10:13:56 -0400
Message-ID: <CAEjxPJ60A==2EgwsiyrbtgBSRQ4G25HWyax+gfdfEsmm+kU0Mg@mail.gmail.com>
Subject: Re: [PATCH testsuite] travis: add nftables to dependencies to run
 more tests
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 27, 2020 at 4:30 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> It is omitted from the official dependency list since it's optional, but
> we want to (try to) install it in CI.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by:  Stephen Smalley <stephen.smalley.work@gmail.com>
(likewise, feel free to merge yourself)
