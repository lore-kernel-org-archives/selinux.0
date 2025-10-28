Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BAB32BF3D
	for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653864; cv=none; b=BrOlYjURos+FTUV07hsVeQvpAzLQwIPtx5XFvsqmTtZpvRrB2ZwGeoGgwgt6/nG/zxCryXny6W9jySRtWasAqqaN4FrPORK8JuO8UQvN9zuUt/hBeBzs5BXEOa+9l1AH4DlX1+ND1/SytsPg7OC3vpRn1y42nR0+ulgj2eIyJlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653864; c=relaxed/simple;
	bh=QC+NOTJbKfs1KZMPt21iXDmNzpoOfoDHja30aFPj574=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kft9n+NzzX504YG14HfGImqVkQRjIsFLv6gCxeWeSmwDFYilr49WbiYah9w04ORscJN8aOI59iwqBsbw+ktvOVKpTQlpYg5UuFXgHELeGjiqJBmrTvNo63ETKZEMqHMZN5MgIfKGOtdK9KdSiX3tyXZCQEfI8HulQnf6Tq1/tDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuIoHMMm; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuIoHMMm"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so5618655a91.0
        for <selinux@vger.kernel.org>; Tue, 28 Oct 2025 05:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761653862; x=1762258662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPBjZqHsOTlcKIXKCCG1b3+JE0JuZ5q7OtmTOTEquec=;
        b=fuIoHMMmta9e19gD98931zD/MAxybYtpvuG2Mie87dN83kXZEqKfTrwdGcftdNCMrF
         2RQy5MKRcQT3k4gp6nHKXbDBQwG5bu7gC28bbeNXzef2BkNJaNjTnViiCbDiVGCJtDSE
         HS26LRk9grdpEgxhc8eBEt7pAvCyxl4WDW121VNRQwRd1F9sPua6JPjp00ki+SWi4aTV
         RJpbaO9NzAjyY4GJLXCI5R1ynFohOJOdPttV8vSMESUwWciQYsx8rv9qd7ujfupQh40T
         OzRwKM3rda2CC2iDuhos4Sy4B2PX5TSjAq0Zm7xXF8Ku9gheuBwBAIt46V6ZcSb11k28
         Hakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761653862; x=1762258662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPBjZqHsOTlcKIXKCCG1b3+JE0JuZ5q7OtmTOTEquec=;
        b=v5yx0oNxSlUzixngCUkNWwVctyxvXu81u8876luPnwYNMCwCXbM9Wt6PhKbj4p1rPV
         ncZ+Fxr0lnBplhqWf8fysXWiz7pxlkpn4MOqRwBOWDA/AmbzyUDlW/E5ZXB6HduVkmCt
         rPNucSM5NsiCn6Nk2AJy13eekon/Yx3xUf9Jkfqtabt6kOeVtSo24Bp1w+116NdtYFAp
         HaE29yub0LUn0HEkGazUtlSONPIyPL6yPCNgGTqr5bVKR3OY8cw/GIbTjCs87xpI6CDJ
         KfnoIFcyivR6PRS5UiqtoXGl6Wrfxj6N2zc8XCeg8G4KStk5RI5ZauJNHDLTQ1F0ytZO
         u5TA==
X-Forwarded-Encrypted: i=1; AJvYcCWRH7Qj6jedMNH0KvdV8VYbSLnExVBQGt5iH1Z/XsWLH/lDQxDAn98jqrjRczjRXa6nPtbQs7A0@vger.kernel.org
X-Gm-Message-State: AOJu0YwM2uJD0gUKGLp+wXTK+6SSViTEHAuNHPtjwBgCyszbjBTw9Wc5
	iDvNMv/RMzvO/6VK5Baw3Pbw+HtAtMV2RqxoxUZlp5wn2D8HPrPe5V5n8hCADB6ITTgr+SN3d3x
	3/zKWz674YgE7puxn2H1loAefwK8Nh8jOEA==
X-Gm-Gg: ASbGncvuB7QA5SfknatTxD1Yrb1HAXmLpJNQO/nQKQLBvl4uME/MtYbEdWtjg9yVrtt
	Nr3AxQCC211tUilgHKDXTSAwYKCqznLmqkz4IYF3s9BufgR8r+dPW4LuYxpcgDMbeTk4hfmg6WG
	8Szx7/8zr1PSOm4KCTrWKWP2+PgI7V2dS3wRlLr0WiyRbzuHLjQS8VzA7nOuKuC/5HfTC9Fdg0v
	OUP/qRM8yd5lCYNz/3YqpFBbPLfd4SlX8h6j2pfqHyRZZKjgrdYOhUcLtz0
X-Google-Smtp-Source: AGHT+IGqz3H0D9zXRvhvMZwtexoRBSDoPMKOYNIx+XqDZdT87+Fnb/jvzsmZBLZTJkb1ChBfJ5hiIBnt0EyU344Spug=
X-Received: by 2002:a17:90b:5104:b0:32e:96b1:fb6e with SMTP id
 98e67ed59e1d1-34027a7fb2amr3524598a91.18.1761653861720; Tue, 28 Oct 2025
 05:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025083916.56013-1-nvraxn@gmail.com> <2b6896af-0fa9-4498-b33d-aa6729d320eb@googlemail.com>
In-Reply-To: <2b6896af-0fa9-4498-b33d-aa6729d320eb@googlemail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Oct 2025 08:17:30 -0400
X-Gm-Features: AWmQ_bnz0oNHxwQqAhzNqB5vAlFbBA9aInS0HBCrN62SC9k7BDtbl13xoP0z18I
Message-ID: <CAEjxPJ5guSPg2TtF+JHXoYtQirv1Hd4+vHe=V+Px-23AKD97nw@mail.gmail.com>
Subject: Re: [PATCH] clang-format: add check-format workflow, update CONTRIBUTING.md
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: Rahul Sandhu <nvraxn@gmail.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 5:15=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Oct 25, 2025 10:39:40 Rahul Sandhu <nvraxn@gmail.com>:
>
> > Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
> > ---
> > .github/workflows/check-format.yml | 13 +++++++++++++
> > CONTRIBUTING.md                    |  5 +++--
> > 2 files changed, 16 insertions(+), 2 deletions(-)
> > create mode 100644 .github/workflows/check-format.yml
> >
> > diff --git a/.github/workflows/check-format.yml b/.github/workflows/che=
ck-format.yml
> > new file mode 100644
> > index 00000000..a15cec05
> > --- /dev/null
> > +++ b/.github/workflows/check-format.yml
> > @@ -0,0 +1,13 @@
> > +name: Check format
> > +
> > +on: [push, pull_request]
> > +
> > +jobs:
> > +  clang-format:
> > +    runs-on: ubuntu-latest
> > +
> > +    steps:
> > +      - uses: actions/checkout@v4
>
> Latest is v5

Pardon my ignorance, but I see that we are using actions/checkoutv4 in
run_tests.yml from which this was likely cut-and-pasted. Do we care?
