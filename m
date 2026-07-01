Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD4D224FA
	for <selinux@vger.kernel.org>; Wed,  1 Jul 2026 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782867644; cv=pass; b=tgsSi7Uiexx3jUa93fhUSlEHXug+O7HgN6yLZONfwDjKpQqbzaVdF1hPhU/oaGjwooZWlSIuC0XVKkqNwAoiU+hwD+TP2uSwEAO27vUb/fstL1x2DAwpR5xpbsOoxcLVo+jhHIts5r2nrDSKnhiwk/ACV2c4fM9y9CROpIwvlVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782867644; c=relaxed/simple;
	bh=1Ah0q8n1N3X6C2o++ADUVtdbE6FeTFMcYD5HBk0eQ2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaCFzYTMuqE9NfwomK6ReeeEDSfcBzKsi2U5h1tlJvhgWa5eBCl7AmV3Od4chGnGjAdJOZ6ns1sRJq7lRCtgEBHIHg0BnZ9KVU6QuEcYCwMUoYQI/UApDO7bJTAnqyEgZE90XVX51lpzo+1d41O4wIMpTk4dCbRLlLQdi+QFI3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AP5qdN4s; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AP5qdN4s"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so36153a91.0
        for <selinux@vger.kernel.org>; Tue, 30 Jun 2026 18:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782867642; cv=none;
        d=google.com; s=arc-20260327;
        b=cR8QPhtqhC+32tNniCguLIH/VSeWMrNkf0ujKiJ+2xmIwhX0N8J+O08zClAQvEb6tp
         KKobKk/bceQLtd2PNHlqXAq0zjsaaWgUVfG0PSkU9AdqUPkK/98N+RqmYYVZW6bBigft
         /ONgZZojdajp249LaiJGBvpyjLk8El1j04qBmJs1ADobM5YE4sFTdzKf41RwhBGrxTT+
         1wBcmwB+z5UxsItFpYniphQOEy5pGJ8I3SkIrArwQPf8f+ZhymkePpiLGTPMC39RphXK
         1u9AwfVl+fHCyRgqlzNMP5xfXos15nPuxUiVnF/F2EfXbBi27R9ePgGtb7kU00Jy+piL
         QMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n61iM4bV7++/DxvMN7WIsTCaA0GmGj7vpiEbLdX841I=;
        fh=8CHmh0rKjca2CTgMA8c5KAtd8XGwz2D6FGE4oE5gp+M=;
        b=d6SpxHXgoTHQpNDTK1rI6CCducjWekjZoJIRg4OuJItB3yVsQTDT32raZoNqA5t9yk
         RHikwn7rvOf0T7D9awIg3xVmbxtiRwXpiTIpzOpGLoxPAspGrzibH2ttUq0cBCyxeFS9
         KYbsSPFb6xaPsa/LPDVBO6KlEQX7mTOe7k5K59PAfo/0ScyXc4MCSqaXaESz6/ORRvYU
         OSCKY5XWiak8N4NW/4VFGVYKjMJtI/NRqoucDWJguUKJaCUGgjGQf5tAkA1rVudAu6lJ
         +ea4+lDyylktNrrlw/L3u2BVC9tsDmVpNAmhp3ngpKvXHD/IvlkL7Ld4aNARq+kmrYct
         aS/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782867642; x=1783472442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n61iM4bV7++/DxvMN7WIsTCaA0GmGj7vpiEbLdX841I=;
        b=AP5qdN4skgocAia0LwoPGHYP4J7Thl3tXhcsZaj+7qo3fyukVEdCpF1IS2xRO1TKWm
         ydUzSK3DpdsniDXWgrA09IuPTRlMxryApLQYLlmQ+Z9CEGI3EFrvFlkF1Y4x5YFaj8Jb
         sVuCHDzH/laoFcLPVBi3rU1r38BpybSvDKu/5cgQxi67xjczb9CSHXJikVOP1qot5bOO
         IpQbql/7eM3JPwT7CniOj7MseKMhk9EIiWvCYsGYEyZFZsfy7vsFu3fm7jx4XHWhoeGa
         lN0gCuBQ6pdZGi2mkufpZSOJo/jYorh1b7b1B8dazK7waSXKysa3Z+SlArmrXd2GlAhi
         e7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782867642; x=1783472442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n61iM4bV7++/DxvMN7WIsTCaA0GmGj7vpiEbLdX841I=;
        b=q+13iMUawssnkeDCmvHxh/9zYWnrjiU+c2azk/182JIr8zjZPchWoYJVwDEILBE8fP
         EmjbFVncao2BpvfCqNPlouUAs1IFs/gp+cJ8VvTx6Ra80idkSwcohMcboRHMFNNMlhOu
         vTqyQGwSQa/R6ch4dBtm5gwd54kFoto5H+C2kyBPcNl4tIhl2MfK1NanG235psE+zrVA
         AOLV4d2ibfHNGl2/LR5D9cPmEuCD3F9Bl4+U4G/ovj+1MbBSGelBNqH+yF/PFt3NmA5g
         f8EruMfHO+PuCirM5H8UM+6bO3xrijGs0+vI6GzPjtFW5SQ26uAnXvcK4Yol/kvkIrrU
         cWOA==
X-Forwarded-Encrypted: i=1; AHgh+Rqg1WnKRTmGycWJslKGAaRUE6+3Qcf0c4BOPcUBnPAFUL0z4oo9Tm2a/CGhJiQ8DK+6FcNNww2C@vger.kernel.org
X-Gm-Message-State: AOJu0YyCmVI+sECUt/G3P2bWtmiIBAcjWjnZxDzdFUTCs/3xaCfSWEaF
	dsDkfcmkkb+y6BeNX29HQ+cBjbUKaTXnY+RSgdU2MT+PGVXq99I5fNli+CEoX2PR7vAXJIwxmXV
	dCjMNBAMVCQTLdIqrNb7FJDkc3OnL8AAPlu7485V6
X-Gm-Gg: AfdE7ckN7Eno+bTlwWA6/poaIr7Duh/QznKf5C3uI+qg/fzcdQfTzxsUeR+3oMA0Ryp
	UVRR8WGzcRNufFhxqTQZBkBi+9I7pHbmOBcsWVzaXLVjlXTLpTHH1fQqFYkV6yTTAtBpE7B/YGt
	64qG0rQqPSYKPL1iNfn/ru2fV44OKdaFSgQUa8+d1z9Hu+7JcCbTgWIPpqHLN2c579qhObx6Xwx
	6EGDfAvAy4GGHjzmr/LICd1qkqM8sP/yLH6zliDMcrmYzCvn6qKlt5V9fAnLlhUZQQURjDr
X-Received: by 2002:a17:90b:4b87:b0:37c:8df2:9f58 with SMTP id
 98e67ed59e1d1-3806754f735mr3150792a91.7.1782867642158; Tue, 30 Jun 2026
 18:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531165852.1478916-1-rppt@kernel.org> <CAHC9VhQ9mMhswzmy3745HbXbe_xm0aeJOmTG1PiDHtv1=zTG6A@mail.gmail.com>
 <ah6uXccHdngEUKr8@kernel.org> <CAHC9VhSFRyFZSxu0jeA_Wv9bU3MgmEWpQMnzP5Q=vRBXe-m++g@mail.gmail.com>
In-Reply-To: <CAHC9VhSFRyFZSxu0jeA_Wv9bU3MgmEWpQMnzP5Q=vRBXe-m++g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jun 2026 21:00:30 -0400
X-Gm-Features: AVVi8CdET7FGOQ5eaG-NQRt_kfqXGjmCPloWtgw63JgjYqPe7X-OuuufOuq0qSM
Message-ID: <CAHC9VhR0k_svOfVUKc0brA9FAHqwUXJroPrmDzVR8OStqpqSTQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: hooks: use kmalloc() to allocate path buffer
To: Mike Rapoport <rppt@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, 
	David Laight <david.laight.linux@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 12:08=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Jun 2, 2026 at 6:20=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
> > On Mon, Jun 01, 2026 at 02:11:11PM -0400, Paul Moore wrote:
> > > On Sun, May 31, 2026 at 12:58=E2=80=AFPM Mike Rapoport <rppt@kernel.o=
rg> wrote:
> > > >
> > > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > >
> > > > selinux_genfs_get_sid() allocates memory for a path with __get_free=
_page().
> > > >
> > > > Such usage does not require a "page" and the size of the buffer sho=
uld
> > > > actually be PATH_MAX which may be less than PAGE_SIZE on some
> > > > architectures.
> > > >
> > > > Replace __get_free_page() for allocation of a path buffer with kmal=
loc()
> > > > and make it explicit that the buffer size is PATH_MAX.
> > > >
> > > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > ---
> > > > v3:
> > > > get the args in the right order
> > > >
> > > > v2:
> > > > * explicitly use kmalloc() with PATH_MAX
> > > >
> > > >  security/selinux/hooks.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > Considering the problems with the first two versions of this patch I
> > > have to ask what sort of testing you've done on this?  I know it's a
> > > trivial patch, but we're on v3 ...
> >
> > Boot of fedora on an arm64 VM with 64K page size kernel.
>
> Given the minimal testing, the problems with the previous versions,
> and the fact that we are at -rc6, I'm going to hold this for the next
> dev cycle.

... and we are now there, merged into selinux/dev.

--=20
paul-moore.com
