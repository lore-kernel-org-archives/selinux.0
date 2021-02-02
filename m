Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82646C4332B
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 19:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FEBF64E08
	for <selinux@archiver.kernel.org>; Tue,  2 Feb 2021 19:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbhBBThK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Feb 2021 14:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239774AbhBBTgd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Feb 2021 14:36:33 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD728C061573
        for <selinux@vger.kernel.org>; Tue,  2 Feb 2021 11:35:52 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id b187so7489744ybg.9
        for <selinux@vger.kernel.org>; Tue, 02 Feb 2021 11:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmyhhEkubGf/AP+454Qeer2Dh8gwXL9oPCgQjmn4k2o=;
        b=aTa8Ls+gDtJ/0gy4zF9EaSBsEk7QrU97Kk01xYEJxOZJXpDZqsWmJFPFubIraBBhIj
         Uq68CHRKisHcPp3cgHYVWWsBOjQ7iGafQBG0BWXkDNS3s7SpsX/ohD7Md6hiW+n4Pf8c
         KlG4bTtqdE3/mKerg5A4f0h1Vo9rWmRRJmErQCG47mTcorW7b34ztgJg9ur9wv/piLuL
         TgyxjbOG5Y5UykUg9IjFqng4gF14yYXdyV8HcZPzwo6VoGMI24QJRiTB6ddRt8ZlCiII
         fcgAKdAILVCbtVzO2fXWy+iFnY/sRsAxxB3d6Pqtf4DS+ue/pU3S6DhIvdmAXpYVq+dt
         rFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmyhhEkubGf/AP+454Qeer2Dh8gwXL9oPCgQjmn4k2o=;
        b=PctLo61g+rGvr/C0L9n3zg1yzBgenrm4UgetMu3JcFuLes+tKy96JO14iXT0okflF8
         M01zp54nrJznaFPQ/52CaM0Pozedl0DleZZs8z+ot/8heXnquXetYp8/FwacBe2LJMSq
         vxR00lwcaGGUInVXQ/D2GmndlNcXTNFdTBP8Uyr+6+J17mhVLa9d1872/Ueffz/Oe+SH
         fTupvxMiTxhWIDXleSCsVshIHdWxM8Y4F1kplwfGPys3UBfBlH/IY3UMa0Fv0ij5+SLT
         XFPjvNdJNe+fMxow+g46eHUMSl6V8R4A103ONeuwntUhMdcT4PHDe0WtHVOWKPB8V8v4
         KDtg==
X-Gm-Message-State: AOAM531n0vSIYEpOdaI//FKmCYM1EjhLSF5NNjjkftMSAxwn3uYF72rk
        C68zZEIkiZWoPf0z4lrbS6AyH2NJnAf5ewR/DsdlVXuaVyc=
X-Google-Smtp-Source: ABdhPJyGa3DrgBhE4W7RyaTRyfa9AFJBbkuUuOfzZvnIMSnD07WlkLPOcYe9mKTNwVC6WnbuT+TKz2qTqhqRJO2EYrA=
X-Received: by 2002:a25:e606:: with SMTP id d6mr14374618ybh.187.1612294551994;
 Tue, 02 Feb 2021 11:35:51 -0800 (PST)
MIME-Version: 1.0
References: <CAJfZ7=mudsPu6FDMY29oXUSVGA7ggqkXPu0RiXa=-=jqwCZzvA@mail.gmail.com>
In-Reply-To: <CAJfZ7=mudsPu6FDMY29oXUSVGA7ggqkXPu0RiXa=-=jqwCZzvA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 2 Feb 2021 13:35:41 -0600
Message-ID: <CAFftDdp6sZrysHtrt0vYzBm32CG2WN1KDKQjN+uK6GjGq2ezgg@mail.gmail.com>
Subject: Re: libsepol: signed integer overflow in the HLL line counter of CIL compiler
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 2, 2021 at 1:37 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Hello,
>
> OSS-Fuzz found an integer overflow when compiling the following
> (empty) CIL policy:
>
> ;;*lms 2147483647 a
> ; (empty line)
>
> ";;*lms" is a line mark which can be produced by the HLL compiler (if
> I understand correctly the meaning of CIL_KEY_HLL_LMS in
> libsepol/cil/src/cil_parser.c). The line number is parsed as an "int"
> variable:
>
>   *hll_lineno = strtol(tok.value, &end, 10);
>   if (errno == ERANGE || *end != '\0') {
>     cil_log(CIL_ERR, "Problem parsing line number for line mark\n");
>     goto exit;
>   }
>
> This code has another issue which is that it silently truncates values
> to 32-bit signed integers on systems where sizeof(long) is 8, because
> hll_lineno is of type "int *", not "long *".
>
> But the issue found by OSS-Fuzz is that when 2147483647 is used (which
> is INT_MAX, 0x7fffffff in hexadecimal), "hll_lineno++;" overflows the
> capacity of signed integers, in cil_parser(), and this is an undefined
> behavior. This could be fixed by limiting the number of lines in a
> source file to some sane value. Another approach consists in emitting
> a warning and resetting the line counter every time it reaches
> INT_MAX. Thoughts?

I would lean towards using the proper type, so we get the full range depending
on architecture and warn on lineno wrap, but let it happen. IIUC,
Lineno is a helper.
I don't see it really affecting anything, so why make it a fatal error.

>
> For reference (and for the people who have access to it), the related
> OSS-Fuzz issue is
> https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=28751.
>
> Cheers,
> Nicolas
>
