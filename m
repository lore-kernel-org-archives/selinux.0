Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F323546EB
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236365; cv=pass; b=WjLgEH/37eXaGppDsEG3YXIK07bYQjXZpZiieKkaleLdGkqFasbFtBb0CQj7eybrCWuMYCfCVZ+fJGj8HGRFsgaT0ZuS2Bz9AUPtRTD0T2A7zUuFm73iDYUpdog8R5rMcIdhBM+emjtd1aQrMcgX93hb8ETMVluupj5jkwVu6UM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236365; c=relaxed/simple;
	bh=N9qRFu4WM8WnVsbLoreYprSqHgn/OjQDC6eflC7v4CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFvt7iBc5GqzNPmoPlFwfHTKWkI05PaZyyvH4h/lmmKeRWVH0+zm6A0cXSehvuLDE2TImGo9VuZ5EZNhXm9yUg1TNWA+kNwFkwUWEvFx0lu4bA1mmYE89DlacPqLDpfNEh78qpJGPXpq5Ldb4Gys4N+7fWjB0gXDkMMGYhGs6HI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nw+n33BA; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nw+n33BA"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a422090b2fso551679a12.0
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 07:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787236362; cv=none;
        d=google.com; s=arc-20260327;
        b=jrtOc2slp5iCmRpyf9jupxcAjtNvZQjdMOncx4M0RpozPdWdG4Sw7Rvj5Qy6XukuR2
         mQ+6iHlVeE6+9P7ZJpSW6pOoxeWumq+iL92fQy/nES/Y4pFrv6FQZiGEMlUJaFlX5pGa
         sA05q2NzXcQOiLdYnabzRFfJBM6bW+H5a1PagCh0W/ioN2j6EEquKo0HBIOxyk6vMJPE
         yHAc0nVNxslPCS/odHZ0C02rxAVDKFZyhGWZE5mLQEMeBgMx12e2GsJEv/NmzXHI/foe
         ozw+d3yaAVM4WfwWtTMtAqJq0L61Ug0oD0c5WpHn7vhioVzi0J8KYchtS44feGQoREeZ
         lyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+3owqiMuWuSPH/bhodOVPPoGcMgRZTIUNdlO0mdLdRE=;
        fh=HEhgrey17WyQxMYho9jIh7HdbMzhrjcB3qENpxORZkE=;
        b=B6SRYryqPxDgCmLlW7YaVNf6Gs8O8ZWquuhZMBWyBEMXBoMvyu+1LgJtAjRyZZBCmo
         W1NyzJoKR64SNoroNRDU2S5P0Kh7aYiyO+MwxUiLvwRz+cKRi9eM/2yLMHU43xz6X6S3
         V/IR3R0PXGH/AGUJIrc2oIOgWARt5YxFqGLpri1rV2r4gyvfC4qk3Y6PTM2opjxScxby
         OoobafkYj9XBKdDSMcfZ9JAvnsYaSt2jbhUWxGd+qca/BlAFvfUcrr/lLkFhHs+7HOH0
         h4FZLY7L+pgi1bRjhvg4APuX0P4Ec5k30c2Xz8C72aqNTIG0gRh4cIjZPAPUyuJBTVLw
         ncUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787236362; x=1787841162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+3owqiMuWuSPH/bhodOVPPoGcMgRZTIUNdlO0mdLdRE=;
        b=nw+n33BAxcbmIcTtLDMF4ZP4rgK2HZx+JLkvY8W+XXy9dFsoyMwYFpmoBPEDNFMZ6f
         Cp5jaOBVvcgy57gZy7CrzLtxvwNrxDcfLRFci5SF2bCKyKy62EnHr9WAeI+A4k+pI4Kb
         dsx2WXVOuLLev6LUgXvDXYDlqGhVE3heP4kX6EczFQkuSsQVnYESpuJenh2O5UWfAwHF
         oPTmqZ/BqpiuI1n1oSHDqi82IxX130BjBnUdu/Yb1Mtse7nZehMc4EcxZhlN5j4EUkPJ
         9wW6U1nB1V0IuwHNG1Tu7ocSQX3QYXz07XVlrFMN1NK0vk7dKk+452gDHSXX4dujdU+x
         E9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236362; x=1787841162;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+3owqiMuWuSPH/bhodOVPPoGcMgRZTIUNdlO0mdLdRE=;
        b=FumrwI2wgAMA54/n3fKIn9PQJz9Mxh01niPj+gDvOPlVJcZN18CFxm8HEvXs/mg6tm
         nyawF9zWMNpS0A/Y8+H87eIdVTCzzYPWj7XkjDxmQDDxlqs2CkI16CUoYB0Bsa1w3sHg
         Vhf60LHOXZRtT/4pmeqLQ0QWuJnH4IbemihArri4M68jO5v7gHLxIL+wUoqjcn2PniJ+
         Kelpx+lUOO6gDOlHmkV6HvK4AU7+PNF7wtQCdzrliqeGtm6n+KKaJUoRTuTHCAI5HCAW
         ILaG64NQgRtABhonzVzNeE58Gw4s7X9XScJ+hMb+4cYDnVnfttjcFAV3vISxPh03xBfu
         SXEg==
X-Gm-Message-State: AFuF++kz37Tllb7QncGkVebkfcYoa/XXRWy3Ije0VUZW+wKUzdiO36TZ
	RnvQLAIoZTIkIhU/hMWyWpU61JPc8fvjgGSjYZXRiPIMfq9MBFOkt9av8i0wtvtIzUCDBKuvjt1
	bWBN7gMMH9tZBxM/paqCEmsbnbhN5DUc=
X-Gm-Gg: AR+sD13TWm+Z6y/kATPE2aDXyM54Mu1W3B4r2BiApnzEmoUNFzLrl91E0R9s32ZNMrp
	vKoTRj0AWhS9E+A/DyF4HMwKECuifrsR8bnJvdDnAsnPUoOtxJurrDZS0bnUFTbuSNyeNqvTmdL
	lNy7DwqTGMtZ7gVIUOj20WJUOVQesNTKzjWp/4bu+lGdAFwWSsVTZa7VAEoVYOzBvUnfEFlkW4b
	VQtITMFivvfBzmbcFN5pJs1nFe2RsaKEveQrZGv7+mOTtPrKfKJLoierVu0R/jLAE2keVh6zWpp
	QgONs3LU2DEUBvd/ImPoIQkrh3ycck5508fP1dWMqdfnshhqcShK2eNc
X-Received: by 2002:a05:6402:454a:b0:699:728e:48c3 with SMTP id
 4fb4d7f45d1cf-6a4032fc5c5mr7757816a12.9.1787236361471; Thu, 20 Aug 2026
 07:32:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820061349.10542-1-kmehltretter@gmail.com>
In-Reply-To: <20260820061349.10542-1-kmehltretter@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Aug 2026 16:32:28 +0200
X-Gm-Features: AcwNN1XBsXitogIEUq0ntdJxL2LGIShvPphxQse83cuHfD_u0whlH1Af-ei3Mks
Message-ID: <CAOQ4uxhgMNvFxauLzm2PQif_D164+rJqmGdU5T+XDfhMJTVJnA@mail.gmail.com>
Subject: Re: [PATCH] selinux: preserve user SID across nested backing files
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 8:13=E2=80=AFAM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> SELinux saves the user file SID in a backing-file security blob so it
> remains available after mmap() replaces vma->vm_file with a backing file.
>
> For nested backing files (overlayfs over overlayfs, or FUSE passthrough
> backed by overlayfs), user_file may itself be a backing file.  Its
> fsec->sid is the SID of the mounter that opened it, rather than the user
> that opened the top-level file.  mprotect() then checks fd { use } agains=
t
> the mounter SID.  This can incorrectly deny access without a domain
> transition, or check the wrong target SID after one.
>
> Copy the saved user SID when user_file is a backing file.  Keep using the
> regular file SID for the first backing layer.
>
> With two nested overlayfs mounts and SELinux enforcing,
> mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
> mounter SID.  With this change, mprotect() succeeds.
>
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Tested on arm64 QEMU at fd6e2388a3ea with SELinux enforcing and two
> nested overlayfs mounts. The policy omitted only
> base_t -> mounter_t:fd { use } among the relevant cross-domain allows:
>
>   baseline: mprotect(PROT_READ) returned EACCES with that denial
>   patched:  mprotect(PROT_READ) succeeded; test exited 0
>
> This patch fixes SID propagation only. backing_file_user_path() still
> resolves to the middle layer for a nested mapping, so the audit path and
> inode do not correspond to uf_sid, and that layer's mounter is not
> re-checked. Preserving the full user path likely needs a VFS-side change,
> such as having backing_file_open() store file_user_path(user_file).
>
>  security/selinux/hooks.c          | 4 +++-
>  security/selinux/include/objsec.h | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1ead2eee1944..8b96934e9992 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3849,7 +3849,9 @@ static int selinux_backing_file_alloc(struct file *=
backing_file,
>         struct backing_file_security_struct *bfsec;
>
>         bfsec =3D selinux_backing_file(backing_file);
> -       bfsec->uf_sid =3D selinux_file(user_file)->sid;
> +       bfsec->uf_sid =3D (user_file->f_mode & FMODE_BACKING) ?
> +                               selinux_backing_file(user_file)->uf_sid :
> +                               selinux_file(user_file)->sid;
>
>         return 0;
>  }
> diff --git a/security/selinux/include/objsec.h b/security/selinux/include=
/objsec.h
> index 3c0a16ec978b..853f7266ed18 100644
> --- a/security/selinux/include/objsec.h
> +++ b/security/selinux/include/objsec.h
> @@ -87,7 +87,7 @@ struct file_security_struct {
>  };
>
>  struct backing_file_security_struct {
> -       u32 uf_sid; /* associated user file fsec->sid */
> +       u32 uf_sid; /* top-level user file fsec->sid */
>  };
>

Sigh, this is so confusing.

The fix looks correct to me but I would use a helper selinux_user_file() ak=
in
to file_user_path() instead of open coding the condition above.

Thanks,
Amir.
