Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713251F9A8D
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467191; cv=none; b=PUi5joLjeMcNuSe+Uen2pDR77geRcCCqQpYLdUdz9M6npNJXzjiJ4Ls2G9ICrvBoo16d/e/7ZuxwlmSHe/bWWNeyxTK66Ux3zg6kLOa6jIqdFzqAaT+9dsiAAk4OwRwriLrdSDEA0NmwJDooj6a3bHL3o9EMcvTGfvtD3Vu2ZY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467191; c=relaxed/simple;
	bh=s2Bbya4Z0sOwymk1lVgBBw052SG9NWeXXjtsfjkd0YQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaITRLmiyaO7IzB2rg9BkOYuZCqySh9Oo6rwq6Dpk8eoQ6krnUVyhMzR9Ytm2Am/fASfGU2JmVx2PupeuWn6U6E9i/XtIGTx2S8ECL3z3iR4bcX71kVqBf5Vbv6TbGmk8+NlETPgNH49jOiFb/Lr9feAzWtX1C2M2AXAmLQv8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6XJXB0r; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6XJXB0r"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85ba8b1c7b9so39914241.1
        for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 12:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734467187; x=1735071987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGgNjDBjLCrg02XQn87qatC+eUrmDnY/As+HGCI/uKo=;
        b=Y6XJXB0r8uFm919VxYjtq9RPHGaXq+pP9smL0WYItRlHKYRw4/aVhlOA6g3mHnUVIC
         5wIi8H9x+or/OCZtoJs1/n7qfL/n9LAB5IrG318wSHufNrO12Q8tTtpMX6/nFVF+oqe2
         c/sjTBafnbWcQZ0847fa77QKCOhv3S4qZ8x4ZK8e/bptbcEJLhkhmJvG/dI49loJXDEl
         lSM2Qj8kz/0zVuOU5ntqNdJGBUCm4/ORf4S4S3PQ7pn/CTTwvEZUTLfxfEZ2G4zDB+cu
         Vc4ytL4+x60skSy9OzM6oFVGyurTeEAGqmNDfYtXRTQABObmVHzRzsW+TwCeA51xm8As
         CJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734467187; x=1735071987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGgNjDBjLCrg02XQn87qatC+eUrmDnY/As+HGCI/uKo=;
        b=eFVALXCAkJIp7yd5ouFi71hqCORH8LJY0zg1QMyevHGY327uCpcnnuznwzdfh/zJRV
         AXWroJ9L14jKl0/yUFE3V9vAzFQXUOKfmJTceTa4xb1x9J+nebC/LxOPlblQ76csIVoB
         ZDwA35aX8A2lONX2uATOwkXBUdWf8eshsfkIIfob0L1RBPyvl08V9fGu/os0RZf3N9Is
         2NlW8VZkz3X32ctAYweeW1Ig1jslZk0B3sjUXAA284u5mIwNh3b7gLtXWXENDdmDE1bE
         YsBUgzojGDm/LoZK5iVuM08gbHDhhO2NG2v8pP5rZwH2vsF6FM9XZCINW1UbiAdG2uZ0
         iizQ==
X-Gm-Message-State: AOJu0YywZkxlAMYfNPLJPqnPhS9l33MCI0xDbSB0lpnONJP6kpYNExsZ
	/amQ0jt0cWSsaFnYTz2SXHPId6GvlSr7rNLEM5Q4dXr1edZDBfBrLS+XWA0OCTvtKIaIBSoJYN5
	51TSaXwXZRn3zbx/v6IdZKYz/qXCAUkrn
X-Gm-Gg: ASbGncue27b9CalE2b2vbgycuVIbrzRk2s2V9KHYUbSDIYm9jeLDWsD1una1+KE9B/T
	eegBOAQz9mAVd3NnhCaxSuBojYAbVOCSHh1Tg1Q==
X-Google-Smtp-Source: AGHT+IGNppOZFlG65G98iBKL2qzJBojAcBiLAfY2FwTPHKMntclIkYoe+zlAWmMRV/RKGXJThOudub2kT5iljJOsB7Y=
X-Received: by 2002:a05:6122:3705:b0:517:e7b7:d04b with SMTP id
 71dfb90a1353d-51a25ee74ddmr5547076e0c.5.1734467187353; Tue, 17 Dec 2024
 12:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205193005.20532-1-cgoettsche@seltendoof.de> <CAP+JOzRpOOJ4WcJ7dpNYRTdgOP7zSDS4Vieeb_DDugigj-+DAg@mail.gmail.com>
In-Reply-To: <CAP+JOzRpOOJ4WcJ7dpNYRTdgOP7zSDS4Vieeb_DDugigj-+DAg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 17 Dec 2024 15:26:16 -0500
Message-ID: <CAP+JOzRqydHhOQmy29wGSeGhvbLxjvDuNNiD-GZ7pp-kjJe0gg@mail.gmail.com>
Subject: Re: [PATCH] libselinux/fuzz: update for lookup_all() change
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 3:40=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Thu, Dec 5, 2024 at 2:40=E2=80=AFPM Christian G=C3=B6ttsche
> <cgoettsche@seltendoof.de> wrote:
> >
> > From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > Commit 89dd0b23 ("libselinux: avoid memory allocation in common file
> > label lookup") added an additional parameter to lookup_all() for an
> > optional buffer the return value might be placed into.  Update the
> > fuzzing related code accordingly.
> >
> > Fixes: 89dd0b23 ("libselinux: avoid memory allocation in common file la=
bel lookup")
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libselinux/fuzz/selabel_file_compiled-fuzzer.c | 2 +-
> >  libselinux/fuzz/selabel_file_text-fuzzer.c     | 2 +-
> >  libselinux/src/label_file.h                    | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/fuzz/selabel_file_compiled-fuzzer.c b/libselinu=
x/fuzz/selabel_file_compiled-fuzzer.c
> > index cf0710ad..d1249a76 100644
> > --- a/libselinux/fuzz/selabel_file_compiled-fuzzer.c
> > +++ b/libselinux/fuzz/selabel_file_compiled-fuzzer.c
> > @@ -232,7 +232,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, siz=
e_t size)
> >         assert(cmp(&rec, &rec) =3D=3D SELABEL_EQUAL);
> >
> >         errno =3D 0;
> > -       result =3D lookup_all(&rec, key, mode, partial, find_all);
> > +       result =3D lookup_all(&rec, key, mode, partial, find_all, NULL)=
;
> >
> >         if (!result)
> >                 assert(errno !=3D 0);
> > diff --git a/libselinux/fuzz/selabel_file_text-fuzzer.c b/libselinux/fu=
zz/selabel_file_text-fuzzer.c
> > index 5d851de1..ed67ea25 100644
> > --- a/libselinux/fuzz/selabel_file_text-fuzzer.c
> > +++ b/libselinux/fuzz/selabel_file_text-fuzzer.c
> > @@ -178,7 +178,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, siz=
e_t size)
> >         assert(cmp(&rec, &rec) =3D=3D SELABEL_EQUAL);
> >
> >         errno =3D 0;
> > -       result =3D lookup_all(&rec, key, mode, partial, find_all);
> > +       result =3D lookup_all(&rec, key, mode, partial, find_all, NULL)=
;
> >
> >         if (!result)
> >                 assert(errno !=3D 0);
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index c7fe3a48..562c3da6 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -63,7 +63,7 @@ struct lookup_result {
> >  extern int load_mmap(FILE *fp, const size_t len, struct selabel_handle=
 *rec, const char *path);
> >  extern int process_text_file(FILE *fp, const char *prefix, struct sela=
bel_handle *rec, const char *path);
> >  extern void free_lookup_result(struct lookup_result *result);
> > -extern struct lookup_result *lookup_all(struct selabel_handle *rec, co=
nst char *key, int type, bool partial, bool find_all);
> > +extern struct lookup_result *lookup_all(struct selabel_handle *rec, co=
nst char *key, int type, bool partial, bool find_all, struct lookup_result =
*buf);
> >  extern enum selabel_cmp_result cmp(const struct selabel_handle *h1, co=
nst struct selabel_handle *h2);
> >  #endif  /* FUZZING_BUILD_MODE_UNSAFE_FOR_PRODUCTION */
> >
> > --
> > 2.45.2
> >
> >
