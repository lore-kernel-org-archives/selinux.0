Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgevGAFt"
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3B5122
	for <selinux@vger.kernel.org>; Fri,  8 Dec 2023 07:17:41 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50bf26b677dso2124607e87.2
        for <selinux@vger.kernel.org>; Fri, 08 Dec 2023 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702048659; x=1702653459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbnPkPCGKF1wgwroqhMSvJU3ZtY7AbddCGR6sMgTlxg=;
        b=UgevGAFtJQGEzAA72ImpRuoJxFYVSLyMFMYbvXqLpa4fRjYjQjq5vt8ZNczNRC+obt
         f5DymK9aOyapklcoyy8y/48CD7LiWZz2yNM8b+YHbhEJ2ojPxBQOAaa3zaBbe/lvmWiu
         +q9EIMs4pd2TbyPNRNG3hSP0e6RaX0Ak6wif68zOuZUfH0Tsl/Z5BISMvsoB/BuAu/Og
         T1b8wzp0+Bpu7bErVdgyp1G2Y3tWZbQnuA+wtgJvvrwN/upjMDZ5zcft8op2Ei7WJ0Q2
         u8+xUoXtL9u/lBd5NhrMMkJRgv8KX70PwbBPdSkgocwKhdCFlhOnQhxvFXwjUGU1oS4a
         vABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048659; x=1702653459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbnPkPCGKF1wgwroqhMSvJU3ZtY7AbddCGR6sMgTlxg=;
        b=raF+FG/ShXeoKK2l7FUqZM3aQCVfE0lxEPdb3mWIcfhFS+gIQpB4QJzFYDvyLmN1gW
         fapTQD/mz7tUM8t6Sb4lNomL+M0zSDgcAOumtQg75RnjOsxQbZ50pMge0KMB5V7TtwS9
         ZM+AsI9FyexXq9mviy2eQE2c3eukPRsJi2aOycgG5KYrPdql42Yb2ZtrDrIJkY+Vmo7I
         3Djnx5qPVKjbl5oJvxnhRaSwdIW0dfSVKbnALUT6FA59AjHBv33jvtNFFcMZJ9ynZ1fY
         Z0HBqhrggbzZbM+KpgTq1sR/EK3KGTN5tPdiqvhLifp23YV55mpcKgEYsQ6LIfuNLupL
         dzBg==
X-Gm-Message-State: AOJu0YzFn8b02a/h8G0BI8W2gcmF0O2vddNdSdMP6SPZrxGDknxkIItp
	wEBSyu75wfcyxyUjc2jIQmBNREmOMrRt1b6HfYL+1peUzJ4=
X-Google-Smtp-Source: AGHT+IFh5NfR+HQN65zPeryIXzySHksRs+7D1lpZ1HtcyxAchEQ7Ok6pNTyScEi08vpuGy4qjz2ijaX4Yh5VcaIzqMk=
X-Received: by 2002:a05:6512:39c9:b0:50b:fe38:53fe with SMTP id
 k9-20020a05651239c900b0050bfe3853femr28593lfu.5.1702048659230; Fri, 08 Dec
 2023 07:17:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207165336.64135-1-cgzones@googlemail.com>
In-Reply-To: <20231207165336.64135-1-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 8 Dec 2023 10:17:27 -0500
Message-ID: <CAP+JOzRU61Y5xe3wDSuMHisOxgdFHoE31gh5AdieFycsKYvrOg@mail.gmail.com>
Subject: Re: [PATCH v2] checkpolicy/dispol: misc updates
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 11:53=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> * add option to display users
> * drop duplicate option to display booleans
> * show number of entries before listing them
> * drop global variable
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
> v2:
>    drop 'b' instead of '5' of duplicated boolean option
> ---
>  checkpolicy/test/dispol.c | 57 ++++++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 27 deletions(-)
>
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index 944ef7ec..18829c97 100644
> --- a/checkpolicy/test/dispol.c
> +++ b/checkpolicy/test/dispol.c
> @@ -33,9 +33,7 @@
>  #include <stdio.h>
>  #include <fcntl.h>
>
> -static policydb_t policydb;
> -
> -static struct command {
> +static const struct command {
>         enum {
>                 EOL    =3D 0,
>                 HEADER =3D 1,
> @@ -50,19 +48,19 @@ static struct command {
>         {CMD,       '2',  "display conditional AVTAB (entirely)"},
>         {CMD,       '3',  "display conditional AVTAB (only ENABLED rules)=
"},
>         {CMD,       '4',  "display conditional AVTAB (only DISABLED rules=
)"},
> -       {CMD,       '5',  "display conditional bools"},
> +       {CMD,       '5',  "display booleans"},
>         {CMD,       '6',  "display conditional expressions"},
>         {CMD|NOOPT, '7',  "change a boolean value"},
>         {CMD,       '8',  "display role transitions"},
>         {HEADER, 0, ""},
>         {CMD,       'c',  "display policy capabilities"},
> -       {CMD,       'b',  "display booleans"},
>         {CMD,       'C',  "display classes"},
> +       {CMD,       'u',  "display users"},
>         {CMD,       'r',  "display roles"},
>         {CMD,       't',  "display types"},
>         {CMD,       'a',  "display type attributes"},
>         {CMD,       'p',  "display the list of permissive types"},
> -       {CMD,       'u',  "display unknown handling setting"},
> +       {CMD,       'U',  "display unknown handling setting"},
>         {CMD,       'F',  "display filename_trans rules"},
>         {HEADER, 0, ""},
>         {CMD|NOOPT, 'f',  "set output file"},
> @@ -234,17 +232,6 @@ static int display_avtab(avtab_t * a, uint32_t what,=
 policydb_t * p, FILE * fp)
>         return 0;
>  }
>
> -static int display_bools(policydb_t * p, FILE * fp)
> -{
> -       unsigned int i;
> -
> -       for (i =3D 0; i < p->p_bools.nprim; i++) {
> -               fprintf(fp, "%s : %d\n", p->p_bool_val_to_name[i],
> -                       p->bool_val_to_struct[i]->state);
> -       }
> -       return 0;
> -}
> -
>  static void display_expr(policydb_t * p, cond_expr_t * exp, FILE * fp)
>  {
>
> @@ -313,6 +300,8 @@ static int display_handle_unknown(policydb_t * p, FIL=
E * out_fp)
>                 fprintf(out_fp, "Deny unknown classes and permissions\n")=
;
>         else if (p->handle_unknown =3D=3D REJECT_UNKNOWN)
>                 fprintf(out_fp, "Reject unknown classes and permissions\n=
");
> +       else
> +               fprintf(out_fp, "<INVALID SETTING!>\n");
>         return 0;
>  }
>
> @@ -334,7 +323,7 @@ static int display_booleans(policydb_t * p, FILE *fp)
>  {
>         uint32_t i;
>
> -       fprintf(fp, "booleans:\n");
> +       fprintf(fp, "booleans (#%u):\n", p->p_bools.table->nel);
>         for (i =3D 0; i < p->p_bools.nprim; i++) {
>                 fprintf(fp, "\t%s : %d\n", p->p_bool_val_to_name[i],
>                         p->bool_val_to_struct[i]->state);
> @@ -364,7 +353,7 @@ static int display_classes(policydb_t * p, FILE *fp)
>  {
>         uint32_t i;
>
> -       fprintf(fp, "classes:\n");
> +       fprintf(fp, "classes (#%u):\n", p->p_classes.table->nel);
>         for (i =3D 0; i < p->p_classes.nprim; i++) {
>                 if (!p->p_class_val_to_name[i])
>                         continue;
> @@ -386,7 +375,7 @@ static void display_permissive(policydb_t *p, FILE *f=
p)
>         ebitmap_node_t *node;
>         unsigned int i;
>
> -       fprintf(fp, "permissive sids:\n");
> +       fprintf(fp, "permissive sids (#%u):\n", ebitmap_cardinality(&p->p=
ermissive_map));
>         ebitmap_for_each_positive_bit(&p->permissive_map, node, i) {
>                 fprintf(fp, "\t");
>                 display_id(p, fp, SYM_TYPES, i - 1, "");
> @@ -394,11 +383,25 @@ static void display_permissive(policydb_t *p, FILE =
*fp)
>         }
>  }
>
> +static int display_users(policydb_t * p, FILE *fp)
> +{
> +       uint32_t i;
> +
> +       fprintf(fp, "users (#%u):\n", p->p_users.table->nel);
> +       for (i =3D 0; i < p->p_users.nprim; i++) {
> +               if (!p->p_user_val_to_name[i])
> +                       continue;
> +
> +               fprintf(fp, "\t%s\n", p->p_user_val_to_name[i]);
> +       }
> +       return 0;
> +}
> +
>  static int display_roles(policydb_t * p, FILE *fp)
>  {
>         uint32_t i;
>
> -       fprintf(fp, "roles:\n");
> +       fprintf(fp, "roles (#%u):\n", p->p_roles.table->nel);
>         for (i =3D 0; i < p->p_roles.nprim; i++) {
>                 if (!p->p_role_val_to_name[i])
>                         continue;
> @@ -412,7 +415,7 @@ static int display_types(policydb_t * p, FILE *fp)
>  {
>         uint32_t i;
>
> -       fprintf(fp, "types:\n");
> +       fprintf(fp, "types (out of #%u):\n", p->p_types.table->nel);
>         for (i =3D 0; i < p->p_types.nprim; i++) {
>                 if (!p->p_type_val_to_name[i])
>                         continue;
> @@ -429,7 +432,7 @@ static int display_attributes(policydb_t * p, FILE *f=
p)
>  {
>         uint32_t i;
>
> -       fprintf(fp, "attributes:\n");
> +       fprintf(fp, "attributes (out of #%u):\n", p->p_types.table->nel);
>         for (i =3D 0; i < p->p_types.nprim; i++) {
>                 if (!p->p_type_val_to_name[i])
>                         continue;
> @@ -522,6 +525,7 @@ int main(int argc, char **argv)
>         char *name;
>         int state;
>         struct policy_file pf;
> +       policydb_t policydb;
>
>         if (argc < 2 || strcmp(argv[1], "-h") =3D=3D 0 || strcmp(argv[1],=
 "--help") =3D=3D 0)
>                 usage(argv[0]);
> @@ -617,7 +621,7 @@ int main(int argc, char **argv)
>                                       &policydb, out_fp);
>                         break;
>                 case '5':
> -                       display_bools(&policydb, out_fp);
> +                       display_booleans(&policydb, out_fp);
>                         break;
>                 case '6':
>                         display_cond_expressions(&policydb, out_fp);
> @@ -659,9 +663,6 @@ int main(int argc, char **argv)
>                 case 'a':
>                         display_attributes(&policydb, out_fp);
>                         break;
> -               case 'b':
> -                       display_booleans(&policydb, out_fp);
> -                       break;
>                 case 'c':
>                         display_policycaps(&policydb, out_fp);
>                         break;
> @@ -678,6 +679,8 @@ int main(int argc, char **argv)
>                         display_types(&policydb, out_fp);
>                         break;
>                 case 'u':
> +                       display_users(&policydb, out_fp);
> +                       break;
>                 case 'U':
>                         display_handle_unknown(&policydb, out_fp);
>                         break;
> --
> 2.43.0
>
>
