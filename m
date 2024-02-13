Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28B95FF00
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852675; cv=none; b=YUJUJAvzY9gy1vxalz8qr3wcte3qW2nlWe7gDm1FH800yhFgKYBTwL1diU3lcDG6aVWtcHydm1IT4zKIhAxBRXmD/7P17ofNE8oSStisgceg1aFGpnynJN5tJgMGkHI0DFXDW1EL52Ia6gRqxtVf7z7WGV3hzqwexYYAwDoJcm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852675; c=relaxed/simple;
	bh=Tw2rowHIbPAqoJMrxrzUcDB4F9+J8tItAzgiEGHiSEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=uTLPi7aRAzmmOkLPtNQx7WAFOOcGvkRiENu5qAwC2bWAzC+vmWLrhRYc+OTj12YFoMqEMw25TIv0ZK9LyzXCpPBnM0tkXQG6mj/uiWPWFe3JaxDThjLTQqpHx1FdknfB1F5fsI97woA8pwKAR/wsL/ZW+OdGmalleuBThgxhkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4hdv3Tw7; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4hdv3Tw7"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso1040791276.3
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 11:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707852672; x=1708457472; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw2rowHIbPAqoJMrxrzUcDB4F9+J8tItAzgiEGHiSEg=;
        b=4hdv3Tw7ANl3xmVEx9SQnA459F3eifEgZzb4mM2FupeQpsfXCjqB9YOptXjOZOmnbp
         X7jLn7zitH2x21NE16NqBGqQ3DN9EeRDQECG/eybSAn8rTni/Uoaw+qZNsrCIgLrr6xy
         pzQIkK3F2lkjCcbEDztysysZHS01cvgkvSKth7pEdf2uKeugeUoamvvmCQ1cxMjW0LbS
         EzjuI6KclEAzhLRWyjdOojSGHn5sIIEJcM60L3hsDFiLEEqii1+6frFf53UF/jECJo8S
         sN50aT2bQbSE+wFlo87AZsqKL7p5Lw6YqanIkXJ9f3JbHB0lbFUd8jxTbJKvB+afhG9i
         i2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707852672; x=1708457472;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw2rowHIbPAqoJMrxrzUcDB4F9+J8tItAzgiEGHiSEg=;
        b=bJby+kKCM9tQJbotawo/vKlPmXYV/VorvLlQBZmRxe5x4xxo+i1YZO2DuOXGSEDyqF
         qcUntDq6AW/V+a/aH5MYFE/19Nt8pDpRGrCI+Cv6P+D3obAtN0FRU5B2rdnPaMsO9vF4
         AjOAoHitwU8vMT89KnSrBUKCRRZkVK+p956IG4uyyXCtPifO50wh3UugPC5dfcg2wpWv
         igj4Lful6YB6fSbUv7ckP9gPJ/7cOx2dcPz0OJDIQQgiVWOq/3PHfs3LifIYOtpTL7p2
         U77z7fe86GQREstskGw3jPtL29en1gsiU22hU7TYKJoCAgp7XWrKb3OvTK1vX17yz9mS
         jx0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUl14Uf9P/w4WmwxvLy45kRtNPmM4y5pLZ7MlBMPRn1JiPYD3VzoWdIBqXBBeGngM3OAdIr/WKGumvWXELmI2rSq4urBbQBsA==
X-Gm-Message-State: AOJu0Yz6ESQWZ9/mSqsdCbgM8bLoEE6vn0UxDFNQavTaAtTihOsDn4T7
	GF+sWfU1RACy/bNAoI/tMY2m00JL6Dm3rdPr+ubZPMv2H6fbuodlqcoys9XYns9sD2K44UnV55E
	hL4RrP0BxxfAXXTkkHypenJxieEvkoAtZR5CC
X-Google-Smtp-Source: AGHT+IH1xmQOWfh9dLSe7wwpBx5E+EKefS15CBVT4ddX57A9DakP6t15fuP5oCCtN0RM9L0M2M+VsoHEc/lviqBqInA=
X-Received: by 2002:a5b:b92:0:b0:dc7:4bc5:72cf with SMTP id
 l18-20020a5b0b92000000b00dc74bc572cfmr277658ybq.14.1707852672365; Tue, 13 Feb
 2024 11:31:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213001920.3551772-1-lokeshgidra@google.com>
 <20240213001920.3551772-4-lokeshgidra@google.com> <20240213033307.zbhrpjigco7vl56z@revolver>
 <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com>
 <20240213170609.s3queephdyxzrz7j@revolver> <CA+EESO5URPpJj35-jQy+Lrp1EtKms8r1ri2ZY3ZOpsSJU+CScw@mail.gmail.com>
 <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com>
 <20240213184905.tp4i2ifbglfzlwi6@revolver> <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
 <CA+EESO6M5VudYK-CqT2snvs25dnrdTLzzKAjoSe7368X-PcFew@mail.gmail.com> <20240213192744.5fqwrlqz5bbvqtf5@revolver>
In-Reply-To: <20240213192744.5fqwrlqz5bbvqtf5@revolver>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Feb 2024 11:30:59 -0800
Message-ID: <CAJuCfpEvdK-jOS9a7yv1_KnFeyu8665gFtk871ac-y+3BiMbVw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:27=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240213 14:18]:
> ...
>
> > > > We could use something like uffd_prepare(), uffd_complete() but I
> > > > thought of those names rather late in the cycle, but I've already c=
aused
> > > > many iterations of this patch set and that clean up didn't seem as =
vital
> > > > as simplicity and clarity of the locking code.
> >
> > I anyway have to send another version to fix the error handling that
> > you reported earlier. I can take care of this in that version.
> >
> > mfill_atomic...() functions (annoyingly) have to sometimes unlock and
> > relock. Using prepare/complete in that context seems incompatible.
> >
> > >
> > > Maybe lock_vma_for_uffd()/unlock_vma_for_uffd()? Whatever name is
> > > better I'm fine with it but all these #ifdef's sprinkled around don't
> > > contribute to the readability.
> >
> > I'll wait for an agreement on this because I too don't like using so
> > many ifdef's either.
> >
> > Since these functions are supposed to have prototype depending on
> > mfill/move, how about the following names:
> >
> > uffd_lock_mfill_vma()/uffd_unlock_mfill_vma()
> > uffd_lock_move_vmas()/uffd_unlock_move_vmas()
> >
> > Of course, I'm open to other suggestions as well.
> >
>
> I'm happy with those if you remove the vma/vmas from the name.

Sounds good to me.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
