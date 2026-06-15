Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89BA40963B
	for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540665; cv=pass; b=nZMeXTwSfsdYTEfgo3e4QdjryxfR5JFEZOrsgW6m1kVaUMCJLDuTxKfBOtFXL6bWsFDQ/m3XRPcpr0RifRgomaL+PVITkOP6duuRE9CLAyZvnatIkJupEygJ9gPdhxGRNJWvVCMseV7QLzdfSMosmkkYn9Q06nN/JXwgN358eS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540665; c=relaxed/simple;
	bh=hGdIjd7m4BLhRCfxel+qSAAnUGCS+fFDhido74cgJWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/1X88gB+zHdStP42412au3aapuaZmI4g+qi2YyfSUaZayRYEVUBe/2vJhrD8xJLZH2zyLJ9ss2Md7rO5OFCu2pwpqmFZKIpEhOMBIzViSFUPxT2Y/FeLsMx4BYz5rsnb7KcopYfLCVv50aDuetuMlJVXLXG/kPUV7H8/Z8W8S0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r19uTxaN; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r19uTxaN"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf22d29dabso22507425ad.2
        for <selinux@vger.kernel.org>; Mon, 15 Jun 2026 09:24:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781540663; cv=none;
        d=google.com; s=arc-20240605;
        b=BvvJ1tnc+5Ls4kLS4cn2vibV85naeBQvIkhN3QdEpbk2Cmgz276REqlMnjdbLPT8sE
         jPTZpmjQnm7q9ZWxPqjBNFmmOnm3gymaN9C02yTxk7tl3wdx50xBt0zOiYvjyJywd7wA
         yPSSbA9ccRA7MVtEXKYUdsfpkYq6SzzVdnzjJatxs+mzUG14bQBAp50ZB9SPdzoPDDh6
         UVvkWS6uf6b201sdsWo0We0UjtYZCzWhuLhwPFw7wRLVOOEbWF6zt7t2sauYnsuwiBVL
         VP0gm+AaGoJdyv4q0RHlUHM8PdN3jnZLrdjK7S5znKo/X6AQNntmsHTQ5Pdu6WHdP+OI
         f0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dk2l4smBmt3S04tfo8O+815STjK5uhtzQtmK0dEL1OE=;
        fh=RcJrr7O3svp8K5gZfgCjK7Xv0tA8i0VIpUekoWsmIc8=;
        b=RwF75sOlBOHzqBtZIUXZrRNNMz7Je4YMHzwM0jr4NRkZ8wkwWAd+Am3iGBDL7mkko9
         0M+4otBUkhlzUym9ahVdEC7aqKEny9DA2JS3rsxiv7xY+GFSio5yM+hP1PdafHBWCU94
         BwSqeMg+FRJeVhtwpEqmnueeQ5d+D8NSs+wdKj9jCB7L/XSCJkjP6mecV0JGpG77AlaS
         nd7oRlpUn4KJw6G4387xPNeWWY6aC9wCuE62p7VF7ccWfoaLVVUWxahHFV6byumVDETH
         d8NZgaqTqOIZzp6/9I2+KiMVPnSpWvV/mwh1kUoaKh2z7uBHLa1k8Gq/o1egAbt7bRlZ
         OUpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781540663; x=1782145463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dk2l4smBmt3S04tfo8O+815STjK5uhtzQtmK0dEL1OE=;
        b=r19uTxaNi94aKkBkmJJFN1888IXL6qTN9hgwqUXYgpZNLeay3zB3fWsB1sWbacd9Y2
         +12pm8HRUOmwpk76YnA5T6D24kbnchHxPKIQgUiUkODZ/7F/Cz5H34np+qDQjz1cLRxW
         c8iYhN+uXhlu1pFqIHSJAm5p63/oV5xii9Cv5cSr+YDNvoP7ELDlNPs9/wUZulNNOsc1
         4/sZW/pXsxQfX0nmCcFVhoGyi3+iSyZ5ADwTgYgamhnITqiIKlvdVTmeQClX6TRO8y6Y
         TPeBVUY8VYqBu1lb6srHyRl3pwxKgA8aJ363OjzQAvwkAJs+nCJX7gToYoON57J252WO
         26gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781540663; x=1782145463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dk2l4smBmt3S04tfo8O+815STjK5uhtzQtmK0dEL1OE=;
        b=YDqnNS44loHcTHHTFhSAlEbET23GdbOwkdz4FN3I2bU5D2s1caIuZFDUuLFWrjIR+N
         vqRV9PAd0QcytB3Hfu6nL+Yg3ih1/V/XAAxfnOlb/ve0yLBS+qgfieh77xwb2JQ5X2Zo
         1aRt746WCjg6Zqb5XKFERdB+QV24nrPmk5GniIsVFYhIFUa2JDJv0Xt0R202Ukr5+ZS/
         bjs/4rqG8O1xupAximVUiZW2c54lQHj+clNkwQnHdWJuNLn+O9GHpwcvuugquTTHutSj
         5Qv22xzc+79t65MJ+UjpeWUSDO2Xagc1f5OjiFW56oCKeAkZKTdXZ4TrE/hFL4ttR1c6
         ehvw==
X-Gm-Message-State: AOJu0YynSZT5QtwfbPR1eiQPAhT0hXm/NqiNWQLY8DBew3AVnBdPQaJa
	yrmp0t0QsfFYNfqDggEyqEBy2JGc36Cz1F+Gewf9Le+reb2d+0+2P4fCLS5bSz6RG9U0D2BuKVe
	klCUz5EQwUdpFLt3QtpDh0naXBiJfu0V8qFbv
X-Gm-Gg: Acq92OG5MesyneTlHAs9iIKJIQcrpXnlNSecEKlAIcTGwFFXHdXB8LQmZOo9i3Oarw9
	9w1lkOeJzYrwS2RDmEb/ngDidMaZB0zKyqlssXv3sdX8sueh40YJnvjaZKM5bElXh4mU8PKM5UX
	V/qE79uoz1EvCo+IJW7U4bwYj0Vl4gdc3oTWVCjGqLrcwdjrNkJ3hgHw3ZPtqru5NkAYA+OMkO+
	Pslmnfam98bU8krh+oNlUGZnyIddL8UgyFvnLbi6/SNcvW0Z3gU0emSz5cyXgf5oC7iJHnMOFwY
	b9oG3r17SDiURKB0cQ==
X-Received: by 2002:a17:902:cecd:b0:2c2:27be:39a5 with SMTP id
 d9443c01a7336-2c412749c19mr156559165ad.33.1781540662825; Mon, 15 Jun 2026
 09:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614174153.8311-1-kalevi@kolttonen.fi>
In-Reply-To: <20260614174153.8311-1-kalevi@kolttonen.fi>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 15 Jun 2026 12:24:11 -0400
X-Gm-Features: AVVi8CfPhcKE6y1i2uLb-ui6CVhIS0TQO4q4RI579Ptvt4-XOgO9FKDbLzgYtes
Message-ID: <CAEjxPJ4XKE3Fydr7gEr64jgGpm-4tkKchvCBbXRmYECBR0cA0g@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: use null character in strings
To: Kalevi Kolttonen <kalevi@kolttonen.fi>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 1:42=E2=80=AFPM Kalevi Kolttonen <kalevi@kolttonen.=
fi> wrote:
>
> Signed-off-by: Kalevi Kolttonen <kalevi@kolttonen.fi>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  mcstrans/src/mcstrans.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index ee9392bc..c494e76e 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -717,7 +717,7 @@ static char *trim(char *str, const char *whitespace)
>         char *p =3D str + strlen(str);
>
>         while (p > str && strchr(whitespace, *(p - 1)) !=3D NULL)
> -               *--p =3D 0;
> +               *--p =3D '\0';
>         return str;
>  }
>
> @@ -793,7 +793,7 @@ static int process_trans(char *buffer)
>         /* zap trailing whitespace */
>         buffer =3D trim(buffer, "\t \r\n");
>
> -       if (*buffer =3D=3D 0)
> +       if (*buffer =3D=3D '\0')
>                 return 0;
>
>         char *delim =3D strpbrk(buffer, "=3D!>");
> --
> 2.54.0
>
>
