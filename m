Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BE218D
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669220; cv=none; b=Etg/obwpoH6ngergeuobHpUhZLJRItXjxPj+EGzvxHpoDvc+dsV2lRzwieMmfVc36iEVGpVrzeMZ9pD2PnmD4MenEnwvwibxe47brFpMH2JVi3/c1xsgslI2krr99JL/WmObmyxs2v+/BUx48kpE7WAZp49GoAEhGaYn1EPSHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669220; c=relaxed/simple;
	bh=Rh/S83SYj/n/PzWTJ2B0lEk8qP5tfuqMOn1xc5rEL28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qr78beOEZpmD1IWevQZEVpZJDBfxe9X0bJN3a2e/SDS8qTduHTfYNQ5rPwzoOrU8t3b85fphFmoWYadz2DfARukwPpK3Le/9jaRLbjXkT0ADx/V/fSsd5IfTEFnEPB1ncHxjbl6bzdG9slRyTT11L/k0QxfPbwQHWYNzHHTF6Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAZDkGBt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAZDkGBt"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313154270bbso263136a91.2
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749669218; x=1750274018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rh/S83SYj/n/PzWTJ2B0lEk8qP5tfuqMOn1xc5rEL28=;
        b=nAZDkGBtFJLXYo7SHhG0QVf4Od8DBC8uI9nVW3nIpn28etimoE5t6O65TgaWCZT0ce
         tHI/Ip8hqAXWbA8CsCoijYe31BJgChrepmgsK9kfE7GotM9L5Jmh6g1hVYRXuS3uNW2b
         W7KYPPXJ+2fnsXLHTWTtLLojsl0SB+JgVhaHJnNlQFcfAMvS0ZuF82yoEndsFpmVu6I3
         Sj3Su/ELLnzXdIFe03rHZXlT2hZTTimE+Mno8V83/utbRjAUj0IMeee1YgTK/cRMa9eZ
         6xLaVJjyDaFJ8AAOglBnTINxA16CGPdhRztEruVHNb/2D3Ak6S46VU5cXTApU3oNhJ8N
         4pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749669218; x=1750274018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rh/S83SYj/n/PzWTJ2B0lEk8qP5tfuqMOn1xc5rEL28=;
        b=JkVA5L6S+yINuEYBuFIKR7rbgKd7+O5Jr6qrtDq1A2jlOxxhriEphLQVOLlKwpiPy9
         3NgY1XwANdSa4NVVPPdWb4GTzJIOS5KCMGuWgby7+DGyfomP81l/aeOIqNGz5U9DKNFH
         CRBSUjh6Q0dWAoW97/Xuf3fbTv+Ljl+YUHEcgwJCZgyhfbBaM/tk2uVmKLNlmuCMNa44
         Y86Q+HmNxjHcJZwPtFLAFK+rhiVanr63efb0r11sSXnzL+daZzXWB42KcgSg0LHxIokr
         76NFDadVmCGD1JubNdKlQz1g6HwbGSPKcGIqSkvcw4e3/f9xaQ1q6ScCTTZqDOHom8b8
         Q3uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD5DIvowg81ivRJyL6kkRZkCf7Lma/xLrzCl/2+SugB+8QgBbGbcaIEQEQOOGi1Sb/Rw08bsZz@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZVMLZavFTJDuYWQr37P7ATHcIuiqUOkbXndjrIdv4LAiduI4
	uzc9lqclhWoXTZaCtpqizE6xKPHnao+jcgtH4wPHSCsNCZGp2/bxGb1qpEnSehr9j5gc+GUzkoV
	ORYCxnHfLRMRST66FA8yVxPiZo/9Kegc=
X-Gm-Gg: ASbGnctvpSkn+y6qy6UM5dKniIdIHofouuyiW2EOS3uCC7H3bcAjK6ELQvFDP3Ddrgy
	G+Cvl1WDcvsUltNFihvTr6uOTvYzdOFyNoyRd8S4f3wjW8VqgvqU87JtIHVEe+B7N9raj54kEeq
	z1QyGPhUMirTqCyczHcVJAtR3NBO4lSRwy4K/IX9+DMFk=
X-Google-Smtp-Source: AGHT+IHwPGfX6rxoDr/JZRVyh1WbYveJpMug2M4PP/2PEcSYeMRvBHkc1ymeIo0YTQu4IQuVJyootA1q48Nzxytae4g=
X-Received: by 2002:a17:90b:274a:b0:30e:3718:e9d with SMTP id
 98e67ed59e1d1-313bfc2ae6bmr873204a91.35.1749669217834; Wed, 11 Jun 2025
 12:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611182846.236298-1-jwcart2@gmail.com> <CAEjxPJ6g+=N3p83hUXRndvET+4T-+OShvMHipLg0h7fo89iPfw@mail.gmail.com>
 <87ldpydrhx.fsf@redhat.com>
In-Reply-To: <87ldpydrhx.fsf@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 11 Jun 2025 15:13:26 -0400
X-Gm-Features: AX0GCFvJZYjJGSa3D3a2DT_tvlXzX2xSR3ctZPvVCnU4BtyfmVUb4n2PdafdOfo
Message-ID: <CAEjxPJ54dhnb40R0Zk9SDuwqXWvv2aMtD6a7MUJQzdKy1NY+sQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Do not inline compile_regex()
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 3:10=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.co=
m> wrote:
>
> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
>
> > On Wed, Jun 11, 2025 at 2:29=E2=80=AFPM James Carter <jwcart2@gmail.com=
> wrote:
> >>
> >> Since commit bdcbbf89b9548afd452449835e58e84105a71a9a (libselinux:
> >> limit fcontext regex path length), an error would be given if
> >> libselinux was compiled directly. (Though, building the whole SELinux
> >> userspace still worked.) This is because the flag "-Winline" is used
> >> when building libselinux directly, but not when building the whole
> >> userspace.
> >>
> >> Remove "inline" from the function compile_regex() in label_file.h
> >> to allow libselinux to be built directly.
> >>
> >> There are four functions defined in label_file.h that are not inlined:
> >> regex_has_meta_chars(), regex_simplify(), compile_regex(), and
> >> insert_spec(). The first three functions are called by insert_spec()
> >> which is called by the inlined function process_line(). This last
> >> function is called by utils/sefcontext_compile.c which prevents
> >> relocating the non-inlined functions to label_file.c.
> >>
> >> Signed-off-by: James Carter <jwcart2@gmail.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
>
> I'm going to postpone 3.9-rc1 to tomorrow so this change can land there.
>
> Ok?

Or feel free to merge it now (or I can) and you can do it today,
whichever is easiest.
