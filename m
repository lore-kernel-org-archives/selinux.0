Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0FC2EB1D
	for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735163; cv=none; b=iVt8+5dicyjyzy8Jswsgq5SfKyYCftMHn5gN89nOX6LNzI0woGVF7bnSFmYjjLNUQb/DW/+VdifH9sz3rmEQy4KS7be7WRZe32HfbonBMVpyjkLWXd6iXx8lb4hEqKu1JDmt2Z5w9Gzax2S1QuwH4wcqN8pOSa/Rs365ggTb10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735163; c=relaxed/simple;
	bh=lHElCl9Ygv1dW+JnTHfTRw4sDVk0vQGqzy+w+uogLCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WL85h3wT9yQufBWVA01pHjfXvamKWBBZsmq7V+efwasGDqppfOWXxR6EBf/XaftCe3eVtGRMfIK6rW6OLB9EH1jpfSGe7YDHl1W1GvTjXPWaJr95khwgvd8H23d6VHlhO8gUjG/5ruThP6it2G4rEQBmBDtH9Q0MZsoK2WBVle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gi8Tu2Qy; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gi8Tu2Qy"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7b3410e122so875898276.2
        for <selinux@vger.kernel.org>; Thu, 12 Jun 2025 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749735160; x=1750339960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzBASK7k+/e7Ds/vYnJDsKLWHjI3nge7y/dWL7FfCOI=;
        b=Gi8Tu2QyYHbC1WHpRlWA11GsmAOltIN26lZiI6A2dnwWciZ3zQBzSoHgAAnr9fvjkq
         Hzen/UHfVX6vl4iYiH3Ic8FRL2MxPMMXWgB8lEomhg33CDtAJGaRTEsZ6PUXR2mMakN8
         bmPDpH/j0KQ9Jayavq/SSHPCAXYTmAFFk6L/FkpazyGlJdo6qT0licZoGrHzOVBMtcki
         nq6ZF+y/r8bsb1An2CcS68RGHGPbIOzj/KIpEe3A1Ztrx7Fb2wwfb9vUdF045b4vzwVF
         SNLn4OJrtRGhYTZ8ZUhwyzdJu0WVs7sO9mDFBH5RdAtjxvT3BSAuh88K+DbVcf56htOr
         kKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749735160; x=1750339960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzBASK7k+/e7Ds/vYnJDsKLWHjI3nge7y/dWL7FfCOI=;
        b=qQoWJD+4Xl5NMujtJicgRyvUDuqZQboTSXs2igeuEIVVzRsbd1ALLQ8lMBLtFhz8bt
         CieRUlN3B+/+K07wJjZ03Dx9JGyScggMNgOPOpAJ/piECl7qoxaXt2Gb0q4Ruom4AMKp
         /Id9cGqCGyGcTZoCrPWOIrDUumH1TzrxH2E3YVdaosm9VIYd3w1bocRfvL7FdehC4tjA
         gSRJd9hnXfxfa1CbXQ4AxFnD/JvYXy1I4FRQ43RGLQDsVg6JFubPYSLYSVjOqYvqnL4w
         KhjPPc+Yg9tcaIljJMwPtaYZKIGWpLo9qTFDcfDQcC+p6wDzgaVnp2ZiEzuBl26N7mcN
         AkGQ==
X-Gm-Message-State: AOJu0YwT+GM9AnmYsnQbEN7LImS2zlD3d3H6o1FlrAeYSRrTawglKSXg
	EWS8Zp3UBo03UXv2z8bnyAvUGLEgpqt0dpoxF5/bN1I+ZtcjrSL/U22qRyxjV7R5p9aKHP82FRO
	6D4ivErLa6lyLNZsNnkCcONS8chykITDtgsZrnhfQ8JdMA8y4M0CdGQ==
X-Gm-Gg: ASbGncvk+6KA7iUZvug3xZzVXM2kd+avSrPSHc7/sdFfWoOEKYSW+iVi9G0XWMezjiV
	ghH3taJmA63zfaLr5UScwb8FGLt4gVrw8vzgufL5DqMnhnSNVO1R4m7v0TyQ4fPCxP5mB8G5YIk
	Iw2BWjVIxG855ZvXpb/t7dMb3dnnIAPMDPoLyCkUzn8OA=
X-Google-Smtp-Source: AGHT+IEcBNO6wN2Kd5nqCjV7qhJgXS6jfsZaZI68Rc4dzfCJrU+85/UJA0To9gc3p0DKP+hC0pdWsopnDHJhxcRLlvE=
X-Received: by 2002:a05:6902:2682:b0:e81:891e:9628 with SMTP id
 3f1490d57ef6-e81fd9ae73bmr10830948276.10.1749735160083; Thu, 12 Jun 2025
 06:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611183234.10255-2-stephen.smalley.work@gmail.com>
 <CAHC9VhR5CZSHKo41C4PdXbeJ3OuZUQ3ue1cbk9kjkHA6thjH6A@mail.gmail.com>
 <CAEjxPJ7JAJ2aypxVyjw4KKAvGBvUVK6eCzbXF3Wd8huTSPiSFw@mail.gmail.com>
 <CAEjxPJ7YixhZOmHVq92EBVoXO5ZO9__YXhhyD7iAWMkQNV-xsA@mail.gmail.com>
 <CAHC9VhTunOdxp2v=27sAxTjQc558nwnQCT=86WR5TNP3ihSdfQ@mail.gmail.com> <CAEjxPJ4MS4S+O3vj+mMuKkCVx53hnt91=2ZNPiP4eY9fKDyO8Q@mail.gmail.com>
In-Reply-To: <CAEjxPJ4MS4S+O3vj+mMuKkCVx53hnt91=2ZNPiP4eY9fKDyO8Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 12 Jun 2025 09:32:29 -0400
X-Gm-Features: AX0GCFt4CUoyMsjla9n9zMvMz1bpAAnUH-cON1n_OAd2HRNDunH1WGxqzgMDDZc
Message-ID: <CAHC9VhQ88CSgJqJcwiysvPPGfqsYcvrmLm+gkh5po-Rda_P6zw@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/inet_socket: invoke ip{6}tables-legacy
 when appropriate
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 8:25=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jun 11, 2025 at 4:43=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:

...

> > I just ran the selinux-testsuite again on my Rawhide system and didn't
> > see any failures in the inet_socket tests ...
> >
> > % make test
> > ...
> > All tests successful.
> > Files=3D78, Tests=3D1427, 241 wallclock secs ( 0.35 usr  0.11 sys +  5.=
90 cusr 17.75
> > csys =3D 24.11 CPU)
> > Result: PASS
> >
> > The kernel-secnext testing doesn't show any failures either, although
> > I likely applied the same fix to that test VM as well.
> >
> > https://groups.google.com/g/kernel-secnext/c/w-oPYY1-HLo
>
> $ sudo alternatives --set iptables /usr/bin/iptables-nft
> $ sudo make test
> ...
> inet_socket/tcp/test ........ 23/34 Warning: Extension tcp revision 0
> not supported, missing kernel module?
> Warning: Extension state revision 0 not supported, missing kernel module?
> iptables v1.8.11 (nf_tables):  RULE_APPEND failed (No such file or
> directory): rule in chain INPUT
> Warning: Extension SECMARK revision 0 not supported, missing kernel modul=
e?
> <repeats for each invocation of iptables-nft>
> ...
> Result: FAIL
>
> $ sudo alternatives --set iptables /usr/bin/iptables-legacy
> $ sudo make test
> ...
> Result: PASS

Odd.  I wonder if there is a kernel build/config difference?  Can you
try a kernel-secnext build?

https://repo.paul-moore.com

--=20
paul-moore.com
