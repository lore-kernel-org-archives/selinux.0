Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D40128727B
	for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571242; cv=none; b=rsOA+BvROEUGUP6OXwkuwkYcO3w8P3TBt08feLTFtnEBlr01qgByiLGE7QaB9DXgNpBmVDMK2niNvTN3CJp9P01L9t417TGMDynZ6Bfx6vlnYhpYjQle3NB9oVm088w8FPNK7yt4c5TCra4xTD4bvpvf13kTznsqINTG/r2MAEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571242; c=relaxed/simple;
	bh=A35ZrG6yNM6UYI/pv21OMHO/wSuOZj0lnDH079UkwW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/9PGk7oeN/UF8gWruT5n87X5UoB7OaGUppc4aZKEsoeWX3RqDE270x07VOHp3fxzndNcYh890Z68LznjkEnltyUgABiPbYYmrecDll0rURRVlUSi6LIjfl9A9wqJuaU8ajpuQZRLmMICUjfgfCMwek2awLmCu5nNBs28mJ0K9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gedE1R+C; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gedE1R+C"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78125ed4052so5537599b3a.0
        for <selinux@vger.kernel.org>; Mon, 27 Oct 2025 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761571240; x=1762176040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlmoGKC7rRRO8FwI8/d9H/DOXObLWYcfkll3qPxsg9I=;
        b=gedE1R+CVoPrht9nDG6vF944koz6Zi1hdl5t0Rdr5NLUnlYQU2TLfrv60UpY8Jnmr9
         zcFXrVr66SVf8mnGsyb1mBtb6wFs33Gqd2MWjAVE/PVwWxUm+0zrDfWoOsWH+/S9ZAfo
         +SAk6wgBodZR2RQ4u3InNNnHQDJvtzLEhSz5dJQXxWa8qKhnau7jQHas30r+S8aUBk30
         A9Owfd1cEBvPcmMgYAHsitVUPrJW2RpMA5KbMgx2HwODJzFVZbAqdNpp22PRWqDCw8Dr
         E+GedkB0EHK5par03j2JrIxo4DZ0ZdofmS1JyRW6vOmQhJWWuesAJdaTBSexgNhbfzBz
         pbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571240; x=1762176040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlmoGKC7rRRO8FwI8/d9H/DOXObLWYcfkll3qPxsg9I=;
        b=XfZu+4n53oHrrIj0TrJvOyiE2B2OXvswAk7T4cpLzCBEfo6nRJMobA2dlrMuxuIMIG
         /uZHVG+dqrSUWhZPUOisdXGRuq1h1g7Ka4h6wHs1fL48tFlyEvDDFOCt9Wu8KhYaoNTa
         MPWk84LauGgeYlpcZBzJXufr7lKsC6X2DNgjdNg9xrCLzAJG+FktxsF/2iaIflQPlnAp
         p2b6FVHct21M1tv5y1+hHVCRwnuL7EwAGNIKDN/EvpLTga7OGe/Z0ys4vMzdIP8jzWS+
         67KDXqBdhyT7ZcaRh/kl+o814n6qcr9PpCXWRyqf6EPfBYU2wTn3ODziXugRK5erhsez
         b4rQ==
X-Gm-Message-State: AOJu0YxJ4z07CzTo9GqIg+nDwiSdonDZPZKN/jdszp9d2CSpIHMXcPRv
	vjC3zZ3D5LmdQRWrmhYheLNLUisMsRW2+bBwp2JBk9Vxf4UlSjCXCYJPyae47g96GSmbXyKBNtT
	l+XzpAJqCT+uzFjnpQpDVe/dLIGL3WfOiXA==
X-Gm-Gg: ASbGncsYzryap5GK1bPgS6FT0qg5bt9BlVqCo79n2oK73NGOUbCeijS5p9Klp+1BJwb
	4ArwiGs2f3NHPtIdky8j+ucM9kvFk17MlkmhlDFYwlRIxKuIOxmOUXExSi3F3y17ku5fObYzKph
	JDsbwyXHwAqJvArhBcDML94iWIc5LEXB5IEjXUIqhps4fYREj1jqU7s3Lf63a0PSXf7aJKiPFnD
	IQ4aJUKymES3sJnWEoCnG/hDaHtVmOTEM++aumJxTlxKV3QUphrIlA2WFbq/k6aWc4/ZUWhYW3z
	fPansQ==
X-Google-Smtp-Source: AGHT+IGk1yjvJ9MoqUvecield9DX8JSllTw8YcJIQlLxeQUGOi3Oo+1zFaBUH1ptulhicuaX+pSDuvuds+WFt5iViFE=
X-Received: by 2002:a05:6a21:3393:b0:343:40ee:884d with SMTP id
 adf61e73a8af0-34340ee8b2cmr3890610637.50.1761571240542; Mon, 27 Oct 2025
 06:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025162001.300193-1-cgoettsche@seltendoof.de>
In-Reply-To: <20251025162001.300193-1-cgoettsche@seltendoof.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 27 Oct 2025 09:20:29 -0400
X-Gm-Features: AWmQ_bkN_C-0BX2dVnnfQqLFrywgWK7UHaO3bIQmWW1RV8I_Nlb5bIAmB6pQxy8
Message-ID: <CAEjxPJ5-hWa6-Hb_k9-BgHg44nw8A2s8nipCUS0XRbg3i44bUg@mail.gmail.com>
Subject: Re: [PATCH] secilc: use correct long option name for -X
To: cgzones@googlemail.com
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 2:21=E2=80=AFPM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> The long option is called 'expand-size' and not 'attrs-size'.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  secilc/secilc.8.xml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/secilc/secilc.8.xml b/secilc/secilc.8.xml
> index 5c0680a8..924a75af 100644
> --- a/secilc/secilc.8.xml
> +++ b/secilc/secilc.8.xml
> @@ -96,7 +96,7 @@
>           </varlistentry>
>
>           <varlistentry>
> -            <term><option>-X, --attrs-size &lt;size></option></term>
> +            <term><option>-X, --expand-size &lt;size></option></term>
>              <listitem><para>Expand type attributes with fewer than <emph=
asis role=3D"bold">&lt;SIZE></emphasis> members.</para></listitem>
>           </varlistentry>
>
> --
> 2.51.0
>
>
