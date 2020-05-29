Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B82C433E0
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 15:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80DA206E2
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 15:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx+Eyyyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgE2PfD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 11:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2PfD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 11:35:03 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB05C03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 08:35:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d191so2881377oib.12
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 08:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q9+sv2k5niwLk+4mz/OCdB3ZLNluHx/qvzRShe47uP8=;
        b=Jx+EyyyrDX3Q/kEtN8/VRhoNcv9aqI+GzzvdK958Jef3iveFWJtm3U0JCvdMdl0dA+
         4N2oDTU6sWfVh2K9vY81y/aX2on4Z3NIj+It1EsrI+3J5al96hKQPIltefxhXjrV85HT
         C0FqxVLsCwh1Dc0gCl1VQrLTIDgVjeE6TuNjqpqbGTxMSGGflCYOj6PPWIim6fCZnSJC
         AzzvNKIha9adtwjOGQUzgFkoCtqRnOF7i8BZQS0w9axiaMmPQ2Ofd3SQEolhyEM6XiC9
         RG4jgzqzU8woW0uCw2nIE38r2a+5WSpSfbS9Q9x1Vo2Yd/2dxGleVhhrkF0o7vlKNoxD
         hn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q9+sv2k5niwLk+4mz/OCdB3ZLNluHx/qvzRShe47uP8=;
        b=KVEAOWq29GeM9ttMn1y3adpOw0+rUzG1HeFjDvhLMIK5hBYgS2OTihps+X5O+0tsKx
         RD8i4eGV76cXBzqTRe2I29mGfE/ksAKqayaWw4l3g74Yhb7rCq5TtxLA9LFCw6f/gH4u
         JtinFYcfnWP9EAHAIqhlHQTgAyr05pvqW6Ea9RWQdQ6/aEc2hMDzmdXwvX+Nz7b5l4FQ
         99F/mbkuL3tZVnaa3G4V476/jltf7n0SHwfx3RG5XYg1b2ECHmHwepDwjkXUY32JB792
         Fmr+mIcz0FhFRZbAmwzpb/WaIHr+Ln9IKJxjCJLQDZHaoxiTQHtmfZooMJwaTDeIU8ej
         I/ww==
X-Gm-Message-State: AOAM532rWUksGthrGPAG/ADH8zGZvAamR5YSWDtm5ubRg9uzCoeX18i+
        chGmu3kRbBykseoWy+wXLGkFqgbq3N5N5jp2qvQ=
X-Google-Smtp-Source: ABdhPJwDd4vpBNfKdSUh97ykof3xcXdCGZXNjXpJGwzlSWfsCht8MQ7PwWO77hY5gd4+Msyd5nnnCm6Xbj3g0RVUuGs=
X-Received: by 2002:aca:bcd4:: with SMTP id m203mr5922452oif.138.1590766502419;
 Fri, 29 May 2020 08:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200528184056.105774-1-jwcart2@gmail.com> <CAEjxPJ5a3BDuN2VpyMt-TWMZvPVVx+JHym3EwnMdHC4xkEXTfQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5a3BDuN2VpyMt-TWMZvPVVx+JHym3EwnMdHC4xkEXTfQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 29 May 2020 11:34:50 -0400
Message-ID: <CAP+JOzTGUJYQTSFBD2rO2_YcveKyv7RPV8gaz-2Haqke1unDoQ@mail.gmail.com>
Subject: Re: [PATCH] libselpol: Sort portcon rules consistently
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>, slawrence@tresys.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 29, 2020 at 10:57 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, May 28, 2020 at 2:41 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > The comparison function, portcon_data_cmp(), only made use of the
> > protocol to put tcp before udp, dccp, and sctp. Rules that have
> > the same port range, but with different protocols would be considered
> > equal unless one of the protocols was tcp. When generating a CIL or
> > conf source policy from a binary or using the "-S" option in
> > checkpolicy the non-tcp portcon rules with the same port range would
> > not be consistently sorted.
> >
> > Changed portcon_data_cmp() to sort portcon rules like the CIL function
> > cil_post_portcon_compare().
> >
> > Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Any idea why it used that logic previously?  And how does this compare
> with sepol_port_compare/compare2() used by libsemanage?

It originally followed the logic in CIL. I updated the CIL logic in
2018 (see commit 4ba19b541 ("libsepol/cil: Improve processing of
context rules"), but failed to update the logic in kernel_to_common.

The logic is similar, but slightly different. The logic in CIL and in
kernel_to_common puts smaller port ranges before larger ones, but
sepol_port_compare/compare2() do not take into account the port range.
Other than that they are the same (with this patch). I am not sure
where the CIL ordering logic came from, Steve Lawrence might remember.

Jim

> Regardless,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
