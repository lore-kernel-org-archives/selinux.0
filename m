Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4623B8248B
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197505; cv=pass; b=OjWyzkS2LbFAUiy4vwfDX72shuevOf65WxT0Dxzvat2uNrc/vGaTdncBIDNnFsBc5cmHXNgRhjnKp9BoOdu57NpEDWyJIC2nknYJaKJz13HrKwtuyVhMkeB1vKSjTSpUF6JMx4+uNufJM3cEQaHc+mEcpsfuX+Vqni8CYzGi9Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197505; c=relaxed/simple;
	bh=JrVvjzG450PzvNyf/uv0OenN6N9UEI9p9CkpDcnTaNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdBFVc8mlS8ufJorNiCyFBab2Ofav77U7H/3knqCtguG8maCDMhxoX4jNDFbb0haQa3kbLhHPiKBymHhekzX40jG8tQrBlOER8ndMdydbBxpUOxgvQL5j3X7ZKoyjJ8NrmNHzrdadLqMHVxSWQEIU4E1DdtYUt2nG6LCIECqSE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gafU4BqZ; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gafU4BqZ"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69ffb48d599so2322186a12.2
        for <selinux@vger.kernel.org>; Mon, 27 Jul 2026 17:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785197502; cv=none;
        d=google.com; s=arc-20260327;
        b=SSLyN7Sdo0BV04FQ7OUHzj5ih8UGaJMU5yM/33E3k9L8N6uh4+VW0bbLw3tkoo191n
         7TvJQtDjyYS/gnS7qJAtCroi9YseDs7oqTR1W3EAkVN7nDACn+ssYUUATu00fHgDB7IA
         1pSvpc5psRvG83YT2IQbcDgFDmeYgwUEz1OF8W2W81SvvYXL1FGht77x2HofuQ8NGGUd
         bWKQD5DhgbIT7/bCqtpEavHwoUnZvaLccEJ2UB10yoMy6eaCi7so3wtGkMfuno04TIro
         SEqAiaf6bus4gK7AJ1jbXQaWzUYIrINJpUZW29C0OAE5JwSJotQxufSdcllUF0Jgs2xF
         cA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hixt6dppLCRGC3qP4/jXBkfDwvNYTYa+nAUd92TQqiU=;
        fh=BLmtxx2D7rfv4Q26Onn+nFBhgGMdpH+yeuI6ZwHcakI=;
        b=kCs/t4e4HIyRgFD7YjC7UIKqmY91ASK8vAL1J+RErMq/I7zYS6GzrCRFs5y2C9UD/r
         IxRINo+GP50U+mfExEgrkxJ+4xo832NLtP72RVfF8o6sZMZSZJPvg535xFsaGc6oXMMR
         wZv2UhGIwNDWhgBZjubSiF6HGO8tH7ZMUtU9jaI9jdc7u8KQekmVj+jYYn7B/5bP/z7B
         2C6S6Z5weTJbDAxbuUzdcmR9qjZMk08VwbEXxaoNqZxU9w0gtVF64OX+//8cPZKAgs1y
         fGqnuQZ7z2HQEOwUJrkcnjLbaVte4x+yLcx7lIQi4MetHLVnate7IQT82YsH2y28lEXz
         ymlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785197502; x=1785802302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hixt6dppLCRGC3qP4/jXBkfDwvNYTYa+nAUd92TQqiU=;
        b=gafU4BqZipyFy+Cr0/3IC0N1e9SDODaFzkJlrYpUF1MbhrrjThS63lFf/xNeKJu6uD
         lFHEG1IPFwnltURs8Nm70wNeTY7p0x+gOvKeETztdH+eeogwg2R3r+BCYY0uRHpFfSn5
         +iWFrXm+9eBuV8nfgTMuiKsY74kxkeCbHMl9fK2+dpVE/sqKwGojZ40wJENoOEy+gtbd
         AE0IdW8FE+cpoziUmGdLQ3vr/5MRabdO6n8uaDc4qaRZZlNHUunW6fmqIUfoGRr2MXYk
         4EGIBF/y3HNGN3dbcUBt97HAxiWEbTYPccsF/zoiwaxNXYlvjVnGZ6QTtxin/PbSVxSV
         EURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785197502; x=1785802302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hixt6dppLCRGC3qP4/jXBkfDwvNYTYa+nAUd92TQqiU=;
        b=PN2cMS6a7Bbf16rKBwhzY3yegSGHrSkZZzmGB7hea15swWGu0jDMJN6i7SDELUnuMy
         g2hfm1LQRzHxCrXsBTbCJsW16e3TG2qMnrZYpkgwseHmZLjEPQLiHdMiW2I3fS2A43WK
         bLm/yM8oOJ6DGtjHzcpiPQ2aCVRpVQbikP+p8BQkvGot2oZ1Ffw9k6UGNfhAvSQCyOSK
         uJWcAbT4lVt196pvSM/ATTc/ceNp7iRX5moKlMKFbtFC6A59mxkfEO61fjYzMXNMRO9e
         zWL+BXIStv4vboZTCPw5VSJ2+/6LV0jfNAGoBcJJZfLptkBBNjCabYEYsOS6Ztwd32PX
         yfKg==
X-Forwarded-Encrypted: i=1; AHgh+RrGtp61H7Iht92DYzardlDTSm6kOPjQkHRjukf77tMFOyar/bgMd+QH3CYPsyf7W5/c0y74n5FB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+NuC5cs5mSaOevy2Zg/xUwqTm7nPbyVvNsuIzrMS+6vtciLBw
	crsYllg3u2RdS/66xVOw8JJoWhw6b51YDnvLbuoObD6G4FRnlElrNEqiy3itpnzJOC6wFjXxetb
	ep675FwxDc+cD6KIJYZQMWPC5hA6cDmPTyPxSI/Hh
X-Gm-Gg: AR+sD11s8K4a0fwilr2ssVB46lxYRcsJ6JHzw1hk8yt4gUsYc7OAHVHXRej+hf5x7r0
	CI4IL5V+bJtOe/3cQdiD/8uBesWEL63xplSx6kvZTWPJx/MJyNEvRtJt4gHmwf+pbSSjZWtHfas
	zRI08K9Ol+IY2rYL1uouSMxBFaVsdDzZQndgAuAgfyqP1XXOPQuvWoAlaFgM8X/Pgulk4Q1JBPQ
	8QELzIf+t8065+M/hQNTo9bXlJ1Y3UR9/Th/dEe7hHlA5L7vI7jJeuYEQjWJQ==
X-Received: by 2002:a17:907:7b81:b0:c15:c658:dc0d with SMTP id
 a640c23a62f3a-c1f7212f768mr2752666b.39.1785197502055; Mon, 27 Jul 2026
 17:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-b4-disp-ec8ac9f6-v1-1-d76d51a69b9d@proton.me>
 <CAEjxPJ4_chAbtJa4obgN+QSjMnCwk9XQ-4bnyOFxgFoFxTsV9A@mail.gmail.com>
 <CAEjxPJ6pTrKAdhGFVO72x5117RkXCn9xKeqW9NTHfgi-6eaywA@mail.gmail.com>
 <20260724170714.71963-1-hexlabsecurity@proton.me> <CAEjxPJ4pVw-BzkHNbdKE7aOvCjDX5qpQA6UF_KADmhEhdkXExA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4pVw-BzkHNbdKE7aOvCjDX5qpQA6UF_KADmhEhdkXExA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Jul 2026 20:11:28 -0400
X-Gm-Features: AUfX_mzoSaB7CCgYAlaz0p_I5ko8yr01uK881S6n2upFMlIvzd-vtNNp6Y4nzQo
Message-ID: <CAHC9VhT4M2--c-ZGf+xPSRz-TiGLUnfmULNXcWMC2NgycufrDg@mail.gmail.com>
Subject: Re: [PATCH] selinux: reject a permission value exceeding the class
 permission count
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Bryam Vargas <hexlabsecurity@proton.me>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Kees Cook <kees@kernel.org>, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:11=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Jul 24, 2026 at 1:07=E2=80=AFPM Bryam Vargas <hexlabsecurity@prot=
on.me> wrote:
> >
> > On Fri, 24 Jul 2026 11:56:11 -0400, Stephen Smalley wrote:
> > > Also wondering to what extent this may overlap with this series that
> > > was never fully merged:
> > > https://lore.kernel.org/selinux/20250511173055.406906-15-cgoettsche@s=
eltendoof.de/
> >
> > Little concrete overlap. I went through the v3 "harden against malforme=
d
> > policies" series: patch 3 adds the value > SEL_VEC_MAX, nel, U16_MAX-cl=
ass and
> > default-* enum bounds (my hunk sits on top of its perm_read value > SEL=
_VEC_MAX
> > check, already in mainline), and later patches bound the top-level symb=
ol values
> > against the symtab counts. None of the 14 patches bounds a permission v=
alue
> > against the owning class/common nprim or touches security_get_permissio=
ns(), so
> > the OOB this patch closes isn't covered there. Happy to coordinate with=
 Christian
> > (on Cc) so this and a revived series don't collide.
> >
> > The review is right that this is incomplete. A class that inherits a co=
mmon maps
> > the common's permissions into an array sized by the class's own nprim
> > (security_get_permissions() -> get_permissions_callback(), perms[value =
- 1]),
> > and nothing checks the class nprim covers the common; perm_read() doesn=
't catch
> > it because the common's values are bounded against the common's nprim. =
v2 adds a
> > class_read() check rejecting permissions.nprim < comdatum->permissions.=
nprim,
> > with the A/B for that trigger. The sparse-value NULL deref in
> > sel_make_perm_files() is separate -- I can fold it into the series or p=
ost it on
> > its own, whichever you prefer.
> >
> > Correct on CAP_MAC_ADMIN too: the precondition is the load_policy permi=
ssion
> > plus DAC write to /sys/fs/selinux/load, not the capability. That line w=
as below
> > the --- so it never entered the commit message.
> >
> > Thanks for the ack.
>
> Ok, thanks, will defer to Paul on whether to just take this patch or
> wait on a larger one.

Considering the privileged nature of policy loading I don't think this
is a "OMG EVERYTHING IS ON FIRE! situation, so I'd rather fix this
properly.

Bryam, it sounds like you have a fix ready (or close to ready) to
post, would you mind posting that as two patches in one patchset so we
can take a look?  If we all decide it's better as one patch, I can
always squash the two when merging.

Thanks.

--=20
paul-moore.com
