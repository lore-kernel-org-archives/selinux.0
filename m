Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBE5C433EC
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 12:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9CA2073A
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 12:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVU+2Er9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGUM7b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgGUM7a (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 08:59:30 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59672C061794
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 05:59:30 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id e4so17111726oib.1
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 05:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVX8zdidRkr8jPR4yAi/O95aNpvXwyCDM/L8i5GNaEo=;
        b=MVU+2Er957dA4qjymQJ/mfBOOZmS5UrMvgfkao1p1KI2DqChLlGsdZscyVZVvFXW/+
         88y301pgj/nxaiL8zeasibU0n+upjjMUWnojLO8Kmm3PcOj1Gdf2ICVnWEBZdwd2/H25
         A/JKuDzqKz/A5kPNLiwla9PYHLz1w3kxt+qSdqz63xeIOZq4clGcLH/ya0rsl7yPFDvW
         tPw7A2SElT1QK/qE7xoQXblKtnNF2Scz3pFwJlGwLtYwx0h0leUYljrkICsKeKYB3Rml
         TBE+mC4UGySG6lonPpWf3LzDtx+kLVHl6+VULaAHOgzpzy8YWNRCteCkTIpeFVjVYkdC
         pN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVX8zdidRkr8jPR4yAi/O95aNpvXwyCDM/L8i5GNaEo=;
        b=r0YW7OSEM3DFVTxR/TWh+zLLV4JfnirGvd+W/0yKM0RqcAXv5xwbo+PdPum7cWv1bS
         gyRqwzNFBb0k+L1IJIWU3DMIkgDaPEFR0NBcXQsj0TlDIh8rBDxa8nXGNgVMlC7KDIOO
         3E8oYeiNsY8PMxyM1J9MiVcXqw5yOZuHnym6OoVVXZBJkL+r5gRPI8pkn5TdRgjSqTf2
         cj5NTlVBQD3qYnHd/+Td00waueAx+EXR2xuVYdhWAMx/dS0lVgJ3qfFUPF8tK6h0KE4G
         xPYzjGnWd3wPyHMha1NQjCOj+yWn8IbaKYCjJw61UulWIwulSIxnespH4sItCRZYd77K
         V9Vg==
X-Gm-Message-State: AOAM533QJ2Pgzwq5xVnydtHJ5mAw811f9TWdoPtZ4vpfYjS525zR4k+m
        z4iRIFtjc12euDi7o8NiKG78fLm8S3W2nKluU7k=
X-Google-Smtp-Source: ABdhPJykVqDi2xbj3DRulbFgNirD5UHsY2aWpEexedNU/WqQQtLEp0R/mtEu3vFeOQy7t5cfgFLMdMLppDkFwNcxiAs=
X-Received: by 2002:aca:ecd3:: with SMTP id k202mr1124674oih.92.1595336369709;
 Tue, 21 Jul 2020 05:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200721115734.GA43979@aloka.lostca.se>
In-Reply-To: <20200721115734.GA43979@aloka.lostca.se>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 21 Jul 2020 08:59:18 -0400
Message-ID: <CAEjxPJ5wZ6HE0hA7+RAPfJkzL_W3LTLop9gNb8GxkHxMkLEAcA@mail.gmail.com>
Subject: Re: [RFC] Porting glibc away from deprecated libselinux APIs
To:     Arjun Shankar <arjun.is@lostca.se>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 21, 2020 at 8:07 AM Arjun Shankar <arjun.is@lostca.se> wrote:
>
> Hi,
>
> glibc currently uses several recently deprecated libselinux APIs:
>
> 1. makedb uses matchpathcon:
>
> https://sourceware.org/git/?p=glibc.git;a=blob;f=nss/makedb.c;h=8e389a1683747cf1047f4de8fe603f2b5ccc5f3f;hb=HEAD

Should migrate to selabel_open/lookup/close.

> 2. nscd uses avc_init and multiple old style callbacks:
>
> https://sourceware.org/git/?p=glibc.git;a=blob;f=nscd/selinux.c;h=a4ea8008e201b9397aa4274bb558de471b0573af;hb=HEAD

Wondering if nscd can migrate to using the higher level
selinux_check_access() interface instead of direct usage of the
avc_*() interfaces.

> We are currently trying to replace these uses with the newer interfaces,
> with a proposed makedb patch written by Aurelien Jarno attached with this
> email, and being discussed here:
> https://sourceware.org/pipermail/libc-alpha/2020-July/116504.html
>
> Would you be able to help review this and any follow-ups?

Yes, please cc the selinux list on any future patches.

> diff --git a/nss/makedb.c b/nss/makedb.c
> index 8e389a16837..a5c4b521172 100644
> --- a/nss/makedb.c
> +++ b/nss/makedb.c
> @@ -846,7 +847,8 @@ set_file_creation_context (const char *outname, mode_t mode)
>  {
>    static int enabled;
>    static int enforcing;
> -  security_context_t ctx;
> +  struct selabel_handle *label_hnd = NULL;
> +  char* ctx;
>
>    /* Check if SELinux is enabled, and remember. */
>    if (enabled == 0)
> @@ -858,9 +860,16 @@ set_file_creation_context (const char *outname, mode_t mode)
>    if (enforcing == 0)
>      enforcing = security_getenforce () ? 1 : -1;
>
> +  /* Open the file contexts backend. */
> +  label_hnd = selabel_open(SELABEL_CTX_FILE, NULL, 0);
> +  if (!label_hnd)
> +    if (setfscreatecon (ctx) != 0)

The setfscreatecon(ctx) call here makes no sense to me.  You haven't
yet looked up a context.  And if !label_hnd, then selabel_open()
failed.

> +      error (enforcing > 0 ? EXIT_FAILURE : 0, 0,
> +            gettext ("cannot initialize SELinux context"));
> +
>    /* Determine the context which the file should have. */
>    ctx = NULL;
> -  if (matchpathcon (outname, S_IFREG | mode, &ctx) == 0 && ctx != NULL)
> +  if (selabel_lookup(label_hnd, &ctx, outname, S_IFREG | mode) == 0 && ctx != NULL)

ctx can't be NULL if selabel_lookup() returned 0.

>      {
>        if (setfscreatecon (ctx) != 0)
>         error (enforcing > 0 ? EXIT_FAILURE : 0, 0,
> @@ -868,7 +877,11 @@ set_file_creation_context (const char *outname, mode_t mode)
>                outname);
>
>        freecon (ctx);
> +      selabel_close(label_hnd);

You don't want to call this twice on the same handle.

>      }
> +
> +  /* Close the file contexts backend. */
> +  selabel_close(label_hnd);
