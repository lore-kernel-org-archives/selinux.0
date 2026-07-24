Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A2B356A37
	for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903307; cv=pass; b=L6DKLU3fpoYSd3Ur7jZDAPwxUYIztrxr93Slx/P9JLZ0INBCeDKYCwUR/zkCSjTTv4No9913iZdVXRiSDcP9FIUEMpWN8dd8OjOOAesUS6JtGhs9qA0OrzcR002RhqPwBZ63DygOeLfM3KLX0MEUyunzedT1INML2cj6dINYCNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903307; c=relaxed/simple;
	bh=WqSLcUP/WLaFznF6ijwZZZbq2UvgJ44SV2pXxVL1HeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDHcX5wOwa2YtP7ileCY+rf1EVjpPgQVyKCg8FmpiYTkjpXUk3hNT1YTaZjS/H1N4hfQo7BuG0p7kCBeTlk3+WCxF0hS3HMCU2HbdXNZWUo/o2eLT+J+KCZv5EvlCTJFGcbfZBF8AXgH7C9BJfp3n1fPQcSgg/Q0nGu6B3OOTHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgdLz42/; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgdLz42/"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9030f8ea3b3so5280316d6.1
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2026 07:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784903305; cv=none;
        d=google.com; s=arc-20260327;
        b=U/XAdPmLKaepPvnzIAF5boUEA9plQodkM/NcUQ++Mm7n5eJ+vvC26gRvinfrDspL4+
         IOj3IJHnlbtKUa1kJSgXerRObYUJtoi65zLLNVaiMMv8bwj476R3oaC3SahlSVbfjrXp
         fOwRltAPXdCyHm9vgv/qXUIELS2wNAkofudxu+zyFt8WPo9ti711kY0QNLMnvPkM1YkW
         nRQ0NR7F8qyUgUg4dSvMrBoIQ9DcszmfUK2Q/YrAHUk8NPAGsZlpcgy/LMGz/mR+Vyzx
         ox+O4+57rWhxp03yZaZOlAE0gUnkg3pOC+1pMp0LjqW0uQ2Vk3VDZggCpxxejGn+VIgX
         Ob5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o/fFvO/pCUGtFw8oJkKBJO5I/SntOy8Hf5FE+fjQLrg=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=ZHpFGVOs0deH5dzTrpbDqSooEugZyLxvTJcu3P26/9shmqh7U2/9/87bO3ojbdTvzC
         V2ykpearW2VMixMtsODQov60umttONErfscSmTUgjBx91qUVA2rQvjLsRuKEOw4bNTzd
         MzDIr+CyxfM6aVXWtkIaQRsAWsvDZ1B9inarrT37rBWb7R4k1fnm+fGbDIUfZN2grAvi
         GSqhH13XDsnM0l4F2eMEcAGV5NREv2PaSMzDEjTIaVtFHzGyJ9eEmx/xu/Gjd6VUtkSD
         lnD/WxilKn7yflO2gciCClNzJSVw4k6dbqKFFEU/ovbKz0L/Fcl1/VwrXA/pLyOUJqO2
         zXMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784903305; x=1785508105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o/fFvO/pCUGtFw8oJkKBJO5I/SntOy8Hf5FE+fjQLrg=;
        b=FgdLz42/grXuPS0LvIpy7IvOwBEA5Ply0y2WxWpr3+gz8qEy6rNyt9AvtOuiAfR4Ra
         Z9g+2IWtKqGog35luZhqvvqt1sPeT6WX7vRRAAzwYulpPfugdDszNIiXaE9BDpgMFj7d
         ID9Yi0hxYMHhTETv2qBB0p4ZWmgOH6VtKeo6ziN80P8icXFRdFxy0xfyBbGUoHcoqkAs
         PKFUkfx/KSanxnH2U2XbvYjU1NX72v0lf2+RGI9fX+2WLPewtH6Bb7ksmi2ON3i2QBkJ
         9ukonQKM+EnvnZN+yp9R3YkPVbWUOrzu5KQ+TN0PEOgSYyd3gXtxKbOHcyPLZOTDX6AU
         aYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903305; x=1785508105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o/fFvO/pCUGtFw8oJkKBJO5I/SntOy8Hf5FE+fjQLrg=;
        b=Anzs7w/6wwSQvKbXgjPZ4DLjk9+k6msTC+EMT1E7BLSVgdP2o8MlfZVc/RbCRD4A91
         2KIE+LhnDubTJWiYqMDnPV0hhwwB/+SP3wtZjeCaKNmRtPWxqUgOFt5D18PhKdF0i4hf
         GnrszJU+Nxs2DfVanCwucPMgIRHfGfB84xtIaktoaHlXm/0eQeycJZfdJjmpFkeO9Dvi
         G+27OSfHtbokXThIFLRXEanuUN7gOHiGFKSLXZfaTXTwEw1jMDzyNdHOpAvOkT3KJnSZ
         zZsHQaOUTcsOQ+EQVYEBysJoIG7AocQzSWfCh63gG1dvpRVX45o5bB+URggX5uaeNNjA
         zpCg==
X-Gm-Message-State: AOJu0YyQU/ABo5USx+HSIpYoN3dQ2Pcx1zLaE2noWnh+b6Vp6+jDc2uk
	H6CPMsRV/6l1nLqpab3F+DCf+NELLV6X8byBltWWhhDjUHMUPkwf/+7SJYaqh+70B6lulysxKou
	CAc8v0eJkYrXfs2O/hoc2BKQbncPtUZI=
X-Gm-Gg: AR+sD12mz1Rm4JpTKtfFdhvKNfjVwKFp+GVRMIbvV0Auk9Jfp5ciBl6nmtStFPv26Kn
	3Cq4H5A146DBl721hPR5GuPAU0xbwZUqbofObY12jzf7hfJmeuYXzPlKwGDBj7oqmlFEEr+lgUd
	4hZIeNpfqfYe6kOf5Jx7EUul6YlSwiHtTRB4D45oR+5d/+JvYqR6kyDwIw2lSToxyvTJnT/ZM1R
	Pd+OlHu2Ox8SVzh7HpNz9QoW5BU9toIKQBDiC1MF90A00xpqHBi7h5Juk1PhA==
X-Received: by 2002:a05:6214:3a06:b0:907:c6bb:5cef with SMTP id
 6a1803df08f44-907ca567aa5mr90954616d6.56.1784903304945; Fri, 24 Jul 2026
 07:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722181325.107755-1-jwcart2@gmail.com> <CAEjxPJ4yGX0joHcb4kajTozQS6jM2ddVckZB4VeeVUzmCw9PBQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4yGX0joHcb4kajTozQS6jM2ddVckZB4VeeVUzmCw9PBQ@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 24 Jul 2026 10:28:12 -0400
X-Gm-Features: AUfX_mxZw1DV2EzSLcjQ3bWNb-o1WVr8jD0vz0-48lQUajgtCB2g6ZgIYtyDQ2A
Message-ID: <CAEjxPJ5fG5tVCaMmw5DUNNSUXEnt8w7wEevuhHziGZCVqeAnEQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Check for embedded NUL when reading from policy file
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 2:39=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Jul 22, 2026 at 2:13=E2=80=AFPM James Carter <jwcart2@gmail.com> =
wrote:
> >
> > Check that data read from a policy file does not have an
> > embedded NUL to protect against maliciously crafted polcies.
>
> policies
>
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> Otherwise,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

>
> > ---
> >  libsepol/src/services.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> > index e8f0e622..3e8bd38b 100644
> > --- a/libsepol/src/services.c
> > +++ b/libsepol/src/services.c
> > @@ -1799,6 +1799,12 @@ int str_read(char **strp, struct policy_file *fp=
, size_t len)
> >         if (rc)
> >                 return rc;
> >
> > +       /* Check for an embedded NUL character */
> > +       if (memchr(str, '\0', len)) {
> > +               errno =3D EINVAL;
> > +               return -1;
> > +       }
> > +
> >         str[len] =3D '\0';
> >         return 0;
> >  }
> > --
> > 2.55.0
> >
