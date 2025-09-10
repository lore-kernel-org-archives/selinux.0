Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A6833438B
	for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520472; cv=none; b=T5fDLP0wYODvZl+eenGHBHG1PPZYfoQHEOh76wbl6ewoLueupQqIpu06YJKc0yjSgysPxObT1W8ntfTcTJwbTTBk979PL0lMHA5vUsKqbu7FWiH7LjZHzhAqAJacb10Z7MZGDqVam3Q++v3QfjTpv+k+JUblwLT3+Z2LbWI1Ci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520472; c=relaxed/simple;
	bh=HOpvpmMa+n6+PJV3cMnp4V2y9/s+jwwW12vum25tD+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHrTsqQ7+b5BQmup6gsU0G3/n1gM6JhX1JakQCHsJi/UQw8XBBGaSQ0ClQfjV0/bwQM1+Y4NlzvZPvU9xrislBkmr0o7YGvi4bYHRAU6LEz3+bTRW3eV357BPzz2d+B7WOPB0YxepINpcsuQaP5AIPDis19qnm4bD8kO4aefhgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FpAURq6c; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FpAURq6c"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5932411a12.3
        for <selinux@vger.kernel.org>; Wed, 10 Sep 2025 09:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757520469; x=1758125269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLWqlRoMr7wcb02ZukmR6IJedBz59hQJwZhzt8WRM5Y=;
        b=FpAURq6c5lfuaUq3gr8JehJsXKlwh59moYSx+j+L1ZNPs21BaWYrNtx1xw+J0KlzzW
         taFpnJgaoJMCtq8Uo0GdD4c1W37B5/0wdMJAfpUpMDU6b5l8174V7nwmBCV/oSiWRhvO
         p/CL/cvx2anSBHSM7MEza7nsf9VQPEskSmJV/ggH3YNMwWFtOEWUZSZjUj4DPfjh+Kx4
         of1leET7rkP4P2zetoBfk+SB1eYghAZZXKu2yuDW/lfVc1bkjbgjT6gOGs/mOs3dI4Ov
         GNqdPLAvpjQdxZqxo3ajrfPSz8VmYhnkEVKp+wZmJOv/NpR9AFJwEqv3MlbzoifAj7Mw
         tlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757520469; x=1758125269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLWqlRoMr7wcb02ZukmR6IJedBz59hQJwZhzt8WRM5Y=;
        b=DhJkdwE0yF1at1YqBLbLbrJMCzHOtxmndkk7u5JWoWvaBU5l5aD754cwktZHxkFqIL
         WO806heRX42UjeF4JNAEoTOMVDwTjCJsEG4vw42OUjMdNUESRxRO9zrwxT92Rx/XiOMg
         Yslpxm++HW/gupszCgsJcqiJjhjYY5rHnsAG+tyn56dHzVmRHUzUbVz2K9bQmhNzuXjo
         e6TrKzXqTrXslqjP272fhQVMFxhXKbw0PXk1RamToYiV/vMUH5q36YCVg1F/nvctCyng
         MmG1sGYO2bU160NAD8QsNR8ch5jfvLJBxjJEEZhZAhl15yIWpVYZ7cweyrcvAyCs7NYH
         4/HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGBajH2l6HqpIvpB2YgCpuZrm5636BhV0wYJrgAnD6MowoZzGCcTEuD0IewIZEpaish3fN8pM1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxym7QWkP9s3IqbADltNnq5VguR/Nz+9V0H4eMjQdMYHs7xQIk
	3OqMpIldnj4IBii4ch5XENlobuMyK7HwRM+hpObcoQFxfU8YZZ/ERZibxUmIefAb5d7UwqKVZao
	RVdknvkoL/0wdwVPgZYnlnODHmqx+Ub39jvULL5N4
X-Gm-Gg: ASbGncslL7bmedVrMrCeqEsEo9QLP/H83lHuuZZtF486nYsqcfpXPMRLMC63byXPFX3
	E014BE1briSx06jhQTWnsthXYpDLdsWFFp00SmijfixSE87ahnHTf+36k4g9Zu/zysmxkCYmO/V
	2JyJ8CO5pa7NaX5EVkz/PFh5EInCcy3cAWoonTYHslQKfwuYL1W1dli0Lp5Tae09AlT5eQHkuqQ
	CY6nVJlraGLuTkUHA==
X-Google-Smtp-Source: AGHT+IHpguB/BnkKHnH9zVjz6Dr8b1EHthri5eX+Xap2TuGmjLAnouAEbwh8yMIc+3LeX6BGg1JCQf54aJCfte2vL2M=
X-Received: by 2002:a17:903:1111:b0:251:3d1c:81f4 with SMTP id
 d9443c01a7336-25173bbbab1mr262547035ad.54.1757520469496; Wed, 10 Sep 2025
 09:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909213020.343501-2-paul@paul-moore.com> <CAEjxPJ73qtdeTcv40gdj2tPJOSRC0VzGqEmHCZv6CwNz4AZdTQ@mail.gmail.com>
 <CAHC9VhSg6jsO8kET1qMUNUkHuWJ9e8UJb=Q75VmCv0kEzwk0Fg@mail.gmail.com>
 <CAEjxPJ7-1MdtcXaeTwH7Z-uPV2Mt++5NTGRWx6u58xKieH-G4w@mail.gmail.com> <CAEjxPJ72F9PsdWo_XBL5XDABYwZFJh5-TSt1bp3toLwgoLchkQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ72F9PsdWo_XBL5XDABYwZFJh5-TSt1bp3toLwgoLchkQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Sep 2025 12:07:37 -0400
X-Gm-Features: Ac12FXyp8ZbxxUh6VWFYU31cgMgzuH75QcFuGKL7vLWXvrriBeUZR2CKjt8gHow
Message-ID: <CAHC9VhTXR42Ogr-aS6OLHTZfW2vwBLtAcSqW7hJ4-0FMZfC2Kg@mail.gmail.com>
Subject: Re: [PATCH] selinux: adjust the !file/memfd_file error handling on execute
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 10, 2025 at 12:06=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Sep 10, 2025 at 12:03=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Wed, Sep 10, 2025 at 11:57=E2=80=AFAM Paul Moore <paul@paul-moore.co=
m> wrote:
> > >
> > > On Wed, Sep 10, 2025 at 10:05=E2=80=AFAM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Tue, Sep 9, 2025 at 5:30=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > >
> > > > > A prior commit, see the 'Fixes:' tag below, added support for a n=
ew
> > > > > object class, memfd_file.  As part of that change, support for th=
e
> > > > > new object class was added to selinux_bprm_creds_for_exec() to
> > > > > facilitate execution of memfd_file objects using fexecvc(2), or
> > > > > similar.  This patch adjusts some of the sanity checking added in=
 that
> > > > > commit to avoid a "silent denial" in the case of a kernel bug as =
well
> > > > > as return -EACCES instead of -EPERM so that we can more easily
> > > > > distinguish between a permission denial and a fault in the code.
> > > >
> > > > Technically, this doesn't make it easier to distinguish because we
> > > > usually return -EACCES from avc_has_perm() and friends, but return
> > > > -EPERM for capability denials and in certain other cases (not alway=
s
> > > > clear why, arguably a bug unless we were just replicating the error
> > > > number for some existing check that also returned -EPERM).
> > >
> > > It's awfully fuzzy from my perspective.
> > >
> > > > My
> > > > suggestion to use -EACCES was because that is more consistent with =
how
> > > > we report denials outside of capability checks.
> > > > To actually test this, would need an updated libsepol patch that de=
als
> > > > with the fact that the policy capability number changed on merge, o=
r
> > > > re-basing the original patch on top. Otherwise,
> > > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > >
> > > To be honest, this isn't the sort of discussion I like to see for
> > > patches that are merged in the -rc5 time frame, if we're merging stuf=
f
> > > at this point in the dev cycle we should be past uncertainty like
> > > this.  I'm obviously not going to merge this patch and I'm going to
> > > drop Thi=C3=A9baud's patch from selinux/dev too so we can sort this o=
ut.
> >
> > Not sure it warrants reverting Thiebaud's patch. I was fine ack'ing
> > that as is. I just thought we might want to follow up with something
> > to improve the error handling here, which can be done anytime IMHO.
>
> And if we revert his kernel patch, I'll have to likewise revert the
> libsepol patch, and the policy capability number might change yet
> again before it lands.

Yep.

--=20
paul-moore.com
