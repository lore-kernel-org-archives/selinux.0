Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11279924
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709580071; cv=none; b=V1fGufcfdZS9fyz5QYEpR4oTRZsV61esZoU6+xidpcI95zuZ7d5YCfgV2PupEvi2LiEvEQA8GAckSoxWd5nGHdbSsDMnCXGEglFllFqH510yB58lf4pZ+j8wmMTQgeV+JrxsDv7ym6+1SoF3ekkIt30m9wZrmH8FyvGflP3rTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709580071; c=relaxed/simple;
	bh=guhEjrTZa7dhMYBpebqsiKrcvVcjyogMZ2XW58TRFpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtJSUpNkAEPpD24HGAYUZhpyKF7i3bsvxeBfPRkIB4Ajy9zGj9K+G8ZUN6xC7cGC6DAXpYSMZp78vcoPe7gvYwdpacoNfarPp96lyDro4O3MkwampGXfJRQCV7eBe6W7ji+3gp5zEsDso7Ky1EzZsa966Vb2wlEnSvJkhI5v6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft04IXrQ; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft04IXrQ"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d698a8d93cso2599457241.3
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709580069; x=1710184869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l320oLJcqfWgI7Gx5KqEgsuDSF3BkXQtvuzRtwjH5Cg=;
        b=ft04IXrQoEoWod4RoQUcZcw+av55aFDrzMEq0FIabZIMOGVxjDypI1X+uLRNO64VDS
         5p0jmITSUwXJ0u889cMMc/IXnwHdKUu4zUxkZZVz+jWcKGaRoWgIEjTac1AYZg1gcTdn
         Sk9SHBZzHODiGT8/Ok5xslE1J+lW0RnT3Wqqb9+n5Tepwe/L8W6rnLn1r61HrYwDwjZd
         DUyw0xV2mi8ErboRFO8j09rKJr5/ai4OfmZvvEWt0KYCp0vjM2wHWFr3C/mOrghBRfzF
         SXxQ/jRBHlpVaxsSRS1Dssw08pZnRTbq/1IdKDiaFYfpNNAR5pkhO3kqy2NUN4Zdf6xH
         WfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709580069; x=1710184869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l320oLJcqfWgI7Gx5KqEgsuDSF3BkXQtvuzRtwjH5Cg=;
        b=JPv8cNX4M0BTMcEt3ndVmv/1RrXJMxVILbTbp6RrUoQBQxT5O3dz6+Ddj4/3bKDia8
         +ZgzpMGnH0x9HaoZD182s2e5vDJTt41GMQdxDPrXB162m4wS10Bg9+cyrYS7e/8sHwWd
         TvsLLQ7CXMyHDAvmIPvOMeRAeuUzuKmWH5jODOBSK4EjFed3IDBYdLkiBiQD8kcgC50/
         +XigFGGf/pZOhaMC2ffW5wRLYESq+pajCWAJ5WsZeMxj3BNjWP0z8l8YK9L1vBng9fZk
         tY3oQIB+uiQG9pd0v7AWOXcpiWSxOvbi5mHR9DOeASS7vyvjfLhTe+iYIi5rVJB2Wusl
         7u1A==
X-Gm-Message-State: AOJu0YzDsKzp3KRcOTJQVCufDZTYD4o7T67ROYfREDnOCwp55rd8/M1X
	utVXFtF+WjTAPuC6UzNfnEGqQCmGs15/nTOiI9B7aHbJNuap2dAtg9u+q0K2PrK7r6Y6IQCwNen
	995921EOxDnGEKmpPi6WhM52MZdcQIcVn
X-Google-Smtp-Source: AGHT+IFGTrQISTQFJMxmvYLIt2RaLXINDIb8NzBLvB/A/HZ3Vl9YhDlWJ9qRjSSvI6f2MSPTOfv0UZ5ZkhphG3AMiPc=
X-Received: by 2002:a67:cf0a:0:b0:471:d67f:ea2 with SMTP id
 y10-20020a67cf0a000000b00471d67f0ea2mr6984600vsl.19.1709580069108; Mon, 04
 Mar 2024 11:21:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122135507.63506-1-cgzones@googlemail.com>
 <20240122135507.63506-15-cgzones@googlemail.com> <CAP+JOzTcxy57oU6Qyqk50n+ks2fFx1O4LSP5P7JchcXxOcCHSQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTcxy57oU6Qyqk50n+ks2fFx1O4LSP5P7JchcXxOcCHSQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:20:58 -0500
Message-ID: <CAP+JOzTviF5PFsS5YHo8wkNG_ugCmuFi7Q2aK3LTxOTWehK1Ug@mail.gmail.com>
Subject: Re: [PATCH 15/15] checkpolicy: misc policy_define.c cleanup
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:39=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Mon, Jan 22, 2024 at 9:02=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Sync function parameter names.
> >
> > Drop superfluous return value.
> >
> >   The function avrule_merge_ioctls() has no failure conditions and
> >   always returns 0.
> >
> > Drop duplicate include.
> >
> > Use native type for ranges.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/policy_define.c | 27 ++++++++++++---------------
> >  checkpolicy/policy_define.h |  2 +-
> >  2 files changed, 13 insertions(+), 16 deletions(-)
> >
> > diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> > index cd49cae3..79d67a78 100644
> > --- a/checkpolicy/policy_define.c
> > +++ b/checkpolicy/policy_define.c
> > @@ -44,7 +44,6 @@
> >  #define IPPROTO_SCTP 132
> >  #endif
> >  #include <arpa/inet.h>
> > -#include <stdlib.h>
> >  #include <limits.h>
> >  #include <inttypes.h>
> >  #include <ctype.h>
> > @@ -1096,7 +1095,7 @@ int define_level(void)
> >
> >         while ((id =3D queue_remove(id_queue))) {
> >                 cat_datum_t *cdatum;
> > -               int range_start, range_end, i;
> > +               uint32_t range_start, range_end, i;
> >
> >                 if (id_has_dot(id)) {
> >                         char *id_start =3D id;
> > @@ -1932,7 +1931,7 @@ error:
> >         return -1;
> >  }
> >
> > -static int avrule_merge_ioctls(struct av_ioctl_range_list **rangehead)
> > +static void avrule_merge_ioctls(struct av_ioctl_range_list **rangehead=
)
> >  {
> >         struct av_ioctl_range_list *r, *tmp;
> >         r =3D *rangehead;
> > @@ -1949,7 +1948,6 @@ static int avrule_merge_ioctls(struct av_ioctl_ra=
nge_list **rangehead)
> >                 }
> >                 r =3D r->next;
> >         }
> > -       return 0;
> >  }
> >
> >  static int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
> > @@ -2070,8 +2068,7 @@ static int avrule_ioctl_ranges(struct av_ioctl_ra=
nge_list **rangelist)
> >         /* sort and merge the input ioctls */
> >         if (avrule_sort_ioctls(&rangehead))
> >                 return -1;
> > -       if (avrule_merge_ioctls(&rangehead))
> > -               return -1;
> > +       avrule_merge_ioctls(&rangehead);
> >         /* flip ranges if these are omitted */
> >         if (omit) {
> >                 if (avrule_omit_ioctls(&rangehead))
> > @@ -3854,7 +3851,7 @@ uintptr_t define_cexpr(uint32_t expr_type, uintpt=
r_t arg1, uintptr_t arg2)
> >         return 0;
> >  }
> >
> > -int define_conditional(cond_expr_t * expr, avrule_t * t, avrule_t * f)
> > +int define_conditional(cond_expr_t * expr, avrule_t * t_list, avrule_t=
 * f_list)
> >  {
> >         cond_expr_t *e;
> >         int depth, booleans, tunables;
> > @@ -3866,15 +3863,15 @@ int define_conditional(cond_expr_t * expr, avru=
le_t * t, avrule_t * f)
> >                 yyerror("illegal conditional expression");
> >                 return -1;
> >         }
> > -       if (!t) {
> > -               if (!f) {
> > +       if (!t_list) {
> > +               if (!f_list) {
> >                         /* empty is fine, destroy expression and return=
 */
> >                         cond_expr_destroy(expr);
> >                         return 0;
> >                 }
> >                 /* Invert */
> > -               t =3D f;
> > -               f =3D 0;
> > +               t_list =3D f_list;
> > +               f_list =3D NULL;
> >                 expr =3D define_cond_expr(COND_NOT, expr, 0);
> >                 if (!expr) {
> >                         yyerror("unable to invert conditional expressio=
n");
> > @@ -3940,8 +3937,8 @@ int define_conditional(cond_expr_t * expr, avrule=
_t * t, avrule_t * f)
> >         /*  use tmp conditional node to partially build new node */
> >         memset(&cn, 0, sizeof(cn));
> >         cn.expr =3D expr;
> > -       cn.avtrue_list =3D t;
> > -       cn.avfalse_list =3D f;
> > +       cn.avtrue_list =3D t_list;
> > +       cn.avfalse_list =3D f_list;
> >
> >         /* normalize/precompute expression */
> >         if (cond_normalize_expr(policydbp, &cn) < 0) {
> > @@ -4117,7 +4114,7 @@ static int set_user_roles(role_set_t * set, char =
*id)
> >  static int parse_categories(char *id, level_datum_t * levdatum, ebitma=
p_t * cats)
> >  {
> >         cat_datum_t *cdatum;
> > -       int range_start, range_end, i;
> > +       uint32_t range_start, range_end, i;
> >
> >         if (id_has_dot(id)) {
> >                 char *id_start =3D id;
> > @@ -5527,7 +5524,7 @@ static int define_genfs_context_helper(char *fsty=
pe, int has_type)
> >         class_datum_t *cladatum;
> >         char *type =3D NULL;
> >         const char *sclass;
> > -       int len, len2;
> > +       size_t len, len2;
> >
> >         if (policydbp->target_platform !=3D SEPOL_TARGET_SELINUX) {
> >                 yyerror("genfs not supported for target");
> > diff --git a/checkpolicy/policy_define.h b/checkpolicy/policy_define.h
> > index 075b048d..bcbfe4f3 100644
> > --- a/checkpolicy/policy_define.h
> > +++ b/checkpolicy/policy_define.h
> > @@ -13,7 +13,7 @@
> >  #define FALSE 0
> >
> >  avrule_t *define_cond_compute_type(int which);
> > -avrule_t *define_cond_pol_list(avrule_t *avlist, avrule_t *stmt);
> > +avrule_t *define_cond_pol_list(avrule_t *avlist, avrule_t *sl);
> >  avrule_t *define_cond_te_avtab(int which);
> >  avrule_t *define_cond_filename_trans(void);
> >  cond_expr_t *define_cond_expr(uint32_t expr_type, void *arg1, void* ar=
g2);
> > --
> > 2.43.0
> >
> >
