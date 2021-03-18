Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC727C433DB
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 14:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA68D64E01
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 14:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhCROWZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 10:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhCROVy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 10:21:54 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9DCC06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 07:21:53 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w65so1677613oie.7
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 07:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RG81OK/JwO/TdbYyLdHMg5k5lcfnlSClL0XHshLvmt0=;
        b=bx2HfnfDlz3RRsVJVlHJc05HG/Jjlpxpym3EHYVwd0Vxk57f/ebS5KABBtCi4Qogqo
         jjUstbafZ2mbsELFGg50u5XNfLFGDDeFyTtrEd94oFQbrpl1ye+NWSyvB7uoQL8NKtWA
         ynKP8xbgouDyJDrG7TAAounPYKrEyXTMMWvJL5R7NR+ERdYWEnQKhwt6tt1InDX4jhdP
         yez7bjUkg20Dm7wQTRFrqiV1EFxdHQ1oZDp2CAuKOPS7m2bGj9Ok+YYOSWG2fHjxTN3s
         pr/MtGPJ8orxqrp78Y5VrHuvrrOuofG56WmZLLh0JzWPrQSjU3F5Kmr5IV5+bwsG4W8n
         GCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RG81OK/JwO/TdbYyLdHMg5k5lcfnlSClL0XHshLvmt0=;
        b=iq54jQqkFabpcWBuBentFJT3q/G9Udoh0orhp1d+g3Tz6DyljFCMuldaTfnodfyoZp
         XzZvMonqUQ46+6ISwN2B2fgtRCi5aMBui0tjgNp2syrL6qAWu+zqC0gnSk02HorzgTON
         2OG5qkdC6gy/noOY9jUTslZsOz1ZFgTh7iecla9X3otKyUnv8fu5EJf35szptS/oCfNS
         ke4rkbKczwkVYPzA+xxh1C88T9N8iAVNpTGnlLaTdb7cNIDUJ669o2G8iEyWu0+TlNin
         3PAmcQ/QzzrHtz8LHxZ2ap693xlH9EKQao5Pq7/zmhQwsLiDvVMDWVP5G3ruJoh7+3ei
         wFRg==
X-Gm-Message-State: AOAM532NCvAlt8D3LyijPhT8ARG3lAqNgkPRYzHXDeCKJD4CJlIvGHUz
        Fobxr5crWorid3hrDpKhac8uhWd+OSf2FGtkMt0=
X-Google-Smtp-Source: ABdhPJygh2/bITHrZPOZnPJ/7x5rsGOtN5O/rc+QQUgLKyUv5AL95ThnxnQCkr/1Aunq8Ihn3RTu+TuS6j7UkfWKC2M=
X-Received: by 2002:a05:6808:1482:: with SMTP id e2mr3315860oiw.138.1616077313041;
 Thu, 18 Mar 2021 07:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210316165131.37312-1-jwcart2@gmail.com> <CAJfZ7==dLpSiV04zRKJdSXMg-FS3uZVQcQkixdK9tJ4+4d8xvQ@mail.gmail.com>
In-Reply-To: <CAJfZ7==dLpSiV04zRKJdSXMg-FS3uZVQcQkixdK9tJ4+4d8xvQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 18 Mar 2021 10:21:42 -0400
Message-ID: <CAP+JOzTHo2+uVHJTgN3AEJxCCAFZFmdmpeKgtGLr66RtPA+Jug@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: Check for duplicate blocks, optionals, and macros
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Evgeny Vereshchagin <evvers@ya.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 16, 2021 at 4:49 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Mar 16, 2021 at 5:51 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > In CIL, blocks, optionals, and macros share the same symbol table so
> > that the targets of "in" statements can be located. Because of this,
> > they cannot have the same name in the same namespace, but, because
> > they do not show up in the final policy, they can have the same name
> > as long as they are in different namespaces. Unfortunately, when
> > copying from one namespace to another, no check was being done to see
> > if there was a conflict.
> >
> > When copying blocks, optionals, and macros, if a datum is found in
> > the destination namespace, then there is a conflict with a previously
> > declared block, optional, or macro, so exit with an error.
> >
> > Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> > Reported-by: Evgeny Vereshchagin <evvers@ya.ru>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> I confirm this patch fixes the reported bug, and makes secilc no
> longer crashes on the non-reduced test case found by OSS-Fuzz.
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

Merged.
Thanks,
Jim

> Thanks!
> Nicolas
>
> > ---
> >  libsepol/cil/src/cil_copy_ast.c | 89 +++++++++------------------------
> >  1 file changed, 25 insertions(+), 64 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_copy_ast.c b/libsepol/cil/src/cil_copy_ast.c
> > index c9aada9d..ed967861 100644
> > --- a/libsepol/cil/src/cil_copy_ast.c
> > +++ b/libsepol/cil/src/cil_copy_ast.c
> > @@ -100,16 +100,17 @@ int cil_copy_block(__attribute__((unused)) struct cil_db *db, void *data, void *
> >         struct cil_block *orig = data;
> >         char *key = orig->datum.name;
> >         struct cil_symtab_datum *datum = NULL;
> > +       struct cil_block *new;
> >
> >         cil_symtab_get_datum(symtab, key, &datum);
> > -       if (datum == NULL) {
> > -               struct cil_block *new;
> > -               cil_block_init(&new);
> > -               *copy = new;
> > -       } else {
> > -               *copy = datum;;
> > +       if (datum != NULL) {
> > +               cil_tree_log(NODE(datum), CIL_ERR, "Re-declaration of %s %s", cil_node_to_string(NODE(datum)), key);
> > +               return SEPOL_ERR;
> >         }
> >
> > +       cil_block_init(&new);
> > +       *copy = new;
> > +
> >         return SEPOL_OK;
> >  }
> >
> > @@ -1509,64 +1510,22 @@ int cil_copy_macro(__attribute__((unused)) struct cil_db *db, void *data, void *
> >         struct cil_macro *orig = data;
> >         char *key = orig->datum.name;
> >         struct cil_symtab_datum *datum = NULL;
> > +       struct cil_macro *new;
> >
> >         cil_symtab_get_datum(symtab, key, &datum);
> > -       if (datum == NULL) {
> > -               struct cil_macro *new;
> > -               cil_macro_init(&new);
> > -               if (orig->params != NULL) {
> > -                       cil_copy_list(orig->params, &new->params);
> > -               }
> > -
> > -               *copy = new;
> > -
> > -       } else {
> > -               struct cil_list_item *curr_orig = NULL;
> > -               struct cil_list_item *curr_new = NULL;
> > -               struct cil_param *param_orig = NULL;
> > -               struct cil_param *param_new = NULL;
> > -
> > -               if (((struct cil_macro*)datum)->params != NULL) {
> > -                       curr_new = ((struct cil_macro*)datum)->params->head;
> > -               }
> > -
> > -               if (orig->params != NULL) {
> > -                       curr_orig = orig->params->head;
> > -               }
> > -
> > -               if (curr_orig != NULL && curr_new != NULL) {
> > -                       while (curr_orig != NULL) {
> > -                               if (curr_new == NULL) {
> > -                                       goto exit;
> > -                               }
> > -
> > -                               param_orig = (struct cil_param*)curr_orig->data;
> > -                               param_new = (struct cil_param*)curr_new->data;
> > -                               if (param_orig->str != param_new->str) {
> > -                                       goto exit;
> > -                               } else if (param_orig->flavor != param_new->flavor) {
> > -                                       goto exit;
> > -                               }
> > -
> > -                               curr_orig = curr_orig->next;
> > -                               curr_new = curr_new->next;
> > -                       }
> > -
> > -                       if (curr_new != NULL) {
> > -                               goto exit;
> > -                       }
> > -               } else if (!(curr_orig == NULL && curr_new == NULL)) {
> > -                       goto exit;
> > -               }
> > +       if (datum != NULL) {
> > +               cil_tree_log(NODE(datum), CIL_ERR, "Re-declaration of %s %s", cil_node_to_string(NODE(datum)), key);
> > +               return SEPOL_ERR;
> > +       }
> >
> > -               *copy = datum;
> > +       cil_macro_init(&new);
> > +       if (orig->params != NULL) {
> > +               cil_copy_list(orig->params, &new->params);
> >         }
> >
> > -       return SEPOL_OK;
> > +       *copy = new;
> >
> > -exit:
> > -       cil_log(CIL_INFO, "cil_copy_macro: macro cannot be redefined\n");
> > -       return SEPOL_ERR;
> > +       return SEPOL_OK;
> >  }
> >
> >  int cil_copy_optional(__attribute__((unused)) struct cil_db *db, void *data, void **copy, symtab_t *symtab)
> > @@ -1574,16 +1533,17 @@ int cil_copy_optional(__attribute__((unused)) struct cil_db *db, void *data, voi
> >         struct cil_optional *orig = data;
> >         char *key = orig->datum.name;
> >         struct cil_symtab_datum *datum = NULL;
> > +       struct cil_optional *new;
> >
> >         cil_symtab_get_datum(symtab, key, &datum);
> > -       if (datum == NULL) {
> > -               struct cil_optional *new;
> > -               cil_optional_init(&new);
> > -               *copy = new;
> > -       } else {
> > -               *copy = datum;
> > +       if (datum != NULL) {
> > +               cil_tree_log(NODE(datum), CIL_ERR, "Re-declaration of %s %s", cil_node_to_string(NODE(datum)), key);
> > +               return SEPOL_ERR;
> >         }
> >
> > +       cil_optional_init(&new);
> > +       *copy = new;
> > +
> >         return SEPOL_OK;
> >  }
> >
> > @@ -2122,6 +2082,7 @@ int __cil_copy_node_helper(struct cil_tree_node *orig, __attribute__((unused)) u
> >                         args->dest = new;
> >                 }
> >         } else {
> > +               cil_tree_log(orig, CIL_ERR, "Problem copying %s node", cil_node_to_string(orig));
> >                 goto exit;
> >         }
> >
> > --
> > 2.26.2
> >
>
