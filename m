Return-Path: <SRS0=piI6=6W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EF8C38A2A
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 19:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5AA21841
	for <selinux@archiver.kernel.org>; Fri,  8 May 2020 19:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rtklb0uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHTyV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 May 2020 15:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHTyV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 May 2020 15:54:21 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE2AC061A0C
        for <selinux@vger.kernel.org>; Fri,  8 May 2020 12:54:20 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m13so2448415otf.6
        for <selinux@vger.kernel.org>; Fri, 08 May 2020 12:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qIqWSaZUAqAH/9SxkC/zSXsuhau0R6CtLFif6JBsLU=;
        b=Rtklb0uuGBSygkMbNuX91nJRV51zOeaP9nv0kg+5Wry4yYpU0JEve7H2/dZmWqtrTf
         WPTfq0wCV214XHLD5o9FoQ0z5+9fiXK3MgSYomdy15tZ1B1OwAU74vsSO6EfAd8gMv6i
         204qitbp4xg4bgyYkq9jq3/jtOTQ6TyQDxHO+qNVWijxEgOnnYRn/CunO5lJu2N4+ojU
         14l0VeYocpzzHqq4mT1gdbQwpAqp44U9MUeTOJqOFmUBccxtXi9LY5FkLKKSZFiqVkHC
         OBlbyQhI5uGtQWHSXnvXd//l/lts+7HeA4TsgzBj46sI3tU3VcTWxGENjkeWyafScwah
         Iddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qIqWSaZUAqAH/9SxkC/zSXsuhau0R6CtLFif6JBsLU=;
        b=OMpO2x8xe1zqx2ksIM4bScGGsCXdoPyP9lfBPpkx6QQ1i5+bY60KOOHnl9FWFhvqio
         meDbYqUn4sL1vTEWEG+xI+uZv5tsCU4ojd+ek+wt8CAa2K+JZgW1U4ry9JTvFn0btc5t
         tJLRBx3Y1WtNaYW9Zvn5X0+vwi+AMRzy7WU+kHm9qx43VohM87OTbpu+ROVK17D4qNGZ
         bqsjhHLjkzbXff4rjKmM2NYPNzzQNEDWj8Jl2LbDNtlpddaGSTefQVgETHKtAIiNCv0/
         IgxhGR2/ykfB3HJ6TG4VDAP+KMZDtWxNzDI5ceobSLnKcah9f33rkNjpjMJhyJZ9ifTU
         sRyg==
X-Gm-Message-State: AGi0Pubnw8vpREHJrVTMCQtdtyIlRYR0pvion2f6Y2VaXmTDH5JgcceV
        y4qJkQ+3QajEZ3B1Jhij3SphK+Gq9IVgFMj91ATxiS0lH/c=
X-Google-Smtp-Source: APiQypL1exagTz6UpckgVrRX1KkTvlBn7CH4/r4Dqm6sw9wKkvZ6KnnOuzb2IpL8+k816Vd6DxqreLmRsi1/ZklKQKE=
X-Received: by 2002:a05:6830:448:: with SMTP id d8mr3343374otc.89.1588967659213;
 Fri, 08 May 2020 12:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200508154138.24217-1-stephen.smalley.work@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 8 May 2020 15:54:08 -0400
Message-ID: <CAEjxPJ6F1x+hC1QK9eeaoWFp63Lk+qBLr9qJiH52xpok9C5ddA@mail.gmail.com>
Subject: Re: [PATCH v4 testsuite 00/15] Update to work on Debian
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 8, 2020 at 11:42 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Update the selinux testsuite to work on Debian and provide
> instructions for building and running it there.

NB With this series applied and the separate quotastest fix, I was
able to also run the testsuite on Ubuntu 20.04.
On Ubuntu I had to build upstream libbpf from source because
libbpf-dev was not packaged in Ubuntu unlike Debian
(https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1836708).

The Ubuntu kernel had two test failures:
mmap/test                 (Wstat: 0 Tests: 39 Failed: 1)
  Failed test:  2
checkreqprot/test         (Wstat: 0 Tests: 1 Failed: 1)
  Failed test:  1

These were both due to kernel configuration in their stock kernel:
CONFIG_LSM_MMAP_MIN_ADDR=0
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1

The latter isn't too surprising since it used to be the default and
likely just got carried forward in newer kernel configs.
The former is rather odd; not sure how that happened.
