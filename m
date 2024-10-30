Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4A1EABC2
	for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294084; cv=none; b=MJnxNfYIZtYyvc+7CxaVPbbK9JB9OU4VnfYzN8/lc7sTaJYTOQy9nRaGTfmXtvr3sogUdQcWCBlazLNgwpGzUOEL8ytsp1/wx4qXnClzvUerYq/fh/9y1ib3xMdPAb8ooMqEsyz7zemi2HujqVAYbr+w/GNxbHiaaOtJiDwNG1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294084; c=relaxed/simple;
	bh=wgfFVGx7dm1ME824x9Xfjd/mRTsE2AkMRobZQQpuefA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0JiiD8W+CQstEddCwXLk85BU3YdxAX3qrL8jGM3WePH2Bb3dbKFZeR7fOla8U4cdg+BBRRTDrVLreIp3j7P3Ei9KHX37lH3juB1TXFcL5G1Ko9ZSxBvrcUPIDFN89jN5U8QJq5oYzEFNd2xkPn0tM1gkf/9SQ7MZ6HI9dQ4kdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AazCqN6Y; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AazCqN6Y"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e600ae1664so3868378b6e.2
        for <selinux@vger.kernel.org>; Wed, 30 Oct 2024 06:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294081; x=1730898881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMkRbWNCuQ3dfsrj083zfCOs2hRrGOBMF5/coDXwtcc=;
        b=AazCqN6Y/Adhg8KxcLJXCtLQYNlmaXnc09jH2nSx5C5ld6BLVtEMJj8tzVfTRyeUFF
         Q6CXhjDsMGzDcdfJxbqD7jMtfMNuhEmztUpLI5o9pH1g6OFUGY/L+wdONX5m1D71uhF3
         NrDOMHa0jeg1RognIqrnbBrLU8cMHBTnDz5wqBoTcdJsrzOZT5YJTVTmtEw96Ml2D0Qv
         uvbWk2xhXlfejhvtQJdRH6LFOD33GqCpt5H7iW9c+nbktQeZdheQa7vsNhn8B10s2JmD
         ui0gsPWgxZ8pTa+oVYRqoeCA/U5YbyPE/SJAs4BTKzA5Y4QYuRD/fmUg6ALwCOvW0mv0
         39EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294081; x=1730898881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMkRbWNCuQ3dfsrj083zfCOs2hRrGOBMF5/coDXwtcc=;
        b=HYqnTVddu+cWP26gUXCoPOZigmfQG7iyHuwv9xxhCD3ZXxsCIY7qeomHt34jmZeu/p
         6avasxEJ3BUOZUCDs9b/o1wBJz5dja1BP3fWb5fTi0dWUqAEJuOr05EUhXn86tfZnI2D
         ewqpDblHoq60Ny99kvtASljA/8CDmEmnc6co7ANll/l6JnNfra1axGcW7ahN86orf+bA
         mfL7/yLWR+fY7SKQoR6XyE/e2sucD/Q4NBATDU1ykz0Z09mVAaPYZYwVD6oM+XodpK2j
         W3hxZdDEoMLSxBgXMn7Ub8R2cLAGnKJbkfK7sSFuviZgMHYEVqnVyzwLc56L74wksOv6
         v6HA==
X-Gm-Message-State: AOJu0YyykQbOud5UmZ/LDqEBrJkTcyZ9AQZRyTKYN2VcwXa5mCX4O1hQ
	lodUCEtwYUYjD5d2JAjgU8s45pfrEiDyVy1TAXJ3V8Iw/9uzYoOkOp3k8PnqSV2LZ2EorzA3gne
	1zcts6lsJPv1aR//wOv/f1kOaMLw=
X-Google-Smtp-Source: AGHT+IEAbizrQ/xc6wmEFyCQs+wXCWsJEJ43MHVtScgVtKMOrTFMHPSQmfLaTk4EBFbZ94gqGnpsi3HXqcdryC9PeUc=
X-Received: by 2002:a05:6359:410e:b0:1b8:33f2:7c81 with SMTP id
 e5c5f4694b2df-1c3f9e63149mr728782455d.8.1730294081360; Wed, 30 Oct 2024
 06:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018151213.444982-1-cgoettsche@seltendoof.de> <CAP+JOzQ-e5u+tXD4f0DhtWHW189=6MzFvbDGeGTvd=GuyMTyNA@mail.gmail.com>
In-Reply-To: <CAP+JOzQ-e5u+tXD4f0DhtWHW189=6MzFvbDGeGTvd=GuyMTyNA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 30 Oct 2024 09:14:30 -0400
Message-ID: <CAP+JOzQWZQvPDmX6CgCfc0pQo3MhTOiRj=M6mw20Tv4y9KgmTg@mail.gmail.com>
Subject: Re: [PATCH] checkpolicy/fuzz: fix setjmp condition
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 1:35=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Fri, Oct 18, 2024 at 11:23=E2=80=AFAM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > setjmp(3) returns 0 on the first fake invocation, adjust the condition
> > accordingly.
> >
> > Reported by the OSS Fuzz Introspector[1].
> >
> > [1]: https://storage.googleapis.com/oss-fuzz-introspector/selinux/inspe=
ctor-report/20241016/fuzz_report.html
> >
> > Fixes: f07fc2a75 ("checkpolicy/fuzz: override YY_FATAL_ERROR")
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  checkpolicy/fuzz/checkpolicy-fuzzer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/checkpolicy/fuzz/checkpolicy-fuzzer.c b/checkpolicy/fuzz/c=
heckpolicy-fuzzer.c
> > index ddb43260..331201c0 100644
> > --- a/checkpolicy/fuzz/checkpolicy-fuzzer.c
> > +++ b/checkpolicy/fuzz/checkpolicy-fuzzer.c
> > @@ -101,7 +101,7 @@ static int read_source_policy(policydb_t *p, const =
uint8_t *data, size_t size)
> >
> >         init_parser(1);
> >
> > -       if (!setjmp(fuzzing_pre_parse_stack_state)) {
> > +       if (setjmp(fuzzing_pre_parse_stack_state) !=3D 0) {
> >                 queue_destroy(id_queue);
> >                 fclose(yyin);
> >                 yylex_destroy();
> > --
> > 2.45.2
> >
> >
