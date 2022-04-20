Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9604C433F5
	for <selinux@archiver.kernel.org>; Wed, 20 Apr 2022 08:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376899AbiDTIx6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Apr 2022 04:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351539AbiDTIx4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Apr 2022 04:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD1C53818C
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 01:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650444670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/1D2R34qiVyQjwlCavuy9y7NCqvh6G2g9lilJgP8R38=;
        b=X1n5tbmbOrvZH15WfYXl5GAV6vL/041ffvAtkLt7378dsSORdPiijg49FdgoEPtcc7PVhO
        abMAJ6rdiZBaXPKBl8APpn4Kfz+ZVW/8tpfEQjSPMrIXCw8jrPLKx3VvOwobrxtQlrqdsg
        CsXIwmidMoPqiU0eJkH5u/K+YKGd9QU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-5jPh60WAMSeGBZzg-e4hWQ-1; Wed, 20 Apr 2022 04:51:06 -0400
X-MC-Unique: 5jPh60WAMSeGBZzg-e4hWQ-1
Received: by mail-yb1-f198.google.com with SMTP id e4-20020a056902034400b00633691534d5so895806ybs.7
        for <selinux@vger.kernel.org>; Wed, 20 Apr 2022 01:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1D2R34qiVyQjwlCavuy9y7NCqvh6G2g9lilJgP8R38=;
        b=Ssu84rTW8ZpWG2ANqef6nHV03XZltSIj6mjqvyE6bqUv75Txoe6r7CGBcay/JY/KHk
         eb3yd/NwaVMfVoFFital1Pl6W+w9LM75RXqLRK79Nf8bGlanARDqyRUyt73gNfx/Bxpd
         XYpEhl5nIVoISZQwvcTHuVswpMK0LkNK214S3bcx6x9d2vSrRPRNrbMoMmTDA/vOSI5F
         8jB59OuOr/lsf1dPuBq9JJ9wRPxth8ckGmFX2+HLIYPOcSe6257yaBS8xus8cj5BsxRu
         snNuIN5GbAPCXAMQs3N0pZ/iHFzC5fVAwbKmtv1APiPY4D8IB+58o/Lr6vmg58s147OG
         Us2A==
X-Gm-Message-State: AOAM532HnnX2Yf50gdiDgUvJ/P7KAw3HYMCHU2hhm8gUxMb6re2YvNGp
        fBB6XmkxBZ29GsEJE0352tAdkPuxORErAOE4C5qyP7RFJp76PaNw+nCc4UE6UsDLxPLBSLaoW0X
        Rce81IRQ8u9vaw9DkKYK/vphISO09K5z5Jg==
X-Received: by 2002:a0d:cc0e:0:b0:2ed:7fac:4e08 with SMTP id o14-20020a0dcc0e000000b002ed7fac4e08mr19052960ywd.106.1650444666195;
        Wed, 20 Apr 2022 01:51:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyt91eIaQDr5C6EhTu9WyGaD+ZbhzwPTUG2zZfGzX09YGJn3usQteWkhQAyG52HozrJERRINTFeLcF9M/Acy3E=
X-Received: by 2002:a0d:cc0e:0:b0:2ed:7fac:4e08 with SMTP id
 o14-20020a0dcc0e000000b002ed7fac4e08mr19052950ywd.106.1650444665969; Wed, 20
 Apr 2022 01:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220413114734.1704750-1-omosnace@redhat.com> <2634e3d64c31ef611d93e2b13c03dbb542969426.camel@btinternet.com>
In-Reply-To: <2634e3d64c31ef611d93e2b13c03dbb542969426.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 20 Apr 2022 10:50:55 +0200
Message-ID: <CAFqZXNs22+2C=fKzey0BV-zgb8hvP_vQEgJW-FWNTDyRSyWULw@mail.gmail.com>
Subject: Re: [PATCH testsuite v4] tests/sctp: add client peeloff tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 14, 2022 at 2:10 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Wed, 2022-04-13 at 13:47 +0200, Ondrej Mosnacek wrote:
> > Currently the testsuite only verifies that SCTP peeloff works on the
> > server side. However, it can just as well be used on the client side
> > as
> > well, which isn't being tested (and actually is buggy at the time of
> > writing).
> >
> > To correct this, add a simple SCTP peeloff client and a couple tests
> > that verify that the client-side peeloff works well with SELinux.
> >
> > The new tests are enabled on kernels 5.18+, where the fixes were
> > introduced. While the fixes are now queued also for some stable
> > streams,
> > it's much simpler to just check the version against 5.18 and skip the
> > test for all older kernels.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > v4: added a kernel version check
> > v3: fixed uninitialized "sinlen" variable in sctp_peeloff_client.c
> > v2: rebased and resolved a conflict
> >
> >  tests/sctp/.gitignore            |   1 +
> >  tests/sctp/Makefile              |   3 +-
> >  tests/sctp/sctp_peeloff_client.c | 254
> > +++++++++++++++++++++++++++++++
> >  tests/sctp/test                  | 170 ++++++++++++++++++++-
> >  4 files changed, 419 insertions(+), 9 deletions(-)
> >  create mode 100644 tests/sctp/sctp_peeloff_client.c
> >
>
> Tested on kernel 5.18-rc2
>
> Tested-by: Richard Haines <richard_c_haines@btinternet.com>

Thanks! The patch is now applied.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

