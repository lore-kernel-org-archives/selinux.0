Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7619AC43334
	for <selinux@archiver.kernel.org>; Thu,  9 Jun 2022 17:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238980AbiFIRmv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jun 2022 13:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240869AbiFIRms (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jun 2022 13:42:48 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D2B7E1F4
        for <selinux@vger.kernel.org>; Thu,  9 Jun 2022 10:42:47 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-fe4ac3b87fso350961fac.3
        for <selinux@vger.kernel.org>; Thu, 09 Jun 2022 10:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=886X5iUOO4uL8GQH6afwNWQL4cJfoy6JcTYWutnBNUI=;
        b=jHxFVfj/rl6Qn6PgA3ajknPNbPMIxiqq6H9S6+c//EpezmCuzZQRal3RwdgON8VI4h
         1oIGllN+SpFO200j0/PNtu/TS/pSLz2bBwU/fbG0Ljwj+bj6xapjx/hYZIxgvIdQ9k+Y
         597eVOga9YGmAeTphA2yxOf367GXW/SDjPgEkujassCVdwe1gHK5Pap+qsTUTfOOJ3+n
         mcqSx7edXVmiR1sVmBtiS+u9ETtMCD8P1cqQNHmFpd1x69hZgsmbzZtaLcD7jUoHoJ4H
         PvcrIfycJVyjGzb5zV4CcYy4MzEXK/Adhed8BICu2YxTajIeL8hDepTfFBAJY4G6Os4t
         QBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=886X5iUOO4uL8GQH6afwNWQL4cJfoy6JcTYWutnBNUI=;
        b=6uAUdKjZ//gU6Ru8EtAzoZGo5tSoFRB1WWs+yVkg6GmyiAOHhilUq4cKLWPJemS8ir
         YizgSUwBFf9UXqM8+o2CAk/NxetSdaZ98GUVsD0I4+lOJV4iZsNtLuWnxX1QRYqPyMCI
         6WWpXT4+XhxlK3lvfPu9LbUUrdq5v4hG7k7aRTX4RngRqU2IE9E4esEnFB2g9MpbFUHI
         NeG3TzFP9Fqd27pUwulp1Wf4eno1FVknlaAkChbHCMABI/5oaM+yt/cAqmMdom0cKDwe
         Ti1/sxLwWRN22ybjdle6RY2+gjQjgskURAjAlHE9nhZO35rqmWM9SBe24j3rIec46EmV
         jeIA==
X-Gm-Message-State: AOAM532kH+sutAwoDJIa87w90IJ1ze2En2FHpds9PN0mo0XP4m5uVoES
        wrv7o5WBmeIR5jyh9R3bF38iqgPAl1fxVwt/X1EdQf5O
X-Google-Smtp-Source: ABdhPJxpDPcKDja9CIYzOW3LxyiKB5TVZLHHpwskhZiuP4awbEku107b3A117/nWT80trAaqsIk/Qmvw53MiL+rd2iU=
X-Received: by 2002:a05:6870:4604:b0:f2:5b64:fad9 with SMTP id
 z4-20020a056870460400b000f25b64fad9mr2400111oao.182.1654796566820; Thu, 09
 Jun 2022 10:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220607174145.51330-1-cgzones@googlemail.com> <20220607174145.51330-3-cgzones@googlemail.com>
In-Reply-To: <20220607174145.51330-3-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 9 Jun 2022 13:42:35 -0400
Message-ID: <CAP+JOzTopQXiGfzF7Bk+Xvc65LhGk5kWAYz_BrmJ_7sZrhtjxw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] checkpolicy: rework initial SID handling
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 7, 2022 at 3:01 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The kernel removed [1] some unused initial SIDs.  Also libsepol got
> support for omitting unused ones [2].
>
> Currently in traditional policy all initial SIDs have to be defined and
> also the order of declarations has to follow the order of the libsepol
> internal representation.  Support omitting unused initial SIDs in the
> traditional policy and do not require a specific order of declarations.
>

I think that your goal is good, but see below.

> [1]: https://github.com/SELinuxProject/selinux-kernel/commit/e3e0b582c321=
aefd72db0e7083a0adfe285e96b5
> [2]: https://github.com/SELinuxProject/selinux/commit/8677ce5e8f592950ae6=
f14cea1b68a20ddc1ac25
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/policy_define.c | 39 ++++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 8bf36859..8f55650d 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -54,6 +54,7 @@
>  #include <sepol/policydb/services.h>
>  #include <sepol/policydb/conditional.h>
>  #include <sepol/policydb/hierarchy.h>
> +#include <sepol/policydb/initialsids.h>
>  #include <sepol/policydb/polcaps.h>
>  #include "queue.h"
>  #include "checkpolicy.h"
> @@ -287,6 +288,7 @@ int define_polcap(void)
>  int define_initial_sid(void)
>  {
>         char *id =3D 0;
> +       sepol_security_id_t sid;
>         ocontext_t *newc =3D 0, *c, *head;
>
>         if (pass =3D=3D 2) {
> @@ -300,28 +302,30 @@ int define_initial_sid(void)
>                 yyerror("no sid name for SID definition?");
>                 return -1;
>         }
> -       newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> -       if (!newc) {
> -               yyerror("out of memory");
> +
> +       sid =3D selinux_str_to_sid(id);
> +       if (sid =3D=3D 0) {
> +               yyerror2("invalid initial SID %s", id);

We can't give an error if the name is not found. In your reference
[2], it is stated that unused SIDs can be renamed and it even suggests
using an "unamed_" prefix.

I am not sure what to suggest here. In the past, one could
theoretically use any name, because all that mattered was the
ordering. I doubt if there are any policies that use any other names,
but I don't know.

Thanks,
Jim


>                 goto bad;
>         }
> -       memset(newc, 0, sizeof(ocontext_t));
> -       newc->u.name =3D id;
> -       context_init(&newc->context[0]);
> -       head =3D policydbp->ocontexts[OCON_ISID];
>
> +       head =3D policydbp->ocontexts[OCON_ISID];
>         for (c =3D head; c; c =3D c->next) {
> -               if (!strcmp(newc->u.name, c->u.name)) {
> +               if (sid =3D=3D c->sid[0]) {
>                         yyerror2("duplicate initial SID %s", id);
>                         goto bad;
>                 }
>         }
>
> -       if (head) {
> -               newc->sid[0] =3D head->sid[0] + 1;
> -       } else {
> -               newc->sid[0] =3D 1;
> +       newc =3D (ocontext_t *) malloc(sizeof(ocontext_t));
> +       if (!newc) {
> +               yyerror("out of memory");
> +               goto bad;
>         }
> +       memset(newc, 0, sizeof(ocontext_t));
> +       newc->u.name =3D id;
> +       context_init(&newc->context[0]);
> +       newc->sid[0] =3D sid;
>         newc->next =3D head;
>         policydbp->ocontexts[OCON_ISID] =3D newc;
>
> @@ -4567,6 +4571,7 @@ static int parse_security_context(context_struct_t =
* c)
>  int define_initial_sid_context(void)
>  {
>         char *id;
> +       sepol_security_id_t sid;
>         ocontext_t *c, *head;
>
>         if (pass =3D=3D 1) {
> @@ -4581,9 +4586,17 @@ int define_initial_sid_context(void)
>                 yyerror("no sid name for SID context definition?");
>                 return -1;
>         }
> +
> +       sid =3D selinux_str_to_sid(id);
> +       if (sid =3D=3D 0) {
> +               yyerror2("invalid initial SID %s", id);
> +               free(id);
> +               return -1;
> +       }
> +
>         head =3D policydbp->ocontexts[OCON_ISID];
>         for (c =3D head; c; c =3D c->next) {
> -               if (!strcmp(id, c->u.name))
> +               if (sid =3D=3D c->sid[0])
>                         break;
>         }
>
> --
> 2.36.1
>
