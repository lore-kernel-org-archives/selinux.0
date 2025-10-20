Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944E225D6
	for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 12:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760964423; cv=none; b=WExjvYRBqIF8hkcmadbFr+0akNy5CdgVUmjTllSoJmGWhcwhQy3ik/gNBXTV1zCtwzDBT3HbNGmlsviqZnoRyRQeT4P1aWE4XLA2UyQhiucEIVWGPKQBhYyUgtVExA3t0YcCWgtKgoSuF9zR3F0PCF0SKpDLdKjew/dBgJjxbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760964423; c=relaxed/simple;
	bh=bF07y42jOA5t/Ey7/bPCFhZ8bzX1m575LKmCswJMzK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPa47bbjT8oKRHq8pD3CHphruzZoVpH3ZghjjsBwqUdhtg2hrqndf456Y5oj3bwbc7nXnDwoVM8OTBU75ELSpReLt9z/kvdPMJyYLJXRfZxonpmYgxnukHAsiLHG+FrexN8cqTLQSZ0fKo613CmIKqIicYrdSPnx48EIiaGzCiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVlGv9F0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVlGv9F0"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso3716603a91.3
        for <selinux@vger.kernel.org>; Mon, 20 Oct 2025 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760964419; x=1761569219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIRJ6DM1xl2GYow3+/I2BISzvdTh4uqxhHFoq8cSwTA=;
        b=AVlGv9F0/IYNg6T6KQrT0wAsO8L97OZ8cz3UeGHrDZh6VEkcWOhTv0qKfOJhzleisC
         oDynIqhVo2RhoVpQqZgF3O9INxtEdyxaHSaqfLbMtp0uGjoHMD+sJhwSBmPIMrnEMTCe
         CjxykoA81d+JTBcjjR0kbp+3Dt4CL7KutPKAWFiOEs1NkJIjIhsNP776vnRIgGmU+D34
         SfzQo8wXDATg9rBKLZRvn9YMysZNn43ursZqpRVkjVy4o1QFoAV3kljOn6t/uGH6zDes
         I0wM2MJCbYveoi+kCNrTDCbrhpcjoxeiNQyFo5KWMQfeETW+nlsu70WNhetOny7aYXGg
         a+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760964419; x=1761569219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIRJ6DM1xl2GYow3+/I2BISzvdTh4uqxhHFoq8cSwTA=;
        b=OzscfGqN0qc/YT/QT6Zyvk4JSIKqryBa/YgC+GVw84N/UhfVgsDx9f4IAM7I/AnwxX
         7nlQbQ+0pLHB3ijGWNHP7ECl/doA8uD287mH3GsdYXpFFOt3yYyCsdKD/Zcy007I2etZ
         otFQ7t0brDoaRy8ZCAy9ASDzrmyw3GIRnBL9h8C2+Zmm2dsqL5JkujXQRmgtsHG/K2i0
         IPeXhv5YJz88o67P49/KdU0tVMVfK1ZnD/znXWnrp3yaBvfRmcBj6/y1wDFZoFkZmkYY
         8ULYB71owPcXupCFTfV4ZFYhUxO9r4xevRxdvw/Lo7+4j1hTfaTeQz9cLKbJ82Wb4KFB
         +0zA==
X-Gm-Message-State: AOJu0YznAO1/eqcWSm76LZtfzvynncgqmjbiaFDRuQJV5w3SZIHgnfaO
	gAdO9QsjlWnaV9Y1D7WXPLHbvsY2jyf3d/nCjjfX5XcWXQAYlM98vCOwF+D5h9ggdgCRtCZnjCZ
	09PE/LFfIY67WkrMKHoMZLnrThoERz3aphQ==
X-Gm-Gg: ASbGnct8RE6tLI4CFc488A5IKNIPAha+O5rSX25YwN5oUD5EJeOZFnF2TQkCc9Iq6NE
	VLkVN9k+cxB29n29Ph7KtZkzJH6RTlAsYGb6mY0TZd6NGGvIrxtBOtw3gB0K8xSsLAEomUeW+Ab
	G7Wn9Pd0yisb9dHUosHoMEmxy8Bnd7nx1HWOZPG6IuQQVPig5rtkN5cg5frHWNviEdZuH8nHMjG
	FSB2cFmwyhSDH9zoZBzOMdBKy30mFvFmxBFNmfmydNNiKEuWEHZYts6Ilq/
X-Google-Smtp-Source: AGHT+IG6SOIae1yypngrgtkxhr4BEog/l3QheTTpSJG1d/cXwV+s+KMQ5apLzo1ZZ2GnkVrv56GGEia8LoEQHIBMX/Q=
X-Received: by 2002:a17:90b:1b4a:b0:32e:1b1c:f8b8 with SMTP id
 98e67ed59e1d1-33bcf8f7cd5mr19140432a91.26.1760964418931; Mon, 20 Oct 2025
 05:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ7UE2vtCBNwDphKO1SPC88vbTHCyq+ENhvZe1Tea2hCGA@mail.gmail.com>
 <20251017150847.580771-1-vmojzis@redhat.com>
In-Reply-To: <20251017150847.580771-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 20 Oct 2025 08:46:46 -0400
X-Gm-Features: AS18NWDTUd08rm6tOsTDSUhxvzSmNFhZtK1Cp-JwynPYUtcFEQIgQLEAUKHfo6Y
Message-ID: <CAEjxPJ6RJCGmizB0zX6pHobiUhWuXFjhhpE2n5EvP+iZgOmYUg@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: Ignore files removed during relabeling
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 11:19=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wr=
ote:
>
> In case ignore_noent is specified, ignore files removed during
> relabeling (race condition between folder read, file read and label
> set).
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libselinux/src/selinux_restorecon.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux=
_restorecon.c
> index 39eabeb9..681c69db 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -726,6 +726,9 @@ static int restorecon_sb(const char *pathname, const =
struct stat *sb,
>                             pathname, newcon);
>
>         if (lgetfilecon_raw(pathname, &curcon) < 0) {
> +               /* Ignore files removed during relabeling if ignore_noent=
 is set */
> +               if (flags->ignore_noent && errno =3D=3D ENOENT)
> +                       goto out;
>                 if (errno !=3D ENODATA)
>                         goto err;
>
> @@ -765,8 +768,14 @@ static int restorecon_sb(const char *pathname, const=
 struct stat *sb,
>                 }
>
>                 if (!flags->nochange) {
> -                       if (lsetfilecon(pathname, newcon) < 0)
> -                               goto err;
> +                       if (lsetfilecon(pathname, newcon) < 0) {
> +                               /* Ignore files removed during relabeling=
 if ignore_noent is set */
> +                               if (flags->ignore_noent && errno =3D=3D E=
NOENT)
> +                                       goto out;
> +                               else
> +                                       goto err;
> +                       }
> +
>                         updated =3D true;
>                 }
>
> @@ -932,9 +941,10 @@ loop_body:
>                 case FTS_NS:
>                         error =3D errno;
>                         errno =3D ftsent->fts_errno;
> -                       selinux_log(SELINUX_ERROR,
> -                                   "Could not stat %s: %m.\n",
> -                                   ftsent->fts_path);
> +                       if (!state->flags.ignore_noent || errno !=3D ENOE=
NT)
> +                               selinux_log(SELINUX_ERROR,
> +                                           "Could not stat %s: %m.\n",
> +                                           ftsent->fts_path);
>                         errno =3D error;
>                         fts_set(fts, ftsent, FTS_SKIP);
>                         continue;
> --
> 2.51.0
>
>
