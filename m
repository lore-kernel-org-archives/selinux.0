Return-Path: <SRS0=Vikk=BC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BCAC433E3
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 01:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A89520781
	for <selinux@archiver.kernel.org>; Thu, 23 Jul 2020 01:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ohaCDL3i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387463AbgGWBzJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgGWBzI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jul 2020 21:55:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CEEC0619DC
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 18:55:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a21so4640270ejj.10
        for <selinux@vger.kernel.org>; Wed, 22 Jul 2020 18:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kg0C9/jzZdX4mTlzT+XZ+cVJtD+z9T8XvgDI1N+8u44=;
        b=ohaCDL3igMlcOdv6+iGx2enUGswTy1+k1DlkVA71OLZc8TEZH0e6gBTHLB+GU8ZMIk
         Tm1JAqFIzWwpIMvBp/INrVF+Gm6nddyTET0QqSkRUTlJWS2+cH2kFEgVDL1LId9e5Nqx
         3cW4R31RyPmBmE2mNn2mLOZt2S0vL7AaW+hwWDVnRFK1IwLntOubhPqiFDpbfa7U5V8o
         dOoL2TFM9nFIqdcguvEmO4DpFhuQzR7BWM6ApQeHsVx3yVoaSjTbq6ZV436VY34AVVVM
         jV5el0OByMMbzZt7ldrQP2cxkFS/Y6ecRh22fNTCoZJvRCZ8yBQLIOyD8DQkydWQM2IR
         3wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kg0C9/jzZdX4mTlzT+XZ+cVJtD+z9T8XvgDI1N+8u44=;
        b=kHte5vfleJ3aj1nyn7Vp5UgygBMNfitU9KmH2P8WZ9GroL0iwGoTJjQ5Ns0C7WITzz
         oWIBGvsQ3AQOvbZn+378PRAQ1/Uork8x8rg2oEWNMdMyJEKegbz/DiJrTOZRm9MsWaCA
         J5vCvFqpJQMSfwtJ+Oh/1RxDmRulJ2xlf5HHGE6TNQWXTlbbMu3orL9P4SLW63R7SDY8
         v+1zpbYQL1NMxD4GhpEQ2hbob/z3953ScQB5LaeqQo/dWbMVC7qMCNRsTB3rJns55Bij
         zbNuaxsus5MJX3/O4sTscsY4MpLiBQdpL503Tu8k5tTkRX4XQYPSlZaGYdaQ50ytrz7B
         +2Dw==
X-Gm-Message-State: AOAM532MoxF8BI60YPSO7Ku+dYscOzgH06+ejUsT098tl8Yl54hpFKdd
        vY/p/4q9dTLK7PRMjak3yqhao4lgskJMiGa+TVjL
X-Google-Smtp-Source: ABdhPJwtrS4XcQ2XjHZj6RcfNndV3JtS77yMC6/vTiB+s8gQG9WaxNsnFaVAli9keyI8lOFHCaCniyX/FmjuEioTOWc=
X-Received: by 2002:a17:906:1403:: with SMTP id p3mr2241802ejc.106.1595469307158;
 Wed, 22 Jul 2020 18:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ49qjVJi1m-bJkaBg2ufx9xx5hPa_HupXbm-6eqXc_j5Q@mail.gmail.com>
 <20200721195726.1975554-1-dominick.grift@defensec.nl>
In-Reply-To: <20200721195726.1975554-1-dominick.grift@defensec.nl>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Jul 2020 21:54:55 -0400
Message-ID: <CAHC9VhTUsk810LCqBuAqw5pXHMm2KoE3RsN2p1hhp203f=yaqA@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH v2] lsm_selinux: document
 genfs_seclabel_symlinks policy capability
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 21, 2020 at 3:57 PM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> This was added with Linux 5.7 and SELinux 3.1
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
> ---
> v2: copied and pasted feedback from Stephen Smalley
>
>  src/lsm_selinux.md | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/src/lsm_selinux.md b/src/lsm_selinux.md
> index a400c36..f762614 100644
> --- a/src/lsm_selinux.md
> +++ b/src/lsm_selinux.md
> @@ -676,6 +676,11 @@ interface, it is not recommended - use the **libselinux** or **libsepol** librar
>  <td>Enables the use of separate socket security classes for all network address families rather than the generic socket class.</td>
>  </tr>
>  <tr>
> +<td>genfs_seclabel_symlinks</td>
> +<td>-r--r--r--</td>
> +<td>Enables fine-grained labeling of symlinks in pseudo filesystems based on genfscon rules.</td>
> +</tr>
> +<tr>
>  <td>network_peer_controls</td>
>  <td>-r--r--r--</td>
>  <td><p>If true the following network_peer_controls are enabled:</p>
> --
> 2.27.0

Merged into main, thanks!

-- 
paul moore
www.paul-moore.com
