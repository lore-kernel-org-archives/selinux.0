Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576A27B50F
	for <selinux@vger.kernel.org>; Tue,  6 Jan 2026 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716441; cv=none; b=qUlfdFdf/kPPuG/AQl/eGlzT1bzb1bCevjY22v3Sd6b02Szz0HiNTO7cGVVyasOIP7o96E0GkKJcbWuGcChNKoSYU5lK1ZY3vfNphvURITIViypwiHs1TVReMjFbxupjlrinX9solq6mre4hmzZx3MjH7KkRXbEzxg52qQoFRtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716441; c=relaxed/simple;
	bh=ey9DGZpqsRgPjTtCRCTSwXwTi2wsymLhSjsMAZDXh1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FdpSkiN7JdZE0cpBVz4DSDRElxCxwAp5qaCUOcltFxoOfr1jjFE+8IYWAsjZACKm3idfacFIFWYU9LhaTDYhz/HWxR62QMMCjd3bkJaEzHyEc43hXmsHuf81MFVWogYj/AEkqZ8MuyckPlob7n1DI4me0ef8IgzpFYkWMd2ZnE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkJm77BN; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkJm77BN"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34abc7da414so977014a91.0
        for <selinux@vger.kernel.org>; Tue, 06 Jan 2026 08:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767716439; x=1768321239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhM/zh3ibnOZJErXiovXEvnYjagZcW39EDCuTq3+OvM=;
        b=EkJm77BN1al8AVgUw7ADA9asEZAgxt769arz0rWmzlOIyN9eXLprCN83dwBtzHYKE4
         CSv/oQTExKufvyKCCGhFNuDknXAIOPRA5pHuT+psaPD8vGMt/3YgI/uLdGUZgDZjP1/e
         1qRmaVaM01P+d+wXB4nqcfzWi4kzcJ3mUU5Ah99vfzfkyJU3A/MF8gTAmvSdDPGhk6Xt
         jF+XCxLInA6PsAIdccKqe1z1whD5CNiphZSdfRwmtHT2lXMJ/F8C+s7Bl9bzdizFHG5/
         uA+Agq5oxjm3gZQS0/xO3H+Pv90fTDlcOKg4Vy/Td8XKQhOOmgXNFwGj0BhQe3QnjNYr
         2xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716439; x=1768321239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhM/zh3ibnOZJErXiovXEvnYjagZcW39EDCuTq3+OvM=;
        b=RsA9kRHX2/eCyaw3jUyDvCsZLQkqbQTR6nMu+UO2scTI/xJXFmdNrSoVtubZnIRqCU
         3GDkMdjhvY9Af59G7MBUvCTElQDvLviWFlIkto7mv7a+Ao4ecEhTRbDjhoaCh1Hr9Yl2
         +WYpJI+7n+NxmZ6gQooW/QmBA8/6wlPTYPKaemwQ4auulQ9Iv11thgdRaG+8Jn1hdwhz
         eVTxZtzEMSrVfHeh67O5WAQ8NDm6DcgN9Umkk6QBGafBdWAVgaxqhwtCKSysO4Z0v1Y+
         sJWQlwu4olmrxoH1WtbEoCotkJbCDDI6oQKK324SiM5SPoYbx26XBFiZi7Fm7LAIH6wy
         hQHg==
X-Gm-Message-State: AOJu0YwQma9WdVX86qtWFyyimObS/mqDQ3eSke61DNTyaxon+IISGr4V
	agl/virh5y31ywlWSFM6RRSxaYk/1F0WKkxyC0hlcl1GcHKx2hu6rH2pT1Ikdm1lU7R5Y35pb3S
	+NgTevLoh657tHkbNiA4SsN+qG9G32eE=
X-Gm-Gg: AY/fxX4Q9s0gtl9eofiR6FCeyBoGd7FSBXF/Bn9uVklqAlNCmRmlqesdxHpj0REXxDe
	5ra+2A8N5A1ylxSB64G4Re6eJXsOEdrzq7gQX1MZXYd1oLErdmKtd/4rFkzd2OUBeywDBTBlJ/I
	fa3wRTNqIgOxmAAbtNxAT9wvabSXqnlCR2hKF2IfEZpz8PneKf7XpxlCyeg7gTwRhIBAF3CsS09
	jW/6O4JQNk1VQ0Fr/IFt0jedSYHt1mJxFxm9ehK/0qJZxRQ5FFVAbYBaGWy4svvkONxHwM=
X-Google-Smtp-Source: AGHT+IGOJaSysar1pWdibVtQ2evNNQz/gB73aG3t1cppcvFYcuDmqbXjPqv1L3OJ62/AYihusQvBBplEqFERhv1/g8Q=
X-Received: by 2002:a17:90b:380c:b0:340:c060:4d44 with SMTP id
 98e67ed59e1d1-34f5f28d85emr2948207a91.14.1767716439470; Tue, 06 Jan 2026
 08:20:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <65a70099-a752-42d5-adfc-5973c21b9710@linux.microsoft.com>
In-Reply-To: <65a70099-a752-42d5-adfc-5973c21b9710@linux.microsoft.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 6 Jan 2026 11:20:28 -0500
X-Gm-Features: AQt7F2otdECiM5dpkILWgjxaCC0YQcL6fCgZmxFHLWTfEHMjTZPplIwVKgBVSr0
Message-ID: <CAEjxPJ6yhZSbzMWXq4sQQ7hLydzzmz3i_Bnj9nhskdr0rWf5Hg@mail.gmail.com>
Subject: Re: RFC systemd-sysext/confext image context mounts
To: Chris PeBenito <chpebeni@linux.microsoft.com>
Cc: SELinux mailing list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 11:08=E2=80=AFAM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> Systemd provides tools for composing directories like /usr and /opt
> (system extensions, sysext) or /etc (configuration extensions, confext).
>   These tools create an overlayfs at the target location, with the root
> filesystem and extensions.  While they support raw directories, files,
> and mutable filesystems, my current concern is with extending immutable
> distributions at runtime using additional immutable images.
>
> The challenge lies in ensuring proper labeling before deploying an
> image, which is problematic for third-party images lacking labels or
> using incompatible ones.  I haven't made any patches yet, as I want to
> consult this group and the systemd developers first.  My proposal is:
> for internally labeled filesystems (ext4, etc.), have the tools validate
> the image's root directory label.  If validation fails, apply a context=
=3D
> mount using the label from the contexts/systemd_contexts file in the
> policy.  I'd probably also add options in sysext.conf(.d) and
> confext.conf(.d) to override this behavior, such as for specifying an
> alternate label for the context mount.
>
> What are your thoughts?

What does validate mean in the above? Check that it matches the
mountpoint's match in file_contexts? Or just check that the context is
valid under the currently loaded policy?

A potential problem with only checking the root directory label is
that those are generally the same across all policies derived from
refpolicy, whereas you are more likely to find invalid or inconsistent
contexts on leaf nodes.
