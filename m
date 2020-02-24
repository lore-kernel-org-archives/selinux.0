Return-Path: <SRS0=m/sx=4M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C75AC38BE2
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 20:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573902084E
	for <selinux@archiver.kernel.org>; Mon, 24 Feb 2020 20:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pwqev87m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgBXUFN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:05:13 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45103 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXUFM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Feb 2020 15:05:12 -0500
Received: by mail-il1-f196.google.com with SMTP id p8so504782iln.12
        for <selinux@vger.kernel.org>; Mon, 24 Feb 2020 12:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVAdKACCJdaVslR/v+cgIg05a/vxtehDMDX/7M+KwZ4=;
        b=Pwqev87mJRBxiCkHg1Q1tOAdCtrpshpXrq9Rxk0cA1N96GxScie6mmE2pmGtHKGVR7
         c8ysF2ZQYoxV8u5O5qyMOmEXpKRCQdSfGU5b3cBwIovXI0aRjNVXz8uJACaLX/PAUGM+
         pYfHvJsQNcAmtXyD0wHAc5ngEJ3GkTmyBPzZxky5RlcEqqQgr6Af3AYOnbPZ6gG59uCF
         Si7fy/qGYydM0ztdmtyk+/I5vBUDY4ACfnbWNQtozWNBPZLLaGsWu2dbPJVPPkbhnSgU
         ogalH8yevZ2RBclqHJeSv9zTq6+lIwk/aoW+ZpTRkPlAuon7Y3CFYAUcOe1H50ebTiM6
         frFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVAdKACCJdaVslR/v+cgIg05a/vxtehDMDX/7M+KwZ4=;
        b=jImHPGEXj9aEZzwNB02cIw2uIxNoZmUtzj89BKQoiU1gtgZ5ySdDIqblzLOWgol6rC
         pgh99b+DoWthTsQMTdU5Vd5KKJMpr+6D45tUbBewB+cbRTw6VM2rUYkXcy5NnQbkXcLP
         BlAvixvMO4v5Cwv8FOWh9sa4lZnz7KCK+Us41K9jR3WycWgF4tAPZo9sAfVG01dXMbV3
         FaI3y6QxKG4xXQ+ouZ2zcBz6uegu50vTYK2AZ2B91eeEdOKmohOHp4KfrgZYpjgskCJI
         +XuubIZm25P3wtlfJAIMbl4dhad7o8gJFz5qT6Gr/OLVV9X0PyLNi210oj3342wJVK28
         +zjg==
X-Gm-Message-State: APjAAAWoh3Y+KbWDQyp65rKyZyjvy5QBv+czH0RDpu56Rk4XXa9klTIe
        Fmpw4LD83mKLWmcQBNCAWR7K7lmF8c1OH/vkeMw=
X-Google-Smtp-Source: APXvYqyZeK/GcwLAbGaJbfXdFV9K9L2tgsiv9iyUJSID2Zb6GD/Z7+XaYriGWPj5+RMgwuY0NNy2+kPiAOjvh/HzCVA=
X-Received: by 2002:a92:d2:: with SMTP id 201mr63658911ila.22.1582574710638;
 Mon, 24 Feb 2020 12:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20200221083819.1124890-1-plautrba@redhat.com> <CAFftDdqzTnhO4ii+r9jweBGMtvwrezi-T1_utoCe-V=v+rfPVA@mail.gmail.com>
 <2b98a7da-e186-1013-1286-27d751e75536@tycho.nsa.gov> <CAFftDdo_A5KCwj1szdf-JMV5CbCet58sPe2gJ4v9wKCHOd=1KA@mail.gmail.com>
 <e5e5f250-8c4e-e80b-f83a-7abe2320adc2@tycho.nsa.gov>
In-Reply-To: <e5e5f250-8c4e-e80b-f83a-7abe2320adc2@tycho.nsa.gov>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 24 Feb 2020 14:04:59 -0600
Message-ID: <CAFftDdqKkRc5S236+OjXJkfJaHVw8F-1XicHUb2aaxYqZK1QSQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: deprecate security_compute_user(), update man pages
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Ill go through and post a follow up with the deprecated tag for all
the "deprecated" interfaces.

Ill work on these and post em out next week.

Bill

On Mon, Feb 24, 2020 at 1:25 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 2/24/20 1:44 PM, William Roberts wrote:
> > On Mon, Feb 24, 2020 at 11:00 AM Stephen Smalley <sds@tycho.nsa.gov
> > <mailto:sds@tycho.nsa.gov>> wrote:
> >
> >     On 2/24/20 11:49 AM, William Roberts wrote:
> >      > Any reason we're not tagging this with __attribute__ ((deprecated));?
> >
> >     Doesn't appear that we've ever used that.  Is it widely supported
> >     across
> >     compilers and versions or limited to recent gcc?
> >
> > Its at least since GCC 3.3 and it's been supported in every clang
> > compiler version I am aware of (linked to 3.3).
> > https://gcc.gnu.org/onlinedocs/gcc-3.3/gcc/Type-Attributes.html
> > https://releases.llvm.org/3.3/tools/clang/docs/LanguageExtensions.html
>
> Ok, I have no particular objection to adding it but am not in a position
> currently to post any patches to the list so someone else will have to
> either re-spin it or do it as a follow-up.  There are certainly a
> variety of other interfaces in libse* that are considered deprecated but
> have never been marked in this way.
>
>
>
