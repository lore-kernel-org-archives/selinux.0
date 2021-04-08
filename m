Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CBFC433ED
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 17:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0160D610E5
	for <selinux@archiver.kernel.org>; Thu,  8 Apr 2021 17:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhDHRgf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Apr 2021 13:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhDHRgf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Apr 2021 13:36:35 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505C8C061760
        for <selinux@vger.kernel.org>; Thu,  8 Apr 2021 10:36:24 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso3144814otp.0
        for <selinux@vger.kernel.org>; Thu, 08 Apr 2021 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqyyJWZvEacA2V3gCUPT1fTDYzHEHaP4C5mvqKK87/k=;
        b=iveKizTeBAjxryVAunTyyexCC7IpiLEmpqKX3TS2kLp+bLugAyeLEpnh48PTkX2dRN
         CROUXwmIKfFMexW0UkoUpAbLtgilrQOY2mAqb+VIZabK5DKQJ4loRHV0SuEs82mIuuZX
         oxFW4h0mFcQryH1xlmc9fQwRIBXseg7TxyHq0za4pYhU+CoUm0oZ+Opb/+KflN9o7TOw
         drT3Ssc4UCdDb/Ey4DoK1/3pV42NU9IOAhoXVTJkwFsYTv71PCoDmm26Gk2mFAAOfV9A
         VEjAe9hKx68aMrlK0hoO+njitchoT2x7yEWUogpiCGGN0uVmbXVS/Ep7D+ab5ej5G9YL
         JEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqyyJWZvEacA2V3gCUPT1fTDYzHEHaP4C5mvqKK87/k=;
        b=EDM0JNq/7mqsRZs2nI/gztY5CY/3tI+yKbtIgrp+hy4bfyPZsUkw7OCfoNiJR8SUAY
         JGkPPDcSv1CL/1Dz6/lclzqEZlJksG8kV1oYjtCiEJL5nWf/teue1tssxY/mm454iTdn
         d7jfgL1XnWXrLJ5TYIahv5RX3QbMz71B0VhaeBPkzdseZsW1hlIiLEXgaC1HWpNbVafD
         8qMg6C86teiGBwoFgfVBNOVCdug9wliNyW09nVXh9z2LUEQ5Mu2XSEYolpepRZQkjMbc
         2BsqJX5HwT0SSXzGO9yi35HQ83qF+XCM8YosLpEyDLvXTyGOq6rgnZxsy+2b11Gu5RVm
         1P9w==
X-Gm-Message-State: AOAM533v9V8zjEl7lUG7bIaV3cxTlhDj9NkCWk9ltBOzqAmS6+UvLnoL
        ChSHbxnzUrmhIFuJkBSqbL4O0d2tFgB/E33QDDatWqrssw8=
X-Google-Smtp-Source: ABdhPJxKQ99ButijMZGZlHpTd/8CZ5dVBLd4eySMamKgzBg0B3W93r4KqupJ91fWzWZLsRLmhc6Q579+hqBlRqIkHQs=
X-Received: by 2002:a9d:aa4:: with SMTP id 33mr8732906otq.295.1617903383723;
 Thu, 08 Apr 2021 10:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210324151105.3765449-1-dominick.grift@defensec.nl> <CAP+JOzSRN4g3MCgaMBuRvAVhy4ftZ+sw=zK+KPracuLzCC6AzQ@mail.gmail.com>
In-Reply-To: <CAP+JOzSRN4g3MCgaMBuRvAVhy4ftZ+sw=zK+KPracuLzCC6AzQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 8 Apr 2021 13:36:12 -0400
Message-ID: <CAP+JOzStdTsOEWy9ANKTur9fraQuyBuLUVDwUvogY2CG7OsrYQ@mail.gmail.com>
Subject: Re: [PATCH] cil_conditional_statements.md: fix expr definition
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 29, 2021 at 11:13 AM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Mar 24, 2021 at 11:13 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
> >
> > expr "(expr (tunable_id tunable_id))" does not work but "(expr
> > tunable_id tunable_id)" does work
> >
> > for example, this works
> >
> > (tunable test1)
> > (tunable test2)
> > (tunableif (or test1 test2)
> >            (true
> >             (allow a b (c (d)))))
> >
> > but this does not work:
> >
> > (tunable test1)
> > (tunable test2)
> > (tunableif (or (test1 test2))
> >            (true
> >             (allow a b (c (d)))))
> >
> > Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Applied. Thanks,
Jim

> > ---
> >  secilc/docs/cil_conditional_statements.md | 24 +++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/secilc/docs/cil_conditional_statements.md b/secilc/docs/cil_conditional_statements.md
> > index a55a9b6c..55f0bfd6 100644
> > --- a/secilc/docs/cil_conditional_statements.md
> > +++ b/secilc/docs/cil_conditional_statements.md
> > @@ -78,12 +78,12 @@ Contains the run time conditional statements that are instantiated in the binary
> >  <tr class="odd">
> >  <td align="left"><p><code>expr</code></p></td>
> >  <td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
> > -<p><code>    (and (boolean_id boolean_id))</code></p>
> > -<p><code>    (or  (boolean_id boolean_id))</code></p>
> > -<p><code>    (xor (boolean_id boolean_id))</code></p>
> > -<p><code>    (eq  (boolean_id boolean_id))</code></p>
> > -<p><code>    (neq (boolean_id boolean_id))</code></p>
> > -<p><code>    (not (boolean_id))</code></p></td>
> > +<p><code>    (and boolean_id boolean_id)</code></p>
> > +<p><code>    (or  boolean_id boolean_id)</code></p>
> > +<p><code>    (xor boolean_id boolean_id)</code></p>
> > +<p><code>    (eq  boolean_id boolean_id)</code></p>
> > +<p><code>    (neq boolean_id boolean_id)</code></p>
> > +<p><code>    (not boolean_id)</code></p></td>
> >  </tr>
> >  <tr class="even">
> >  <td align="left"><p><code>true</code></p></td>
> > @@ -196,12 +196,12 @@ Compile time conditional statement that may or may not add CIL statements to be
> >  <tr class="odd">
> >  <td align="left"><p><code>expr</code></p></td>
> >  <td align="left"><p>Zero or more <code>expr</code>'s, the valid operators and syntax are:</p>
> > -<p><code>    (and (tunable_id tunable_id))</code></p>
> > -<p><code>    (or  (tunable_id tunable_id))</code></p>
> > -<p><code>    (xor (tunable_id tunable_id))</code></p>
> > -<p><code>    (eq  (tunable_id tunable_id))</code></p>
> > -<p><code>    (neq (tunable_id tunable_id))</code></p>
> > -<p><code>    (not (tunable_id))</code></p></td>
> > +<p><code>    (and tunable_id tunable_id)</code></p>
> > +<p><code>    (or  tunable_id tunable_id)</code></p>
> > +<p><code>    (xor tunable_id tunable_id)</code></p>
> > +<p><code>    (eq  tunable_id tunable_id)</code></p>
> > +<p><code>    (neq tunable_id tunable_id)</code></p>
> > +<p><code>    (not tunable_id)</code></p></td>
> >  </tr>
> >  <tr class="even">
> >  <td align="left"><p><code>true</code></p></td>
> > --
> > 2.30.1
> >
