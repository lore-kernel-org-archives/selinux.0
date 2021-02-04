Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CB9C433DB
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 17:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E2B64E8C
	for <selinux@archiver.kernel.org>; Thu,  4 Feb 2021 17:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbhBDRHm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Feb 2021 12:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbhBDRAT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Feb 2021 12:00:19 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66221C0613D6
        for <selinux@vger.kernel.org>; Thu,  4 Feb 2021 08:59:45 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id d7so4080645otf.3
        for <selinux@vger.kernel.org>; Thu, 04 Feb 2021 08:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GP3m6XoaTN7hMI01UQqO9epcFrx3jceiizAuXBYXAbM=;
        b=t7HIIo9ozGymAYGRy0crKYNfeWQL8482+xv5nBGus75WhVdUtzzFifYfF3k9dSo0Iz
         klhdsmfrCkOPwziNzpdpj9TZNjG7xeEwoHsr0B10dCwLm2OGdsUBpqkOsZTtWRV2y8IQ
         Y4dwIrfAyxLqw5HwcOOOkzuMae+3DC5oTv50P3YjMuthbxE8qSa7lmgt9FqxpsAZo4yg
         d2NixjY6vUmFvsNsk9P+8d+6l+SdQLxGOWTGE9gGqVa2B0nCfeGtOsVcMvU9iKHfkNM8
         DTVdUli5VeTVkHcdyj2xkIiWR6YLVu1C26ckFvr/KqImZ8EFuzfl0SrsQ8938DslHQmX
         f4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GP3m6XoaTN7hMI01UQqO9epcFrx3jceiizAuXBYXAbM=;
        b=DTpgNIXWpUwJk+5xoSjZUF4H8MTEeaF1z3hcjnp/x/OUcwig8RuF2d1T1egikGFqEA
         kbC55+7Mm623vISQsavhxdnpEV9skGEJ1DYTLjx7TzVGXUMasUJxNjX8vvVwI2h3m6s7
         dmFsT8TEaXIausCzG/FU4XTsNH1h8cjgD9+/WEk5BQkCjLQE//wC4zWbAgED6ubV/4KZ
         iatjLBfWFsg+W7U+YiK7UFvDaFp47qTmow6VPWxeNDMMYCKvH4d6gpHTdY+dpKrMvxUG
         ODW0sGZmsMUvQ+WLYRwUigBDq8vD7HHr8kX26+YGdN2Gn1PNOOwWX4vO9OyMOuU5T44N
         gvQw==
X-Gm-Message-State: AOAM531WCOr031cu3rHzjrSCPuROfz+OIw5P/pq1LsFdoWUDcY3ZVd9P
        9xn1BdceUZKaMrbzwNmGexHLAQVr9k9tyBoKvmU=
X-Google-Smtp-Source: ABdhPJzuCA3kfwRIBipxn3YaSLIYaG8AYoYIc1iNZj+nvmwM6o/faAxW7d2oTYvAvR8VtygWuImIp0nt9j1ls+K746o=
X-Received: by 2002:a9d:32e2:: with SMTP id u89mr218172otb.196.1612457984621;
 Thu, 04 Feb 2021 08:59:44 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7=mudsPu6FDMY29oXUSVGA7ggqkXPu0RiXa=-=jqwCZzvA@mail.gmail.com>
 <CAFftDdp6sZrysHtrt0vYzBm32CG2WN1KDKQjN+uK6GjGq2ezgg@mail.gmail.com>
In-Reply-To: <CAFftDdp6sZrysHtrt0vYzBm32CG2WN1KDKQjN+uK6GjGq2ezgg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 4 Feb 2021 12:04:46 -0500
Message-ID: <CAP+JOzRXnEK64agg1rhu6+0sqsva7c4UBr6sAbGucAaN2Z3uhg@mail.gmail.com>
Subject: Re: libsepol: signed integer overflow in the HLL line counter of CIL compiler
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 2, 2021 at 2:42 PM William Roberts <bill.c.roberts@gmail.com> wrote:
>
> On Tue, Feb 2, 2021 at 1:37 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > Hello,
> >
> > OSS-Fuzz found an integer overflow when compiling the following
> > (empty) CIL policy:
> >
> > ;;*lms 2147483647 a
> > ; (empty line)
> >
> > ";;*lms" is a line mark which can be produced by the HLL compiler (if
> > I understand correctly the meaning of CIL_KEY_HLL_LMS in
> > libsepol/cil/src/cil_parser.c). The line number is parsed as an "int"
> > variable:
> >
> >   *hll_lineno = strtol(tok.value, &end, 10);
> >   if (errno == ERANGE || *end != '\0') {
> >     cil_log(CIL_ERR, "Problem parsing line number for line mark\n");
> >     goto exit;
> >   }
> >
> > This code has another issue which is that it silently truncates values
> > to 32-bit signed integers on systems where sizeof(long) is 8, because
> > hll_lineno is of type "int *", not "long *".
> >
> > But the issue found by OSS-Fuzz is that when 2147483647 is used (which
> > is INT_MAX, 0x7fffffff in hexadecimal), "hll_lineno++;" overflows the
> > capacity of signed integers, in cil_parser(), and this is an undefined
> > behavior. This could be fixed by limiting the number of lines in a
> > source file to some sane value. Another approach consists in emitting
> > a warning and resetting the line counter every time it reaches
> > INT_MAX. Thoughts?
>
> I would lean towards using the proper type, so we get the full range depending
> on architecture and warn on lineno wrap, but let it happen. IIUC,
> Lineno is a helper.
> I don't see it really affecting anything, so why make it a fatal error.
>

I agree that it doesn't need to be a fatal error. I think it should be
read into an unsigned long and then checked using something like what
Nicolas did in cil_fill_integer() before being saved in hll_lineno.
Also, it makes sense to just make hll_lineno be a uint32_t.

I am working on a patch, but I won't be able to send it out until late
this afternoon.

Jim

> >
> > For reference (and for the people who have access to it), the related
> > OSS-Fuzz issue is
> > https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28751.
> >
> > Cheers,
> > Nicolas
> >
