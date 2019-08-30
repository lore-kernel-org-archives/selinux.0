Return-Path: <SRS0=26Hx=W2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A253C3A59B
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 21:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1EA2342E
	for <selinux@archiver.kernel.org>; Fri, 30 Aug 2019 21:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="CSK9MnY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfH3Vos (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Aug 2019 17:44:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40746 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfH3Vos (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Aug 2019 17:44:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id u29so6376861lfk.7
        for <selinux@vger.kernel.org>; Fri, 30 Aug 2019 14:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DoBHWQPkyVassec/GBgmahpYkWK2pbvwheEpeZifOQ=;
        b=CSK9MnY/c1G0itW+uTwSpMeh0o33SQIjYfuqGrIMXhj2eMK7gHIjsRK7zsojDs6vok
         JO37JJOngIgEtKLrOfPTm3WufZsRF6rslND+/OqBnAejyDBuXP5sXc0ZqgvhvpY7Y4/e
         PXuTJwzSDNmOmtew99q/HYb52LLEM8UKIZcdAZEJhF3lRab3NN2aTT+3ORLE1aa6+LkG
         nmrAm6rWndIPFHH1/L6nbnZIiiTD5aEzDpQvYniIDtGoqLma+gbyKDcocNBg44+uQt5k
         3DaCksDUi09WioTijOEDTjtPByM85DeVHg+cn6oT32EkXc6PuFUFtznOtmSqrPSQbDhq
         fezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DoBHWQPkyVassec/GBgmahpYkWK2pbvwheEpeZifOQ=;
        b=LeDVS/X3BvtLiwfsQoRwdmCwvWsdWBYwN2v6Pv/skQdsooiRbqkoOtixPBtGdj807u
         KRRKjJFsFpNuH0/Sejj3hBseLcJ1HxLx3X7bdhOobhIwVWiL8YTNGZVFJNCeQwakwgd/
         iO44F+l9EbhL8jQCobFE90etgOCmwM8OV+jrEnD4R8Ggg4gOedCbm/IaWi1edQvXtEdw
         2ROftuRDxdtDu8JIzs3NnoA6zrxEBrIggTowxgv/yjMSNY8/wiTFfOCKU0oZy6TI5WHj
         YEOflSZJuDJCxayYZk8+cUniDabQQMrOMzzup98Lh4caq5u9VC5zwzxqQuJfs7ZA6XGF
         G/xQ==
X-Gm-Message-State: APjAAAVL5ODRxFI/Wh8JQuXQYHj6o4zq2Kr2HURW+BelFIsqHy1xfCKU
        vWpMJLO+loZ5PtXcRp1Hp+2T3QgdK7axMtmrwH7E
X-Google-Smtp-Source: APXvYqzxjW2AeubX6l8EnoabWwRqIsB6lmxUCeU0YLgwOoLRz2gqTCm9f1uoSaiE46JWCIK8ArkZlhBVNlJxaOSEtjs=
X-Received: by 2002:a19:8c14:: with SMTP id o20mr10473891lfd.158.1567201486020;
 Fri, 30 Aug 2019 14:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190830153946.28159-1-joshua.brindle@crunchydata.com>
 <85c1aba4-39ce-ba21-bb8c-30aa71bab06c@tycho.nsa.gov> <CAGB+Vh6tLsLEd7fwQqkqFjgf0YZznFm=DUAMe39oFMBf8+eDXw@mail.gmail.com>
In-Reply-To: <CAGB+Vh6tLsLEd7fwQqkqFjgf0YZznFm=DUAMe39oFMBf8+eDXw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Aug 2019 17:44:35 -0400
Message-ID: <CAHC9VhTqe5OFUSwCV-RDa8LEq0Kwv2XE3hZVX078fH42y3Uubw@mail.gmail.com>
Subject: Re: [PATCH v3] default_range glblub implementation
To:     Joshua Brindle <joshua.brindle@crunchydata.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Aug 30, 2019 at 11:47 AM Joshua Brindle
<joshua.brindle@crunchydata.com> wrote:
> <snip>
> > > +
> > > +static inline int mls_context_glblub(struct context *dst, struct context *c1, struct context *c2)
> > > +{
> > > +     struct mls_range *dr = &dst->range, *r1 = &c1->range, *r2 = &c2->range;
> > > +     int rc = 0;
> > > +
> > > +     if (r1->level[1].sens < r2->level[0].sens || r2->level[1].sens < r1->level[0].sens)
> > > +             /* These ranges have no common sensitivities */
> > > +             return -1;
> >
> > I mentioned this on the prior patch, but perhaps you didn't read past
> > the first comment: I think you need to return -EINVAL or some other
> > -errno value here since this will get propagated up to the userspace
> > caller as an errno if I am not mistaken.
>
> Yes, you are right. Sorry about that. I'll fix this on the next spin
> if everyone is okay with everything else.  I think -EINVAL is
> appropriate unless anyone else objects.

Other than this, v3 seems reasonable to me, but it would be good to
see a thumbs-up on the latest userspace patches before we merge this.
Changes to the kernel/user interface are
<haunting_voice>FOREVER</haunting_voice>.

-- 
paul moore
www.paul-moore.com
