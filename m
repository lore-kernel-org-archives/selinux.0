Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C231C43461
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 17:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D404610A0
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 17:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhDAR41 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhDARvI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Apr 2021 13:51:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3768BC02FE81
        for <selinux@vger.kernel.org>; Thu,  1 Apr 2021 08:56:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h13so2515727eds.5
        for <selinux@vger.kernel.org>; Thu, 01 Apr 2021 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eZyej4DR7Bni1LGYVDkMQcQWwua8NQMc3CSgND+VEu4=;
        b=cpxAHeoCM7XSXQVAAbHDBdHaEddnUwmNudBAkRrbhbZvUjzRpPCZuP4kKpk9RXj7og
         Onx1kHycWhYUVBNqNeqkxSkbNM362Y2u1QVleVQrNbBdQ6+lDEkAr5sDw0xRe1oyzxLg
         +ozzUqg8eXxJlTY9fEX/x6oHEN1Ib2FhD8HVOTWqslf252zJ/KtSme7d+2Yu4r1p0pDy
         ZOefPAB2zvbokIJhVX/+E4nSPoeqhTIwR8zg2Q4/KSP36pLNwid7nQx42YgYuvQVr4lk
         Om9KWWgOFlf785XiC1qggUqj0BVrH/0le/AANVk5Y/OrzV8QSvAd449iXYtaXaETyF21
         Kgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eZyej4DR7Bni1LGYVDkMQcQWwua8NQMc3CSgND+VEu4=;
        b=SmjY5liJAw25WfOaWPfqT+qEzuYt+foQ+xzABGqdo9Uf6uiNiW2UV87b3rIsretztx
         4TYVBBToiUqj4ZjnCAcVDIMGyAXKR3LqPq0KBing4BQY5/ooPKKxxRUCsXc/O5C2GJea
         OAyBgaIDesj323m5JMeh0yCyVfg/2ZpL/4ykCRNB3jImOAxp2SxS8Fb6ysZBdmNQf58C
         mA/IYcWE4dguAVJ6sBf5/z/0IE0W93xdGfEE0JN9Hi64GzH5jFVmE4Q3TjRruG3En7F2
         daFYRWo7IB9C2ypzKH8w3KW/Px7d138qwnr8sX+huEm/akjsJSN6bBAVyPFi9/7b9NrP
         Pxkw==
X-Gm-Message-State: AOAM533nudZIAKwthmS0uDlxrCZzpSUI7x60VaxtCedPHtlNWHhPVNAU
        GT33w49/n1X8fp/1L6y7FGkss2yWAmUcgXjJ9vb3
X-Google-Smtp-Source: ABdhPJxZC/uVrZM4x2XkmIICX9nPPq8TapFSzVB2MlGG3rC/2s5jCoZ69WWdKV1NHX77lwkOUKuQlhH0ZJ7Y5+Wnkqk=
X-Received: by 2002:a05:6402:1cc1:: with SMTP id ds1mr2243009edb.135.1617292588872;
 Thu, 01 Apr 2021 08:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210330131646.1401838-1-omosnace@redhat.com> <20210330131646.1401838-2-omosnace@redhat.com>
 <CAHC9VhQ4Hc1VccUjR7cMq_Lm2YOn=i=w_FahZ7ZFnoxz+iKUPA@mail.gmail.com>
 <CAFqZXNsus-5PGNMT2t=T4WQQMrzgBSJDu6=qr0KmtDgKCR=hfQ@mail.gmail.com>
 <CAHC9VhRD=SNev8Ptk7idauX+0gzQysKDLBhGkfpD1CETB2TNrA@mail.gmail.com>
 <CAFqZXNuq2aBs6mW6jZ+bt_SY2xrE4LYL3knEjxD26bOw8J3Eqg@mail.gmail.com>
 <CAHC9VhQUo0cp_7Zt=ogsj0RknZ-YK7pv40rUevZztF-PJ+99ig@mail.gmail.com> <CAFqZXNu0fwwPYLPy0_E-+YoK+A+5odiw1f_SBVSsgeOJ-L80Mw@mail.gmail.com>
In-Reply-To: <CAFqZXNu0fwwPYLPy0_E-+YoK+A+5odiw1f_SBVSsgeOJ-L80Mw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Apr 2021 11:56:18 -0400
Message-ID: <CAHC9VhTHYnEBEd3F2QhsatZFykqQ6HRYR8YHhUrK9YKKrKJ1QA@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: fix cond_list corruption when changing booleans
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 1, 2021 at 11:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> Ok, I agree it's not something worth obsessing over, so I'll just use
> this last suggestion :) (One day maybe I'll try to simplify/optimize
> it a bit, but that is for another patch...)

Sounds good, thanks Ondrej.

-- 
paul moore
www.paul-moore.com
