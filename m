Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AC4457A6
	for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330413; cv=pass; b=IEMudspYrxbcvq+c42+PaGCQ0+L6T2ELM9lK7mc+B4F/5oj3YIAcY+lqfwd995lXFcryzDNIU7CB6NjugrnRM2XACAH1qWrJJXZXd1pKxtX6HNX9bMFLm2PiaR6qRQDVYPzI1LyxOmRKHaZuErBRvps2MbtMLxqzNS4VIQ4BGg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330413; c=relaxed/simple;
	bh=I85Kz8awt5wgrIO3lgHrdwOKN8fr3CLC6dymsmgNuIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSWnEj3kTpBarSEzNk61tQZCZbCqCFflkLhUr/a77hWXnIa+NM8fUwv0BJLWtWfljTFQpL3tdhGsjKLTghWAmqg5onQF2LxL1Dxlc8x8PW/lv3za7ai+uMPcXBnZ+/in52PgomtgnHnmZ75umDZV/w0aeME7tYVB55ODD0mMwqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVXwqYYk; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVXwqYYk"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4518ad44e83so562170fac.0
        for <selinux@vger.kernel.org>; Wed, 29 Jul 2026 06:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785330410; cv=none;
        d=google.com; s=arc-20260327;
        b=Xo5FOKbAOZC8uVKyauXx2Y5sziIoh2yVzxxid3Zytug2H+c0PA9D1Cn5GkEN4mhvqF
         dgrYRq/9744QqqjMYlvRj/oiB+r/rqXr0xWe0LnobPLN+OWyQg/VZG+H4jSzzYVf2BF9
         m2fnaTtJuHnVc/f569owHtpL3B/F7EEvPfVeKQ0AOvEM+b++rcLaehC2drgAiHT9v1DH
         CY2ifwATlItQXD3eSEQTh4Aw6ROHJLHifMDXCZQoKYOWIiu0rjnJjxccN8g2leD582nf
         LNz35SRdRGq1U8D6DZHCEUvLPBdO2gL+uZ5C53GI1niqCMXQJGwedgSYZiri/bSEydUf
         7sIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I85Kz8awt5wgrIO3lgHrdwOKN8fr3CLC6dymsmgNuIU=;
        fh=PQW2+EFmpWBtO81Y9GXw7FUXUmmIfFgRGhdldCcDDpM=;
        b=p2JA6iBtLz7VZgsOGHKWjj4/YwAoTd0jAF06N+h9zEipwLZy3HbVa5OzQh0ndLhm7s
         0mkWTtxtUk0pdtXCZJMogj4rP0mtXlBbpm2NJ/VwuXcAFTla4gqbOtfh8ql5PIxt/BEw
         dDcQMSEba2bCUHKhWFewzWAMMiVqZw7r/iiq4HAHEe/qA+Sw1EZNLonD7Isqu9U4F4YN
         oxaXDG+MnN6DloT0TOtysQQhwFZqB+t/blIXbPMyMCEfc8GPdtNo9UHoEXPzjU8rIUov
         QSglbfU3sJxSZKeFwI4ql0dOPUAqQof4NDR3UEaLy+r1ZV7EnUbi+lEaV4kz7F/bt+uu
         TbZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785330410; x=1785935210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I85Kz8awt5wgrIO3lgHrdwOKN8fr3CLC6dymsmgNuIU=;
        b=MVXwqYYk56SOTw54639bE7HLo/VSiNEX0ebtKFpSs/7woizEFYFNSlB6esjYlTal2E
         uSYRpe5+lFnGBLUPOmeDtyxzbhmzZe0BV5Mfe+OPZt9Mb8qRFG+sRv8P7qFOKmluofKY
         hphTFBgH6xQcE5+gC9TYXr7Ao8nzview8LyC/PI45KQyZR552H+GT/N0nUfjdspNVPJZ
         EdXqW/1wdgrDipa2S7e2a4fidnwTz2peAwkYUevTjUVth/t1vhIw2UuHJOgountN/TqR
         Om1FFfWwXwmrOjXJbCQPzhEKHMCfbtuDNbz5hDS7Pgrvn2HYoHkx6kbq/1c6JjHAKQtZ
         7h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785330410; x=1785935210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I85Kz8awt5wgrIO3lgHrdwOKN8fr3CLC6dymsmgNuIU=;
        b=HHRoAcgtpOQH/zCPB+E3KBGvCw7xqUYRPIVj6jyG9jkQ0fR/QlY9VErRpGuOc4zEmE
         dI0dzkysEw5MQ7p3uXfdKH4mlMhDclsN4yblgsXRbuzeeJY9MaHu1SA/jrNhhVQyE8BM
         Tk75iHUCWaYOOum/nALpt/e4mhlAmX498lb7Ypz87V+ZH6UzXQegPVWgTmC4y14xaZDQ
         TD2uufT9wTq/zxvAadqpK566/yro8tqvgjaKyr3voNbp1r352xEUe1hhHexRR7AZufNh
         2P6eAZL+OLY8xDODg9kvPpL/TMSnfMvOATvmERNgfE4iOCPTauFwS0RxT0N7ZERV+pvG
         RDXg==
X-Gm-Message-State: AOJu0YxmEGVTSBy97j9z9ov2vNPSwO3/FVLqheshqiT3DH9FOKMZv0Ra
	C+t175U4LyI5L2UHoG6EOcfyZV75PKpfn3EmH96EnZx1PoNP3qIrHO7JGPvcp67XydMRzH10edq
	BpVqFEy/0nwhl3FodyTIKF2lmVGYpAOU=
X-Gm-Gg: AR+sD10n03zDPwXELWszfTmiFsHsFF1fKyZtSzvzcTcojVPwoBsulmrDXP5DIpbEyZE
	oKnY2jV4s4IRuH4meE1jxLPG1zoEinMINKNAFN5QOdzf6+wDPNfTKzCGKz4YsEYyy6dLAYqlAhT
	gB+0+bR4wgx/fzUBmXJhOmnCCZl+XC3cAY4WHRt/l7Okiq/TFKPap/J1LhsSnLUEHhAC1WtWTMi
	R14JtMiZzbOPLiBN+apNHMmEocHgquVQExpIJz3qVKItBpSY+22OIqqTlY3IceQwEN+K1Kzwf5W
	lrX/D9ZNO2QDP2YSO9neplEHmUs7GeIB4aWZu+fVfUib
X-Received: by 2002:a05:6870:3042:b0:448:9d5b:6393 with SMTP id
 586e51a60fabf-4586cd19005mr3909524fac.14.1785330410289; Wed, 29 Jul 2026
 06:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723062355.3096648-1-jason@perfinion.com> <20260723062355.3096648-3-jason@perfinion.com>
 <CAEjxPJ7RsJoivrD+xr9qaC2znKkG2NxZCuMqNRRHVah6h2BwJg@mail.gmail.com> <CAEjxPJ7Xh0NvGJUm5YWVVJykAATGwZBHKfk=z_cSaNiG=LTkWA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7Xh0NvGJUm5YWVVJykAATGwZBHKfk=z_cSaNiG=LTkWA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 29 Jul 2026 09:06:39 -0400
X-Gm-Features: AUfX_mxbf3RVXQPr7VSxQzkQ18ZP7dXFG7N98TjayL0jKDHhGVN6qd9GAmDS_qA
Message-ID: <CAEjxPJ6Rng2BPbZd3Gu=Tro2x=5qc_NQ=Cegf6HAohMMxxDuyQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] RFC: SECURITY.md: Rough draft of codifying the
 maintainer process
To: Jason Zaman <jason@perfinion.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	James Carter <jwcart2@gmail.com>, Petr Lautrbach <lautrbach@redhat.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Johannes Segitz <jsegitz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 8:45=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jul 23, 2026 at 9:30=E2=80=AFAM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Jul 23, 2026 at 2:25=E2=80=AFAM Jason Zaman <jason@perfinion.co=
m> wrote:
> > > +If unsure about whether an issue is in kernel or userspace, feel fre=
e to send
> > > +to any and the maintainers will handle it internally.
> >
> > I'd recommend sending to both rather than any to avoid potential loss/d=
elay.
> > We should also mention that private vulnerability reporting is now
> > enabled on GitHub,
> > so another option is to submit via:
> > https://github.com/SELinuxProject/selinux/security/advisories
>
> We may also want to add something like the following to SECURITY.md:
> Bugs in libsepol that only affect policy compilers (checkpolicy,
> checkmodule, secilc) are not considered

I would also add the semodule-utils (semodule_expand/link/package) as
well to the list above.

> security vulnerabilities. The policy compilers are typically run
> without any privileges and attackers who
> can feed them arbitrary inputs can do more interesting things. We will
> fix such bugs but will not create
> security advisories for them.
