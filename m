Return-Path: <SRS0=YleE=BH=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A937C433F1
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 13:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A81A206D7
	for <selinux@archiver.kernel.org>; Tue, 28 Jul 2020 13:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LheCqbjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgG1NXj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbgG1NXi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jul 2020 09:23:38 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB15C061794
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 06:23:38 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id s20so10154651vsq.5
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2020 06:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXfi6vnP/umEXJ3y6ImlOcqse9iDrshGxOOYKi2M06w=;
        b=LheCqbjpyiQxtwihTuUKy4NYEy6OXctJA8A1Y2Sr5BuJnvgKdbi15QewOOWwOTF6LV
         N2nrvCDnDI6GG/a3Jcr92B0KsFOfnIx3sJxvg47M9j3sObDZC9PWHbGNaB1knVrOKZMt
         XaQkggAT9CIHSU6HwIIO0Uh6obozcw60whadWtPtoWDktgnp71oS0tVa3zhHJs+7n8+K
         IAbkNycIfArwi90Sg+Df3RoB6L4iaWjWFKdl2zPrVAgC63StILnwkrJVR/XSS4BQYQAg
         xqyjw3VvVR1efAQwRhhfVK/v7zHsJwwiKNVVj4dbwhCGVPp4+N3Jt8y8IK2q1SbP04DV
         +a/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXfi6vnP/umEXJ3y6ImlOcqse9iDrshGxOOYKi2M06w=;
        b=un9he+87RRb5TLGsxaZ/wNEXE2LNO+RodU8cUfJRSv7VU/Pr0AaTwwhGH165sYOZsx
         YP74i4cym93DMS82uWZk7znbFCAQlargfNp6Q4nWGPYhtlQ96fNIYaMl6BQEnPWf8+TZ
         vkjJMg5ptVrGkv8kRmo17oEGHdYAD95fJ1kqMRlqe2ncyFsRUhh3wnPs+5o5NdiuWZ/o
         wGcacUFW8rIPfDmnPGnHuDShvTNRMkhXBfsgROL3Od6bhAPivhxeqBi7J2JaolSPJ14z
         LSx1zEfbxO+6filbtZE70J5BaY2Vbkuk52gaJgwFUXbPf4wZ6+Y6P23J2xvbboAessNV
         ZNZA==
X-Gm-Message-State: AOAM530FnA/kTVCMA/y+HfSYB5oM6g8TVVYCmbqiZjPkpVHV+nj8MyNT
        6v1gCCoIkw1TGKX4d+H4yJH4pcLImkOPTK3n7VhK8A==
X-Google-Smtp-Source: ABdhPJzBOH10rk3Rdn+jqyz9OJv/90a0M5FuL1RWCmiobUTvZgrGDVcf4sKGcimEjjpR3cDYVpJ4HObqnToKzsJqr9g=
X-Received: by 2002:a67:f60c:: with SMTP id k12mr19847110vso.8.1595942617191;
 Tue, 28 Jul 2020 06:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200724091520.880211-1-tweek@google.com> <CAEjxPJ45ij3obT37ywn_edb9xb89z-SdwzejfN6+jrvAtghXfA@mail.gmail.com>
 <CAHC9VhS4aXD8kcXnQ2MsYvjc--xXSUpsM1xtgq3X5DBT59ohhw@mail.gmail.com>
 <CA+zpnLfczC=9HQA8s1oBGKGQO+OkuydF85o89dhSxdOyKBHMgg@mail.gmail.com> <20200728091220.5769b606@oasis.local.home>
In-Reply-To: <20200728091220.5769b606@oasis.local.home>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Tue, 28 Jul 2020 15:23:15 +0200
Message-ID: <CA+zpnLc1i32LZGXU8q3=Ssd7Nhpzis0PFXjs8e+weav6rMpWbQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: add tracepoint on denials
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Eric Paris <eparis@parisplace.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 28, 2020 at 3:12 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> Where in that document does it say that trace events have a fixed size.
> We have a lot of dynamically sized trace events.

My mistake. From the "format" pseudo-file, I assumed the offset and
size were fixed.

> Please take a look at samples/trace_events/trace_events_sample.h
> and read the example on __print_symbolic().
> I think that's what you are looking for.

Ack, thanks for pointing these out. I still think that my other
argument (i.e. duplication of avc message) holds.
