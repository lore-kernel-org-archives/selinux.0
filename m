Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB707C77B61
	for <selinux@archiver.kernel.org>; Mon, 24 Apr 2023 19:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjDXTHj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Apr 2023 15:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjDXTHh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Apr 2023 15:07:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12F6E9
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 12:07:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94a34a14a54so882820366b.1
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 12:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682363251; x=1684955251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0KP8Ruhmqk0CHTKXZiV7LTzV23+2U21VcCUUAOv5Cw=;
        b=OFGi5JqzB++m0rNGWzpEW1zJuOj4KFZYXJcAzn/GgO4uGxJ1Oov/yRHX4nj3xAN8DS
         RryNPw5JAyL43lZOMCE2F+yeIw2GWJ0CRC2pE/IeQF7myjuIq/5E1dhsvx6+U88RTm0X
         INjY5YvvCsXcvQzfRO7pfIu/jn7RUKLDeNzR/kU5BI+7sFJh5rfHAdzPkgl6xlAsTnuG
         SCu/qfQHMuPXgcJUngB1GYAXvjyL0TzlvzvoEGpi4UFD9KiKp5EvfAaa8ErnCtkLPymJ
         gtWlh9Pkrh0/5RUngWC41oXJRdBQZa2k4YJ6eFSlsD5I8xtGzzzE0Dwm4jmq1Tm/WyI6
         MtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682363251; x=1684955251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0KP8Ruhmqk0CHTKXZiV7LTzV23+2U21VcCUUAOv5Cw=;
        b=XfqL59i3Ut0stU6NcJW2w2CY2DF/F3romifocfvQs2bYX66SsOurwzMGZD+nmWK/pJ
         uVCoEeS/9hbfEcGqbmMaExv2H9Hudg8Ubb+QsQAAQCVopSkQv0n7iTnijRikxaq0313o
         66CO3heLanaHJFwrZ+s2lDveW4hE7BKjdftesaQHioHhzh6VC2Ht1PlNGvjKa9cIJumJ
         9auCjk8MqTimTEFq9VMSnwjhqdV2mWe/1XhrmOia0s9MVnaTrB1cb+ujUGGpCCkwwFL9
         UxfVzJz3K9DkWXg8vhnRRCus5ZMijS5zyQVArRl8uYSM8K6mSLaJJeEResiKsdH4fT2+
         2H1A==
X-Gm-Message-State: AAQBX9eJA2WmNv+lznnOCDzVnnKtW7J61lAnIMNtZ6hp3Z3NWgf6ME9N
        yHAMpVjruQaRZRJQpoTcA5CH1CF3kW4j9v90tZ4=
X-Google-Smtp-Source: AKy350apVnjFKT3E0GGNfwtzLI+ULfX5bUI9qQ0/JxHbfNsBq++agZuTJ11hNxwhleUbgRoCTD2XEMiMaYy1pyQ9Ap0=
X-Received: by 2002:a17:907:765a:b0:94a:643f:ba5e with SMTP id
 kj26-20020a170907765a00b0094a643fba5emr10601879ejc.46.1682363251039; Mon, 24
 Apr 2023 12:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230331173442.101678-1-cgzones@googlemail.com> <20230331173442.101678-2-cgzones@googlemail.com>
In-Reply-To: <20230331173442.101678-2-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 24 Apr 2023 15:07:20 -0400
Message-ID: <CAP+JOzRNquDkfZm98Wv3+Ce0nOQVypvYM8dQnUJmGpCHKPowJQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] checkpolicy/dispol: add output functions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 31, 2023 at 1:37=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add the ability to show booleans, classes, roles, types and type
> attributes of policies.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> Almost all of the time seinfo(8) is a superior tool and several policy
> details are still not supported, e.g. genfscon, ocontexts and class
> constraints.
> dispol was however useful in the past to analyze some OSS-Fuzz generated
> policies, since seinfo trips over non-ascii identifier names.
> ---
>  checkpolicy/test/dispol.c | 94 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index 36a3362c..adac2370 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -274,6 +274,18 @@ static int change_bool(char *name, int state, policy=
db_t * p, FILE * fp)
>         return 0;
>  }
>
> +static int display_booleans(policydb_t * p, FILE *fp)
> +{
> +       uint32_t i;
> +
> +       fprintf(fp, "booleans:\n");
> +       for (i =3D 0; i < p->p_bools.nprim; i++) {
> +               fprintf(fp, "\t%s : %d\n", p->p_bool_val_to_name[i],
> +                       p->bool_val_to_struct[i]->state);
> +       }
> +       return 0;
> +}
> +
>  static void display_policycaps(policydb_t * p, FILE * fp)
>  {
>         ebitmap_node_t *node;
> @@ -292,6 +304,20 @@ static void display_policycaps(policydb_t * p, FILE =
* fp)
>         }
>  }
>
> +static int display_classes(policydb_t * p, FILE *fp)
> +{
> +       uint32_t i;
> +
> +       fprintf(fp, "classes:\n");
> +       for (i =3D 0; i < p->p_classes.nprim; i++) {
> +               if (!p->p_class_val_to_name[i])
> +                       continue;
> +
> +               fprintf(fp, "\t%s\n", p->p_class_val_to_name[i]);
> +       }
> +       return 0;
> +}
> +
>  static void display_id(policydb_t *p, FILE *fp, uint32_t symbol_type,
>                        uint32_t symbol_value, const char *prefix)
>  {
> @@ -312,6 +338,54 @@ static void display_permissive(policydb_t *p, FILE *=
fp)
>         }
>  }
>
> +static int display_roles(policydb_t * p, FILE *fp)
> +{
> +       uint32_t i;
> +
> +       fprintf(fp, "roles:\n");
> +       for (i =3D 0; i < p->p_roles.nprim; i++) {
> +               if (!p->p_role_val_to_name[i])
> +                       continue;
> +
> +               fprintf(fp, "\t%s\n", p->p_role_val_to_name[i]);
> +       }
> +       return 0;
> +}
> +
> +static int display_types(policydb_t * p, FILE *fp)
> +{
> +       uint32_t i;
> +
> +       fprintf(fp, "types:\n");
> +       for (i =3D 0; i < p->p_types.nprim; i++) {
> +               if (!p->p_type_val_to_name[i])
> +                       continue;
> +
> +               if (p->type_val_to_struct[i]->flavor =3D=3D TYPE_ATTRIB)
> +                       continue;
> +
> +               fprintf(fp, "\t%s\n", p->p_type_val_to_name[i]);
> +       }
> +       return 0;
> +}
> +
> +static int display_attributes(policydb_t * p, FILE *fp)
> +{
> +       uint32_t i;
> +
> +       fprintf(fp, "attributes:\n");
> +       for (i =3D 0; i < p->p_types.nprim; i++) {
> +               if (!p->p_type_val_to_name[i])
> +                       continue;
> +
> +               if (p->type_val_to_struct[i]->flavor !=3D TYPE_ATTRIB)
> +                       continue;
> +
> +               fprintf(fp, "\t%s\n", p->p_type_val_to_name[i]);
> +       }
> +       return 0;
> +}
> +
>  static void display_role_trans(policydb_t *p, FILE *fp)
>  {
>         role_trans_t *rt;
> @@ -381,6 +455,11 @@ static int menu(void)
>         printf("8)  display role transitions\n");
>         printf("\n");
>         printf("c)  display policy capabilities\n");
> +       printf("b)  display booleans\n");
> +       printf("C)  display classes\n");
> +       printf("r)  display roles\n");
> +       printf("t)  display types\n");
> +       printf("a)  display type attributes\n");
>         printf("p)  display the list of permissive types\n");
>         printf("u)  display unknown handling setting\n");
>         printf("F)  display filename_trans rules\n");
> @@ -511,12 +590,27 @@ int main(int argc, char **argv)
>                 case '8':
>                         display_role_trans(&policydb, out_fp);
>                         break;
> +               case 'a':
> +                       display_attributes(&policydb, out_fp);
> +                       break;
> +               case 'b':
> +                       display_booleans(&policydb, out_fp);
> +                       break;
>                 case 'c':
>                         display_policycaps(&policydb, out_fp);
>                         break;
> +               case 'C':
> +                       display_classes(&policydb, out_fp);
> +                       break;
>                 case 'p':
>                         display_permissive(&policydb, out_fp);
>                         break;
> +               case 'r':
> +                       display_roles(&policydb, out_fp);
> +                       break;
> +               case 't':
> +                       display_types(&policydb, out_fp);
> +                       break;
>                 case 'u':
>                 case 'U':
>                         display_handle_unknown(&policydb, out_fp);
> --
> 2.40.0
>
