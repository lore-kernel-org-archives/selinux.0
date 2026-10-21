Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792587472;
	b=a5sdd7LLCgl/t3tK5aLAYvKCP/Er/6j0lux/LI4lrik6Gd873tLaHZuPSD8Y3uJwVEw3
	 /jqcRD2mekRnilGlDqwLkE/q0Z4QmJbbwjr6AJmpWwmj2BVG/dbbg2LsZ/PWjU0/eqm+f
	 bF4sLpgu18ixpNhPxpGdjadmecNDNC04FBgxSzR7KsyTCv3OjUZRT7+7wll8pLvjEPJKd
	 9YxmDywNG5OP7Vs7DwaycYpiGl7RrL+nUGhCzBJsEpmO45EN1N9TsmQSmen2tQtIdV/3H
	 CqW3Cl5+7Cd5QyzjMYeNryZPGA8274nzzMvxP2uV73GyQnvF/GcVn5zqYjADexiqrOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=fUZvO19o5Pm+wAlRlAl4PmutFh3nt1tufPTD9vE7Nvo=;
	b=MDcZfKBzGxoAuTdyq05BixGrEHkJVHONaWXfhtgdF0hWZv5OpLIp8gCkaM0rv32in09F
	 ScZXVhgTJmjPa05eFeZwlW7+xzLHqLkqH/3v5rA88qcwsj478VpB5+Pua9yyGwJ1XUu57
	 IgLgMI0Aig2NvPqN57RrjVOuSXugN+2swC0AjHuKdxrPFN80bn8VTHHw+YsDOc0k1rVbA
	 V7amY9YHobbNAV/oOY/ij4r9XGJhHt6LYk1TTn1+AR8qaizd0TSdxSvwdRppDjlowBx7j
	 6gBdfoLD+93PKaMQz3R8gOGqQOj970jwVzjaBm8JWg2s3Dic9624FIGyvbnhsnXVafg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MfLjJjC1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF0606A31E
	for <selinux@vger.kernel.org>; Wed, 21 Oct 2026 12:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08AF0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MfLjJjC1
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8a83d2706fdso5350667b3.0
        for <selinux@vger.kernel.org>; Wed, 21 Oct 2026 05:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792587471; cv=none;
        d=google.com; s=arc-20260327;
        b=Rs55K5FDzSpbpQ6zbEOhL1BTncPc7d1Wmobmyd5IJd9DkwEa9o6WdFpNRBzyqb7hQH
         e4hdYF1GuSa0nOPX2BAyTst+WExcD5Ov4HMIAFRlCfm9Qtub96ThDc966bBm/o8n9m4V
         HvGkPikjguN9efW0/fzc94u+FdJrByiDDIlC4TxxHPuOo0lfBscW00AM5sXdOrgKYXLf
         iFrkEZnXxlJYEY4yFsDa0Mk3ohy9zsKZohrJK1O+zS08RXII0pvlWv/0I4zZj0Y+7+in
         0ZpKrfDp0lhEZs6L6ksoK0lgAI81ZeoogsBC29DRr9py5ER1P2sdjbIU06AaEEVlP+Gh
         bA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fUZvO19o5Pm+wAlRlAl4PmutFh3nt1tufPTD9vE7Nvo=;
        fh=FI/PfdRZ2Lz4Qx0n8jPAAJ3JkXy61tFrPS9hpnSBL+w=;
        b=Jrslia0Y1IMGYN2iZ3IYAgg9HZBi/jKF+4DNbIbeZo65cqUIwpG/IRjN/6vH3mRfsH
         D4K3O6CY3gko4dj7nCiAiHSMKZmtTyvuW3+/9qhx/f7jO+yLjiAbeo37mXac437z5yN7
         DpE0CSmNiRiB7vUth6wFtrvvsOFxfqVw/bblmX8BUm07CgPJ/YauWV8khUgN0GedYcWG
         OFvDWTXHqpU7mfaQL5o4OqNJ+H8YSjgRpA9Q/tcezKodqylR9aamyNrytMrmuniqK7wW
         8bVQZlDdw61UCndimEHnBszwwffmGGJBem7mQIyn41meIwK9OshqYCzPzpfLo5Z618Dp
         uoEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587471; x=1793192271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fUZvO19o5Pm+wAlRlAl4PmutFh3nt1tufPTD9vE7Nvo=;
        b=MfLjJjC1wn0+6bQQ6xpWjsGhOMSHyISO6EYSHfP1nzsb5nHh1/YXBvKUjcJa9EuMvH
         C7ty3BwMxZd2WVA9Yfc0F0hkOgawA5tt3ZmWnzZ2T1j7juvMU3Sw/MEIOgL/iU2/a/iU
         70hW+P6xHblI6ghtLxXo3lFfRGR6zxgdczn5jQOwEDPha0QQ+uQwVDLrf6wClfhqDNg+
         spk6ChOUG7BKhJ70F47bfT3XNWJfPApPAYe4lB73uMoCCBXo9yjXTopylyTK4bV1rMKk
         zUeEDPCJuvdQDYdnyQzDpq1lDWM3E6shzadq5lIgaF4XfjMZUET5sGtSIfiSeEf7uMHt
         v41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587471; x=1793192271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUZvO19o5Pm+wAlRlAl4PmutFh3nt1tufPTD9vE7Nvo=;
        b=FM/6XXzE1GuP4pqxNCovdQOy21T3O4NSap1zigz98UHNuCNztxcmEFM1KEL2+uNa8W
         T8TAgBTeV5f99iImjMr7+xhz6FQcNeluorPqt0Lk36bFklVCjt9UJJDwAXyJB2egcoN/
         wIP8XhtM2b5GkHiSnADFazD81rx26U2pUg8RW9iKqZOvQ/HbP+TkMJT7mEegn9N1mM3A
         Cpf4LCjcQPsnDQmjNvUYw6TKjZvuWTt1R4LsOKBCgpQPO8qqSmBIOh51Bq8jj467Leqd
         sKhFfEodYZk6txXlkIpFoSlUNVhO87EclolS1BaKCgo8ZAo+e2DnNS+CJDaAzat7zVsS
         gbdA==
X-Gm-Message-State: AFq9FYJ7dH7rFSYbSzmHK+PXB0cu6iLk4Ta9dnRl/JAB6L5XU14KmpIM
	mocR5fJacOE36rzRyXvBFPoqA7GYBO5ZZ5/BLedG0kyHZWjO3kqnFjF5f0u5pQY8grOMcDJIKgt
	O4WWE0UWWwYDG+w8xIC3qTTzOVTQ8jrQ=
X-Gm-Gg: AYBFou0CpCCupUTFi3MyPq5mWl2l88LdbrQbcYB+XkKYt2Hgwqs2WLGFCKpcPiB4Kxr
	tCWJpFbdDEFAP74OAtytRmrid1+JA7/bcLaFsJELOGM0QUHgPT3tHhHoDi41XTtbuFhgUl/WvNd
	btFs2DaDiQuvd9Ssv93hHUlUOpqJZ0Vdd8+3e+84iJLAfifNY91RFtqIX8+wopFT+URzNDKzg30
	NFhomg7gsCr1tNE0epk61/qmZVueUClmF7dgB7hnFKwqvckKzTAChlntMOdb3xyp1FDgcuBSxon
	zRAjsYCjTE+BVlNZ1Zy7ckb7DYT2T3xs8Rl69arPB1ECEhfAQdHmHzJLt6b4cgoMAQuXsiGjVQt
	D1xkT9iHeCWq8MyHDXSNrteLytDume962p8pg+h75XxhP9dmyxzApfDO4GpF2lMp1U4ZWA0Sspw
	6OuMhXDAr9UrzmeZZ4T/5kssXRv9RB6glEpSiKaS80sJI=
X-Received: by 2002:a05:690c:ed6:b0:8a8:8d90:a66a with SMTP id
 00721157ae682-8b13408f190mr8237837b3.87.1792587471046; Wed, 21 Oct 2026
 05:57:51 -0700 (PDT)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018012855.1795025-1-phugen@redhat.com> <20261020180701.2710971-1-phugen@redhat.com>
In-Reply-To: <20261020180701.2710971-1-phugen@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 21 Oct 2026 08:57:40 -0400
X-Gm-Features: AclHuK-LCY8sLg_hiNmsHLE0w9458xLgDovnGwX0w_KObkvenPffdFrfT-v70bo
Message-ID: <CAEjxPJ5hHwmf7fMcrNwtW62Z_sSCsRfh5vvYBn0ZcyDGUHUtOQ@mail.gmail.com>
Subject: Re: [PATCH v2] tests/keys: skip KEYCTL_DH_COMPUTE when unavailable
To: Pablo Alessandro Santos Hugen <phugen@redhat.com>
Cc: selinux@vger.kernel.org, omosnacek@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 2:07=E2=80=AFPM Pablo Alessandro Santos Hugen
<phugen@redhat.com> wrote:
>
> Since 32f07cc40c9b ("crypto: dh - disallow plain "dh" usage in
> FIPS mode") landed in linux 5.18, plain "dh" is disallowed in
> FIPS mode per SP800-56Arev3. keyctl(KEYCTL_DH_COMPUTE) returns
> ENOENT in FIPS mode.
>
> Treat ENOENT and EOPNOTSUPP as non-fatal in keyctl.c and
> request_keys.c (the operation is unavailable, not denied by
> policy). SELinux denials (EACCES) still exit 9/8.
>
> Fixes: 2d7aad8a1f8c ("selinux-testsuite: Add keys tests")
> Signed-off-by: Pablo Alessandro Santos Hugen <phugen@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Note that this will skip this testing on FIPS-enabled hosts so it
won't be exercised if your testing infrastructure always enables FIPS;
that's ok with me but noting for the record.
