Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B2E8594E
	for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965196; cv=none; b=nRpMFz2iRLM+SWRIhzD8hQqPEKZlomDtb+pykO4oFp/ZPIL2DHeu1Tj2lNE1uPojtTwVF5oOcfzOv8vvX2OaP5DXWVvfbvXyIx3lUwnn+czaU+hzfSYeuhi+Ja/AXigCIs0HYytpX0P0/obYEscnbwjlTFDCLnoxKFyaSyHKDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965196; c=relaxed/simple;
	bh=uomyBCiPFIhzRJM+qwL+JrZhDGfnVS8jguHF7Zuxr6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Geo4svwulA+I8zwfwU6j4Uhe33Ic5Z9jnBAsPDeyCcZGB8krYQpvEP5ptLDp8Ec8p1VoZONp9n3xUIMU5pUW/d88WCiPZPqZxfarTNrA11Aa66ojsUd4YOEPFDUbX55eLICHgOPhOhp9pPKgiv/Be99E9nNXsdOYIM/nncOLKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ig6B3xFa; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ig6B3xFa"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60a068e26d8so2087667b3.3
        for <selinux@vger.kernel.org>; Wed, 20 Mar 2024 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710965194; x=1711569994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rz5XGgwFL9mDFWWShVBEiNXTXonC9P8YNdUF+I9OwIE=;
        b=ig6B3xFavA03IaslDXQmi5rQNw9KqGyXSHvUxBwUZSS87JYNGx6MGpEAGMksxh7oaF
         3Acken5uQKDoqXtNxmkxBxATJODAzW3RsQSCotXH2QF9922jx0U6nPp6XrQJnfz/B2bI
         MI0Y7HhlVBUrO3WcIvbYRI4bdak5FaZnrVv2rPlsSbKktuhnRlb1bsnuqFLzZ3K+pD45
         NAenvfbYRHKxX1JTjDhFnzxzyQwzPeD0glVMppms+1m6VsAexRrFYGl9GRBsT+VLCjVQ
         eRN3DVTDN6WnuegIB8RtGY2aMyqwgTVISR7TZH9qY3Uf9cdt+sZaGRNlH5y0SzZtAbGV
         Bzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965194; x=1711569994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rz5XGgwFL9mDFWWShVBEiNXTXonC9P8YNdUF+I9OwIE=;
        b=M+lfQj8znDQYoHCQZ0Psi2MmKFHw0OzpRKoK/nHx33xB/Pc2xbWFduy9JVJ8FlG7qq
         AGt9rSBd+BHFDAKYLcGOW0VtPchCtHHY71vWlGqx+UABVWwYDPXmf6u8ICDZVfbj/FfI
         rfmfyrUbKjqnQvYCI0wZVCI1AFjRkY18ql9b2KkWcsh/EZSXoRDz+ntTt8UKWLzATHVD
         RM7M4sJNGaLl0YD23hRIIDwIB8EcAVlzQiYCMGn6Kzd4JVPQ/SCcGXtpNfi+HPVJ9SDM
         0Jw/Bjp++jC6XyUhDcL6IwQcYIaW+Dh/5y86iVWrCoEZ9JPQot10Z/UgpxmghTssSEi9
         6wxQ==
X-Gm-Message-State: AOJu0Yz/BpExIZRZcgDwgIRvQFJWfSY0mF6q31zfN0cWzYmyRUIYMQEV
	CQ7lOV/G4FT5sBCqNHnT2VuXLR/4PD/mGrZkkJ61aj6eWpdfc2bZXt4jQdoT1K5LTRhWxNQN3n+
	eAexs2XYFkVrEUlV2TmdHkQBkhBywIfQk
X-Google-Smtp-Source: AGHT+IEGYVRriFb3alESj66wkW1P9FBeI8dwCl67o8r+RxXa6id8W0t9QzVSXG7oFP0OaWzYJPuY+OZ/nkgdhyKi2fs=
X-Received: by 2002:a81:9253:0:b0:608:e694:ffcd with SMTP id
 j80-20020a819253000000b00608e694ffcdmr18318469ywg.43.1710965194159; Wed, 20
 Mar 2024 13:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313111025.43720-1-cgzones@googlemail.com> <CAP+JOzRWQRtnR56bkLNmCB0F3fGR-2v-DRyTg8Jd=wxFMUv=hg@mail.gmail.com>
In-Reply-To: <CAP+JOzRWQRtnR56bkLNmCB0F3fGR-2v-DRyTg8Jd=wxFMUv=hg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 20 Mar 2024 16:06:23 -0400
Message-ID: <CAP+JOzQX0NBMZDOUVYL7S2vryoFr6AGVVBrwER9F8oMU0gCaEQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] libselinux/utils/selabel_digest: drop unsupported
 option -d
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 12:06=E2=80=AFPM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Wed, Mar 13, 2024 at 7:12=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > The command line option -d is not supported, drop from usage message.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For these 5 patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

These 5 patches have been merged.
Thanks,
Jim

> > ---
> >  libselinux/utils/selabel_digest.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selab=
el_digest.c
> > index bf22b472..50f55311 100644
> > --- a/libselinux/utils/selabel_digest.c
> > +++ b/libselinux/utils/selabel_digest.c
> > @@ -11,7 +11,7 @@ static size_t digest_len;
> >  static __attribute__ ((__noreturn__)) void usage(const char *progname)
> >  {
> >         fprintf(stderr,
> > -               "usage: %s -b backend [-d] [-v] [-B] [-i] [-f file]\n\n=
"
> > +               "usage: %s -b backend [-v] [-B] [-i] [-f file]\n\n"
> >                 "Where:\n\t"
> >                 "-b  The backend - \"file\", \"media\", \"x\", \"db\" o=
r "
> >                         "\"prop\"\n\t"
> > --
> > 2.43.0
> >
> >
