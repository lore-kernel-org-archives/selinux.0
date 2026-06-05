Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B37036DA13
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674600; cv=pass; b=NSv/tlaSuOt78OeRiBeQUxKg8YXTaYIRMzNDgf4oYzvfCnpvtlGtGdby/uYdI51gYMjff7WoF4/l1iisyPa8V33bqQV0YpkEn5m94EPBYRUcRHVx9IJgU3iUlQC2MEAHHGTbiTwqqndFshqTxLK6RoX45LuKOCmNP8mc/gHCEk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674600; c=relaxed/simple;
	bh=95JO41Ku8xGrF+mPDX30oDKLmR2TjMUfC/Pft4ocfTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBhg5hvhFpgDNnSF5IafLXJVwpamu7f5V/A8wF9NHAw+SVktVA0W4ZTGIMimrVMWlgEunrXpjpRmQkrA8ADrFylwgI3oKwIFUYGmXJwf9Q6WBpSGToZGbkLYKWct0tdht0lMn2tP0YuKAmZZ19KKu9AO+SuR2N/nalxj97Fey0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdCs4mZu; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdCs4mZu"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so1349273a91.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 08:49:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780674598; cv=none;
        d=google.com; s=arc-20240605;
        b=OlFdVpg7ApdqfNjmVdQoGLuxWCL46cIwwqFKPFZ+yFZu+suck6wPBQqQXZHM1VP7Tl
         9SJvd+EXf2d5lj9jXguCicBEiDFbxaEv3V3k+hPL+NAXQJohe0X0PkTULKomQdOX7oaw
         gYQmFvZGVGD46AfLg+Ri4i0/Jp0xnwH+pZ+InBE8GKTr6RZgHIW7FpHkhRYrG+ZNb2Ce
         5VZddI8FHsAtezqZLykJuoeaxkobvMAH9Ym8d4WZonfkuw4TUuzV6pHyUoB7W03FPesM
         so0Y4zXSCLe5rIvLdu49b8uMLlCqswUiV74Lt22WKbvfUce+TkoUKlOW9hdVnujrs7z1
         YV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k9xVh/G1cjMJ3PHQuQLFEfV659EkTd0NydkMlok4hXk=;
        fh=5BxwEK/iVIzhs7kNCBs0/zEkT4yGKFLka6Po5B0u4CY=;
        b=jRQr1MH4xf1JGq+2RjmvkvXzmdr9piIJuEVk0II32YccVwNDOtIrz7H5BRbGV63NvF
         kAOT3E8dXjAqXBir7tsyrIt/tOJiNl5XIAJQRglFu4oAB/kB/KEr7BeGT9RXpWzjMWR6
         O43UQzhJdKlOwPr26Z1d6cEx78FMbGXTqQurNAWLCtbMZ/Ehm1EVa8MHIELBwvvWWgE4
         9+GLbsWxbA8s0kLBShyWHiR65ypoHs8D0Rq1rVENsO3mAZhIGAVnUeJuQg18GR22knjx
         GC3aBN7wgp/AFmBDjZELMqdDswLgqAS0DWE4yPd2lMAi4WdU9pGKjC9daacuy0bZ7DYs
         GNMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780674598; x=1781279398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9xVh/G1cjMJ3PHQuQLFEfV659EkTd0NydkMlok4hXk=;
        b=CdCs4mZuWlglbReTo2yGMbDokAAaRXhn2saxJ/9uNdPrgF7Qd7p/IryZoV9flaeKRz
         hi/nSWWRd7URC/1u8nPg+IrpxlHdo0cej/FP91iNMiyimcP8zmXi+s3311GLP2DwgCm0
         6Ud3ZtY7L8xUYyaBB38t5Qlf4NSwoixmsZ+KPuI4tdmKYGHdccJq6G4Gg9dpnLfVLkib
         ejT53627gFU0B/UrqPZ2u5B/MzEGrZUi0hPMNJpf6/7BfML7r1kTfEszBoEk6tn+OOTL
         X/G9BtPuSXRsW6NodZ+daz2nS+dE2M/ybIAnro0wVz9DQc/8xP0MtrfaG1BIqnqHzzum
         21+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674598; x=1781279398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9xVh/G1cjMJ3PHQuQLFEfV659EkTd0NydkMlok4hXk=;
        b=dlvjwz3ZbUhdV0b4unyTs/EdCRoPWwsfUYJAasB7fmtg5E/E+NYL32FCmpJW28hGBq
         2QxhqPXPwa2hq/wgFbCaqioeS+oxzWn4hhiSIpMNE3EcJNf4apGybQrqgQYxk4oVuqSB
         ApIjivVeT4Aou2ObETrcF3wdLxo3GMqchJYct258dEHk8BGQCRP3+7Lx1VaP9rA/F7dc
         66gLmVEDR1Z5dUptFeVcl+Sa99Bj4MXHaf4R6u0WTd36JHmsTQW0GfbA2YG38BgHUU+3
         vXn9OsrD+5279xDv3Ll2OTvc4bPbYJ/MSdZWXTPTEMphumjgKOMedk5w5bUcx3yojRL0
         IAIg==
X-Gm-Message-State: AOJu0YzvUV1H9mGY6cZbu2bCIRXyVJCzL9Z7L8tqnmKDmJHzgPSRFffy
	h+Et6vm7bJfDAVP8BVwnIhshOrrGpvv3rDTX4OCOPhR08I28k6bea3KON3Dpv0YwYTFe9s0TL1O
	J8M4YKnqNtTBM7jt2E4TT3X8WzC0cMZo=
X-Gm-Gg: Acq92OFrM/4+MgVDp9glm+XAwTBxgmCTwezesckLUo0qr0QQTMqOtCOALElAe+chhBh
	MkXKjuJGBg9ovHpSwe5zRKl+ba5LEk5iJ8Orwil8W2jzQLWEo7/9B3LmBDSlxpIWn5C0r/19RAX
	zoiZaVKoJ+g2b7xnl6HTHTW0KpOJLicCWWmJSJQaO4vecuSpVw2Yy7Yn88PzaP9+yNPmWFU3fnF
	hyo8+e5+uz4dKpGATfzDnCDDIu0i5qsu+y7lEP00BO212YbqUV7GUL941jEOcunWip/b7Ciip/z
	cDiPr2wNDD0ZjatcnA==
X-Received: by 2002:a17:90b:3c4f:b0:36b:93f7:a903 with SMTP id
 98e67ed59e1d1-370f057b7f0mr4987159a91.18.1780674597805; Fri, 05 Jun 2026
 08:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605140203.76848-1-cgoettsche@seltendoof.de>
In-Reply-To: <20260605140203.76848-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 11:49:46 -0400
X-Gm-Features: AVHnY4LR4DM8i6BOKPaYTEnZne_bt_mHM6dPwNSe1EV9jOFnmiPxBnzB7MI2Zn0
Message-ID: <CAEjxPJ5NssOEhCiZ4e_eRHJBvjaL5mHT2vC5id-TD61dur3afw@mail.gmail.com>
Subject: Re: [PATCH 2/4] libselinux: reject invalid file_kind in compiled
 fcontext loader
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 10:11=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> load_mmap_literal_spec() and load_mmap_regex_spec() read the file_kind
> field as a raw byte from the compiled fcontext file without validating
> it.  The text parser only ever produces values in the range
> LABEL_FILE_KIND_ALL..LABEL_FILE_KIND_REG via string_to_file_kind(), but
> the binary loader accepted any value 0-255.
>
> There is no memory-safety impact (file_kind is only compared and passed
> to file_kind_to_string(), which has a safe default), but an
> out-of-range value lets a .bin file carry specifications that behave
> inconsistently with the equivalent text format.  Reject file_kind
> values greater than LABEL_FILE_KIND_REG for parity with the text path.
>
> Assisted-by: Claude:claude-4.7-opus
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/label_file.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 824fa080..ac0a3ab0 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -618,6 +618,8 @@ static int load_mmap_literal_spec(struct mmap_area *m=
map_area, bool validating,
>         rc =3D next_entry(&data_u8, mmap_area, sizeof(uint8_t));
>         if (rc < 0)
>                 return -1;
> +       if (data_u8 > LABEL_FILE_KIND_REG)
> +               return -1;
>         lspec->file_kind =3D data_u8;
>
>         return 0;
> @@ -706,6 +708,8 @@ static int load_mmap_regex_spec(struct mmap_area *mma=
p_area, bool validating,
>         rc =3D next_entry(&data_u8, mmap_area, sizeof(uint8_t));
>         if (rc < 0)
>                 return -1;
> +       if (data_u8 > LABEL_FILE_KIND_REG)
> +               return -1;
>         rspec->file_kind =3D data_u8;
>
>         /*
> --
> 2.53.0
>
>
