Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FED137C110
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660677; cv=pass; b=Zk51r6X2rG4NSbuNLce9zm7dsdcZ+6ytapzSyfXszFlMqOBW7rkzJykRAaZQ+2cR6gkHZyOjKgOixwUWs4CmJDwMKQMEwIsF4GfH1bHiUaBr0fXjrgTghg8YrtNjNCW59fIzNR0JH68cBPZkBg/FpAcNQCcjm4+NL7xHPfZvlXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660677; c=relaxed/simple;
	bh=6FZFkllfddbz/vKmDH27mlYjwZUc8nZXs9Sj5JCpFTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSuIgpxlNmQ7fQX8+UU9xCRs60zfaxuZ1jkLH1nvLJeYpja6P2fjbxk1uFcDgBNnhhDK4Lscdq/QiIitihm7UPAIhRXozRENUy+1ZaQSPzXsBFOpd6vB6QZNL75f6mlLG7Xuoy3GGOaHEkJWxqvM0e5G0iFtXQcEbCGNPj0t3Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI7SbOQD; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI7SbOQD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bf237e1433so21103905ad.1
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 04:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780660676; cv=none;
        d=google.com; s=arc-20240605;
        b=hvD2NXT3/rKH2/4FzQbSW1C5tzPOLcemcah4L3bQ8HJnIj2mW3ub0a+T2gkQYZydBk
         UhQ+GGCRZUJUAj/NmU9K/bm1BQEJ3yMCQkolbDcmx5QN95PXVY38t7Ag6VX+9824Ujri
         CwGnNTez5J1hQmzgFhy5nFrC8EanKACG7hGTSFIF/UoEAAb8k7efHIydMbmSG9ln+jxs
         xXoFY7d00n8QIzfrAggE3eS38oM9qSMwOCxJLVQUn4qk5JWJIxtQn1WYhuiQAXtyc0I6
         lsL+wcFM7nvqmnCJfNP+K565GxM1sUhL5CXZO9f/EvI1snUs5sQKR3ewNLBbyP2cRPyw
         fNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EhuL9Pb8RVX8ZbFxXjNPPkvoWR0GnKAvsWQT3j6mm98=;
        fh=FsXghBnyoYbEc42Idnie0oh5A6i9FUng5ntOLhqXIRs=;
        b=ECSypN84rcxm1hrVBrtyzo8SiB7SMH9aDTuggTs/7YyavAjgRM45usxg63CCvyz8fk
         ZxL22MiKOQORozc3w/Vcn48MKvbrWdwQEE+Wwpa3RK3+IB7R8eWT8J1sHR2jBNN4ormJ
         H3jYRELL0pdPtGU6oIBiV6u1pAWNlpvNeQkiQFKeP0BwLcRDj/nhl40SL7EaukmZoJA4
         zWePX5pVSebbo4KN5Jvs/2xZcbjAPpbR5L/imIClKpyjfe52yUwFMJvSI8k33C6NAn5Y
         9yYsjXMw9OhBMuYu7Kf1JssoFNci27nQiTWUYwGbpMbNHlTtME5lSm/yRMJXX+0BD5Oj
         hTjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780660676; x=1781265476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhuL9Pb8RVX8ZbFxXjNPPkvoWR0GnKAvsWQT3j6mm98=;
        b=SI7SbOQD3KvvO4ai/2JtZXHS4nRZXTFGkJXkdwNXU17QUFG5Nnn3pq+bUwcaq1JkW8
         Ehc8itEluXNc1bdvyETDzsYRQyjhY+Y7Mwzp5S/TTN7GrFReT2sUuyez5GetyTd1HEc7
         nEDOjU1cmmyvUQaR0ddr+jsVbRleEU31z6CeD2sDoZZex6f0MCWvdz5Ervuff+XgVfkg
         UkFgdoyIo8kobLqFIMBXw3cS6rm9uruiAVVapf7E3DdoAz54Wj7M6B8PUv29z01YtPg1
         RJwvhikSRsWQGU52BHywZD2DdJL/U5/IQh94OqZfCLcCbN2mPocgRGO2n7X/dvCDrYt2
         RZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780660676; x=1781265476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhuL9Pb8RVX8ZbFxXjNPPkvoWR0GnKAvsWQT3j6mm98=;
        b=AQkbVHMzPJk3BA29W527gLey2NsdnIEBP90n+1rmn+trqsx6OYiHE0tFVFzZAXXrlv
         tfsH8kV4RhzTofVZ6GC8tVluJIsKgotTTf6YP74IpZFwo9scRJ9pdaDaNFPsrmu3E2bl
         hJTPcefAXZhWzfFdLDVnBYZUaI+4PJaIBVE9SJjlX/WTWqgdqv+Gy9msV95cScC2sDAv
         n25ppENuifhFrIzMHX1GtcVyuGQ7VfpmUsrPZ9KWVIyJH4RWkfbaruYd8fUhcLHjD/Ku
         NzLEx0oLQ7w99uMHN2j+AS5xmOz+uGxaAh43ieCeZmbsijfqPZtrBvrbbihXem8vPqTD
         Ufdg==
X-Gm-Message-State: AOJu0YwJUVnmu2Ng/6Ez8Wn1ixDbVNNMcz+5/q0+Dn9JYbrrBcYmCkrO
	lvMV7vrInTuaPEdZXcAWADlbLRDxizmsUvE5Gg2vrJcTX+dt7pJDropaEKDvosfGEnkDCddV0da
	Ng4RGBwfRjn+rf7i3v6Ut1bFxY1jzqHEtNejU
X-Gm-Gg: Acq92OEj7e7N7XkVhkir9gjuK+8L1dSyFBlSa7Raa7qDyJTcOMoTAgQYhe54kLiVNq8
	mFSXNxRQ9yKdVYn6Wa+nFs3sH7+hu+BTh6+SyaFsSjxlfSAh6QD61zXH7N5ioUYb3EQ4cekybMj
	KTPHiCJ4XzF7YcUk/JbkMFAizWBc/UJFFnMhic5zNYLf8y0jU72gH8lrEiiEqoammlGQmBr4ZXn
	b4Qqrtz2dXdNF/Y/HqMXyFbiuut4TNAdORx01be089Pzre+pzL5dRHp22eu2HPsnm1tssF3AcEb
	4vVIw+xa8peXXXf+kQ==
X-Received: by 2002:a17:903:2302:b0:2c0:dd75:e834 with SMTP id
 d9443c01a7336-2c1e80cf35emr35449355ad.5.1780660675893; Fri, 05 Jun 2026
 04:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604201228.61342-1-jwcart2@gmail.com>
In-Reply-To: <20260604201228.61342-1-jwcart2@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 07:57:44 -0400
X-Gm-Features: AVHnY4IaGYMSOXXwEH27reOhMNwq0HzkrdkRrCdh9RQUrcBIuInYmnuve62l7pQ
Message-ID: <CAEjxPJ6k3CdqejBZ7s3m6d3wGd9CFMv_F5iHZRD+NgjxgLqabg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Ensure dst gets set when copying range transitions
To: James Carter <jwcart2@gmail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 4:19=E2=80=AFPM James Carter <jwcart2@gmail.com> wro=
te:
>
> If there are no range transition rules or an error occurs when
> malloc'ing the first rule, dst will never get set.
>
> Set dst to NULL immiediately and when exiting upon an error after
> the range transition rule list has been destroyed.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  libsepol/src/link.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index 004bb61a..70742fc8 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -1498,6 +1498,7 @@ static int copy_range_trans_list(range_trans_rule_t=
 *rules,
>  {
>         range_trans_rule_t *rule, *new_rule =3D NULL;
>
> +       *dst =3D NULL;
>         for (rule =3D rules; rule; rule =3D rule->next) {
>                 new_rule =3D (range_trans_rule_t *)malloc(
>                         sizeof(range_trans_rule_t));
> @@ -1528,6 +1529,7 @@ static int copy_range_trans_list(range_trans_rule_t=
 *rules,
>  cleanup:
>         ERR(state->handle, "Out of memory!");
>         range_trans_rule_list_destroy(new_rule);
> +       *dst =3D NULL;
>         return -1;
>  }
>
> --
> 2.54.0
>
>
