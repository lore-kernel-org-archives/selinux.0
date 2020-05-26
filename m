Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC0AC433DF
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 15:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B3E20663
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 15:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iv/bX9VM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgEZPro (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 11:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgEZPro (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 11:47:44 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E739C03E96D
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 08:47:44 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id c3so16626972otr.12
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 08:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sLBFrgbtUjDOh+bNfCHHpVPetsCpTUlhGgD0rg3cjsg=;
        b=iv/bX9VMX3hq9lRGOfLLBcFEvT6D2pQDPPNrj9UOlHBH79oQHGJUrINYcCfX06U6qj
         WEWvUYWYelhVJQ/aW10aiJ3Bet2X9yc1qinEHqSxbBjkFWAYpDU6vF79OPjoFiMr7KzX
         wBGOSm/lijrbC2m15vSSyEyvobZz6ruDbRlFbplrgPkaqtLWJWTKgGyI4LzuOtzQw65q
         Lq5yUGfJOnHwl0sDBuhqeYV8Snki9VH4hyqDASeWJpVmrk5vVXuMvrEbjHGpH5HCE7zU
         9sCKzNW4abHrD3tsw3OMENuavq7Cl4w4472PcdRUtr56nUwV9K13XFz1pibgkiN1x+wS
         1m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sLBFrgbtUjDOh+bNfCHHpVPetsCpTUlhGgD0rg3cjsg=;
        b=j4acu/82242J9Q5++qn+ScSOdO86CU2fw5PifexQfrHJdDbYW9oqghn2B9nqM1IHeL
         HiH839gcbOBD6Jn4DqerClaNLJ80wKo9eHWmq7NRpIIaw03IOt6LWUYEt6UC8QqWDTTl
         i9uibAdvhwA2tuU7R9Zoys8D7avF8L0IK99bwVcx8+SEGEW9jxT0dd5/0wJaCNgDq88m
         U4AccQETVUq+j9hz50lwe22DSERrfrN5rHD/34BPRAhcYzQu+zFgy2vqNB6/dAQijd2F
         mfXieUC8TxQNxrz5rIEa0dlXHvweZQ55RjLIHYNEC5I2qM8Mg6D4W7N39ecRZpwsY0NU
         L+3w==
X-Gm-Message-State: AOAM532k/EZcdJqdKguSYhHUVQ0MkD353kJPalKh33tknlR5ee+fhpw4
        GI47S3cRrW6Qgi0MFaLkjbmTp08UX2sY85ZWFuw=
X-Google-Smtp-Source: ABdhPJwIOks/ORSRpLpvGrpSv4d7iLn1OLRt5XKZMVFOjVVdfmHLKj1Op18eUqRDwEWLT2Ui+cRoHLQ6TK73xocO438=
X-Received: by 2002:a05:6830:158b:: with SMTP id i11mr1352563otr.135.1590508063681;
 Tue, 26 May 2020 08:47:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200519142946.76861-1-jwcart2@gmail.com> <20200519142946.76861-2-jwcart2@gmail.com>
In-Reply-To: <20200519142946.76861-2-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 26 May 2020 11:47:33 -0400
Message-ID: <CAEjxPJ4ZCLi8V33umgWap4WNkB2zsW+Juuh3GKyAzT0zv4=vFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libsepol/cil: Return error when identifier
 declared as both type and attribute
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 19, 2020 at 10:30 AM James Carter <jwcart2@gmail.com> wrote:
>
> CIL allows a type to be redeclared when using the multiple declarations
> option ("-m" or "--muliple-decls"), but make it an error for an identifier
> to be declared as both a type and an attribute.
>
> Change the error message so that it always gives the location and flavor
> of both declarations. The flavors will be the same in all other cases,
> but in this case they explain why there is an error even if multiple
> declartions are allowed.
>
> Issue reported by: Topi Miettinen <toiwoton@gmail.com>

Normally just Reported-by:...

> Fixes: Commit fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare
>        types[attributes]")

Normally just "Fixes: <hash> ("one-liner")", no "Commit".

> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
>  libsepol/cil/src/cil_build_ast.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> index fcecdc4f..ce2499a1 100644
> --- a/libsepol/cil/src/cil_build_ast.c
> +++ b/libsepol/cil/src/cil_build_ast.c
> @@ -87,7 +87,7 @@ exit:
>   * datum, given the new datum and the one already present in a given symtab.
>   */
>  int cil_is_datum_multiple_decl(__attribute__((unused)) struct cil_symtab_datum *cur,
> -                               __attribute__((unused)) struct cil_symtab_datum *old,
> +                               struct cil_symtab_datum *old,
>                                 enum cil_flavor f)
>  {
>         int rc = CIL_FALSE;
> @@ -95,8 +95,12 @@ int cil_is_datum_multiple_decl(__attribute__((unused)) struct cil_symtab_datum *
>         switch (f) {
>         case CIL_TYPE:
>         case CIL_TYPEATTRIBUTE:
> -               /* type and typeattribute statements insert empty datums, ret true */
> -               rc = CIL_TRUE;
> +               if (!old || f != FLAVOR(old)) {
> +                       rc = CIL_FALSE;
> +               } else {
> +                       /* type and typeattribute statements insert empty datums */
> +                       rc = CIL_TRUE;
> +               }
>                 break;
>         default:
>                 break;
> @@ -126,19 +130,20 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
>         if (symtab != NULL) {
>                 rc = cil_symtab_insert(symtab, (hashtab_key_t)key, datum, ast_node);
>                 if (rc == SEPOL_EEXIST) {
> +                       rc = cil_symtab_get_datum(symtab, (hashtab_key_t)key, &prev);
> +                       if (rc != SEPOL_OK) {
> +                               cil_log(CIL_ERR, "Re-declaration of %s %s, but previous declaration could not be found\n",cil_node_to_string(ast_node), key);
> +                               goto exit;
> +                       }
>                         if (!db->multiple_decls ||
> -                           cil_symtab_get_datum(symtab, (hashtab_key_t)key, &prev) != SEPOL_OK ||
>                             !cil_is_datum_multiple_decl(datum, prev, nflavor)) {
> -
>                                 /* multiple_decls not ok, ret error */
> +                               struct cil_tree_node *node = NODE(prev);
>                                 cil_log(CIL_ERR, "Re-declaration of %s %s\n",
>                                         cil_node_to_string(ast_node), key);
> -                               if (cil_symtab_get_datum(symtab, key, &datum) == SEPOL_OK) {
> -                                       if (sflavor == CIL_SYM_BLOCKS) {
> -                                               struct cil_tree_node *node = datum->nodes->head->data;
> -                                               cil_tree_log(node, CIL_ERR, "Previous declaration");
> -                                       }
> -                               }
> +                               cil_tree_log(node, CIL_ERR, "Previous declaration of %s",
> +                                       cil_node_to_string(node));
> +                               rc = SEPOL_ERR;
>                                 goto exit;
>                         }
>                         /* multiple_decls is enabled and works for this datum type, add node */
> @@ -169,7 +174,7 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
>         return SEPOL_OK;
>
>  exit:
> -       cil_log(CIL_ERR, "Failed to create node\n");
> +       cil_log(CIL_INFO, "Failed to create node\n");

Is this useful/meaningful to retain?  Seems odd to have an
informational message about a failure to create a node.
