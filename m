Return-Path: <SRS0=TGs9=7I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CE9C433DF
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 17:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2983E20723
	for <selinux@archiver.kernel.org>; Tue, 26 May 2020 17:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEMAwICv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbgEZRVj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 May 2020 13:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388463AbgEZRVj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 May 2020 13:21:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C7C03E96D
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 10:21:39 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id d26so16929947otc.7
        for <selinux@vger.kernel.org>; Tue, 26 May 2020 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TJQdmkd8ZO7Gq1St41+z1lWRfFPE2kNPeMjFFazMhqU=;
        b=pEMAwICv6zX1WSw1yCETqjxYRQJQVvTBE9Fq7pLvMLHeYTTYCuwVTakOefqmAm7KEp
         thPOmGIc1veeW0LtD98/c2Af6/kNMVOgBOez0UUMiTkUDWwWah/d2scJ08k/SF2PFndu
         STliEGf1qckRGHDTkEyWCNHkdrZt4kdAg6SoQMDCD+sac0lS7A9JEeJJMrShipvWLvEM
         PWoon9nLg9ndhtOsUA/tlmccXfpoXjw03wArQgBf6KkvLxvXbSJOyY4RmoIb6TbmjgVf
         tdWLuVpv5pDM4AJqUvwjlW6s7cLzaBAt73YR3l2A2EU1hq2LdlKhwm/C8GfxK2BS2/kV
         44+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TJQdmkd8ZO7Gq1St41+z1lWRfFPE2kNPeMjFFazMhqU=;
        b=JvR//NjmShiP0Wkqra+Oxfw7atB4C0PHylF+683uHp6AkrZOFRqAHpsZBiICJlfLki
         QiIP5Cu2f6ZAHQFG6qcwmy+gsk4ZgmBZfk4RNtOWgqhTHHnRk7mY900h+BpXwBI0MMyq
         smAOzocjgqhxZjCiwSi9xU1ATEWB2V3ri8BMBJus0v5A/RQQ1iTp5qNjWV8/ikHNOHcm
         Nfnf5j8GEuxDalCG9sJddh0jiykqOpxVX3dm3W0YwErl666OGhivrKFX+CqEfIn7jIu+
         fpZSjnoAPCw6pJ4hNJjDX2TXgQLEJB4LlNdp2iAtERwmUsuEt0kso9zqOJu8iCU+bwgK
         mDNA==
X-Gm-Message-State: AOAM533esaSRUc6uzA9ahjtM2XEzAPaiLDFQOmwHlRTbbo9FRZdKPX6G
        v6vmpNPhcL7NyNTNVWgm3cYbO+MqjjGgb608E5Q=
X-Google-Smtp-Source: ABdhPJyvRlrVt4g3d9NgTKQ4Xf4QqAuhkYfqzy0YrqQLuxkfx7VoHMcevxbk1RV4cU+hMmyKznSzj/17SDr9ic/QGbk=
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr1698465oto.295.1590513697444;
 Tue, 26 May 2020 10:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200519142946.76861-1-jwcart2@gmail.com> <20200519142946.76861-2-jwcart2@gmail.com>
 <CAEjxPJ4ZCLi8V33umgWap4WNkB2zsW+Juuh3GKyAzT0zv4=vFQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4ZCLi8V33umgWap4WNkB2zsW+Juuh3GKyAzT0zv4=vFQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 26 May 2020 13:21:26 -0400
Message-ID: <CAP+JOzRF-kCyWsEWMTMr1Wrz9HPXAZCUrm6b88MQD9JwT_QsDQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] libsepol/cil: Return error when identifier
 declared as both type and attribute
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 26, 2020 at 11:47 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, May 19, 2020 at 10:30 AM James Carter <jwcart2@gmail.com> wrote:
> >
> > CIL allows a type to be redeclared when using the multiple declarations
> > option ("-m" or "--muliple-decls"), but make it an error for an identifier
> > to be declared as both a type and an attribute.
> >
> > Change the error message so that it always gives the location and flavor
> > of both declarations. The flavors will be the same in all other cases,
> > but in this case they explain why there is an error even if multiple
> > declartions are allowed.
> >
> > Issue reported by: Topi Miettinen <toiwoton@gmail.com>
>
> Normally just Reported-by:...
>
> > Fixes: Commit fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare
> >        types[attributes]")
>
> Normally just "Fixes: <hash> ("one-liner")", no "Commit".
>
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/cil/src/cil_build_ast.c | 29 +++++++++++++++++------------
> >  1 file changed, 17 insertions(+), 12 deletions(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index fcecdc4f..ce2499a1 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -87,7 +87,7 @@ exit:
> >   * datum, given the new datum and the one already present in a given symtab.
> >   */
> >  int cil_is_datum_multiple_decl(__attribute__((unused)) struct cil_symtab_datum *cur,
> > -                               __attribute__((unused)) struct cil_symtab_datum *old,
> > +                               struct cil_symtab_datum *old,
> >                                 enum cil_flavor f)
> >  {
> >         int rc = CIL_FALSE;
> > @@ -95,8 +95,12 @@ int cil_is_datum_multiple_decl(__attribute__((unused)) struct cil_symtab_datum *
> >         switch (f) {
> >         case CIL_TYPE:
> >         case CIL_TYPEATTRIBUTE:
> > -               /* type and typeattribute statements insert empty datums, ret true */
> > -               rc = CIL_TRUE;
> > +               if (!old || f != FLAVOR(old)) {
> > +                       rc = CIL_FALSE;
> > +               } else {
> > +                       /* type and typeattribute statements insert empty datums */
> > +                       rc = CIL_TRUE;
> > +               }
> >                 break;
> >         default:
> >                 break;
> > @@ -126,19 +130,20 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
> >         if (symtab != NULL) {
> >                 rc = cil_symtab_insert(symtab, (hashtab_key_t)key, datum, ast_node);
> >                 if (rc == SEPOL_EEXIST) {
> > +                       rc = cil_symtab_get_datum(symtab, (hashtab_key_t)key, &prev);
> > +                       if (rc != SEPOL_OK) {
> > +                               cil_log(CIL_ERR, "Re-declaration of %s %s, but previous declaration could not be found\n",cil_node_to_string(ast_node), key);
> > +                               goto exit;
> > +                       }
> >                         if (!db->multiple_decls ||
> > -                           cil_symtab_get_datum(symtab, (hashtab_key_t)key, &prev) != SEPOL_OK ||
> >                             !cil_is_datum_multiple_decl(datum, prev, nflavor)) {
> > -
> >                                 /* multiple_decls not ok, ret error */
> > +                               struct cil_tree_node *node = NODE(prev);
> >                                 cil_log(CIL_ERR, "Re-declaration of %s %s\n",
> >                                         cil_node_to_string(ast_node), key);
> > -                               if (cil_symtab_get_datum(symtab, key, &datum) == SEPOL_OK) {
> > -                                       if (sflavor == CIL_SYM_BLOCKS) {
> > -                                               struct cil_tree_node *node = datum->nodes->head->data;
> > -                                               cil_tree_log(node, CIL_ERR, "Previous declaration");
> > -                                       }
> > -                               }
> > +                               cil_tree_log(node, CIL_ERR, "Previous declaration of %s",
> > +                                       cil_node_to_string(node));
> > +                               rc = SEPOL_ERR;
> >                                 goto exit;
> >                         }
> >                         /* multiple_decls is enabled and works for this datum type, add node */
> > @@ -169,7 +174,7 @@ int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_s
> >         return SEPOL_OK;
> >
> >  exit:
> > -       cil_log(CIL_ERR, "Failed to create node\n");
> > +       cil_log(CIL_INFO, "Failed to create node\n");
>
> Is this useful/meaningful to retain?  Seems odd to have an
> informational message about a failure to create a node.

I definitely did not think that there was any value in reporting it as
an error and I agree with you that it is not very useful at all.

Jim
