Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E44288C2C
	for <selinux@vger.kernel.org>; Tue,  2 Jun 2026 18:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424589; cv=pass; b=mPP6x3QwpH57l128KDXt4GXxLN2bltSnp/kvX3KKd5x29bsvr3Zk1qlXuWTFsViT2lgGTcEOcmScAG+lRJgC8Mf9JS3aczpuesF3/fjG7lOYQ7h4CsFkoct6b1N0CYfdzG8CKOpu16dlDXIswGOgmGKXiFzRjlVxakY9AjAITjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424589; c=relaxed/simple;
	bh=1WXEL9uwsG/rfQvvDIFyo+L/8ZByof9El2bNdUPdcz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGJT3Qi9dxFYL+n3eFRj2lPoEeBwtvQoNN/AW441+Jq+As5fuRDGDlPSzoh+NMbw5jYXAAr9uV0KCBYuFwMRnevo3Z0bbSGRMjFdvtPZjFgE18IQNkXslMEDKbQNY0y5Z6+TImGy9C3eZMlzUJS1aeo3/K5Y84BePCgfWWLLMVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiXZ3Fo5; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiXZ3Fo5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c2d792c8so18986495ad.1
        for <selinux@vger.kernel.org>; Tue, 02 Jun 2026 11:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780424587; cv=none;
        d=google.com; s=arc-20240605;
        b=Bcbq6/AwGz6KsUOnyi1+JXmURPYRehFxPGIjrXISHn8BdnPm7I01t1G2rA6cWDgGBx
         aHa2ZK8dLOzXZXnwoPYyTv7wKWICtvjdKG2ZahNiFOg+1WYjyKWrof2UrBrzrP8NXKp6
         jnSZb+jgbSr26n949o2+OSikqKTuEJIvDP95hSsUnv3/AvoL+wkzO2lTCmF4TFlNGKy2
         bXsmTvxoOILD6rtrp6X/1eUoN5valNzpnKPgoqhatUFWJhHS1rLwSPzPcO0uK2xAikvz
         vtNQofyXYJ/Fnz4CRLfGp9A1EYshLfD73X0beB15Amu/2WhJH63ka/+TPpj9mO6pq5hr
         WGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xFKvDN0U6ZFqcJVhYTK9tRdfYbPJlntP88BabzejXQU=;
        fh=5O/C79wO42cQf6w/vh3W7FviilpJ0XtrrgBkDvem/c8=;
        b=Ji7yLmovF+DT1lXVEQourtZY7WarjiBTdAo/36FWOlcGV5+ciWuK9jTDSpDPvEbjI4
         ZDPE0W7aTa4KyFnmUMeDi2Xpt+2UZtz6h6f2JI6zLfle071DuOV0pOPEKrO+bRNuuG2G
         +J4LffXtrG5zyuc54GCgsIvBW99C2LQqQ9fhBlidubCeoAbu/Ke7ZPmGLu4nQSHtrKwN
         9MnbwAdO9Lm4xZAJqyv+rsT4YdQ4JQC9ymyCxdfmhpHtnIU3kIzi46bbS1+KvfVbpX4+
         wBF6oqZrYZO0BL6JMZuZzjn51jvxOtKdjDY3RcWyglLLkPTxVlfiDxhbangeNtS++n6b
         UBhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780424587; x=1781029387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFKvDN0U6ZFqcJVhYTK9tRdfYbPJlntP88BabzejXQU=;
        b=DiXZ3Fo5O0gKTj3IGDG63kRYCq3PB922cYK3Rl86o6iesjdX1aAUbCKg2QcA5L48K0
         8msvRytYwCKex8kbqopoP4SjZefD8XDo2M1a50oDOHMcPXEeBJFGPCr1t64fmEijAZoH
         BCEU4PPYMTr3GXJr69KLPFhLWbmIyer7zJmxIJxqtv0kg+JbwLJJ2i3UK+IYxUYtM9ba
         VQdIrZF4gk0TF7SduCEYs89KTh2pj4F24Bb3O1xb1l9Si9uxV3LrrDIeggfV7Y6LXVTB
         yLO/wbCDaaNcesFo4p6qYx0lHa7tkenc1Vsky5LZ0heRoqJksrDlu8+Wf/+VjhfN1LAn
         Uiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780424587; x=1781029387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xFKvDN0U6ZFqcJVhYTK9tRdfYbPJlntP88BabzejXQU=;
        b=S2O2/jdJBGj4FU5c4yaykLfFqmJHzwNY2DMxW/rGy7rZn0n8JthD+/ryjmDVdg8WrA
         +zI5OlslWISh9bzZ9MZU8oAuZRVXQ1+1n15QJBQC1J5VuSfj87qdKMXN/VElbMHC43za
         ufuQhuyj6djAVODIdISPkzwDT9AuxgoqrGha73lV1o9z+OfShos8HcR+cS0vT1WV5FMg
         MUYyxkoS9m1gEpi8T0ex8sL+V4NQZXoyGqv3TSoCLmEoUM3JpfD+Lym7bVkcOyw0Vp+K
         3Xsas18FtTjV3tAE1PMKrt9ch1CDTIstwvbUenZIjM6Q2rua2S4/wqzcSVslIaYzHHRW
         3UIw==
X-Gm-Message-State: AOJu0YwgimYgxETvTNbPyjXhYqP2JeTwt63VUxBQ6Z/nNtuj4o7+nl/+
	WhA5MUya0Cv8AUL8WZg4oAuslNJY2zXKcxFPxLO5xhN2Ls4KcrIRK092ZmnDDO504J5QyMalDxG
	pELtpBsL/mCGyHQNQcuqCGzPwyEmOM0oHqA==
X-Gm-Gg: Acq92OGVnF7jwkjRJy0RtWdexqYPfm6ffvwioGRtB5We0X16hOWVjUgDs7n3RMnN19d
	uQIdl5GIpfkEyMx93IHWkHfv/EHecSoI0TNnJiFWasDJ/ZHAWadEQRxZkVkRmKAJlmLQloUKnmt
	A8EoV8p8bu156oxFHVxX7grXgjN6OYVPCilDAikcHM9Qf6yjO5irDAzxqjf9pSilqRksYPa3Qs0
	4qowbATXQUyfrqo27YPosTdXK8RZt3ub3cb/OW+LCtrd27APDLaKmrClryIF5+kYGYYPBN7tRzE
	o0Vj53Zz/P0x4CxV5Q==
X-Received: by 2002:a17:902:da8d:b0:2bc:b80f:677e with SMTP id
 d9443c01a7336-2bf3683bf5dmr187116485ad.25.1780424587366; Tue, 02 Jun 2026
 11:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601124210.174430-1-stephen.smalley.work@gmail.com> <20260601124210.174430-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20260601124210.174430-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 2 Jun 2026 14:22:56 -0400
X-Gm-Features: AVHnY4JBCSON4OebPx8zcJcRE-2BfaHcWV_R_W_VViEL0wGF79IAAD6sSVRuVX0
Message-ID: <CAEjxPJ6jh1d+aiLs9ReOHDWzX9H_KJwc-uCX1K9fWirawUNBSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] libselinux: load_mmap: avoid unmapping already merged mapping
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com, 
	paul@paul-moore.com, perfinion@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 8:42=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> We need to clear addr to prevent unmapping the area on the err
> path.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.

> ---
>  libselinux/src/label_file.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 88c2c9e1..1649cecf 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -992,6 +992,7 @@ end_arch_check:
>         mmap_area->next =3D data->mmap_areas;
>         data->mmap_areas =3D mmap_area;
>         mmap_area =3D NULL;
> +       addr =3D NULL;
>
>         if (data->num_specs =3D=3D 0) {
>                 free_spec_node(data->root);
> --
> 2.54.0
>
