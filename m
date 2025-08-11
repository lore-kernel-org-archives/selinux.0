Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F43D2D9EE3
	for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 20:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944446; cv=none; b=EWsnK5wxazj6tm+cIdSb1xEl7yWLu/0zKXO1QDp/dNKTKtCn2o5ZIovaSfZZm7r763KDExBN51dRyUYtHEAPb6cNpcZEm4NQ7yAelLBDmw0zhovGu8Ba3cZ0VvcJEoFyJx9U+XNTy0meE/M/cLEGUqKiIC00hgNr4KOF9tls98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944446; c=relaxed/simple;
	bh=PnHpj1Bu+hRpnSmlTb7dKoFyKb881Sw3CBB3q9o7Nrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7RIC6i/WKMR34+BWdH7Y+sR/7xIynwnYc7Z8zIfpQipO4kAZMz+O+MfxWhk7A4PaTzclWzFhyESOMynEUjK0WYogZGI989XWcTLtcfiXVgksqlKUi6GazE4Wc36ZwzjNCwOKYfK5Bf8IpECyGZjD+AAnQVZ+SusemTG8FwpNpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R6rcLy4K; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R6rcLy4K"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-31f017262d9so3800889a91.1
        for <selinux@vger.kernel.org>; Mon, 11 Aug 2025 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754944444; x=1755549244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpPn8A9jCQ7MgX8U6zXahP30pGg2kLSkTU0QUHy/gSE=;
        b=R6rcLy4KrIa8nOeNNAD7lc6fnGxzkBWME39LNqr5D+FEkSsMUDfuD2hVObWHotYx6c
         mj8AE9tOtbgowrwo5RqSJ+jpC/0eAz+k+AXglEmmygQJe1h6QgpOj0NCCKiCk2iimBjD
         uX3FVd3bLwehO2DSD9zIFC9mG5act67oNS8AhinRTN369iAc+EJBpcL1YAxcUjavlnh6
         iNK6jV51lx1KKDl5KjbMXezRev2Dp2s4Vg+XCRMGSyBlO65jqs9g0roaMb1ICqMs3RxR
         KKUyyUWyVeACnws9MnrXLw22aeaZqnUsZOg6F4iV07WCzFWhlLd0i/8j2EgHwobtLmNL
         YAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754944444; x=1755549244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpPn8A9jCQ7MgX8U6zXahP30pGg2kLSkTU0QUHy/gSE=;
        b=DlsrjhX7KhUvgNyeH3COydZm46HCetd2aRGFIU7L+GVt61MexFPDJ5ys22MP0NiVyE
         bHKjZS7Lo2FRICOXG3srcD3FgheNJvCsH0Zud75WwnhswGIH94oxIrTQMaX6sjaRdlDW
         9PzsKE6vDY3yAKNpzku0GZdCXVqGECmrYF5EE4giQdHs3xow8RFMWVJArODd4gadZfyr
         g41qsduZ7pSIc0sYd+RtS1wMbv13PxHXdBXAJr/ThG81L26zRQq4w4j+rcji2XqxBlYk
         1Stb21cRmibVRlqoamO0iptvYbDOInJ4TR4x7yl4MXvTYewH43Ie+/42IWnd3eNPtz5o
         pM9g==
X-Forwarded-Encrypted: i=1; AJvYcCVcol7NU1/XuZqiInDRgA/EhYzgrd7OJ2CH3zPQ4Vrm5ZQW/cdgRetnPgismTa3SldMP6c1aXCf@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8NSzebKFMZgMpInIrur9g5CRaeJtrGuDJMe86FGZVbr++nID
	UzmWyussuoFPHlpJo1PSGn+IRab/KWg1NPCE3t5SgCw6DmMwBLZs8XcrPGhFuUkmtfByjRuvyOk
	A6/buxZFk7XILx1wZx5Z9k2XtA+ZFKpxejGj1cnx1
X-Gm-Gg: ASbGncsUNdP8Efx2+J5K7KZhzwadFBsvwZYCB5XyeYaBHyxIo0HEvKgQkUvfBdxlxLu
	ny98P4VKisHXpV7PBsYMyukHZc8RO7GpxSQPTQi1jNyPVoWpEZC0oJIJSHZspn/NMsyTGwdYfaJ
	Ph65GEQCgX48JMIwMu5UuB3GKKkZlNBXXN9lLXRQ/VSo/ef89eXwf9HlGjEUdW5hypHJ95npB7x
	Q8HO5E=
X-Google-Smtp-Source: AGHT+IF31yTJU6Kg36QQB0fuwM0VWHfh4eoNGItb1oSRv3EIqw3YPshJ86aHKMubkf5+Mobs856Kk7HA24CH5UYMiJc=
X-Received: by 2002:a17:90a:ad84:b0:321:7a2f:985d with SMTP id
 98e67ed59e1d1-321c0b5eaabmr857006a91.25.1754944444202; Mon, 11 Aug 2025
 13:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180149.1995-1-ericsu@linux.microsoft.com>
 <CAEjxPJ4MPBmjfr_e6x94XmDHUhZR+EJ0_Gqyjn8mbALL2HNKJw@mail.gmail.com>
 <CAEjxPJ4Xk81Tc=o532SvqWeeig4wt-oOt8Np0DubUBbfFuVLnQ@mail.gmail.com>
 <CAHC9VhSck4zDgsBtdBJhJ0qYtNz-tFYjj=3=as+4yX38JNTOGQ@mail.gmail.com> <CAEjxPJ4gAOXFShde9focOFpO747UaNMcxa9+-YJHT_Yu0GwETQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4gAOXFShde9focOFpO747UaNMcxa9+-YJHT_Yu0GwETQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 16:33:52 -0400
X-Gm-Features: Ac12FXzU18DOz2mgI5tf-NVe58CDZ7TZmBnfW9eu2a087nCPKXSPryz-6fh32fc
Message-ID: <CAHC9VhQLhJBYnnQTNamiQNBSBC8ynE=Cd50mVwuF_86B+PLepA@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Add support for BPF token access control
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: ericsu@linux.microsoft.com, danieldurning.work@gmail.com, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 2:13=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Aug 11, 2025 at 1:47=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Aug 7, 2025 at 9:46=E2=80=AFAM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > Also, since you are introducing new permissions and a policy
> > > capability, please include instructions in the commit description for
> > > running your testsuite, see
> > > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started=
#add-new-permissions
> > > and
> > > https://github.com/SELinuxProject/selinux-kernel/wiki/Getting-Started=
#adding-a-new-selinux-policy-capability
> > > for instructions and links to example previous commits.
> >
> > I think it's fair to simply call out the new permissions and policy
> > capability in the patch's description along with a simple explanation
> > that the new behavior is gated on the new policy capability.
> > Including instructions on how to enable a policy capability is
> > something that I think we can consider "an exercise left to the
> > reader", with documentation located outside the patch description.
> > The unfortunate reality is that there is no single right way to add a
> > policy capability to a system, and those instructions which are distro
> > independent are likely to also clash with the distro supplied policy
> > packages.
> >
> > Unfortunately, while the process around adding policy capabilities
> > have improved somewhat over the years, it's still and ugly thing to
> > have to do and I'm not sure a commit description is the best place to
> > document that process.  I still have hope that some of the new policy
> > work will improve this somewhat.
>
> My request and the linked example I provide in the wiki page is to put
> this information into the testsuite patch description, not the kernel
> patch description ...

Your request was attached to the kernel patch thread, while you may
have linked to test suite documentation, I think the distinction was
unclear at best.  Perhaps one could put forward an argument and
highlight portions of the discussion context, but I'm not going to
bother to argue that either way; my comments stand with respect to
kernel patch.

> The instructions in the linked example are distro-agnostic and just
> leveraging a CIL module, so nothing specialized there.

I suspect there might be issues relating to the distro provided
packages, but I'll leave that as an exercise for those with more time
to play with that, and my Debian VM is in a bit of a broken state at
the moment.

Since there is some documentation on policy capabilities in the wiki,
perhaps it would be good to provide some actual policy capability
commit description boilerplate in the wiki?

> At the very least, the specific name of the new policy capability and
> the names of any new permissions and what classes they should be added
> to needs to be clearly identified in the description.

That was the first sentence in my reply.

--=20
paul-moore.com
