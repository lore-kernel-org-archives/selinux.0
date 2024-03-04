Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518BC78B53
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580012; cv=none; b=sVEHLsdK7ETPvXd1ApjvzzIlKFuSxsbUFFfvmX1DAnKRJUm8nq19TBR9JONNdskIbzWot17Rwsp3MBH88hEbfWgHdHVO/w2H8EXpdNgLiZ3DkRG26BENDwTyapwEQM3ocgKges42EMO+dTZ8tmx6xI0KiChtjDO7TTiFJ3TyUVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580012; c=relaxed/simple;
	bh=ygY0qgh/fqcGe6D/6ecWCJb+M4wCl4p/qoFIYCW/9KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyACfUv2cV+ctz2w7oS+z5RlaXtiwcLhKM2X3tAY2L5+cg9jB2iKYGP2AlBoEAWvmYgvlXf3MzLYS5EZI1v9OaEe1bUCj0d8/gbNVf06FRozSSF7Mje/aNqbjMiG32434EDd/fCFGvE0bIHIqwjt231vwx4bJVaa1EytwJ7fF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7rdvJfr; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7rdvJfr"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d698a8d93cso2598600241.3
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709580009; x=1710184809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXT+CcQNHxul2PKeUcN8ITV5r65hy2XO23hfFowqByI=;
        b=D7rdvJfrN7dS+fvvRM7KwkRGBNk5UJp8JpMTFoKvNSrA3v5euhiJYHsjbKv0YI00IK
         82J74pMYw6Cm6ipZlpm4CH7stC37aElK5LC4NTnLrtGa+1RQsd041ErAkVOkP0Wd1VSH
         zjLXF8l/gzmbcgWCRScFsLXjdaB5HRtPQeLluJKrYAhrPdmcarJvtkT80ci4+DVi1jhA
         oZr0lSIP/klO09YvV/PwzgZ0yAVdEn3WQ63v5yD9Csq+pbr8gj8HlgXWocYxvIXUqpWK
         KBfEFjW4gKkSzOfBNz3/EOYDBmJlOHNcJugV7WMBvyup8DTrUtl/nlBd98doXTBj0mZm
         0Cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709580009; x=1710184809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXT+CcQNHxul2PKeUcN8ITV5r65hy2XO23hfFowqByI=;
        b=CqVTkZ8wLczfPQGQtEwFMpXkZVBws4bmi5krrE7mApyDDcc4QXw5frLD8Ez3L65U1W
         b4ypSXv+C9/ZIeHUV6SKvOt9U/QRepzSNb98z+0cGrTbMjG3ZcFVjbfMl7bGPLbmYtTF
         41Ta9Iat00ep+aC+KWxGgDHEumaPQqbE/SQ3/Mz5SnpVo46fepWZ8Vu7CHXAqwmiyz9R
         5TatgLpjOnHD+Rjqc4/aUwR2bb+whxZdaQc7N1kjzvq0YSL9gotO6+F7u79k3VvxC0KQ
         uL+lulVw5I1LFp1PoskF4XX1Pt+7gmuW4f5/ZN3iuuN6jkb6A4lb1w87lWu6wZkQNogz
         cVRw==
X-Gm-Message-State: AOJu0Yz/FKbqQr521a1CXu3qbZn8QEJMVomk5/RsnTajuVNgpHli7Mpi
	230i3DTP3gPAaPd3fE4QCoL47dsKs1alaGWpWo65iMEH0mFHFc56LAy6zOVdIJInLZl9s7Fb4c3
	SHX2RuIUf1ryw7thqLxx5mVmNKUU=
X-Google-Smtp-Source: AGHT+IEFTc0oA33H5QJtg4oP/GJP61S8LzDJE6y+srHWUSLPZ6KEKsvHYi6B4jafL5JNwHEWfLCJhD8P3FNBiWNpZ6A=
X-Received: by 2002:a67:e314:0:b0:472:b056:1264 with SMTP id
 j20-20020a67e314000000b00472b0561264mr3891065vsf.30.1709580009103; Mon, 04
 Mar 2024 11:20:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-12-cgzones@googlemail.com> <CAP+JOzS4rop0rJOKpJEiMhWfh8OW-qxob6kzdsJaEJVNpfzOFg@mail.gmail.com>
In-Reply-To: <CAP+JOzS4rop0rJOKpJEiMhWfh8OW-qxob6kzdsJaEJVNpfzOFg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:19:58 -0500
Message-ID: <CAP+JOzTs_9biQjL46a2pPif6n4=qrxo1ASQsLgPV2UUQoTG5Vg@mail.gmail.com>
Subject: Re: [PATCH 12/15] checkpolicy: provide more descriptive error messages
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:37=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 8:55=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Provide more descriptive error messages by including the identifier
> > or other kind of value if available.
> >
> > Also drop duplicate newlines at the end of messages.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/module_compiler.c |   6 +-
> >  checkpolicy/policy_define.c   | 123 ++++++++++++++++++++--------------
> >  2 files changed, 76 insertions(+), 53 deletions(-)
> >
> > diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compile=
r.c
> > index 74a9f93c..119b7e36 100644
> > --- a/checkpolicy/module_compiler.c
> > +++ b/checkpolicy/module_compiler.c
> > @@ -75,7 +75,7 @@ static void print_error_msg(int ret, uint32_t symbol_=
type)
> >                 yyerror2("Could not declare %s here", flavor_str[symbol=
_type]);
> >                 break;
> >         default:
> > -               yyerror("Unknown error");
> > +               yyerror2("Unknown error %d", ret);
> >         }
> >  }
> >
> > @@ -86,7 +86,7 @@ int define_policy(int pass, int module_header_given)
> >         if (module_header_given) {
> >                 if (policydbp->policy_type !=3D POLICY_MOD) {
> >                         yyerror
> > -                           ("Module specification found while not buil=
ding a policy module.\n");
> > +                           ("Module specification found while not buil=
ding a policy module.");
> >                         return -1;
> >                 }
> >
> > @@ -111,7 +111,7 @@ int define_policy(int pass, int module_header_given=
)
> >         } else {
> >                 if (policydbp->policy_type =3D=3D POLICY_MOD) {
> >                         yyerror
> > -                           ("Building a policy module, but no module s=
pecification found.\n");
> > +                           ("Building a policy module, but no module s=
pecification found.");
> >                         return -1;
> >                 }
> >         }
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index 360cff68..cd49cae3 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -96,6 +96,17 @@ void yyerror2(const char *fmt, ...)
> >         va_end(ap);
> >  }
> >
> > +__attribute__ ((format(printf, 1, 2)))
> > +static void yywarn2(const char *fmt, ...)
> > +{
> > +       char warnmsg[256];
> > +       va_list ap;
> > +       va_start(ap, fmt);
> > +       vsnprintf(warnmsg, sizeof(warnmsg), fmt, ap);
> > +       yywarn(warnmsg);
> > +       va_end(ap);
> > +}
> > +
> >  int insert_separator(int push)
> >  {
> >         int error;
> > @@ -233,7 +244,7 @@ int define_permissive(void)
> >         }
> >
> >         if (t->flavor =3D=3D TYPE_ATTRIB) {
> > -               yyerror2("attributes may not be permissive: %s\n", type=
);
> > +               yyerror2("attributes may not be permissive: %s", type);
> >                 rc =3D -1;
> >                 goto out;
> >         }
> > @@ -520,7 +531,7 @@ int define_common_perms(void)
> >         }
> >         comdatum =3D hashtab_search(policydbp->p_commons.table, id);
> >         if (comdatum) {
> > -               yyerror2("duplicate declaration for common %s\n", id);
> > +               yyerror2("duplicate declaration for common %s", id);
> >                 free(id);
> >                 return -1;
> >         }
> > @@ -557,8 +568,8 @@ int define_common_perms(void)
> >                 perdatum->s.value =3D comdatum->permissions.nprim + 1;
> >
> >                 if (perdatum->s.value > (sizeof(sepol_access_vector_t) =
* 8)) {
> > -                       yyerror
> > -                           ("too many permissions to fit in an access =
vector");
> > +                       yyerror2
> > +                           ("too many permissions (%d) to fit in an ac=
cess vector", perdatum->s.value);
> >                         goto bad_perm;
> >                 }
> >                 ret =3D hashtab_insert(comdatum->permissions.table,
> > @@ -619,12 +630,15 @@ int define_av_perms(int inherits)
> >                 yyerror2("class %s is not defined", id);
> >                 goto bad;
> >         }
> > -       free(id);
> >
> >         if (cladatum->comdatum || cladatum->permissions.nprim) {
> > -               yyerror("duplicate access vector definition");
> > -               return -1;
> > +               yyerror2("duplicate access vector definition for class =
%s", id);
> > +               goto bad;
> >         }
> > +
> > +       free(id);
> > +       id =3D NULL;
> > +
> >         if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE)) {
> >                 yyerror("out of memory");
> >                 return -1;
> > @@ -664,8 +678,8 @@ int define_av_perms(int inherits)
> >                 perdatum->s.value =3D ++cladatum->permissions.nprim;
> >
> >                 if (perdatum->s.value > (sizeof(sepol_access_vector_t) =
* 8)) {
> > -                       yyerror
> > -                           ("too many permissions to fit in an access =
vector");
> > +                       yyerror2
> > +                           ("too many permissions (%d) to fit in an ac=
cess vector", perdatum->s.value);
> >                         goto bad;
> >                 }
> >                 if (inherits) {
> > @@ -737,7 +751,7 @@ int define_sens(void)
> >                 return -1;
> >         }
> >         if (id_has_dot(id)) {
> > -               yyerror("sensitivity identifiers may not contain period=
s");
> > +               yyerror2("sensitivity identifier %s may not contain per=
iods", id);
> >                 goto bad;
> >         }
> >         level =3D (mls_level_t *) malloc(sizeof(mls_level_t));
> > @@ -766,11 +780,11 @@ int define_sens(void)
> >                         goto bad;
> >                 }
> >         case -2:{
> > -                       yyerror("duplicate declaration of sensitivity l=
evel");
> > +                       yyerror2("duplicate declaration of sensitivity =
level %s", id);
> >                         goto bad;
> >                 }
> >         case -1:{
> > -                       yyerror("could not declare sensitivity level he=
re");
> > +                       yyerror2("could not declare sensitivity level %=
s here", id);
> >                         goto bad;
> >                 }
> >         case 0:
> > @@ -784,7 +798,7 @@ int define_sens(void)
> >
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (id_has_dot(id)) {
> > -                       yyerror("sensitivity aliases may not contain pe=
riods");
> > +                       yyerror2("sensitivity alias %s may not contain =
periods", id);
> >                         free(id);
> >                         return -1;
> >                 }
> > @@ -806,13 +820,13 @@ int define_sens(void)
> >                                 goto bad_alias;
> >                         }
> >                 case -2:{
> > -                               yyerror
> > -                                   ("duplicate declaration of sensitiv=
ity alias");
> > +                               yyerror2
> > +                                   ("duplicate declaration of sensitiv=
ity alias %s", id);
> >                                 goto bad_alias;
> >                         }
> >                 case -1:{
> > -                               yyerror
> > -                                   ("could not declare sensitivity ali=
as here");
> > +                               yyerror2
> > +                                   ("could not declare sensitivity ali=
as %s here", id);
> >                                 goto bad_alias;
> >                         }
> >                 case 0:
> > @@ -920,7 +934,7 @@ int define_category(void)
> >                 return -1;
> >         }
> >         if (id_has_dot(id)) {
> > -               yyerror("category identifiers may not contain periods")=
;
> > +               yyerror2("category identifier %s may not contain period=
s", id);
> >                 goto bad;
> >         }
> >         datum =3D (cat_datum_t *) malloc(sizeof(cat_datum_t));
> > @@ -938,11 +952,11 @@ int define_category(void)
> >                         goto bad;
> >                 }
> >         case -2:{
> > -                       yyerror("duplicate declaration of category");
> > +                       yyerror2("duplicate declaration of category %s"=
, id);
> >                         goto bad;
> >                 }
> >         case -1:{
> > -                       yyerror("could not declare category here");
> > +                       yyerror2("could not declare category %s here", =
id);
> >                         goto bad;
> >                 }
> >         case 0:
> > @@ -957,7 +971,7 @@ int define_category(void)
> >
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (id_has_dot(id)) {
> > -                       yyerror("category aliases may not contain perio=
ds");
> > +                       yyerror2("category alias %s may not contain per=
iods", id);
> >                         free(id);
> >                         return -1;
> >                 }
> > @@ -980,13 +994,13 @@ int define_category(void)
> >                                 goto bad_alias;
> >                         }
> >                 case -2:{
> > -                               yyerror
> > -                                   ("duplicate declaration of category=
 aliases");
> > +                               yyerror2
> > +                                   ("duplicate declaration of category=
 alias %s", id);
> >                                 goto bad_alias;
> >                         }
> >                 case -1:{
> > -                               yyerror
> > -                                   ("could not declare category aliase=
s here");
> > +                               yyerror2
> > +                                   ("could not declare category alias =
%s here", id);
> >                                 goto bad_alias;
> >                         }
> >                 case 0:
> > @@ -1114,7 +1128,7 @@ int define_level(void)
> >                         range_end =3D cdatum->s.value - 1;
> >
> >                         if (range_end < range_start) {
> > -                               yyerror2("category range is invalid");
> > +                               yyerror2("category range %d-%d is inval=
id", range_start, range_end);
> >                                 free(id);
> >                                 return -1;
> >                         }
> > @@ -1170,6 +1184,7 @@ int expand_attrib(void)
> >         ebitmap_t attrs;
> >         type_datum_t *attr;
> >         ebitmap_node_t *node;
> > +       const char *name;
> >         uint32_t i;
> >         int rc =3D -1;
> >         int flags =3D 0;
> > @@ -1222,13 +1237,13 @@ int expand_attrib(void)
> >         }
> >
> >         ebitmap_for_each_positive_bit(&attrs, node, i) {
> > -               attr =3D hashtab_search(policydbp->p_types.table,
> > -                               policydbp->sym_val_to_name[SYM_TYPES][i=
]);
> > +               name =3D policydbp->sym_val_to_name[SYM_TYPES][i];
> > +               attr =3D hashtab_search(policydbp->p_types.table, name)=
;
> >                 attr->flags |=3D flags;
> >                 if ((attr->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE) &&
> >                                 (attr->flags & TYPE_FLAGS_EXPAND_ATTR_F=
ALSE)) {
> > -                       yywarn("Expandattribute option was set to both =
true and false. "
> > -                               "Resolving to false.");
> > +                       yywarn2("Expandattribute option of attribute %s=
 was set to both true and false; "
> > +                               "Resolving to false.", name);
> >                         attr->flags &=3D ~TYPE_FLAGS_EXPAND_ATTR_TRUE;
> >                 }
> >         }
> > @@ -1247,9 +1262,9 @@ static int add_aliases_to_type(type_datum_t * typ=
e)
> >         int ret;
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (id_has_dot(id)) {
> > +                       yyerror2
> > +                           ("type alias identifier %s may not contain =
periods", id);
> >                         free(id);
> > -                       yyerror
> > -                           ("type alias identifiers may not contain pe=
riods");
> >                         return -1;
> >                 }
> >                 aliasdatum =3D (type_datum_t *) malloc(sizeof(type_datu=
m_t));
> > @@ -1274,7 +1289,7 @@ static int add_aliases_to_type(type_datum_t * typ=
e)
> >                                 goto cleanup;
> >                         }
> >                 case -1:{
> > -                               yyerror("could not declare alias here")=
;
> > +                               yyerror2("could not declare alias %s he=
re", id);
> >                                 goto cleanup;
> >                         }
> >                 case 0:         break;
> > @@ -1790,8 +1805,8 @@ int define_bool_tunable(int is_tunable)
> >                 return -1;
> >         }
> >         if (id_has_dot(id)) {
> > +               yyerror2("boolean identifier %s may not contain periods=
", id);
> >                 free(id);
> > -               yyerror("boolean identifiers may not contain periods");
> >                 return -1;
> >         }
> >         datum =3D (cond_bool_datum_t *) malloc(sizeof(cond_bool_datum_t=
));
> > @@ -1814,7 +1829,7 @@ int define_bool_tunable(int is_tunable)
> >                         goto cleanup;
> >                 }
> >         case -1:{
> > -                       yyerror("could not declare boolean here");
> > +                       yyerror2("could not declare boolean %s here", i=
d);
> >                         goto cleanup;
> >                 }
> >         case 0:
> > @@ -1957,7 +1972,8 @@ static int avrule_read_ioctls(struct av_ioctl_ran=
ge_list **rangehead)
> >                         id =3D queue_remove(id_queue);
> >                         r->range.high =3D (uint16_t) strtoul(id,NULL,0)=
;
> >                         if (r->range.high < r->range.low) {
> > -                               yyerror("Ioctl ranges must be in ascend=
ing order.");
> > +                               yyerror2("Ioctl range %d-%d must be in =
ascending order.",
> > +                                        r->range.low, r->range.high);
> >                                 return -1;
> >                         }
> >                         free(id);
> > @@ -2532,7 +2548,7 @@ int define_te_avtab_extended_perms(int which)
> >         if (strcmp(id,"ioctl") =3D=3D 0) {
> >                 rc =3D define_te_avtab_ioctl(avrule_template);
> >         } else {
> > -               yyerror("only ioctl extended permissions are supported"=
);
> > +               yyerror2("only ioctl extended permissions are supported=
, found %s", id);
> >                 rc =3D -1;
> >         }
> >
> > @@ -3189,7 +3205,7 @@ int define_role_allow(void)
> >  avrule_t *define_cond_filename_trans(void)
> >  {
> >         yyerror("type transitions with a filename not allowed inside "
> > -               "conditionals\n");
> > +               "conditionals");
> >         return COND_ERR;
> >  }
> >
> > @@ -3861,7 +3877,7 @@ int define_conditional(cond_expr_t * expr, avrule=
_t * t, avrule_t * f)
> >                 f =3D 0;
> >                 expr =3D define_cond_expr(COND_NOT, expr, 0);
> >                 if (!expr) {
> > -                       yyerror("unable to invert");
> > +                       yyerror("unable to invert conditional expressio=
n");
> >                         return -1;
> >                 }
> >         }
> > @@ -4126,7 +4142,7 @@ static int parse_categories(char *id, level_datum=
_t * levdatum, ebitmap_t * cats
> >                 range_end =3D cdatum->s.value - 1;
> >
> >                 if (range_end < range_start) {
> > -                       yyerror2("category range is invalid");
> > +                       yyerror2("category range %d-%d is invalid", ran=
ge_start, range_end);
> >                         return -1;
> >                 }
> >         } else {
> > @@ -5102,7 +5118,7 @@ int define_ibendport_context(unsigned int port)
> >         }
> >
> >         if (port > 0xff || port =3D=3D 0) {
> > -               yyerror("Invalid ibendport port number, should be 0 < p=
ort < 256");
> > +               yyerror2("Invalid ibendport port number %d, should be 0=
 < port < 256", port);
> >                 return -1;
> >         }
> >
> > @@ -5121,7 +5137,7 @@ int define_ibendport_context(unsigned int port)
> >         }
> >
> >         if (strlen(newc->u.ibendport.dev_name) > IB_DEVICE_NAME_MAX - 1=
) {
> > -               yyerror("infiniband device name exceeds max length of 6=
3.");
> > +               yyerror2("infiniband device name %s exceeds max length =
of 63.", newc->u.ibendport.dev_name);
> >                 rc =3D -1;
> >                 goto out;
> >         }
> > @@ -5248,13 +5264,14 @@ int define_ipv4_node_context(void)
> >         }
> >
> >         rc =3D inet_pton(AF_INET, id, &addr);
> > -       free(id);
> >         if (rc < 1) {
> > -               yyerror("failed to parse ipv4 address");
> > +               yyerror2("failed to parse ipv4 address %s", id);
> > +               free(id);
> >                 if (rc =3D=3D 0)
> >                         rc =3D -1;
> >                 goto out;
> >         }
> > +       free(id);
> >
> >         id =3D queue_remove(id_queue);
> >         if (!id) {
> > @@ -5264,14 +5281,16 @@ int define_ipv4_node_context(void)
> >         }
> >
> >         rc =3D inet_pton(AF_INET, id, &mask);
> > -       free(id);
> >         if (rc < 1) {
> > -               yyerror("failed to parse ipv4 mask");
> > +               yyerror2("failed to parse ipv4 mask %s", id);
> > +               free(id);
> >                 if (rc =3D=3D 0)
> >                         rc =3D -1;
> >                 goto out;
> >         }
> >
> > +       free(id);
> > +
> >         if (mask.s_addr !=3D 0 && ((~mask.s_addr + 1) & ~mask.s_addr) !=
=3D 0) {
> >                 yywarn("ipv4 mask is not contiguous");
> >         }
> > @@ -5376,14 +5395,16 @@ int define_ipv6_node_context(void)
> >         }
> >
> >         rc =3D inet_pton(AF_INET6, id, &addr);
> > -       free(id);
> >         if (rc < 1) {
> > -               yyerror("failed to parse ipv6 address");
> > +               yyerror2("failed to parse ipv6 address %s", id);
> > +               free(id);
> >                 if (rc =3D=3D 0)
> >                         rc =3D -1;
> >                 goto out;
> >         }
> >
> > +       free(id);
> > +
> >         id =3D queue_remove(id_queue);
> >         if (!id) {
> >                 yyerror("failed to read ipv6 address");
> > @@ -5392,14 +5413,16 @@ int define_ipv6_node_context(void)
> >         }
> >
> >         rc =3D inet_pton(AF_INET6, id, &mask);
> > -       free(id);
> >         if (rc < 1) {
> > -               yyerror("failed to parse ipv6 mask");
> > +               yyerror2("failed to parse ipv6 mask %s", id);
> > +               free(id);
> >                 if (rc =3D=3D 0)
> >                         rc =3D -1;
> >                 goto out;
> >         }
> >
> > +       free(id);
> > +
> >         if (!ipv6_is_mask_contiguous(&mask)) {
> >                 yywarn("ipv6 mask is not contiguous");
> >         }
> > --
> > 2.43.0
> >
> >
