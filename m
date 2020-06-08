Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C0AC433E0
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 15:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C03206D5
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 15:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBUUrqfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgFHPVD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729668AbgFHPVD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 11:21:03 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D166C08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 08:21:03 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id b18so13940207oti.1
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4SSmacygWV9Am6wKKCLNQ9QOKVfFZrz9ZiL835aLtR0=;
        b=sBUUrqfjpPIZU6Bn29wiufccbzFPIwwlDwmaV8dkbIhiqMjKQwDLTfSduzxxKk6Arb
         i+8uRWikGPoDDOK9dhy+i42QfD9IdKs6UlXMjMMjwqTMl1PaOX00hN6BCMseU4rHnPLv
         2bjkfkLgbGns/q5kNUYKacF1rdVjp2FoTf2x8Ak1jXqCg0ewmBVN4/gVkf6Z3zQ7z3si
         hgetde4FcfkunaYpWOgJgalHhvi0BV7msc3gGFhQwIk/9b/E4/vwwg77mzCbJGjoBcdk
         k8IBxO/vKGPitIiJDnuy8mZBrcw6QPfdvl1DgKkLbmbvuRbhp4F7fUIB9LBtTvqXt5Bt
         4uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4SSmacygWV9Am6wKKCLNQ9QOKVfFZrz9ZiL835aLtR0=;
        b=fMjcK/exn/miRA1v6V/sp3Mig+s9uls16oLl/w/zFwIJk8hlZHSjRyiEvXwQ2KtCj7
         jincC9YmxP4Xa4sSlOku+2HawavGWwgImwb4CuLW9J1bXeVvPzL5M50GLc3c2v+U7Ubg
         Aqnrt9lBiLPw4TqoPJekznK98BihDkhklmPUAeInit4qpz3wVCy9tQG/ncoimF5bX1Jr
         JLig1dcZGsqdcOtSFwMkJvQJCRp68ORCtkQ86+D1D/OI04UVYZZ55mrTH4PdlWo8pHhG
         6AJQeptIk2Crr3Tayc/5D2kngz/pi/3bbBFaNkF978BpjPOB7NX3qfxGEVpe9SwEnukU
         +9Og==
X-Gm-Message-State: AOAM5335HyPNP30eyK8C+ME2dT+uh+F7KaWOQIFyMFNJrlefK7AEkRng
        Bp5f+lDYvrbcFXQzRpa5Hv04pIKa93sjR2c22Fk9y4YK
X-Google-Smtp-Source: ABdhPJx6tJtfbt4LsxTzdtpEYczcL87GTDsloo30LLgeh8jm4S4tIpSAi1rmbOVkdwLKJB4FKLSekFgPCQ6Ge78V6i4=
X-Received: by 2002:a05:6830:2003:: with SMTP id e3mr16998702otp.89.1591629662475;
 Mon, 08 Jun 2020 08:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200603101534.4666-1-toiwoton@gmail.com>
In-Reply-To: <20200603101534.4666-1-toiwoton@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 8 Jun 2020 11:20:51 -0400
Message-ID: <CAEjxPJ5sshiJ+UC1F7EouwpHOsZOaR8X8EyYYKHHcnHjEOk40Q@mail.gmail.com>
Subject: Re: [PATCH] semanage-node.8: describe netmask
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 3, 2020 at 6:16 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> Network Mask argument for `semanage node` accepts also the simple CIDR
> mask format, so let's document it.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  python/semanage/semanage-node.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/python/semanage/semanage-node.8 b/python/semanage/semanage-node.8
> index e0b0e56c..a0098221 100644
> --- a/python/semanage/semanage-node.8
> +++ b/python/semanage/semanage-node.8
> @@ -45,7 +45,7 @@ Extract customizable commands, for use within a transaction
>  Remove all local customizations
>  .TP
>  .I   \-M NETMASK, \-\-netmask NETMASK
> -Network Mask
> +Network Mask, either in CIDR (/16) or address mask notation (255.255.0.0, ffff::)
>  .TP
>  .I   \-t TYPE, \-\-type TYPE
>  SELinux type for the object
> --
> 2.26.2
>
