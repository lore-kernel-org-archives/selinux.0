Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A226DC433E0
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 16:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7A32074F
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 16:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="X9zkASWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgG1QUS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730929AbgG1QUR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jul 2020 12:20:17 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3313AC0619D2
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 09:20:17 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o10so5573698edh.6
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JdZsT2eGwbAuU6cqrvpHfhhr/C0FiXQpjb+sn/9k/nA=;
        b=X9zkASWiHWpjw6+nfqculWmMqamRYe3jn+QpljCcE6rJCor63DWmNH8UXkREdL4LmA
         hX7JihkSmaISC2e90syV/nPflCE7AL7AEZ1Z+4EgWTRwS6F1oltQA5o7sllAVXXTtOjA
         tnNZaCWpLrx7cGQ4mcDqtAG5KnT7R9u8iYrT+7Wbanfa6AWhKysZe2sNE10Y9rEP3biP
         LvBFRmYStOgbfPGCMZ9tS3Prfl6Thygrao4u+wwHdIjNPHXgO0nNBDY8S2hpJIHWjH81
         RrqgQqigk8TbQaqyAGa5fi6b8NtKy46FAuTe4A877W2VO7H7x39HZK+YYKmAzGAmrUI5
         2vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JdZsT2eGwbAuU6cqrvpHfhhr/C0FiXQpjb+sn/9k/nA=;
        b=pFhrv6SJGG4qudtDTwZyTEjO5J7WfHUbxGh+Zt+aRnotBNvNDyyS/Oin1vfjNq2DHo
         e+ZvqTHwRYU0k6/DbKzuXLvczEBu9HPsNJcNgnjppAwUBOFdMtWAu26cszXH3dY6DEXh
         Xb/sugreqSiSTYeDLhF0rqAkFX19tqrQtRdws1e0vQDPIsZaPgwStl1JUt0vdo18I3oJ
         o7P51LQgrfjhRyknZ9Ntfu1qcXh+CGZeEwPvJXTQ2xOlWLI10nS7B904n8s6cJcFhrtl
         7qcRB5fvQiIbQCVyvEHOnVxqtwZhZTyhxkjYDncI0Z3m4UywLZVhK3gZpYds+rNSdWHX
         WD9A==
X-Gm-Message-State: AOAM533dldbPVqckeYvkTZYhz3FUs/p42Kbt0LFE9+tFhd4gzhT9BTfD
        tVD0jEVV9nRN3jD9bfqB9e+C2uuPxA5dSzg3faQM
X-Google-Smtp-Source: ABdhPJzz74dgHHHep+KqO57RY1mJjew1iG0Rr5CUV4iYLH0RYRsPHpC3OsJhrBq7IcV6icvPjOOe0+CBPJ68RFWRx0Y=
X-Received: by 2002:aa7:db10:: with SMTP id t16mr13033990eds.196.1595953215861;
 Tue, 28 Jul 2020 09:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com> <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
 <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com>
 <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com>
 <CAHC9VhT1sGSpfCKojbKR+O2Hf_h+wnKnBwwSo09CbFaCYLcOHA@mail.gmail.com> <CA+zpnLecz_gvXYnrwNGW8SLaJsu==M_n9MuJgjqX9nPJtuTZBg@mail.gmail.com>
In-Reply-To: <CA+zpnLecz_gvXYnrwNGW8SLaJsu==M_n9MuJgjqX9nPJtuTZBg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Jul 2020 12:20:04 -0400
Message-ID: <CAHC9VhReYQwxvHeJ8jAUKZ8P+N2yyGNN3rGRb_9t7hZpW=+HVQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 28, 2020 at 12:02 PM Thi=C3=A9baud Weksteen <tweek@google.com> =
wrote:
> On Tue, Jul 28, 2020 at 5:12 PM Paul Moore <paul@paul-moore.com> wrote:
> > Perhaps it would be helpful if you provided an example of how one
> > would be expected to use this new tracepoint?  That would help put
> > things in the proper perspective.
>
> The best example is the one I provided in the commit message, that is
> using perf (or a perf equivalent), to hook onto that tracepoint.

I probably wasn't as clear as I should have been.  I think it would be
helpful if you demonstrated how one would take the SELinux data in the
perf event and translated that into something meaningful.

--=20
paul moore
www.paul-moore.com
