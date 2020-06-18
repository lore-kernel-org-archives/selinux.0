Return-Path: <SRS0=MecV=77=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE3C433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 18:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 557FB207DD
	for <selinux@archiver.kernel.org>; Thu, 18 Jun 2020 18:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKfXkfhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgFRS5K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgFRS5J (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Jun 2020 14:57:09 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689EBC06174E
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2020 11:57:09 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 25so6031860oiy.13
        for <selinux@vger.kernel.org>; Thu, 18 Jun 2020 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0phawuxkQ0Mr21+hc2fVYyJFKo+0+Oph4m4Mr2PZCsU=;
        b=kKfXkfhlhoqIXN6luGAwOWTplgR3eGufN3VjqsGqCl0r+mSKl40+BRyei2rwEoCXY7
         wjv0/wWVqs5YPBDJGyXCwg/1jTUzsUhCz5oIo1CLwY+dP85daxMMb9Df+36pwq9MPeED
         RnaeUt50AHPSEFtf+DDVYoBWEc7yCcriistVFurGfJc3P34GgwrRUTdcslSu/6OuPK0h
         AtA6hpgKGttrOEJES31weJ91dmILvs0A0gZ0x6OVOh9xVzOh73qq72PJ2cWQAR+kXWQS
         rENnBJHgoIC4UjEi72d95GQRE2Zu8CIyfj6EBd1qcpT/kCo8B2r7UKIsdKyTYqaJhzKG
         9z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0phawuxkQ0Mr21+hc2fVYyJFKo+0+Oph4m4Mr2PZCsU=;
        b=Rm7Gq32JQxdaHiBJ8z1sXYFe96pNCJwAZ3gkcBOBygDlydFgk/XV8dtu9OlepRSGl/
         CbXmNP/fBfxUL/z0j8AXLD2YSuV7Ug3zAzzSe5E0UsYLILBXR/MPGtzjY/1OpxKFhkYU
         F+aYhsigkEtwS+o8RgFYaGW2Y7Eh4QNvEQ+E1m5YbtuLxuQHNcCfh0PSVaGJOrAeVt8i
         2080Drz2vb8yvbyDVns+UGezuKcwQRJi/d2AYLvdnb340wjs35L0SKNyT8G9KcGt8m2Y
         0wA4y5mRt4MyrXP+1ol6vZ1o7hE5OLa2nBMe0Y75u01nR4IR4S+yGdv+9pg4tjXZEs2c
         KXCw==
X-Gm-Message-State: AOAM531f5bK6nnKyeXNi4P/GIiSaKwGCgMc5BQKdfXwxKKA3hbnirTob
        z1KPplGYeYYHRou3NKe/MrhnkLIij7TLl0qcJt8=
X-Google-Smtp-Source: ABdhPJxTfOxXKqpA0Ec1PebM1uFT+5RwtQXMqaiyRjvlCiQUKyswUVlp6+l4416ng4as6tacE6yybo9BC1edAQ5QDIk=
X-Received: by 2002:aca:5a05:: with SMTP id o5mr205174oib.138.1592506626357;
 Thu, 18 Jun 2020 11:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <002913f4-070d-4179-f4ee-029d5347f570@gmail.com>
In-Reply-To: <002913f4-070d-4179-f4ee-029d5347f570@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 18 Jun 2020 14:56:55 -0400
Message-ID: <CAP+JOzRfd7efUsrzxEor-ECOtLjaJVMkAg0RQHb_jF7dNAJeQA@mail.gmail.com>
Subject: Re: CIL blockinherit and entering a macro namespace using in
To:     bauen1 <j2468h@googlemail.com>
Cc:     selinux <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 18, 2020 at 12:17 PM bauen1 <j2468h@googlemail.com> wrote:
>
> Hello,
>
> After getting my CIL policy to work, I have discovered another problem.
>
> According to the manual
> https://github.com/SELinuxProject/selinux/blob/master/secilc/docs/cil_container_statements.md#in
> `in` can be used to enter a namespace, including macros.
> This works, except when using blockinherit and trying to enter a macro
> that was inherited.
>

That is correct. The problem is that "in" is resolved before the
blockinherit. We wanted to keep things simple, so we picked an order
for them to be resolved. There were good arguments for resolving it
the way you would need for your policy, but that is not what was
chosen. Sorry.

Jim


> My use case would be a base file template with a lot of macros, and
> using `in` to add more access to the macros where appropiate.
>
> See the test case below, bauen1
>
>
> (class process (transition))
> (class file (read))
> (classorder (unordered process file))
>
> (user kernel_u)
> (role kernel_r)
> (userrole kernel_u kernel_r)
> (type kernel_t)
> (roletype kernel_r kernel_t)
>
> (sid kernel)
> (sidorder (kernel))
>
> (sensitivity s0)
> (sensitivityorder (s0))
> (level low (s0))
> (level high (s0))
> (levelrange lowhigh (low high))
> (userlevel kernel_u low)
> (userrange kernel_u lowhigh)
>
> (context kernel_context (kernel_u kernel_r kernel_t lowhigh))
> (sidcontext kernel kernel_context)
>
> (macro test1
>     ((type domain))
>     (allow domain self (process (all)))
> )
>
> (in test1
>     (allow domain self (file (all)))
> )
>
> (block a
>     (macro test2
>         ((type domain))
>         (allow domain self (process (all)))
>     )
>
>     (in test2
>         (allow domain self (file (all)))
>     )
> )
>
> (block b
>     (blockabstract b)
>     (macro test3
>         ((type domain))
>         (allow domain self (process (all)))
>     )
> )
>
> (block c
>     (blockinherit b)
>
>     (in test3
>         (allow domain self (file (all)))
>     )
> )
>
> ; In Theory all macros: test1, a.test2, c.test3 should result in the
> same code
>
>
