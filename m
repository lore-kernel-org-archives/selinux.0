Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB223264FC
	for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268198; cv=pass; b=P4Loy2ErIdUq6gpT5w5cF1+Llk+W7h/Cz+fYS1T13HedqStI3v85RdrOyX2X0XNwTxFReim+VTLaNY2xZPJF7G0rxIhr5lAgJONBF+Emxtcn9WiP8cEVA03xOOImAlEsgMsVo6ROLjU1qb5IvKx9/cJ9wUfwdRs69TvoX28NFOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268198; c=relaxed/simple;
	bh=bG9xafmFIk3yWJdhDjVi8ky0s5VFlBaiK2/g5rblcHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hl7JgM68/9BoaG6niytlZyfIhhjaTOf393283r+eY4Uy9ACiWa4Ge2RT61UDg3+dZKG3zDrg+Uu68Buf80c9zWonXQx7789+dWvqXpus4GoZAINHxJoEkiADVGO1mPg7vB7ICdR+Xxivs7U4M2aqE9J0fKjmXaHrYQPFba11a74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm5ydFsa; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm5ydFsa"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4472500e25fso78020fac.1
        for <selinux@vger.kernel.org>; Tue, 28 Jul 2026 12:49:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785268196; cv=none;
        d=google.com; s=arc-20260327;
        b=PizqDdGjhga3ydu9smPGtIcoIKr2NW1E0xsneGljUlZVSCnqKvuYw2nO0MHQ2o4hH4
         a24XSTxUT70DPf8RKURjnL2hIS/ic6folYDJ8PIqAabQqr0O2lXdAAm2UkCNVMcOjbud
         YzW4Rlbqe9zNLwrN/Wspqo5a7oC/fazF2/IylmCZbJt2hO5Ozm/SCNlWHQFrO6MZiuMN
         XMvJqn/sYA0qq8F/qByIHLL+KXIQBQA1bWz/QWIMudZ/PI6nyMeEmDqcZIVfCT5xm23M
         5sqDYfoT5vGwSLMiaNhS+Sb+wB2HBrSfxZKjegcPuKKYG/teh+HU1DhtoeMKnlbcYnfL
         K4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bG9xafmFIk3yWJdhDjVi8ky0s5VFlBaiK2/g5rblcHQ=;
        fh=ctNnd7rEgrNGVRcNYAD2iHPqnd+GFVudQHEzcgGqyZE=;
        b=pNJp4afv/rCEnILJRzLxCDv2UhEYWCAZnXIi60BWmA4iYhDxk3IffEdeNkU4zAaQKg
         bhBTACerbCovVno5x+Kfs/OqvawLkh826AlIKgQRKr7NiITEySLtmlg9SGhvDJ15c51c
         yFbv1GZH2l85odpy32CNabc7q1TwtSZRkyZOKwW/4z0YrqMbhq6TpRwoNNcp5cUbtRZa
         LVs2clNFLaNaedzYSlgqap7JPSDba+Pwa1R8qiA8lzoz7A8/U2hRMkdeEpXbCJ+6Z9vZ
         vYjygYSGF1bSCgkWQoe8hhcC5F7W4kJ8maigfqNrk7I7JLkDj27Qx+rZ34y7juU4e0WL
         kMLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785268196; x=1785872996; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bG9xafmFIk3yWJdhDjVi8ky0s5VFlBaiK2/g5rblcHQ=;
        b=bm5ydFsahyJyygarUlR27+pZP96RC19nBzTyU+T/Z70eWR/IGHG3rbw4c9q2SkDSxZ
         rB7J7MRtkir+BbyK6FMPq/u/y2faWPkyasILDgaGwz5RBEgi+Oo9zUv2B9zQYW4q1csq
         fVv1Oh8qUTg7eX7cFuETZad7SouX8Qe443aTyWBfq5muJIKC0n/M2xFn+DWJHMCyv9N1
         aNkjvk/aYSnIZ8uqVFu1XFGoVPXBFN+W2bK2WdePXYUT302l9ISrrcq00wh849SsYJ7p
         pNocgWGY7gBx14juaZJkl+aUNYc5JFhE5n3ZMmIAXysYCUOtySeQxyLaSeP+6t/qkUBn
         mw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268196; x=1785872996;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bG9xafmFIk3yWJdhDjVi8ky0s5VFlBaiK2/g5rblcHQ=;
        b=Hc5uPRh81vz6C2PidzllMYHnxjIbOLSR2sxongEL6zdAdGN4RRkJ0iVYvFQDIqi4B/
         TctSdMZR3yHmV7rT+9j53qjtlzoV0zVqnsZdhQ+FdVYFyzftRP0b4SlCF7jUYqdGltzi
         BlSUz8hnQWJAH4wBHsC7XvDpe1BvRyTEkKjNTcewqQHhh870jBWJj03cAeM79we4Ljvl
         gEb5P2cc6EDHRe3FAPEidVneQ4Smohjz/6EO38Un92K49Nn6vgxYrP+GE+28JlpnXSIl
         xyPhWab0FKygW+aomcqHLnHxMCvVywzOD/WcsIEJ7wT/2UK/eE79xIi85A2BBlfYafH7
         YTGA==
X-Gm-Message-State: AOJu0Yz5EZ+FM6R/GUcacODysKmCXrQaEJTeno0sqj36nCh/gNnzZHI4
	5aB5K+gF1fQkcF61vD5jTR4Pjfjp1gE9G0VFBooKR6fxmbOryRRw5BJDvWOcyri41FGRCTMsSPk
	vQKliPuyVv7T5kLQJayT1BnG4I1Vx++Y=
X-Gm-Gg: AR+sD12uuaiAxWLaWDoR4FAROpTrTxajMx50DmyY3bieL0fFU9SNkWy9dpgp0ktAmIi
	/r9spkgQt4Ir+TKJOO4W1qdIDGhEbqFlB+edjJPg+4z0N/X2+vSFritf1EXIm/C55QPgqhkF1h0
	XHnkZF/i/zp6qLJhliZaTHsKIaoCH2coxpzSqyCLLz1ytvUoc0tglwfQR3vFZSscNwFigLGsKOR
	bIshv8jMi94q+x7rpl6dPgjlW3MV8wiFYkugshgcWpzDdTQAHdpI0I2b0vqvw==
X-Received: by 2002:a05:6871:431b:b0:457:8166:ba36 with SMTP id
 586e51a60fabf-4586ce1a13fmr2509360fac.29.1785268196546; Tue, 28 Jul 2026
 12:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727115247.365341-1-omosnace@redhat.com> <CAEjxPJ7WpL2N7ZJ=jkNFNKpvFtWga+Ub8ufFwaPFZWzMQ=LqYg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7WpL2N7ZJ=jkNFNKpvFtWga+Ub8ufFwaPFZWzMQ=LqYg@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 28 Jul 2026 15:49:45 -0400
X-Gm-Features: AUfX_myC8qjr-dzuGPXHBITcXSKyJ2ho8SyWR5Lpu0fTHJuhb2SGNtZdsbiUdJg
Message-ID: <CAEjxPJ7qT1Q43tEntjSXrJVzbEjmFVqGfX_fC6Nz9_Cks7TVbQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/file_contexts: avoid using a C99-style
 for loop
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 9:33=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jul 27, 2026 at 7:54=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.=
com> wrote:
> >
> > The for loop in assertContextsMatch() seems to be the only code that
> > makes use of C99 features, which means that it fails to build with olde=
r
> > compilers, such as GCC on RHEL-7. Avoid this by moving the declaration
> > out of the for loop.
> >
> > An alternative would be to instead add -std=3Dc99 to CFLAGS, but it see=
ms
> > simpler to just revert to the C90 status quo ante.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> It makes me sad that there are still people using RHEL-7 but:
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Thanks, merged.
