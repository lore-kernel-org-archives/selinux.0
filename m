Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F44CC433DB
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 15:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA9BC61968
	for <selinux@archiver.kernel.org>; Mon, 29 Mar 2021 15:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhC2PNw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Mar 2021 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhC2PNZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Mar 2021 11:13:25 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F7AC061574
        for <selinux@vger.kernel.org>; Mon, 29 Mar 2021 08:13:24 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n140so13364560oig.9
        for <selinux@vger.kernel.org>; Mon, 29 Mar 2021 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VwMBtJwqGAO4g8rvYEZDMGySRtdRuORtxeEs06HTSLQ=;
        b=Vx9dCJemEeA3UHb2ruGOds3o5bEez30qjhZocsoKwM2TXdEpNV/pRhzQ8hcZnX2opH
         zlDAN/+v0+fAOyMexk1DpajPE/ca9zdomUu5QoNHRtrAaNkxYMWa6Vgp5wFklIMDsMwR
         vjqV7QnB+bAeZJd95RrYqbJCrh7Zvw0PobTjRGIevL0zcNz/XLYR9+/nGPHg2HWAiGkc
         LnRDukCda4B2y3QAj5fhL9FfGnklAGmnGU4ZjlLjatl3TgTJBSI1n6r3e/WRgZrqDVsF
         SyuxeqHSBvima0iNshNDyBzFAURbF1huc3TLvlCruj7bIrBocvQqRbbfxVdOVsFgfdeo
         9ouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VwMBtJwqGAO4g8rvYEZDMGySRtdRuORtxeEs06HTSLQ=;
        b=hw44F13Fl7l0GiS3eBcVouvNh5wpHpAGnjxPQAw18ymTiKNo4NhrN9tayozNjfMefq
         Uzd/oF8GbmL6rhoRcnl8GcOXVxyIaRava/rNEqV0Dl/y7BCnCPtxGdI6O4Pa/2Ld3OsA
         DX/KedUxw/4xfcM741rKLEWR95HHncCS/wIeclvBgC3HS4ax/oKad7ruj25qTLn4f9lk
         PuLc/9qTWIYN5om67QTXctSZhVF8WYpItBB2oMvF6uWweC8NZWpqKMVfFH2utE6X5JPd
         qCtzJELkWsayhkRQWrwz0PEugUHaFJlVtoKy8irHPqi8m+vHp59Tj6lrllHs+2ZGiT4E
         Dxxw==
X-Gm-Message-State: AOAM531q6UcjTRakEqn+Tx4KBUsdO3pUE0K1QknMgoyCShxAyx1I0KWx
        N6JqkgyKuQPoJdHpEocdhH62zKmVpOml9XzLOWSKtSh9I3y7Jw==
X-Google-Smtp-Source: ABdhPJzpSGVkh/LgO8L4DQiNwWjkfS5YEiGLeYSuprDjxKQvZzpEpAxFKVFPR/XCfQsLuD5NfrdN1KdPWTKF64n95nI=
X-Received: by 2002:aca:5ad6:: with SMTP id o205mr19589911oib.128.1617030802953;
 Mon, 29 Mar 2021 08:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210324151105.3765449-1-dominick.grift@defensec.nl>
In-Reply-To: <20210324151105.3765449-1-dominick.grift@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 29 Mar 2021 11:13:12 -0400
Message-ID: <CAP+JOzSRN4g3MCgaMBuRvAVhy4ftZ+sw=zK+KPracuLzCC6AzQ@mail.gmail.com>
Subject: Re: [PATCH] cil_conditional_statements.md: fix expr definition
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 24, 2021 at 11:13 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> expr "(expr (tunable_id tunable_id))" does not work but "(expr
> tunable_id tunable_id)" does work
>
> for example, this works
>
> (tunable test1)
> (tunable test2)
> (tunableif (or test1 test2)
>            (true
>             (allow a b (c (d)))))
>
> but this does not work:
>
> (tunable test1)
> (tunable test2)
> (tunableif (or (test1 test2))
>            (true
>             (allow a b (c (d)))))
>
> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  secilc/docs/cil_conditional_statements.md | 24 +++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/secilc/docs/cil_conditional_statements.md b/secilc/docs/cil_conditional_statements.md
> index a55a9b6c..55f0bfd6 100644
> --- a/secilc/docs/cil_conditional_statements.md
> +++ b/secilc/docs/cil_conditional_statements.md
> @@ -78,12 +78,12 @@ Contains the run time conditional statements that are instantiated in the binary
>  <tr class="odd">
>  <td align="left"><p><code>expr</code></p></td>
>  <td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
> -<p><code>    (and (boolean_id boolean_id))</code></p>
> -<p><code>    (or  (boolean_id boolean_id))</code></p>
> -<p><code>    (xor (boolean_id boolean_id))</code></p>
> -<p><code>    (eq  (boolean_id boolean_id))</code></p>
> -<p><code>    (neq (boolean_id boolean_id))</code></p>
> -<p><code>    (not (boolean_id))</code></p></td>
> +<p><code>    (and boolean_id boolean_id)</code></p>
> +<p><code>    (or  boolean_id boolean_id)</code></p>
> +<p><code>    (xor boolean_id boolean_id)</code></p>
> +<p><code>    (eq  boolean_id boolean_id)</code></p>
> +<p><code>    (neq boolean_id boolean_id)</code></p>
> +<p><code>    (not boolean_id)</code></p></td>
>  </tr>
>  <tr class="even">
>  <td align="left"><p><code>true</code></p></td>
> @@ -196,12 +196,12 @@ Compile time conditional statement that may or may not add CIL statements to be
>  <tr class="odd">
>  <td align="left"><p><code>expr</code></p></td>
>  <td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
> -<p><code>    (and (tunable_id tunable_id))</code></p>
> -<p><code>    (or  (tunable_id tunable_id))</code></p>
> -<p><code>    (xor (tunable_id tunable_id))</code></p>
> -<p><code>    (eq  (tunable_id tunable_id))</code></p>
> -<p><code>    (neq (tunable_id tunable_id))</code></p>
> -<p><code>    (not (tunable_id))</code></p></td>
> +<p><code>    (and tunable_id tunable_id)</code></p>
> +<p><code>    (or  tunable_id tunable_id)</code></p>
> +<p><code>    (xor tunable_id tunable_id)</code></p>
> +<p><code>    (eq  tunable_id tunable_id)</code></p>
> +<p><code>    (neq tunable_id tunable_id)</code></p>
> +<p><code>    (not tunable_id)</code></p></td>
>  </tr>
>  <tr class="even">
>  <td align="left"><p><code>true</code></p></td>
> --
> 2.30.1
>
