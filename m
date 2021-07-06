Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6B3C07E96
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 911FF619D2
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhGFR1b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbhGFR1b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:27:31 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD78C061574
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:24:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w127so37619oig.12
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=esQYOqiK3JMW70d53GFUi6T9nvRYv+Fw2gY+RQlq0GU=;
        b=S8vwaXTxDSDKgu8igXTqhPpNZsorsfoIF4fuhKpY5S10xqKC1j4vn2+F9IkJw6g/PZ
         8Q5oO7zsDMHf+USILEHlf+cmJ+mzXlB5HbJiLp9+ehYyY4EBJVw4f4fLrSAwW9sU9buo
         lbS+buYEigPG6YiEaUB7ym3g5A5lI6FCoM/ipRyqk6lFEV8wmAkTPSPjPmwRbeSQLWRE
         kpALRSB+A36IT6SPtoL7Y2XP5jPgU78BC7Ly08XgkIOZXLy6UVultf/HPXmGhnVXdSaj
         XDrSqVbWU5+QQ0mV3ei+9C1C9PHDsNIH/hQm9OKMjOadwbcrbUrS9NEwS6m5iuIJL/C/
         3nkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=esQYOqiK3JMW70d53GFUi6T9nvRYv+Fw2gY+RQlq0GU=;
        b=ArCgYxAmzJX3sufATRN5VImoQPpTuQ2APsQv4Q5O0iqpo9eazc4QgvuRPi07VJ8TCO
         zse0+5qs/hp2e60PojsK8RX9X7M0xBisvvf1PeD2uAVeE0zu6ZPVL6U7rvTxYMYxDFV0
         15eyUb8KdsiDQvtf8tGdBMsQjAiil753qkodUwXr4IXEeUnehUAv6ulpxYdS76uekQzp
         y1Gav8a1U2zqsTuRN6+isgTBE1EVoEWGPgrArMb0GHWw+ZPoxc/1jrCVqX+K+/CZjXMt
         qxx3Z58O9MnLGwKvM+rZuarVp3u+krcwJjJKfQsrJ9801ILiu40LwKZLw5alFPZyq+bM
         p5mA==
X-Gm-Message-State: AOAM530asMOWN46zrL5hTZq4uqumOTZD0HSTAQXzhu6atr5TkLDqpr5M
        8YPQCvGVY9bVif07fUwc5nKoRT6IfdAsIooBu6SeJl4lde4=
X-Google-Smtp-Source: ABdhPJzHLqp9bpaHiJzDf4uzXnbLCHSvdm82i89aVk5BTmsc+ZLX1LBCHNvYLekV9VBMjdhyPWLhhl+CboPVCrV2ljQ=
X-Received: by 2002:aca:618a:: with SMTP id v132mr1284920oib.144.1625592291755;
 Tue, 06 Jul 2021 10:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210701183430.145934-1-cgzones@googlemail.com>
 <20210701183833.146592-1-cgzones@googlemail.com> <CAJfZ7=k5+wSxrmBtTH91Fw6AHO4z-=wYqm2OFEzDtQXLei0=eg@mail.gmail.com>
In-Reply-To: <CAJfZ7=k5+wSxrmBtTH91Fw6AHO4z-=wYqm2OFEzDtQXLei0=eg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 6 Jul 2021 19:24:40 +0200
Message-ID: <CAJ2a_DccPRQhBhmgGBVPrZ6++RCZ2QkV4Wk=4Co4TN1DXiW1+Q@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: avoid unsigned integer overflow
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 2 Jul 2021 at 22:36, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jul 1, 2021 at 8:38 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Unsigned integer overflow is well-defined and not undefined behavior.
> > But it is still useful to enable undefined behavior sanitizer checks on
> > unsigned arithmetic to detect possible issues on counters or variables
> > with similar purpose.
> >
> > Use a spaceship operator like comparison instead of subtraction.
> >
> > Modern compilers will generate a single comparison instruction instead
> > of actually perform the subtraction.
> >
> >     policydb.c:851:24: runtime error: unsigned integer overflow: 801 - =
929 cannot be represented in type 'unsigned int'
> >
> > This is similar to 1537ea84.
>
> While I agree with the change, I still see subtractions in gcc 11.1
> and clang 12. What do you call "modern compilers"?
>
> More precisely, I copied the function rangetr_cmp in Godbolt and
> compiled it with "x86-64 gcc 11.1" and -O2,
> https://godbolt.org/z/5c4jG7eeh . The generated assembly code
> contains:
>
>     mov eax, DWORD PTR [rsi]
>     cmp DWORD PTR [rdi], eax
>     seta al
>     movzx eax, al
>     sbb eax, 0
>     test eax, eax
>     jne .L1
>
> This really computes a subtraction, with instruction SBB. For people
> not familiar with x86_64 assembly language:
>
> * the first two instructions compare two values,
> * SETA sets the 8-bit register AL to 1 if the first value was above
> the other one,
> * MOVZX ensures that the 32-bit register EAX contains 0 or 1,
> * SBB computes the subtraction between EAX and the carry flag, which
> is one only if the first value was below the other one.
> * TEST checks whether the result of the subtraction is zero.
>

Since I also checked the assembly results with Godbolt, it seems I had
misinterpreted the results regarding the subtract instruction.

> For information, the previous code generated the following instructions:
>
>     mov eax, DWORD PTR [rdi]
>     sub eax, DWORD PTR [rsi]
>     jne .L1
>
> So the previous code generated simpler assembler instructions, but
> which could trigger an undefined behavior in C.
>

It is not undefined behaviour, unsigned integer overflow is well defined
to be wrapped. And there are legitimate use cases, like for hashing or
pseudo number generation. But outside of those unsigned integer over-
and underflow can point to logic errors (when reducing a counter below zero=
)
or missed overflow checks on user input.

> TL;DR Anyway, as this change is not about performance but about
> undefined behaviour in C, it looks good to me. Nevertheless the
> sentence "Modern compilers will generate a single comparison
> instruction instead of actually perform the subtraction." seems to be
> wrong. Could you rephrase it (for example by giving examples of such
> compilers), or remove it?
>

I'll send a new version with an updated description and also using a compar=
ison
macro, to minimize the chance for typos like in the first version.
