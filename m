Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACCDC433DB
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 20:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF2A64E0F
	for <selinux@archiver.kernel.org>; Sun, 14 Mar 2021 20:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhCNUFM convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sun, 14 Mar 2021 16:05:12 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:52018 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhCNUEm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 14 Mar 2021 16:04:42 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 395FD564EE6
        for <selinux@vger.kernel.org>; Sun, 14 Mar 2021 21:04:40 +0100 (CET)
Received: by mail-pj1-f53.google.com with SMTP id s21so7666722pjq.1
        for <selinux@vger.kernel.org>; Sun, 14 Mar 2021 13:04:40 -0700 (PDT)
X-Gm-Message-State: AOAM530wuK7N39sJBbW5hM6N4xI3KLDjfDlyvm4Q3ZN+p/g15jtjk31V
        xPIYYcQdv+P1oKCb9yaU60GpJ4cadnwSYIqELMI=
X-Google-Smtp-Source: ABdhPJwAy7P08UHuRjcMcMNgXlF7TcM4f2j9Bwo82KvNMlkYk44/CqoWh3n5AyK1WekraVt/fJiy8NBHa8SkxbErtmI=
X-Received: by 2002:a17:90a:4d81:: with SMTP id m1mr1222658pjh.143.1615752278907;
 Sun, 14 Mar 2021 13:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210310193012.166256-1-jwcart2@gmail.com> <CAJ2a_DeSUHcBnXOTmTmexP_teYOz7Jt3zCNbKaHSS_V+fUs=EQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DeSUHcBnXOTmTmexP_teYOz7Jt3zCNbKaHSS_V+fUs=EQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 14 Mar 2021 21:04:27 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=nkqjKj8WqSPaTCJE6HGQvVgKPgOFxZ6OWiuVtHVwttmQ@mail.gmail.com>
Message-ID: <CAJfZ7=nkqjKj8WqSPaTCJE6HGQvVgKPgOFxZ6OWiuVtHVwttmQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Expand role attributes in constraint expressions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar 14 21:04:40 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 10, 2021 at 9:16 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Am Mi., 10. März 2021 um 20:30 Uhr schrieb James Carter <jwcart2@gmail.com>:
> >
> > When creating the kernel binary policy, role attributes in constraint
> > expressions are not expanded. This causes the constraint expression
> > to refer to a non-existent role in the kernel policy. This can lead
> > to a segfault when converting the binary policy back to conf or CIL
> > source or when using policy tools such as seinfo.
> >
> > Expand role attributes in constraint expressions when creating the
> > kernel binary policy.
>
>
> Thanks for the quick fix.
> Tested role attribute constraints with bare 3.2, leading to setfiles
> failing with `libsepol.validate_constraint_nodes: Invalid constraint
> expr`.
> Works fine with this patch.
> Also seinfo does not crash on the newly generated policy anymore.
>
> Tested-by: Christian Göttsche <cgzones@googlemail.com>
>
>
> >
> > Reported-by: Christian Göttsche <cgzones@googlemail.com>
> > Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

> > ---
> >  libsepol/src/expand.c | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index eac7e450..2d9cb566 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -71,6 +71,38 @@ static int map_ebitmap(ebitmap_t * src, ebitmap_t * dst, uint32_t * map)
> >         return 0;
> >  }
> >
> > +static int ebitmap_expand_roles(policydb_t *p, ebitmap_t *roles)
> > +{
> > +       ebitmap_node_t *node;
> > +       unsigned int bit;
> > +       role_datum_t *role;
> > +       ebitmap_t tmp;
> > +
> > +       ebitmap_init(&tmp);
> > +       ebitmap_for_each_positive_bit(roles, node, bit) {
> > +               role = p->role_val_to_struct[bit];
> > +               assert(role);
> > +               if (role->flavor != ROLE_ATTRIB) {
> > +                       if (ebitmap_set_bit(&tmp, bit, 1)) {
> > +                               ebitmap_destroy(&tmp);
> > +                               return -1;
> > +                       }
> > +               } else {
> > +                       if (ebitmap_union(&tmp, &role->roles)) {
> > +                               ebitmap_destroy(&tmp);
> > +                               return -1;
> > +                       }
> > +               }
> > +       }
> > +       ebitmap_destroy(roles);
> > +       if (ebitmap_cpy(roles, &tmp)) {
> > +               ebitmap_destroy(&tmp);
> > +               return -1;
> > +       }
> > +       ebitmap_destroy(&tmp);
> > +       return 0;
> > +}
> > +
> >  static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
> >                               void *data)
> >  {
> > @@ -333,6 +365,9 @@ static int constraint_node_clone(constraint_node_t ** dst,
> >                                         if (map_ebitmap(&expr->names, &new_expr->names, state->rolemap)) {
> >                                                 goto out_of_mem;
> >                                         }
> > +                                       if (ebitmap_expand_roles(state->out, &new_expr->names)) {
> > +                                               goto out_of_mem;
> > +                                       }
> >                                 } else if (new_expr->attr & CEXPR_USER) {
> >                                         if (map_ebitmap(&expr->names, &new_expr->names, state->usermap)) {
> >                                                 goto out_of_mem;
> > --
> > 2.26.2
> >

