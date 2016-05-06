MIME-Version: 1.0
In-Reply-To: <CAFftDdpeO4C7nH6coQ-ZXrab+eCWjkVo8bv=SHQ-5mMe_o_Rdg@mail.gmail.com>
References: <1462561003-2629-1-git-send-email-jwcart2@tycho.nsa.gov>
 <CAFftDdrdT1+=HHUFhVpQb6hmHbZswa=XEe=jXJysx87ixcOrwA@mail.gmail.com>
 <CAFftDdpeO4C7nH6coQ-ZXrab+eCWjkVo8bv=SHQ-5mMe_o_Rdg@mail.gmail.com>
Date: Fri, 6 May 2016 12:16:21 -0700
Message-ID: <CAFftDdra7ygQKTszajTpevP3+3tnsm7OedHpdG6SPCeYkTufDg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Change which attributes CIL keeps in the binary
 policy
From: William Roberts <bill.c.roberts@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a114099364ca2c50532314ba4
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114099364ca2c50532314ba4
Content-Type: text/plain; charset=UTF-8

On May 6, 2016 11:58 AM, "James Carter" <jwcart2@tycho.nsa.gov> wrote:
>
> The removal of attributes that are only used in neverallow rules is
> hindering AOSP adoption of the CIL compiler. This is because AOSP
> extracts neverallow rules from its policy.conf for use in the Android
> compatibility test suite. These neverallow rules are applied against
> the binary policy being tested to check for a violation. Any neverallow
> rules with an attribute that has been removed cannot be checked.
>
> Now attributes are kept unless they are not used in any allow rule and
> they are auto-generated or named "cil_gen_require" or do not have any
> types associated with them.
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  libsepol/cil/src/cil_post.c  | 27 +++++++++++++++++++++++++++
>  libsepol/src/module_to_cil.c |  8 +++++---
>  2 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index a694b33..f8447c9 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -47,6 +47,9 @@
>  #include "cil_verify.h"
>  #include "cil_symtab.h"
>
> +#define GEN_REQUIRE_ATTR "cil_gen_require" /* Also in
libsepol/src/module_to_cil.c */
> +#define TYPEATTR_INFIX "_typeattr_"        /* Also in
libsepol/src/module_to_cil.c */
> +
>  static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out,
int max, struct cil_db *db);
>  static int __cil_expr_list_to_bitmap(struct cil_list *expr_list,
ebitmap_t *out, int max, struct cil_db *db);
>
> @@ -1186,6 +1189,27 @@ exit:
>         return SEPOL_ERR;
>  }
>
> +static int cil_typeattribute_used(struct cil_typeattribute *cil_attr)
> +{
> +       if (cil_attr->used) {
> +               return CIL_TRUE;
> +       }
> +
> +       if (strcmp(DATUM(cil_attr)->name, GEN_REQUIRE_ATTR) == 0) {
> +               return CIL_FALSE;

Just by reading this patch with 0 knowledge of cil, I would imagine this
would be CIL_TRUE on a match with GEN_REQUIRED_ATTR. Especially since
cardinality 0 below returns false.

> +       }
> +
> +       if (strstr(DATUM(cil_attr)->name,TYPEATTR_INFIX) != NULL) {
> +               return CIL_FALSE;
> +       }
> +
> +       if (ebitmap_cardinality(cil_attr->types) == 0) {
> +               return CIL_FALSE;
> +       }
> +
> +       return CIL_TRUE;
> +}
> +
>  static int __cil_post_db_attr_helper(struct cil_tree_node *node,
uint32_t *finished, void *extra_args)
>  {
>         int rc = SEPOL_ERR;
> @@ -1208,6 +1232,9 @@ static int __cil_post_db_attr_helper(struct
cil_tree_node *node, uint32_t *finis
>                 if (attr->types == NULL) {
>                         rc = __evaluate_type_expression(attr, db);
>                         if (rc != SEPOL_OK) goto exit;
> +                       if (cil_typeattribute_used(attr)) {
> +                               attr->used = CIL_TRUE;
> +                       }
>                 }
>                 break;
>         }
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index b9a4af7..bcbb4de 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -58,7 +58,9 @@ FILE *out_file;
>  #define STACK_SIZE 16
>  #define DEFAULT_LEVEL "systemlow"
>  #define DEFAULT_OBJECT "object_r"
> -#define GEN_REQUIRE_ATTR "cil_gen_require"
> +#define GEN_REQUIRE_ATTR "cil_gen_require" /* Also in
libsepol/cil/src/cil_post.c */
> +#define TYPEATTR_INFIX "_typeattr_"        /* Also in
libsepol/cil/src/cil_post.c */
> +#define ROLEATTR_INFIX "_roleattr_"
>
>  __attribute__ ((format(printf, 1, 2)))
>  static void log_err(const char *fmt, ...)
> @@ -626,9 +628,9 @@ static int set_to_cil_attr(struct policydb *pdb, int
is_type, char ***names, uin
>         num_attrs++;
>
>         if (is_type) {
> -               attr_infix = "_typeattr_";
> +               attr_infix = TYPEATTR_INFIX;
>         } else {
> -               attr_infix = "_roleattr_";
> +               attr_infix = ROLEATTR_INFIX;
>         }
>
>         len = strlen(pdb->name) + strlen(attr_infix) +
num_digits(num_attrs) + 1;
> --
> 2.5.5
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a114099364ca2c50532314ba4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On May 6, 2016 11:58 AM, &quot;James Carter&quot; &lt;<a href=3D"mailto:jwc=
art2@tycho.nsa.gov">jwcart2@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; The removal of attributes that are only used in neverallow rules is<br=
>
&gt; hindering AOSP adoption of the CIL compiler. This is because AOSP<br>
&gt; extracts neverallow rules from its policy.conf for use in the Android<=
br>
&gt; compatibility test suite. These neverallow rules are applied against<b=
r>
&gt; the binary policy being tested to check for a violation. Any neverallo=
w<br>
&gt; rules with an attribute that has been removed cannot be checked.<br>
&gt;<br>
&gt; Now attributes are kept unless they are not used in any allow rule and=
<br>
&gt; they are auto-generated or named &quot;cil_gen_require&quot; or do not=
 have any<br>
&gt; types associated with them.<br>
&gt;<br>
&gt; Signed-off-by: James Carter &lt;<a href=3D"mailto:jwcart2@tycho.nsa.go=
v">jwcart2@tycho.nsa.gov</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0libsepol/cil/src/cil_post.c=C2=A0 | 27 +++++++++++++++++++++++++=
++<br>
&gt; =C2=A0libsepol/src/module_to_cil.c |=C2=A0 8 +++++---<br>
&gt; =C2=A02 files changed, 32 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c=
<br>
&gt; index a694b33..f8447c9 100644<br>
&gt; --- a/libsepol/cil/src/cil_post.c<br>
&gt; +++ b/libsepol/cil/src/cil_post.c<br>
&gt; @@ -47,6 +47,9 @@<br>
&gt; =C2=A0#include &quot;cil_verify.h&quot;<br>
&gt; =C2=A0#include &quot;cil_symtab.h&quot;<br>
&gt;<br>
&gt; +#define GEN_REQUIRE_ATTR &quot;cil_gen_require&quot; /* Also in libse=
pol/src/module_to_cil.c */<br>
&gt; +#define TYPEATTR_INFIX &quot;_typeattr_&quot;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Also in libsepol/src/module_to_cil.c */<br>
&gt; +<br>
&gt; =C2=A0static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t=
 *out, int max, struct cil_db *db);<br>
&gt; =C2=A0static int __cil_expr_list_to_bitmap(struct cil_list *expr_list,=
 ebitmap_t *out, int max, struct cil_db *db);<br>
&gt;<br>
&gt; @@ -1186,6 +1189,27 @@ exit:<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 return SEPOL_ERR;<br>
&gt; =C2=A0}<br>
&gt;<br>
&gt; +static int cil_typeattribute_used(struct cil_typeattribute *cil_attr)=
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cil_attr-&gt;used) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_TRU=
E;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(DATUM(cil_attr)-&gt;name, GEN_R=
EQUIRE_ATTR) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_FAL=
SE;</p>
<p dir=3D"ltr">Just by reading this patch with 0 knowledge of cil, I would =
imagine this would be CIL_TRUE on a match with GEN_REQUIRED_ATTR. Especiall=
y since cardinality 0 below returns false.</p>
<p dir=3D"ltr">&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (strstr(DATUM(cil_attr)-&gt;name,TYPEAT=
TR_INFIX) !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_FAL=
SE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ebitmap_cardinality(cil_attr-&gt;types=
) =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_FAL=
SE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return CIL_TRUE;<br>
&gt; +}<br>
&gt; +<br>
&gt; =C2=A0static int __cil_post_db_attr_helper(struct cil_tree_node *node,=
 uint32_t *finished, void *extra_args)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rc =3D SEPOL_ERR;<br>
&gt; @@ -1208,6 +1232,9 @@ static int __cil_post_db_attr_helper(struct cil_=
tree_node *node, uint32_t *finis<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (attr-&gt;t=
ypes =3D=3D NULL) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 rc =3D __evaluate_type_expression(attr, db);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 if (rc !=3D SEPOL_OK) goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (cil_typeattribute_used(attr)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr-&gt;used =3D CIL_TRUE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil=
.c<br>
&gt; index b9a4af7..bcbb4de 100644<br>
&gt; --- a/libsepol/src/module_to_cil.c<br>
&gt; +++ b/libsepol/src/module_to_cil.c<br>
&gt; @@ -58,7 +58,9 @@ FILE *out_file;<br>
&gt; =C2=A0#define STACK_SIZE 16<br>
&gt; =C2=A0#define DEFAULT_LEVEL &quot;systemlow&quot;<br>
&gt; =C2=A0#define DEFAULT_OBJECT &quot;object_r&quot;<br>
&gt; -#define GEN_REQUIRE_ATTR &quot;cil_gen_require&quot;<br>
&gt; +#define GEN_REQUIRE_ATTR &quot;cil_gen_require&quot; /* Also in libse=
pol/cil/src/cil_post.c */<br>
&gt; +#define TYPEATTR_INFIX &quot;_typeattr_&quot;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Also in libsepol/cil/src/cil_post.c */<br>
&gt; +#define ROLEATTR_INFIX &quot;_roleattr_&quot;<br>
&gt;<br>
&gt; =C2=A0__attribute__ ((format(printf, 1, 2)))<br>
&gt; =C2=A0static void log_err(const char *fmt, ...)<br>
&gt; @@ -626,9 +628,9 @@ static int set_to_cil_attr(struct policydb *pdb, i=
nt is_type, char ***names, uin<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 num_attrs++;<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_type) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr_infix =3D=
 &quot;_typeattr_&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr_infix =3D=
 TYPEATTR_INFIX;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr_infix =3D=
 &quot;_roleattr_&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr_infix =3D=
 ROLEATTR_INFIX;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D strlen(pdb-&gt;name) + strlen(attr=
_infix) + num_digits(num_attrs) + 1;<br>
&gt; --<br>
&gt; 2.5.5<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</p>

--001a114099364ca2c50532314ba4--
