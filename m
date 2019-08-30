Return-Path: <SRS0=26Hx=W2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0D0C3A59B
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 15:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13B723427
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 15:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crunchydata-com.20150623.gappssmtp.com header.i=@crunchydata-com.20150623.gappssmtp.com header.b="PSMjdsEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfH3Prq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:47:46 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37771 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbfH3Prq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Aug 2019 11:47:46 -0400
Received: by mail-ot1-f68.google.com with SMTP id 97so4510120otr.4
        for <selinux@vger.kernel.org>; Fri, 30 Aug 2019 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crunchydata-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tH0MSTo10/wXXsYEBF/4ssgCsln98nLKsiM3R7F644=;
        b=PSMjdsEoSXMYcdoK5J2eDSByZwMqqX6rO/WI5Cj/5T8PBD0jmkFYAHQEnlxALee3Ti
         RrlEtiIkKWDfENvQWRPu24lAg9bjSB0K4bevMg58iJyyGiJHGpdNfvNjA1D29rPZGp0+
         9uHg/XnXNfRAkJUwTWOmsr/WLjDYVRynxlcT1+dM3+HlAmT1wurOa3VOLTVjdtFDDVNS
         ci+okFm9nlNmUvPUZ99a6KW38/3TIoAgSwn6itcv18ateP1wd9NwDs7Ggs8W8ALcJ8Jf
         lG8qqG1RTcbCDfur+BtxKgxYHIshYC6JCVfWCjbdcD5pVZBYKv1E6YrqzroOWF/XF+hn
         fPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tH0MSTo10/wXXsYEBF/4ssgCsln98nLKsiM3R7F644=;
        b=ZtnhUBTnCNhnkmAdCZHkc6+YpIRioNqySDEHOl/PwpcmzHczZDJ1cE/sbDezacqtdY
         yulhG5xhM6MEPyUSpeJracXAj2zk3oJWW/twSXCMhVloM2CA7YtCJivT2jEUUZQ/1zw1
         jRDb67jeatlxvGpYMVcTkyI1ERMueFNhq0ZHyj8uDz6RZZOoPIQwHOws23kgNezns+kB
         rMUatFDCBVGTOIcihMQRM92rH93eRqKS2vun1aJI9jU3rEMZjDR+J7ooW+v9aPohPo7I
         5Z5syIoL1Qd8RrzDyNiXKbNAE6IPyK1r4zc3olJz7xAZ/kQcw0SqnqyM7GFVx9EU1wsw
         jtTQ==
X-Gm-Message-State: APjAAAX0vMilpvV0M79tKtqIJh0VK5PzL+eshS2+loFt5ki1s1dt8Fs8
        sh7isfDtM47c+SIvneFvour2BOTsJhSe4oLL9g+z7Qf3
X-Google-Smtp-Source: APXvYqzq2Doms6hy4v2PPmxI3SCIEV8aockpUgQ5NFCbnUXIkHCLa4uFLRO9v2IyIX/jks2bDBzXNrKSjg/lh/vldOg=
X-Received: by 2002:a05:6830:4a1:: with SMTP id l1mr13105414otd.180.1567180065292;
 Fri, 30 Aug 2019 08:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190830153946.28159-1-joshua.brindle@crunchydata.com> <85c1aba4-39ce-ba21-bb8c-30aa71bab06c@tycho.nsa.gov>
In-Reply-To: <85c1aba4-39ce-ba21-bb8c-30aa71bab06c@tycho.nsa.gov>
From:   Joshua Brindle <joshua.brindle@crunchydata.com>
Date:   Fri, 30 Aug 2019 11:47:34 -0400
Message-ID: <CAGB+Vh6tLsLEd7fwQqkqFjgf0YZznFm=DUAMe39oFMBf8+eDXw@mail.gmail.com>
Subject: Re: [PATCH v3] default_range glblub implementation
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

<snip>
> > +
> > +static inline int mls_context_glblub(struct context *dst, struct context *c1, struct context *c2)
> > +{
> > +     struct mls_range *dr = &dst->range, *r1 = &c1->range, *r2 = &c2->range;
> > +     int rc = 0;
> > +
> > +     if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens < r1->level[0].sens)
> > +             /* These ranges have no common sensitivities */
> > +             return -1;
>
> I mentioned this on the prior patch, but perhaps you didn't read past
> the first comment: I think you need to return -EINVAL or some other
> -errno value here since this will get propagated up to the userspace
> caller as an errno if I am not mistaken.

Yes, you are right. Sorry about that. I'll fix this on the next spin
if everyone is okay with everything else.  I think -EINVAL is
appropriate unless anyone else objects.

Thank you.
