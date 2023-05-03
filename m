Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10166C77B7F
	for <selinux@archiver.kernel.org>; Wed,  3 May 2023 16:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjECQYQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 May 2023 12:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjECQYP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 May 2023 12:24:15 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D354EEC
        for <selinux@vger.kernel.org>; Wed,  3 May 2023 09:24:13 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ac7462d9f1so9983691fa.2
        for <selinux@vger.kernel.org>; Wed, 03 May 2023 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683131052; x=1685723052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWv4Eee4LNho2nQY6xWW5rcSKA5adX2v9Kt5fpG+1V0=;
        b=lEctZdQxExnUXuRUzT3zRz8uAr9gj3RdX2ohW7ZBYWDUsrUKneRzk84K+9IkPkIxrh
         tIqUoqMFf7UMSP4s8CQKycYIPEtCU0dC/qRGhE6PerfbVkfm4VpgRKM3ctYW7/lmnNcs
         wz/nZR/o5nXcYBUpYa9ZaQcGHMUjL9GiSYJ0YCOzooodiKAzQ04oSAHg3N4IQfpPAJs+
         yyIgSe07KAPqm62iE9OUS9u24JZx0WLiKbm99lPwZHd2Kw20LoXxh1Pb4gfNDdYrZuRM
         /4xhiYwcDWxDT3SV0iArooLgcmgUnwCzBe7s61DW8E6XskjyzhIpLu0wsXuuBQqoQRAF
         L3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131052; x=1685723052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWv4Eee4LNho2nQY6xWW5rcSKA5adX2v9Kt5fpG+1V0=;
        b=ladvNUUKyAAY53EMzD2wWlEbszAuPfuWTAOg7c/W/5qOJRgN3bY/SznPNeIWmXZunU
         KhSn/AIHYcIJVGxl8xojjXk69DznptAH023Q2d1JTI2L75WZEkTrQg+obruQ+JCvk6wG
         MuH8L2sePxZF9gOdkTN44ktXQSSL9lAH/HSDCAFj8kvu8Km5nxnT+lqNxcpX43AXg8WS
         iPa7E5BH+AKJuQ3r+XzqQbr88e99KDDswF5raWugOmfdwIbdDFelcX1AzeDlT4UvDDJc
         JgXrPcc/bgwXdMT4N25Y/VGSxzLlDr2Ql/K810Dxx7u6yZTKdOZz1EK4/0DsWfhBQ+dB
         Lm4g==
X-Gm-Message-State: AC+VfDyhUiqrJ+K4l6f/MZpvMNPZGkxrQ36ZUIaTTtPfUXBon8c3NiAq
        Uzvcu0AJMi13XGLSC5wGbMmFzx4PJJFCUV+NAP0=
X-Google-Smtp-Source: ACHHUZ5f8pKFhriQVZuh2ZUJLOVnMDxP8B4t7bSHD0kNQLGdNuFSVl9LXj65fBHlJQIRXDqwuCqjW3WrSd/ANJpx2Nk=
X-Received: by 2002:a2e:3a03:0:b0:2a7:6f60:34f2 with SMTP id
 h3-20020a2e3a03000000b002a76f6034f2mr161465lja.33.1683131051645; Wed, 03 May
 2023 09:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230331173442.101678-1-cgzones@googlemail.com>
 <20230331173442.101678-2-cgzones@googlemail.com> <CAP+JOzRNquDkfZm98Wv3+Ce0nOQVypvYM8dQnUJmGpCHKPowJQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRNquDkfZm98Wv3+Ce0nOQVypvYM8dQnUJmGpCHKPowJQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 3 May 2023 12:24:00 -0400
Message-ID: <CAP+JOzRk8z2osiLHjWDasqvce58YdYWmmpYKcBCxEMKLApf9AA@mail.gmail.com>
Subject: Re: [PATCH 2/3] checkpolicy/dispol: add output functions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 24, 2023 at 3:07=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Mar 31, 2023 at 1:37=E2=80=AFPM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add the ability to show booleans, classes, roles, types and type
> > attributes of policies.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

This patch has been merged since it was independent of the other two.
(The other two were not merged.)
Thanks,
Jim

> > ---
> > Almost all of the time seinfo(8) is a superior tool and several policy
> > details are still not supported, e.g. genfscon, ocontexts and class
> > constraints.
> > dispol was however useful in the past to analyze some OSS-Fuzz generate=
d
> > policies, since seinfo trips over non-ascii identifier names.
> > ---
> >  checkpolicy/test/dispol.c | 94 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 94 insertions(+)
> >
> > diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> > index 36a3362c..adac2370 100644
> > --- a/checkpolicy/test/dispol.c
> > +++ b/checkpolicy/test/dispol.c
> > @@ -274,6 +274,18 @@ static int change_bool(char *name, int state, poli=
cydb_t * p, FILE * fp)
> >         return 0;
> >  }
> >
> > +static int display_booleans(policydb_t * p, FILE *fp)
> > +{
> > +       uint32_t i;
> > +
> > +       fprintf(fp, "booleans:\n");
> > +       for (i =3D 0; i < p->p_bools.nprim; i++) {
> > +               fprintf(fp, "\t%s : %d\n", p->p_bool_val_to_name[i],
> > +                       p->bool_val_to_struct[i]->state);
> > +       }
> > +       return 0;
> > +}
> > +
> >  static void display_policycaps(policydb_t * p, FILE * fp)
> >  {
> >         ebitmap_node_t *node;
> > @@ -292,6 +304,20 @@ static void display_policycaps(policydb_t * p, FIL=
E * fp)
> >         }
> >  }
> >
> > +static int display_classes(policydb_t * p, FILE *fp)
> > +{
> > +       uint32_t i;
> > +
> > +       fprintf(fp, "classes:\n");
> > +       for (i =3D 0; i < p->p_classes.nprim; i++) {
> > +               if (!p->p_class_val_to_name[i])
> > +                       continue;
> > +
> > +               fprintf(fp, "\t%s\n", p->p_class_val_to_name[i]);
> > +       }
> > +       return 0;
> > +}
> > +
> >  static void display_id(policydb_t *p, FILE *fp, uint32_t symbol_type,
> >                        uint32_t symbol_value, const char *prefix)
> >  {
> > @@ -312,6 +338,54 @@ static void display_permissive(policydb_t *p, FILE=
 *fp)
> >         }
> >  }
> >
> > +static int display_roles(policydb_t * p, FILE *fp)
> > +{
> > +       uint32_t i;
> > +
> > +       fprintf(fp, "roles:\n");
> > +       for (i =3D 0; i < p->p_roles.nprim; i++) {
> > +               if (!p->p_role_val_to_name[i])
> > +                       continue;
> > +
> > +               fprintf(fp, "\t%s\n", p->p_role_val_to_name[i]);
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int display_types(policydb_t * p, FILE *fp)
> > +{
> > +       uint32_t i;
> > +
> > +       fprintf(fp, "types:\n");
> > +       for (i =3D 0; i < p->p_types.nprim; i++) {
> > +               if (!p->p_type_val_to_name[i])
> > +                       continue;
> > +
> > +               if (p->type_val_to_struct[i]->flavor =3D=3D TYPE_ATTRIB=
)
> > +                       continue;
> > +
> > +               fprintf(fp, "\t%s\n", p->p_type_val_to_name[i]);
> > +       }
> > +       return 0;
> > +}
> > +
> > +static int display_attributes(policydb_t * p, FILE *fp)
> > +{
> > +       uint32_t i;
> > +
> > +       fprintf(fp, "attributes:\n");
> > +       for (i =3D 0; i < p->p_types.nprim; i++) {
> > +               if (!p->p_type_val_to_name[i])
> > +                       continue;
> > +
> > +               if (p->type_val_to_struct[i]->flavor !=3D TYPE_ATTRIB)
> > +                       continue;
> > +
> > +               fprintf(fp, "\t%s\n", p->p_type_val_to_name[i]);
> > +       }
> > +       return 0;
> > +}
> > +
> >  static void display_role_trans(policydb_t *p, FILE *fp)
> >  {
> >         role_trans_t *rt;
> > @@ -381,6 +455,11 @@ static int menu(void)
> >         printf("8)  display role transitions\n");
> >         printf("\n");
> >         printf("c)  display policy capabilities\n");
> > +       printf("b)  display booleans\n");
> > +       printf("C)  display classes\n");
> > +       printf("r)  display roles\n");
> > +       printf("t)  display types\n");
> > +       printf("a)  display type attributes\n");
> >         printf("p)  display the list of permissive types\n");
> >         printf("u)  display unknown handling setting\n");
> >         printf("F)  display filename_trans rules\n");
> > @@ -511,12 +590,27 @@ int main(int argc, char **argv)
> >                 case '8':
> >                         display_role_trans(&policydb, out_fp);
> >                         break;
> > +               case 'a':
> > +                       display_attributes(&policydb, out_fp);
> > +                       break;
> > +               case 'b':
> > +                       display_booleans(&policydb, out_fp);
> > +                       break;
> >                 case 'c':
> >                         display_policycaps(&policydb, out_fp);
> >                         break;
> > +               case 'C':
> > +                       display_classes(&policydb, out_fp);
> > +                       break;
> >                 case 'p':
> >                         display_permissive(&policydb, out_fp);
> >                         break;
> > +               case 'r':
> > +                       display_roles(&policydb, out_fp);
> > +                       break;
> > +               case 't':
> > +                       display_types(&policydb, out_fp);
> > +                       break;
> >                 case 'u':
> >                 case 'U':
> >                         display_handle_unknown(&policydb, out_fp);
> > --
> > 2.40.0
> >
