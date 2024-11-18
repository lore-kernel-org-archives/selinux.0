Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432981E570E
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731960819; cv=none; b=exfSQ4/eGHYUCMGT4b/hocG9ALprFu2o44tK0aPxTpzgzgzC6ZPXpz5g2sntHCfoVOYNFFZskZhpdxIui4Z0iZOOkp+Bnj1UcmZbUKEUxZGim2K0v/s2Gk0QIdvsTezN/CqnKfnGAW8b4ENezyP83cy6cU4wewH0vWeJEw7/TXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731960819; c=relaxed/simple;
	bh=diOiyQOIRedQaJYntGUQR3O8fk4He3YeSRlBaSaL1DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTOqbvk2ItyCO7H7B0LX3BY/6z3G8lr/7yuiYyrUnwB/lbDKKJJ6vcQSNw5JeKzeB2bhHK4fW0l+KyVpy3lrKcLFJ0IPr875Qf3pyfTNtdmqV+uXHiY6nwNLyP/4C5A0tWWFURW8U2PAKitUaNF50YvkKhIFoXEHeRelB/zrsM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfcIGpct; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfcIGpct"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ec1ee25504so1504766eaf.3
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 12:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731960816; x=1732565616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbIteTHicCe/Zyfi/7ObhkAZ8NEWbuev7eKW4eOmIXw=;
        b=ZfcIGpctxCOtQHyaSA7JM2AsJYARJ2MAEHoeHtk4snGoL5XO3SOQ0FhxprTmLP5sc3
         H1kk6+GXPvI6S4ersNKu8izROjGBUb37u81Q6i27eSozA980gQjCR9NkUSUpnA2LxVya
         7peiaTeBXW2X/F46fwLKZ+B8jgjnUqGPYzljxbwoj5hhys9bqP58UEzwocwVaCsTAytY
         oPecfnInEVr3YmAh/zq3bz8WpOaoZJgrJ/I3WewJpehjvHlK3br2/3Mv6BW1yv/O6wIf
         5fvyfNGZ9ibydhGLrTrMati47EaiQfLLurlPT7VdDOe4ig+6GsknoImIniTea90Bay3y
         ZiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731960816; x=1732565616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbIteTHicCe/Zyfi/7ObhkAZ8NEWbuev7eKW4eOmIXw=;
        b=H4H/V31LQP8rwuxCzzUh/b5d6zQ3Py654hlu3tDLwWSh60E+yPuuA8v/s1Za8nK71r
         oZKHLq/Gf8groezs33Kiu611onCi9VgN/3ikIFKVCPkLbsOeZvRqauOqfT3pt/sfdqdF
         x/6fKOeXKsbGIId+yer5w+K8U0LjEpAcdOAqRoxPnOVMBcOz++Kby06Opv4YWbasDAtg
         LUjaHjYP5ya/kwgPCQXkviE9y5gz7cwxQp5/gHjYgi0T6OPDFeFJkYS2codZR2zz/rFq
         XIfHAyjn7OFbmcANe4xE3LLAzrNJsBsOOfHM98/i0FYInn0Vp277RF1xClMys48IzdWw
         kz5Q==
X-Gm-Message-State: AOJu0Ywic/xZL5dLLG3DSA0lATomhJrPRYLg72nTt9Z6NblcVXqGY1zv
	NY7MYfl/neKY4b9GfoWP8JDoKx/qjXsSUBdAM8zo4jbJ0c/sJJKRPchkQXmaZyX9iS/nqc/zeXE
	s4NPBxaK13zipVxVRvIXRsI/LIzU=
X-Google-Smtp-Source: AGHT+IFiMusZYXVwFgmgFoCJ7zun+oHXt1pWpRHSbbIHsiNNkmY5v43zSRdWB608ak0qQvfBSeqEoS2XE+8BAU+mRdk=
X-Received: by 2002:a05:6808:1807:b0:3e5:f43a:5d77 with SMTP id
 5614622812f47-3e7bc850c93mr9110828b6e.42.1731960816060; Mon, 18 Nov 2024
 12:13:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105210618.326533-1-cgoettsche@seltendoof.de> <CAP+JOzTMjLah6iX0WYzQUOQ18-s9Yj5-yJ6F_w=Yf5MMoW7zWQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTMjLah6iX0WYzQUOQ18-s9Yj5-yJ6F_w=Yf5MMoW7zWQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 18 Nov 2024 15:13:25 -0500
Message-ID: <CAP+JOzRqTz=MRdmEP3BYgx45BwsVvRd+qmPVDFNdVjEpAQthzw@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy: avoid memory leaks on redeclarations
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 2:43=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Tue, Nov 5, 2024 at 4:06=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > If declare_symbol() returns 1 the id and the datum are already defined
> > and not consumed by the function, so it they must be free'd by the
> > caller.
> >
> > Example policy (generated by fuzzer):
> >
> >     class s sid e class s{i}optional{require{bool K;}bool K true;
> >
> > Reported-by: oss-fuzz (issue 377544445)
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/module_compiler.c |  2 +-
> >  checkpolicy/module_compiler.h |  2 +-
> >  checkpolicy/policy_define.c   | 72 +++++++++++++++++++++++------------
> >  3 files changed, 49 insertions(+), 27 deletions(-)
> >
> > diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compile=
r.c
> > index 4efd77bf..3a7ad1bb 100644
> > --- a/checkpolicy/module_compiler.c
> > +++ b/checkpolicy/module_compiler.c
> > @@ -190,7 +190,7 @@ static int create_symbol(uint32_t symbol_type, hash=
tab_key_t key, hashtab_datum_
> >   * not be restricted pointers. */
> >  int declare_symbol(uint32_t symbol_type,
> >                    hashtab_key_t key, hashtab_datum_t datum,
> > -                  uint32_t * dest_value, uint32_t * datum_value)
> > +                  uint32_t * dest_value, const uint32_t * datum_value)
> >  {
> >         avrule_decl_t *decl =3D stack_top->decl;
> >         int ret =3D create_symbol(symbol_type, key, datum, dest_value, =
SCOPE_DECL);
> > diff --git a/checkpolicy/module_compiler.h b/checkpolicy/module_compile=
r.h
> > index e43bc6c0..2fe3455d 100644
> > --- a/checkpolicy/module_compiler.h
> > +++ b/checkpolicy/module_compiler.h
> > @@ -28,7 +28,7 @@ int define_policy(int pass, int module_header_given);
> >   */
> >  int declare_symbol(uint32_t symbol_type,
> >                    hashtab_key_t key, hashtab_datum_t datum,
> > -                  uint32_t * dest_value, uint32_t * datum_value);
> > +                  uint32_t * dest_value, const uint32_t * datum_value)=
;
> >
> >  role_datum_t *declare_role(unsigned char isattr);
> >  type_datum_t *declare_type(unsigned char primary, unsigned char isattr=
);
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index f8a10154..9aae8378 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -156,9 +156,9 @@ static int id_has_dot(const char *id)
> >
> >  int define_class(void)
> >  {
> > -       char *id =3D 0;
> > -       class_datum_t *datum =3D 0;
> > -       int ret;
> > +       char *id =3D NULL;
> > +       class_datum_t *datum =3D NULL;
> > +       int ret =3D -1;
> >         uint32_t value;
> >
> >         if (pass =3D=3D 2) {
> > @@ -175,27 +175,29 @@ int define_class(void)
> >         datum =3D (class_datum_t *) malloc(sizeof(class_datum_t));
> >         if (!datum) {
> >                 yyerror("out of memory");
> > -               goto bad;
> > +               goto cleanup;
> >         }
> >         memset(datum, 0, sizeof(class_datum_t));
> >         ret =3D declare_symbol(SYM_CLASSES, id, datum, &value, &value);
> >         switch (ret) {
> >         case -3:{
> >                         yyerror("Out of memory!");
> > -                       goto bad;
> > +                       goto cleanup;
> >                 }
> >         case -2:{
> >                         yyerror2("duplicate declaration of class %s", i=
d);
> > -                       goto bad;
> > +                       goto cleanup;
> >                 }
> >         case -1:{
> >                         yyerror("could not declare class here");
> > -                       goto bad;
> > +                       goto cleanup;
> >                 }
> > -       case 0:
> > -       case 1:{
> > +       case 0: {
> >                         break;
> >                 }
> > +       case 1:{
> > +                       goto cleanup;
> > +               }
> >         default:{
> >                         assert(0);      /* should never get here */
> >                 }
> > @@ -203,12 +205,10 @@ int define_class(void)
> >         datum->s.value =3D value;
> >         return 0;
> >
> > -      bad:
> > -       if (id)
> > -               free(id);
> > -       if (datum)
> > -               free(datum);
> > -       return -1;
> > +      cleanup:
> > +       free(id);
> > +       free(datum);
> > +       return ret =3D=3D 1 ? 0 : -1;
> >  }
> >
> >  int define_permissive(void)
> > @@ -785,8 +785,13 @@ int define_sens(void)
> >                         yyerror2("could not declare sensitivity level %=
s here", id);
> >                         goto bad;
> >                 }
> > -       case 0:
> > +       case 0: {
> > +                       break;
> > +               }
> >         case 1:{
> > +                       level_datum_destroy(datum);
> > +                       free(datum);
> > +                       free(id);
> >                         break;
> >                 }
> >         default:{
> > @@ -827,8 +832,13 @@ int define_sens(void)
> >                                     ("could not declare sensitivity ali=
as %s here", id);
> >                                 goto bad_alias;
> >                         }
> > -               case 0:
> > +               case 0: {
> > +                               break;
> > +                       }
> >                 case 1:{
> > +                               level_datum_destroy(aliasdatum);
> > +                               free(aliasdatum);
> > +                               free(id);
> >                                 break;
> >                         }
> >                 default:{
> > @@ -957,15 +967,20 @@ int define_category(void)
> >                         yyerror2("could not declare category %s here", =
id);
> >                         goto bad;
> >                 }
> > -       case 0:
> > +       case 0:{
> > +                       datum->s.value =3D value;
> > +                       break;
> > +               }
> >         case 1:{
> > +                       cat_datum_destroy(datum);
> > +                       free(datum);
> > +                       free(id);
> >                         break;
> >                 }
> >         default:{
> >                         assert(0);      /* should never get here */
> >                 }
> >         }
> > -       datum->s.value =3D value;
> >
> >         while ((id =3D queue_remove(id_queue))) {
> >                 if (id_has_dot(id)) {
> > @@ -981,11 +996,11 @@ int define_category(void)
> >                 }
> >                 cat_datum_init(aliasdatum);
> >                 aliasdatum->isalias =3D TRUE;
> > -               aliasdatum->s.value =3D datum->s.value;
> > +               aliasdatum->s.value =3D value;
> >
> >                 ret =3D
> >                     declare_symbol(SYM_CATS, id, aliasdatum, NULL,
> > -                                  &datum->s.value);
> > +                                  &value);
> >                 switch (ret) {
> >                 case -3:{
> >                                 yyerror("Out of memory!");
> > @@ -1001,8 +1016,13 @@ int define_category(void)
> >                                     ("could not declare category alias =
%s here", id);
> >                                 goto bad_alias;
> >                         }
> > -               case 0:
> > +               case 0:{
> > +                               break;
> > +                       }
> >                 case 1:{
> > +                               cat_datum_destroy(aliasdatum);
> > +                               free(aliasdatum);
> > +                               free(id);
> >                                 break;
> >                         }
> >                 default:{
> > @@ -1833,10 +1853,12 @@ int define_bool_tunable(int is_tunable)
> >                         yyerror2("could not declare boolean %s here", i=
d);
> >                         goto cleanup;
> >                 }
> > -       case 0:
> > -       case 1:{
> > +       case 0:{
> >                         break;
> >                 }
> > +       case 1:{
> > +                       goto cleanup;
> > +               }
> >         default:{
> >                         assert(0);      /* should never get here */
> >                 }
> > @@ -1854,7 +1876,7 @@ int define_bool_tunable(int is_tunable)
> >         return 0;
> >        cleanup:
> >         cond_destroy_bool(id, datum, NULL);
> > -       return -1;
> > +       return ret =3D=3D 1 ? 0 : -1;
> >  }
> >
> >  avrule_t *define_cond_pol_list(avrule_t * avlist, avrule_t * sl)
> > --
> > 2.45.2
> >
> >
