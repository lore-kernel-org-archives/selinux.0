Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C111C33A033
	for <selinux@vger.kernel.org>; Wed, 20 May 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281889; cv=pass; b=JwVjsLdxexITmt9PaTq/qjNNDHQBFHzNPtu1r/ellJI8vmVWkKtAwCqyA+ajbN8ZUNEUKg0mUW7NwdSHHUQUCtTDhHDF7ynq2C1uNWVj1QCi+WvzgGh7dtxUc6I7aQI1bG44Kf7POexM58ZaTPw70j9CRGLJd7ze020d/K5nx2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281889; c=relaxed/simple;
	bh=4Rjy5pOMUJhmxkIeicghpD7jLrdCwFUDkD+1ADzGQYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CR9IHF5LevGBnZ++npElygSReQy/K7jjUKJr2UePpkvIcC7/zWAlvbS4/Vi9WQ5GhMgZRudFJgWQ6PVu1M9yJrZihzQON8IFZe2NREvu76E8K5njWNBQK4VeZXKdv6i5r7MF4JVyRjxaWuFhtqdSXwMjznoexgx7pL9eYczBZtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKj5AtVq; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKj5AtVq"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bc7b311e77so20504235ad.0
        for <selinux@vger.kernel.org>; Wed, 20 May 2026 05:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779281888; cv=none;
        d=google.com; s=arc-20240605;
        b=lnDhwnJEF1dTPDz5D0rD32ipMLe8uEHfQutPUHY1eWQFX8NECzTaSi5wAskn+lgdH7
         Z7jQi/mTPlYAcGyE+LMxFY6F16Vq44noEeaZ9uT6YE8JgFDMzAAJoX5hGTc6QVpmNzjj
         eIC1N7pnk57DMjAAMUJglsXQzqCwec/8UYwp+tPN6WD8tzJiycYxdm+vMLDgcoL8tiB0
         llKcfzReKjn1vO5afsRu5wkfWEZFiIBKNhA3s1a3yxxG8uE7JjfvgKUUMgEyLDqa6Se8
         hl10OQtOtd2i5y8C9qV/Pvq8sP0PzSbcnOMsEfj9KWE1KBr8PRlJ4ACWxKc9LsltL8PO
         sH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Rjy5pOMUJhmxkIeicghpD7jLrdCwFUDkD+1ADzGQYY=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=VtqXPDxgP+kEVy7Zr0S6PmowoJsNdoyeu+7LNoY4f2+m49Xw4cKt0hV/S6R4O9gbIc
         rAT0w0YyN+bG0S6rDyJ4XsxJhuZ2Z0JpqT9p6KWrAe06fMo+K4jsVRgeMA4HCGOSOvf0
         Zp4Vuf7i6yGSn9v04W+YaR/uQzdq+2pexkk/+9TsRgd8jekJ+/7mYBLxd27sZb00rUfn
         Tz106/aEa5aAU/InaIiyGLWDLfhRbMjRFJ0b4SoTtdS/Bb4hA3N6pBsUS7BXKlFpzb5L
         dvElt8OYqhlQk90L+FdRBoETQ/UV4zRjtfr5imTUiiUBxjPZX9GAbINRqefvQj20WwRb
         PXAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779281888; x=1779886688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rjy5pOMUJhmxkIeicghpD7jLrdCwFUDkD+1ADzGQYY=;
        b=QKj5AtVqDMBurOcXuKZevNKGTGxkQYcX6syzHEweGM5zprIfhZwa6XrpEOWO4BZaQY
         kl4IyIVYNIFtRVBiBo2NISx3RvFGIoMoaW2PVNTyjMMJuqQbwjqS+p/+sQLkUG9gDFya
         NkHsnZzZ4TQcDyNHcj4FQM0DvPosxgtXTEQn9xBaaejFwQ+N+k3g9JkB/ykDOXbtjICw
         ItzCS0qSX0y11r8Ei8wGEY90Ir8n8rP//tYLoP1k2s74pi3Mf2MXRp18TWICESjcyRzg
         EbBgcBsbo483mr5mErSLkxJ2zGC8EtJkJDp4Qo6UpjHb5YCz+xwlsIB56A1/7xq7HCVv
         T0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779281888; x=1779886688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Rjy5pOMUJhmxkIeicghpD7jLrdCwFUDkD+1ADzGQYY=;
        b=WSXhu+g3GZiPeP1a8fDKHz3D6a4jmFmRa3snfxGYTdgfWjxPFsbYwaIVmwoHxxl6Me
         E1VJPGejY5QAZIB/u8PTiV2L37Rp+BLfEMocoQ7O/UeHeOqAeIE9KHUebPiyK7Gq8mCO
         wKG/88lAluSWlQqLt83sWIKrGRE7iziQv/5d8JgLaeTz2CfRkAbYWdbsJUpFjbC7FJhq
         vGe4EYA2HzBNCQ5O92izebCxA6kE3cha90U3NrItnTP3e5SMN9DA4RlKv2Lt0Us+n05j
         1RLBAougZL40AAMfXhQ/3XekqKJOqKAED3Cv/tv9aYSrbMlWXRKelYlxnZZRHALxk5Vp
         F8LA==
X-Gm-Message-State: AOJu0YwXt1nJqQhCY8vSZKatT4AV0LyXEy7SRQgHzs/fEF1gAJGzpRYr
	yAvjVGyOtpmoPw5bJH/5hCJxA/fdkJpRsbn7oxJcjyYLInymy0Lp8MmI1RykP+fPaXSLYxRHe3p
	8Osdag3bhPT8vM1Mfyfz30AkIWBXST+HBtA==
X-Gm-Gg: Acq92OHSyNVLUENM7tQMLrwz4cqZKzQ7oElFCf4qWbH+7hpfml9ZioNrs5PWdFrQ5v4
	gjUzwXvSFw1F1/l+B4dh5AMv+5wlO1Wi+8Hx19RJpNd2PcWU5/Yfw0AGYGokzaLBO2hsgG/KpY/
	GKgzqWYnuM9GpzcZoVyWvY4xIaMK5lQ35r+ezcFmto4R2MHDK/sk+nget3qHpbP3D5G/GIrBxK7
	Pfv5I+uD2wMWuLdV+6GWAStBVe8bGJvqE0Gs501GdpBXvpb0zsN8o0CZzBzpTWiEWZcd5YH7BJS
	4ktIXYRo4Hv5DxIITsBoTh7SEOuO
X-Received: by 2002:a17:903:283:b0:2b0:91e6:bc18 with SMTP id
 d9443c01a7336-2bd7e9004e2mr191255015ad.14.1779281887747; Wed, 20 May 2026
 05:58:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519121456.377096-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260519121456.377096-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 20 May 2026 08:57:56 -0400
X-Gm-Features: AVHnY4KdkYkrYYlpGvpNEKG7EZB74b75yrTmHbYZ-tjTdBiTeSgv4gVFa87fzfA
Message-ID: <CAEjxPJ4=qFbvpSZOyfVthKJfv=6oF+2RHLvy3hCpwJKYijzQaw@mail.gmail.com>
Subject: Re: [PATCH] sandbox/seunshare: fix fd_tmpdir_r check
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:15=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Check fd_tmpdir_r not fd for a failed pin_dir() here.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.
