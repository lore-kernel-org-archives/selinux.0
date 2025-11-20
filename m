Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF5A2BE65B
	for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763679448; cv=none; b=VgBMhR8j5BPLZHpuSgfaEvXsbst1ZxpQr4QKNh+N+pOaLYVVX446V+Xc/RahYEWdp4NdJqxW7K3lfT1vFx1+lOmiXVQhVIJ0PaYc+LlPLgPgTFoIgZSsszJ9R8WIUGQ+tjceK9YJdCYg8k9+IfOtutvpNto8D2OPTowau11f4AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763679448; c=relaxed/simple;
	bh=qQ4PvmQoNFQK8TS8TRADFAM7d0Q/RB0S+0o7X97mJdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUrVjHT8ttjw6yjAp7pKuopC/xfObRaMGkmCkSA+O+503i8QrurNzDgRKL/nUOKyWxrrf4a1lO0PQqM4PJ6b32qzLvgeluCNcP+Hf7upFZ3vxLCfJ1tL1JwQ7CPTqlvTgWnuXlNKZCp+jlMEJ/ySkxAiLHd9A7CUUDG79Zeq+4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W5v/+Vtd; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W5v/+Vtd"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3436d6aa66dso1356893a91.1
        for <selinux@vger.kernel.org>; Thu, 20 Nov 2025 14:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763679445; x=1764284245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r250qwM/sjsPhWniak69NdHr2BPUfxih4zgZ6cqynZI=;
        b=W5v/+Vtdf8M3E3U7RVbdE71jxsJ0xqL/zBt/pCYkxSFgRP/wYSeLBH4X9hhnKLRkEs
         WUQUX/h0bJz1J2VSd6XAjkP9p4zodKG3Cj/ChGd65xaP9F1UupY/3SKASCQ6veSSkejc
         dH5GntYBBHbom853Zv4b5PX3HtvHmMJIk3TGbwKFJnfgJUcR+WliXf1816RCtwoQZ69+
         98/AwjD/b0sq3UmMkQRxQVIGrx7qfshbVviyNh5kjySGXpuncNZIwX+jcaZbN/dCHnCQ
         DP6qqCz6xFivF+XCP3/jLK/62lB5+L/4FwX4ay4jjWIOgZT/iJNBwtgjgp21SIyTGNFF
         j/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763679445; x=1764284245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r250qwM/sjsPhWniak69NdHr2BPUfxih4zgZ6cqynZI=;
        b=mK063mHDf+C7pKXyEgf3ytlBPEh8SY5LNQIoAxAEX4B8WLsCZK75D4b3oN+X0XGtLK
         65dvSGYl8KX9qFBIqBfWBiD1QVsg9NgSN9W5GaGOWFqA8ddf3kU6+kiwgnhDvAbGF542
         ul41tY1cADtpQHqGsjy2QqzrsEdHqFYRSaUcqJ4DIpgo+XlgUA976AA48fTH71DoqssM
         XTOA3DkmKv5K/JxlWmlonTnEICYnloLcJwBt5cdPGuI2jiDRfb0vvb7FBgw01g14BAqW
         opPgkegGMGLkCImq631fOPQFDEs1PBqY+hb20U7HuFNGOMp4FDJ4N0I1tt+ki2a/xpIP
         /uIg==
X-Gm-Message-State: AOJu0YzKnWv8yUKUDGdRa5ShTzi+57tKlcn2/CBYPLZ/IRR7KBy6fccU
	MoKOi/txWJoVkALwr7FxDpzfO0B7hUFydQmUWSY8YlGevKbOJTJiBZwS7xbk6vOiTHuVs5GviE2
	JEZxSPKBTfPJVjQRR28tgMGtqSmzSgDrJjhR3q6JZEJsJ0XKHUN8=
X-Gm-Gg: ASbGncsUKb2YNtvr2orEM1J1HC+/O+VfoYkhQvGtsXVAcpbJenEqOzYVSwYoqlS9r7t
	iUl3v0d5R/8saAjj18iL/rMih5I8Ca9m29JpcTjcCdBx/YSoO9PLAQetX/ZTDr1QTYcMSDex2c1
	5iiW120aUw5e35waVQoWavcsw4d1VFsGAsfmLxz1n7kVBv1bYCjDioctVmPTSr/ZHa8totYHEMf
	DNfKafraBuCb677Nd0lguv3kVrtSx+pO/9/0s1+kx7UvFfaq3Khj/7mUIawhqRmz3mQT8Q=
X-Google-Smtp-Source: AGHT+IHmdF7yEavBCvH4ASbuLeH2nmrkb5JjLyq0VeTO/iw9ohaQMcAOHlt3i7kODJf+3K8mM4aaHz19D3ATybrcEMM=
X-Received: by 2002:a17:90b:5626:b0:343:cfa1:c458 with SMTP id
 98e67ed59e1d1-3473346ea40mr315807a91.18.1763679445490; Thu, 20 Nov 2025
 14:57:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119195628.184825-4-paul@paul-moore.com> <20251119195628.184825-6-paul@paul-moore.com>
 <CAEjxPJ4cy3zarsytxGV65+mNh7ikbt_Le_4M-m8YV0QqvgdRWg@mail.gmail.com> <CAHC9VhRaWn_Rdh=EtiNKsFJu3KKJuVqoNN0BEQg_4wV3yNnTcw@mail.gmail.com>
In-Reply-To: <CAHC9VhRaWn_Rdh=EtiNKsFJu3KKJuVqoNN0BEQg_4wV3yNnTcw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 20 Nov 2025 17:57:13 -0500
X-Gm-Features: AWmQ_bnFOe6UTjvZf_aqqgxqyDs9PtKELnLevTXLjG6JUryJpcz72GTOIi_3t2c
Message-ID: <CAHC9VhSVa1YkWaYdP9dXd8VGvQn4weZrPPDwOBJs=zrqtkiGag@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] selinux: rename the cred_security_struct variables
 to "crsec"
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 3:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Nov 20, 2025 at 8:57=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Nov 19, 2025 at 2:56=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > Along with the renaming from task_security_struct to cred_security_st=
ruct,
> > > rename the local variables to "crsec" from "tsec".  This both fits wi=
th
> > > existing conventions and helps distinguish between task and cred rela=
ted
> > > variables.
> > >
> > > No functional changes.
> > >
> > > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >
> > Just re-affirming my Acked-by since this patch did change.
>
> Yeah, normally that would have been enough of a change to drop the
> ACK, but since the change was exactly what you had described when you
> provided the ACK I felt it was reasonable to leave it intact.
>
> > I confirmed that building security/selinux/hooks.o before and after
> > this change produces the same result (after stripping the object
> > file).
>
> Thanks.
>
> > Not sure how the stable maintainers are going to respond to the two
> > renaming patches though.
>
> Yeah, we'll have to see.  We need to fix it in Linus' tree regardless,
> so the first step is simply getting the patches there.  Unless the
> patches apply cleanly (which is somewhat doubtful), the stable folks
> will likely drop the patch on the floor and it will be up to someone
> to manually port the patch and resubmit it to the stable folks.  First
> step is Linus' tree, let's get that done and see how it goes.

All three patches are now in selinux/stable-6.18.  Assuming no
problems in the automated testing I'll send them to Linus tomorrow.

--=20
paul-moore.com
