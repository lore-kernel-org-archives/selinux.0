Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9BD154457
	for <selinux@vger.kernel.org>; Thu,  2 May 2024 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673156; cv=none; b=X31BOIZvJqKikuQoyvB4v7XFjBnFDcRh9cnJz52zJPwHtqP8vRVYcCdN/MDbgStHRs9mR9OpEJHkUQ3RBmM9yC746CqzsReswF/K9LOjcd35kCxGCHe3z8WhmOxFYsipf/srzceE1elGux0Wf4Q01qVU0iQq2h5hkQ/6cUFgBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673156; c=relaxed/simple;
	bh=3uXCoyI7/LM5rNNYnx7uT0iYEZ+8r+/q1w7mLCunUaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGiqQGexJ9sH78aIGNSL9GuBNsO/rsQUFzAdQTSDvMrVtNOQQ98ITJrBq0aQWFXcEM4Gv0OQmn60M0/2+yc2/pB4z3L3BbREOALjrnHaRP3/0TqwVsuGWMaS4MscDZ29c5qnfPNhBNBJ7UkmDtnh2mOkimRHv+6DL2cINi8VaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7N8MfSv; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7N8MfSv"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6eb93ec8804so4638804a34.2
        for <selinux@vger.kernel.org>; Thu, 02 May 2024 11:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714673154; x=1715277954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P1aCo0JXOM2BMYyDtTWUBEJxxU/W3PeZ3RcrnOXQ3c=;
        b=f7N8MfSvwWwnwKsrWpVJqfKAH3sab18hUNd6N7Rv5SliehdBHaHT982iGY7pxDmVtz
         vX7mcuLCC6heR5hZjf6rkW33Ap1bJU6cqbjiN7rg8bnzb5t3lKwcAHRSEauYXdGR1TA2
         CUQ/s9uyWpnkyd/woBwduTuKW0YjmsG/FK2Q5GHeGkd7kWgBM1fb8ten/mlDpAr37AIY
         n0jM/Clb1NMTs6+H1ZhtnIS44TgWbykofYTss7QITwph1DL21xgAtQ1oxjbdniI9scOA
         MXuxIrgkjalSPO0c4jS47AGU0/DNJmSdvMjNfR6Po2VRE0F3Crd/Us//qFmpYIJj04E2
         HdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714673154; x=1715277954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4P1aCo0JXOM2BMYyDtTWUBEJxxU/W3PeZ3RcrnOXQ3c=;
        b=UdwLqPElLrhir/KEhskSnQx9cgQQk2VhFygeqME+4dKBIwQSvB0PAAN532G8mF0tX1
         dvd3ky/d3sTDCRHVsbvLHqKIMFYMNbTHGvwv5FZod+MOgui/u9SPxD1fNReQmxTIl9FE
         tNp61UvvvErCmZkszdgxz0PDm3iDegLtianVFqdWOHY4D59+wSae/QKIiY5gyEJX4jz3
         I3mzKrwsUAnKAh2L1cKP67YEPU4PMuJ2ZZNSJKv7lc7eh+xAwUAnSxfkKv658EIuRDE8
         TKqLI4HNNbzPM8mqzV2A/YVK8oJTOa7h+99IWaJDkSswwc+goR1HcETsgsfaRzg0Cwkr
         N7FA==
X-Gm-Message-State: AOJu0Ywi3196V4AAAkr9QVecL6+36xtBU4QwWbj3gpWzW/L5DE5Rf7/9
	Q+cPlh5JoyzBMhTlEKivzfFN7u8sqHWZdwLbKIqpmCJgIatQ7ZuZ4NgxjG0xDgxiDRDf4SEK5Fl
	aGlGcuo9hCOnKHSJzX39h8B3V07NX6A==
X-Google-Smtp-Source: AGHT+IEKmAFNdiwluRZNmkCwbjNG7W3zYfRW7tq5PcjQKhO4q1bDIslLdEImZRIDoeA8n9bqSKBXvtN2L8iZ1w1QE9I=
X-Received: by 2002:a05:6830:91b:b0:6ed:d4bc:1b72 with SMTP id
 v27-20020a056830091b00b006edd4bc1b72mr981155ott.5.1714673154526; Thu, 02 May
 2024 11:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429163122.63181-1-cgoettsche@seltendoof.de> <CAP+JOzSc7kZP3BxaZAgR5uML1xWJzwrEptKVopsoOV_PbeA4Yw@mail.gmail.com>
In-Reply-To: <CAP+JOzSc7kZP3BxaZAgR5uML1xWJzwrEptKVopsoOV_PbeA4Yw@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 2 May 2024 14:05:43 -0400
Message-ID: <CAP+JOzRJvZmjWbvu7z7fAtP0+581R0qdOrW8GVCz6aiwW_ursQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] libselinux/man: correct file extension of man pages
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:07=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Mon, Apr 29, 2024 at 12:31=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Set the correct file extension .3 (instead of .c) for the
> > security_validatetrans(3) and security_validatetrans_raw(3) man pages.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these five patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These five patches have been merged.
Thanks,
Jim

> > ---
> >  .../man3/{security_validatetrans.c =3D> security_validatetrans.3}   | =
0
> >  ...{security_validatetrans_raw.c =3D> security_validatetrans_raw.3} | =
0
> >  2 files changed, 0 insertions(+), 0 deletions(-)
> >  rename libselinux/man/man3/{security_validatetrans.c =3D> security_val=
idatetrans.3} (100%)
> >  rename libselinux/man/man3/{security_validatetrans_raw.c =3D> security=
_validatetrans_raw.3} (100%)
> >
> > diff --git a/libselinux/man/man3/security_validatetrans.c b/libselinux/=
man/man3/security_validatetrans.3
> > similarity index 100%
> > rename from libselinux/man/man3/security_validatetrans.c
> > rename to libselinux/man/man3/security_validatetrans.3
> > diff --git a/libselinux/man/man3/security_validatetrans_raw.c b/libseli=
nux/man/man3/security_validatetrans_raw.3
> > similarity index 100%
> > rename from libselinux/man/man3/security_validatetrans_raw.c
> > rename to libselinux/man/man3/security_validatetrans_raw.3
> > --
> > 2.43.0
> >
> >
