Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759AE73175
	for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212709; cv=none; b=K2zCFjTGnkC3OxwmmHGZ4HTGrx042yk5NHfIyXbiIFmMofJCGbmaZlLk61b4UfZ4BhpNmSpwGjd6nGgyylnz9JanUCrr3VCmpQHHuHJdC3WbAzRWfFjTC4hVRXV78Nl2M4EtqyBMmb2eYSPsY8DyGqxT6LVrXwpZ8QvYPzoXZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212709; c=relaxed/simple;
	bh=iA6tUHx1Tgz89K729XXT3u0iZ1r9A8/toSQC4SDdLaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fkey1Osf6qNXOWjmkdwcnSVsIpZkn3lPQ86PmDcUj673U/4Y05x4Gms9iBXFtT6wIeF1hXEdqsEYdZYCrBt8fgagpRBX2nvoq51lf9VFVnUq+a624Nc7VPJ3ImiyYBOo5/hdosOZ689lj00qTSl/zyLX568z6rNEq+Nu9dqlpY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLx0RP+O; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLx0RP+O"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf161b5eadso38173621fa.2
        for <selinux@vger.kernel.org>; Thu, 25 Jan 2024 11:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706212706; x=1706817506; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66qpOYrKMlWtbFp0MvAGWV5YWF1wcN5DDNMhbnDmw/Y=;
        b=JLx0RP+OESHM0nIOI8I/owP8JaxAmbFYRZqj7/XZx3XsGBBCIErqw66DysdwbPZU5i
         p87tKtpxoepxNI5pJjDPAQ0JAkX8RqRQKmKygywAsGsj5v0NCABTv4aqmVUx4vwqOaUA
         epGv8kInq0rE1UR8RjypbY4AU9yNcVozIJfsn/I1HyNW4DzMZ0jixCbCcVdpgX6yu467
         YgLFy8pnhXNtJvgqVrDUhCfpGTSaP83WZYKwFLVyXUuLKT4bLfEEKunb67Oq7ClDBn4Y
         fVBRmL9YZm6NrSc+IsqivJBJM4jOYDgRz15+nSv3rAZ7U7JfGL9haubMpjVKlx/qvHU9
         1WdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212706; x=1706817506;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66qpOYrKMlWtbFp0MvAGWV5YWF1wcN5DDNMhbnDmw/Y=;
        b=A6LN0xStT3VtAjjnDGatrp0zgM+8l8OBWzpwsIkKbfaIPoJtP5KiB1OlL9fCMXfIY7
         S8lkUVCrDRJQWl1zxqivDogsWXZ6FLJzQq372AoWfNPzrQErw8UzBuLdAMyBUKwK4r/q
         dDPbtO8/35p5chOoDR4MqClp59hsTEI7ak/1CTYPFzroRe2CsSM1OpytAzy8vuRw6Axg
         XsvqCnSvxYEwG6BTgxCmAAV27ISnesXc5VDS4Kg7YJXsbhaF+B2KxuLLBKfDDqLVoekr
         TTtUMpViZNpUSWU9E1V9HjThdpUMUeiHKNd3gu/OdXC7u3a1Fwhr8ZbxlV1m/Q61KKlU
         9L3A==
X-Gm-Message-State: AOJu0YwbMuAOfGNurGT8QWu9UyP8DrT/pAM2gKBRo0BcXVrdtdViAmPP
	ZXHvbHiDz/rpDE8LNw0YH2pZS6r45Wsy3u+ROAlaABiZ+s1hjQLv0BPsh5GrDxb+cuF9TMu0m3s
	YFb/Faikuc5ymd1xvnCNzuC6vRDCKCZFJ
X-Google-Smtp-Source: AGHT+IHwqWz4P05QzPDKLNA62gfdqgXaGj2bbzK9XLuGlJHHzW9KZe4tbeOVLFYeQhBU39JRwMtlhATB/i2jKz4/Vrc=
X-Received: by 2002:a2e:9193:0:b0:2cf:33b7:904a with SMTP id
 f19-20020a2e9193000000b002cf33b7904amr132577ljg.40.1706212706003; Thu, 25 Jan
 2024 11:58:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105201917.2286119-1-jwcart2@gmail.com>
In-Reply-To: <20240105201917.2286119-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Thu, 25 Jan 2024 14:58:14 -0500
Message-ID: <CAP+JOzRkY3xQ6eDxttBVXM0gchNXBXnpD=hAYNTdmz_6wxBFSA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Fix ordering of arguments to calloc
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 3:19=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> The number of elements should be first and the size of the elements
> second.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This patch has been merged.
Jim

> ---
>  libselinux/src/audit2why.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index 8c4c07d5..ad846cc3 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -148,7 +148,7 @@ static int check_booleans(struct boolean_t **bools)
>                 sepol_bool_free(boolean);
>
>         if (fcnt > 0) {
> -               *bools =3D calloc(sizeof(struct boolean_t), fcnt + 1);
> +               *bools =3D calloc(fcnt + 1, sizeof(struct boolean_t));
>                 if (!*bools) {
>                         PyErr_SetString( PyExc_MemoryError, "Out of memor=
y\n");
>                         free(foundlist);
> @@ -226,7 +226,7 @@ static int __policy_init(const char *init_path)
>                 return 1;
>         }
>
> -       avc =3D calloc(sizeof(struct avc_t), 1);
> +       avc =3D calloc(1, sizeof(struct avc_t));
>         if (!avc) {
>                 PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
>                 fclose(fp);
> --
> 2.43.0
>
