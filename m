Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDBBC3F2D1
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 08:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D8721556
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 08:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XO4Yg6FT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgCEIQZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:16:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30927 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgCEIQZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Mar 2020 03:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583396182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VlQPrBcPMK+P+XCzcy7YF9yIpxglWPf/9POm2m0ZV+U=;
        b=XO4Yg6FTKPZ7EtxGDRfQKRZ48uBpDFD6j+RZiBPvq05ttzWnph/o5cdi4Mtg3J35ytKEQ4
        SdU7YsJvQHOzgHlFlEncs2MVVCUpTpx36GRo5moiedhbKww8MSwAnm9/YpHNU6JCFCoiLf
        GM6XKA6ZHGI8C5VD3iY+BpIUiTxZN9c=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-lr0rCX2XOjSgiSBrv7Mw9g-1; Thu, 05 Mar 2020 03:16:18 -0500
X-MC-Unique: lr0rCX2XOjSgiSBrv7Mw9g-1
Received: by mail-ot1-f72.google.com with SMTP id 1so2718644oti.21
        for <selinux@vger.kernel.org>; Thu, 05 Mar 2020 00:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VlQPrBcPMK+P+XCzcy7YF9yIpxglWPf/9POm2m0ZV+U=;
        b=Z0D1+HvOeQWz4LjI7DrKX0bl6dWhDaoBMpnZj06zFYqbvMV88w63KL43yHFex3PFCd
         tQO42TXm1eVlFpf1eqlWfzRhUWxlRrcWg4ZWY514kdGuQKB4QnLyrj6gQhadlGCRnx0i
         ceHwLLav1jdO7cdoFuVxuillk8uglSYsxT3XD6Yr8T9bqnFF90V4B81IVWWC8UXKgAOZ
         73QRZHk/oHnJFIU/X07sEqRNCTDZsMRPCeP3dpcLPi7ZE4NI1AtI8VptHgqkZq3xFCLw
         zHUUszcqZ+l1cdLuWYvS3R2/QoxjIhr6NAebtespykVmhdReKQuJkwwLnZWgHvz/xgTM
         +kHw==
X-Gm-Message-State: ANhLgQ3EHmCXTq4WeOnD/No08pVVzaEb0kvO8u70Az1s+9cZxO5o0lhZ
        R+Rqpmp/WJxgsoiBpG2j1+0Ikmd3pmGsdDb1w9yZReKI0GDstOy2pX2VHu+4G6pVvJmDG/rascU
        kz6l8N7co4qpemUOjn5BBIO7tN/NQR3CGGg==
X-Received: by 2002:a05:6830:1245:: with SMTP id s5mr2348745otp.43.1583396178180;
        Thu, 05 Mar 2020 00:16:18 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtTOyWMJYZNLUcWswcXTZaP7NoVOInu4TlcNJdVjE8LRLycxsXnhU7EzHRk0G+vTH5ZDAdzec8cNwDNZA2EU/w=
X-Received: by 2002:a05:6830:1245:: with SMTP id s5mr2348730otp.43.1583396177855;
 Thu, 05 Mar 2020 00:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20200303085233.137371-1-omosnace@redhat.com> <CAEjxPJ5XHa2JLMf_BmhHV=LNBUe7qgM8Le6_PMX=jYjGb2OXvA@mail.gmail.com>
 <CAGB+Vh4RVwSraAGn1caEXOvHySkmgzgAfV7aZ-pwWKeUVyV_ag@mail.gmail.com> <CAGB+Vh69hcAjRG7aoDbCO6RyATWFoOBzEBcAYyGRWWHkE9RSFQ@mail.gmail.com>
In-Reply-To: <CAGB+Vh69hcAjRG7aoDbCO6RyATWFoOBzEBcAYyGRWWHkE9RSFQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 5 Mar 2020 09:16:06 +0100
Message-ID: <CAFqZXNueR3tdjTUsNXgRCktL+NNH2RqirPPb32vGeVqPSY06SQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests: add test for default_range glblub support
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 4, 2020 at 6:18 PM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
> On Wed, Mar 4, 2020 at 12:11 PM Joshua Brindle
> <joshua.brindle@crunchydata.com> wrote:
> >
> > On Wed, Mar 4, 2020 at 11:54 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Tue, Mar 3, 2020 at 3:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > Adds a basic test for the "glblub" default_range mode introduced in
> > > > kernel commit [1] and userspace commit [2]. The test vectors are taken
> > > > from the original commit messages.
> >
> > I'm confused, I submitted tests at Paul's request. The patch is here
> > but says superceded:
> > https://patchwork.kernel.org/patch/11119909/
> >
>
> It's been a while so I'm just rereading mine, I also attempted to
> differentiate between MLS and MCS policies on the system running the
> tests so that they could run on the MLS policies directly (which is
> where glblub support is utilized), and I also verify the default (non
> glblub) behavior to ensure we didn't impact normal computations.
>
> Unless there is a compelling reason I think mine should be merged
> rather than this one.

Oh, I didn't know about that lost patch, sorry! Based on the
discussion in the rest of the thread, it looks like you are going to
repsin the patch with some improvements, so I'll just wait for that.

Thanks,

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

