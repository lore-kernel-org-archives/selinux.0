Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7F2153E7
	for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749666730; cv=none; b=GEiBnVaZx/0gpGfAo3zAfM4WzA0z8643yG7uS2tdlS/GUFPK5v5oNvrnnh17SmijlJr3xkui6OpCjrcX05eXODd+1Bbb7EL1DSao7biXfATn8FWq6XhW74turuWaJT8Vq2hpd7JSyCoA8KqqEkE8C0DgpzI8UaKTbcNWc113Qu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749666730; c=relaxed/simple;
	bh=oeyJmqDFlzBj740tFkX7Ri4Nq53M/N1UgPlaJrvRhSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkQSjlsDAfA37cS7KMVJ3oRV/r7Y6jJaqhXmahIBSk4UlDiz8xaC9J2rOuMu5M2AphKfXxyPxQAS683c5Lo9n9dZWRe62dt8A6Uz6P8q2kN1hPkr2oOtIIKQ2q4GWsEgSPIPKbogLy6qx52ktK6iF8xdIjOEoJKo9eizZ4ASgb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg2ey06C; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg2ey06C"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747c2cc3419so207110b3a.2
        for <selinux@vger.kernel.org>; Wed, 11 Jun 2025 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749666728; x=1750271528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d65leWeqBzgZ16as85IGoHhY4EOrvYL8bcW1L4cbFA=;
        b=cg2ey06CxD+W7UbXf2v/cdlA+j6S/Pjq+5Q2ZrFEQWQxS2uSdGnD5QMjdrhlonJcQx
         nyznbsn3limJZuIryGM9rXf+YVrDIykyQjJgRNOexB4bPrZqP9LwahFxsXTfydenGrcM
         SkTPTp+KREmaKeB8Ko69WQ9e1xBMQ6tqku5ZCqOqz7KMx+N8Ei4VHcsISmd7KMhQuMPJ
         Cnq9R86RVN4r3ghTZlbJZ6oODuGZCAG2f9rNwzveEETzpJo16nMIwpy95vTNjoZlfZwp
         TMBkUq7GuEdVwIXplfQodJ5wH1pcjI16CWdFAf+8iCNuX0gWPRK+lxox5Rf03Z4wLFuV
         uv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749666728; x=1750271528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+d65leWeqBzgZ16as85IGoHhY4EOrvYL8bcW1L4cbFA=;
        b=rBx5Re/P+lFsSPaciTeV0/CdcKZPd6uAk3tpi1PK3gtWQmoR7+s58y8X5VKAaPXapy
         wsOpJoCQNFIPj4hvDp8XVfQJFBAfarj5pUoiCS5Iaip1G/FzpGzwc2ogk9f4G+3/VMKH
         EiYKmUlbpSfwt9OXVP+z+y03SFgq5mnFVn9TcFHlh1k59vaqMRZOo/PzU+fcA2MnQFQ2
         xlypJg2hhsKNkRXJPW/7tmnLS6GDNr9cRHxXEDf6n0L8posG80D5RdW+vGPRgAcVqLFD
         aCj373XfF1HnIBO9k6J9IoDtFehxzPAiOQ5pKZxk2bJ/YZXwYppoVut9YZyE5hdkRdhJ
         yabw==
X-Gm-Message-State: AOJu0YwENeCBhTnAXlzF2TcTbqqiyP8cC+RdI5hzVs3wvtrkpi0vEVyx
	6Kr7Z5vYjJb3PtFPjkytkdDBnpQX0lMi8BC9J45V62HhfVHA+euGf+Ax4lIj5uRsk3NWICAqYyC
	KBKutnhCrzkgG9PqP/vDHJSUjjW3OH5Q=
X-Gm-Gg: ASbGncvje21wvQNpWv3tjud8lYuKtFSnoH/4fhEoUfPAHOx44XEXNrgCy/8PsdZqXCE
	asNKEmRlbohvLO19FcsZI2MESVrCrroWXLh4OMo13sIhbOL2dKCN5jlDKyw60ZjSqkNpt0Z0MH1
	4vG15KxW+Ak1s0nRTEMHoTpjvAYBTExv9SWvm3kwyAUsw=
X-Google-Smtp-Source: AGHT+IGnJkpuuFhi2Htd3+3zdCpaT6AUPmzlYmvfrAkIVrfQwzk5y50bcUO3J3YJs1XMuZtZJ3ppfvGUvgIvMHxme50=
X-Received: by 2002:a05:6a00:3925:b0:748:323f:ba21 with SMTP id
 d2e1a72fcca58-7487bfe8a14mr792488b3a.1.1749666727658; Wed, 11 Jun 2025
 11:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611182846.236298-1-jwcart2@gmail.com>
In-Reply-To: <20250611182846.236298-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 11 Jun 2025 14:31:55 -0400
X-Gm-Features: AX0GCFui_JPeLz8-DolGU8OzL1OIlNFFHUDwNAukA86-kQsoDujO5Jhiye-lrLU
Message-ID: <CAEjxPJ6g+=N3p83hUXRndvET+4T-+OShvMHipLg0h7fo89iPfw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Do not inline compile_regex()
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 2:29=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> Since commit bdcbbf89b9548afd452449835e58e84105a71a9a (libselinux:
> limit fcontext regex path length), an error would be given if
> libselinux was compiled directly. (Though, building the whole SELinux
> userspace still worked.) This is because the flag "-Winline" is used
> when building libselinux directly, but not when building the whole
> userspace.
>
> Remove "inline" from the function compile_regex() in label_file.h
> to allow libselinux to be built directly.
>
> There are four functions defined in label_file.h that are not inlined:
> regex_has_meta_chars(), regex_simplify(), compile_regex(), and
> insert_spec(). The first three functions are called by insert_spec()
> which is called by the inlined function process_line(). This last
> function is called by utils/sefcontext_compile.c which prevents
> relocating the non-inlined functions to label_file.c.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/label_file.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> index d1a0713a..8fcf74e3 100644
> --- a/libselinux/src/label_file.h
> +++ b/libselinux/src/label_file.h
> @@ -390,7 +390,7 @@ static inline void sort_specs(struct saved_data *data=
)
>         sort_spec_node(data->root, NULL);
>  }
>
> -static inline int compile_regex(struct regex_spec *spec, char *errbuf, s=
ize_t errbuf_size)
> +static int compile_regex(struct regex_spec *spec, char *errbuf, size_t e=
rrbuf_size)
>  {
>         const char *reg_buf;
>         char *anchored_regex, *cp;
> --
> 2.49.0
>
>
