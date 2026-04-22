Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56535FF6C
	for <selinux@vger.kernel.org>; Wed, 22 Apr 2026 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884854; cv=pass; b=Zn9/uvLI3zOCeEPWSTKHBsSvKIfnrkRmGhf3/Jz/4aQ/8JNsVxIouSgoPsv0RWfwzzfgP56KpZXernalSBEeURHTBEFUTJsURCyih4CCmaXPIjSz28IQLAifj/O66+9PHJlNp+Da5ugC8p/sU5+gN0wLclEODKlOAXkATEHKCOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884854; c=relaxed/simple;
	bh=7EaEv9O9Ga9wR7p8D1x0z+8ut3oCjfyFYOOQoO2ZzWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QQ3fvQvzhKzGb9z4CBYFJPOBFz68XCWuSt+BFHj338oEQX376Mwhrng8EVu+tbKw9l9RtmgkzGnZUdQ6jFol4p3lJsQE926GwOr4eb5I019fRu6fPiJkd8NpzfBbjpnZbdclo5zpWQCwX+6cd+ihMksweo6LiQJcqO1On1fmCn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz9CX3x7; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz9CX3x7"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a2c77c62d7so6470730e87.0
        for <selinux@vger.kernel.org>; Wed, 22 Apr 2026 12:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776884843; cv=none;
        d=google.com; s=arc-20240605;
        b=BZCRRgLiogA1mB3GjjNlxLwYpjSXOa+a7wlyBacMVM+B4B0UkOCkccIDL7lmrv59zv
         0xthAKQ0Ip1KauxlCOeXinnJf2ClM7gDtSsy1ZQt6Q9nGUyHs3nrRLebIkd1lJZxW5jq
         jxQuA4VGdckn2ZSXIcBE15aq0mb+ewll/iaynDYO4AcWOlaMv4G/xqYnwBkTI8BV2Vuk
         n9dlKOHsRI0iZyr9WCKhQPm7KDAbylinQc5WtPwLelpqzrmFCTUJku0jyRFG3h11nl6o
         QMcZmROK/IeA3xBCnZMZ+bf/ZL39VXKqNAjaexiibhQadHBaIc6wziLqeS7AG43YtDqN
         stlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gAkbH7yZ+qBSqOuEhBU7uh6DdtnRwnRCVDP87zOwRP4=;
        fh=l2l+BKIhep14i9a5yxIzwDvgNRHYkyJlbYDDp8LiW6o=;
        b=c4m2AD4Me23vLCAI7xUhQN5EQtODxgVzBUWtUWdE6zyRqvKnY3kJtm4+ZumXMMRC8y
         rp6ko4vJiR24Lu4c6j9SEe1seLjVD3LhZgA0XT8huNHhkEh4qQ7LLI+OdcEFcSslrujv
         1F8EicPlFSJcMZzRDpMmmdjCul5er9vL1TILiPuwLJAalqSW+MEPV+N858xsFVdFF/8h
         LnbJ0ID/MoZEEibPAc9SLli8Fb7Fd3pmfhRa/5kRznu//Lx0T5hj3dvWQiLP6fN2H8WJ
         686b4PjVU8OCT8tX1TXanSuEMY/BxeP5e+Q5D85wYD1xrTlRenzmJS6E83LPgYRQtc6y
         USqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776884843; x=1777489643; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAkbH7yZ+qBSqOuEhBU7uh6DdtnRwnRCVDP87zOwRP4=;
        b=Dz9CX3x7phNZoNVTflXw+IQZRVAyHhM9UGeTnO6f70Svb8wS6BCOW8fBHM/uxYei/w
         srGIarCEjyDG/rgAsGh+8FHSnucgr0vxvJTemPoIz5wiflrX9HlijHkdYveShk323pi+
         gXVUd8WRZI70cX2VfA13W3VBuoV8ebEL7ur3TvlkaD8QOfi6pi3dM6kxfKByYYlxGjIy
         41ksXSzXI1szUkzDvVZssN0LyvZZCDHnWB/9QAj4JA9CEVG/1Zxui60KTDZBdjbhC9Ow
         mcNmMSSzOKwZHQGG+V/lDIPZC7/mgS3uXlSTrDPhX425iU6kGcpSj3fUDRD6UChLiMan
         dbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776884843; x=1777489643;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gAkbH7yZ+qBSqOuEhBU7uh6DdtnRwnRCVDP87zOwRP4=;
        b=Y4xO92LLAY1ROSgWrWFlrB77nif7TO+mOJXYuvAb1d2U4jbfCXtBYe37DYupvUmr30
         8TqcfCiMRNO7L3zYQs7d0NxybJf4P7qXlR/iNsQg1oJhb7kS1bu9/y/anMZJ9KeePY1i
         mf+WjU5YIf2BtE6wAn7q51l6RYULnf73Vwytwksu4cy+C4/uRXog12Ihv/s9ixha+POP
         I8BhBSgeYf4bl0tn4DVNPTGF7y26xdIKkSOHE0dIg8KOA4AtO849m7yZuqY22iMvl/Ox
         +FATuHppvTY38+b72aMe3gLnXBnA+JOLunwbxjCLMW9qs2ZuQXBmVbaNGNUVccYXF0Xg
         vkyw==
X-Gm-Message-State: AOJu0Yxftioi/Kh6axAlFmAHrvqG/+91u/yJy01V3WHt+kZ3GvPwFF74
	wi8pQ2te2dxYLihsN3p3IJeQS+4cG+DcctTZOPv5ZUlEcPfVx54nOUBF2gKjTcKPpgBAu0KVvlx
	t3tu3Jgs2dnmapg96b6vuhvTfRYR+jQpOLA==
X-Gm-Gg: AeBDievhkQ+tXL9qhNtb48Oo1DbWtXU3bWCoAyb6xdhYGz0loczfGMddZICrSmxzYMq
	/hvfK0+6zM/+YmL4YGIIe63i94yrx/q3djinH1wQ0y7+mI+LHaqQu1aEXpTYH41tbeNT8kdV1Tx
	qZkTgKBDdW+SPlfu0wYP44VW1x0ucxFAkUOzLrKXPMJuqSGIM+I/dHposNBbgVLyr+dW7+H99S1
	e+aeC8uMk6lC5Mj2JtiDkXv7vBUCRuZBrKyeVCJfa0uKIjj2hoLysjEuyOiGRv9IaghqUTw4Ke1
	g5tE8au6SzWYTmw=
X-Received: by 2002:a05:6512:138e:b0:5a2:b8cf:39ce with SMTP id
 2adb3069b0e04-5a4172bd2c3mr7229090e87.10.1776884842939; Wed, 22 Apr 2026
 12:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414191120.29067-1-jwcart2@gmail.com>
In-Reply-To: <20260414191120.29067-1-jwcart2@gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Wed, 22 Apr 2026 15:07:10 -0400
X-Gm-Features: AQROBzBhUXguUKlaBjXWumB9CBElgb6lsMhWcZY4jDh5Zv-9DF4zIOcMmMoWn6E
Message-ID: <CAP+JOzR72tkdmwJEmb1=htSdQ-ZC5wmN5zKpEUbC5kHio1moWA@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsepol: Fix out-of-bounds memory write in discard_tunbables()
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 3:11=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> The function discard_tunables() will walk all the avrule blocks
> and do one of the following two options.
> 1) If preserve_tunables =3D=3D 0, then it will evalutate tunable
> expressions and add the appropriate true or false block to the
> avrules list of the current enabled block.
> 2) If preserve_tunables !- 0, then it will remove the tunable flag
> from all tunables making them booleans.
>
> The function was allocating an array of pointers to cond_bool_datum_t
> with a length of COND_EXPR_MAXDEPTH. The number of tunables was the
> index and each tunable found would be pointed to be the array. This
> is a potential buffer overflow because COND_EXPR_MAXDEPTH is the
> limit on the depth of sub expressions, not the limit on the number
> of items in an expression. Having more than COND_EXPR_MAXDEPTH
> number of tunables in an expression that had a maximum sub
> expression depth of less than COND_EXPR_MAXDEPTH would cause an
> out-of-bounds memory write.
>
> There is no need to wait to update a tunable datum's flag, so
> just update the flags as tunables are found when preserve_tunables
> is true.
>
> This patch is based on a report and patch from the security firm
> Trail of Bits.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

These three patches have been merged.
Jim

> ---
>  libsepol/src/expand.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index ed912b57..5b2b7b03 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -3042,22 +3042,21 @@ static void discard_tunables(sepol_handle_t *sh, =
policydb_t *pol)
>
>                 for (cur_node =3D decl->cond_list; cur_node !=3D NULL;
>                      cur_node =3D cur_node->next) {
> -                       int booleans, tunables, i;
> +                       int booleans =3D 0, tunables =3D 0;
>                         cond_bool_datum_t *booldatum;
> -                       cond_bool_datum_t *tmp[COND_EXPR_MAXDEPTH];
> -
> -                       booleans =3D tunables =3D 0;
> -                       memset(tmp, 0, sizeof(cond_bool_datum_t *) * COND=
_EXPR_MAXDEPTH);
>
>                         for (cur_expr =3D cur_node->expr; cur_expr !=3D N=
ULL;
>                              cur_expr =3D cur_expr->next) {
>                                 if (cur_expr->expr_type !=3D COND_BOOL)
>                                         continue;
>                                 booldatum =3D pol->bool_val_to_struct[cur=
_expr->boolean - 1];
> -                               if (booldatum->flags & COND_BOOL_FLAGS_TU=
NABLE)
> -                                       tmp[tunables++] =3D booldatum;
> -                               else
> +                               if (booldatum->flags & COND_BOOL_FLAGS_TU=
NABLE) {
> +                                       tunables++;
> +                                       if (preserve_tunables)
> +                                               booldatum->flags &=3D ~CO=
ND_BOOL_FLAGS_TUNABLE;
> +                               } else {
>                                         booleans++;
> +                               }
>                         }
>
>                         /* bool_copy_callback() at link phase has ensured
> @@ -3069,10 +3068,6 @@ static void discard_tunables(sepol_handle_t *sh, p=
olicydb_t *pol)
>
>                         if (booleans || preserve_tunables) {
>                                 cur_node->flags &=3D ~COND_NODE_FLAGS_TUN=
ABLE;
> -                               if (tunables) {
> -                                       for (i =3D 0; i < tunables; i++)
> -                                               tmp[i]->flags &=3D ~COND_=
BOOL_FLAGS_TUNABLE;
> -                               }
>                         } else {
>                                 cur_node->flags |=3D COND_NODE_FLAGS_TUNA=
BLE;
>                                 cur_state =3D cond_evaluate_expr(pol, cur=
_node->expr);
> --
> 2.53.0
>
