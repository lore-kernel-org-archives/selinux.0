Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE326462B
	for <selinux@vger.kernel.org>; Mon, 24 Mar 2025 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843130; cv=none; b=oPkW8lklJU9M5ayz+x4ASYzohJiSqZVfldP8pEdCqMPDy0fXZwgPLUAWQ8ctqk4kquMAj5wUn61v9F6iTyyL/kJtOZP/et2fUctyvqBjsHiTuxsuNybgVxDCDQ+/EhRfSft5+6oosoomKsaQG3fJ8+GKTDjQMELeyQZfLAKMRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843130; c=relaxed/simple;
	bh=fkrxoZXx84oQ+TWQfdRL7O7FxbOoG/vwQC0mtPHJNiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bg2vOSuNKxr4mztXO5twWMmV1/l3KsCz2q9os3PH0rlwjyBQlz/e1EwqqA93EJUL0TLumQKQ0Dpll6prfxMGLZXPspZoushHCQRJuKP6JSrk7z8SGfvronN/ydcgPSgvI/qyf+zn0QWv9bc3SY7cLaA1QXZTYtA0QQzX8tRXXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7CKSNQt; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7CKSNQt"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86d3907524cso1995031241.0
        for <selinux@vger.kernel.org>; Mon, 24 Mar 2025 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742843128; x=1743447928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOfkCFVfwOaCBs9E5sxneViXDqo5Kfb0CogMXMNznWs=;
        b=S7CKSNQtkzCT8uLcBNUnWBfRn0kV59Y4noXmVpLnsZfw4wD8sas9A65fDhRly/EHEZ
         cgBRCihp7sFwUKK82Q9jrk8ZMVorwUu0FNw1DcZTFy8k7v6+A3+tq+WWxHr+YQ6GVnrp
         biqKa1I6tCuKdRatOFcY3rfS0pigKZZooNE0vP9kmfKHf20ofaaH+UamgG9aJaoBVTsA
         92R0ZuveIApKBRGIws+Lmb0U9xRq1PQ8ALLhE1eoxAjwrTA+/lq0JHZkuZ2CvaQDEXKh
         ZpW4NDWqQlLprRHxNHx57FFap6ygocJQAuWhYIjVBymEzaOvBtJpXZ0tBIbK0yLBhyxg
         lSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742843128; x=1743447928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOfkCFVfwOaCBs9E5sxneViXDqo5Kfb0CogMXMNznWs=;
        b=hcAA8b/lbdQWSP1ePcAkPCRTPumA3QU58pdxrjFqrr68sss6F+nA4gXSurMKV9VKkm
         U7GS7LzCT50sdXVu9Cl/SUw9zuW0D+TFH3GupDKk4h1RvqyVBLKOJmmQpDZzUZA0BR/9
         Mw4vgHwMcU5TgxlduzSr1bh1Z4CQIDZ3wrfLGit7jtzQcY22LQpxcBU5y2CQRvR8MuB5
         dpbjry5ILvdcnivJcJZzhkoIV2CY344MeH8Gd+31VOOz/zTnyVp+36/T3tZn5z9DTcov
         guXFBM2ZDSoN1iurNGhl5iXibG4eqHQzwGioax330CCGQWoQJqmmhftR2ZWjaWVFrmej
         teSg==
X-Gm-Message-State: AOJu0YycC7aH2664Hy07acLUXs+4+4uVVRioUWidtFoAziG7SIavupiN
	SVJJ3EgEB6159q2GlJP7RYcx1Qi9PAmdKsg2yFnKWF36JIm0KjDJ7jy/9iVffvkriUl311cNREe
	UwE2ff+NZMalwz6yysmREunzolc8=
X-Gm-Gg: ASbGncvs9hIWh0fslPzhTaQfrENHr2v0xxZN3ix7SV4bcC+VopU78dNkbDEv7rtPdhZ
	oi5VGeyKV7yujWGOy3JukyM1sLBCt+Q79F0eBR7Pxg40IsYJC+KlU1u1EIEspzIUAAPnsIErQOZ
	BNA9a4K5RpUZw7JqVzfRnGfYc=
X-Google-Smtp-Source: AGHT+IFNk2nWfG+YN4Q7lH9FVfZRRKfCNDbig9qAEE+S+WKGAApi946zyZ8BqcUxwUTSNEzewSi5imX/VdlkPoKWbQY=
X-Received: by 2002:a05:6102:50a9:b0:4c1:9cb2:8389 with SMTP id
 ada2fe7eead31-4c50d481bb3mr11100667137.2.1742843127800; Mon, 24 Mar 2025
 12:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225143312.47755-1-cgoettsche@seltendoof.de> <20250225143312.47755-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250225143312.47755-3-cgoettsche@seltendoof.de>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 24 Mar 2025 15:05:17 -0400
X-Gm-Features: AQ5f1JqCsxfFPMIbA_lAISc2_4alerTVwRkLs2wS5NZAOmEW7Qt2F8qYX_RTD18
Message-ID: <CAP+JOzR0U7Hjo43R_TqpgS-OHE8T8ZV8nbmU9nhnXzSZH0E_PQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] checkpolicy: free left hand conditional expression on error
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 9:37=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> On a failure during a binray conditional expression free the left hand
> side expression.
>
> Reported-by: oss-fuzz (issue 398356455)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

For these three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  checkpolicy/policy_define.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index f19e9f6d..18654d00 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -4202,6 +4202,7 @@ cond_expr_t *define_cond_expr(uint32_t expr_type, v=
oid *arg1, void *arg2)
>                 if (!e1 || e1->next) {
>                         yyerror
>                             ("illegal right side of conditional binary op=
 expression");
> +                       cond_expr_destroy(arg1);
>                         free(expr);
>                         return NULL;
>                 }
> --
> 2.47.2
>
>
