Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB25C433FE
	for <selinux@archiver.kernel.org>; Fri, 11 Feb 2022 19:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352993AbiBKTsW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Feb 2022 14:48:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352987AbiBKTsV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Feb 2022 14:48:21 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5C82A6
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 11:48:17 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id p190-20020a4a2fc7000000b0031820de484aso11516705oop.9
        for <selinux@vger.kernel.org>; Fri, 11 Feb 2022 11:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wXfqcuIO3dfU/7WgHLoi0qNm8eeEGxxr+e5mJyHLvGU=;
        b=QgNvx0NlKPk2rya2kq3pZ8RLGUwuZ6Bzc0h2Cqb4SRukJqw/gK+lZBAGX5O9ipMqFx
         A2iiOYL2R66XXiShfb2/rhY0LNcpcku4m6UNZmGswCKJRkb/Fc9NNVND5/XPqNsfJM0l
         QCRTybWFrZYwmErg2VS4blGTxn1XHUI7HLoJF6Z7f0UulIUdMRYeXcGPTMaxBeeZCMqi
         orGftqfnWF6vU8Wvfj6oyL6NTBfs0FxOvURroZq2NKFSWk9gy2zu7LHxGyk6WoULBexZ
         q2hG1dmt3xLFnBMJPOgf0PGWC7g7ONXXgTEQqtwRfsgyz5+RNR/VzEQfE+vD7ky5sKBp
         /qVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wXfqcuIO3dfU/7WgHLoi0qNm8eeEGxxr+e5mJyHLvGU=;
        b=X51sH7X4+GSFlrCyFUFjokTRvESUUV0op+JtV5nJYOunidVgq9dBdZmvTwMov8IjMH
         J1P5WnMZNLYTMwsv/i9qz8sU1FTcjiMK9KPh97H1oA5jYh6DGAcsXNM1y2EIco8R/1Ny
         DSr9xYDzZLW6RACXrI4CLknPaUWaZFhbk98/PdlKF1Ri8cPg9MlyuJjApIwOBQR4V2Ek
         TF7cw8Oiac5pIi4JjqezGRgeCVCPxZmJujH+K/p4o83Wrca+ZhYsaewZdlMI2+FX8lUe
         mv4MlEoLIuc8fpIxTHrpgPSswZ26Khs292E/tp8UGeQyk8lfh7BurFkBqpRG3RNA76Im
         wLoA==
X-Gm-Message-State: AOAM5311JI+akWDFguLuSHDqHnShqnRqqLMcF1jVaq3Xp0qnl27fDt9T
        nc2jfAF+mvIp2q0mLdtkR8UqzLgsB2G+SpSHF7Yr7Vlc
X-Google-Smtp-Source: ABdhPJx/zRZf6pz3WXH5WT6yYoYPYQPfcxve4T6kqHxbFrnI9QmA4GE0uhnyxerJSt/5+dDToh68eueHkUUJe97oIAU=
X-Received: by 2002:a05:6870:d891:: with SMTP id dv17mr622732oab.223.1644608896873;
 Fri, 11 Feb 2022 11:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20220105211602.359300-1-jwcart2@gmail.com> <CAP+JOzThuDcN_RpT8oZw-NBos0LbxEt=BkK5jgKGRV_skPadtw@mail.gmail.com>
In-Reply-To: <CAP+JOzThuDcN_RpT8oZw-NBos0LbxEt=BkK5jgKGRV_skPadtw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Feb 2022 14:48:06 -0500
Message-ID: <CAP+JOzRhGC_MKsGcSFOhdOnpmp27AXWGRGU8NBt4NNt33nwdHw@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol/cil: Do not copy blockabstracts when
 inheriting a block
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 7, 2022 at 1:55 PM James Carter <jwcart2@gmail.com> wrote:
>
> FYI, I plan on merging this series at the end of the week. If anyone
> has any objections, please let me know.
> Jim
>
This series has now been merged.
Jim

> On Wed, Jan 5, 2022 at 4:16 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Do not copy any blockabstract statements when copying a block to
> > resolve a blockinherit statement. Inheriting a block from what was
> > just inherited does not work, so there is no reason to create an
> > abstract block.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_copy_ast.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> > index 2fad972c..a4ead9db 100644
> > --- a/libsepol/cil/src/cil_copy_ast.c
> > +++ b/libsepol/cil/src/cil_copy_ast.c
> > @@ -1725,6 +1725,12 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, uint32_t *finished, void
> >                 copy_func = &cil_copy_block;
> >                 break;
> >         case CIL_BLOCKABSTRACT:
> > +               if (args->orig_dest->flavor == CIL_BLOCKINHERIT) {
> > +                       /* When inheriting a block, don't copy any blockabstract
> > +                        * statements. Inheriting a block from a block that was
> > +                        * just inherited never worked. */
> > +                       return SEPOL_OK;
> > +               }
> >                 copy_func = &cil_copy_blockabstract;
> >                 break;
> >         case CIL_BLOCKINHERIT:
> > --
> > 2.31.1
> >
