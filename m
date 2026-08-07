Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F339C1C3BFC
	for <selinux@vger.kernel.org>; Fri,  7 Aug 2026 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786106700; cv=pass; b=I2q5oKt4uOf03Z0C2v0qmvwmeRcpgjiP+ApnK4jbs5KdNALJs+5wbZO+llMTZj6AomFZA652/FB/NJwNyhdsyFKL3GpEIYQcLjqnxUSbzR1Z5zYEyZdA7hCWuhAtQa8V4t5qvud+T4COeq8KRNs3yR0IUxg33Ysr5d1intmctWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786106700; c=relaxed/simple;
	bh=fGrJ34u6wsf4zyfhhn0ofMswUhb7TQANDJEFGTHf5Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvlMIhHQKiUigWZLSGnEwLvh+MNJUnrUh1XnJM4ZOLQOux5jIl0Gq+2jBU7LjqMZqc3SwoVKWNCigUNtTMVD1J8SVC0pwYMKjwbDS2Qr6ttd5LHVHULQlj0SsLyy7bepsEis/gp9vpAh/2r6F6RUKnROTSjzStpAYZphYMsuQtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeh/9hn+; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeh/9hn+"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-455ee8f529dso611534fac.1
        for <selinux@vger.kernel.org>; Fri, 07 Aug 2026 05:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786106685; cv=none;
        d=google.com; s=arc-20260327;
        b=jOXFiEPmfLXe6jP1M29m5KgETsViO/ZbdX5WR2WYQI34GkyvfIUW+XUmGuS/E0AOvy
         mmJ2VA5DxV6WblmHy0VkA9EW9HJhjM/euWhmC/1fw55ZRoaUs4WwPrv525QhOvTsmdS+
         KLsEoTX4os6TMm4zeDg6bxiBO+noh8+fcdMSaIoleei2oMpvD8G02IPrigvUe2EajJDd
         AtwuZv30ge+qY0ou+jB9j+nuiKsOJ43ZyKzrsJexrnoQ009EgkEw30mQADTJYXoscyRr
         cBiL29HU8OiYzlYvrF2KVucNgHr6O8ViX9P9RWZajt1Iqq6zmXLCjPeXfALmrquCmzLb
         G+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ryQNHNfuhb1RSu49JWXfn7HtWjt10nrASp7WM/PBg0=;
        fh=XCM8fo7IfM89sTn06SjGxcUqBXOhXzH4qY9c7awlrP0=;
        b=TQ3sDUCI2tOTDvGVoZA2KjiNM14mgJJ46R8fdUnR/orV7XA9dVtQAPzUEU//PYqY1T
         nXTZy7YjcmwLlkF4S+U44M2cMIKvD41/pGVHtOPMQs2WhN3e6/tkJ/MjfMGnnpqrhq0M
         A0DVuNs87EhwJilf4INN1cKZQ0HRxYNnaYI93ZX+A/ibNv5x+lIj/Ud/20L3t+qfjy2i
         ju2utu0bhOBQw13+prfdv7ya7kL8KLYR4T1ZXYthofpePStq7VVQSnLnCpuFdbpEzsIF
         nIh+emM2Hn5jzoMp5Kcv++gm+a6nP1v1Yz1CMxqZ2uaR3BzxtSkh1Hr5zgevzPR4Vvio
         Y36Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786106685; x=1786711485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ryQNHNfuhb1RSu49JWXfn7HtWjt10nrASp7WM/PBg0=;
        b=oeh/9hn+toCZBRWYsc9Zymf6abDgn2DVt0GK7cW9S4ykij0HouKWc7E6WtXZJmp8xU
         625afIscBhbkCWS+wg0bVOC9ze8T2U4RNWEoVzYe+hx6+UBjcEAt4whUXiuKLcihlOud
         QnDdqMk6vY5YC7FPMpH+sg/6Dy9LWhanxHHPQHmjJa+H4RHSKGWq4YBuecMwGjFOmPDu
         b8RVaJDtozwjUhV0J10jKo1x8k6SwmPJIJvV1nWFrJcfvgk1eztyixV2Fp62zHYiVSLj
         4zvSuvNiZ3zm/x7YfRnoGNesj5q9kn3LyOXlwHMQUk8H/w2ArmFxqV2ktD+CfPD06Wxl
         jjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786106685; x=1786711485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ryQNHNfuhb1RSu49JWXfn7HtWjt10nrASp7WM/PBg0=;
        b=IuLSRQbjzO8eEal8uYUabP5+o/DpbvngSQRSk3XrrHgb3F2trmy9B3mM2EsirhoLyG
         W9ZjvR1+tva3C1w6BGsLIvgIGq47j33yfiwfCqJZAUepvJ0EcWRvDnxkaz9rl8IVAtjX
         GV0CdQLmOpc10+Qvn6KL7P6DN1u2t7X77ZgwVncMDpXaub+LnJwBlq8PPiwVwRfmpB+v
         /9mHSo+vgkF/9nkXTXu77YJhsU8KKOeUGXACi+dSrUZ3jgFXE1kzwkHPAMpWXM6wyBXn
         8V15UbrKnN4y8HBQWzI/HzdQpEoE4GTKXbiV9+JRBR3vCOz8VunYpZlFkGL/Lx1Gt99+
         nNuw==
X-Gm-Message-State: AOJu0Yymv5s6rbUGI9/2FAf1QFfg4mArAV1ezf7x+e5hD+43IgFh/5jX
	7Q1R/71Wp1AU74mn5zs3dFLYIcF40sBWTX3CFF/BY8oDuFK+acDFxvndkeHc6bETVt8Ev+YTJBZ
	i5DyyjA5bwkP9oNiVKB+WSzpMbO3E5tQ=
X-Gm-Gg: AR+sD110NbfhW6BqnKx2KeuqW5h4eiszE2nNNgkZWxCDmhPaBZXGMhKQjfSPoQ84rJu
	ggz8P64J76jHe12y7ZAvKG7vKfZ+NBxR3FFinkP8kH5QQE3zV4gdkLdkXgJZasA7zIuN51nr1/5
	Ql5UBdBI5/KiwRtQHtSS3nrtV4jgoD8OY5AfEisgAZLqr4DsI1uCVgJKYY62nunAYF3xBZ84RTz
	nrtDyA0u6ZahGoN6cxAx1UvwVU6U3E/cbTgUFm2w/Z15L7ypgyPAA53BxbiOgFMCEYCHt4gcXNR
	1Tg6wwUwzFp5Debx/Z+idtTj0XtmMkp2aIL0/3yGJsR6
X-Received: by 2002:a05:6871:5b20:b0:448:9e35:c3fe with SMTP id
 586e51a60fabf-45a0f263c19mr97732fac.11.1786106685586; Fri, 07 Aug 2026
 05:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806204320.381649-1-vmojzis@redhat.com>
In-Reply-To: <20260806204320.381649-1-vmojzis@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 7 Aug 2026 08:44:33 -0400
X-Gm-Features: AUfX_mwER4KOAvVIgKc1tmY82neDbziR96oDPybu-xaySV3JLz-t8TrhSt99MOo
Message-ID: <CAEjxPJ42-mJMUCvW7r8xS9y0J-9mYQoDU83T5EkAstaLjNXVgw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: fix size truncation in cil_add_file()
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:46=E2=80=AFPM Vit Mojzis <vmojzis@redhat.com> wrot=
e:
>
> cil_add_file() receives size as size_t but passes size + 2 to
> cil_parser() which takes uint32_t. The existing overflow guard
> (size > SIZE_MAX - 2) only prevents size_t wraparound but does
> not catch truncation to 32 bits. Use UINT32_MAX - 2 as the limit
> to match the downstream parameter type.
>
> Fixes:
> 2. libsepol-3.11/cil/src/cil.c:561:2: cast_overflow: Truncation due to ca=
st operation on "size + 2UL" from 64 to 32 bits.
> 3. libsepol-3.11/cil/src/cil.c:561:2: overflow_sink: "size + 2UL", which =
might have overflowed, is passed to "cil_parser(name, buffer, size + 2UL, &=
db->parse)".
> 4. libsepol-3.11/cil/src/cil_parser.c:247:2: taint_sink_lv_call: Passing =
tainted expression "size" to taint sink "cil_lexer_setup".
> 5. libsepol-3.11/cil/src/cil_lexer.l:71:2: var_assign_parm: Assigning: "s=
ize" =3D "size".
> 6. libsepol-3.11/cil/src/cil_lexer.l:72:2: taint_sink_lv_call: Passing ta=
inted expression "size" to taint sink "cil_yy_scan_buffer".
> 8. libsepol-3.11/cil/src/cil_lexer.c:1770:2: lower_bounds: Checking lower=
 bounds of unsigned scalar "size" by taking the false branch of "size < 2UL=
".
> 9. libsepol-3.11/cil/src/cil_lexer.c:1770:2: data_index: Using tainted ex=
pression "size - 2UL" as an index to pointer "base".
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> ---
>
> Not sure if this could be a genuine issue as the parser is not likely to
> encounter a 4GiB file.
>
>  libsepol/cil/src/cil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 18b98fe2..d9a5a825 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -549,7 +549,7 @@ int cil_add_file(cil_db_t *db, const char *name, cons=
t char *data, size_t size)
>
>         cil_log(CIL_INFO, "Parsing %s\n", name);
>
> -       if (size > SIZE_MAX - 2) {
> +       if (size > UINT32_MAX - 2) {
>                 cil_log(CIL_ERR, "File size is too large\n");
>                 return SEPOL_ERR;
>         }
> --
> 2.53.0
>
>
