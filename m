Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF54276038
	for <selinux@vger.kernel.org>; Mon,  6 Oct 2025 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763535; cv=none; b=a4WLjbWVl8xuquQ4ChbkUUW2SJaS1wxvp3yFRW4dhUdyVu7U38Bqc3/DH9suoV5DrNYbHcj0mDb+1/H9N128wDfuhaP40ek7AFvGVrIDY3Ia4DhSB3TkHZo1ktS0cZB6h5VH6Kpm9rAZBMQ/EzaV9Fx8VLDgzqw1jIbEY42XYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763535; c=relaxed/simple;
	bh=EUCKyeRmlSde5T9Povz3OSAAUM506l5PqpMO7b5ULek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnj17g2JOIwAl0oe7/ZF1J3/0R0fO/3Wkp1Tgqk6QVr4ICq2EVSNKxCgEq1u/rcdVXPcOvCNhmyd4UOWQbua8GJYvuRBkIov0LSjyZdPVLTtm57ZV9qML5ell6Zb2lbtrRSTOM8+206/Zi5gUjVz476Zp9Su9KKuN/eN2HrmENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3YwGCFm; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3YwGCFm"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3305c08d9f6so3573791a91.1
        for <selinux@vger.kernel.org>; Mon, 06 Oct 2025 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759763533; x=1760368333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l22LKfI/zeNEmfXygl1K/SJb9mFFH/U0K2uj6MnwM/w=;
        b=l3YwGCFmUmi2dWaIBKZlTr0cM2hujvfo6e5dheUjrwf9m0P66rHP9jMkeF6IGLDRP4
         IKZLpwIKdVrI3iLSTK1E4YCBmXuioEZNTEHBeY8iRIOjt8FUi803mXQAlAXcsLGtRR7l
         OtLPIVlGQbeWO/aK41+ISAndFn3xjy5Xx/32ORzV02nbETkRoidDCMUaKwXyJK7SzNz6
         cKtMRGpArQRHEIsw52aR/eNOshWFQYats5hPW0vFcBA9KvLQGE7naX3TSnRuKZW/PR1I
         HmL8Kgs7N79q5Pk0C4LUwwLZ3TaCKONddyA9UKQUMudBlwCC0C8RL+14Mm6kmv0BMjcp
         yJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759763533; x=1760368333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l22LKfI/zeNEmfXygl1K/SJb9mFFH/U0K2uj6MnwM/w=;
        b=r8fxDz625jLzaHtxEDeNsap7VaGebL4kQZMUd8U8V+Qas3Lln9jxAiwkDa8nWKuavN
         vynwDKRQCqZQ0rfWwWW4nNR58kS20Q8cY+XeLhqtZSXftLiQAshwxS4joir+3AUClyc6
         xrdIPGsCjmylW4heaLjHeBUYhu/V0J3eXYzKG/cgCL4V4wZjVG2S5vz6/HiBGsptBs/U
         ce0HL56rJZwrzd3SgMa0uQAD3izoxm6pqbX/+f8TnPhnU9WOtae49z7O4c0dhveaJI23
         Kt/NJ/Z40kcrqp15MqJYvAtC1vyZJQQ0lz4JdpVCLaQeLNoQoP8gOf4rHukk+Qbq7If1
         /1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVNHiXaAPqZBSKcCOWxBredsykKY6I8a75geCQG2fK3HA2gxhjEwM7KOFSios/Z+bVDqxzmY03@vger.kernel.org
X-Gm-Message-State: AOJu0YyVnru6dV2QH1NwcYo5oaQNVo8EwML1+pBDy7GNwbVhMP3n1fbD
	MUyD6M0RIyUu5EFMdpRp7PhWzNXeyCBTrmSSKfYPQg7qfwRcwl2l8RiYRqmwiG/yb/a5KmiHK9e
	MG9130Egzthepb4it5Ymsr3YyawNvlIo=
X-Gm-Gg: ASbGncsoouUUXggHbqmtOyOwTXrUV36GKsSZ7iXo9Nb6OYlEAWeRyaEqObX4kiWRESH
	rxL8X8UAa/yOdoV9it/Gom4ZUORsULz7d3jDXNSpYYU5sQQzIcpExoFxqKipuXod0YAc5aVJLWD
	AFvkgw7RSSKXjJ8NkC0Rz0en0M4lkrQRvfaAjlPqtkn9RKq/MOpCHwKnL7QuPBUoseZK2HSEydZ
	syFHPmYMqig18lHlELhR84eecfvDBe2TbXJWybTUg==
X-Google-Smtp-Source: AGHT+IE5QOM7Iv2WUk6m7hgkLPUymhRFxpNDwkuO3SkOwxbVEChNOh9opcr2Jm3x+DDzq3RqWNtrqr5yvg8DnwRI0Yg=
X-Received: by 2002:a17:90a:510:b0:32d:a37c:4e31 with SMTP id
 98e67ed59e1d1-339b52180f2mr14298555a91.17.1759763532804; Mon, 06 Oct 2025
 08:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813052552.3636318-1-inseob@google.com> <CAP+JOzQu-KPLP9QSeseLj+VB10j-PYO1se8T+zKY4-kP=zQoiA@mail.gmail.com>
In-Reply-To: <CAP+JOzQu-KPLP9QSeseLj+VB10j-PYO1se8T+zKY4-kP=zQoiA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 6 Oct 2025 11:12:01 -0400
X-Gm-Features: AS18NWCPqZcbeFXuxLkbTRczgZ4rqL_aboYrpMQjmQtqI_f8Hvs4BCEAkVr3Cm0
Message-ID: <CAEjxPJ6OhyTeuVbpck4Z5hcw7gy=amNsRFCwnK6b-xxq1empTg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix erroneous genfscon asterisks
To: James Carter <jwcart2@gmail.com>
Cc: Inseob Kim <inseob@google.com>, selinux@vger.kernel.org, takayas@google.com, 
	tweek@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 12:52=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, Aug 13, 2025 at 1:26=E2=80=AFAM Inseob Kim <inseob@google.com> wr=
ote:
> >
> > When genfs_seclabel_wildcard is on, extra asterisks are added to keep
> > semantics of genfscon entries. That needs to be removed when converting
> > the policy to CIL or conf, but genfscon_to_cil is missing it.
> >
> > Signed-off-by: Inseob Kim <inseob@google.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.

>
> > ---
> >  libsepol/src/module_to_cil.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.=
c
> > index b4439b27..8647d928 100644
> > --- a/libsepol/src/module_to_cil.c
> > +++ b/libsepol/src/module_to_cil.c
> > @@ -2987,10 +2987,22 @@ static int genfscon_to_cil(struct policydb *pdb=
)
> >         struct genfs *genfs;
> >         struct ocontext *ocon;
> >         uint32_t sclass;
> > +       char *name;
> > +       int wildcard =3D ebitmap_get_bit(&pdb->policycaps, POLICYDB_CAP=
_GENFS_SECLABEL_WILDCARD);
> > +       size_t name_len;
> >
> >         for (genfs =3D pdb->genfs; genfs !=3D NULL; genfs =3D genfs->ne=
xt) {
> >                 for (ocon =3D genfs->head; ocon !=3D NULL; ocon =3D oco=
n->next) {
> >                         sclass =3D ocon->v.sclass;
> > +                       name =3D ocon->u.name;
> > +                       name_len =3D strlen(name);
> > +                       if (wildcard) {
> > +                               if (name_len =3D=3D 0 || name[name_len =
- 1] !=3D '*') {
> > +                                       ERR(NULL, "genfscon path must e=
nd with '*' when genfs_seclabel_wildcard");
> > +                                       return -1;
> > +                               }
> > +                               --name_len;
> > +                       }
> >                         if (sclass) {
> >                                 const char *file_type;
> >                                 const char *class_name =3D pdb->p_class=
_val_to_name[sclass-1];
> > @@ -3011,9 +3023,10 @@ static int genfscon_to_cil(struct policydb *pdb)
> >                                 } else {
> >                                         return -1;
> >                                 }
> > -                               cil_printf("(genfscon %s \"%s\" %s ", g=
enfs->fstype, ocon->u.name, file_type);
> > +                               cil_printf("(genfscon %s \"%.*s\" %s ",=
 genfs->fstype, (int)name_len, name,
> > +                                          file_type);
> >                         } else {
> > -                               cil_printf("(genfscon %s \"%s\" ", genf=
s->fstype, ocon->u.name);
> > +                               cil_printf("(genfscon %s \"%.*s\" ", ge=
nfs->fstype, (int)name_len, name);
> >                         }
> >                         context_to_cil(pdb, &ocon->context[0]);
> >                         cil_printf(")\n");
> > --
> > 2.51.0.rc0.205.g4a044479a3-goog
> >
> >
>
