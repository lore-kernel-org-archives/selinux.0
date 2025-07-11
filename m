Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF87A148827
	for <selinux@vger.kernel.org>; Fri, 11 Jul 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244429; cv=none; b=IC/Gdl16VYDV5mfl1cK6VDbf45uYl4L/R7R+Flbwrl7DeoyhO/0xDQhwILFiwTTqeBEDMrvTtjVQDAcPUdIKj13Lhi3RPSPKuMFPXzVFjHJsd0hfZv6AF1ymtAD7y5t5ysixkExBhQ6Psp8TWX3fuNqwFQ9Rhppro7VbApsmzBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244429; c=relaxed/simple;
	bh=8EQrLALbXdhrjQ5jVA8+1HZmOzMWYtoNDHLv3pQPKwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sCThx/TccGJpQSqYhYR7V8g7dWmztFWzT8C7pOlhAbKku5uFzCMkL3wrLQgLh0+jhFCQ0Zj37MP6Cz7MlYm2PbAkXFT38n5opBtE3K1k5qQLIH4rsGyO3tTt96TL9Me4A9h+WKYwgLwcoC+qxUD1wnNwwDirqrrxEi5sJMOppOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbzGqCOW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbzGqCOW"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b31d578e774so2836483a12.1
        for <selinux@vger.kernel.org>; Fri, 11 Jul 2025 07:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752244427; x=1752849227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llKVvRGuUm2a68Ss91thZXfT5YWJTPCvkcTV0N3Orzw=;
        b=hbzGqCOWVjOlbz6qhcvKRAx+Yai7q/i1nkWpEJu3f50VdzGP/fojI7sbpobO3Mkmpq
         07yDwJ/DLnk3yggqvwnQUfcfXP6wK2Dt3PucnQSly0epAkbxq9Fz8LiqZ+xhqol75TtX
         Lu+73Sj+J//2PEeuMYdF95V6s5xxr1e71YunqqMTSqrICGRa+4pFL00rwCOjEjYrGFJt
         B7bPdky1U5Zkz1LO/bmhuBFXttG905s/2PH4bsSywBm2+Clb0hPqrlpNUO2lVP4K62hl
         QC2iU8z4FEWLsiWZmctoi9rx/+ZAe9SchQ3loYgEC5BX9GWFQdOpJs5sRe55h83Belzq
         dHUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752244427; x=1752849227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llKVvRGuUm2a68Ss91thZXfT5YWJTPCvkcTV0N3Orzw=;
        b=NcT1Elh1+Ti2qh27mcavvfMRtPUevZGToYFHJCoh1V5Vakac5/Sxp9HoU/8K8wmJ7Y
         txcxHDMogdTXzcWwvqzocD6rb9b5R/unB1cjhMtl+XeSdwD3qdetxazSFwGZT3a5apMv
         HQsEQa/9/OK5WMmqD6NxjqPugMEsB8lhtxyo0vrJVRrq/xgnEJFFvsdetRPkDZGYlV27
         32CURMmCA5bR6NvSDQLVpt4tBgqqVifNT6xeaLB2K1wULXKX8442UNBpQQAxK9sf/Yx2
         lDQgMh3ex0liFYY2Ti8KtISVHkW6MTRDSZlefNv5sTtH/8mcV5heNRUOgwwAZeYdg+OC
         G2uw==
X-Gm-Message-State: AOJu0YwotHx1SZl6r+ErbQdknihEU4TecPkUYyexIYX8n4n4HF87MGq5
	MBBDTyeAlH0eyS0wwYDf6BGC3DX7CLgQO8kB2XCfjpHjT64IsIMjnjQFvhycpCw8jle86Z0C4cM
	cLDZGI8EHrOkSSqZo7fIrY9JfjuZbo4++qw==
X-Gm-Gg: ASbGncsqQp0CUvKHcNzd3c/jJTgRMJ2jRnDu3H8FoGk9hHvFoy90yMGY/iCe0MWBZ7d
	0dMFcifg15k1RmsRs0P2FSCiShjKqEnxx7KT69e0Eqjhd93BcFTOObZq1J2uqheTOjsGk5/2rLJ
	m3SCDKNBgdYEIYGHyqaNh1xyQLmq2oF3HTqgD76uSIGjX6IyOvgbQyK07UUD1GP5pgaP9LrdPWG
	1ueEN/y9dQ/k0eX3w==
X-Google-Smtp-Source: AGHT+IH3HyDx4B4KmiVFkdGm1eAQSqWsder8He9XzkkHrCptx7pCSKocp7oElFUC5RbH9o6eLlmhk+NQy/14mDQqBKY=
X-Received: by 2002:a17:90b:2e47:b0:313:f995:91cc with SMTP id
 98e67ed59e1d1-31c3cf1a3d5mr11682368a91.2.1752244426806; Fri, 11 Jul 2025
 07:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626155755.21075-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250626155755.21075-2-stephen.smalley.work@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 11 Jul 2025 10:33:35 -0400
X-Gm-Features: Ac12FXy_LLq6qn48jEJRo5U0UAuXdRedZnuZ96mhOOoAJnOg4rAmymTwJUrwypM
Message-ID: <CAEjxPJ5824rxcio4kZyN9N_ho_zTGPmyu=kJmyA4X5Dnf5+zhQ@mail.gmail.com>
Subject: Re: [PATCH] SECURITY.md: add my email address and GPG key fingerprint
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com, lautrbach@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 11:58=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

NAK'ing my own patch due to generating a new key for this purpose,
will follow up again once it is signed by others.


> ---
> No hurry on this so feel free to wait until after final release if you li=
ke.
>
>  SECURITY.md | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/SECURITY.md b/SECURITY.md
> index 4f624f5d..2fee4927 100644
> --- a/SECURITY.md
> +++ b/SECURITY.md
> @@ -33,6 +33,8 @@ the issue as quickly as possible and shorten the disclo=
sure window.
>    *  (GPG fingerprint) 4568 1128 449B 65F8 80C6  1797 3A84 A946 B4BA 62A=
E
>  * Paul Moore, paul@paul-moore.com
>    *  (GPG fingerprint) 7100 AADF AE6E 6E94 0D2E  0AD6 55E4 5A5A E8CA 7C8=
A
> +* Stephen Smalley, stephen.smalley.work@gmail.com
> +  *  (GPG fingerprint) 5073 3D29 EB3D 5CF7 17AB  32FE 100E 57E3 3B8B 54F=
2
>  * Jason Zaman, perfinion@gentoo.org
>    *  (GPG fingerprint) 6319 1CE9 4183 0986 89CA  B8DB 7EF1 37EC 935B 0EA=
F
>  * Steve Lawrence, slawrence@tresys.com
> --
> 2.49.0
>
