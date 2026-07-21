Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D44D199EAD
	for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638479; cv=pass; b=QaoY0mzr80jq90u7Th8naKr5S1LKbKY7oKPYRCn+/fxryLpsqJ0wVEcceYS9bIocR/eUJ/reULE1pLKdFUm4eIGzt7dhrGJy/VJHjP+W50g19qv8aw2ALqLrgfwcoYa5Ax7y441Dum5hgo6S0evEWYfXb7L1fcxiM1LYhKkCylo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638479; c=relaxed/simple;
	bh=D2QmCZIVsdek3u7P3V3AuoQG+lTj9lKBwyV5WswYnJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikxENNLXenL7eboaLuYRbSrShQWOdHss0pPHb1BifnTh+oRbAYhI1M0FWGyVTSPZ1L94TXl+HPWqlXoQZRW6hjxWsNYR+E92ok4tHP15dUE7vXYQSPp8xgPLMzQIVf+4B4IsExpAR7JRUTKPzinxbPF3t/EJuXvXuJWZEJkAcPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMn+XaJp; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMn+XaJp"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so9579851a91.0
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2026 05:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638478; cv=none;
        d=google.com; s=arc-20260327;
        b=H0Fn5vAW+2B+rvGpe/3f/GgMTyrzR5vzAU63Nv8vF1RbSVzlYI8vozqIOpWzU0pN7k
         hKEqBZFvfjXSf0DNZ6c6ofRTWEHod2E8HJ84/IY2WpkkRhXKTlmw4+UzeSOfppC9ym5t
         mz+yQLZpb/yrJcRdnKOBlLFlEEH3vqW1yjra5w/Kt/icN/QXWRO0YbOPj8UOGu1SCEhe
         bwVteWsJk/5Bob3Nii80z0EpLqwhazk8u29fpyJxRaLrflXb8/tsMdUai0trLi/kQ9de
         Rrx/ANgv1RuNxyb7YlaqdJUJmVPvQmUviSbmWZJJZC5xE7lBXeIZqcavjQakOo16Yug+
         daIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=19BG5bgeoV252jz2U2rvKSd3+CUkGYpX5Ldr58HFwHY=;
        fh=gfzHzywM79Llzpb3oUi4mMfwpHTHBNavmzg+APAH/VE=;
        b=rkQqMndc+VxCst1UgvPVZ4xdIG3Cn+SQMnrcjCXVX7RnlYql3g33rpcWUcJJwjZ7sx
         c+JQOZuphAMyj7SSb7faizqcex7a5a7mrdi3bAyZXpPqCogOkmc6J2fjLVE6Czp//yyx
         eXgAVWgJmXS/y3KRDjFrqQGiIk+XWsxidc6CAwkToPyIqx734MSVkfpGVtpwMDKRAu35
         //jGZ8z65tCuwu5PuUJ+zh+7k3lEpWllAWEVSgAWxWRCHmvrQmrJ+k6EmYga6+Fx7pP/
         lmlvrU19ioOQ0Y6EggyhEOguV9aREeYONjLEDHKRsXWj4XjPjBna7z+Ywtq+tRQIBvrj
         2BjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784638478; x=1785243278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=19BG5bgeoV252jz2U2rvKSd3+CUkGYpX5Ldr58HFwHY=;
        b=nMn+XaJp8FNjsOA+ajR5u9J8PrGDrMj0xV/p5uIx1Ee2gxP9oTuzMYLvQSUSOqJWSP
         +UMGhSp1JMSISAd3TKgW1siSjSV0wYHiiPIdrjW+3h02KnMg6W1Oj4R2uCWVkmPkh7k1
         ni5MehWwgTDmIpaiNXgFL2mnPhU5PMXT6v4L3aU8rnYzSptlpeAU+TgfDIL7Mp5U9Cuu
         cxli1SCO3MhzRt3DPuLWyGgph2YjcuBXIhYVKH4XcaEN2K38YxE0uXk1smaBHHQh2Qi7
         fZqifVqmMgbNMGwTmWfhSlXiP3O40k05lWagh1mNdOCF3DD/FdIZvZLFa1U4no4abSRc
         uwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638478; x=1785243278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=19BG5bgeoV252jz2U2rvKSd3+CUkGYpX5Ldr58HFwHY=;
        b=b7jdbyD8/dm/k3iNOEZwTy8LjrcnC+LWwGYbftCs5V2WWUusoyoII1blG9W+8ur6x9
         e6q+Br0Z17nU5EPeJvtyQj6/KUaCXZndCuc/3AqGKhkb8EShuOKEDnxeuoGaYQSGYGZu
         8n/dvhE2yolPRs1OQwi2IIPD1q6FR97aJCDVwbSH7hoPX9xvtKNaMbifT/7mQaewLgSC
         kQVK/CowCk4cmqdf7O6QdJni6SohQUEhHe0PanpCa6JtMzis76yQfKYllw1i/SVGGQi8
         vnIAeZc4bnWm34Tjc4gNXkxAKG1q7v1IFurQJGNzT0Tf87ITRVHXq8vLiwye2hJ4HafE
         l5Jw==
X-Gm-Message-State: AOJu0YwpaDl0ymJtT7UBFk7ZCNM4hRztIr5HuEH9JalcsPN43Km7V01D
	tvj5CdYxDaVDbBHIy8/2Q4Z8oB7DidcLSalB0wltLzh+ZZiM8p06UAqVeC9AdwyAvlPfb5bC2bf
	9jmYdeL7wUwXDhjCw0zzso11i/QvTcpmyXA==
X-Gm-Gg: AR+sD10d4YbJcVXLNTekxZOaNWYeqhHG62INeqYGBwQtD8qKPEjs5K6w0jIU4u8Zbu4
	NPtiDb57wspmHXuQm92cFRfoD2tzPWVkoD6EjAM86roXJbdJPKiCDLIw8z/KIap05vtMSdj6Zmc
	oazBxl5rnocR1wUi9qmZ91l5lPWuJdpCY4Cj4v8Uflz/aUkuFXFZav0AjpHIAGCNDd2ARx2xyLE
	GdPk59brV+DX8oUXFR+hUKn/IBI3JYbHDHwPJddthwON4Niyk8Na8pSt43kAg==
X-Received: by 2002:a17:90b:442f:b0:38e:6d4c:14e6 with SMTP id
 98e67ed59e1d1-38e6d4c15a9mr8284002a91.3.1784638477910; Tue, 21 Jul 2026
 05:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717143330.18119-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20260717143330.18119-1-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 21 Jul 2026 08:54:25 -0400
X-Gm-Features: AUfX_myz0zJd5fA_bww9_sW7CSWTMw-CnHlI5sOJe8GRgfuZJHyJECEi-FzOrQE
Message-ID: <CAEjxPJ5ab_=+wUD_EK3U3WCn9s4B48PwrXq1=DtJ+FqBn4ia4A@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: do not call close(fd) when fd < 0
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, plautrba@redhat.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 10:33=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> The error path was incorrectly calling close(fd) when fd < 0.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.

> ---
>  libselinux/utils/sefcontext_compile.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sef=
context_compile.c
> index ab73180d..f8115026 100644
> --- a/libselinux/utils/sefcontext_compile.c
> +++ b/libselinux/utils/sefcontext_compile.c
> @@ -707,7 +707,6 @@ int main(int argc, char *argv[])
>         if (fd < 0) {
>                 fprintf(stderr, "%s: mkstemp %s failed: %s\n", argv[0], t=
mp,
>                         strerror(errno));
> -               close(fd);
>                 goto err;
>         }
>
> --
> 2.55.0
>
