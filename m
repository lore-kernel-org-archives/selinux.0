Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D986D2AE8D
	for <selinux@vger.kernel.org>; Sat,  1 Nov 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014622; cv=none; b=obuCCEamZ5K992k0m4uAdBEEHWOQsGnwAzZvTsptnqwrz+Sj5Al4azMF4vvXMW2nbic5IWVi4wzgoiY3jImTZfFLQSEcHtgMEliYe0yxG5gLe0FCGoCf9ZUa/7QZF2Qb3Q8m1BWwEN3ZaQEZ+jR6XmdvMkTYGyy7yGng5LEXqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014622; c=relaxed/simple;
	bh=SLWYVUPtgN3rbsoGhuz33/IADrnTxqkRvQhSejQ0NCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5T7fNoHzMxDh/e/w97QGScublBZHmC1C+t/KIzGb+0zymC1aKPZHr9LRxTLhNXE47CmqLrCfKw6FLb1hboMM3oGoJKyto1njkW+fIKDuzziLeK8yrIf2WfKWHGdIJu8tBVURifJePUD+J1EZsW16+kE2iqCN/IVL63nlj6FnnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TiEree5F; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TiEree5F"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29470bc80ceso35453465ad.1
        for <selinux@vger.kernel.org>; Sat, 01 Nov 2025 09:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762014620; x=1762619420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLWYVUPtgN3rbsoGhuz33/IADrnTxqkRvQhSejQ0NCk=;
        b=TiEree5Ft+o/Us3AINMy4IlM83etO37FfAS2h4NfhUmhxjsflmm6GAGM2/JEe4ihPP
         T9ODETK4PRfO3rTuL2k2gZEOM5XIzVmFuVlagFJLPr8KL0hMcTEMxqNzYJiGlyAP2Mpz
         EJGrL6z0Fmllipf8NXPGh8b5W/ErrkPsWEjk5AaQ5IZINLc1O8gQIHUL/w95HzAFD9XP
         m+CrB21CHHw+nEnIUNB/Gs9N+eYBRX2r+aIOhehBOAQ4OeCcinZTguRDW+WCuvjkCOpW
         Efkq9XLi+fZWgRzgw3OPuZjKl9Vxn7zwiy6FnCV0OU/YHR5Cb1NUDzgLA9N8H/vokbsV
         ZE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762014620; x=1762619420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLWYVUPtgN3rbsoGhuz33/IADrnTxqkRvQhSejQ0NCk=;
        b=kuQCMw/3F77SItnj8u4dGe6RDalEqTh3cRVyM/5cSLdLt8Hi6/qsQMk53tWsqvQUj7
         HtFaScbd66zkFNqJ3jo0BJrmgEHSE6eVD9tp7Xfi1WwhTQ5EIEsqjPLZzQd1ZMT9Kql5
         ZFtWSNJmBgACF/4bXt1a0tq5ni7dxqDR75vERwOzIECfgeD8nOv/UUbZJoKHzQXKSn8T
         nZ880pAXTCuFPiSeYX8aiDFAkWgVXIDrYlx1OS3PeLbKkG5S3FvOIsmKZyALWqtX0N//
         nQ9oJg50EDzskg1eDrCTPPKpCQHfZI0mtXlV0Aat8GoEcy5CGV53u0btyTZV470fSh58
         iI5w==
X-Forwarded-Encrypted: i=1; AJvYcCVW31f5EGUncAZl2o6xPvuklYBR0hKJKeQj2ruZbJ5Yot679cGYiPn+j1taIDy2TpSnXVvLem8l@vger.kernel.org
X-Gm-Message-State: AOJu0YzAyalrSqz7GOGO7zaP89qlKUU/4hiyf929Ry/kX7qJ6jXyBg4b
	c9HEql+oDBpCUyBdIq1vU8v9eBGzOvUb7oCDtaNB6vdhYnzRC6yEcnyns+XpOFbvONB9ZJm4erv
	z2Vn0nSbCAaJc0GRx+5yUQ5zcfLXTnyo3TGS8trBL
X-Gm-Gg: ASbGncudQ4EJlUwUwNEOwWSA3a1I9M1oYM8DrrRh2DhnVwTivSk2YZvJsBtCf17UQeL
	8UbwU13jiONhnvMnWv58gCGhaK1arMFqxw3k+5y+HlGpLAF7+LCPEy8epR+zB8KmwRruMixwTlW
	hY8YFDrZBqFWjt2VVBFXmFvuzClapybS18l6DLuwQVcSMApuLq3e1YX4vPc2r96WS28mtlchbp8
	rxT4xmGFxSWHYR/+D6FqXPPEcdYIjs8hawRRolniGIGxbUyUbDl2aLAznbc/tsXU29r/3sYICUy
	qxK/oQ==
X-Google-Smtp-Source: AGHT+IGSNHUxFUlH00tcXlYR8rm2n7oeY7NUe2FFkNQG9dY70CQpq7ofsYJezXuic+eRz1Xj3Gw4sL9HIM40S2uYy2A=
X-Received: by 2002:a17:902:c405:b0:293:639:6546 with SMTP id
 d9443c01a7336-294ed2a060dmr128009935ad.20.1762014620087; Sat, 01 Nov 2025
 09:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9bf87e7a-17e7-4c74-bafd-885752dfe045@linux.microsoft.com> <CAEjxPJ5SX-9OyMPQF9B9wr4ixdaG9jxSmG5R7Ozev+KVztWoWg@mail.gmail.com>
In-Reply-To: <CAEjxPJ5SX-9OyMPQF9B9wr4ixdaG9jxSmG5R7Ozev+KVztWoWg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 1 Nov 2025 12:30:07 -0400
X-Gm-Features: AWmQ_bmTme1B4tWoHXomB4fK6h088g0BizY3QN25a6ZAQSRO3vt0TKzt6LTqghc
Message-ID: <CAHC9VhQjEo57SMp49A+iXMUiyEXkpMUOnHkSJ3cspTHGUFXdUA@mail.gmail.com>
Subject: Re: SELinux documentation repo licensing
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Daniel Burgener <dburgener@linux.microsoft.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 9:02=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Oct 29, 2025 at 5:19=E2=80=AFPM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
> >
> > Finally, Creative Commons seems like a fairly standard option. However,
> > we have decisions to make, since we can specify different CC variants.
> > Something like CC-BY gets us a more permissive MIT/BSD style license,
> > CC-BY-SA would be similar to the GNU FDL (but of course mutually
> > incompatible).
> >
> > My initial preference personally is for the CC-BY, but I'm happy with
> > whatever license the community chooses.
>
> I am fine with CC-BY.

Same here.

--=20
paul-moore.com
