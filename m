Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79813ADBA1
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412492; cv=pass; b=RKED514xgO2M+gtrwHrMzITyIce7uQrY3k9T+BR+qC6L4nkXCrJ6xarzLOA5/qSKMnjgayEgyIFxt+XJBElZhP9f62h2ZPKqPMtoOApjCAlaVb3f7AMpUzGf5mMZtFmZX7v9lgAyCqsX8K02YQIvhJzItv3O2fD56F3Yz9u9Ris=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412492; c=relaxed/simple;
	bh=tv0aFc4wSe/hoqxUdf0hXbXZEiRy+/k2MaaAL6f6FPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQ5GUkKP1NqYRocf2r8z+NapkKm/eeDbAe7/uD7NwXGicdgx2g/x/xJskuYfkP/Zb6W7g+GV3RiqJu4vxIIDPv5WHtJoC79kU/EihcRP3RDto6Mdrq9p8guRZ7kB2SxqhlTZjiA7CsYN3lRRO92Ph9V6LlapThuoV9POGO0CJwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYiEv+6I; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYiEv+6I"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39666f49929so31402351fa.0
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 08:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780412489; cv=none;
        d=google.com; s=arc-20240605;
        b=N8aD1dzCWeKpN48co+TQUUk20jJbJe3jcgwLMdljvg2RzdFc+BTGUTEd9SGb6OcsOb
         VWWFDF9VOsQgG8oi8o32szqsTiffPivZEaakKRs6PO/zHHFXUIlmPbv7BBRn3edGECOB
         bzcwEA4vsdnGkjX7MBfQoVf7zI7MJaZtGmtpRfQcJ5GZdO+ACIEkCJILq+RDC/Im7gGG
         treOnto6a9Q35+mBRp/3g/h8zCGKO/p2y1QrJqFFAMsig8fOmjJtafprMCVyCPLwYmne
         5DvGlNWXh86LRkCh/zdsFQXSQTb/+esYnFep0rfyFI5t10zNTSEERMKz6UexGfXeIaZa
         /g0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0GCrk5vYYVZywhodYeDveRlMEWIgiB6Kv9O3MJrrK0c=;
        fh=+D6xJ6BB9J6NyoJZZl71KoOEMrrFPGwz9kIyEgHHWvo=;
        b=Yl//9CwjdSbdcxHd0E2szxRTWAmbkooFWk0wQt9cHtPszuwK/2LbeJo7UkVqgyiqf/
         qWqCr6EMgGBD96HVFUshGAKIuGapcCePnp3oHnOS4tJbQQraK3zHvdEOEOfl4IkCfkJ1
         sG/xOM+kVpYWqF8keMJx62tzAJn7T+YeJT0TUJRbsIa1Y0EQ5rCKHO7WvffLNP5smwlg
         0QTU5mkApVHuADnOk4OiP37cKoHhITWw4/JLZp5dJlxRDU79rjICxQBBx80bo45YqJwI
         wMj3GVzcsIRT+fEmFBiUQuEDIkPjbzUTCN2RNtj3ncrA299oOeaEP9sfE7FozhfROWHx
         R/UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780412489; x=1781017289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GCrk5vYYVZywhodYeDveRlMEWIgiB6Kv9O3MJrrK0c=;
        b=eYiEv+6I/ScWXpdy5Y10XeAAy9gYMNL6CLkSEYwoza3IcP+NIgTvIVT+4j+jktE+L5
         ZePDOxHOEVTN+bs08Y4eT4XFM46pNUWXBAerYUgF94oImuWvAbrxmqxL4s/cSl9GEIVB
         79OYmFC5eQGFSAjOAR5lhueR/KWpkqU4ukD7byBAvfTBbY93QLdHoLrZWy16b9idAszK
         gn823/hLZpJEMZ1wHjzNE/gUHiXqgcYzLU+Z8ErFmgLLIoLRzULSSOYEpPCKpb7UNo0A
         38J1DwDvklQKZyIF973BWubEz5BMQlsH5KeHWeA50uYqTZswdvXQDQP+W+xD/MUAtOdM
         45bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780412489; x=1781017289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0GCrk5vYYVZywhodYeDveRlMEWIgiB6Kv9O3MJrrK0c=;
        b=UnESQEvNyZOP7J8QjY1mEk6bkPMkMbKyVr+m4jHJcNWJveQ4b+Z5EK6LxJAlUoKDy+
         cOmkA1Dw36q4pGzIxZ0P1OJTpm6Bc0rTaEe6S7eKUwzpnfhvnNp9sZEb9Upkwe248Gib
         UmB2QfeVIMcn+G0OASXSZwoD8E02ZFjoC8hfsot81zxeW5V0q/zTkx8wRPFH5K6Sn5Y1
         JsfMR2BYObkZXo+7B4Vv1CMqwP6qS3KBUkf61kmYvJm59WBYUQI3P7SJ6qUT98yvNDXu
         OupANRGJHw0oUCboxpAbxHoBfvleglf5MVa+9p7SmmLBTRMsJkhxBDTTLel4n9fHEEgE
         B+Dw==
X-Gm-Message-State: AOJu0YwtREEUdsotuA+XSI2o16yMb88x7ylrcyYErkk2z8ae+VvRDizL
	Rxj5W7b+zFc5O559gcMi3gp2MY8D+7u5jNwkPidCPBZCWC3k/GD7B7X4dWsn2V/pmIsEuB3EGLy
	KX43UWmdzVrwpqMcxOJ+bHi50KeETTOw=
X-Gm-Gg: Acq92OFFEtEsRJXBnp07MjK7Ysk/yWWWh61eHecDFdW3mgk6Xo0y2zq+cEbtNMJfZr0
	EMNENE4XcESLJwzZwBLp2rHwIzlKFQ57eZckflhVHEtRnf5vKOmcjpEoC1ejShB75w5Fgw+1BP9
	T7GR7Ub+n8kHYEDpHD2/b9mHKW+I/OgFANTlC8zP3b2WqtBFXEKC7KzS9sTmzUBoOcysjOWqA10
	VUZt6KLawlLjX3YRBGVQsQdQu0gaR/vVTzOtuXFOXSKYPkkjQsO3mIBMpviUraxCHHbUU7cQrhK
	dSFTww0+xZLZ8AA=
X-Received: by 2002:a2e:a410:0:b0:396:746d:a9a1 with SMTP id
 38308e7fff4ca-396ac2dd077mr207951fa.18.1780412487344; Tue, 02 Jun 2026
 08:01:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531054519.650723-2-nvraxn@posteo.uk> <CAP+JOzQcj47Px69QqLnNeaggvLkK=P254ALzDiLFQ9+hebBSXQ@mail.gmail.com>
In-Reply-To: <CAP+JOzQcj47Px69QqLnNeaggvLkK=P254ALzDiLFQ9+hebBSXQ@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 2 Jun 2026 11:01:15 -0400
X-Gm-Features: AVHnY4KdyG-mLwNuLpKofNYiJ9FK_CVlb5edpP-FmChX_BJGNTbN0K8loIalZe4
Message-ID: <CAP+JOzSR0zYt9a=3N5XD0_8ugfLGTbhq01S8WFL-AuMxFk3v6w@mail.gmail.com>
Subject: Re: [PATCH] libsepol: cil_policy: check at least one perm exists in a classperm
To: Rahul Sandhu <nvraxn@posteo.uk>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 1:36=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> On Sun, May 31, 2026 at 1:45=E2=80=AFAM Rahul Sandhu <nvraxn@posteo.uk> w=
rote:
> >
> > Kernel policy language does not support an empty list of permissions,
> > { }. CIL expressions may collapse to nothing, so ensure that we only
> > emit a permission list if at least one permission exists.
> >
> > Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_policy.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/libsepol/cil/src/cil_policy.c b/libsepol/cil/src/cil_polic=
y.c
> > index ca73bd28..e618ab13 100644
> > --- a/libsepol/cil/src/cil_policy.c
> > +++ b/libsepol/cil/src/cil_policy.c
> > @@ -653,6 +653,12 @@ static void cil_classperms_to_string(struct cil_cl=
assperms *classperms, struct c
> >         size_t len =3D 0;
> >         char *new, *curr;
> >
> > +       /* cil classperms are expressions, and hence may collapse to no=
ne. As an empty
> > +          list of permissions, { }, is not valid in kernel policy lang=
uage, make sure
> > +          we only emit something if at least one permission exists.  *=
/
> > +       if (cil_list_is_empty(classperms->perms))
> > +               return;
> > +
> >         len +=3D strlen(DATUM(classperms->class)->fqn) + 1;
> >         cil_list_for_each(i1, classperms->perms) {
> >                 len +=3D strlen(DATUM(i1->data)->fqn) + 1;
> > --
> > 2.54.0
> >
