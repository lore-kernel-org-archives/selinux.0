Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F8CC433F5
	for <selinux@archiver.kernel.org>; Thu, 24 Feb 2022 21:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiBXVHd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Feb 2022 16:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiBXVHd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Feb 2022 16:07:33 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C417C1081B2
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 13:07:02 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id w3-20020a056830060300b005ad10e3becaso2235351oti.3
        for <selinux@vger.kernel.org>; Thu, 24 Feb 2022 13:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pCTzA76Ccgf9R+ILizZhfuYVjFHM6Qa/wjkt69NZDM4=;
        b=DFlrck3nWckRgkx2GHsbMH+2dcNpST1SH8m+h5AOCC6sRH+li8/o86yQGvZhMHLbAT
         RXFfbYNDOm3fMiAIKJ9mRu6tXsLUc08/X0lD2SoBOBEfhDzg/X1jZihPCj2g1mU2GmD2
         08d3eWj2uzeNNQfJlqzQwzmpNFLVXOvGlolcDkuzMO+DMNKrD4JcgOwIItb9K+vEQJDp
         uwEkH7D25xkcV+UCQiHmaNTz9+NP4ztM5Fv83v5ExfTVChUSLiJKc1JMgxcfh5Am+q3g
         +4Fp2giFVNoW88r9dzAhljCT2QpCmgKmUYNdx1fA93GgJEkcfEPhRWsWxZWHJIzrGGuQ
         ZbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pCTzA76Ccgf9R+ILizZhfuYVjFHM6Qa/wjkt69NZDM4=;
        b=uwIzWTnoO89yNL1MXdd0ycEAlwal3CV2J1vUQ3rT05m5Sc2gmp/Xy8XLZ7b5uMYfsd
         hb0tG6+SqSGvB5CFNg6Ijqlq1B/JgfdriQjaipqePoHvIVZpreXVi6OvyvaUoKeyIfNv
         RD3InfPBQpriYmKxExjWHS5BOdmcGlhWEuhgZBwHVEpLY/mLNkusYHoWRRnKQMM4Vq1R
         pezn2kx3gYiijgC7rotesc655UbSvfcFUpEx4wIzHOJ7c46YOss3PxVzn+H/ngUQ85X+
         o3Ydx7uWPFqf8do4lj2fXSUCNHCrqoUT8j7I9FfVEAhG2vIJDkhdm/s+EyEueJgJ12Sz
         ehhQ==
X-Gm-Message-State: AOAM533FJMznlO96Qp+bTxILQkgSOrS6xRhMu3ifhe5FF/YIoqR/nF7P
        7RXzCXCaA0tCZ15/NQVqdxjEciNgTu5knoHRHoU=
X-Google-Smtp-Source: ABdhPJyvBEjtXczh4vuCigDV4JiOuxWNAW6Dr30HuNPmLrsaYOm9CdafOAqlEGSlqaKwYPfrDYs1+E4wB//JWCEBvdQ=
X-Received: by 2002:a05:6830:2390:b0:5ac:19a3:4888 with SMTP id
 l16-20020a056830239000b005ac19a34888mr1669114ots.53.1645736821724; Thu, 24
 Feb 2022 13:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20220216005326.1899481-1-tweek@google.com> <CAP+JOzRuDOUP7jBzuzFe7S4SvBRA6sG69Q7tzd+LgpsRxNWNiw@mail.gmail.com>
In-Reply-To: <CAP+JOzRuDOUP7jBzuzFe7S4SvBRA6sG69Q7tzd+LgpsRxNWNiw@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 24 Feb 2022 16:06:50 -0500
Message-ID: <CAP+JOzSegHonk2V6AtNbr0aPDwD-FNXYAcuET=+nvN0BHkN+sw@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Populate and use policy name
To:     =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Alan Stokes <alanstokes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 18, 2022 at 4:15 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Wed, Feb 16, 2022 at 2:27 AM Thi=C3=A9baud Weksteen <tweek@google.com>=
 wrote:
> >
> > When an assertion fails, the error message refers to a generic
> > "policy.conf" file. When parsing a policy in checkpolicy, populate its
> > name using the original filename (source_filename is still build using
> > the #line directives within the policy).
> >
> > Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > v1 -> v2: Fix leak reported by Christian G=C3=B6ttsche
> >
> >  checkpolicy/module_compiler.c |  1 +
> >  checkpolicy/parse_util.c      |  1 +
> >  libsepol/src/assertion.c      | 20 ++++++++++++++------
> >  libsepol/src/expand.c         |  3 +++
> >  4 files changed, 19 insertions(+), 6 deletions(-)
> >
> > diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compile=
r.c
> > index 5f5b0b19..129650fa 100644
> > --- a/checkpolicy/module_compiler.c
> > +++ b/checkpolicy/module_compiler.c
> > @@ -99,6 +99,7 @@ int define_policy(int pass, int module_header_given)
> >                                 yyerror("no module name");
> >                                 return -1;
> >                         }
> > +                       free(policydbp->name);
> >                         policydbp->name =3D id;
> >                         if ((policydbp->version =3D
> >                              queue_remove(id_queue)) =3D=3D NULL) {
> > diff --git a/checkpolicy/parse_util.c b/checkpolicy/parse_util.c
> > index 8c1f393c..f2d1e04d 100644
> > --- a/checkpolicy/parse_util.c
> > +++ b/checkpolicy/parse_util.c
> > @@ -47,6 +47,7 @@ int read_source_policy(policydb_t * p, const char *fi=
le, const char *progname)
> >         }
> >
> >         policydbp =3D p;
> > +       policydbp->name =3D strdup(file);
> >         mlspol =3D p->mls;
> >
> >         init_parser(1);
> > diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
> > index dd2749a0..74f6d9c0 100644
> > --- a/libsepol/src/assertion.c
> > +++ b/libsepol/src/assertion.c
> > @@ -36,13 +36,21 @@ struct avtab_match_args {
> >         unsigned long errors;
> >  };
> >
> > +static const char* policy_name(policydb_t *p) {
> > +       const char *policy_file =3D "policy.conf";
> > +       if (p->name) {
> > +               policy_file =3D p->name;
> > +       }
> > +       return policy_file;
> > +}
> > +
> >  static void report_failure(sepol_handle_t *handle, policydb_t *p, cons=
t avrule_t *avrule,
> >                            unsigned int stype, unsigned int ttype,
> >                            const class_perm_node_t *curperm, uint32_t p=
erms)
> >  {
> >         if (avrule->source_filename) {
> > -               ERR(handle, "neverallow on line %lu of %s (or line %lu =
of policy.conf) violated by allow %s %s:%s {%s };",
> > -                   avrule->source_line, avrule->source_filename, avrul=
e->line,
> > +               ERR(handle, "neverallow on line %lu of %s (or line %lu =
of %s) violated by allow %s %s:%s {%s };",
> > +                   avrule->source_line, avrule->source_filename, avrul=
e->line, policy_name(p),
> >                     p->p_type_val_to_name[stype],
> >                     p->p_type_val_to_name[ttype],
> >                     p->p_class_val_to_name[curperm->tclass - 1],
> > @@ -173,9 +181,9 @@ static int report_assertion_extended_permissions(se=
pol_handle_t *handle,
> >                                 /* failure on the extended permission c=
heck_extended_permissions */
> >                                 if (rc) {
> >                                         extended_permissions_violated(&=
error, avrule->xperms, xperms);
> > -                                       ERR(handle, "neverallowxperm on=
 line %lu of %s (or line %lu of policy.conf) violated by\n"
> > +                                       ERR(handle, "neverallowxperm on=
 line %lu of %s (or line %lu of %s) violated by\n"
> >                                                         "allowxperm %s =
%s:%s %s;",
> > -                                                       avrule->source_=
line, avrule->source_filename, avrule->line,
> > +                                                       avrule->source_=
line, avrule->source_filename, avrule->line, policy_name(p),
> >                                                         p->p_type_val_t=
o_name[i],
> >                                                         p->p_type_val_t=
o_name[j],
> >                                                         p->p_class_val_=
to_name[curperm->tclass - 1],
> > @@ -190,9 +198,9 @@ static int report_assertion_extended_permissions(se=
pol_handle_t *handle,
> >
> >         /* failure on the regular permissions */
> >         if (rc) {
> > -               ERR(handle, "neverallowxperm on line %lu of %s (or line=
 %lu of policy.conf) violated by\n"
> > +               ERR(handle, "neverallowxperm on line %lu of %s (or line=
 %lu of %s) violated by\n"
> >                                 "allow %s %s:%s {%s };",
> > -                               avrule->source_line, avrule->source_fil=
ename, avrule->line,
> > +                               avrule->source_line, avrule->source_fil=
ename, avrule->line, policy_name(p),
> >                                 p->p_type_val_to_name[stype],
> >                                 p->p_type_val_to_name[ttype],
> >                                 p->p_class_val_to_name[curperm->tclass =
- 1],
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 8667f2ed..7da51a40 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -2970,6 +2970,9 @@ int expand_module(sepol_handle_t * handle,
> >
> >         state.out->policy_type =3D POLICY_KERN;
> >         state.out->policyvers =3D POLICYDB_VERSION_MAX;
> > +       if (state.base->name) {
> > +               state.out->name =3D strdup(state.base->name);
> > +       }
> >
> >         /* Copy mls state from base to out */
> >         out->mls =3D base->mls;
> > --
> > 2.35.1.265.g69c8d7142f-goog
> >
