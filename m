Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680BFC433F5
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 20:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbiBRUGV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 15:06:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiBRUGU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 15:06:20 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2D22402F9
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 12:06:03 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id y7so4277602oih.5
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 12:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8q+kfClhxK7rJWzlAkPYe4zUU41QOe2qDQoHJ3wghpY=;
        b=JlPyc526cAxKRC8KJslIoHaaSjhpdgjXVjeze0Tg/7gRR3lu1Grx58o5qQbM6AnGIu
         72zRqG8gncHw47P20lV7cPFZ5DK7r2Z1NvoyAGwE4lSQQlHuBMcfcMbdkVfTh1KOOrb4
         VUO5Rgj4hAwuxBPO7744g6mL2a5egDOdkPTPsz5VgfVrzwck6GM86WhBxH2b1YlFAe+P
         HIt/WWpzoAgXnChCeIIq606eruy/Z0D8eeE2Q58mfpVC/T+RhsypyWW7+BShTnbaebux
         lRnl3eO4wk67Q72BCvnjTYqFN8QgYlKj3Wo7aTDOsoPVM6lXHRd8YJDXmB/+8Ch6B8qn
         LvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8q+kfClhxK7rJWzlAkPYe4zUU41QOe2qDQoHJ3wghpY=;
        b=ga8Kwcvl6izFnda7of0o5QKAwRErMJHazrt5G63BicMQ+bPE/9vM9tVq519IymaUuH
         E8B3GGkHCwPQ+3KJhCtb6sybsz7dCNo8+UQkoreJNbCEwLBEXtHIo+4VY3YPTZZ+nb91
         MAnrorEjPvv8MOVbjl0rk0ogEcwxGbq85lPGiOzO8MrMLXfmqUTYGBfR5NznU1JROBDN
         /IL6xLWiDKBK4bTVE/xQNi5YufFFGrZnScb47Upm7DDcNKAms6d1ZK7CLQleH9NJ6YY4
         aXj5uOroVjOS3xrrUkwFADLSypNVkMO5o/R+afe/Xd53L8M2OS5m/JZSPx/wpiLttkoj
         dGPQ==
X-Gm-Message-State: AOAM530QLE3Ctbsy8bJj9sTHAjrAn8wi0hkjNuK1jduf5ve0lHGKVGy0
        fbbpCoIcMhWSHp5JlBYBMiXAq2qlcwjgr09DSbEtLVcE
X-Google-Smtp-Source: ABdhPJwJZJ1yBAaFgsqYWCcylQmU+1o7Xa85vMGYKekNwuECKhb2i9WfOHaYmZQIF9QjXFy4sH7/Bu1tQQXlNVdafmQ=
X-Received: by 2002:a05:6808:1642:b0:2d4:5a9a:c58b with SMTP id
 az2-20020a056808164200b002d45a9ac58bmr4187818oib.200.1645214763251; Fri, 18
 Feb 2022 12:06:03 -0800 (PST)
MIME-Version: 1.0
References: <20220204133717.27793-1-cgzones@googlemail.com>
 <20220210183823.39187-1-cgzones@googlemail.com> <CAP+JOzR9C+2Weho74wNtJyt4_6SONPFyT=wfxb-jeu-6gcQ+eQ@mail.gmail.com>
In-Reply-To: <CAP+JOzR9C+2Weho74wNtJyt4_6SONPFyT=wfxb-jeu-6gcQ+eQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 18 Feb 2022 15:05:52 -0500
Message-ID: <CAP+JOzREGpGOp_N7-qPcQApj3iNMn_FuxO-S=V=0HbDdfeDa0g@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy: allow wildcard permissions in constraints
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 11, 2022 at 1:40 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Fri, Feb 11, 2022 at 11:19 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Allow all and complement permission sets in constraints, e.g.:
> >
> >     constrain service ~ { status } (...);
> >     constrain service * (...);
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> >
> > ---
> >
> > v2:
> >    - do not set invalid permission bits
> >    - omit constrain rules with an empty permission bitset
> > ---
> >  checkpolicy/policy_define.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index b2ae3263..16b78346 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -3477,6 +3477,8 @@ static constraint_expr_t *constraint_expr_clone(c=
onst constraint_expr_t * expr)
> >         return NULL;
> >  }
> >
> > +#define PERMISSION_MASK(nprim) ((nprim) =3D=3D PERM_SYMTAB_SIZE ? (~UI=
NT32_C(0)) : ((UINT32_C(1) << (nprim)) - 1))
> > +
> >  int define_constraint(constraint_expr_t * expr)
> >  {
> >         struct constraint_node *node;
> > @@ -3590,6 +3592,22 @@ int define_constraint(constraint_expr_t * expr)
> >                         cladatum =3D policydbp->class_val_to_struct[i];
> >                         node =3D cladatum->constraints;
> >
> > +                       if (strcmp(id, "*") =3D=3D 0) {
> > +                               node->permissions =3D PERMISSION_MASK(c=
ladatum->permissions.nprim);
> > +                               continue;
> > +                       }
> > +
> > +                       if (strcmp(id, "~") =3D=3D 0) {
> > +                               node->permissions =3D ~node->permission=
s & PERMISSION_MASK(cladatum->permissions.nprim);
> > +                               if (node->permissions =3D=3D 0) {
> > +                                       yywarn("omitting constraint wit=
h no permission set");
> > +                                       cladatum->constraints =3D node-=
>next;
> > +                                       constraint_expr_destroy(node->e=
xpr);
> > +                                       free(node);
> > +                               }
> > +                               continue;
> > +                       }
> > +
> >                         perdatum =3D
> >                             (perm_datum_t *) hashtab_search(cladatum->
> >                                                             permissions=
.
> > --
> > 2.34.1
> >
