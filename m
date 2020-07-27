Return-Path: <SRS0=Yzg2=BG=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00725C433F2
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 13:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50002083B
	for <selinux@archiver.kernel.org>; Mon, 27 Jul 2020 13:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwe/B5qY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgG0Niy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgG0Nix (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Jul 2020 09:38:53 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90511C061794
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 06:38:52 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id w17so12323645otl.4
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2020 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7DH1AZgXDJU8lHYxvVMWyiAxnM5Ognj9nOoKTITxM0Q=;
        b=jwe/B5qYCkyiOSgewbhn8rrycNcNQ9vtNNYQO6FKgLYx3cftYUz5QAM89NvyqhWw0t
         8mX32dx33Jc5l3UrAcilRK6X6F4joxo9RRb85hM/Ugt7B3UeHSqY2w3cue5tsnRj0jVR
         gjfs4ilrbXLLRY0xXFak3V5RHEUYzP4+/EGUqxUD1GPXj01SpyXjXw+eMrRFbPQjfdv2
         3MuRX+NEL+9a6Ypjv1GLOje4lD5yxFwhmbidL3YKpSkKnuBnbcAfOQgcXMrnKBMc6PB1
         NNGWi5OZSyJoDOPOsXpS4HJ+l5jeJi/xERg/wJsZoTH37jkjh+UTjFfIXbGzeJLiebdq
         vkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7DH1AZgXDJU8lHYxvVMWyiAxnM5Ognj9nOoKTITxM0Q=;
        b=Ij3rCJd7L4KU9k+22HGGFSRVdQZRlMIPfytMb0H8ZMMf+Y5SAeETxrT0/vrQb+mtFR
         7bm/3wzNFPEVM7SBb1LAMlK5o2tt5Mne0yzRE+OpP2m14kPBVn8EQETzTUYqSVnU9cqg
         cGBiGUmVBO1iiNIBRL3S47R3oMajGDOkmUyN38JSC3AUWucatrSurBpiY210n/U18Gr5
         r3cHlzU155Cp/R9lMAjKIvv5eNUzLfrBKWY0YoOesVx9l+w5qcQag5vm0rB0io4bPssL
         mLXpsXGTMCsgHQLPkzW4LNfqjHCYz8SjCzYPlE+TfOpOSeliMasZGA1WrUNgqvm/zx+E
         gwDg==
X-Gm-Message-State: AOAM531h6fbSa4RbyNUdhw2/tTPNCwYvATXenQ6oawmfrPx/ihhe3Z+O
        N7OZQeouPrJr0GAfxeWqIunfUimvKoTdCS3XlM4jwA==
X-Google-Smtp-Source: ABdhPJyacXttFsRO9nYLrC6T+LK+MmXBZeLj46hQWpdf4DDylPgDVYvH1QaOVMllWEJS1NH+cC1L41nvmLSUJ3rrzYQ=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr20943149oto.135.1595857131963;
 Mon, 27 Jul 2020 06:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200724175522.39286-1-cgzones@googlemail.com>
In-Reply-To: <20200724175522.39286-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 27 Jul 2020 09:38:41 -0400
Message-ID: <CAEjxPJ6nGztqAJkUydfy84eNM25CDpaO=1x_7GRy5xLxa87-2A@mail.gmail.com>
Subject: Re: [RFC PATCH] Improve getcon man page
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 24, 2020 at 1:57 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> - Improve formatting of section DESCRIPTION by adding list points
> - Mention errno is set on failure
> - Mention the returned context is guaranteed to be non NULL on success
> ---

> diff --git a/libselinux/man/man3/getcon.3 b/libselinux/man/man3/getcon.3
> index 67872a4d..b618691f 100644
> --- a/libselinux/man/man3/getcon.3
> +++ b/libselinux/man/man3/getcon.3
> @@ -110,6 +120,8 @@ context and the
>  .BR setcon ()
>  will fail if it is not allowed by policy.
>
> +.TP
> +.BR *_raw()

What's this?

>  .BR getcon_raw (),
>  .BR getprevcon_raw (),
>  .BR getpidcon_raw (),
> @@ -118,9 +130,15 @@ and
>  .BR setcon_raw ()
>  behave identically to their non-raw counterparts but do not perform cont=
ext
>  translation.
> -.
> +
>  .SH "RETURN VALUE"
> -On error \-1 is returned.  On success 0 is returned.
> -.
> +On error \-1 is returned with errno set.  On success 0 is returned.
> +
> +On success all this
> +.BR *_get()

Do you mean get*()?  Probably should just enumerate them all since
there aren't very many.

> +functions guarantee to allocate and set
> +.I *context
> +to a non\-NULL security context.
> +

I guess technically if we are going to make this promise, then
libselinux ought to explicitly implement it on the offhand chance that
there is a kernel bug or someone calls one of these libselinux
functions while running some other security module that doesn't
provide the same guarantee.
