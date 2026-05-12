Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A033EDE4A
	for <selinux@vger.kernel.org>; Tue, 12 May 2026 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609159; cv=pass; b=c8cfPys2RVpeDX8kK/CCO3SoJKem/SvJfkU/8kBcNSIT0CUmM2BGk5IQ0AJUirla+puPaCOADCvJkBGFSTPzXCLAylpckF+Dbs2IKLuu0sN64kS4wMhLOqnUiKXkpvYrgt3HhrA68roPserf2WpKGobgMFRw0KzVsLSev/kJAxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609159; c=relaxed/simple;
	bh=HpLV/6xUDKu4BKASY245kQRzrdjjZDp3OIuAumUI1Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoA3I7MyXahOR+zEZkySHzPlkN8ozNyx4iddF9dTxiUtLbvUbJS9ZbrS8/sZVC/NzSMq+LddMIh3WzKcBWP1ifb6ywZOwPggStNUfAmnVLyH/D7byShhWJUocwRGAj9bkFgCEeSZl3BwQ8AOQ/VLmrH2yXRuiFpj8XqCa2YhN68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVHUpFEG; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVHUpFEG"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8738c178dso4057094e87.1
        for <selinux@vger.kernel.org>; Tue, 12 May 2026 11:05:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778609156; cv=none;
        d=google.com; s=arc-20240605;
        b=PoAqX7h+Ym2s663UPvaTGz3PWWTXk3tAP9w3zMq9pkHSPEpy+MtBLZCJmf8gigjnDT
         C0vKRKIpLLOIBgaCmYmbXoN4nod5wWKTkJ8DoouxfKiHuiU+xvffziGL4vz5XyKtONsS
         RLo+3oAH1jAGzUG4ZZabSLBPEyF+yHgqWS0eunQRZSIr1TWe7GABBEPoITzKJEFZZjdQ
         ULH1o1q9ebsvLEdf40rzVTx/ig3zSRRdZMhPfTIrCOaUtqlvyZ9P8qPThS4uMbf0WKr3
         wL3P/IQ72oRDniRavNA8NJE1dwFVObssvTAO5ONhYt7DhWlV+lGV61GLWPBPvVMRl3uL
         TTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RfjYyrC6spm2x8JAGRUw1pw462UyLev5bm+sj6Pl6Ug=;
        fh=dcS4OfzG3KKFMsdn+JV6f4ljbDQ0+DiEqv1NPzdqZq4=;
        b=C7FfUSgg7GK7kvizDGgUF/mcCdLZ4F8HwCwrGvOwYKVZV6f64kXbH8tdtCRQS4N359
         CwKamOCquWPWBz0PqEnBKo6Yqqvh8wNWrt5T/v8kSgimZRCSoghRbQ3vkiCScEBuTvCW
         ti2AUVeYx36hBy3zql8SF+NqIbtXj9o+PE/vmVyvOEe/Qs6Pt3DI7OVqC5/OBgHZKH6B
         kDCq5Y36enMuaN4cZOhFLoyPgg/PXWkbE8hIsyQn+OwQsLk8eHFjh6T5rNtGSVMvHw1c
         fE6W07+VkFaVc4RUPy2eDVadv0XdYbV20JyIp+Q8EtWeA1TTUK7uXU8z2BDsXUf1kn/z
         Uozw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778609156; x=1779213956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfjYyrC6spm2x8JAGRUw1pw462UyLev5bm+sj6Pl6Ug=;
        b=DVHUpFEG0WXC+3E92KGeRCfvPBjQ3ZLZYqiK1hlx8sjsSWLGIqC3/PnfoCh0zC5750
         hZZCkNx0afhTXgUHdOPhdkXxd+LMiuqStriohH+sFZbn8ZPZMhsdyS7XrUn66VFQfRcd
         0hFUwt7ZluyIzEzOs/ZzHZVbpgglBHT0uZeWcExAmeTGT+JF0RFnOaIoVDk2s579CFLS
         av4aeKCWp/Uwm84ANuTE/jKZKYTEYRAUzhHHJQzGT5QcxR+zYGJS3PZPojXduV+HG6N4
         YhF7gE+b+QkvBqDL5csL854qJ11P7e/r9nM7sd4RUkiyAgJ5GuO+wFWi8qd7G39urk+h
         Jvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609156; x=1779213956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RfjYyrC6spm2x8JAGRUw1pw462UyLev5bm+sj6Pl6Ug=;
        b=UKWy4NGVLu7s4Z+wV+JFQge/+P0QIhPJ+xwhiirlr4Fa8AopTxMi7Bl1HRniMa90jC
         647uISE9kmwFN0rmgYnbacQ3glg4YyJLHP5xqSTPplZ9A/cWmVV65Bfv2aV0mL6onKYC
         O6ahu1Nz6E16vJZ39SSHkvll5xmqfnGNukkPwIeExXFecH4AtZIc9p8t1YabO7+yJv0O
         PPoaC5ZiFtlL5PDyEvltui3NdGWkOK1NHzRe/JzP+2igJRPZdGyNXnKfkGrBZ/+vdElH
         RaF2sWJwmYocgFIVUtXv5HRHTEAmdR4VspCWkLT00btU9bBtv43JlmaqXhy6fUPBoq7E
         dOWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pNhwrC1rrV7JbD5tuWHC+yFskx5bWosKQ6Z5fG+HyyJvk56m+oAkfNEjZooMvUTF84HbpWqHE@vger.kernel.org
X-Gm-Message-State: AOJu0YyPCb+pmtv/S13TLhei8AtntXWZ3/HRzwqwaVJH1E3tQyLTmW2H
	zdCZFBi2z7TUhmSZlpVzfWI8rg1UGaWflQEzlcfiu6v8WB0sKNBF1chyWNHqtvJxiFwQyiZKyMW
	TtqxSe0mGJqx6Ie3KsuCGGcQOzdfT7m4=
X-Gm-Gg: Acq92OHy7wS06QwL7dzFnKz7cCP1sq6eItR00g+AUuwb+0XEa8ZqMXi1EuyAOBwPMmT
	51pLx501HmT/UFkuNAb6NGZoVNptTFg/B3Nx4ateazj+jCMFjsu7IJ5vczzawOJdHsZEC9ras7J
	Io+HUovPYtX6tapaQNLxd7NwKXJZPeFOaBw8g0B2o4HLD1lVTanOdGCd5l3UiL2hlYIkowTYZZp
	XNZqHG7DQ9CxxAc3FAYeD1OlB1d8N7YYha0TCjCn2TGSZx8ibTvfHTGHTEKcSulYuILhIw33hSO
	mS5Y
X-Received: by 2002:a05:6512:23a2:b0:5a8:a754:f9d5 with SMTP id
 2adb3069b0e04-5a8ef99d5ecmr32458e87.39.1778609156169; Tue, 12 May 2026
 11:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zf2nsl6g.fsf@redhat.com> <20260428213444.907701-1-vmojzis@redhat.com>
 <87qznxsxij.fsf@redhat.com>
In-Reply-To: <87qznxsxij.fsf@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 12 May 2026 14:05:44 -0400
X-Gm-Features: AVHnY4L_t9HTClAQOWTzvaD6esl5UtJLAAkCzNXQhy6xvdXHRPqb7JscxboYh_8
Message-ID: <CAP+JOzSwySZZ_opCmRA9n+mOnXbuS9MY1TLJHBKoWETqBv+BqQ@mail.gmail.com>
Subject: Re: [PATCH v2] libsepol: Fix memory leak in role_dominates_copy_callback
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: Vit Mojzis <vmojzis@redhat.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 9:35=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Vit Mojzis <vmojzis@redhat.com> writes:
>
> > Free memory allocated by map_ebitmap in case ebitmap_union fails.
> >
> > Fixes:
> >   Defect type: RESOURCE_LEAK
> >   libsepol-3.10/src/expand.c:828:2: alloc_arg: "map_ebitmap" allocates =
memory that is stored into "mapped.node".
> >   libsepol-3.10/src/expand.c:68:3: alloc_arg: "ebitmap_set_bit" allocat=
es memory that is stored into "dst->node".
> >   libsepol-3.10/src/ebitmap.c:420:2: alloc_fn: Storage is returned from=
 allocation function "malloc".
> >   libsepol-3.10/src/ebitmap.c:420:2: assign: Assigning: "new" =3D "(ebi=
tmap_node_t *)malloc(24UL)".
> >   libsepol-3.10/src/ebitmap.c:437:3: assign: Assigning: "e->node" =3D "=
new".
> >   libsepol-3.10/src/expand.c:831:3: leaked_storage: Variable "mapped" g=
oing out of scope leaks the storage "mapped.node" points to.
> >   \#   829|                   return -1;
> >   \#   830|           if (ebitmap_union(&new_role->dominates, &mapped))
> >   \#   831|->                 return -1;
> >   \#   832|           ebitmap_destroy(&mapped);
> >   \#   833|
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: Petr Lautrbach <lautrbach@redhat.com>
>

Merged.
Thanks,
Jim

> > ---
> > No changes, only added "Signed-off-by".
> >
> >  libsepol/src/expand.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 5b2b7b03..c7978948 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -827,8 +827,10 @@ static int role_dominates_copy_callback(hashtab_ke=
y_t key __attribute__ ((unused
> >
> >       if (map_ebitmap(&role->dominates, &mapped, state->rolemap))
> >               return -1;
> > -     if (ebitmap_union(&new_role->dominates, &mapped))
> > +     if (ebitmap_union(&new_role->dominates, &mapped)) {
> > +             ebitmap_destroy(&mapped);
> >               return -1;
> > +     }
> >       ebitmap_destroy(&mapped);
> >
> >       return 0;
> > --
> > 2.53.0
>
>
