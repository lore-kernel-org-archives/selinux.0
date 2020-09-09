Return-Path: <SRS0=iCYl=CS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F0BC433E2
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 20:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6E920C09
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 20:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgMFbvb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIIUaT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIUaS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 16:30:18 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAD2C061573
        for <selinux@vger.kernel.org>; Wed,  9 Sep 2020 13:30:17 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a2so3431918otr.11
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2020 13:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TScv+Oa7rVc1C7XPJEYM5I+mmkD5XvhSHxZGP4eB/kk=;
        b=kgMFbvb3bdECp7De50BKrczGFwO+h7so5c1zH7LUwcVH51dD9zq+oDLoYtULwD3QUu
         kojJYacmZj1iSArVZE8Fp1kFiIfgKZGgZoKXK23NXb6GPqyrkIU2CN9NlVPkLLt5PJa0
         fMUnv45ca0S98DBRObvdqCJ+uG9tEus10W69VbnpaNpKDpM3xhxKefv15O5ElzKhveqX
         CLlO70d6gHMye7AsddeG5vd9gRawwqgaxkZ3LecGSU30wv0IVPSWGIDlwuwKvsSOAg0F
         D+ZXcWPyCVqRuFQZqD6psMYJrnA8M8sOzaQ8NtMkDGp6l8xRpPrFV73zZiAXy6k4x+2G
         Ridg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TScv+Oa7rVc1C7XPJEYM5I+mmkD5XvhSHxZGP4eB/kk=;
        b=AAbzpSs++tVnjv0cQRyBNr6izgAuKLg9xra+uCkWebIKmwyoo22Cvey2yEpWPVeClc
         rkkN4yQDKi2ycQ2VnegbKM3kcoxpMsCXpSapGLulA9Od9HrXyGiXkkKetB1OR/3Jhj+o
         6NSfesceIcW6uG0KqQnnC4CuzI3YV4Strn/PAIM/op25GjANV6pZmEUomYai6rrxFwZs
         OG3Y/RDz2bPJqzNSWddNlLM2zyuwsvSYmVPOOodd7ibc5/z0UAzyCJo11PrH/C3HvicK
         c6sbdoiUnoShFJzPt3qooJIWy2LmjV9EwPTUZ6FP2c6RIr/cwlIV5edHTVgUK9ROGESo
         baRw==
X-Gm-Message-State: AOAM533pZbPtxaqkY7P6rCQTSSUnjGHmEICcE9b4r9NYoUBl1/AT3iUU
        b6yc8fv1RDo12EtAMxEvKl36RCWKnRhlTmW2gFS4dxwh
X-Google-Smtp-Source: ABdhPJxt3IYPJXpwsttYfT4BzArWdAMMFAz/PIC4sjlG+BkciE+uKbOY+znxpzmLz6g78YrwZXyZxBXR1+jJy/25Dp0=
X-Received: by 2002:a9d:75d1:: with SMTP id c17mr1782732otl.59.1599683417120;
 Wed, 09 Sep 2020 13:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200909182444.254828-1-jwcart2@gmail.com> <CAEjxPJ7nPcuGRe5HUc+za-9Zh13LWcjuEPWhFVCzL=qh==t66w@mail.gmail.com>
In-Reply-To: <CAEjxPJ7nPcuGRe5HUc+za-9Zh13LWcjuEPWhFVCzL=qh==t66w@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Sep 2020 16:30:06 -0400
Message-ID: <CAP+JOzRCj7DZYcGbY7T4_2ET+4xP4V84cwdb6=kUazh5v4yw9w@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Validate constraint expressions before
 adding to binary policy
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jonathan Hettwer <j2468h@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 9, 2020 at 4:24 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Sep 9, 2020 at 2:25 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > CIL was not correctly determining the depth of constraint expressions
> > which prevented it from giving an error when the max depth was exceeded.
> > This allowed invalid policy binaries with constraint expressions exceeding
> > the max depth to be created.
> >
> > Validate the constraint expression using the same logic that is used
> > when reading the binary policy. This includes checking the depth of the
> > the expression.
> >
> > Reported-by: Jonathan Hettwer <j2468h@gmail.com>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_binary.c    | 50 ++++++++++++++++++++++++++++++++
> >  libsepol/cil/src/cil_build_ast.c | 20 ++++---------
> >  2 files changed, 55 insertions(+), 15 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> > index 77266858..0604db3c 100644
> > --- a/libsepol/cil/src/cil_binary.c
> > +++ b/libsepol/cil/src/cil_binary.c
> > @@ -2713,6 +2713,51 @@ int __cil_constrain_expr_to_sepol_expr(policydb_t *pdb, const struct cil_db *db,
> >         return SEPOL_OK;
> >  }
> >
> > +int __cil_validate_constrain_expr(constraint_expr_t *sepol_expr)
> > +{
> > +       constraint_expr_t *e = sepol_expr;
> > +       int depth = -1;
> > +
> > +       while (e) {
> > +               switch (e->expr_type) {
> > +               case CEXPR_NOT:
> > +                       if (depth < 0) {
> > +                               cil_log(CIL_ERR,"Invalid constraint expression\n");
> > +                               return SEPOL_ERR;
> > +                       }
> > +                       break;
> > +               case CEXPR_AND:
> > +               case CEXPR_OR:
> > +                       if (depth < 1) {
> > +                               cil_log(CIL_ERR,"Invalid constraint expression\n");
> > +                               return SEPOL_ERR;
> > +                       }
> > +                       depth--;
> > +                       break;
> > +               case CEXPR_ATTR:
> > +                       if (depth == (CEXPR_MAXDEPTH - 1)) {
> > +                               cil_log(CIL_ERR,"Constraint expression exceeded max allowable depth\n");
> > +                               return SEPOL_ERR;
> > +                       }
> > +                       depth++;
> > +                       break;
> > +               case CEXPR_NAMES:
>
> You don't like sharing a single block for multiple cases?  Up to you.
> As long as it gets annotated with the magic fallthrough indicator,
> modern compilers shouldn't care.

I noticed that after that I sent it out. Since I should add the final
check that you mention below, I'll change this as well.

>
> > +                       if (depth == (CEXPR_MAXDEPTH - 1)) {
> > +                               cil_log(CIL_ERR,"Constraint expression exceeded max allowable depth\n");
> > +                               return SEPOL_ERR;
> > +                       }
> > +                       depth++;
> > +                       break;
> > +               default:
> > +                       cil_log(CIL_ERR,"Invalid constraint expression\n");
> > +                       return SEPOL_ERR;
> > +               }
> > +               e = e->next;
> > +       }
>
> Only difference I noticed from checkpolicy logic here is that you
> don't do a final check that depth was 0 at the end.  Don't know if
> that is impossible here for other reasons.

No, I am just sloppy today. I had removed it, because I was just going
to check the depth, but didn't add it back in when I decided to keep
the other validation stuff.

Jim
