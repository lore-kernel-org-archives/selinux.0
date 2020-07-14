Return-Path: <SRS0=WW+a=AZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E919FC433F2
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 14:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3375208C3
	for <selinux@archiver.kernel.org>; Tue, 14 Jul 2020 14:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mr7Rr8Qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgGNOkv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:40:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42507 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729399AbgGNOke (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jul 2020 10:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594737633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DD6pS3c9+3TLnow5w+xUjQpFZeP3PmWH/8jTyt7Pkzk=;
        b=Mr7Rr8QkToJK+tlHqX3h8MPtbBdrDSxshne3bfr0ops04BMz2tzjyHS7Lk0D6PIvo4KNYT
        tMEIEOg++Dkp2EdaNw22YbJRvkZdHPzFeCLbMxvZkENae70smyE1LjQA/Qmxvz2QPE5onV
        SOsHayCf4+h+9zzlqMrIpqbA+kL3HJc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-u1V8H93QMdSs9AG01RVWPw-1; Tue, 14 Jul 2020 10:40:32 -0400
X-MC-Unique: u1V8H93QMdSs9AG01RVWPw-1
Received: by mail-lj1-f200.google.com with SMTP id h14so14426931ljk.7
        for <selinux@vger.kernel.org>; Tue, 14 Jul 2020 07:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DD6pS3c9+3TLnow5w+xUjQpFZeP3PmWH/8jTyt7Pkzk=;
        b=fXgmad/F4Hwdj7gisDkx5EwgKv/nwgn37nWKjjO39OPNKYGeDs5MpJpHQzDQBLAyva
         UG0XOv5qiDobqyP2+7XlYoocB4te+v/K0bOuSU2d4GlpsEk9//2yp2MqyY93JCHZmgHx
         0bYVnxNY4FkAKyTlwNdgsHMvXN0FDHTbuewBYG+oll5cXhnOKoMElBf3qp2fFv+fWqxq
         RCVfWIkxf55UC7r7nbo7KD71p5EheWtIzakG7HSWjaQbCuSxhN8WyedfuhQe6ob91l6H
         Cs2DXkqyeqPvuwSIWc8uZ5IBa39z1M9X3/BhyDuFGp6agyIdbOMQAXP5TBuiUC1wdyI3
         nkaA==
X-Gm-Message-State: AOAM532La3seFuphXW0IHrvw6weqW2mkBRVuikAEjCQ29UdYLVxLdPM3
        H6uNO9199WFQvGTZc19EPDJ1gxBsRT/tESc6o/jtliUALLnU42zSj9UhKNUS+qrRIOOU1WEzxVD
        +Cbta0zQ30n7o4P4JJEUtoJvYUcJ9QToNtw==
X-Received: by 2002:a2e:91da:: with SMTP id u26mr2574384ljg.311.1594737630420;
        Tue, 14 Jul 2020 07:40:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyp/Q8z3C+XhGeAhpM5L9bizdmed6ELNj7l5bOOoN+60fZiBhxTklgJwY6Gns8TGbz2E3NJsNE7ERfvhLQrRUs=
X-Received: by 2002:a2e:91da:: with SMTP id u26mr2574371ljg.311.1594737630237;
 Tue, 14 Jul 2020 07:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200702143508.24143-1-richard_c_haines@btinternet.com> <CAFqZXNt9BHra05Xuj6U7uMe6Qyf-Et65qWMCOqLCBp4hiXAB=w@mail.gmail.com>
In-Reply-To: <CAFqZXNt9BHra05Xuj6U7uMe6Qyf-Et65qWMCOqLCBp4hiXAB=w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Jul 2020 16:40:19 +0200
Message-ID: <CAFqZXNuKHxsPO4+NZJNQ3R_EkgM3-a=Dp35-Zpy+_HT_Hv51pw@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Remove unused sctp code
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 7, 2020 at 4:50 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Jul 2, 2020 at 4:35 PM Richard Haines
> <richard_c_haines@btinternet.com> wrote:
> > Removed obsolete code that was used to test permissions that never made it
> > to the final commit.
> >
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  tests/sctp/.gitignore          |   2 -
> >  tests/sctp/Makefile            |   2 +-
> >  tests/sctp/sctp_set_params.c   | 205 ---------------------------------
> >  tests/sctp/sctp_set_pri_addr.c | 135 ----------------------
> >  4 files changed, 1 insertion(+), 343 deletions(-)
> >  delete mode 100644 tests/sctp/sctp_set_params.c
> >  delete mode 100644 tests/sctp/sctp_set_pri_addr.c
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

And now it's applied. (Sorry for the delay, got lost from my radar...)

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

