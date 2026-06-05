Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E99416CFD
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676811; cv=pass; b=qKuEDwXahLLttUFPrNWdHQxv43at9HGjmrDtTnTpP8C5vgQlO6qcXKSODLowCa4fMMur4bedS98wMgreV798axVMhzKWhZFTnDAsZGJSGnVm3ZdVb7uZ1bxquezEzKHuLd8Io1zG0nnJOqRtToMGlV5iq8QJgN8Qw314P6OlVhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676811; c=relaxed/simple;
	bh=ReyHD82OponrGLrvMw7OO9FFkd6YSj68sLjF5n2Hoew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6n47ctJn0hNToBpaKS4mP7waF65HMa7M0CjXL2uN3/7XObmT6okQib4hEIBNlQ24VuJPZeboccxfNwhQ3AHh1h2Av8W/rCv8vcA7PQaOcRWezvFOzIwIxTDSqxYAT5dGjQGokepIOaPmXhH/KZeKY9zHhPHmavaQ/y4eDUMx6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdfUaphx; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdfUaphx"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c3184c71so16941005ad.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676807; cv=none;
        d=google.com; s=arc-20240605;
        b=O8nykyuEr9/wfCl63Y7ha3xVt9U2sv7mu0XDYO24E9UOhFx+3PTsJKtLZ2qIuQKCeL
         pVgPwdm/ECqd+/5GRzODDn8u5l+u3nxpHu9FzQzw0LTdPzALeZbSo3P8ChHIRf4Mz2uk
         96SyKUW1sgLWyK69rGQV2/VCDyR1Yz041aPaf38MkaX4bVKSUH3TEOPBnZ1U3bxYKaSq
         jcfU5dfwK/wyO8c15WIXuP+0+Q09fAr3rKdQ/ldLF4vu+vTUUFtfCoR92jqTGyvTj1Su
         rDoJOrn88M84xQfHwedAJZ3i79iVFRe/6csrt71PYaSKzipUNa99xODTP16sAWCrOdR1
         p1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RNJMqpebrPKHivpcKGy7/fNnDZNVaPU5grbq0JZiuL4=;
        fh=Zj1IMa/s0GDs2tXbiD0MgH3G+uXEgEZ586fq4Mmx8S4=;
        b=brpB63h+xG7mWoLl0XWhRDvwKnQ/0E71CIPLnCOQYUQp02aJtb0V5MBrThRUllvTQx
         EEZ1XfFtiIlboeI80u4uOAHQMDiK95oi3a3PhWD1zild97Tm0ruQxNnLIQp3hgnUnJCO
         GMnrI06F2vPAcQffjqyYFEOJCgXHSquj1Du6OhJzVVcNSVoNo0tH3XAdXuS/wpvvWU5F
         YDrMWcx6Bvf0eb+lmgTSrBO97BYMWuMcMwD2D3LE8elqzi+no48alaL6lteWdMHZhSTn
         2cYKdio7R7kY9iuFAfufAz0w2Iu1ZTxOg8UlVj2M7Cq4CTju9WpEogfsfAc8tuxUGgrN
         fC6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676807; x=1781281607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNJMqpebrPKHivpcKGy7/fNnDZNVaPU5grbq0JZiuL4=;
        b=IdfUaphxjh/cU4nmeSqrMUWASAny4qvAi0QEqaXiDRgBH6Cgh9vQ42goU6sH0iOS30
         dTaTuY+PioQW5tMIkL7WBqiSQ/NFDsq2/OYvMWoB238QBcHHP+lMRksXPmJjHa0w3bDL
         RR1OukyW8x18QfOETNKOgibLY2cmDeT+N2Q+HeCmekaozzZXShZh270zWJtBVQgiHXQc
         2l/lh96JwxyA1hmuREIj/R6ij7N3R2TtSMxv5hWUTDOw4oHmprr/0JQW/anTpinNX33f
         fTq8+4wt6BEfm+s6XfMSqQD6fKCkzCrmzMO331xEkeeImod36Y7sLHMrdXTpWGuk04Pv
         SvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676807; x=1781281607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RNJMqpebrPKHivpcKGy7/fNnDZNVaPU5grbq0JZiuL4=;
        b=hOpIWQtsih+07dwbwI9fY9YIxvjs2EaTNL4fskjCavEzIjChbFm0J48UUwtlg+df1J
         E/J9f3LKKBYQp+U6JMSscxyh9Mru4flDgfj08xI3iQNyFgzywxT7K7s6OfT/sp7oxo0h
         Fq67b7z7/Y3qeprEwf4wo2RuHNDviuGJW1coHB7Zy57+n6Z7RTgQy3fGUMSjgvmeceEF
         eAb+Z3WYJUrlBap2qi4UsK/WYhO2NtPcHka4wVergLvkEhUH/FVVw7Bfmn+9zyb9+0Tn
         4WTUDfYHAVGJ8gKk5/RXs3rTdLueet0fJkGzJbS1ydo1v2ri+e9K653xJ6mhiDpDKLXe
         CMmA==
X-Gm-Message-State: AOJu0Yw5GqbtWd/5qj4lv2O/MC84WU48iQUDvxzWH94ggmkOdXuGKYZF
	T0TpFTanoXtlTkznfSTqxv88JopmG4oWOawLczPHnxW7+0HrdZudmqJj/pZ5/TSQKParIbuML1z
	+w5JwK2nLKE1Zt/tOceQclxRj1pMfHgDnOV/0
X-Gm-Gg: Acq92OEmBDXx63L9yHg+1kn2qDv97KoV6k7edxLNIE8Bvlcn4X3qtQEZI+K1dRDYs2Q
	qO2eXxn6JklV3qFvsZ9l6Iwds257dGigQhUUSq3otZ1NaCGF7eudJKw4ywglmXkCOzMHHd4mcrn
	4ZoXGTql5bE2eD2Pj4f3SUrdCxainvoNzIxgcwIR85ttN51qTKApnsdRkCfhWYb+9f7cz29iZsA
	vsFdrmExpZKiTi9ap3NdODXr3rrHiQrlLze7/qA49Gs3zNfOsdWcEinpHFDgYd4IWWKebQuzKv5
	nmuIdxRihnJYpgAf5A==
X-Received: by 2002:a17:903:1b0e:b0:2bf:dd8b:7cd with SMTP id
 d9443c01a7336-2c1e7e4bbacmr45766465ad.10.1780676806914; Fri, 05 Jun 2026
 09:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604175258.264439-1-stephen.smalley.work@gmail.com> <CAP+JOzRAP+eeamszsP7h5=H2VYhMu2LYkSEya0M22k0DDV+ukQ@mail.gmail.com>
In-Reply-To: <CAP+JOzRAP+eeamszsP7h5=H2VYhMu2LYkSEya0M22k0DDV+ukQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:26:35 -0400
X-Gm-Features: AVHnY4IDM-tVp54pYoWciw3waSaChfXnAqkQMX8r1E9g77OMEFAYAs8dIrR4x-E
Message-ID: <CAEjxPJ5Tn2pD+OfrDhWHogicd5+BKk-yF1hCJJzkpctFQ8W9DQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mcstrans: fix glob() error checking
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:49=E2=80=AFAM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Jun 4, 2026 at 1:53=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > glob(3) returns 0 on success, > 0 on various error conditions.
> >
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> For these two patches:
> Acked-by: James Carter <jwcart2@gmail.com>

Merged.

>
> > ---
> >  mcstrans/src/mcstrans.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> > index 15c2d76b..e0593c76 100644
> > --- a/mcstrans/src/mcstrans.c
> > +++ b/mcstrans/src/mcstrans.c
> > @@ -854,7 +854,7 @@ static int process_trans(char *buffer)
> >                 unsigned int n;
> >                 glob_t g;
> >                 g.gl_offs =3D 0;
> > -               if (glob(tok, GLOB_ERR, NULL, &g) < 0) {
> > +               if (glob(tok, GLOB_ERR, NULL, &g) !=3D 0) {
> >                         globfree(&g);
> >                         return -1;
> >                 }
> > --
> > 2.54.0
> >
