Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2QJXBDI025452
 for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2018 15:33:11 -0400
Received: by mail-qk0-f194.google.com with SMTP id o184so21379866qkd.13
 for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2018 12:32:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180316175509.76068-1-trong@android.com>
 <ea35a26d-ff96-3959-6950-fd6d47ecc4ac@tycho.nsa.gov>
In-Reply-To: <ea35a26d-ff96-3959-6950-fd6d47ecc4ac@tycho.nsa.gov>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Mon, 26 Mar 2018 19:32:17 +0000
Message-ID: <CABXk95CyD4EyZS6-4LSH0kFaC=sc4_awPtcJ1oeqt1cCs-BkhA@mail.gmail.com>
To: jwcart2 <jwcart2@tycho.nsa.gov>
Cc: Tri Vo <trong@android.com>, selinux@tycho.nsa.gov, dcashman@google.com,
 sspatil@google.com, bill.c.roberts@gmail.com
Content-Type: multipart/alternative; boundary="94eb2c048faca102ce056855d55e"
Subject: Re:  [PATCH v3] Resolve conflicts in expandattribute.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c048faca102ce056855d55e
Content-Type: text/plain; charset="UTF-8"

Merged.

On Mon, Mar 19, 2018 at 11:55 AM jwcart2 <jwcart2@tycho.nsa.gov> wrote:

> On 03/16/2018 01:55 PM, Tri Vo wrote:
> > This commit resolves conflicts in values of expandattribute statements
> > in policy language and expandtypeattribute in CIL.
> >
> > For example, these statements resolve to false in policy language:
> >   expandattribute hal_audio true;
> >   expandattribute hal_audio false;
> >
> > Similarly, in CIL these also resolve to false.
> >   (expandtypeattribute (hal_audio) true)
> >   (expandtypeattribute (hal_audio) false)
> >
> > Motivation
> > When Android combines multiple .cil files from system.img and vendor.img
> > it's possible to have conflicting expandattribute statements.
> >
> > This change deals with this scenario by resolving the value of the
> > corresponding expandtypeattribute to false. The rationale behind this
> > override is that true is used for reduce run-time lookups, while
> > false is used for tests which must pass.
> >
> > Signed-off-by: Tri Vo <trong@android.com>
>
> Acked-by: James Carter <jwcart2@tycho.nsa.gov>
>
> > ---
> >   checkpolicy/policy_define.c        | 10 ++++++----
> >   libsepol/cil/src/cil_resolve_ast.c | 21 ++++++---------------
> >   2 files changed, 12 insertions(+), 19 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 2c5db55d..40cc62b0 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -1182,10 +1182,6 @@ int expand_attrib(void)
> >                       goto exit;
> >               }
> >
> > -             if (attr->flags & TYPE_FLAGS_EXPAND_ATTR) {
> > -                     yyerror2("%s already has the expandattribute
> option specified", id);
> > -                     goto exit;
> > -             }
> >               if (ebitmap_set_bit(&attrs, attr->s.value - 1, TRUE)) {
> >                       yyerror("Out of memory!");
> >                       goto exit;
> > @@ -1213,6 +1209,12 @@ int expand_attrib(void)
> >               attr = hashtab_search(policydbp->p_types.table,
> >                               policydbp->sym_val_to_name[SYM_TYPES][i]);
> >               attr->flags |= flags;
> > +             if ((attr->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE) &&
> > +                             (attr->flags &
> TYPE_FLAGS_EXPAND_ATTR_FALSE)) {
> > +                     yywarn("Expandattribute option was set to both
> true and false. "
> > +                             "Resolving to false.");
> > +                     attr->flags &= ~TYPE_FLAGS_EXPAND_ATTR_TRUE;
> > +             }
> >       }
> >
> >       rc = 0;
> > diff --git a/libsepol/cil/src/cil_resolve_ast.c
> b/libsepol/cil/src/cil_resolve_ast.c
> > index d1a5ed87..02259241 100644
> > --- a/libsepol/cil/src/cil_resolve_ast.c
> > +++ b/libsepol/cil/src/cil_resolve_ast.c
> > @@ -269,9 +269,8 @@ exit:
> >       return rc;
> >   }
> >
> > -int cil_type_used(struct cil_symtab_datum *datum, int used)
> > +void cil_type_used(struct cil_symtab_datum *datum, int used)
> >   {
> > -     int rc = SEPOL_ERR;
> >       struct cil_typeattribute *attr = NULL;
> >
> >       if (FLAVOR(datum) == CIL_TYPEATTRIBUTE) {
> > @@ -279,16 +278,12 @@ int cil_type_used(struct cil_symtab_datum *datum,
> int used)
> >               attr->used |= used;
> >               if ((attr->used & CIL_ATTR_EXPAND_TRUE) &&
> >                               (attr->used & CIL_ATTR_EXPAND_FALSE)) {
> > -                     cil_log(CIL_ERR, "Conflicting use of
> expandtypeattribute. "
> > -                                     "Expandtypeattribute may be set to
> true or false "
> > -                                     "but not both. \n");
> > -                     goto exit;
> > +                     cil_log(CIL_WARN, "Conflicting use of
> expandtypeattribute. "
> > +                                     "Expandtypeattribute was set to
> both true or false for %s. "
> > +                                     "Resolving to false. \n", attr->
> datum.name);
> > +                     attr->used &= ~CIL_ATTR_EXPAND_TRUE;
> >               }
> >       }
> > -
> > -     return SEPOL_OK;
> > -exit:
> > -     return rc;
> >   }
> >
> >   int cil_resolve_permissionx(struct cil_tree_node *current, struct
> cil_permissionx *permx, void *extra_args)
> > @@ -488,11 +483,7 @@ int cil_resolve_expandtypeattribute(struct
> cil_tree_node *current, void *extra_a
> >                       goto exit;
> >               }
> >               used = expandattr->expand ? CIL_ATTR_EXPAND_TRUE :
> CIL_ATTR_EXPAND_FALSE;
> > -             rc = cil_type_used(attr_datum, used);
> > -             if (rc != SEPOL_OK) {
> > -                     goto exit;
> > -             }
> > -
> > +             cil_type_used(attr_datum, used);
> >               cil_list_append(expandattr->attr_datums, CIL_TYPE,
> attr_datum);
> >       }
> >
> >
>
>
> --
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
>

--94eb2c048faca102ce056855d55e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Merged.</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r">On Mon, Mar 19, 2018 at 11:55 AM jwcart2 &lt;<a href=3D"mailto:jwcart2@t=
ycho.nsa.gov">jwcart2@tycho.nsa.gov</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">On 03/16/2018 01:55 PM, Tri Vo wrote:<br>
&gt; This commit resolves conflicts in values of expandattribute statements=
<br>
&gt; in policy language and expandtypeattribute in CIL.<br>
&gt;<br>
&gt; For example, these statements resolve to false in policy language:<br>
&gt;=C2=A0 =C2=A0expandattribute hal_audio true;<br>
&gt;=C2=A0 =C2=A0expandattribute hal_audio false;<br>
&gt;<br>
&gt; Similarly, in CIL these also resolve to false.<br>
&gt;=C2=A0 =C2=A0(expandtypeattribute (hal_audio) true)<br>
&gt;=C2=A0 =C2=A0(expandtypeattribute (hal_audio) false)<br>
&gt;<br>
&gt; Motivation<br>
&gt; When Android combines multiple .cil files from system.img and vendor.i=
mg<br>
&gt; it&#39;s possible to have conflicting expandattribute statements.<br>
&gt;<br>
&gt; This change deals with this scenario by resolving the value of the<br>
&gt; corresponding expandtypeattribute to false. The rationale behind this<=
br>
&gt; override is that true is used for reduce run-time lookups, while<br>
&gt; false is used for tests which must pass.<br>
&gt;<br>
&gt; Signed-off-by: Tri Vo &lt;<a href=3D"mailto:trong@android.com" target=
=3D"_blank">trong@android.com</a>&gt;<br>
<br>
Acked-by: James Carter &lt;<a href=3D"mailto:jwcart2@tycho.nsa.gov" target=
=3D"_blank">jwcart2@tycho.nsa.gov</a>&gt;<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0checkpolicy/policy_define.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1=
0 ++++++----<br>
&gt;=C2=A0 =C2=A0libsepol/cil/src/cil_resolve_ast.c | 21 ++++++------------=
---<br>
&gt;=C2=A0 =C2=A02 files changed, 12 insertions(+), 19 deletions(-)<br>
&gt;<br>
&gt; diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c=
<br>
&gt; index 2c5db55d..40cc62b0 100644<br>
&gt; --- a/checkpolicy/policy_define.c<br>
&gt; +++ b/checkpolicy/policy_define.c<br>
&gt; @@ -1182,10 +1182,6 @@ int expand_attrib(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto exit;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (attr-&gt;flags &a=
mp; TYPE_FLAGS_EXPAND_ATTR) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0yyerror2(&quot;%s already has the expandattribute option specified&q=
uot;, id);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ebitmap_set_=
bit(&amp;attrs, attr-&gt;s.value - 1, TRUE)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0yyerror(&quot;Out of memory!&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto exit;<br>
&gt; @@ -1213,6 +1209,12 @@ int expand_attrib(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr =3D hashtab=
_search(policydbp-&gt;p_types.table,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0policydbp-&gt;sym_val_to_name[SYM_=
TYPES][i]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr-&gt;flags |=
=3D flags;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((attr-&gt;flags &=
amp; TYPE_FLAGS_EXPAND_ATTR_TRUE) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(attr-&gt;flags &amp; TYPE_FLAGS_EXPAND_=
ATTR_FALSE)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0yywarn(&quot;Expandattribute option was set to both true and false. =
&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Resolving to false.&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0attr-&gt;flags &amp;=3D ~TYPE_FLAGS_EXPAND_ATTR_TRUE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D 0;<br>
&gt; diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil=
_resolve_ast.c<br>
&gt; index d1a5ed87..02259241 100644<br>
&gt; --- a/libsepol/cil/src/cil_resolve_ast.c<br>
&gt; +++ b/libsepol/cil/src/cil_resolve_ast.c<br>
&gt; @@ -269,9 +269,8 @@ exit:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;<br>
&gt; -int cil_type_used(struct cil_symtab_datum *datum, int used)<br>
&gt; +void cil_type_used(struct cil_symtab_datum *datum, int used)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int rc =3D SEPOL_ERR;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cil_typeattribute *attr =3D NULL;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (FLAVOR(datum) =3D=3D CIL_TYPEATTRIBUTE) =
{<br>
&gt; @@ -279,16 +278,12 @@ int cil_type_used(struct cil_symtab_datum *datum=
, int used)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0attr-&gt;used |=
=3D used;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((attr-&gt;us=
ed &amp; CIL_ATTR_EXPAND_TRUE) &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(attr-&gt;used &amp; CIL_ATTR_EXPA=
ND_FALSE)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cil_log(CIL_ERR, &quot;Conflicting use of expandtypeattribute. &quot=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Expand=
typeattribute may be set to true or false &quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;but no=
t both. \n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0cil_log(CIL_WARN, &quot;Conflicting use of expandtypeattribute. &quo=
t;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Expand=
typeattribute was set to both true or false for %s. &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Resolv=
ing to false. \n&quot;, attr-&gt;<a href=3D"http://datum.name" rel=3D"noref=
errer" target=3D"_blank">datum.name</a>);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0attr-&gt;used &amp;=3D ~CIL_ATTR_EXPAND_TRUE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return SEPOL_OK;<br>
&gt; -exit:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0return rc;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0int cil_resolve_permissionx(struct cil_tree_node *current,=
 struct cil_permissionx *permx, void *extra_args)<br>
&gt; @@ -488,11 +483,7 @@ int cil_resolve_expandtypeattribute(struct cil_tr=
ee_node *current, void *extra_a<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto exit;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0used =3D expanda=
ttr-&gt;expand ? CIL_ATTR_EXPAND_TRUE : CIL_ATTR_EXPAND_FALSE;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D cil_type_used(=
attr_datum, used);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc !=3D SEPOL_OK)=
 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto exit;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_type_used(attr_da=
tum, used);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cil_list_append(=
expandattr-&gt;attr_datums, CIL_TYPE, attr_datum);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;<br>
<br>
<br>
--<br>
James Carter &lt;<a href=3D"mailto:jwcart2@tycho.nsa.gov" target=3D"_blank"=
>jwcart2@tycho.nsa.gov</a>&gt;<br>
National Security Agency<br>
</blockquote></div>

--94eb2c048faca102ce056855d55e--
