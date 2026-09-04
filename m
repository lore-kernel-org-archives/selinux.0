Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A93F1AA1
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788526195; cv=pass; b=Qm4UlK10fxIQQ1XfoR7NG2xqVWnmME0tAzWsYqlzKKWQQr2CsZREOS/xJUe/ZffEO9sdppFKX5DhG8H+TeAUTrIRSSrHB4sDt1izf+ivVRvM+/orz2QgYTC/7f4w3VkaipBymr/0dkbwY+6lhNbrocQJeuiLI3umrOxtLJNctOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788526195; c=relaxed/simple;
	bh=UrIjpnn75oCJu7GqizmB2qb0Vnft+/m6+7tG4VSnD5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjX5dXmi1HjKpGC2bj6KapCp859F5jRotjbdEnM4e5RXRoDnhh1MZt/APSPiJVDR1uPvWy0MZ0BR0NonLzPyrTfR8L4Oru+Gw2+YW2Xnh9f/XUNbgnh+o6QLKfKDzvJc3IDjP5RqXiK9XwIugeE65fr1IdyGu4uZN1xWwvWdh2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mokdE+ml; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mokdE+ml"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-46ac530b9ebso846049fac.0
        for <selinux@vger.kernel.org>; Fri, 04 Sep 2026 05:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788526192; cv=none;
        d=google.com; s=arc-20260327;
        b=DtsBdkIXMCNXMAx07tyDwcf8+4BZBB34j0cvh5GxheKpZsXW+j8UWZW6wWVHXa3Fke
         UPd7tlfr1rJnygVWGCY7SMoLIy7ddwOR5lRy3GI1tamaIskcBpblE3AZ227j0X3CGO1+
         zRWee/z5LpxQ0wa6th+7mCjJd+aki9P0f2Xuhh5TrUe6fZJ+Xsg6Ju7/+yCAItw6+Hzd
         U1Iiz2ii2X3rth4dRqAwYPyNS1uT7PDrmQHRaAw1YCHRb++2gD0H2oRhB14vzwKBx0DI
         ddsdZ3BePvn1JiTX7xX2Xom+1eDr3TvJhtsgicRRWcoVEGB11WNSzntJW3sWjv+htp64
         gNiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K51Atqkvh45WUFNgzTNJ6PvWbZjzkQU8cCbSL959GN4=;
        fh=VWwbX+H1Sc8ilbX5LEN836EN17/lKaPP6kwZv2JuZcs=;
        b=JMs8pBKGTRefrpS+IeFYCtuOsdKSuEDAfqPEb0bDUUjsWckPzu2egNCG8gMqKry8xi
         RGDNYYC00YhD5mLQ9SUtSEx0MWeagmWzBn+3p2rjnB0Tpr5H8BxSyri1q6gqCa5TTRQT
         31tq0MzXpoT+dkrt/+tPLD+/hGOcgU25wbNkYuv5wE6ULSfVRLSBIkXxNqIgT73hgK/d
         tOEU18zyNUw1x5blAuAklp9IeAL5VIm5b1VHfuEvahqZG9+DLL9T98EWM18qbwk3PuWD
         RmpVkI3acDGGoZdI9trWDD1GGsZMH3UNdWOnfkhyVqxlw3mSyIeuHjYo+TWRWSJJUqId
         sZpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788526192; x=1789130992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K51Atqkvh45WUFNgzTNJ6PvWbZjzkQU8cCbSL959GN4=;
        b=mokdE+mlUKvt3wjTD8JmUedfTJIcAPa2RhknJQakhG9hNLAvmB5NhbkAzqw0/EcITE
         b/43LfhJG3uSEl7zJOp0iyCTE9bFLX1ryelZTYjMAjueppqD+OWeLCy+KowiS+YUDxuS
         sHLuRbHyfDvhyxH+K06kwxk3OqnhWJG4P3/k2LIocFSLsGLKCHRVweIyrA0+1AU2oNsr
         4YZDM5kFnixH9OlgNlAe1aLh3Sa5uPk8xDWhoZW4AEbvF6gBcq8Tq5vQIKQmX+WUlwRg
         POJAwmGajdlZKZygN8l2ILp4SmyUKQno2jl5khAcoOwFow14RSimtr7E1eVwCYFtxdMZ
         n/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788526192; x=1789130992;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K51Atqkvh45WUFNgzTNJ6PvWbZjzkQU8cCbSL959GN4=;
        b=NWuvSR7XGqzjqGXIAlt1Pg4bTrTWl12kr6dWJ6Iwu4AhNK96EyAmgJm/EMOHU1VG7f
         UlY1R8tTueUenyAlfo+9q5wxOlFtrXfINK9KEP3qAXhV4+YUvl4aIVCZYyzErI+sV6W2
         jWUb0uMCgNYprjNdy35J9x5YFUJSmRuOKAP77gJRBHo2WEQSX47LsYHQxpNQ4jDfnc6O
         3XPv9O8MJUmCkmIY/uI9ytt/uLzXpMa9R295ScySdDnvPgHX7YHX5sipJpeE9lDwXIFc
         66Iud4PuPHZ/+WVAUquV6mq5amCNavcdU8DwEhynxyP69j/cN8QL5+dI1mRnYSwH5Qdx
         izoQ==
X-Gm-Message-State: AFuF++kDmw7S7LscjVv17zDR8YigNfpG1WGeY+2dw5NN0/BkYB1FInpr
	7hu1gjUA1358DifgvVxZNvW46K3GHggwgbAHLcLT3dUul+2TVd8+CdU70EBQVVrWNz+W01bo4lV
	A+zNHu7BiYcBygKJyZRBOMVxM3III9OlwyA==
X-Gm-Gg: AYBFou3PUmOpBHCJ8nB6RoalTzQIBwdF74w4LN7dkpk+2MjzciGA77wi3voFHw/z+/z
	EKlx2VQeYEYdZxnCjXe+Gz8rDAE29LvKhCUX/Qojz7Jy/kJOU4clOtMW1tCioWpxlUAVp2ZMctZ
	44js5zySff9bN1S2BQeXFsMKx7rynuee4LhFuiEuiJzqs61/JkX6g5/vTomE73e7yDokBmdrCbG
	cloVH+IhJQdZKd5KBnDRup7623MCghS4rOkq6Dc7mA6lgxNQyGmR/5fjPYF6iCYGDj5LSQ3ILJe
	gqddjZ7Oozuotik0Ry6TjX4PfWLDeJw0ijKzrrTRxfpy
X-Received: by 2002:a05:6871:68c6:b0:456:4c6b:773a with SMTP id
 586e51a60fabf-4757b5318afmr1758504fac.9.1788526192382; Fri, 04 Sep 2026
 05:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904121559.1658789-1-lautrbach@redhat.com>
In-Reply-To: <20260904121559.1658789-1-lautrbach@redhat.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 4 Sep 2026 08:49:40 -0400
X-Gm-Features: AcwNN1WCSlb1LosWLaVRfUhJ6onjcYmvrvtTqCaY8Z0iVQJJZyT9gZLX_6Z6kbc
Message-ID: <CAEjxPJ4SNx2VSSm3ZXNoh425vOmP-SjBcrgW52HA_TcE2wbAxA@mail.gmail.com>
Subject: Re: [PATCH v4] Add support for UTF-8 in file context specifications
To: Petr Lautrbach <lautrbach@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:34=E2=80=AFAM Petr Lautrbach <lautrbach@redhat.com=
> wrote:
>
> Implement support for UTF-8 symbols in file specifications. Strings
> representing paths are processed as bytes so if users need to use
> wildcards on non-ascii symbols, they need to put them in pcre groups,
> e.g. "/opt/=C5=BElu=C5=A5ou(=C4=8D)+"
>
> This brings some overhead and so it's possible to disable UTF-8 support
> build time using DISABLE_UTF=3Dy environment variable.
>
> Fixes:
>     # cat unicode.cil
>     (filecon "/opt/=C5=BElu=C5=A5ou=C4=8Dk=C3=BD(/.*)?" any (system_u obj=
ect_r user_home_t ((s0) (s0))))
>
>     # semodule -i unicode.cil
>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_c=
ontexts:  line 2145 error due to: Non-ASCII characters found
>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_c=
ontexts:  line 2145 error due to: Non-ASCII characters found
>     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Invalid=
 argument
>     libsemanage.semanage_validate_and_compile_fcontexts: setfiles returne=
d error code 1.
>     semodule:  Failed!
>
>     # semanage fcontext --add -t user_home_t "/opt/=C5=BElu=C5=A5ou=C4=8D=
k=C3=BD(/.*)?"
>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_c=
ontexts.local:  line 4 error due to: Non-ASCII characters found
>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_c=
ontexts.local:  line 4 error due to: Non-ASCII characters found
>     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Invalid=
 argument
>     libsemanage.semanage_validate_and_compile_fcontexts: setfiles returne=
d error code 1.
>     OSError: Error
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
