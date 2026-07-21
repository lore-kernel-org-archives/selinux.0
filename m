Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC80932720D
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638453; cv=pass; b=hNjcH2EtCQCUe/ntkZyRhoCpBTFGgSdsa38Kuvjhw1XF9MMH6imemSbEyWDOspnHpkkzOOU7BNymRRZ3LLT2Ckr/RMi1RCXfrI3a3MBOuQUUc1bx8tVq+3YSL+Olt1s+98iKdOqLs+kaI5nOvfM84q0tRh/BEfv+4giu5YhTRRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638453; c=relaxed/simple;
	bh=uWbuktItQUlIcBPrZWFCvaonxP/rhYO1eKPe2w12/D4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQANvj/5aMUR/x76J0fOLYDiBfOrCD2k1aKDbpJ+fsa5bJalS+ag61vWxnU8KOFm0hHa5uGrclS/fG9WNBtuNcR3hn8T7fM/d44GzZDQm72zBPitVHzHwF79/5KD9sxf7FV990MmVnf8CU/IZ4/PfBJmL5g5aw3hu6/iwRTT29M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyJ9zhU8; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyJ9zhU8"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845c92bc464so6945944b3a.2
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638452; cv=none;
        d=google.com; s=arc-20260327;
        b=nVNBa664wmIFWnWZC7tfTLV37qGkAZAHQ0vAnyooy6qqLGqKaDeZLWw+1+ByNOniZm
         Un2jgdROnUbg5CrRDUGk/c1shMH/21xhKmE0vb/i6fj54Yc111br85539HGRSnsdFT5J
         XTgEqDDigyABj559ZSUlnX75jiula9l4mc2jmJ0Y6UeVX1hMfytYkuneKBfuiK0HTO66
         LasKJptgB6oB6FOneSK+GFXzBfcQ32+jNPA66eaRQ7gOCrHBLG2b5LjyWHPAme24lw2X
         XQ7PUVBAhLFGqs+3ubHYrv0EoG/hBHMay25anGKV6irJv4F70MUuqks4hHlsAhVyxfxg
         TQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oMXNT4AoOBnTYkwv/OzqlY5Aikzm70TSufMkDoMfwsw=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=ZvBHl33a7HK11JU7e5pHT480dgr1mHupeLZTWh5Liqlr08ZsFq0IWqCpItF8mq42XF
         UYGOvaOcyU/tPuyOrzBPZ/iPP3MQa9agTQQK1naed1Csm6WNj8GVNvIbCNZaD4rS7Ixr
         a7pIkxpWj/GeQlbFWuJaw9rvrYxCgIHtn77xYaoXV+cY8irBXGx4jrnLszQJqPZmiBmt
         YsRC41qBq4GaIYq8mFfRQaGGxsYYMqMGOKhxBHGxpbRSfZ3lebr4z9rq6OdMtCnecMab
         0+t+/pg1osnspJ4dMKMn0zbfCM5pRi46qwnLRAhmuaQVBH16HNGj8fKTnPd1i9Yo+mI0
         zFKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638452; x=1785243252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oMXNT4AoOBnTYkwv/OzqlY5Aikzm70TSufMkDoMfwsw=;
        b=pyJ9zhU88OeNuE1MTn0Yyq/6cz6grBZaZWp/r0h4d8PR03WRFvxEIpUXO1T17sFfkb
         sJOQeWxqYCqsR8OrOyJ1WtO+HZquaoyGQbc8vxD4sgYOa89hbFDLMJ+a7m8Y87BehVut
         IzTUsk46+3VaCEmxQzRR3fYZCg5CNPIJccRioxbVaNbxYWUBQyhlwqKVt0SvgZWXgE6g
         LjOod/TmbKOrVSUQTuyj+KZ4rPJEXVimj1vzR8XVIkAL1OuAqKpO6GbBwQV6xk+6U390
         EEaH0IhhBR2R7eMy2vIa38qiXl20mupjddRxOfoWITEEb1tW5PY2atGOaqdGZQdL89qy
         K0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638452; x=1785243252;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oMXNT4AoOBnTYkwv/OzqlY5Aikzm70TSufMkDoMfwsw=;
        b=UHnjJ5rkVDfi6Och0hxCBCCLlfzF3b5z+r0hHdhmLMqUJF+Chkti7s3I46NU6s+EuN
         q3WiQgqrumP00wis8rgMWQlu4372yYqxR+aBlAP0OyRQ7y5zTG27fI3/RHf/o90U9Vdj
         L6t8TvQztcEj4bEnmnxO9cDRbM5Kt6wAFsW6raAfCioDBL0KPw83rcTj9Xzl062uDYNh
         gITe30X/JKH8H5c1HEX9jeznyvNOU2c25AdRu28cgesXH6HPMc/ZFz9Qhiz/YeRyKS5p
         i2WmeglBbzagZL5nhHeCqhd4/AKadWpkAt5FtRyL5UxDdyzz23W1i3XNHVGOZ2VaFylD
         RVGQ==
X-Gm-Message-State: AOJu0Yz+5ERHO8x5I0vYKXp2z+BBAB0TZkLGFSUcdB1No4tkfGzMAHiY
	gNb1YgKLlGCu2nfj8wbqs3RfnZkPIcsPhNfy+onZlLMv78QJnQmBehhamdGeQYH/FyK1XR/qvgj
	X4jhN12PsL0rvvWINAr9xeeHZvts1RnljBw==
X-Gm-Gg: AR+sD13hma3jritfR06Mx47sE4TPAjwyHbVH7qJZ7HwKdv90n7+o5OMO6zgNvqSqXJG
	CCV994qBEiXnpJSDw7qvFEygfyrktI4i7Io4BTJTICImtwCLsLzq8+uF4R0/rAMT71hbOznw/Nz
	7kP7e+tazQwK5Y9VYgIKmfn1Tb1AfEZLcfgBccWLkfP64IyljHCr+saeHGT2RV9DguXoMN4PwEU
	I48skdxAXkTiVHNqRVb3OUU4OpQaK6BiIlxdMXkBP4I4lYDtA4Ihf4KMCO5JQ==
X-Received: by 2002:a05:6a00:90a8:b0:845:e1a3:107e with SMTP id
 d2e1a72fcca58-84c2952c249mr18080426b3a.52.1784638451930; Tue, 21 Jul 2026
 05:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716195732.11660-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260716195732.11660-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:54:00 -0400
X-Gm-Features: AUfX_mxTKpMGi72qv-HcU1Cqq5XxddcWyTGvOZ3Pz_MjAIhripguFg_vD0GuFwA
Message-ID: <CAEjxPJ6WzreWdVMBPz5zZu8LYdBUSK31UMYGTgiR-RvTvz7Aog@mail.gmail.com>
Subject: Re: [PATCH] mcstrans: match base classification and word text case-insensitively
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 3:57=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The base classification and word regexes are compiled with
> PCRE2_CASELESS so a differently cased input matches the regex, but the
> extracted substring is then compared against the configured text with
> strcmp/strncmp() and fails.
>
> Use strcasecmp()/strncasecmp() so the follow-up lookup is consistent
> with the caseless regex.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merged.

> ---
>  mcstrans/src/mcstrans.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index 8ed1aa95..89235269 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -1285,7 +1285,7 @@ static char *compute_raw_from_trans(const char *lev=
el, domain_t *domain)
>                           match, strlen(match));
>                 base_classification_t *bc;
>                 for (bc =3D domain->base_classifications; bc; bc =3D bc->=
next) {
> -                       if (!strcmp(bc->trans, match)) {
> +                       if (!strcasecmp(bc->trans, match)) {
>                                 log_debug(
>                                         " compute_raw_from_trans base cla=
ssification %s matched %s\n",
>                                         level, bc->trans);
> @@ -1443,7 +1443,7 @@ static char *compute_raw_from_trans(const char *lev=
el, domain_t *domain)
>                                                                 int wlen =
=3D strlen(
>                                                                         w=
->text);
>                                                                 if (plen =
>=3D wlen &&
> -                                                                   !strn=
cmp(
> +                                                                   !strn=
casecmp(
>                                                                          =
   w->text,
>                                                                          =
   p,
>                                                                          =
   strlen(w->text))) {
> --
> 2.55.0
>
