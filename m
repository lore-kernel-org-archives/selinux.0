Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B56831F999
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638560; cv=pass; b=RJgmzlH5p8C3KYTBC+Nn4B8pkTwqpqFkihRj2Wo5fv6KIM/2Tv5yRpjKhxRbD00piAsdrSJJmcIpfesReFklIHGaalrqqrQTP5symOM765agFUNQTAJiqAy1y2j1GKLfE7BZ3R+AwQZac+nm4P92g/keaR7CkJL5inmws9Hv9Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638560; c=relaxed/simple;
	bh=RaHegueEBXKhn2EYL7uXHDdLZ56OnxQeC+T04CFqUMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H29YdYKTe8Y+A8JXaBjNQN2BP0VpBHoqkqwHzZ3amIo+oJk1+beKs2wCttHpukuODXmbK7axo66Pv2AzhGwSPSKQocKAM9jB3aCgIofPhOtaP3sRVacOtMqNlJV3GX+J60oVlhzL5cQTyOo2vSeXdsDlSL0Jt0p5qVsPLx6Vpxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6Yg+XhB; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6Yg+XhB"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8453427d3f4so10441577b3a.3
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638559; cv=none;
        d=google.com; s=arc-20260327;
        b=I+33z4iLW1NjwIOFPUliN33HHfGrEKkGBkq5AXU4JMZzaz0+73Ymmqi8+1+kvLHZVT
         Uc1JRZaAB57k4hyzJTprIHYfsKk8RPYmYcJHsw6O1JuzrgR4Ta7Y0GgfB3qXKHTatpQ0
         YhR9KYri2GLBKj+fm2z3d2D+c/OnDcuE5XzDPa+R5+ssY5+PsI6Obc1n2b73vlwL7QFM
         2byHFUFlBUtMqk3YUwBI3QfwIP0l3yNIkDKlF4bS0DmHn24T9xz5Dv7/jxcIIC3cHdq1
         D5rXAZhGOlJBeFA+Xf+3wCJPdSsr9ZIp/TQYhqzOnSTVi2nRTvb/2aWhKDf1sRpAXPWz
         XaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W9R1gUzjPINoQU1kenLR9e1CJA76D7QCTNFOE+JRcKM=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=YojKKyEa/idUL3K78ZhLxBPws1AIS+aByXNTRMdjuZoSgpoS1KXnuC4xRFIRciKe8b
         WWrEwsa7E60VnRQW//PChgWc5/SHsL5qj8cJ0g0OVhn/ebz7HoRGGUyNpVxD1iFMYtkB
         a666DLRx9GBWtN08TSNvUT1N6wdQLogOePp7+IrrldAXYK9ATOXbAk1Tx33wWcaXkR5I
         T2vTZQJ96tEOgdKc7VLS946NPXX0uHEx1gkxc/PFUQ1PLbY4/UbLYDQPr977JawcOQ5X
         aC2q+AHgtw0OG+2K9MJc1C9WmxyrUs9RFYx475+6yMH95nUdYQZ8gpDLiToNDQHzGd/H
         qJ+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638559; x=1785243359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W9R1gUzjPINoQU1kenLR9e1CJA76D7QCTNFOE+JRcKM=;
        b=g6Yg+XhBfEUJSpDpCJ2zOjy60hGKzyLDkGZphj44MxdbW4thw0dgGvZx3OU9vUyhcc
         8+lNRHZutyU9nsQ0Qd0fUuDCgMYIqkmprmmMrmMadC9gEb3Xwa9TlwYpVsysCQH7CHYM
         oDZ+nbnXFOoU+Uy8VHA5ENS48FkAgL3GPyiG6L1cZm9D1n28jpp4FZ3UnvNhob+gk3oO
         3ULP3Z3AWk/EmfAPCqAIocTwSWNjfTys5WtXi4IPBOQ21o30gQc0AAtiPvNpTofqohXO
         Vz+4GGG3oZYjnn04CQnuSr5xSA6pnTgeUg5pQn3T6KzKZ1TurN3kziqY1Mw/TjsfuWtL
         VJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638559; x=1785243359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W9R1gUzjPINoQU1kenLR9e1CJA76D7QCTNFOE+JRcKM=;
        b=RD+/9DfKaNgnmqvwSeONAprlUmFOFuXZHoBfoUH2OOgW9vT/1HPL4BOhvunP+24JIN
         AqV9L8NTYLS6rAcRnJ53LnnKzCaZTsaYDzheYHT+skTWqi/sYMq44u86yYo22lX2Ybcf
         AHyZ4CL2NaERtyzk3RuQeFz/meRcnR+3VWWWXUmhCEx465sSAzxFK9KHW4jrd1U13fWw
         +OY08kt61jmcIsWscYtVplm6vMQD1ZJve2FaNCoaLWoT7+CG5hxcm29S8GqK/r/fMGI5
         JJCYitmZncrPfPvPetZn1bdanSZktRGCvoUrBgHN/I+gyXEdmNtm6hLdyKmv/NvU3CSv
         m/lQ==
X-Gm-Message-State: AOJu0Yyp4kLLwKEMci+Pj/609TLs1dR77aFXsXTRQCrtYK91Y5Hp2iSB
	4STqtxBfDAlCSZXaDP0IyktcsLlmyJrVM82d1HxTQfJypPeVVmfFGaFk1vc0V/SIjbyhlXHw8AZ
	ltQRFANGvS+HUlDf84RU3WTlPE5O5pY2jww==
X-Gm-Gg: AR+sD112BWHSRvuXTZHb5j8RLJsBwsaBfqQUN3BzsRPQfSHBPT+8URGCUFvB8x0lKm5
	5ij/ctk1F3OjYTiz9TPbSEEzqy+SgUoEc4A/WoWsF+AEYXf12mxSTm7VRB0wRUJcL60xKyx0mV9
	ogsvKkaxXCEP7w1P59ssRKgF+90FfkFaYwo8QAKw5hgjl5IuPxQddGP9NzIYKCZoZviXFvs+evI
	1EaY5b3vXaxLbYJpTaPAuMR4VEjgOZ7oakbZpKcp0ggnwT65fw35G4bGRht3A==
X-Received: by 2002:a05:6a00:4299:b0:845:cf73:c1d8 with SMTP id
 d2e1a72fcca58-84c2926b51emr19305869b3a.14.1784638558908; Tue, 21 Jul 2026
 05:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717172726.19402-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260717172726.19402-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:55:48 -0400
X-Gm-Features: AUfX_mwr1aZbkNnEy1UTKBo4IkpajZ_VVsFhJM0Q-jKoyTslQ3UuMtC4vQkH1wg
Message-ID: <CAEjxPJ75Wrz6Yivb42gxTULaEpgAusYwZrWXc_aMYZpJYMznbg@mail.gmail.com>
Subject: Re: [PATCH] policycoreutils/secon: ensure that range_bg is not left NULL
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 1:27=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The color string from mcstransd is split into eight tokens; every
> strtok()-result is NULL-checked except the last, so a truncated color
> string leaves colors.range_bg NULL and disp_color_to_ansi()
> dereferences it. Check it and handle the same way as the others.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  policycoreutils/secon/secon.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/policycoreutils/secon/secon.c b/policycoreutils/secon/secon.=
c
> index 48daf9d5..5cc3d943 100644
> --- a/policycoreutils/secon/secon.c
> +++ b/policycoreutils/secon/secon.c
> @@ -696,6 +696,8 @@ static void disp_con(const char *scon_raw)
>                 if (!color.range_fg)
>                         errx(EXIT_FAILURE, "Invalid color string");
>                 color.range_bg =3D strtok(NULL, " ");
> +               if (!color.range_bg)
> +                       errx(EXIT_FAILURE, "Invalid color string");
>
>                 color.valid =3D 1;
>         }
> --
> 2.55.0
>
