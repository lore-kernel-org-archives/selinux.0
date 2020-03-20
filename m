Return-Path: <SRS0=Veyl=5F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E45C4332B
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 10:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6032C20739
	for <selinux@archiver.kernel.org>; Fri, 20 Mar 2020 10:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnPoUGup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgCTK6W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:58:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27322 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726796AbgCTK6V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Mar 2020 06:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584701900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cUY99P5AKtg6SpOpKL2xCfjvzunsmGBvVhUliXwUY7I=;
        b=TnPoUGupsaVqqCdhnTQI0DZdgcEmVJF9o1KTvW34fnPFiIrc/2CutB9tPmrW0/ZbcWyyoE
        jb8RBP/Hkldw2clOL6V1c/he7N+52ZyxsxKdXoAnPsBDpwVaij6+TVHItNIZBhQitXT5hK
        qfu1iC3x+ylKEfXDYlB59P2zZAke1Rs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-vKFB_C-COYWhQaLIYLBR8Q-1; Fri, 20 Mar 2020 06:58:19 -0400
X-MC-Unique: vKFB_C-COYWhQaLIYLBR8Q-1
Received: by mail-ot1-f71.google.com with SMTP id 22so3529411otg.21
        for <selinux@vger.kernel.org>; Fri, 20 Mar 2020 03:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUY99P5AKtg6SpOpKL2xCfjvzunsmGBvVhUliXwUY7I=;
        b=LHDkif6Jzuuysav/SOOpoCC8CbUZpJFzdzwf6Rp1p5xaY5p9+gy65VoFpH47XIAks+
         uA70IGSzxtg//n48R56xGwotV3eWnUjyHl1ySRSo8ILwCJzP+zJzFe1lqkiGzBxDU8Rn
         GqxbRWNko7IDE3Y9UsmlM/KpGsluyDzDJ9SpEsQomQuihc/aLT9CGOsfuRIMBW568MvX
         Nrjok6wdNNhIMEm7XwHCqBA0EwI8oI/I9cK50tby1WYqylouq6A4SFA5F+iRcZQG9ciw
         sFUBY5fWt247mTQqLu9eaclnpOaJulf0ir+4KOrEnP+JUHiPrJbPC/XOrDDyUXdF+NvJ
         ymSA==
X-Gm-Message-State: ANhLgQ3f35ucDq5ZRVcTD037l5PHtjFmPWiV/zmpOm3f/cG2/TqdLyRu
        QsmQJjn17izkv+KRr/sBOp6WXRFZxT7qQhfhVGT4vBIRarWTtHRjlA90WsoUK2JLYyDzCralDSF
        8MBcdJBxtsWkIZFanC3AvLMEmCkP0LOqYlw==
X-Received: by 2002:a05:6808:16:: with SMTP id u22mr5934570oic.127.1584701898413;
        Fri, 20 Mar 2020 03:58:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu6YaznDTphqJ5Z1zg7b8g+jb43+tgdaZdhu4I9o93bU/iOnWmfStnor7IdLBYN9tLPY+OAlmVNGTflF9Vd4yA=
X-Received: by 2002:a05:6808:16:: with SMTP id u22mr5934557oic.127.1584701898196;
 Fri, 20 Mar 2020 03:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200312084001.101645-1-omosnace@redhat.com> <CAHC9VhSD-mLS8C1f+n+8F81ed4nSonWmj=gdDT=YGsG9gm0Cqg@mail.gmail.com>
In-Reply-To: <CAHC9VhSD-mLS8C1f+n+8F81ed4nSonWmj=gdDT=YGsG9gm0Cqg@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 20 Mar 2020 11:58:06 +0100
Message-ID: <CAFqZXNtDThnLeSvZLc193u4knBGBgyg9t0-kksg_Pd2q+6M6Lw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/bpf: ask for unlimited RLIMIT_MEMLOCK
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 12, 2020 at 1:36 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Mar 12, 2020 at 4:40 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > Currently the code sets it to at most 128K, but this is not enough in
> > some aarch64/ppc64le environments. Therefore, stop guessing the magic
> > threshold and just set it straight to RLIM_INFINITY.
> >
> > Fixes: 8f0f980a4ad5 ("selinux-testsuite: Add BPF tests")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  tests/bpf/bpf_common.c | 16 ++++------------
> >  1 file changed, 4 insertions(+), 12 deletions(-)
>
> I have to make a similar fix to the audit-testsuite earlier this week,
> I didn't think to check the selinux-testsuite because the bpf tests
> were running just fine on my aarch64 test system.  Sorry about that, I
> should have checked regardless.
>
> One small style nit below, but otherwise ...
>
> Acked-by: Paul Moore <paul@paul-moore.com>

I went ahead and applied the patch, thanks!

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

