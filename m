Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0KZq7If"
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5554D6C
	for <selinux@vger.kernel.org>; Fri,  1 Dec 2023 11:52:31 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bd4fcbde1so2373243e87.1
        for <selinux@vger.kernel.org>; Fri, 01 Dec 2023 11:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701460350; x=1702065150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woeD0Ey2nNjk0otcADO9sJIgc1KsQcPfQYdY/xOg0Zg=;
        b=F0KZq7IfEmLyDkSpSDryHPkY7Y426Kj2fv6Z216Y7ykJmPwbF+V8kGv+vI/KJ3fPvs
         IizyqN/0OzQv9Ipf5OxHt8sq1PPfJBTBG805qGvb//MbkgHTsAz47r71c+AYGm5O3maR
         guyC/xRoy1LabBMCmjKsJV3D1xkniuB0U1SumMF8tFAifmxRXWgBzkHWok+UyV+qW2Bn
         nc5DuGe/3HlsAQLDRJD8CFPmUCeOfqbpLtVtd52ntqXERXiWy5Cxx9PV4feONpDVgkr9
         T6uo+3Suj5I22V6WpNKgJoKS7YCGBTif5UZswYh+160L0DStPB7cY4BxaJ8gWXLAaJBW
         tHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701460350; x=1702065150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woeD0Ey2nNjk0otcADO9sJIgc1KsQcPfQYdY/xOg0Zg=;
        b=Ur7mCvSRuzbyPmZN/w8jipnR9npxok2c62dYWuwOLbBmxvM9IFalB3c2izf+5K+V3y
         +zZXX/T2hMIWtXmdaLyAd6bDceFbhAH8yC3ieeK0s9X31BYSjFJd4FtY9wn2PkVCeDpM
         F8durXUfVFA+aXjacBXPpsiXa2Jw+BVkE/dqJ4Oxio9FmUwdCLhWoir8eCQ97nwFTp5n
         HuKxDdcZVCoCwN7U1oyWmayJrqB5MOV+MuF9N6NUXPC8IKl8tpu8D+z7l8MO912sqnbP
         OuLOG5suY+cqQ7F/BFon6Sf9V70UEjUEKUIHDEFsmYRoTwKinlpc6kC1hFlx6UmV9Q5G
         hUww==
X-Gm-Message-State: AOJu0YwAgiiDNYeeKMIJo3ni+1xl0ZiyfmdcDPS2wcJV+F0IxPsSQSci
	7eg9mr6aRiCkZKTJX7hmxaVciSfkoGLzogFWMFg=
X-Google-Smtp-Source: AGHT+IHCjOU+q994QCbZZMPDT6p8ksZjWvVWbT+dG9ZVEX0WhT+nsRTc/1O5CAZwEmzqISwcZwwe3OzmYV7hx4yhfrk=
X-Received: by 2002:ac2:5589:0:b0:50b:bb8f:eb77 with SMTP id
 v9-20020ac25589000000b0050bbb8feb77mr991617lfg.45.1701460349728; Fri, 01 Dec
 2023 11:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128182334.57740-1-cgzones@googlemail.com> <20231128182334.57740-4-cgzones@googlemail.com>
In-Reply-To: <20231128182334.57740-4-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 1 Dec 2023 14:52:18 -0500
Message-ID: <CAP+JOzTieqd0d=PO3xV6DPv8W-r+2Kg5bh48mneHyziTveNNYw@mail.gmail.com>
Subject: Re: [PATCH 4/7] checkpolicy/dispol: misc updates
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 1:23=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> * add option to display users
> * drop duplicate option to display booleans
> * show number of entries before listing them
> * drop global variable
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  checkpolicy/test/dispol.c | 53 +++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 25 deletions(-)
>
> diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
> index 944ef7ec..02cb9499 100644
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
> @@ -50,7 +48,6 @@ static struct command {
>         {CMD,       '2',  "display conditional AVTAB (entirely)"},
>         {CMD,       '3',  "display conditional AVTAB (only ENABLED rules)=
"},
>         {CMD,       '4',  "display conditional AVTAB (only DISABLED rules=
)"},
> -       {CMD,       '5',  "display conditional bools"},

This command is older than 'b'.
I would like to keep it, but with it saying "display booleans" like
below and calling the display_booleans() function like below.
If there is something else that would use '5', that would be fine. It
just seems weird to skip a number.

Thanks,
Jim

>         {CMD,       '6',  "display conditional expressions"},
>         {CMD|NOOPT, '7',  "change a boolean value"},
>         {CMD,       '8',  "display role transitions"},
> @@ -58,11 +55,12 @@ static struct command {
>         {CMD,       'c',  "display policy capabilities"},
>         {CMD,       'b',  "display booleans"},
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
> @@ -616,9 +620,6 @@ int main(int argc, char **argv)
>                         display_avtab(&policydb.te_cond_avtab, RENDER_DIS=
ABLED,
>                                       &policydb, out_fp);
>                         break;
> -               case '5':
> -                       display_bools(&policydb, out_fp);
> -                       break;
>                 case '6':
>                         display_cond_expressions(&policydb, out_fp);
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
