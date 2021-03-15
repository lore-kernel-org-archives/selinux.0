Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8764FC433E0
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523A464F0F
	for <selinux@archiver.kernel.org>; Mon, 15 Mar 2021 21:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhCOVJV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Mar 2021 17:09:21 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47528 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbhCOVJC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Mar 2021 17:09:02 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 753AC56549C
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 22:09:00 +0100 (CET)
Received: by mail-pf1-f175.google.com with SMTP id 18so7392615pfo.6
        for <selinux@vger.kernel.org>; Mon, 15 Mar 2021 14:09:00 -0700 (PDT)
X-Gm-Message-State: AOAM531H7Yo9oooiIj4kjbqbXNeqnC6iBeKmxjntK5fnKjeH2771DVMK
        /YEEX4gzMKPQdqMKpXs9yBiEPaQpMLqVsHWJeKI=
X-Google-Smtp-Source: ABdhPJxfTY2PeUqjyQGVfrl81rZYhnvoChdKowbb2nIY9XKLK5CgFNKf0gcYuBpaQfDNjcsai7WSdeRtqE5GnjeXBf8=
X-Received: by 2002:a62:5cc3:0:b029:203:54be:e4c9 with SMTP id
 q186-20020a625cc30000b029020354bee4c9mr11824915pfb.80.1615842539362; Mon, 15
 Mar 2021 14:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210308204923.71940-1-jwcart2@gmail.com> <CAJfZ7=nJv_KafJFgR1tWDZkvMB6V3zbAqqJQuQkMcaGk2F+bPA@mail.gmail.com>
In-Reply-To: <CAJfZ7=nJv_KafJFgR1tWDZkvMB6V3zbAqqJQuQkMcaGk2F+bPA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 15 Mar 2021 22:08:48 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mNN9Fa7i7505S0TjbBUf1BV2+otraK+mUym_s4pQDBVw@mail.gmail.com>
Message-ID: <CAJfZ7=mNN9Fa7i7505S0TjbBUf1BV2+otraK+mUym_s4pQDBVw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/checkpolicy: Set user roles using role value
 instead of dominance
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Mar 15 22:09:01 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Mar 14, 2021 at 8:59 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Mar 8, 2021 at 9:50 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Roles in an optional block have two datums, one in the global block
> > and one in the avrule_decl where it is declared. The datum in the
> > global block does not have its dominace set. This is a problem because
> > the function set_user_role() sets the user's roles based on the global
> > datum's dominance ebitmap. If a user is declared with an associated role
> > that was declared in an optional block, then it will not have any roles
> > set for it because the dominance ebitmap is empty.
> >
> > Example/
> >   # handle_unknown deny
> >   class CLASS1
> >   sid kernel
> >   class CLASS1 { PERM1 }
> >   type TYPE1;
> >   allow TYPE1 self:CLASS1 PERM1;
> >   role ROLE1;
> >   role ROLE1 types { TYPE1 };
> >   optional {
> >     require {
> >       class CLASS1 { PERM1 };
> >     }
> >     role ROLE1A;
> >     user USER1A roles ROLE1A;
> >   }
> >   user USER1 roles ROLE1;
> >   sid kernel USER1:ROLE1:TYPE1
> >
> > In this example, USER1A would not have ROLE1A associated with it.
> >
> > Instead of using dominance, which has been deprecated anyway, just
> > set the bit corresponding to the role's value in the user's roles
> > ebitmap in set_user_role().
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  checkpolicy/policy_define.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index c9286f77..6c035716 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -4088,8 +4088,6 @@ cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void *arg2)
> >  static int set_user_roles(role_set_t * set, char *id)
> >  {
> >         role_datum_t *r;
> > -       unsigned int i;
> > -       ebitmap_node_t *node;
> >
> >         if (strcmp(id, "*") == 0) {
> >                 free(id);
> > @@ -4115,12 +4113,9 @@ static int set_user_roles(role_set_t * set, char *id)
> >                 return -1;
> >         }
> >
> > -       /* set the role and every role it dominates */
> > -       ebitmap_for_each_positive_bit(&r->dominates, node, i) {
> > -               if (ebitmap_set_bit(&set->roles, i, TRUE))
> > -                       goto oom;
> > -       }
> >         free(id);
> > +       if (ebitmap_set_bit(&set->roles, r->s.value-1, TRUE))
> > +               goto oom;
> >         return 0;
> >        oom:
> >         yyerror("out of memory");
>
> In other places there are spaces between the subtraction operator
> ("r->s.value - 1") and it would be nicer if this patch also used
> spaces.
> This is a minor comment anyway, and this patch looks good to me.
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged, with added spaces.

Thanks!
Nicolas

