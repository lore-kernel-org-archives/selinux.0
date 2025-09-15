Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A08A21578D
	for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757965121; cv=none; b=F9RzB5uvzbpNNSLBQ5bdF0IHr/mrjB4l5lBUq1o2M51F9sxG39gLiME/E9QhVjQqBj3Xxw4v9qzGPmg6qXmTA7CNTG9V6CaXYaCpCjN0bVAWH4PHVwcsXlsPCOIMsIZ+fa8usJpynqqwI4GZs25MTiIDu/sJznQ84zBuufFAHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757965121; c=relaxed/simple;
	bh=k+vexNXWmOSfIQvaAr+/BXxkET4SR3vlxDVMhZYHgdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOujxMcCm0GJQL+IbjLkT1B1En7c3aOMfHqZt5c6vqhWwS9+qWpMImaoTfxRsPCMkjN6K947qW00avTLojeowKsmv7qXIRwkK3ZTOYv6RY4vuEjxHh5lhql9HUFekNgmIJVC5WZHGZ5gpYC0KH48f9zvspTT31gvVhYlOVXS3bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8xCheBX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8xCheBX"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4e84a61055so3034630a12.0
        for <selinux@vger.kernel.org>; Mon, 15 Sep 2025 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757965119; x=1758569919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcyQEqxmGHgxQmRuL3YMxaU+xW22AR3ojJrBGyZsf24=;
        b=R8xCheBXHyZOtNFJPo0BJiZ2yGLXjEu9Qq0qu9haIdvQSyGnrMw8bvHlHPUWo4td95
         7z3SdnH2OUDXmYX9yVkKcI3uMbpcLtFYxMwf9A41wl9rfA6Hkabq6Sh9XOZbawACMvI+
         XwzpnF4Q0yDfTvvi457+qv+K1B2YkfHn/FR14TpB/plJDiCsGQmqtX2qPp86gC9befpL
         J/qHmtupI8JpzrqQnYhKY4gpzW9EPewLO15NdgP2AWQMWDGSQ3cP4cOHjaRJVCfAhfGx
         WJSiX7SgKt8Hp3R+jOQacMwD6MtdXdkZ8ihsFzULZRtIVR1fYB8LKRuPu1q9F1eiMj3h
         RDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757965119; x=1758569919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcyQEqxmGHgxQmRuL3YMxaU+xW22AR3ojJrBGyZsf24=;
        b=c77CrBvRJfNY95zbLXvCJ6C9BcBqowW8qiO94WvN8uekNOxWO0vOxz6ef//O9UG+7y
         rnEfIb6Q7dnAdaPWisymkhFrUPr+8XMWBPYG7LNNuQ9g53pT3FLjcxPf45HQ1Ug33+6q
         qjLOvF+xfminKyxF/vDVIv0QFvjCabMoTh0fOHiEQb/AVRLLSFI5Z9BtVXtqfA28ddqa
         PLFaTqeIJqXuPN4pYrxu5QbqcZV+5Fh2dMmx2IpBeWpMEqNbxVJrVEi48SUbw5VRAkHY
         j9Xv7n/Cgk++ByHntGQhciQv+E33aju5B3lK7B7SXpNnjctCS5Aws5L+GUuWJfpAujD7
         SsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnr+Wtpq+Vw0vHI5Ef3AsU8S/ogeG6LWK73bWf5TzcDgtqahy7zDth1+UQRV0e/O4Eo0lcD/YO@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKY8Zt+oeq6tu3qr2Z4CKh2I3hgbUcUXFID8ju4q41cV59+6F
	IU9fIAD2aTKRQqk1zQpY3K6v5eP/Jw6Io4Th65CQQkA6CfNdK7J1Yc83dOk2Kaz6LP6OihTI7R0
	ZzhOKrH10cGd3mptJ4JEBuPYKv9nndljCKg==
X-Gm-Gg: ASbGncujS/TVD8/EsBTGh7kpRC9KVk0yxgfFYboMwYkIiADXTjpmU89Kt/3VGUTCSqg
	h/gmsKc7uKvHWQgBj614lUYfzF2L4WMeIreerzfSrbQlYfP4Y2B6RTSXidvWxOkPjeHXp0ecVoU
	/bGc5R47ZDyEymX+rwgVXJk9xia9dQBhAU/vRQllSgJG8eS8e043sgbWfzOaNZ4ygkPhh0O1HuE
	ytt8tvlIll/tXOv4Q==
X-Google-Smtp-Source: AGHT+IF1h3xvIskUdB53aw9XSSipKRmsz1ts56c8cbC5qNa0sKiwWfnODozBthXRdZUadnZveDFM/9QTFtGu71hMKeQ=
X-Received: by 2002:a17:90b:1c82:b0:32b:dfdb:b27f with SMTP id
 98e67ed59e1d1-32de4f961d1mr18327804a91.17.1757965118589; Mon, 15 Sep 2025
 12:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7a27eed6-9554-4f6a-9f2f-2cb1efc522fb@penurio.us>
 <CAEjxPJ5F5YtqqOb+KTiC4-ED+0YMAOLfKnABNnggjK_N2hhzjA@mail.gmail.com> <1ea8829c-7b4a-4048-8045-768b5af70218@ieee.org>
In-Reply-To: <1ea8829c-7b4a-4048-8045-768b5af70218@ieee.org>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Sep 2025 15:38:27 -0400
X-Gm-Features: Ac12FXwJw_C3VODwec1CTOSF6BrfqzbCnZwQtwn8EX3HDhJ5uKYg_8GosoAlWrY
Message-ID: <CAEjxPJ692h1RbJfHLGfVye7diVW1r5WJz=P0iZeNet0gf8Qusg@mail.gmail.com>
Subject: Re: Lack of official hosted macro documentation
To: Chris PeBenito <pebenito@ieee.org>, Paul Moore <paul@paul-moore.com>
Cc: Ian Pilcher <ian@penurio.us>, SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 3:26=E2=80=AFPM Chris PeBenito <pebenito@ieee.org> =
wrote:
>
> On 9/15/2025 2:01 PM, Stephen Smalley wrote:
> > On Mon, Sep 15, 2025 at 1:56=E2=80=AFPM Ian Pilcher <ian@penurio.us> wr=
ote:
> >>
> >> TL;DR - Writing policy modules is harder than it needs to be, because
> >> the documentation for the macros/interfaces in the reference policy is
> >> not easily discoverable.  This could be helped by hosting the generate=
d
> >> HTML documentation in a location that would be indexed/processed by
> >> search engines and AI chatbots.
> >>
> >> Over the weekend, I wrote a policy module that allows a containerized
> >> service (running as container_t) to access shared content
> >> (public_content_t and/or public_content_rw_t).
> >>
> >>> policy_module(container-public-content, 0)
> >>>
> >>> require {
> >>>        type container_t;
> >>> };
> >>>
> >>> bool container_read_public_content false;
> >>> if container_read_public_content {
> >>>        miscfiles_read_public_files(container_t)
> >>> }
> >>>
> >>> bool container_manage_public_content false;
> >>> if container_manage_public_content {
> >>>        miscfiles_manage_public_files(container_t)
> >>> }
> >>
> >> In the end, it turned out to be extremely simple, but it took me most =
of
> >> a day to do this, because it took me that long to figure out the names
> >> of the macros that I should be using.  I finally discovered the
> >> miscfiles_read_public_files and miscfiles_manage_public_files in the
> >> apache.te source file, but that was only after I wasted several hours
> >> asking search engines and AI chatbots what macro I should use for this
> >> purpose.
> >>
> >> I was pretty sure that macros like these had to exist, but I was never
> >> able to discover them through Google searches, Google Gemini, or
> >> ChatGPT.  (Google Gemini hallucinated a non-existent fs_read_access
> >> macro; ChatGPT did a bit better and referred me to
> >> files_read_public_content, which was real, but has been removed.)
> >>
> >>   From my POV, the problem is that documentation of the macros and
> >> interfaces in the reference policy is *reference* documentation, which
> >> is helpful if one needs the details of a known thing, but isn't helpfu=
l
> >> in actually identifying what thing one should use to accomplish a give=
n
> >> task.
> >>
> >> Fortunately, search engines and AIs have become pretty darn good at
> >> processing reference-style documentation and answering "what should I
> >> use to do this thing?" type questions (occasional hallucinations aside=
).
> >> But this only works if said reference documentation is available for t=
he
> >> search engine/AI to index/process.  AFAICT, the generated HTML docs ar=
e
> >> not available online anywhere (at least not anywhere that seems remote=
ly
> >> official).
> >>
> >> It feels like having this documentation hosted in a place where it is
> >> visible to these tools and given the appropriate weight (i.e. not just
> >> a copy of the docs on Joe Rando's web site) would go a long way toward
> >> making these macros more discoverable, which would make it much easier
> >> for policy authors to use them.
> >>
> >> Thanks for reading my screed.  :-)
> >
> > Great idea. I thought we actually used to have something like this but
> > am not finding it now.
> > Chris, any clues?
>
> We did have some generated pages, but when the project moved to GitHub,
> there wasn't a place to put them.  There hadn't been any requests for it
> to return, so I never looked into it.
>
> `make html` in the repo checkout will generate them in the doc/html/
> directory (from the repo root).

Maybe we could put these in GitHub pages for SELinuxProject?
