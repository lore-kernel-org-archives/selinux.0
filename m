Return-Path: <SRS0=iCYl=CS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76D7C43461
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 20:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975D121D7D
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 20:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FR6Dn/eM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIIUJq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgIIUJp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 16:09:45 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BE4C061573
        for <selinux@vger.kernel.org>; Wed,  9 Sep 2020 13:09:45 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h17so3437055otr.1
        for <selinux@vger.kernel.org>; Wed, 09 Sep 2020 13:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qTJi3LesMTG6xXYsGbenavB3dY+ToaGSfSwYAAPhFvg=;
        b=FR6Dn/eMHt7L9puBDmGJyCduGRJPxi4cmQfiFUCp9yScVkNVqlp69AxIFM7FiWfVlu
         v3qu/zIOODD8AAW/fOQOhm4DN75QPalgFWRuJDx8rZWPq7Av7svDP2/KraH3mEo4Xq+t
         OAb7B/d5a1AQqpCXLIWSQjBzsLK8Z2EHlKLKbbi9eS3RiKLPs7AooIkJY3kpAG0GCgJU
         Kwrm4gCFJt/nO1l0ohG14qnTZOKz7uPtg0mRgsUfGWsGeujJVBEE+aiz19Dgc6x4cKUi
         EEsSGYgkVSSXcR0Syg94WZritqpqR0xF9bSWZAOeZWgdeiZxUYOTZQ4stHoIYRxPfvUx
         lOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qTJi3LesMTG6xXYsGbenavB3dY+ToaGSfSwYAAPhFvg=;
        b=nyWjy+nQd3VJdP6DLuAW8YA9g+C9cFLGWL4MtHVwiW6Bg9DErHgwp95BKzdrjzNVlw
         CZRZe/q5KJDyoSgCF2q8qugM0goyy57Pk6vZG2vHZsrC2c+NilnKQrSUWq5MPN6nJRo9
         Sce17zYkTDwmHzbpBo7v+wciE44vj8DWekdU9S/4d1B/Xhc5pVVRhJ5sywIN6JcVUXix
         Mqx+SB5M4anM1OO+l6E52hLspkjy7u13kIBwnJ+q9Xq0/fbiYt6WpcWxNifWCa2zXWrQ
         vfODvCIu0DKoD5TQ2BzV9kzu1RAZh0PWAMjSxXUSBYPQAUs7ydwtqt1I87HKUBLoPLWe
         YmeA==
X-Gm-Message-State: AOAM533efS1vkX5fOIG4ebNBdjoBeA9AOekKRZFOirIP4xN76W0QageC
        28ybQT3PVtoGngmmhUJPgHJNoKaB5NW75CbsJNc=
X-Google-Smtp-Source: ABdhPJxCg2lUTz/sTbk2qjhHN4vzvjN7nm5f7LW3mFXMISW3A8EjewhbmSjrvPyZqiHvxBGMxJIJDi7NZjyujoCGlmo=
X-Received: by 2002:a9d:185:: with SMTP id e5mr1861610ote.135.1599682184423;
 Wed, 09 Sep 2020 13:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200909194222.263841-1-jwcart2@gmail.com>
In-Reply-To: <20200909194222.263841-1-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 9 Sep 2020 16:09:33 -0400
Message-ID: <CAEjxPJ4Ss39iMLX93N_uMaAze0yw2t1+SdB0cdWCNGQj4z=JZQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Validate conditional expressions before
 adding to binary policy
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 9, 2020 at 3:43 PM James Carter <jwcart2@gmail.com> wrote:
>
> CIL was not correctly determining the depth of conditional expressions
> which prevented it from giving an error when the max depth was exceeded.
> This allowed invalid policy binaries to be created.
>
> Validate the conditional expression using the same logic that is used
> when evaluating a conditional expression. This includes checking the
> depth of the expression.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_binary.c    | 43 ++++++++++++++++++++++++++++++++
>  libsepol/cil/src/cil_build_ast.c | 26 ++++++-------------
>  2 files changed, 50 insertions(+), 19 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.=
c
> index 77266858..d30233c4 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -2176,6 +2176,44 @@ static int __cil_cond_expr_to_sepol_expr(policydb_=
t *pdb, struct cil_list *cil_e
>         return SEPOL_OK;
>  }
>
> +int __cil_validate_cond_expr(cond_expr_t *cond_expr)
> +{
> +       cond_expr_t *e;
> +       int depth =3D -1;
> +
> +       for (e =3D cond_expr; e !=3D NULL; e =3D e->next) {
> +               switch (e->expr_type) {
> +               case COND_BOOL:
> +                       if (depth =3D=3D (COND_EXPR_MAXDEPTH - 1)) {
> +                               cil_log(CIL_ERR,"Conditional expression e=
xceeded max allowable depth\n");
> +                               return -1;
> +                       }
> +                       depth++;
> +                       break;
> +               case COND_NOT:
> +                       if (depth < 0) {
> +                               cil_log(CIL_ERR,"Invalid conditional expr=
ession\n");
> +                               return -1;
> +                       }
> +                       break;
> +               case COND_OR:
> +               case COND_AND:
> +               case COND_XOR:
> +               case COND_EQ:
> +               case COND_NEQ:
> +                       if (depth < 1) {
> +                               cil_log(CIL_ERR,"Invalid conditional expr=
ession\n");
> +                               return -1;
> +                       }
> +                       depth--;
> +                       break;
> +               default:
> +                       cil_log(CIL_ERR,"Invalid conditional expression\n=
");
> +                       return -1;
> +               }
> +       }

Missing a return here.
../cil/src/cil_binary.c: In function =E2=80=98__cil_validate_cond_expr=E2=
=80=99:
../cil/src/cil_binary.c:2215:1: error: control reaches end of non-void
function [-Werror=3Dreturn-type]
 2215 | }
      | ^
