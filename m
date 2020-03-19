Return-Path: <SRS0=B1VM=5E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B101C4332D
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7EC2070A
	for <selinux@archiver.kernel.org>; Thu, 19 Mar 2020 19:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJDMGjj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCSTi0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:38:26 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33812 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgCSTi0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Mar 2020 15:38:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id j5so4043282oij.1
        for <selinux@vger.kernel.org>; Thu, 19 Mar 2020 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GMZtIq5Gw/bB4bLlCOA+I58jsXO+Bcz4e+OLUFq7Rqg=;
        b=eJDMGjj+28nQjiE7JVPsOOHsEWBJnWsvUO3O8S+/6iO8x1gVrmhJuzHshgBQK8ie3n
         PA/lR2L/xSMq7wk+kWC2BWb/IgtnAOq/cQilTxNQi0rhKNoTbQP2I5MxGTy9SJYpXjCv
         MA2CbAoPmf8TxoSwuHI1dsetzAcZ4UvhuYw1PiwQ8detgwXHDu4WnqX3mz7Aj6dJdtN8
         6bZ56yXanh0sA+6kRePLQU8KRd6fquvkn6Y64lyPekEcrmW8m8lrENWTPK+rQvvLNKQS
         kj/XuPKKDDTdLqDqmNl87tMP2jnglZ01JIgR3uDY95pltm0CuU64KYTZbid6XxCtthbp
         bzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GMZtIq5Gw/bB4bLlCOA+I58jsXO+Bcz4e+OLUFq7Rqg=;
        b=WhN0ecu8ttwMj157G7a2vCHGGOJMNmA/3WvkOCpE75mPrZbAy1Yl5vyw5XRR8EiK7g
         eVHIxoqPVMjLEtNsG7CQzqzyujS7Ckjpq+bOQbSghiobPYpj0+P3Oz4/UHrp4vdvgf92
         h+EO7nKW2t70jyYselC6qqAlQLjAipY8xsgRJltHylgeb8oB/mUilHx7HSXC4Lq5vFmJ
         3unEuzxR8dm/PYHCfBO31xTpGJUGvoMCj3zkEOtSO7ABm43GM0YiAzXsGom90rISND9C
         W2YwcKLtjvJ0z6jS5vR1rA1aDodA0EljmszX2bxpBvW1NxShGTgYfRfwPNXcOeeAzdzh
         2Tog==
X-Gm-Message-State: ANhLgQ2ah6cZ0OlKOfFXepkYC029oIohxpay6gCijp0SkoeUA1FU6PB+
        WzENa71++DEpIJOm0LQ0omq40wTUZx659kASIJs=
X-Google-Smtp-Source: ADFU+vuc1r9ICjwK5U0hbJ2yjpL8iRA0e/njKNPaK1FDMwwnT5+P1ds0tBcOyc1hv/aExU8jwp4xNrUcGVbzRonthD0=
X-Received: by 2002:a54:4396:: with SMTP id u22mr3705817oiv.128.1584646705897;
 Thu, 19 Mar 2020 12:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <20200227160257.340737-4-omosnace@redhat.com>
 <CAEjxPJ6BnBoBGi+Dv=MQkH0-+JPAQE3ewHGykERYw_yEJ92CJQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6BnBoBGi+Dv=MQkH0-+JPAQE3ewHGykERYw_yEJ92CJQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 19 Mar 2020 15:39:52 -0400
Message-ID: <CAP+JOzSMxYurya=KPeDUh5SCF+KZzcTDgUs8pDyFHmnnxAROJg@mail.gmail.com>
Subject: Re: [PATCH 3/3] libsepol: speed up policy optimization
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 17, 2020 at 2:25 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 11:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > The iteration over the set ebitmap bits is not implemented very
> > efficiently in libsepol. It is slowing down the policy optimization
> > quite significantly, so convert the type_map from an array of ebitmaps
> > to an array of simple ordered vectors, which can be traveresed more
> > easily. The worse space efficiency of the vectors is less important than
> > the speed in this case.
> >
> > After this change the duration of semodule -BN decreased from 6.4s to
> > 5.5s on Fedora Rawhide x86_64 (and from 6.1s to 5.6s with the unconfined
> > module disabled).
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Sidebar: Wondering whether you would have gotten similar results by taking some
> of the ebitmap optimization done in the kernel into libsepol. Regardless,
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Applied.
Thanks,
Jim
