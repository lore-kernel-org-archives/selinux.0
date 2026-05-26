Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3C2868A7
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805196; cv=pass; b=l1a50mWjt2lqyyAp6oaJIft8sAxGuXrpVpnHK4IToaFj+rTYtRudaVp3kumJTQZ+t2HJYojzbh8oL6fkoIOMuUdx/Yv0fi+WLw7GytYhgc/8q8vfJ9UggwF50p5IMi5T/zGjLGW9mmRK7wiGBAK17cEbSxkwa7YuVmID2SV1rRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805196; c=relaxed/simple;
	bh=g0bD3csQKbNphzf2Q7qZg2h9MjDQzUb6S0UgGFuU/6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyVBCILzTrKgaGTJIQ46LYWjZjfr6EKmKQKg4xW2pWPYNGZIPdLtZXVzU+JMC9r1ULpNL6o0lA70cpg62Aa6tU2ObXpfhJfBSU4yQYCleOQvEfMlUW5rxqh+mg/8F5ENWo7c8FuQi9qb6Uq9udplKEhbXYjxsyuhkXQPjpGLEcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaFvEjkE; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaFvEjkE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so5961943a91.2
        for <selinux@vger.kernel.org>; Tue, 26 May 2026 07:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805195; cv=none;
        d=google.com; s=arc-20240605;
        b=PS4sT1MvEmcpqPLbpsU2gsnrNT/fxw7poS/oulxWBz9OaJ0TXiDNadgA3B/VMYtdpV
         B5fQ5RhdbazkpxOsFsnk9NKJQie6F01YD1lxHtPUunotzLqyJorI+H+xFauqNb7ZZbLH
         F0d+xg05K0OHTpY0ZOm6ic9PNthX4nBwho3MwxGWARPOjREfi188OTaV1mvmKrPTGU6w
         6QW48ar0OJweZgJXPjSC/r7BlUvI3Z7o6Gygofpi+gduUk+algwsI1914ubXEGgW5bu3
         NOklhfP5Eau8F+yWe5UXyb9vyCevJ26drhPvi+4XOUtizZ8rULqt+la/tbepRjX2gp8b
         jlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SQxTArx4dt+TcfNmxAsT/y1Np5GFA3KuP0+rkv8r8iw=;
        fh=m2dpDAay7t3oBdtDq/iACj3Wi14bX1b+w6l4aB58TUQ=;
        b=brll9MM6NdYnqqoRjtJDEtt9t38Ykco0j1P5l1bvHuMennfPuIYs/hL3fCitZ0DEkA
         nAP3hj+oEMyAHvj7Te4szle6oyXc/nmDcnByohR0kwZAAizm9NcXJkpFoZNvOVHhtqTM
         nQ1qgNpYq3uqQ6QY3rdEasT2gqT172z/6xHHKLhLhIfT6aTqVos2HjtXGhDpO7btpp9E
         QdouE4jCEf7BKHRcmPmUtTZphWyjkaWaisuhjpYjcQD/HUH11MRNjAuj9nZJLmLiu5mV
         gzJVqigLUkIy/xrcKYMW3aKX2jcfj4Bg2KH3qcRB7zUTg7ZPU/erMUS6TB8HK8v0zhsI
         AYsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805195; x=1780409995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQxTArx4dt+TcfNmxAsT/y1Np5GFA3KuP0+rkv8r8iw=;
        b=JaFvEjkEw3Ipz/Zpi0EAaIH5vMRzYFWVrc2KvPkXpmNl9aSbNrXQ5gcSy/hs1Bu4f7
         JyATpxc/7e5oVujHwyhZnSdhiRjNaT9DqRqf5hKW3iSnwmFRlcw91mAi8N9Ak3EqD5pD
         2/GDjaSLrfeL1KH9c++BB0Im8pGlLMNe0DfFslA3SB9WzQHcwlTYpWHUrf1rqibxdm3A
         JbF1TgPPL5vwrsefFfQaR1uazMhSEAMuvwErWvoWJuv3Xr/sWf73q0KOWbUYapEJWN/k
         ejZIOhHr/gBZI5aWzvuaukFkE2vpbY5bmtnDjdEqr+offOF4Fu1AInOZMOLNyWQN2rsN
         lHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805195; x=1780409995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SQxTArx4dt+TcfNmxAsT/y1Np5GFA3KuP0+rkv8r8iw=;
        b=smcIW5Lv3qGEGd1T+l+BA+9WOzBOeT/5BGnvKtXQjBMCkHxRGGLTBHHkfmNXFP+tHl
         FlzZ9P2uMyOKIh4onAUNOPiJdHprPCJHV2rpwQj0w40xcGJylHAqe5J449QR7S425g5g
         /adbfvlBrIujPzCDCv/T/wgOSBaXEwa/S6ZvAXAkfa/A+yBLo1RvHpXCi9GpghoFMJuq
         rAx5ox74pJ54P3WO/RrCddP0haJP8O2Mpe3fsL57Vhdkm+VXjaC1NQqsmS2cwEEjacFa
         KVqqLcAoBs+lAczC2q1xRNxOMKIvXsTC9j1+ocBn4vkzASxBrakzh+HZKXlYouZzzoMI
         j4BA==
X-Forwarded-Encrypted: i=1; AFNElJ8Lev3BA0FwUSRptxuPgeZfKRvivTPS0H3zPXysvpk7+FAVmFLLDhJjaUdomj0hjBDkn55LsOHT@vger.kernel.org
X-Gm-Message-State: AOJu0YxV02bnbYc0Y/z8qn95l5KUN1/peslEXCNStX8xh2/xKcqdzfHQ
	gLwBG/8p2nnsuD6YiDcaKhSlO2OPT7WBZsefxTlAe9VWjmlq9EeAf9/0yeLY1PAn5ssNRrcJ3AA
	g/4/zeLKn00hQyyegfj/3Upv9kWtcQT+65A==
X-Gm-Gg: Acq92OFI8tizhhyZ1rdcRZM4zMpUifv0xPXt+vCKlYIPxvN95iUwz6OmzsEyBIoCdyQ
	CKSFoRpd8RHK51cR8Kww6ap5snsS+hvtepjLkUlZ61IVbJPl8Ru/mMWyIOQDiifRs47Lz0tnwkM
	tA1JKs/yUGFg1Fj+phy3+xeNcrNCsgVokGzQ0mJR22+lsSKtwunDg4+BPb8TxCgTyi05MWsEQLL
	81pCqQANhg8+J61A2bMac7c/waq9NP98pMO5f9xrJa/S7b5VWchiN+KfEKkY1sh3hcce3hF+ca9
	RbZEWvY=
X-Received: by 2002:a17:90b:560d:b0:36b:12b5:e720 with SMTP id
 98e67ed59e1d1-36b12b5e9dcmr2042005a91.5.1779805194919; Tue, 26 May 2026
 07:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519122401.156311-1-cgoettsche@seltendoof.de> <CAP+JOzQ0LYoYStegKak=oS2egG=QQLNYOezhXgXtLPantZM16Q@mail.gmail.com>
In-Reply-To: <CAP+JOzQ0LYoYStegKak=oS2egG=QQLNYOezhXgXtLPantZM16Q@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 26 May 2026 10:19:43 -0400
X-Gm-Features: AVHnY4L4HcYDFDu-43_knKOxdROsRv8u-wRp_HNGr4lebhbYDPT1zk4ncF4wzzw
Message-ID: <CAEjxPJ42UBmsiKEVhQM=K=GSauTjib3RF_xzzPnEwyTJFCSiEQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: link xperm rule permissions correctly
To: James Carter <jwcart2@gmail.com>
Cc: cgzones@googlemail.com, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 1:34=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Tue, May 19, 2026 at 8:39=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > In copy_avrule_list() the class_perm_node_t::data field is interpreted
> > either as a permission bitmap (for AV rules) or as a destination type
> > index (for type_transition/_change/_member rules), and is remapped
> > accordingly when linking a module into the base.  Extended-permission
> > rules (allowxperm/auditallowxperm/dontauditxperm/neverallowxperm) carry
> > a permission bitmap in this field just like AV rules -- checkpolicy
> > sets it via `data |=3D 1 << (perdatum->s.value - 1)` in
> > define_te_avtab_xperms_helper() -- but the conditional only checks
> > AVRULE_AV and so xperm rules fall into the else branch.  That branch
> > dereferences module->map[SYM_TYPES][data - 1], where `data` is a perm
> > bitmap rather than a type index.  When the underlying ioctl/nlmsg
> > permission lives at a high bit position the resulting out-of-bounds
> > read segfaults semodule_link; when the bit is low the read silently
> > succeeds and the linked policy's xperm class_perm_node->data is
> > overwritten with an unrelated type id.
> >
> > expand.c::expand_rule_helper() already discriminates with
> > `specified & (AVRULE_AV | AVRULE_XPERMS)`; apply the same condition
> > here so the perm-bitmap branch handles extended-permission rules too.
> >
> > Reproduced with a modular refpolicy build that emits allowxperm rules
> > into non-base modules (XPERM_RULES=3Dy, MONOLITHIC=3Dn); `make validate=
`
> > crashes inside copy_avrule_list at link.c:1298 and succeeds with this
> > change.
> >
> > Fixes: 58962eb3d847 ("libsepol,checkpolicy: add binary module support f=
or xperms")
> > Assisted-by: Claude:claude-4.7-opus
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks, merged.

>
> > ---
> >  libsepol/src/link.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> > index 188b4020..de964c92 100644
> > --- a/libsepol/src/link.c
> > +++ b/libsepol/src/link.c
> > @@ -1280,7 +1280,7 @@ static int copy_avrule_list(avrule_t * list, avru=
le_t ** dst,
> >                             module->map[SYM_CLASSES][cur_perm->tclass -=
 1];
> >                         assert(new_perm->tclass);
> >
> > -                       if (new_rule->specified & AVRULE_AV) {
> > +                       if (new_rule->specified & (AVRULE_AV | AVRULE_X=
PERMS)) {
> >                                 for (i =3D 0;
> >                                      i <
> >                                      module->perm_map_len[cur_perm->tcl=
ass - 1];
> > --
> > 2.53.0
> >
> >
>
