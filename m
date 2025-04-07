Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5029B0
	for <selinux@vger.kernel.org>; Mon,  7 Apr 2025 18:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049179; cv=none; b=molMizxJX93aGcTU8/q8F6a7PPdre6QpzU/d8+J1+0NV6i+nMb6uUdWnjMpxNrC2NmqgzxgAzFPEtfifu251DHFRbLkv5NI0Cv9HbLOR4M2EMrute1f9V4X/1Qn/Zhuk6ooH0REHgBqba1yJV3WCjj7F3++VMR95AyRRmeooFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049179; c=relaxed/simple;
	bh=0N9BSzFfRTDWmQrmQQY1YkDcWOPnKLdQVka3NpJB5qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqaCsgOf8Yf9CQpYFN3dcb8AwSlJ69PUD0M4VR+qtBJPko1EEv61OZlu/uxFvigM9pBnI/v8N5IPEvbwYsSdf7OatbuiHwAmfLy/ADhmkC5R/M2fizcIMmFFZdzEfLyukW4VBHD73jKqI9Iqs9gSugpmR+psVuTnKnVAZ4BfbtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9MoNu3b; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9MoNu3b"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5f720c717so592916885a.0
        for <selinux@vger.kernel.org>; Mon, 07 Apr 2025 11:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049177; x=1744653977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9zhLhqZ4hRqKrKHTezpgo0CImlftbzS/1p1lkFXSVI=;
        b=W9MoNu3bjdm3lu1uCpGLmwXPeFOkGFdcHvLVgGeHZ6fa3yuqAnYBQ3TvqZJnAF9G9W
         56jId9ZJoTrW9lNUOyfpt2Th8rn5pVAEY24XyYuoojaiq7oMnb49wkR23LwTOra2lLLw
         2QB5XPXVLXC0H7cov3D6nIjv8xeVm952CR5lUtLTqNYSJl9UmeOCOOAm24qnTIxsGSy+
         4oM9YF1glrK/KrJ1iBOj7NkXTnz4vg13d8+WNpoPBRXlMpLenjq3wuhwzsk4WLNW8tKH
         K8WboV8Cu+TOjXINUeYu59hhM5CUn+RpofEospr4vNjzgKZhVq2bCyAtV1GY2NGM/pj3
         bADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049177; x=1744653977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9zhLhqZ4hRqKrKHTezpgo0CImlftbzS/1p1lkFXSVI=;
        b=GCvKiWafA3jeDT1Z2leB0p5IZRj3XSpsmUOH+TNgubI6EOH70AZf6441wCPsb2t+hU
         AbqaqQ0EJ7lZubysz3GVL9uw9OUug1sXS2yy/QHD2fQNSj6Gs+IYfNkxhWM6/W6vYRlX
         gXFFbeskk1W+6/VMF7lN30GquDt00fR1nYCxiJDjkGDYxIX0HJfs/savW+TbSEu5HMpi
         vfFsvOOcSxZjCOhcL6+x7qoiAD32qhYCNGM1h+QW8VaktBgPrnf8c7QGA53IwgH5MvVn
         /M9UARNNP5S9W9cmKktPiNzHvrMQ1+kQ835zRyLYwMDBurbzccUQYu6IhNHGdQ6PuYy9
         2aaA==
X-Gm-Message-State: AOJu0YyWzvjCZLdSLKA3xkHJt8CbfgKG7lgtNCpS3etXRXqaTrUHA+Rp
	kTLWf3KJ+2jv5DqfeuZkKkdZzzg9SwzMcda2VYtCIUqrZlZ8JyDI17p/JYMzsmKXUVViJnY7OAn
	EFq2NTapTlp2RETMFcluTrirAkELFvg==
X-Gm-Gg: ASbGncvoDNze6eSp012ELU/vKpa7xcOy1M+ZSCzA8nDG5AR5aC0XhjIeqO0CHDbP5cS
	bpNyeBCzz04E7hT/JNRRfYQOjCrbKmIYIIpktZ2VS86D8YappuW+hFL89RijfuqJLrHX13C4NvQ
	bR4QsmLMWLvpFio04LcGRMOgI=
X-Google-Smtp-Source: AGHT+IFCE+waNwy30KC2nlQYqTRRjlxtsePWjWdyMiTDuujANlNRa7ml57ERVxBcVsTvAfjMYEb1NIY4QdTuuAPN1cs=
X-Received: by 2002:a05:620a:d96:b0:7c5:e8c5:a307 with SMTP id
 af79cd13be357-7c794068be6mr58204585a.9.1744049177115; Mon, 07 Apr 2025
 11:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212164932.35152-1-dburgener@linux.microsoft.com> <CAP+JOzSSt_N5u+zcYBS53vM8JqbqGe9CTjYNU-Rhvytm=5f2FA@mail.gmail.com>
In-Reply-To: <CAP+JOzSSt_N5u+zcYBS53vM8JqbqGe9CTjYNU-Rhvytm=5f2FA@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 7 Apr 2025 14:06:05 -0400
X-Gm-Features: ATxdqUHW8ULlFqFJrXxZT7J4AW5IaQCeKkzTjElfkI_Ws1tyqVSfDpShUmOQEqA
Message-ID: <CAP+JOzSSinTdy8BGe56Uzx=SJ6W0dS_jDGGq3hvPcSBcLVbQtA@mail.gmail.com>
Subject: Re: [PATCH] Switch from bison name-prefix to api.prefix
To: Daniel Burgener <dburgener@linux.microsoft.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 11:47=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, Feb 12, 2025 at 11:50=E2=80=AFAM Daniel Burgener
> <dburgener@linux.microsoft.com> wrote:
> >
> > Avoid a deprecation warning when building.
> >
> > api.prefix was first released in bison 2.6, which was released in July
> > 2012 [1].  name-prefix was deprecated in favor of api.prefix in bison
> > 3.3, released January 2019 [2].
> >
> > The new api.prefix construct rewrites additional variables when compare=
d
> > to name-prefix, such as YYTYPE and YYDEBUG. However, these variables ar=
e
> > unused currently in conf-parse.y, so this does not affect libsemanage.
> >
> > [1] http://savannah.gnu.org/news/?id=3D7269
> > [2] http://savannah.gnu.org/news/?id=3D9321
> >
> > Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libsemanage/src/conf-parse.y | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-parse.=
y
> > index 6cb8a598..93a04699 100644
> > --- a/libsemanage/src/conf-parse.y
> > +++ b/libsemanage/src/conf-parse.y
> > @@ -53,7 +53,7 @@ static int parse_errors;
> >
> >  %}
> >
> > -%name-prefix "semanage_"
> > +%define api.prefix {semanage_}
> >
> >  %union {
> >          int d;
> > --
> > 2.34.1
> >
> >
