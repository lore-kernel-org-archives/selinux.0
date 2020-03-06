Return-Path: <SRS0=Zw2N=4X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D85C10DCE
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 15:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF1B20726
	for <selinux@archiver.kernel.org>; Fri,  6 Mar 2020 15:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLmNSgtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCFPn1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:43:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36707 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCFPn1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 6 Mar 2020 10:43:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id j14so2836841otq.3
        for <selinux@vger.kernel.org>; Fri, 06 Mar 2020 07:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81ds0fHDJNvZVgBFXy18VbdEVmzbtTNQwBH+vBPlXgA=;
        b=KLmNSgtImCRMnoed4069qQ8WMVGyHQ0DYwWCaXSpC3GvfBEvGjE5wfAjqvuv7dsKv1
         kH37DWVRSh0QGyLg8EGcmORcWuMbnom0iACIJvd0/TMfn5msXsK9SpRnkTY87KFUR4vA
         CTqMcwNYVSvwaqG8Lk0PA7i5CZWk1Y7wZWhIdem4kB4yGAr5nLajREPtMwYQSjpc4ZH9
         kJ2TfDHtPSHFdqG/aNJF9BEwsnL3pQqgXMNRQh3ndhciddhJEK0tpM6sm8WXV7I3jV2m
         3cbEgL13SvjQC4ZaNqlF/5akMr9qhsJJb8w454Zw87XTbaJC4iQKy25LgDAtKSr6Gw/W
         Urhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81ds0fHDJNvZVgBFXy18VbdEVmzbtTNQwBH+vBPlXgA=;
        b=oGbBA4Lkb3sGy8lfTXhD00M/iHoLPjfwgxBsqePpVscODLgYVyYKtMhAJyEnxcE9sC
         mXcrffqpq9zWi7VCM8UT53kj5PY+EMUSTJyxUPkrZXi46exBgYO8j/QYInD3tNlVmhuM
         pshCjVRsHc2UIlWlshp2/z2Pzm801UWPQ4Vvb01q9du9/zB0ZCy7O69Bg4iZ78puWZi6
         3Pn+QxaVfHpF3gyzAgEuKAdku5Bj+CL9Dps2XJdFYr48Y/CjxApL8TYo0L+1FIwIarA5
         e/lCmyQib9/90t9I/IWb9mC6aKP0AO48B0jeUNlv87eCJyiIn1xEAL9Y/1xbhkr42qgF
         mauA==
X-Gm-Message-State: ANhLgQ3CBn5Pfb+SjZpJxC+DHV2GftSX4tBNMrQsXH0NBiaKvyhpmvE8
        m1l4Ntw1Fz5HqcnK+T6UfuaSobMoT7sO3/tbTQQ=
X-Google-Smtp-Source: ADFU+vvoatzUmTYgNyU9C1Mk6Av7SsGeMmhfuLnKsUpJRMP5zHalCTY3zyybAWcFj2qd3BMzMJ2m8g0Nv5PojpOMSzQ=
X-Received: by 2002:a05:6830:1144:: with SMTP id x4mr3001041otq.59.1583509404962;
 Fri, 06 Mar 2020 07:43:24 -0800 (PST)
MIME-Version: 1.0
References: <20200305184034.165554-1-dburgener@linux.microsoft.com>
 <CAEjxPJ5OZpvvrWq9h1xYudLwZFgHj6nyr-uPnFqxoGEv91fk2A@mail.gmail.com> <f7d669b6-25bc-699c-5bc7-f7dbc12b3a24@linux.microsoft.com>
In-Reply-To: <f7d669b6-25bc-699c-5bc7-f7dbc12b3a24@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 6 Mar 2020 10:44:47 -0500
Message-ID: <CAP+JOzSqQCjuV_yiKQuvRzuvFQcSn8FGgP2ksJ-B0MjzWjrvtg@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: Add --werror flag to checkmodule and
 checkpolicy to treat warnings as errors.
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Joshua Brindle <joshua.brindle@crunchydata.com>,
        pebenito@ieee.org, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

It looks to me like the only warnings are for:
- Conflicting expandattribute rules (which will default to false)
- A dontaudit rule that uses ~ for its permissions
- Stating that role dominance is deprecated
- Unexpected character: @ $ % & _ + = \ | " ' < > ?

It might make more sense just to make the unexpected character case to
always be an error.

Jim

On Fri, Mar 6, 2020 at 9:16 AM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 3/6/20 8:57 AM, Stephen Smalley wrote:
> > On Thu, Mar 5, 2020 at 1:40 PM Daniel Burgener
> > <dburgener@linux.microsoft.com> wrote:
> >> When the lexer encounters an unexpected character in a policy source
> >> file, it prints a warning, discards the character and moves on. In
> >> some build environments, these characters could be a symptom of an
> >> earlier problem, such as unintended results of expansion of
> >> preprocessor macros, and the ability to have the compiler halt on
> >> such issues would be helpful for diagnosis. Signed-off-by: Daniel
> >> Burgener <Daniel.Burgener@microsoft.com>
> > I'm trying to remember why this particular case (unmatched character
> > in the lexer) isn't already a fatal error. If there isn't a real
> > reason for it, we could alternatively just switch it to use yyerror()
> > in that case. Otherwise, your description suggests that you only want
> > to make that particular case a fatal error; are you sure you want to
> > treat all warnings as fatal errors?
>
> That's a bug in the description rather than the code.  That particular
> case is what caused me to want this option, but my intent was to add an
> ability to treat all warnings as errors.  I can resubmit with a better
> message if you'd like.
>
> I'm not sure why the behavior is that that particular case is a
> warning.  Git blame shows it as going back to the import from svn, so
> it's been that way for a while.  I'd think that --werror would be
> helpful either way.  If no one has a reason for this particular case to
> be a warning rather than an error, I can submit a patch for that change
> as well.
>
> -Daniel
>
