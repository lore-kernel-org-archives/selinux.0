Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680F60B8E
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856679; cv=none; b=Vnz0e7jVgw/FTEX9hS5S3THSj4lvtk33gI9KIKg8kgQsaKG5NKIVESTBUoOglQNV1PVpx+5GBRIBaKn2Ml1VgRGlgyreJh7vwZzy2QGHNKSbSL/Do+MQ0OwFf1DAgVGdHvYVYNApMKidGrnLvIMDUcURfpuSgVvvb3iFi+yBtqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856679; c=relaxed/simple;
	bh=nDLgDgIxZEVHcfw/pdQWyjhE+ifMxVGK/ud790qRd6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdujIwZyhqgTaszl+jaITuZWNir8liOtoHugrrO9tblWoM5RrPqup2C7gTj3DkHmY9gqmhB79dGv20Yu7DzcgABV7ZI1grlrKhlaUtuJhBSTn2LFL2ZQbtpsSY0zvc+Kr6SiZl72pcRK55uYalrpVrVuGzZZ5TUbNFhAtAz7h48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRMbdxxZ; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRMbdxxZ"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so638796241.1
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 12:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707856676; x=1708461476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tF86rzwYm2qjn3zHxoszVoYQOUDQtyAtXMK0RBF0Xpc=;
        b=iRMbdxxZd/JpRE+QaCVO4jBmKxG8BDtqORwd5CVMcaMY2gsgQk3g0G5O9dLiAvQ/CB
         lJRehiFxpy/+Za/ZNEZb2SKYQL3od/12RyFJettLHvldu54E6Tdih9bzs4JVCTTNvE06
         kdAOAgR1/XXL/L8Jk61ghsABRN1bH1kVecOs8pzS0AlNg7ib0jeqq5NHg/rnXnxvYJ84
         45qSmxita7dYM9skE3365CL2mofzaEgFsGQ7nRfy+sFTM9K4ilMg7gMxTgemoisM3nK4
         3tYfBFXQN5jwoOQo851wlGnuA0zK0C47ADmXWzvR2huSWRk12x96b6M47G97UuAp1GXv
         ajFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707856676; x=1708461476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tF86rzwYm2qjn3zHxoszVoYQOUDQtyAtXMK0RBF0Xpc=;
        b=KQ3GhkUe0ime9pTFUA+d1EGIEbzRvUY661hDXbPz+zittqdz/ynygE3K3TL6nBmzfa
         pKqlraiJZEhKkaPt64ufrVKWgWKhU0AkdywR+u0iaZ8N8gy55Jt0M/jyH2y/xAbjD8bf
         5Rmky8ri4hqbptHHNRX4BEso28F5mO1DJxC0J/J864d5ynfZJmxnl6VRaPovw1uVLUH0
         piz7CeE5KUlVHgYgTgtuwezcnjporF1yw64f3CkA9Vnj4PR9wT/Se7pNiXBKCOCzcK7c
         RH8znzWCSyQwWtbN2rXK3uxysO+j+nhRSiHw9+hZxJXaWCYab9cRQEywTii1+BOPSng2
         eL5Q==
X-Gm-Message-State: AOJu0YzJM5AZYnTPYpCpN0n22gJwyEjkyvLRDJ0DiQgNGEOQfe4GVgNn
	MAscw/mKLQ3LYOjFCwsgoF0qLWSnsDs1tPmi7FPmJNL33FF/Oig3uawak/F3OFP3LlKaI5aEnbN
	utX/028JgtT0SkijZGxGPEwu//y6Pwj62nH4=
X-Google-Smtp-Source: AGHT+IH9F1UGmpa0Gj6+EV4xGYUM5f5Z1pKvCMHtUJJ6l6PKMhoscSeCVd+hHgvdE3fs1e92CfQATrW28pOpBn85/Cw=
X-Received: by 2002:a05:6102:942:b0:46d:6beb:38a with SMTP id
 a2-20020a056102094200b0046d6beb038amr871310vsi.1.1707856676603; Tue, 13 Feb
 2024 12:37:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com> <20240122135507.63506-12-cgzones@googlemail.com>
In-Reply-To: <20240122135507.63506-12-cgzones@googlemail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 13 Feb 2024 15:37:45 -0500
Message-ID: <CAP+JOzS4rop0rJOKpJEiMhWfh8OW-qxob6kzdsJaEJVNpfzOFg@mail.gmail.com>
Subject: Re: [PATCH 12/15] checkpolicy: provide more descriptive error messages
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 8:55=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Provide more descriptive error messages by including the identifier
> or other kind of value if available.
>
> Also drop duplicate newlines at the end of messages.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/module_compiler.c |   6 +-
>  checkpolicy/policy_define.c   | 123 ++++++++++++++++++++--------------
>  2 files changed, 76 insertions(+), 53 deletions(-)
>
> diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.=
c
> index 74a9f93c..119b7e36 100644
> --- a/checkpolicy/module_compiler.c
> +++ b/checkpolicy/module_compiler.c
> @@ -75,7 +75,7 @@ static void print_error_msg(int ret, uint32_t symbol_ty=
pe)
>                 yyerror2("Could not declare %s here", flavor_str[symbol_t=
ype]);
>                 break;
>         default:
> -               yyerror("Unknown error");
> +               yyerror2("Unknown error %d", ret);
>         }
>  }
>
> @@ -86,7 +86,7 @@ int define_policy(int pass, int module_header_given)
>         if (module_header_given) {
>                 if (policydbp->policy_type !=3D POLICY_MOD) {
>                         yyerror
> -                           ("Module specification found while not buildi=
ng a policy module.\n");
> +                           ("Module specification found while not buildi=
ng a policy module.");
>                         return -1;
>                 }
>
> @@ -111,7 +111,7 @@ int define_policy(int pass, int module_header_given)
>         } else {
>                 if (policydbp->policy_type =3D=3D POLICY_MOD) {
>                         yyerror
> -                           ("Building a policy module, but no module spe=
cification found.\n");
> +                           ("Building a policy module, but no module spe=
cification found.");
>                         return -1;
>                 }
>         }
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 360cff68..cd49cae3 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -96,6 +96,17 @@ void yyerror2(const char *fmt, ...)
>         va_end(ap);
>  }
>
> +__attribute__ ((format(printf, 1, 2)))
> +static void yywarn2(const char *fmt, ...)
> +{
> +       char warnmsg[256];
> +       va_list ap;
> +       va_start(ap, fmt);
> +       vsnprintf(warnmsg, sizeof(warnmsg), fmt, ap);
> +       yywarn(warnmsg);
> +       va_end(ap);
> +}
> +
>  int insert_separator(int push)
>  {
>         int error;
> @@ -233,7 +244,7 @@ int define_permissive(void)
>         }
>
>         if (t->flavor =3D=3D TYPE_ATTRIB) {
> -               yyerror2("attributes may not be permissive: %s\n", type);
> +               yyerror2("attributes may not be permissive: %s", type);
>                 rc =3D -1;
>                 goto out;
>         }
> @@ -520,7 +531,7 @@ int define_common_perms(void)
>         }
>         comdatum =3D hashtab_search(policydbp->p_commons.table, id);
>         if (comdatum) {
> -               yyerror2("duplicate declaration for common %s\n", id);
> +               yyerror2("duplicate declaration for common %s", id);
>                 free(id);
>                 return -1;
>         }
> @@ -557,8 +568,8 @@ int define_common_perms(void)
>                 perdatum->s.value =3D comdatum->permissions.nprim + 1;
>
>                 if (perdatum->s.value > (sizeof(sepol_access_vector_t) * =
8)) {
> -                       yyerror
> -                           ("too many permissions to fit in an access ve=
ctor");
> +                       yyerror2
> +                           ("too many permissions (%d) to fit in an acce=
ss vector", perdatum->s.value);
>                         goto bad_perm;
>                 }
>                 ret =3D hashtab_insert(comdatum->permissions.table,
> @@ -619,12 +630,15 @@ int define_av_perms(int inherits)
>                 yyerror2("class %s is not defined", id);
>                 goto bad;
>         }
> -       free(id);
>
>         if (cladatum->comdatum || cladatum->permissions.nprim) {
> -               yyerror("duplicate access vector definition");
> -               return -1;
> +               yyerror2("duplicate access vector definition for class %s=
", id);
> +               goto bad;
>         }
> +
> +       free(id);
> +       id =3D NULL;
> +
>         if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE)) {
>                 yyerror("out of memory");
>                 return -1;
> @@ -664,8 +678,8 @@ int define_av_perms(int inherits)
>                 perdatum->s.value =3D ++cladatum->permissions.nprim;
>
>                 if (perdatum->s.value > (sizeof(sepol_access_vector_t) * =
8)) {
> -                       yyerror
> -                           ("too many permissions to fit in an access ve=
ctor");
> +                       yyerror2
> +                           ("too many permissions (%d) to fit in an acce=
ss vector", perdatum->s.value);
>                         goto bad;
>                 }
>                 if (inherits) {
> @@ -737,7 +751,7 @@ int define_sens(void)
>                 return -1;
>         }
>         if (id_has_dot(id)) {
> -               yyerror("sensitivity identifiers may not contain periods"=
);
> +               yyerror2("sensitivity identifier %s may not contain perio=
ds", id);
>                 goto bad;
>         }
>         level =3D (mls_level_t *) malloc(sizeof(mls_level_t));
> @@ -766,11 +780,11 @@ int define_sens(void)
>                         goto bad;
>                 }
>         case -2:{
> -                       yyerror("duplicate declaration of sensitivity lev=
el");
> +                       yyerror2("duplicate declaration of sensitivity le=
vel %s", id);
>                         goto bad;
>                 }
>         case -1:{
> -                       yyerror("could not declare sensitivity level here=
");
> +                       yyerror2("could not declare sensitivity level %s =
here", id);
>                         goto bad;
>                 }
>         case 0:
> @@ -784,7 +798,7 @@ int define_sens(void)
>
>         while ((id =3D queue_remove(id_queue))) {
>                 if (id_has_dot(id)) {
> -                       yyerror("sensitivity aliases may not contain peri=
ods");
> +                       yyerror2("sensitivity alias %s may not contain pe=
riods", id);
>                         free(id);
>                         return -1;
>                 }
> @@ -806,13 +820,13 @@ int define_sens(void)
>                                 goto bad_alias;
>                         }
>                 case -2:{
> -                               yyerror
> -                                   ("duplicate declaration of sensitivit=
y alias");
> +                               yyerror2
> +                                   ("duplicate declaration of sensitivit=
y alias %s", id);
>                                 goto bad_alias;
>                         }
>                 case -1:{
> -                               yyerror
> -                                   ("could not declare sensitivity alias=
 here");
> +                               yyerror2
> +                                   ("could not declare sensitivity alias=
 %s here", id);
>                                 goto bad_alias;
>                         }
>                 case 0:
> @@ -920,7 +934,7 @@ int define_category(void)
>                 return -1;
>         }
>         if (id_has_dot(id)) {
> -               yyerror("category identifiers may not contain periods");
> +               yyerror2("category identifier %s may not contain periods"=
, id);
>                 goto bad;
>         }
>         datum =3D (cat_datum_t *) malloc(sizeof(cat_datum_t));
> @@ -938,11 +952,11 @@ int define_category(void)
>                         goto bad;
>                 }
>         case -2:{
> -                       yyerror("duplicate declaration of category");
> +                       yyerror2("duplicate declaration of category %s", =
id);
>                         goto bad;
>                 }
>         case -1:{
> -                       yyerror("could not declare category here");
> +                       yyerror2("could not declare category %s here", id=
);
>                         goto bad;
>                 }
>         case 0:
> @@ -957,7 +971,7 @@ int define_category(void)
>
>         while ((id =3D queue_remove(id_queue))) {
>                 if (id_has_dot(id)) {
> -                       yyerror("category aliases may not contain periods=
");
> +                       yyerror2("category alias %s may not contain perio=
ds", id);
>                         free(id);
>                         return -1;
>                 }
> @@ -980,13 +994,13 @@ int define_category(void)
>                                 goto bad_alias;
>                         }
>                 case -2:{
> -                               yyerror
> -                                   ("duplicate declaration of category a=
liases");
> +                               yyerror2
> +                                   ("duplicate declaration of category a=
lias %s", id);
>                                 goto bad_alias;
>                         }
>                 case -1:{
> -                               yyerror
> -                                   ("could not declare category aliases =
here");
> +                               yyerror2
> +                                   ("could not declare category alias %s=
 here", id);
>                                 goto bad_alias;
>                         }
>                 case 0:
> @@ -1114,7 +1128,7 @@ int define_level(void)
>                         range_end =3D cdatum->s.value - 1;
>
>                         if (range_end < range_start) {
> -                               yyerror2("category range is invalid");
> +                               yyerror2("category range %d-%d is invalid=
", range_start, range_end);
>                                 free(id);
>                                 return -1;
>                         }
> @@ -1170,6 +1184,7 @@ int expand_attrib(void)
>         ebitmap_t attrs;
>         type_datum_t *attr;
>         ebitmap_node_t *node;
> +       const char *name;
>         uint32_t i;
>         int rc =3D -1;
>         int flags =3D 0;
> @@ -1222,13 +1237,13 @@ int expand_attrib(void)
>         }
>
>         ebitmap_for_each_positive_bit(&attrs, node, i) {
> -               attr =3D hashtab_search(policydbp->p_types.table,
> -                               policydbp->sym_val_to_name[SYM_TYPES][i])=
;
> +               name =3D policydbp->sym_val_to_name[SYM_TYPES][i];
> +               attr =3D hashtab_search(policydbp->p_types.table, name);
>                 attr->flags |=3D flags;
>                 if ((attr->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE) &&
>                                 (attr->flags & TYPE_FLAGS_EXPAND_ATTR_FAL=
SE)) {
> -                       yywarn("Expandattribute option was set to both tr=
ue and false. "
> -                               "Resolving to false.");
> +                       yywarn2("Expandattribute option of attribute %s w=
as set to both true and false; "
> +                               "Resolving to false.", name);
>                         attr->flags &=3D ~TYPE_FLAGS_EXPAND_ATTR_TRUE;
>                 }
>         }
> @@ -1247,9 +1262,9 @@ static int add_aliases_to_type(type_datum_t * type)
>         int ret;
>         while ((id =3D queue_remove(id_queue))) {
>                 if (id_has_dot(id)) {
> +                       yyerror2
> +                           ("type alias identifier %s may not contain pe=
riods", id);
>                         free(id);
> -                       yyerror
> -                           ("type alias identifiers may not contain peri=
ods");
>                         return -1;
>                 }
>                 aliasdatum =3D (type_datum_t *) malloc(sizeof(type_datum_=
t));
> @@ -1274,7 +1289,7 @@ static int add_aliases_to_type(type_datum_t * type)
>                                 goto cleanup;
>                         }
>                 case -1:{
> -                               yyerror("could not declare alias here");
> +                               yyerror2("could not declare alias %s here=
", id);
>                                 goto cleanup;
>                         }
>                 case 0:         break;
> @@ -1790,8 +1805,8 @@ int define_bool_tunable(int is_tunable)
>                 return -1;
>         }
>         if (id_has_dot(id)) {
> +               yyerror2("boolean identifier %s may not contain periods",=
 id);
>                 free(id);
> -               yyerror("boolean identifiers may not contain periods");
>                 return -1;
>         }
>         datum =3D (cond_bool_datum_t *) malloc(sizeof(cond_bool_datum_t))=
;
> @@ -1814,7 +1829,7 @@ int define_bool_tunable(int is_tunable)
>                         goto cleanup;
>                 }
>         case -1:{
> -                       yyerror("could not declare boolean here");
> +                       yyerror2("could not declare boolean %s here", id)=
;
>                         goto cleanup;
>                 }
>         case 0:
> @@ -1957,7 +1972,8 @@ static int avrule_read_ioctls(struct av_ioctl_range=
_list **rangehead)
>                         id =3D queue_remove(id_queue);
>                         r->range.high =3D (uint16_t) strtoul(id,NULL,0);
>                         if (r->range.high < r->range.low) {
> -                               yyerror("Ioctl ranges must be in ascendin=
g order.");
> +                               yyerror2("Ioctl range %d-%d must be in as=
cending order.",
> +                                        r->range.low, r->range.high);
>                                 return -1;
>                         }
>                         free(id);
> @@ -2532,7 +2548,7 @@ int define_te_avtab_extended_perms(int which)
>         if (strcmp(id,"ioctl") =3D=3D 0) {
>                 rc =3D define_te_avtab_ioctl(avrule_template);
>         } else {
> -               yyerror("only ioctl extended permissions are supported");
> +               yyerror2("only ioctl extended permissions are supported, =
found %s", id);
>                 rc =3D -1;
>         }
>
> @@ -3189,7 +3205,7 @@ int define_role_allow(void)
>  avrule_t *define_cond_filename_trans(void)
>  {
>         yyerror("type transitions with a filename not allowed inside "
> -               "conditionals\n");
> +               "conditionals");
>         return COND_ERR;
>  }
>
> @@ -3861,7 +3877,7 @@ int define_conditional(cond_expr_t * expr, avrule_t=
 * t, avrule_t * f)
>                 f =3D 0;
>                 expr =3D define_cond_expr(COND_NOT, expr, 0);
>                 if (!expr) {
> -                       yyerror("unable to invert");
> +                       yyerror("unable to invert conditional expression"=
);
>                         return -1;
>                 }
>         }
> @@ -4126,7 +4142,7 @@ static int parse_categories(char *id, level_datum_t=
 * levdatum, ebitmap_t * cats
>                 range_end =3D cdatum->s.value - 1;
>
>                 if (range_end < range_start) {
> -                       yyerror2("category range is invalid");
> +                       yyerror2("category range %d-%d is invalid", range=
_start, range_end);
>                         return -1;
>                 }
>         } else {
> @@ -5102,7 +5118,7 @@ int define_ibendport_context(unsigned int port)
>         }
>
>         if (port > 0xff || port =3D=3D 0) {
> -               yyerror("Invalid ibendport port number, should be 0 < por=
t < 256");
> +               yyerror2("Invalid ibendport port number %d, should be 0 <=
 port < 256", port);
>                 return -1;
>         }
>
> @@ -5121,7 +5137,7 @@ int define_ibendport_context(unsigned int port)
>         }
>
>         if (strlen(newc->u.ibendport.dev_name) > IB_DEVICE_NAME_MAX - 1) =
{
> -               yyerror("infiniband device name exceeds max length of 63.=
");
> +               yyerror2("infiniband device name %s exceeds max length of=
 63.", newc->u.ibendport.dev_name);
>                 rc =3D -1;
>                 goto out;
>         }
> @@ -5248,13 +5264,14 @@ int define_ipv4_node_context(void)
>         }
>
>         rc =3D inet_pton(AF_INET, id, &addr);
> -       free(id);
>         if (rc < 1) {
> -               yyerror("failed to parse ipv4 address");
> +               yyerror2("failed to parse ipv4 address %s", id);
> +               free(id);
>                 if (rc =3D=3D 0)
>                         rc =3D -1;
>                 goto out;
>         }
> +       free(id);
>
>         id =3D queue_remove(id_queue);
>         if (!id) {
> @@ -5264,14 +5281,16 @@ int define_ipv4_node_context(void)
>         }
>
>         rc =3D inet_pton(AF_INET, id, &mask);
> -       free(id);
>         if (rc < 1) {
> -               yyerror("failed to parse ipv4 mask");
> +               yyerror2("failed to parse ipv4 mask %s", id);
> +               free(id);
>                 if (rc =3D=3D 0)
>                         rc =3D -1;
>                 goto out;
>         }
>
> +       free(id);
> +
>         if (mask.s_addr !=3D 0 && ((~mask.s_addr + 1) & ~mask.s_addr) !=
=3D 0) {
>                 yywarn("ipv4 mask is not contiguous");
>         }
> @@ -5376,14 +5395,16 @@ int define_ipv6_node_context(void)
>         }
>
>         rc =3D inet_pton(AF_INET6, id, &addr);
> -       free(id);
>         if (rc < 1) {
> -               yyerror("failed to parse ipv6 address");
> +               yyerror2("failed to parse ipv6 address %s", id);
> +               free(id);
>                 if (rc =3D=3D 0)
>                         rc =3D -1;
>                 goto out;
>         }
>
> +       free(id);
> +
>         id =3D queue_remove(id_queue);
>         if (!id) {
>                 yyerror("failed to read ipv6 address");
> @@ -5392,14 +5413,16 @@ int define_ipv6_node_context(void)
>         }
>
>         rc =3D inet_pton(AF_INET6, id, &mask);
> -       free(id);
>         if (rc < 1) {
> -               yyerror("failed to parse ipv6 mask");
> +               yyerror2("failed to parse ipv6 mask %s", id);
> +               free(id);
>                 if (rc =3D=3D 0)
>                         rc =3D -1;
>                 goto out;
>         }
>
> +       free(id);
> +
>         if (!ipv6_is_mask_contiguous(&mask)) {
>                 yywarn("ipv6 mask is not contiguous");
>         }
> --
> 2.43.0
>
>
