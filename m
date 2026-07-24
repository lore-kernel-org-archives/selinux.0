Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666843C041
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903634; cv=pass; b=BQ6sXyVtd85MjcK1Ev3g+LVAKM7RysmS0IObLXf0oDyA4/x4rUsIWoL5H51gemaipOMtyGHwga9Rm+ac0OiRnnQrRDeSgfSuyjfv3clJppS8o3blKG2O8EFlWw2rqYRTVjETGgpl36WKba1IdjsxyHPAN5n71Y1wJ9q/jkCKgAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903634; c=relaxed/simple;
	bh=VCfOwu0w0Xv5v0JU5uZTRG72Kah3wzxnKQUq7coVQiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjTkdbRjx/vCjqWFaGkl3c4jJtBLIS42u57baPiOSkT2wzucUek6XtsqUfETZZriAzBY6QQJnY64/9MdhKyOW2HWh7w7UaXUt2uV4Qt7juD3LIpPgYBK9PmQJbdvf+R4nEDtq00UrKvAfUO7VtKM+yQg4D5qVyI0wCemi8INN3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj0kLlYp; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj0kLlYp"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c2808dbc3so4421971cf.1
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784903631; cv=none;
        d=google.com; s=arc-20260327;
        b=Jp/txPFtjNAoXeRaUMVtb+nM232ehFg5ddiAgOMQOYjz8Zv8Fakl1875iKH1jvFsWk
         UKRE7+3OucVdC/i/FImW4jpG/eJ40zotDU5m8+SINC3ziJaD7uHs0G9UQQWqnMMi1unM
         gc5mPOHlUBZIgASgCllx7b2pfiUw6Edxj7D3muG66PIzzqEQJE5i2Jr+BRIgVrEAv2FV
         ig0o5fjnhhvWSpoi7cTOZ+rvHW3xGWgdidniRA3tkl/4eupo5wgO3yfIxg4mbRZW+8NZ
         oMM6AOETPuR1UtPy09aK6b6kitvkwxz4fGTrCM/PB5ZEUz1VixWD3wugdyp9qK8Hqmlw
         0Aaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ThKe9AI4s+Vo182mqFmgFtsRizFAnKmkKo3zIeJxMFY=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=cav0gSeM7KSd7+kcISzJy9IlJOAfxQ5UjZzeEExwqkF5DbEQA4PhUt9adZsLSlcfEz
         KygG3ny9x6nv7AGVK/jlg29r22A14/tSuoGex9wBK6xgYeIFgYXfRcNPkIQh4MN2xIpe
         D9/66cLTZOD/hM+awUXlYbrIdrHEhWnzHKKamlOuQdKudDmjel+lM8xRtB67gqh88NyD
         SlREEtfnSKeELZ+keZhAjxAUoio9pG2PtrhN8bZkx/hFulMyNtveqc72gYC8TiQVUWKN
         hQNlHq0xNhWC6PiKB5MdrXIssitBXoouupWLy8VhjCHihm9qGa8nlY4kB5xiyAKHDB3p
         hRDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784903631; x=1785508431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ThKe9AI4s+Vo182mqFmgFtsRizFAnKmkKo3zIeJxMFY=;
        b=Rj0kLlYpyRoYNKg97GryxpNzTQFonRAqICQLzv9+VKomgN8hu7qMet6gWAOnwW7qAi
         RiQ/zraGsngoMkNKY+3xChZQLlHb+Rl/nowlqRW1fZ3QdNTu/3sW7HYhucPXOv8vfnyI
         X6hSVF0F5wRk704or+wOyZnCrbiQQe+3xCVhwAhCiEIugfdF58c4Z7gZodDHuc0VxaCP
         wpR7APy7tlzzZkM/+dwiNpYWLegtRyFFNKBrxl+HR1qV9zpYdbk3cprQu1uuKkFqGUi0
         aaaBbJSoknEEIkTIrecAr3FVE7wgNiT+B7xDI91/Jm8Z+Ylb/uLfmKLucRHdiBA/L0Yz
         kyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903631; x=1785508431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ThKe9AI4s+Vo182mqFmgFtsRizFAnKmkKo3zIeJxMFY=;
        b=IyRNHOKYq6u59BakJbB+zi5fn/+PFUZv2UU+j8o0bU7JQHmfbaVVniUasQ/4/YZTSI
         XhzjOtns5nzpMBUeW5wg4p+Ki4lnn/lKjAvWrshmmm+HMuLxg80G590d6rp/L2WvJUND
         IwN4sCeJhjYHZmCyjwkN9aU3Xp3wja7dsm7tqLdxOeyRgZXehkHDId7eOA9jFr3bBQZW
         OFi4gwn9OHSqSl51/jCqgU0SQXeB9dctPV05AkaGCIMz4SiNjxg5WqoBoJH1jcDB8MEB
         F7V5IrOknMK/WOsix4vGUXVPDVY4/94E2+kJr1YmMZyxej/jj68bb+8DeKT4KGg2JPrL
         oxAA==
X-Gm-Message-State: AOJu0YwbNZaqIYRsddw5go1/paPzNGkR4Q0ZYkZnj5mZgxOpJJUdsdyU
	HbXY5AIlSQHivKsswbarFpMp3MSDgNmHIKfr/X1cgrI4xv3BViyDNgpvU1hMlwDZznOSCeXLkoA
	fouPIUQCFZFdQt6JXjnZuWlB3vJRVHlfb6A==
X-Gm-Gg: AR+sD10EhPw3YsR8TUcreQBJIrVpK8UNjVUOKU006vswIT4B9Bn8qtu4z6nYMMsIuW+
	SfTmJe9BIpmGwElhCITzFx2dAdya27HgHUevTC7bP+AmT+e9By0blPlqK7nHwQdVCqPmTHHuZlJ
	e0mO5021IgqzLMxP4MVwFjdBKrqzFXccArS7EAgxz8lp7ya2u4H3sI90+P7Wrl4jbVReVBYrX1I
	xL/yuRKhlZgL4l9V7er3U6z9LG6LO7D+ShvZOF4qaD7xESP7jdv2sY+r8n3Trxrp1y0RY1r
X-Received: by 2002:a05:622a:4106:b0:51b:fca2:af71 with SMTP id
 d75a77b69052e-5283df106bdmr73514381cf.42.1784903631297; Fri, 24 Jul 2026
 07:33:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723165436.10978-1-jwcart2@gmail.com> <CAEjxPJ52heUU276fCsy20fsKi5YLV4QZci6hnnS6c3c1uFbWiA@mail.gmail.com>
In-Reply-To: <CAEjxPJ52heUU276fCsy20fsKi5YLV4QZci6hnnS6c3c1uFbWiA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:33:39 -0400
X-Gm-Features: AUfX_myw_obOp4J13lojSY6rkcHR_NwFGzAU_Aj-bdIxUHFJVYm6FDO-8297qkk
Message-ID: <CAEjxPJ7V9k8gMvut=wURfbDMUXMw358equJKip_MoJSyMrDO9w@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Validate string fields used in various
 labeling rules
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:37=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 23, 2026 at 12:54=E2=80=AFPM James Carter <jwcart2@gmail.com>=
 wrote:
> >
> > Filename transitions and the ocontexts fs, netif, fs_use,
> > ibendport, Xen devicetree, and genfs use strings in a name or type
> > field used to identify what to label.
> >
> > Check that these strings do not contain any control characters to
> > protect against maliciously crafted policies.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

>
> > ---
> > v2: Added another check in validate_genfs() and a check in
> >      validate_filename_trans_rules
> >
> >  libsepol/src/policydb_validate.c | 35 +++++++++++++++++++++++++++-----
> >  1 file changed, 30 insertions(+), 5 deletions(-)
> >
> > diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_v=
alidate.c
> > index cde0b8d6..e7d79871 100644
> > --- a/libsepol/src/policydb_validate.c
> > +++ b/libsepol/src/policydb_validate.c
> > @@ -1,4 +1,5 @@
> >
> > +#include <ctype.h>
> >  #include <sepol/policydb/conditional.h>
> >  #include <sepol/policydb/ebitmap.h>
> >  #include <sepol/policydb/polcaps.h>
> > @@ -129,6 +130,23 @@ bad:
> >         return -1;
> >  }
> >
> > +static int validate_string_field(const char *s)
> > +{
> > +       if (!s || !*s)
> > +               goto bad;
> > +
> > +       while (*s) {
> > +               if (iscntrl((unsigned char)*s))
> > +                       goto bad;
> > +               s++;
> > +       }
> > +
> > +       return 0;
> > +
> > +bad:
> > +       return -1;
> > +}
> > +
> >  static int validate_ebitmap(const ebitmap_t *map, const validate_t *fl=
avor)
> >  {
> >         if (ebitmap_length(map) > 0 &&
> > @@ -1436,6 +1454,8 @@ static int validate_filename_trans(hashtab_key_t =
k, hashtab_datum_t d,
> >                 goto bad;
> >         if (validate_value(ftk->tclass, &flavors[SYM_CLASSES]))
> >                 goto bad;
> > +       if (validate_string_field(ftk->name))
> > +               goto bad;
> >         if (!ftd)
> >                 goto bad;
> >         for (; ftd; ftd =3D ftd->next) {
> > @@ -1505,7 +1525,7 @@ static int validate_ocontexts(sepol_handle_t *han=
dle, const policydb_t *p,
> >                                         if (validate_context(&octx->con=
text[1],
> >                                                              flavors, p=
->mls))
> >                                                 goto bad;
> > -                                       if (!octx->u.name)
> > +                                       if (validate_string_field(octx-=
>u.name))
> >                                                 goto bad;
> >                                         break;
> >                                 case OCON_PORT:
> > @@ -1522,7 +1542,7 @@ static int validate_ocontexts(sepol_handle_t *han=
dle, const policydb_t *p,
> >                                         default:
> >                                                 goto bad;
> >                                         }
> > -                                       if (!octx->u.name)
> > +                                       if (validate_string_field(octx-=
>u.name))
> >                                                 goto bad;
> >                                         break;
> >                                 case OCON_IBPKEY:
> > @@ -1533,7 +1553,8 @@ static int validate_ocontexts(sepol_handle_t *han=
dle, const policydb_t *p,
> >                                 case OCON_IBENDPORT:
> >                                         if (octx->u.ibendport.port =3D=
=3D 0)
> >                                                 goto bad;
> > -                                       if (!octx->u.ibendport.dev_name=
)
> > +                                       if (validate_string_field(
> > +                                                   octx->u.ibendport.d=
ev_name))
> >                                                 goto bad;
> >                                         break;
> >                                 }
> > @@ -1560,7 +1581,7 @@ static int validate_ocontexts(sepol_handle_t *han=
dle, const policydb_t *p,
> >                                                 goto bad;
> >                                         break;
> >                                 case OCON_XEN_DEVICETREE:
> > -                                       if (!octx->u.name)
> > +                                       if (validate_string_field(octx-=
>u.name))
> >                                                 goto bad;
> >                                         break;
> >                                 }
> > @@ -1590,9 +1611,11 @@ static int validate_genfs(sepol_handle_t *handle=
, const policydb_t *p,
> >                             validate_value(octx->v.sclass,
> >                                            &flavors[SYM_CLASSES]))
> >                                 goto bad;
> > +                       if (validate_string_field(octx->u.name))
> > +                               goto bad;
> >                 }
> >
> > -               if (!genfs->fstype)
> > +               if (validate_string_field(genfs->fstype))
> >                         goto bad;
> >         }
> >
> > @@ -1728,6 +1751,8 @@ validate_filename_trans_rules(sepol_handle_t *han=
dle,
> >                         goto bad;
> >                 if (validate_simpletype(filename_trans->otype, p, flavo=
rs))
> >                         goto bad;
> > +               if (validate_string_field(filename_trans->name))
> > +                       goto bad;
> >
> >                 /* currently only the RULE_SELF flag can be set */
> >                 switch (filename_trans->flags) {
> > --
> > 2.55.0
> >
